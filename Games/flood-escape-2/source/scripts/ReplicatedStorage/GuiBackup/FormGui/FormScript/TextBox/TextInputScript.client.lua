local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormRemote = ReplicatedStorage.FormRemote
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
local Config = require(FormModules.Config)
local RemoteType = require(FormModules.RemoteType)
local ResponseType = require(FormModules.ResponseType)

-- UI
local TextBox = script.Parent
local Border = TextBox.Border
local defaultBorderSize = Border.Size

-- Constants
local defaultColor = Colors.LightGray
local focusedColor = ContainerGui:GetAttribute("ThemeColor")

TextBox.PlaceholderColor3 = Colors.MediumGray

function onFocused()
	Border.BackgroundColor3 = focusedColor
	Border.Size = defaultBorderSize + UDim2.fromOffset(0, 1)
end

function onFocusLost()
	Border.BackgroundColor3 = defaultColor
	Border.Size = defaultBorderSize
	
	-- Filter text
	if Config.FilterText then
		local requestData = { text = TextBox.Text }
		local responseType, filteredText = FormRemote:InvokeServer(RemoteType.FilterText, requestData)
		
		TextBox.Text = filteredText
		
		if responseType ~= ResponseType.Success then
			StarterGui:SetCore("SendNotification", Config.Notifications[responseType])
		end
	end
end

TextBox.Focused:Connect(onFocused)
TextBox.FocusLost:Connect(onFocusLost)

-- Gamepad / Keyboard Support
TextBox.SelectionGained:Connect(onFocused)
TextBox.SelectionLost:Connect(onFocusLost)
