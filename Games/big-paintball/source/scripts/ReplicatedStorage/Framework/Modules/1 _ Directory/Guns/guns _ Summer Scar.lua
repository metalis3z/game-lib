-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["78"] = {
		displayName = "Summer Scar", 
		description = "You may want to put on some sunscreen.", 
		thumbnail = "rbxassetid://9705923166", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = true, 
		customDisplay = "", 
		price = 825000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 270, 
		automatic = true, 
		shotrate = 0.145, 
		zoomAmount = 1, 
		additionalSpeed = 2, 
		disableRagdoll = false, 
		offsets = {
			firstPerson = {
				idle = CFrame.new(0.75, -0.8, -1.75), 
				left = CFrame.new(0.75, -0.8, -1.75) * CFrame.Angles(0, 0, 0.08726646259971647), 
				right = CFrame.new(0.75, -0.8, -1.75) * CFrame.Angles(0, 0, -0.08726646259971647), 
				fire = CFrame.new(0, 0, 0.45) * CFrame.Angles(0.03490658503988659, 0, 0), 
				sprint = CFrame.new(0.75, -1.2, -1.75) * CFrame.Angles(-0.2617993877991494, 0, 0)
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
			if p1 then
				local l__Head__1 = p1:WaitForChild("Head");
				u1.Audio.Play(4301788747, l__Head__1, math.random(95, 105) / 100, 1, 300);
				l__Head__1:WaitForChild("BallSocketConstraint"):Destroy();
				l__Head__1.Velocity = Vector3.new(math.random(-15, 15), 50, math.random(-15, 15));
			end;
		end
	}
};
