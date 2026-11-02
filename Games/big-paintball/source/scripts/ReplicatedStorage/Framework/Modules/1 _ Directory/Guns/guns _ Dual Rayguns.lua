-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["32"] = {
		displayName = "Dual Rayguns", 
		description = "Found at a UFO crashsite! \240\159\155\184\240\159\145\189", 
		thumbnail = "rbxassetid://4439662814", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		shootSound = 4447086085, 
		price = 555555, 
		gamepassId = 0, 
		productId = 0, 
		damage = 100, 
		velocity = 275, 
		automatic = false, 
		shotrate = 0.12, 
		zoomAmount = 1, 
		additionalSpeed = 2, 
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
		}, 
		killEffect = function(p1)
			if p1 and p1.PrimaryPart then
				u1.Audio.Play(4447087364, p1.PrimaryPart.CFrame, 1, 0.75, 300);
				local v1 = Color3.fromHSV(math.random(), 1, 1);
				local v2, v3 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v4, v5 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Raygun KillFX"):GetChildren()) do
					local v7 = v5:Clone();
					v7.Color = ColorSequence.new(v1);
					v7.Parent = v3;
					v7:Emit(15);				
				end;
				v2.Parent = p1;
				for v8, v9 in pairs(p1:GetDescendants()) do
					if v9:IsA("BasePart") and v9.Transparency == 0 then
						if v9.ClassName == "MeshPart" then
							v9.TextureID = "";
						end;
						if v9 == p1.UpperTorso then
							v9.Anchored = true;
						end;
						v9.Material = Enum.Material.Neon;
						v9.Color = v1;
						u1.Functions.FastTween(v9, {
							CFrame = v9.CFrame + Vector3.new(0, 6, 0), 
							Transparency = 1
						});
					elseif v9.ClassName == "SpecialMesh" then
						v9.TextureId = "";
					elseif v9.ClassName == "Shirt" or v9.ClassName == "Pants" or v9.lassName == "ShirtGraphic" or v9.ClassName == "Decal" or v9.ClassName == "Texture" then
						v9:Destroy();
					end;				
				end;
			end;
		end
	}
};
