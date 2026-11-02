repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hotel_FirstRoom" then

else
	return
end

local KeyObtain = require(script.Directory.KeyObtain)

local ItemPickup = require(script.Directory["ItemPickup"])
local RoomGeneration = require(script.Directory["RoomGeneration"])
local GameDetails = require(script.Directory["GameDetails"])
local Controls_Items = require(script.Controls.Items)
local RoomInteractable = require(script.Controls.RoomInteractable)

RoomGeneration:DoorKeyGenerate(game.Workspace.CurrentRooms["0"])
task.wait(0.5)
KeyObtain:Load(game.Workspace.CurrentRooms:FindFirstChild("0").Door.Lock, true)
game.Workspace.CurrentRooms:FindFirstChild("0").Door.Lock:SetAttribute("LoadModule", "Loaded")

local p123 = 10

for v7, v8 in pairs(game.ServerScriptService.Server.Special.Hotel_Bayourd:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
		if string.find(v8.Name, "Chex") or string.find(v8.Name, "Delta") then
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			if p123 < 2 then
				p123 = 10
			else
				p123 = p123 - 1
			end
		else
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			v8.Parent:SetAttribute("Wardrobes", true)
			v8.Parent:SetAttribute("SaveRoom", math.random(1, p123))
			v8:Destroy()
			if p123 < 2 then
				p123 = 10
			else
				p123 = p123 - 1
			end
		end
	end
end

for v9, v10 in pairs(game.ServerScriptService.Server.Special.Hotel_Infirmary:GetDescendants()) do
	if v10:IsA("Model") and string.find(v10.Name, "Bed_Infirmary") then
		if v10:FindFirstChild("HidePrompt") then
			v10:FindFirstChild("HidePrompt"):Destroy()
		end
	end
end

for v9, v10 in pairs(game.ServerScriptService.Server.DifficultyRooms:GetDescendants()) do
	if v10:IsA("Model") and string.find(v10.Name, "Bed") then
		if v10:FindFirstChild("HidePrompt") then
			v10:FindFirstChild("HidePrompt"):Destroy()
		end
	end
end

for v9, v10 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
	if v10:IsA("Model") and string.find(v10.Name, "Bed") then
		if v10:FindFirstChild("HidePrompt") then
			v10:FindFirstChild("HidePrompt"):Destroy()
		end
	end
end

for v9, v10 in pairs(game.ServerScriptService.Server.BackupRooms:GetDescendants()) do

	if v10:IsA("Model") and string.find(v10.Name, "Hotel_") then
		if v10:GetAttribute("OriginalName") then

		else
			local part = Instance.new("Part")

			part.Name = "CollideRoom"

			local orientation, size = v10:GetBoundingBox()
			part.Size = size
			part.CFrame = orientation

			part.Parent = v10

			part.Anchored = true
			part.CanCollide = false
			part.Transparency = 1

			RoomInteractable:PlayerAttribute(v10)
		end
	end
end

for v9, v10 in pairs(game.ServerScriptService.Server.Special:GetDescendants()) do

	if v10:IsA("Model") and string.find(v10.Name, "Hotel_") then
		if v10:GetAttribute("OriginalName") then

		else
			local part = Instance.new("Part")

			part.Name = "CollideRoom"

			local orientation, size = v10:GetBoundingBox()
			part.Size = size
			part.CFrame = orientation

			part.Parent = v10

			part.Anchored = true
			part.CanCollide = false
			part.Transparency = 1
			
			RoomInteractable:PlayerAttribute(v10)
		end
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

local p1 = 10
local p2 = 10
local p3 = 10

for v7, v8 in pairs(game.ServerScriptService.Server.BackupRooms:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
		if string.find(v8.Name, "Chex") or string.find(v8.Name, "Delta") then
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			if p1 < 2 then
				p1 = 10
			else
				p1 = p1 - 1
			end
		else
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			v8.Parent:SetAttribute("Wardrobes", true)
			v8.Parent:SetAttribute("SaveRoom", math.random(1, p1))
			v8:Destroy()
			if p1 < 2 then
				p1 = 10
			else
				p1 = p1 - 1
			end
		end
	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.DifficultyRooms:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
		if string.find(v8.Name, "Chex") or string.find(v8.Name, "Delta") then
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			if p2 < 2 then
				p2 = 10
			else
				p2 = p2 - 1
			end
		else
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			v8.Parent:SetAttribute("Wardrobes", true)
			v8.Parent:SetAttribute("SaveRoom", math.random(1, p2))
			v8:Destroy()
			if p2 < 2 then
				p2 = 10
			else
				p2 = p2 - 1
			end
		end
	end
end

for v7, v8 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
	if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
		if string.find(v8.Name, "Chex") or string.find(v8.Name, "Delta") then
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			if p3 < 2 then
				p3 = 10
			else
				p3 = p3 - 1
			end
		else
			local clone = game.ServerStorage.Storage.Wardrobe:Clone()
			clone.Parent = v8.Parent.Assets
			clone:PivotTo(v8.PrimaryPart.CFrame)
			task.wait()
			v8.Parent:SetAttribute("Wardrobes", true)
			v8.Parent:SetAttribute("SaveRoom", math.random(1, p3))
			v8:Destroy()
			if p3 < 2 then
				p3 = 10
			else
				p3 = p3 - 1
			end
		end
	end
end

for v7, v8 in pairs(game.ServerScriptService:GetDescendants()) do
	if v8:IsA("Model") then
		if string.find(v8.Name, "Window") or string.find(v8.Name, "window") then
			
			if v8.Name == "Fake_Window_Tall" or v8.Name == "Arch_Window" then
				
			else
				if v8.Glass:FindFirstChild("PlaySound") then
					v8.Glass:FindFirstChild("PlaySound"):Destroy()
				end

				if v8.Glass:FindFirstChild("Rain") then
					for i = 1, 2 do
						v8.Glass:FindFirstChild("Rain"):Destroy()
					end
				end

				if v8.LightPanel.Attachment:FindFirstChild("Thunder") then
					v8.LightPanel.Attachment:FindFirstChild("Thunder"):Destroy()
				end

				if v8.Particles.Attachment:FindFirstChild("PlaySound") then
					v8.Particles.Attachment:FindFirstChild("PlaySound"):Destroy()
				end

				task.wait()
				
				v8.Glass.Transparency = 0.7
				v8.Glass.Material = Enum.Material.Glacier

				local Rain_New = game.ServerScriptService.Server.Sounds.PlaySound_Window:Clone()
				Rain_New.Name = "PlaySound"
				Rain_New.Parent = v8.Particles.Attachment

				local Thunder_New = game.ServerScriptService.Server.Sounds.Thunder_Window:Clone()
				Thunder_New.Name = "Thunder"
				Thunder_New.Parent = v8.LightPanel.Attachment
			end
			
		end
	end
end


for v7, v8 in pairs(game.Workspace:GetDescendants()) do
	if v8:IsA("Model") then
		if string.find(v8.Name, "Window") or string.find(v8.Name, "window") then

			if v8.Name == "WindowTallSingleUnique" or v8.Name == "Fake_Window_Tall" then

			else
				if v8.Glass:FindFirstChild("PlaySound") then
					v8.Glass:FindFirstChild("PlaySound"):Destroy()
				end

				if v8.Glass:FindFirstChild("Rain") then
					for i = 1, 2 do
						v8.Glass:FindFirstChild("Rain"):Destroy()
					end
				end

				if v8.LightPanel.Attachment:FindFirstChild("Thunder") then
					v8.LightPanel.Attachment:FindFirstChild("Thunder"):Destroy()
				end

				if v8.Particles.Attachment:FindFirstChild("PlaySound") then
					v8.Particles.Attachment:FindFirstChild("PlaySound"):Destroy()
				end

				task.wait()
				
				v8.Glass.Transparency = 0.7
				v8.Glass.Material = Enum.Material.Glacier

				local Rain_New = game.ServerScriptService.Server.Sounds.PlaySound_Window:Clone()
				Rain_New.Name = "PlaySound"
				Rain_New.Parent = v8.Particles.Attachment

				local Thunder_New = game.ServerScriptService.Server.Sounds.Thunder_Window:Clone()
				Thunder_New.Name = "Thunder"
				Thunder_New.Parent = v8.LightPanel.Attachment
			end

		end
	end
end

for v7, v8 in pairs(game.ServerScriptService:GetDescendants()) do
	if v8:IsA("Model") then
		if v8.Name == "Door" then
			v8.Door.Material = Enum.Material.Wood
			v8.Door.MaterialVariant = "PlywoodALT"
			if v8.Door:FindFirstChild("Sign") then
				v8.Door:FindFirstChild("Sign").Material = Enum.Material.Pebble
				v8.Door:FindFirstChild("Sign").MaterialVariant = "Plywood"
			end
		end;
	end;
	
	if v8:IsA("MeshPart") then
		if v8.Name == "Door" or v8.Name == "FakeDoor" then
			v8.Material = Enum.Material.Wood
			v8.MaterialVariant = "PlywoodALT"
		end;
	end;
end;

for v7, v8 in pairs(game.Workspace:GetDescendants()) do
	if v8:IsA("BasePart") then
		if v8.Name == "Wall" then
			v8.Material = Enum.Material.Wood
			v8.MaterialVariant = "Plaster"
			v8.CanCollide = true
		end;
	end;
end;

function wall(v, randomwallcolor)
	if randomwallcolor == 1 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(109, 70, 70)
		color.Name = "color"
		color.Parent = v.Wall
		v.Wall.colortrue.Value = true
	elseif randomwallcolor == 2 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(89, 116, 117)
		color.Name = "color"
		color.Parent = v.Wall
		v.Wall.colortrue.Value = true
	elseif randomwallcolor == 3 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(69, 81, 109)
		color.Name = "color"
		color.Parent = v.Wall
		v.Wall.colortrue.Value = true
	elseif randomwallcolor == 4 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(76, 109, 91)
		color.Name = "color"
		color.Parent = v.Wall
		v.Wall.colortrue.Value = true
	elseif randomwallcolor == 5 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(134, 116, 95)
		color.Name = "color"
		color.Parent = v.Wall
		v.Wall.colortrue.Value = true
	elseif randomwallcolor == 6 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(72, 88, 125)
		color.Name = "color"
		color.Parent = v.Wall
		v.Wall.colortrue.Value = true
	end
end

function carpet(v, randomcarpetcolor)
	if randomcarpetcolor == 1 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(106, 79, 70)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(156, 116, 103)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Texture = "rbxassetid://12002739056"
		Texture.StudsPerTileU = 9
		Texture.StudsPerTileV = 9
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.85
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 2 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(71, 77, 69)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(102, 117, 102)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(0, 0, 0)
		Texture.Texture = "rbxassetid://9820813087"
		Texture.StudsPerTileU = 3
		Texture.StudsPerTileV = 3
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.88
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 3 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(81, 70, 61)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(77, 63, 63)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(198, 187, 162)
		Texture.Texture = "rbxassetid://849185396"
		Texture.StudsPerTileU = 6
		Texture.StudsPerTileV = 6
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.85
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 4 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(79, 51, 51)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(91, 68, 73)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(255, 247, 179)
		Texture.Texture = "rbxassetid://7960579811"
		Texture.StudsPerTileU = 72
		Texture.StudsPerTileV = 72
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.9
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 5 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(65, 63, 63)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(71, 69, 69)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(255, 255, 255)
		Texture.Texture = "rbxassetid://2062021684"
		Texture.StudsPerTileU = 10
		Texture.StudsPerTileV = 10
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.97
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 6 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(79, 86, 77)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(95, 109, 95)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(0, 0, 0)
		Texture.Texture = "rbxassetid://3476500459"
		Texture.StudsPerTileU = 4
		Texture.StudsPerTileV = 4
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.88
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 7 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(79, 51, 51)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(91, 68, 73)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(153, 148, 107)
		Texture.Texture = "rbxassetid://2279603548"
		Texture.StudsPerTileU = 15
		Texture.StudsPerTileV = 15
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.93
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 8 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(91, 62, 71)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(72, 74, 83)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(255, 255, 255)
		Texture.Texture = "rbxassetid://2535177972"
		Texture.StudsPerTileU = 10
		Texture.StudsPerTileV = 10
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.6
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	elseif randomcarpetcolor == 9 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(77, 63, 63)
		Carpet.Name = "Carpet"
		Carpet.Parent = v.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(102, 83, 83)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = v.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(0, 0, 0)
		Texture.Texture = "rbxassetid://273619459"
		Texture.StudsPerTileU = 18
		Texture.StudsPerTileV = 15
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.85
		Texture.Face = "Top"
		Texture.Parent = v.Carpet
	end
end

local randomwallcolor11 = math.random(1, 6)
local randomwallcolor12 = math.random(1, 6)
local randomwallcolor13 = math.random(1, 6)
local randomwallcolor14 = math.random(1, 6)
local randomwallcolor15 = math.random(1, 6)
local randomwallcolor16 = math.random(1, 6)
local randomwallcolor17 = math.random(1, 6)
local randomwallcolor18 = math.random(1, 6)

local randomcarpetcolor11 = math.random(1, 9)
local randomcarpetcolor12 = math.random(1, 9)
local randomcarpetcolor13 = math.random(1, 9)
local randomcarpetcolor14 = math.random(1, 9)
local randomcarpetcolor15 = math.random(1, 9)
local randomcarpetcolor16 = math.random(1, 9)
local randomcarpetcolor17 = math.random(1, 9)
local randomcarpetcolor18 = math.random(1, 9)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.NextInHallway.Colors, randomcarpetcolor11)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.NextInHallway.Colors, randomwallcolor11)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.CoolGroom.Colors, randomcarpetcolor12)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.CoolGroom.Colors, randomwallcolor12)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.LastSeekRoom.Colors, randomcarpetcolor13)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.LastSeekRoom.Colors, randomwallcolor13)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.RightWayRoom.Colors, randomcarpetcolor14)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.RightWayRoom.Colors, randomwallcolor14)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.RightWayRoom2.Colors, randomcarpetcolor15)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.RightWayRoom2.Colors, randomwallcolor15)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.MiddleWayRoom.Colors, randomcarpetcolor16)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.MiddleWayRoom.Colors, randomwallcolor16)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.LeftWayRoom.Colors, randomcarpetcolor17)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.LeftWayRoom.Colors, randomwallcolor17)

