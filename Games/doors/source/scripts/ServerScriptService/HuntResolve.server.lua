repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hotel_FirstRoom" then
	return
else
	
end

for v1, v2 in pairs(game.Workspace.CurrentRooms:FindFirstChild("0"):GetDescendants()) do
	if v2.Name == "DrawerContainer" and v2:IsA("Model") then
		require(game.ServerScriptService.Game.Directory.Hunt_Drawers).Scan(v2)
	end
end

for v7, v8 in pairs(game.Players:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

for v7, v8 in pairs(game.Workspace:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

for v7, v8 in pairs(game.ServerScriptService:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

for v7, v8 in pairs(game.ReplicatedStorage:GetDescendants()) do
	if v8:IsA("Sound") then
		v8.SoundGroup = game.SoundService.Main
	end
end

local Hunt_Generation = require(game.ServerScriptService.Game.Directory.Hunt_RoomGeneration)
local Hunt_KeyObtain = require(game.ServerScriptService.Game.Directory.Hunt_KeyObtain)

game.Workspace.LoadGame.MovingEntities.Enabled = false

for v7, v8 in pairs(game.ServerScriptService.Server.Special.Hunt_ExitBackdoor:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Lever") then

		local room = v8.Parent

		if room then
			for v8, v9 in pairs(room:GetChildren()) do

				if string.find(v9.Name, "Lever") and v9:IsA("Model") then

					local PartPoint = Instance.new("Part")
					PartPoint.Transparency = 1
					PartPoint.Anchored = true
					PartPoint:PivotTo(v9.PrimaryPart.CFrame)
					PartPoint.Orientation = v9.PrimaryPart.Orientation
					PartPoint.Name = "JustRandomPart"..math.random(1, 10)

					PartPoint.Size = Vector3.new(0.8, 0.8, 0.8)
					PartPoint.CanCollide = false

					if not room:FindFirstChild("LeverPoints") then

						local FolderPile = Instance.new("Folder")
						FolderPile.Name = "LeverPoints"
						FolderPile.Parent = room

					end

					wait()

					PartPoint.Parent = room:FindFirstChild("LeverPoints")
					v9:Destroy()

				end

			end
		end

	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.Special.Hunt_ExitBackdoor:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Backdoor_Table") then

		local room = v8.Parent

		if room then
			for v8, v9 in pairs(room:GetChildren()) do

				if string.find(v9.Name, "Backdoor_Table_Small") and v9:IsA("Model") then

					local PartPoint = Instance.new("Part")
					PartPoint.Transparency = 1
					PartPoint.Anchored = true
					PartPoint:PivotTo(v9.PrimaryPart.CFrame)
					PartPoint.Orientation = v9.PrimaryPart.Orientation
					PartPoint.Name = "Smalltabl"

					PartPoint.Size = Vector3.new(0.8, 0.8, 0.8)
					PartPoint.CanCollide = false

					if not room:FindFirstChild("FurniturePoints") then

						local FolderPile = Instance.new("Folder")
						FolderPile.Name = "FurniturePoints"
						FolderPile.Parent = room

					end

					wait()

					PartPoint.Parent = room:FindFirstChild("FurniturePoints")
					v9:Destroy()
				else
					if string.find(v9.Name, "Backdoor_Table") and v9:IsA("Model") then

						local PartPoint = Instance.new("Part")
						PartPoint.Transparency = 1
						PartPoint.Anchored = true
						PartPoint:PivotTo(v9.PrimaryPart.CFrame)
						PartPoint.Orientation = v9.PrimaryPart.Orientation
						PartPoint.Name = "JustRandomPart"..math.random(1, 10)

						PartPoint.Size = Vector3.new(0.8, 0.8, 0.8)
						PartPoint.CanCollide = false

						if not room:FindFirstChild("FurniturePoints") then

							local FolderPile = Instance.new("Folder")
							FolderPile.Name = "FurniturePoints"
							FolderPile.Parent = room

						end

						wait()

						PartPoint.Parent = room:FindFirstChild("FurniturePoints")
						v9:Destroy()

					end
				end

			end
		end

	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.Special.Hunt_ExitBackdoor:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
		local clone = game.ServerStorage.Storage.Backdoor_Wardrobe:Clone()
		clone.Parent = v8.Parent.Assets
		clone:PivotTo(v8.PrimaryPart.CFrame)
		v8:Destroy()
	end
end

for v7, v8 in pairs(game.Workspace.CurrentRooms:FindFirstChild("0"):GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
		local clone = game.ServerStorage.Storage.Backdoor_Wardrobe:Clone()
		clone.Parent = v8.Parent.Assets
		clone:PivotTo(v8.PrimaryPart.CFrame)
		v8:Destroy()
	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.Hunt_Rooms:GetDescendants()) do
	if v8.Name == "Lightbulb" and v8:IsA("Model") then
		v8.Name = "LightStand"
	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.Hunt_Rooms:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Lever") then
		
		local room = v8.Parent
		
		if room then
			for v8, v9 in pairs(room:GetChildren()) do
				
				if string.find(v9.Name, "Lever") and v9:IsA("Model") then
					
					local PartPoint = Instance.new("Part")
					PartPoint.Transparency = 1
					PartPoint.Anchored = true
					PartPoint:PivotTo(v9.PrimaryPart.CFrame)
					PartPoint.Orientation = v9.PrimaryPart.Orientation
					PartPoint.Name = "JustRandomPart"..math.random(1, 10)
					
					PartPoint.Size = Vector3.new(0.8, 0.8, 0.8)
					PartPoint.CanCollide = false
					
					if not room:FindFirstChild("LeverPoints") then
						
						local FolderPile = Instance.new("Folder")
						FolderPile.Name = "LeverPoints"
						FolderPile.Parent = room
						
					end
					
					wait()
					
					PartPoint.Parent = room:FindFirstChild("LeverPoints")
					v9:Destroy()
					
				end
				
			end
		end
		
	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.Hunt_Rooms:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Backdoor_Table") then

		local room = v8.Parent

		if room then
			for v8, v9 in pairs(room:GetChildren()) do
				
				if string.find(v9.Name, "Backdoor_Table_Small") and v9:IsA("Model") then

					local PartPoint = Instance.new("Part")
					PartPoint.Transparency = 1
					PartPoint.Anchored = true
					PartPoint:PivotTo(v9.PrimaryPart.CFrame)
					PartPoint.Orientation = v9.PrimaryPart.Orientation
					PartPoint.Name = "Smalltabl"

					PartPoint.Size = Vector3.new(0.8, 0.8, 0.8)
					PartPoint.CanCollide = false

					if not room:FindFirstChild("FurniturePoints") then

						local FolderPile = Instance.new("Folder")
						FolderPile.Name = "FurniturePoints"
						FolderPile.Parent = room

					end

					wait()

					PartPoint.Parent = room:FindFirstChild("FurniturePoints")
					v9:Destroy()
				else
					if string.find(v9.Name, "Backdoor_Table") and v9:IsA("Model") then

						local PartPoint = Instance.new("Part")
						PartPoint.Transparency = 1
						PartPoint.Anchored = true
						PartPoint:PivotTo(v9.PrimaryPart.CFrame)
						PartPoint.Orientation = v9.PrimaryPart.Orientation
						PartPoint.Name = "JustRandomPart"..math.random(1, 10)

						PartPoint.Size = Vector3.new(0.8, 0.8, 0.8)
						PartPoint.CanCollide = false

						if not room:FindFirstChild("FurniturePoints") then

							local FolderPile = Instance.new("Folder")
							FolderPile.Name = "FurniturePoints"
							FolderPile.Parent = room

						end

						wait()

						PartPoint.Parent = room:FindFirstChild("FurniturePoints")
						v9:Destroy()

					end
				end

			end
		end

	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.Hunt_Rooms:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
		local clone = game.ServerStorage.Storage.Backdoor_Wardrobe:Clone()
		clone.Parent = v8.Parent.Assets
		clone:PivotTo(v8.PrimaryPart.CFrame)
		v8:Destroy()
	end
end

function GameGenerate()
	local room = workspace.CurrentRooms:WaitForChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)
	
	if game.Workspace:FindFirstChild("SkyboxPart") then
		game.Workspace:FindFirstChild("SkyboxPart"):PivotTo(room[room.Name].CFrame)
	end
	
	if room then
		
		if math.random(1, 10) == math.random(1, 10) then
			require(game.ReplicatedStorage.ClientModules.Module_Events).breakLights_Time(room, 15)
		end

		for i, v in pairs(room:GetDescendants()) do

			if v:GetAttribute("LoadModule") == "Door" then

				v:SetAttribute("LoadModule", "Loaded")
				Hunt_Generation:SetRoomGenerate(false)

			end
			
			if v:GetAttribute("LoadModule") == "DoorKey" then

				v:SetAttribute("LoadModule", "Loaded")
				Hunt_Generation:SetRoomGenerate(false)

			end
			
			if v:GetAttribute("LoadModule") == "Lock" then

				v:SetAttribute("LoadModule", "Loaded")
				Hunt_KeyObtain:Load(v)

			end

		end

	end
end

workspace.CurrentRooms.CurrentRoom.Changed:Connect(function()
	GameGenerate()
end)

for i = 1, 1 do
	GameGenerate()
end