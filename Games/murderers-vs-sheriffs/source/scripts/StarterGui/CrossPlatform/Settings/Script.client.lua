local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local WindowService = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WindowService"))
local SettingsFrame = script.Parent
local MenuBlur = Lighting:WaitForChild("MenuBlur")

local function ToggleSettingsFrame(visible)
	SettingsFrame.Visible = visible
	MenuBlur.Enabled = visible
end

WindowService:RegisterFrame(SettingsFrame, "Settings")
SettingsFrame.Title.Close.Button.Activated:Connect(function()
	if SettingsFrame.Visible then
		ToggleSettingsFrame(false)
	end
end)

SettingsFrame:GetPropertyChangedSignal("Visible"):Connect(function()
	MenuBlur.Enabled = SettingsFrame.Visible
end)

local SettingsList = SettingsFrame.Settings.List
local RemotesFolder = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Settings")
local Camera = workspace.CurrentCamera

local Settings = {
	"FOV",
	"NightTime",
	"LowGraphics",
	"DisableShadows",
	"LowFog",
	"Knife",
	"GunAnimations"
}

for _, SettingName in ipairs(Settings) do
	local Setting = SettingsList:FindFirstChild(SettingName)
	if not Setting then continue end
	
	local Active, IsEnabled, Button
	if SettingName ~= "Knife" then
		Active = Setting:WaitForChild("Active")
		IsEnabled = Active:WaitForChild("IsEnabled")
		Button = Active:FindFirstChild("Button")
	end
	
	local WritingSetting = Setting:FindFirstChild("WrittingSetting")
	local Remote = RemotesFolder:FindFirstChild(SettingName)
	
	if SettingName == "FOV" and WritingSetting then
		local SetBox = Active:WaitForChild("Set")
		local FOVValue = Setting:FindFirstChild("FOV") or Instance.new("NumberValue")
		if not FOVValue.Parent then
			FOVValue.Name = "FOV"
			FOVValue.Value = Camera.FieldOfView
			FOVValue.Parent = Setting
		end
		
		FOVValue.Changed:Connect(function(newValue)
			Camera.FieldOfView = newValue
		end)
		
		SetBox.FocusLost:Connect(function(EnterPressed)
			if not EnterPressed then return end
			local Value = tonumber(SetBox.Text)
			if Value and Value >= 5 and Value <= 200 then
				SetBox.PlaceholderText = tostring(Value)
				SetBox.Text = ""

				FOVValue.Value = Value
				Camera.FieldOfView = Value

				if Remote then
					Remote:FireServer(Value)
				end
			else
				SetBox.Text = ""
			end
		end)
	elseif SettingName == "Knife" then
		local Belt = Setting:WaitForChild("Belt")
		local Back = Setting:WaitForChild("Back")
		local BeltButton = Belt:WaitForChild("Button")
		local BackButton = Back:WaitForChild("Button")
		local BeltEnabled = Belt:WaitForChild("IsEnabled")
		local BackEnabled = Back:WaitForChild("IsEnabled")
		local Remote = RemotesFolder:FindFirstChild("KnifePosition")
		
		local function setChosen(chosen)
			BeltEnabled.Visible = (chosen == "Belt")
			BackEnabled.Visible = (chosen == "Back")
		end
		
		if Remote then
			BeltButton.MouseButton1Click:Connect(function()
				setChosen("Belt")
				Remote:FireServer("Belt")
			end)
			
			BackButton.MouseButton1Click:Connect(function()
				setChosen("Back")
				Remote:FireServer("Back")
			end)
		end
		continue
	else
		if Button and Remote then
			local ActiveState = false
			Button.MouseButton1Click:Connect(function()
				ActiveState = not ActiveState
				IsEnabled.Visible = ActiveState
				Remote:FireServer(ActiveState)
			end)
		end
	end
end

