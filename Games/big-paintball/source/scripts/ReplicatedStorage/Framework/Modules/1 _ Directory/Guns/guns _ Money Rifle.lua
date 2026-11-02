-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = Random.new();
return {
	["72"] = {
		displayName = "Money Rifle", 
		description = "It's raining money, rapidly!", 
		thumbnail = "rbxassetid://6775457091", 
		quality = true, 
		premium = true, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		gamepassId = 22632240, 
		productId = 0, 
		damage = 100, 
		velocity = 270, 
		automatic = true, 
		shotrate = 0.095, 
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
		}, 
		killEffect = function(p1)
			if p1 and p1:FindFirstChild("UpperTorso") then
				u1.Audio.Play(4598002166, p1.UpperTorso.Position, 1, 0.65, 300);
				local v2, v3 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v4, v5 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Money Gun KillFX"):GetChildren()) do
					local v7 = v5:Clone();
					v7.Parent = v3;
					v7:Emit(24);				
				end;
				v2.Parent = p1;
			end;
		end
	}
};
