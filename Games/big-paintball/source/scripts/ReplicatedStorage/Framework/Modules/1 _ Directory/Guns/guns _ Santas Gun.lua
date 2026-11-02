-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Santas Gun", 
	description = "Stolen from Santa's workshop. Harness the power of CHRISTMAS! \240\159\142\133\240\159\142\129", 
	thumbnail = "rbxassetid://4525212686", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = true, 
	customDisplay = "", 
	price = 25000000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 300, 
	automatic = true, 
	shotrate = 0.06, 
	zoomAmount = 1, 
	additionalSpeed = 2.5, 
	disableRagdoll = false, 
	animatedTexture = true, 
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
		local v3, v4 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
		for v5, v6 in ipairs((game.ReplicatedStorage.Assets.Particles:FindFirstChild("Santas Gun KillFX"):GetChildren())) do
			local v8 = v6:Clone();
			v8.Parent = v4;
			v8:Emit(5);		
		end;
		u1.Audio.Play(4537511041, v3, 1, 0.5, 300);
		local v9 = game.ReplicatedStorage.Assets.Presents:GetChildren();
		for v10 = 1, u2:NextInteger(3, 5) do
			local v11 = v9[u2:NextInteger(1, 2)]:Clone();
			u1.PhysicsService:SetPartCollisionGroup(v11, "Present");
			v11.CFrame = p1:GetPrimaryPartCFrame();
			v11.Velocity = Vector3.new(u2:NextNumber(-10, 10), u2:NextNumber(-10, 10), u2:NextNumber(-10, 10));
			v11.RotVelocity = Vector3.new(u2:NextNumber(-180, 180), u2:NextNumber(-180, 180), u2:NextNumber(-180, 180));
			v11.Parent = game.Workspace.__DEBRIS;
			u1.Functions.AddDebris(v11, 2);
		end;
		u1.Functions.AddDebris(v3, 5);
	end;
end;
v1["42"] = v2;
return v1;
