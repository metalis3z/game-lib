-- Decompiled with the Synapse X Luau decompiler.

return {
	["9"] = {
		displayName = "Double Shot", 
		description = "Built to fire two bullets at once from the barrel, for some reason.", 
		thumbnail = "rbxassetid://4352541297", 
		quality = false, 
		premium = false, 
		offsale = true, 
		disabled = true, 
		isLimited = false, 
		customDisplay = "", 
		price = 1900, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 300, 
		automatic = false, 
		shotrate = 0.125, 
		zoomAmount = 1, 
		additionalSpeed = 1.5, 
		doubleShot = true, 
		disableRagdoll = false, 
		offsets = {
			firstPerson = {
				idle = CFrame.new(0.75, -0.75, -2), 
				left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
				right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
				fire = CFrame.new(0, 0, 0) * CFrame.Angles(0.2617993877991494, 0, 0), 
				sprint = CFrame.new(0.75, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}, 
			thirdPerson = {
				idle = CFrame.new(0.3, 0.5, -1.35), 
				left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
				right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
				fire = CFrame.new(0, 0, 0.2) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}
		}
	}
};
