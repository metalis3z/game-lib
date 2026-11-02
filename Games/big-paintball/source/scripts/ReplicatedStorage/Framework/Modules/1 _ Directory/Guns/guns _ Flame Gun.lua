-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["27"] = {
		displayName = "Flame Gun", 
		description = "Burn your enemies alive! \240\159\148\165\240\159\148\165", 
		thumbnail = "rbxassetid://4352530406", 
		quality = true, 
		premium = false, 
		offsale = false, 
		disabled = false, 
		isLimited = false, 
		customDisplay = "", 
		price = 225000, 
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
				u1.Audio.Play(4102527627, p1.UpperTorso, 1, 0.85, 300);
				for v1, v2 in pairs(p1:GetDescendants()) do
					if v2:IsA("BasePart") and v2.Transparency == 0 then
						if v2.ClassName == "MeshPart" then
							v2.TextureID = "";
						end;
						u1.Functions.FastTween(v2, {
							Color = Color3.new(0, 0, 0)
						}, { 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out });
					elseif v2.ClassName == "SpecialMesh" then
						v2.TextureId = "";
					elseif v2.ClassName == "Shirt" or v2.ClassName == "Pants" or v2.ClassName == "ShirtGraphic" or v2.ClassName == "Decal" or v2.ClassName == "Texture" then
						v2:Destroy();
					end;
				end;
				local v3, v4 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v5, v6 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Flame KillFX"):GetChildren()) do
					local v8 = v6:Clone();
					v8.Parent = v4;
					v8:Emit(10);				
				end;
				v3.Parent = p1;
				for v9, v10 in pairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Fire"):GetChildren()) do
					v10:Clone().Parent = p1.UpperTorso;
				end;
			end;
		end
	}
};
