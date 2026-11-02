-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Winter Shattered Sniper", 
	description = "Awarded to those who completed the 2022 Winter Event!", 
	thumbnail = "http://www.roblox.com/asset/?id=11855266199", 
	quality = true, 
	premium = false, 
	offsale = true, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "", 
	price = 0, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 850, 
	automatic = false, 
	shotrate = 0.6, 
	zoomAmount = 2, 
	additionalSpeed = -1, 
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
			idle = CFrame.new(0.3, 0.5, -2), 
			left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
			right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
			fire = CFrame.Angles(0.3490658503988659, 0, 0) * CFrame.new(0, 0, 0.4), 
			sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}
	}
};
local u2 = Random.new();
function v2.killEffect(p1)
	if p1 and p1.PrimaryPart then
		local v3, v4 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
		local l__Shattered_Winter_KillFX__5 = game.ReplicatedStorage.Assets.Particles:FindFirstChild("Shattered Winter KillFX");
		local v6 = l__Shattered_Winter_KillFX__5.Impact:Clone();
		v6.Parent = v4;
		v6:Emit(14);
		u1.Audio.Play(8235398914, v3, 1, 0.5, 300);
		local v7 = game.ReplicatedStorage.Assets.Presents:GetChildren();
		for v8 = 1, u2:NextInteger(6, 14) do
			local v9 = Instance.new("Part");
			v9.Size = Vector3.new(0.4, 0.4, 0.4);
			v9.Transparency = 1;
			local v10 = l__Shattered_Winter_KillFX__5.Debris:Clone();
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
v1["91"] = v2;
return v1;
