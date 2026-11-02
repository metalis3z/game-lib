local player = game.Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local RemoteFunctions = RSEngine:WaitForChild("RemotesFunctions")
local getValue = RemoteFunctions:WaitForChild("GetValue")
local RemoteEvents = RSEngine:WaitForChild("RemotesEvents")
local ChangeValue = RemoteEvents:WaitForChild("ChangeValue")

local playerGui = player.PlayerGui
local gui = playerGui:WaitForChild("GUI")
local frames = gui:WaitForChild("Frames")
local settingsFrame = frames:WaitForChild("Settings")
local sfxToggle = settingsFrame:WaitForChild("SFXToggle")
local hidePetsToggle = settingsFrame:WaitForChild("HidePetsToggle")
local musicToggle = settingsFrame:WaitForChild("MusicToggle")

local SoundService = game:GetService("SoundService")
local main = SoundService:WaitForChild("Main")
local music = main:WaitForChild("Music")
local SFX = main:WaitForChild("Interface")

local settingsData = getValue:InvokeServer("Settings")
for i, setting in pairs(settingsData) do
	local frame = settingsFrame:FindFirstChild(i.."Toggle")
	
	if frame then

		if setting == true then
			frame.TextLabel.Text =  "On"
			frame.ImageColor3 = Color3.fromRGB(255, 255, 255)
		else
			frame.TextLabel.Text = "Off"
			frame.ImageColor3 = Color3.fromRGB(255, 0, 0)
		end
	end
end

local lastHidePets = nil
local lastMusic = nil
local lastSFX = nil

local function toggleValue(value)
	local settingData = getValue:InvokeServer("Settings")
	if settingData[value] == true then
		settingData[value] = false
	else
		settingData[value] = true
	end
	ChangeValue:FireServer("Settings", settingData)	
	
	local frame = settingsFrame:FindFirstChild(value.."Toggle")
	
	if frame then
		
		if settingData[value] == true then
			frame.TextLabel.Text =  "On"
			frame.ImageColor3 = Color3.fromRGB(255, 255, 255)
		else
			frame.TextLabel.Text = "Off"
			frame.ImageColor3 = Color3.fromRGB(255, 0, 0)
		end
	end
end

sfxToggle.MouseButton1Click:Connect(function()
	toggleValue("SFX")
end)

musicToggle.MouseButton1Click:Connect(function()
	toggleValue("Music")
end)

hidePetsToggle.MouseButton1Click:Connect(function()
	toggleValue("HidePets")
end)

while wait(1) do
	local settingData = getValue:InvokeServer("Settings")
	
	if settingData["HidePets"] == true then
		if settingData["HidePets"] ~= lastHidePets then
			lastHidePets = settingData["HidePets"]
			
			for _, player in pairs(game.Players:GetChildren()) do
				local character = player.Character
				if character then
					local petsFolder: Folder = character:FindFirstChild("Pets")
					if petsFolder then
						for _, part in pairs(petsFolder:GetDescendants()) do
							if part:IsA("BasePart") then
								part.Transparency = 1
							end
						end
					end
				end
			end
		end
	else
		if settingData["HidePets"] ~= lastHidePets then
			lastHidePets = settingData["HidePets"]

			for _, player in pairs(game.Players:GetChildren()) do
				local character = player.Character or player.CharacterAdded:Wait()
				local petsFolder = character:FindFirstChild("Pets")
				if petsFolder then
					
					for _, part in pairs(petsFolder:GetDescendants()) do
						if part:IsA("BasePart") then
							if part.Name ~= "Part" and part.Name ~= "Main" and part.Name ~= "Core" then
								part.Transparency = 0
							end
						end
					end
				end
			end
		end
	end
	
	if settingData["Music"] == true then
		if settingData["Music"] ~= lastMusic then
			lastMusic = settingData["Music"]
			
			for _, sound: Sound in pairs(music:GetChildren()) do
				sound.Volume = 0.185
			end
		end
	else
		if settingData["Music"] ~= lastMusic then
			lastMusic = settingData["Music"]

			for _, sound: Sound in pairs(music:GetChildren()) do
				sound.Volume = 0
			end
		end
	end
	
	if settingData["SFX"] == true then
		if settingData["SFX"] ~= lastSFX then
			lastSFX = settingData["SFX"]

			for _, sound: Sound in pairs(SFX:GetChildren()) do
				sound.Volume = 0.5
			end
		end
	else
		if settingData["SFX"] ~= lastSFX then
			lastSFX = settingData["SFX"]

			for _, sound: Sound in pairs(SFX:GetChildren()) do
				sound.Volume = 0
			end
		end
	end
end 