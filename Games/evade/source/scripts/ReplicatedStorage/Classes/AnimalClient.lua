local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _RunService = game:GetService("RunService");
local _TweenService = game:GetService("TweenService");
local l_HttpService_0 = game:GetService("HttpService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v5 = require(l_Packages_0.Trove);
local v6 = require(l_Packages_0.Gradients); 
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v8 = require(l_Datas_0.Animals);
local v10 = require(l_Datas_0.Rarities);
local v11 = require(l_Datas_0.Mutations);
local v12 = require(l_Datas_0.Traits);
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v15 = require(l_Shared_0.Animals);
local l_Animals_0 = l_ReplicatedStorage_0:WaitForChild("Models").Animals;
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v19 = require(l_Utils_0.NumberUtils);
local v20 = require(l_Utils_0.TimeUtils);
local l_Animations_1 = l_ReplicatedStorage_0:WaitForChild("Animations").Animals;
local l_RenderedMovingAnimals_0 = workspace:WaitForChild("RenderedMovingAnimals");
local FastOverheadController = require(l_ReplicatedStorage_0:WaitForChild("Controllers"):WaitForChild("FastOverheadController"))

local v23 = {};
v23.__index = v23;

function v23:GetUID()
	return self.UID;
end;

v23.new = function(v30)
	local v31 = setmetatable({}, v23);
	v31.UID = v30.Name;
	v31.Collector = v5.new();
	v31.Instance = v30;
	v31.Index = v31.Instance:GetAttribute("Index");
	v31.Mutation = v31.Instance:GetAttribute("Mutation");

	local v32 = v8[v31.Index];
	if not v32 then
		warn("Failed to find animal data: " .. v31.Index);
	end;

	local v33 = v10[v32.Rarity];
	v31.AnimalModel = l_Animals_0:FindFirstChild(v31.Index):Clone();
	local l_ExtentsSize_0 = v31.AnimalModel:GetExtentsSize();

	for _, v36 in v31.AnimalModel:GetDescendants() do
		if v36:IsA("BasePart") then
			v36.CanCollide = false; v36.CanQuery = false; v36.CanTouch = false;
			v36.Massless = true; v36.Anchored = false;
		end;
	end;

	v31.Collector:Add(v31.AnimalModel);
	if v31.AnimalModel.PrimaryPart then
		v31.AnimalModel.PrimaryPart.Anchored = true;
	end;

	v31.AnimalModel:AddTag("RenderedMovingAnimal");
	v31.AnimalModel.Parent = l_RenderedMovingAnimals_0;

	if v31.Mutation then
		v31.Collector:Add(v15:ApplyMutation(v31.AnimalModel, v31.Index, v31.Mutation));
	end;

	local noOverhead = v31.Instance:GetAttribute("NoOverhead")
	if not noOverhead then
		local l_FirstChild_0 = v31.AnimalModel:FindFirstChild("OVERHEAD_ATTACHMENT", true);
		if not l_FirstChild_0 then
			local l_Attachment_0 = Instance.new("Attachment");
			l_Attachment_0.Name = "OVERHEAD_ATTACHMENT";
			l_Attachment_0.CFrame = CFrame.new(0, l_ExtentsSize_0.Y * 0.75 * (v32.OverheadYOffsetModifier or 1), 0);
			l_Attachment_0.Parent = v31.AnimalModel.PrimaryPart;
			l_FirstChild_0 = l_Attachment_0;
		end;

		local overheadGui, cleanupOverhead = FastOverheadController.createFastOverhead({
			adornee = l_FirstChild_0,
			studsOffsetY = 0,
			animal = v31.AnimalModel
		})

		v31.Overhead = overheadGui;
		v31.Collector:Add(cleanupOverhead);
	else
		v31.Overhead = {
			Generation = { Visible = false, Text = "" },
			Traits = { Visible = false, Template = Instance.new("Frame") },
			DisplayName = { Text = "" },
			Price = { Text = "" },
			Rarity = { Text = "", TextColor3 = Color3.new() },
			Mutation = { Visible = false, Text = "" }
		}
	end;

	local function v38()
		local v37
		if v32.LuckyBlock then
			v37 = v32.LuckyBlock.Timer <= 0 and "READY!" or v20:E(v32.LuckyBlock.Timer)
		elseif v31.Index == "Coffin Tung Tung Tung Sahur" then
			v37 = ""
		else
			v37 = ("$%*/s"):format((v19:ToString(v15:GetGeneration(v31.Index, v31.Mutation, v31.Traits))))
		end
		if v31.Overhead.Generation then
			v31.Overhead.Generation.Text = v37
			v31.Overhead.Generation.Visible = v37 ~= ""
		end
	end

	local v39 = v31.Collector:Extend();
	local function v46()
		v39:Clean();
		local l_Attribute_0 = v31.Instance:GetAttribute("Traits");
		v31.Traits = if l_Attribute_0 then l_HttpService_0:JSONDecode(l_Attribute_0) else nil;
		if v31.Traits then
			local v41 = v15:ApplyTraits(v31.AnimalModel, v31.Index, v31.Traits);
			if v41 then v39:Add(v41); end;
			for _, v43 in v31.Traits do
				local v44 = v12[v43];
				if v44 and not noOverhead then
					local v45 = v31.Overhead.Traits.Template:Clone();
					v45.Image = v44.Icon;
					v45.Visible = true;
					v45.Parent = v31.Overhead.Traits;
					v39:Add(v45)
				end;
			end;
			if v31.Overhead.Traits then v31.Overhead.Traits.Visible = true; end
		else
			if v31.Overhead.Traits then v31.Overhead.Traits.Visible = false; end
		end;
		v38();
	end;

	local v47 = v31.AnimalModel:FindFirstChildOfClass("AnimationController") or Instance.new("AnimationController", v31.AnimalModel);
	local v48 = v47:FindFirstChildOfClass("Animator") or Instance.new("Animator", v47);
	local l_l_Animations_1_FirstChild_0 = l_Animations_1:FindFirstChild(v31.Index);

	local v50 = l_l_Animations_1_FirstChild_0 and l_l_Animations_1_FirstChild_0:FindFirstChild("Walk");
	if v50 then
		v31.WalkTrack = v48:LoadAnimation(v50);
		v31.WalkTrack.Looped = true;
		v31.WalkTrack:Play();
		v31.WalkTrack:AdjustSpeed(v50:GetAttribute("Speed") or 1);
	end;

	local v51 = l_l_Animations_1_FirstChild_0 and l_l_Animations_1_FirstChild_0:FindFirstChild("Idle");
	if v51 then
		v31.IdleTrack = v48:LoadAnimation(v51);
		v31.IdleTrack.Looped = true;
	end;

	local function v52()
		if v31.Instance:GetAttribute("ForceIdle") and v31.IdleTrack then
			if v31.WalkTrack then v31.WalkTrack:Stop() end;
			v31.IdleTrack:Play();
		elseif v31.WalkTrack then
			v31.WalkTrack:Play();
			if v31.IdleTrack then v31.IdleTrack:Stop() end;
		end;
	end;

	v31.Collector:Add(v31.Instance:GetAttributeChangedSignal("ForceIdle"):Connect(v52));
	task.spawn(v52);

	v31.Overhead.DisplayName.Text = v32.DisplayName;
	v31.Overhead.Price.Text = ("$%*"):format((v19:ToString(v15:GetPrice(v31.Index))));
	v31.Overhead.Rarity.Text = v32.Rarity;
	v31.Overhead.Rarity.TextColor3 = v10[v32.Rarity].Color;

	v31.Overhead.Mutation.Visible = v31.Mutation ~= nil;
	if v31.Mutation and not noOverhead then
		local v53 = v11[v31.Mutation];
		v31.Overhead.Mutation.Text = v53.UseRichText and v53.DisplayWithRichText or v53.DisplayText;
		v31.Overhead.Mutation.RichText = v53.UseRichText;
		if v53.GradientPreset then
			v31.Overhead.Mutation.TextColor3 = Color3.new(1,1,1);
			v31.Collector:Add(v6.apply(v31.Overhead.Mutation, v53.GradientPreset));
		else
			v31.Overhead.Mutation.TextColor3 = v53.MainColor;
		end;
	end;

	if v33.GradientPreset and not noOverhead then
		v31.Collector:Add(v6.apply(v31.Overhead.Rarity, v33.GradientPreset));
	end;

	v31.AnimalModel:PivotTo(v31.Instance:GetPivot());
	local l_PrimaryPart_0 = v31.AnimalModel.PrimaryPart;
	if l_PrimaryPart_0 then
		l_PrimaryPart_0.RootPriority = 100;
		local v57 = Instance.new("WeldConstraint");
		v57.Part0 = l_PrimaryPart_0;
		v57.Part1 = v31.Instance.PrimaryPart;
		v57.Parent = l_PrimaryPart_0;
		v31.Collector:Add(v57);
		l_PrimaryPart_0.Anchored = false;
	end;

	v31.Collector:Add(v31.Instance:GetAttributeChangedSignal("Traits"):Connect(v46));
	task.spawn(v46);

	return v31;
end;

v23.Destroy = function(v58)
	v58.Collector:Destroy();
end;

return v23;