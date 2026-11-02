-- Decompiled with the Synapse X Luau decompiler.

return {
	["80"] = {
		displayName = "Summer Minigun", 
		description = "\"The ocean waves cant keep up with this hotrod of a gun\"", 
		thumbnail = "rbxassetid://9774652357", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = true, 
		customDisplay = "", 
		price = 899999, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 150, 
		automatic = true, 
		shotrate = 0.075, 
		zoomAmount = 1, 
		additionalSpeed = -2.5, 
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
				fire = CFrame.new(0, 0, 0.2) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}
		}
	}
};
