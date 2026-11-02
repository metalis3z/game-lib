-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["37"] = {
		displayName = "Party Gun", 
		description = "Turn your enemies into party animals!", 
		thumbnail = "rbxassetid://4506905661", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 370000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 325, 
		automatic = false, 
		shotrate = 0.12, 
		zoomAmount = 1, 
		additionalSpeed = 0, 
		disableRagdoll = false, 
		offsets = {
			firstPerson = {
				idle = CFrame.new(0.75, -0.75, -2), 
				left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
				right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
				fire = CFrame.new(0, 0, 0) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.75, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}, 
			thirdPerson = {
				idle = CFrame.new(0.3, 0.5, -1.35), 
				left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
				right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
				fire = CFrame.new(0, 0, 0.2) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}
		}, 
		killEffect = function(p1)
			if p1 and p1:FindFirstChild("UpperTorso") and p1:FindFirstChild("Head") then
				u1.Audio.Play(4507125638, p1.Head, 1, 0.75, 275);
				p1.UpperTorso.Velocity = Vector3.new(math.random(-50, 50), 250, math.random(-50, 50));
				local v1, v2 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v3, v4 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Party KillFX"):GetChildren()) do
					local v6 = v4:Clone();
					v6.Parent = v2;
					v6:Emit(5);				
				end;
				v1.Parent = p1;
			end;
		end
	}
};
