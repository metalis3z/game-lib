--Variables
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerStorage = game:GetService("ServerStorage")
local Armour = ServerStorage:WaitForChild("Uniforms")


--Function
Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(5834847) == 255 then
			local Uniform = Armour.SD["SD LR"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(12124958) == 3 then
			local Uniform = Armour.SD["SD LR"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(5834847) == 1 then
			local Uniform = Armour.SD["SD REC"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(5834847) == 6 then
			local Uniform = Armour.SD["SD MR"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(5834847) == 7 then
			local Uniform = Armour.SD["SD MR"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(5834847) == 8 then
			local Uniform = Armour.SD["SD HR"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(5834847) == 10 then
			local Uniform = Armour.SD["SD DIR"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Security Department"].TeamColor and Player:GetRankInGroup(5834847) == 12 then
			local Uniform = Armour.SD["SD DIR"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)


Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 7 then
			local Uniform = Armour.MTF["TAU 5"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)


Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 5 then
			local Uniform = Armour.MTF["EPSILON 11"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 10 then
			local Uniform = Armour.MTF["ALPHA 1"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 8 then
			local Uniform = Armour.MTF["IOTA 10"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 4 then
			local Uniform = Armour.MTF["IOTA 10"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 3 then
			local Uniform = Armour.MTF["NU 7"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)


Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 14 then
			local Uniform = Armour.MTF["SGT"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 15 then
			local Uniform = Armour.MTF["SGT"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 254 then
			local Uniform = Armour.MTF["SGT"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if Player.TeamColor == Teams["Mobile Task Force"].TeamColor and Player:GetRankInGroup(5834837) == 255 then
			local Uniform = Armour.MTF["SGT"]
			local Humanoid = Character:WaitForChild("Humanoid")
			local BodyColour = Character:WaitForChild("Body Colors")
			local Face = Character:WaitForChild("Head"):FindFirstChildOfClass("Decal")
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
			local Values = Uniform.Values
			wait(0.1)
			local CAc = function(Character)
				for _,K in pairs(Character:GetChildren()) do
					if K:IsA("Accessory") or K:IsA("Accoutrement") or K:IsA("Hat") then
						K:Remove()
					end
				end
			end
			local ClearA = Values:FindFirstChild("ClearAccessories")
			if ClearA and Values.ClearAccessories then
				CAc(Character)
			end
			for _,C in pairs(Uniform:GetChildren()) do
				if C:IsA("Accessory") then
					local Clone_Armour = C:Clone()
					Humanoid:AddAccessory(Clone_Armour)
				end
			end
			for _,E in pairs(Character:GetChildren()) do
				if E:IsA("Clothing") then
					E:Remove()
				end
			end
			local ShirtC = Uniform.Clothing:WaitForChild("Shirt")
			local PantsC = Uniform.Clothing:WaitForChild("Pants")
			Face.Texture = "rbxassetid://209715003"
			Instance.new("Shirt", Character)
			Character.Clothing.Name = ShirtC.Name
			Instance.new("Pants", Character)
			Character.Clothing.Name = PantsC.Name
			Character.Shirt.ShirtTemplate = ShirtC.ShirtTemplate
			Character.Pants.PantsTemplate = PantsC.PantsTemplate
			Character.Shirt.Color3 = ShirtC.Color3
			Character.Pants.Color3 = PantsC.Color3
			BodyColour.HeadColor3 = Values.BodyColour.Value
			BodyColour.TorsoColor3 = Values.BodyColour.Value
			BodyColour.LeftArmColor3 = Values.BodyColour.Value
			BodyColour.RightArmColor3 = Values.BodyColour.Value
			BodyColour.LeftLegColor3 = Values.BodyColour.Value
			BodyColour.RightLegColor3 = Values.BodyColour.Value
			Humanoid.Health = Values.Health.Value
			Humanoid.MaxHealth = Values.Health.Value
			Humanoid.WalkSpeed = Values.WalkSpeed.Value
		end
	end)
end)