-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["77"] = {
		displayName = "Glass Scar", 
		description = "Fragile! Handle with Care", 
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
				for v1, v2 in pairs(p1:GetDescendants()) do
					if v2:IsA("BasePart") and v2.Transparency == 0 then
						if v2.ClassName == "MeshPart" then
							v2.TextureID = "";
						end;
						v2.Material = Enum.Material.Glass;
						v2.Color = Color3.fromRGB(255, 255, 255);
						v2.Transparency = 0;
						u1.Functions.FastTween(v2, {
							Transparency = 0.5
						}, { 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out });
					elseif v2.ClassName == "SpecialMesh" then
						v2.TextureId = "";
					elseif v2.ClassName == "Shirt" or v2.ClassName == "Pants" or v2.ClassName == "ShirtGraphic" or v2.ClassName == "Decal" or v2.ClassName == "Texture" then
						v2:Destroy();
					end;
				end;
				local v3, v4 = u1.Functions.CreateParticleHost(p1.PrimaryPart.CFrame);
				for v5, v6 in ipairs(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles"):WaitForChild("Glass KillFX"):GetChildren()) do
					local v8 = v6:Clone();
					v8.Parent = v4;
					v8:Emit(v8.Rate);				
				end;
				v3.Parent = p1;
				for v9, v10 in pairs(p1:GetDescendants()) do
					if v10:IsA("BasePart") then
						local l__Velocity__11 = v10.Velocity;
						u1.Functions.FastTween(v10, {
							Velocity = Vector3.new()
						}, { 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out }).Completed:Connect(function()
							v10.Anchored = true;
						end);
					end;
				end;
				coroutine.wrap(function()
					task.wait(1);
					for v12, v13 in pairs(p1:GetDescendants()) do
						if v13:IsA("BasePart") then
							u1.Functions.FastTween(v13, {
								Transparency = 1
							}, { 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out }).Completed:Connect(function()
								v13:Destroy();
							end);
						end;
					end;
				end)();
			end;
		end
	}
};
