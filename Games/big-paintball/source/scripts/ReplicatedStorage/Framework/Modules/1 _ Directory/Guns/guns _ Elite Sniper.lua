-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["11"] = {
		displayName = "Elite Sniper", 
		description = "Only for the elite. Extremely powerful in the right hands. \240\159\146\128", 
		thumbnail = "rbxassetid://4352532732", 
		quality = true, 
		premium = true, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 2250000, 
		gamepassId = 7238476, 
		productId = 0, 
		damage = 100, 
		velocity = 1000, 
		automatic = false, 
		shotrate = 0.625, 
		zoomAmount = 2, 
		additionalSpeed = -1, 
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
				fire = CFrame.Angles(0.3490658503988659, 0, 0) * CFrame.new(0, 0, 0.4), 
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
