-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["33"] = {
		displayName = "Skeleton Gun", 
		description = "Spooky scary skeletons \240\159\142\181", 
		thumbnail = "rbxassetid://4463016791", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 233333, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 230, 
		automatic = false, 
		shotrate = 0.09, 
		zoomAmount = 1, 
		additionalSpeed = 3.5, 
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
			if p1 and p1:FindFirstChild("Humanoid") then
				u1.Audio.Play(4477057099, p1.PrimaryPart.Position, 1, 1, 300);
				for v1, v2 in pairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("SkeletonPackage"):GetChildren()) do
					if p1:FindFirstChild(v2.Name) then
						local v3 = v2:Clone();
						v3.CFrame = p1:FindFirstChild(v2.Name).CFrame;
						v3.Size = v3.Size * 2;
						v3.Parent = game.Workspace.__DEBRIS;
						v3.RotVelocity = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180));
						u1.PhysicsService:SetPartCollisionGroup(v3, "Ragdolls");
						coroutine.wrap(function()
							wait(3);
							v3:Destroy();
						end)();
					end;
				end;
				coroutine.wrap(function()
					wait();
					p1:Destroy();
				end)();
			end;
		end
	}
};
