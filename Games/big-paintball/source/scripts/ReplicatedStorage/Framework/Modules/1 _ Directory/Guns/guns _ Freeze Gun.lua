-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["20"] = {
		displayName = "Freeze Gun", 
		description = "Freeze your enemies! Brrrr.... \226\157\132\239\184\143", 
		thumbnail = "rbxassetid://4352529150", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 255555, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 300, 
		automatic = false, 
		shotrate = 0.135, 
		zoomAmount = 1, 
		additionalSpeed = 0, 
		disableRagdoll = false, 
		offsets = {
			firstPerson = {
				idle = CFrame.new(0.75, -0.75, -2), 
				left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
				right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
				fire = CFrame.new(0, 0, 0.15) * CFrame.Angles(0.08726646259971647, 0, 0), 
				sprint = CFrame.new(0.75, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}, 
			thirdPerson = {
				idle = CFrame.new(0.3, 0.5, -1.35), 
				left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
				right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
				fire = CFrame.Angles(0.08726646259971647, 0, 0) * CFrame.new(0, 0, 0.2), 
				sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
			}
		}, 
		killEffect = function(p1)
			if p1 and p1.PrimaryPart then
				u1.Audio.Play(4102526909, p1.UpperTorso, 1, 0.75, 300);
				local v1, v2 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v3, v4 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Freeze KillFX"):GetChildren()) do
					local v6 = v4:Clone();
					v6.Parent = v2;
					v6:Emit(8);				
				end;
				v1.Parent = p1;
				for v7, v8 in pairs(p1:GetDescendants()) do
					if v8:IsA("BasePart") and v8.Transparency == 0 then
						if v8.ClassName == "MeshPart" then
							v8.TextureID = "";
						end;
						u1.Functions.FastTween(v8, {
							Color = BrickColor.new("Light blue").Color
						}, { 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out });
					elseif v8.ClassName == "SpecialMesh" then
						v8.TextureId = "";
					elseif v8.ClassName == "Shirt" or v8.ClassName == "Pants" or v8.ClassName == "ShirtGraphic" or v8.ClassName == "Decal" or v8.ClassName == "Texture" then
						v8:Destroy();
					end;
				end;
				coroutine.wrap(function()
					u1.Functions.Wait(0.15);
					for v9, v10 in pairs(p1:GetDescendants()) do
						if v10:IsA("BasePart") then
							local v11 = Instance.new("BodyGyro");
							v11.MaxTorque = Vector3.new(math.huge, math.huge, math.huge);
							v11.CFrame = v10.CFrame;
							v11.Parent = v10;
						end;
					end;
				end)();
			end;
		end
	}
};
