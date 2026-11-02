-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["34"] = {
		displayName = "Balloon Gun", 
		description = "Send your opponents to the sky with balloons!", 
		thumbnail = "rbxassetid://4463016566", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 285000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 300, 
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
			if p1 and p1:FindFirstChild("UpperTorso") and p1:FindFirstChild("Head") then
				coroutine.wrap(function()
					wait(0.25);
					u1.Audio.Play(4477057697, p1.Head.Position, 1, 1, 300);
					local v1 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Balloon"):Clone();
					v1.CFrame = CFrame.new(p1.Head.CFrame.Position) * CFrame.new(0, 4, 0);
					v1.BrickColor = BrickColor.Random();
					v1.Parent = p1;
					local v2 = Instance.new("RopeConstraint");
					v2.Attachment0 = p1.Head:WaitForChild("HairAttachment");
					v2.Attachment1 = v1:WaitForChild("Attachment");
					v2.Length = 4;
					v2.Visible = true;
					v2.Parent = p1;
					u1.Functions.FastTween(v1, {
						CFrame = v1.CFrame * CFrame.new(0, 100, 0)
					}, { 1.75, "Quad", "In" });
					wait(1.75);
					if p1 and p1:FindFirstChild("Head") then
						u1.Audio.Play(4477057942, p1.Head.Position, 1, 1, 275);
					end;
					v1:Destroy();
					v2:Destroy();
					if p1 and p1:FindFirstChild("UpperTorso") then
						p1.UpperTorso.Velocity = Vector3.new(math.random(-100, 100), 500, math.random(-100, 100));
					end;
				end)();
			end;
		end
	}
};
