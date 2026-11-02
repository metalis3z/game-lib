local button = script.Parent
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")
local AdminPanelMain = gui.Frames.AdminPanelMain

local function toggleAdminPanelMain()
	AdminPanelMain.Visible = not AdminPanelMain.Visible
end

button.MouseButton1Click:Connect(toggleAdminPanelMain)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F2 then
		toggleAdminPanelMain()
	end
end)
