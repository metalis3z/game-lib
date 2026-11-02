-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["44"] = {
		displayName = "Fart Gun", 
		description = "Uh oh, stinky!", 
		thumbnail = "rbxassetid://4595355731", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 425000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 275, 
		automatic = false, 
		shotrate = 0.13, 
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
			if p1 and p1:FindFirstChild("UpperTorso") then
				local v1 = math.random(1, 5) == 1;
				local v2
				if v1 then
					v2 = 4625459010;
				else
					v2 = 4598001962;
				end;
				u1.Audio.Play(v2, p1.UpperTorso.Position, math.random(95, 105) / 100, 0.7, 300);
				local v3, v4 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v5, v6 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Fart KillFX"):GetChildren()) do
					local v9
					if v1 then
						v9 = 18;
					else
						v9 = 7;
					end;
					v6:Emit(v9);				
				end;
				v3.Parent = p1;
			end;
		end
	}
};
