-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Gem Stone Scar", 
	description = "Masterfully crafted and enchanted with quartz crystals! \240\159\148\174\240\159\146\142", 
	thumbnail = "rbxassetid://6721352590", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 850000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 265, 
	automatic = true, 
	shotrate = 0.145, 
	zoomAmount = 1, 
	additionalSpeed = 0, 
	disableRagdoll = false, 
	offsets = {
		firstPerson = {
			idle = CFrame.new(0.75, -0.75, -2), 
			left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
			right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
			fire = CFrame.new(0, 0, 0.35) * CFrame.Angles(0.05235987755982989, 0, 0), 
			sprint = CFrame.new(0.75, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}, 
		thirdPerson = {
			idle = CFrame.new(0.3, 0.5, -1.35), 
			left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
			right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
			fire = CFrame.new(0, 0, 0.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
			sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}
	}
};
local u2 = Random.new();
function v2.killEffect(p1)
	if p1 and p1.PrimaryPart then
		u1.Audio.Play("rbxassetid://6814526663", p1.UpperTorso, 1, 0.75, 300);
		local v3 = u1.Assets.QuartzCrystals:GetChildren();
		local l__UpperTorso__4 = p1:FindFirstChild("UpperTorso");
		for v5, v6 in pairs(p1:GetDescendants()) do
			if v6:IsA("BasePart") and v6.Transparency == 0 and v6.Name ~= "_crystal" and u2:NextInteger(1, 2) == 1 then
				local v7 = v3[u2:NextInteger(1, 2)]:Clone();
				v7.CanCollide = false;
				v7.Size = v7.Size / u2:NextNumber(0.8, 1.5);
				v7.CFrame = v6.CFrame * CFrame.Angles(u2:NextNumber(), u2:NextNumber(), u2:NextNumber());
				v7.Name = "_crystal";
				v7.Parent = p1;
				u1.Functions.Weld(v7, v6);
			end;
		end;
		local v8 = p1:GetPrimaryPartCFrame();
		for v9 = 1, u2:NextInteger(5, 10) do
			local v10 = v3[u2:NextInteger(1, 2)]:Clone();
			u1.PhysicsService:SetPartCollisionGroup(v10, "Present");
			v10.Size = v10.Size / u2:NextNumber(1.8, 3.5);
			v10.CFrame = v8;
			v10.Velocity = Vector3.new(u2:NextNumber(-8, 8), u2:NextNumber(-8, 8), u2:NextNumber(-8, 8));
			v10.RotVelocity = Vector3.new(u2:NextNumber(-180, 180), u2:NextNumber(-180, 180), u2:NextNumber(-180, 180));
			v10.Parent = game.Workspace.__DEBRIS;
			u1.Functions.AddDebris(v10, u2:NextNumber(1.5, 2.5));
		end;
		local v11, v12 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
		for v13, v14 in ipairs(u1.Assets.Particles:WaitForChild("Quartz KillFX"):GetChildren()) do
			local v16 = v14:Clone();
			v16.Parent = v12;
			v16:Emit(v16.Rate);		
		end;
		v11.Parent = p1;
	end;
end;
v1["56"] = v2;
return v1;
