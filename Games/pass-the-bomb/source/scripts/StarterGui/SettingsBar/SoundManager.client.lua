-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SoundFolder = ReplicatedStorage.Sounds

local StarterGui = script.Parent
local SettingsBar = script.Parent.SettingsBar

-- Script
for _, element in pairs(StarterGui:GetDescendants()) do
	if element:IsA("ImageButton") or element:IsA("TextButton") then

		-- When hovering
		element.MouseEnter:Connect(function()
			SoundFolder.ButtonHover:Play()
		end)

		-- When clicking
		element.MouseButton1Click:Connect(function()
			SoundFolder.ButtonClick:Play()
		end)

	end
end