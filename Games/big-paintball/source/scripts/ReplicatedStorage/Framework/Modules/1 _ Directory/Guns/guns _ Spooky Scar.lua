-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["90"] = {
		displayName = "Spooky Scar", 
		description = "Awarded to players that completed the 2022 Halloween Event! \240\159\142\131", 
		thumbnail = "rbxassetid://11363700568", 
		quality = true, 
		premium = false, 
		offsale = true, 
		disabled = false, 
		isLimited = true, 
		customDisplay = "", 
		price = 3750000, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 275, 
		automatic = true, 
		shotrate = 0.145, 
		zoomAmount = 1, 
		additionalSpeed = 1.5, 
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
			if p1 and p1.PrimaryPart then
				local v1 = Random.new();
				local v2, v3 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
				for v4, v5 in ipairs((game.ReplicatedStorage.Assets.Particles:FindFirstChild("Halloween KillFX"):GetChildren())) do
					local v7 = v5:Clone();
					v7.Parent = v3;
					v7:Emit(10);				
				end;
				u1.Audio.Play("rbxassetid://11364244559", v2, 1, 0.25, 300);
				for v8 = 1, v1:NextInteger(3, 5) do
					local v9 = game.ReplicatedStorage.Assets:WaitForChild("Pumpkin"):Clone();
					u1.PhysicsService:SetPartCollisionGroup(v9, "Present");
					v9.CFrame = p1:GetPrimaryPartCFrame();
					v9.Velocity = Vector3.new(v1:NextNumber(-10, 10), v1:NextNumber(-10, 10), v1:NextNumber(-10, 10));
					v9.RotVelocity = Vector3.new(v1:NextNumber(-180, 180), v1:NextNumber(-180, 180), v1:NextNumber(-180, 180));
					v9.Parent = game.Workspace.__DEBRIS;
					u1.Functions.AddDebris(v9, 2);
				end;
				u1.Functions.AddDebris(v2, 5);
			end;
		end
	}
};
