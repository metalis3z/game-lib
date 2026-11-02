-- Decompiled with the Synapse X Luau decompiler.

return {
	["23"] = {
		displayName = "Dual Pistols", 
		description = "Two is better than one!", 
		thumbnail = "rbxassetid://4352525889", 
		quality = false, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 100000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 205, 
		automatic = false, 
		shotrate = 0.135, 
		zoomAmount = 1, 
		additionalSpeed = 5, 
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
	}
};
