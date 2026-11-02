-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Steampunk Gun", 
	description = "Tick tock, tick tock, tick tock, tick tock.", 
	thumbnail = "rbxassetid://6721353214", 
	quality = false, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 185000, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 205, 
	automatic = false, 
	shotrate = 0.0875, 
	zoomAmount = 1, 
	additionalSpeed = 1, 
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
		u1.Audio.Play("rbxassetid://6819240686", p1.UpperTorso, u2:NextNumber(0.95, 1.15), 1, 300);
		u1.Audio.Play("rbxassetid://6819240728", p1.UpperTorso, u2:NextNumber(0.95, 1.05), 0.5, 275);
		p1.UpperTorso.Velocity = Vector3.new(math.random(-20, 20), 250, math.random(-20, 20));
		local v3, v4 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame - Vector3.new(0, 4, 0));
		for v5, v6 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Steampunk KillFX"):GetChildren()) do
			local v8 = v6:Clone();
			v8.Parent = v4;
			v8:Emit(6);		
		end;
		v3.Parent = p1;
	end;
end;
v1["60"] = v2;
return v1;
