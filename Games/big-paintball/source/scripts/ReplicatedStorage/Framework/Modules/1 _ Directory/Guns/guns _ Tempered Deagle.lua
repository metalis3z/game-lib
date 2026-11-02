-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["13"] = {
		displayName = "Tempered Deagle", 
		description = "Stylish hand cannon! \240\159\152\142\226\156\168", 
		thumbnail = "rbxassetid://4352531617", 
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
		velocity = 305, 
		automatic = false, 
		shotrate = 0.17, 
		zoomAmount = 1, 
		additionalSpeed = 4, 
		disableRagdoll = false, 
		offsets = {
			firstPerson = {
				idle = CFrame.new(0.75, -0.75, -2), 
				left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
				right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
				fire = CFrame.new(0, 0, 0.1) * CFrame.Angles(0.08726646259971647, 0, 0), 
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
			if p1 and p1.PrimaryPart then
				local v1, v2 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
				for v3, v4 in ipairs((game.ReplicatedStorage.Assets.Particles:FindFirstChild("Tempered KillFX"):GetChildren())) do
					local v6 = v4:Clone();
					v6.Parent = v2;
					v6:Emit(5);				
				end;
				u1.Audio.Play(4102525478, v1, 1, 0.65, 300);
				u1.Functions.AddDebris(v1, 5);
			end;
		end
	}
};
