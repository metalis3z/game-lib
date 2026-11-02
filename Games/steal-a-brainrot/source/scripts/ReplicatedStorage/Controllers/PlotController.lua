local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local _ = require(l_Controllers_0.CharacterController);
local v5 = require(l_Controllers_0.SoundController);
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v7 = require(l_Packages_0.Observers);
local v8 = require(l_Packages_0.Trove);
local v9 = require(l_Packages_0.Net);
local _ = require(l_ReplicatedStorage_0.Shared.Updates);
local v11 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v13 = require(l_Datas_0.Animals);
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local v15 = require(l_Classes_0.PlotClient);
local l_Animals_0 = l_ReplicatedStorage_0:WaitForChild("Animations").Animals;
local v17 = require(l_ReplicatedStorage_0.Shared.Animals);
local v18 = require(l_ReplicatedStorage_0.Controllers.AnimationSyncController);
local v19 = v9:RemoteEvent("PlotService/Open");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v21 = nil;
local v22 = {};

return {
	GetMyPlot = function(_)
		return v21;
	end,
	Start = function(_)
		v19.OnClientEvent:Connect(function(v27, v28, v29, v30, v31, v32)
			local v33 = v22[v27];
			if not v33 then return end;

			local v34 = v13[v29];

			if v29 ~= "Coffin Tung Tung Tung Sahur" then
				if not v34 or not v34.LuckyBlock then
					return
				end
			end

			local podium = v33.PlotModel.AnimalPodiums:FindFirstChild(v28);
			if not podium then return end;

			while podium:GetAttribute("DeferDisplay") and podium:IsDescendantOf(workspace) do
				task.wait(0.1);
			end;
			if not podium:IsDescendantOf(workspace) then return end;

			podium:SetAttribute("DeferDisplay", v30);
			task.spawn(v33.UpdateAnimalPodiums, v33);

			local spawnPart = podium.Base.Spawn;
			local trove = v8.new();

			if v29 == "Coffin Tung Tung Tung Sahur" then
				local model = l_ReplicatedStorage_0.Models.Animals:FindFirstChild(v29)
				if not model then return end

				local clone = trove:Clone(model)

				for _, part in clone:GetChildren() do
					if part:IsA("MeshPart") and string.find(part.Name, "Plane.003_col", 1, true) then
						part.Transparency = 1
					end
				end

				clone.PrimaryPart.Anchored = true
				clone.Parent = workspace.CurrentCamera
				clone:PivotTo(spawnPart:GetPivot())

				if v31 then trove:Add(v17:ApplyMutation(clone, v29, v31)) end
				if v32 then trove:Add(v17:ApplyTraits(clone, v29, v32)) end

				for _, d in clone:GetDescendants() do
					if d:IsA("Trail") then
						d:Destroy()
					end
				end

				local ac = clone:FindFirstChildOfClass("AnimationController")
					or trove:Add(Instance.new("AnimationController", clone))
				local animator = ac:FindFirstChildOfClass("Animator")
					or trove:Add(Instance.new("Animator", ac))

				local anim = animator:LoadAnimation(
					l_ReplicatedStorage_0.Controllers
						.CoffinDanceTungTungTungSahurController.Unbox
				)
				anim.Looped = false
				anim:Play(0)

				v5:PlaySound(
					"Sounds.Sfx.Tung Tung Coffin",
					spawnPart.Position + Vector3.new(0, 3, 0),
					false
				)

				local finished = false
				local thread = coroutine.running()

				local function done()
					finished = true
					if coroutine.status(thread) == "suspended" then
						task.spawn(thread)
					end
				end

				anim.Stopped:Once(done)
				local timeout = task.delay(15, done)
				if not finished then coroutine.yield() end
				pcall(task.cancel, timeout)

				local smoke = v11.copy(
					v11.Library.Misc.Smoke,
					spawnPart.CFrame + Vector3.new(0, 3, 0)
				)
				v11.rescale(smoke, 3)
				v11.emit(smoke)
				task.delay(5, function()
					smoke:Destroy()
				end)

				v5:PlaySound(
					"Sounds.Sfx.Lucky Blocks.SpinEnd",
					spawnPart.Position + Vector3.new(0, 3, 0),
					false
				)

				trove:Clean()
				podium:SetAttribute("DeferDisplay", nil)
				v33:UpdateAnimalPodiums()
				return
			end
			v5:PlaySound("Sounds.Sfx.Lucky Blocks.SpinStart", spawnPart.CFrame.Position + Vector3.new(0, 3, 0));
			local effect = trove:Add(v11.copy(v11.Library.Misc.LuckyBlockUnbox, spawnPart.CFrame + Vector3.new(0, 3, 0)));
			v11.emit(effect);

			local animals = v34.LuckyBlock.Animals;
			local clones = {};
			local selectedIndex = 0;

			for _, animal in animals do
				if not animal.IsEnabled or animal.IsEnabled() then
					local name = animal.Name;
					local animalModel = l_ReplicatedStorage_0.Models.Animals:FindFirstChild(name);
					if animalModel then
						local clone = trove:Clone(animalModel);
						clone.PrimaryPart.Anchored = true;
						clone.Parent = workspace.CurrentCamera;

						for _, part in clone:GetDescendants() do
							if part:IsA("ParticleEmitter") then part:Destroy(); end;
						end;
						if v31 then trove:Add(v17:ApplyMutation(clone, name, v31)); end;
						if v32 then trove:Add(v17:ApplyTraits(clone, name, v32)); end;
						for _, trail in clone:GetDescendants() do
							if trail:IsA("Trail") then trail:Destroy(); end;
						end;

						local ac = clone:FindFirstChildOfClass("AnimationController") or trove:Add(Instance.new("AnimationController", clone));
						local animator = ac:FindFirstChildOfClass("Animator") or trove:Add(Instance.new("Animator", ac));
						local idleAnim = l_Animals_0:FindFirstChild(name) and l_Animals_0[name]:FindFirstChild("Idle");

						if idleAnim and animator then
							local anim = animator:LoadAnimation(idleAnim);
							anim.Looped = true;
							anim:Play();
							local stop = v18:Add(anim);
							trove:Add(function()
								stop();
								anim:Stop(0);
								anim:Destroy();
							end);
						end;

						table.insert(clones, clone);
						if name == v30 then selectedIndex = #clones; end;
					end;
				end;
			end;

			local value = trove:Add(Instance.new("NumberValue"));
			value.Value = 0;
			trove:Add(value.Changed:Connect(function(newVal)
				local pivot = spawnPart:GetPivot();
				for i, model in clones do
					local s = math.sin(math.clamp((newVal - (i - 1)) % #clones * 0.5, 0, 1) * math.pi);
					local defaultScale = model:GetAttribute("DefaultScale");
					if not defaultScale then
						defaultScale = model:GetScale();
						model:SetAttribute("DefaultScale", defaultScale);
					end;
					model:PivotTo(pivot);
					model:ScaleTo(math.clamp(defaultScale * s * 1.01, 0.001, defaultScale));
				end;
			end));

			local finalValue = #clones * 12 + selectedIndex;
			local tween = trove:Add(l_TweenService_0:Create(value, TweenInfo.new(6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Value = finalValue }));
			tween:Play();
			task.wait(tween.TweenInfo.Time * 0.82);
			value.Value = finalValue;
			tween:Cancel();
			trove:Clean();

			v5:PlaySound("Sounds.Sfx.Lucky Blocks.SpinEnd", spawnPart.CFrame.Position + Vector3.new(0, 3, 0));
			podium:SetAttribute("DeferDisplay", nil);
			v33:UpdateAnimalPodiums();
		end);

		v7.observeTag("Plot", function(v66)
			local isBaseCheck = v66:GetAttribute("BaseCheckPreview") == true;
			local isAllowed = l_LocalPlayer_0.Name:lower() == "do_zynna" or l_LocalPlayer_0.Name:lower() == "badr_studio";
			if isBaseCheck and not isAllowed then
				local hiddenParts = {};
				local function hide(instance)
					if instance:IsA("BasePart") then
						hiddenParts[instance] = instance.LocalTransparencyModifier;
						instance.LocalTransparencyModifier = 1;
					end;
				end;
				for _, instance in ipairs(v66:GetDescendants()) do
					hide(instance);
				end;
				local connection = v66.DescendantAdded:Connect(hide);
				return function()
					connection:Disconnect();
					for instance, transparency in pairs(hiddenParts) do
						if instance and instance.Parent then
							instance.LocalTransparencyModifier = transparency;
						end;
					end;
				end;
			end;

			local trove = v8.new();
			trove:Add(task.spawn(function()
				while not v66:GetAttribute("Loaded") do task.wait(); end;
				local plot = v15.new(v66);
				local uid = plot:GetUID();
				v22[uid] = plot;
				if plot:GetOwner() == l_LocalPlayer_0 then v21 = plot; end;
				trove:Add(plot);
				trove:Add(function() v22[uid] = nil; end);
			end));
			return trove:WrapClean();
		end);
	end
};