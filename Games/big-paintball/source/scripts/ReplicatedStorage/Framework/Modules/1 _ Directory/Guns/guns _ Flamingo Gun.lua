-- Decompiled with the Synapse X Luau decompiler.

return {
	["26"] = {
		displayName = "Flamingo Gun", 
		description = "Such a cool gun!", 
		thumbnail = "rbxassetid://4352525507", 
		quality = true, 
		premium = false, 
		offsale = true, 
		disabled = false, 
		isLimited = true, 
		customDisplay = "", 
		price = 425000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 235, 
		automatic = false, 
		shotrate = 0.1, 
		zoomAmount = 1, 
		additionalSpeed = 4, 
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
		}
	}
};
