-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["30"] = {
		displayName = "Dark Matter Gun", 
		description = "%%random", 
		thumbnail = "rbxassetid://4405108810", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		locked = true;
		customDisplay = "DarkMatter", 
		shootSound = 4405651154, 
		deploySound = 4405650671, 
		price = 99999999, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 450, 
		automatic = true, 
		shotrate = 0.0135, 
		zoomAmount = 1.75, 
		additionalSpeed = 5, 
		disableRagdoll = true, 
		animatedTexture = true, 
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
				fire = CFrame.new(0, 0, 0.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}
		}, 
		killEffect = function(p1)
			if p1 and p1.PrimaryPart then
				u1.Audio.Play(4405964749, p1.PrimaryPart.CFrame, 1, 0.35, 350);
				local l__Magnitude__1 = (u1.Player.Get("Camera").CFrame.p - p1.PrimaryPart.CFrame.p).Magnitude;
				if l__Magnitude__1 <= 75 then
					u1.Shake.Create(1, 0.75 - l__Magnitude__1 / 75 * 0.75, 0.2);
				end;
				local v2, v3 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v4, v5 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Dark Matter KillFX"):GetChildren()) do
					local v7 = v5:Clone();
					v7.Parent = v3;
					v7:Emit(30);				
				end;
				v2.Parent = p1;
				for v8, v9 in pairs(p1:GetDescendants()) do
					if v9:IsA("BasePart") then
						v9.Anchored = true;
						u1.Functions.FastTween(v9, {
							Color = Color3.new(0, 0, 0), 
							Size = v9.Size / 10, 
							CFrame = p1.PrimaryPart.CFrame
						}, { 1, Enum.EasingStyle.Back, Enum.EasingDirection.In }).Completed:Connect(function()
							if v9 and v9.Parent then
								v9:Destroy();
							end;
						end);
					end;
				end;
			end;
		end
	}
};
