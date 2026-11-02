-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SoundFolder = workspace.Sounds

local StarterGui = script.Parent
local MainFrame = script.Parent.MainFrame

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