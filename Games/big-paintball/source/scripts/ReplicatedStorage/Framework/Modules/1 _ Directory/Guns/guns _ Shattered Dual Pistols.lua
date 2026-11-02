-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Shattered Dual Pistols", 
	description = "Fizzle your enemies away! \240\159\146\128", 
	thumbnail = "rbxassetid://5580789819", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "", 
	price = 350000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 275, 
	automatic = false, 
	shotrate = 0.12, 
	zoomAmount = 1, 
	additionalSpeed = 2, 
	doubleShot = true, 
	disableRagdoll = false, 
	offsets = {
		firstPerson = {
			idle = CFrame.new(0, -0.95, -2), 
			left = CFrame.new(0, -0.95, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
			right = CFrame.new(0, -0.95, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
			fire = CFrame.new(0, 0, 0) * CFrame.Angles(0.08726646259971647, 0, 0), 
			sprint = CFrame.new(0, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}, 
		thirdPerson = {
			idle = CFrame.new(0, 0.35, -2), 
			left = CFrame.new(0, 0.35, -2) * CFrame.Angles(0.08726646259971647, 0, 0), 
			right = CFrame.new(0, 0.35, -2) * CFrame.Angles(-0.08726646259971647, 0, 0), 
			fire = CFrame.new(0, 0, 0.2) * CFrame.Angles(0.08726646259971647, 0, 0), 
			sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}
	}
};
local u2 = Random.new();
function v2.killEffect(p1)
	if p1 and p1.PrimaryPart then
		local v3, v4 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
		local l__Shattered_KillFX__5 = game.ReplicatedStorage.Assets.Particles:FindFirstChild("Shattered KillFX");
		local v6 = l__Shattered_KillFX__5.Impact:Clone();
		v6.Parent = v4;
		v6:Emit(8);
		u1.Audio.Play(5726333064, v3, 1, 0.5, 300);
		local v7 = game.ReplicatedStorage.Assets.Presents:GetChildren();
		for v8 = 1, u2:NextInteger(6, 14) do
			local v9 = Instance.new("Part");
			v9.Size = Vector3.new(0.4, 0.4, 0.4);
			v9.Transparency = 1;
			local v10 = l__Shattered_KillFX__5.Debris:Clone();
			v10.Parent = v9;
			u1.PhysicsService:SetPartCollisionGroup(v9, "Present");
			v9.CFrame = p1:GetPrimaryPartCFrame();
			v9.Velocity = Vector3.new(u2:NextNumber(-6, 6), u2:NextNumber(-8, 8), u2:NextNumber(-6, 6));
			v9.RotVelocity = Vector3.new(u2:NextNumber(-130, 130), u2:NextNumber(-130, 130), u2:NextNumber(-130, 130));
			v9.Parent = game.Workspace.__DEBRIS;
			v10:Emit(1);
			u1.Functions.AddDebris(v9, 6);
		end;
		u1.Functions.AddDebris(v3, 5);
		coroutine.wrap(function()
			wait();
			p1:Destroy();
		end)();
	end;
end;
v1["53"] = v2;
return v1;