carpet(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.LeftWayRoom2.Colors, randomcarpetcolor18)
wall(game.ServerScriptService.Server.Special.SeekRooms.RunningRooms.LeftWayRoom2.Colors, randomwallcolor18)

wait()

if game.Workspace.CurrentRooms.CurrentRoom.Value > 0 then
	while true do
		wait(1.5)
		local room = workspace.CurrentRooms:WaitForChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)
		if workspace.CurrentRooms:WaitForChild(workspace.CurrentRooms.CurrentRoom.Value - 1) then

			if room:FindFirstChild("Settings") then
				if room:FindFirstChild("Settings"):FindFirstChild("Key") then
					if room:FindFirstChild("Settings"):FindFirstChild("Key").Value == true then

						for i, v in pairs(room:GetDescendants()) do

							if v:GetAttribute("LoadModule") == "DoorKey" then

								RoomGeneration:OpenLock(v:FindFirstChild("Hidden"))
								RoomGeneration:DeleteRooms()
								v:SetAttribute("LoadModule", "Loaded")

							end

							if v:GetAttribute("LoadModule") == "Key" then

								KeyObtain:Load(v)
								v:SetAttribute("LoadModule", "Loaded")

							end

						end;
					end
				end
			end
			
			for i, v in pairs(room:GetDescendants()) do

				if v:GetAttribute("LoadModule") == "Door" then
					
					RoomGeneration:Open(v:FindFirstChild("Hidden"))
					RoomGeneration:Generate(v:FindFirstChild("Hidden"))
					RoomGeneration:DeleteRooms()
					v:SetAttribute("LoadModule", "Loaded")

				end

			end;
		end
	end
end

while true do
	wait(1)
	if game.Workspace.Ambience_Figure.TimePosition >= 168 then
		game.Workspace.Ambience_Figure.TimePosition = 15
	end
end