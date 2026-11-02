-- NovaUI showcase — press Right Shift to open/close.
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Nova = require(game:GetService("ReplicatedStorage"):WaitForChild("NovaUI"))

local ui = Nova.new(Players.LocalPlayer:WaitForChild("PlayerGui"), "nova")

local main = ui:Tab("Controls")
main:Section("Buttons")
main:Button("Say hello", function() ui:Notify("Hello from Nova UI 👋") end)
main:Button("Reset character", function()
	local hum = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.Health = 0 end
end)
main:Section("Toggles")
main:Toggle("Notifications", true, function(v) ui:Notify("Notifications " .. (v and "on" or "off")) end)
main:Toggle("Sprint", false, function(v)
	local hum = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = v and 32 or 16 end
end)

local player = ui:Tab("Player")
player:Section("Movement")
player:Slider("Walk speed", 8, 100, 16, function(v)
	local hum = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = v end
end)
player:Slider("Field of view", 50, 120, 70, function(v) workspace.CurrentCamera.FieldOfView = v end)

local settings = ui:Tab("Settings")
settings:Section("Appearance")
settings:Dropdown("Accent", {"Emerald", "Violet", "Sky", "Rose"}, "Emerald", function(v) ui:Notify("Accent: " .. v) end)
settings:Toggle("Blur behind UI", false, function(v)
	local blur = game.Lighting:FindFirstChild("NovaBlur") or Instance.new("BlurEffect")
	blur.Name = "NovaBlur"; blur.Size = 12; blur.Parent = game.Lighting; blur.Enabled = v
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if input.KeyCode == Enum.KeyCode.RightShift and not UserInputService:GetFocusedTextBox() then ui:Toggle() end
end)
