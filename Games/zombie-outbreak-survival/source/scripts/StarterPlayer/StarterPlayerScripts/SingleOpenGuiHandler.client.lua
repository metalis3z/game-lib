local guiNames = {
	"CommentsUi",
	"Codes",
	"Tools_shop",
	"Tutorial"
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Helper function to close all GUIs except the one specified
local function closeOtherGuis(openedGuiName)
    for i, guiName in guiNames do
        if guiName ~= openedGuiName then
            local gui = PlayerGui:FindFirstChild(guiName)
            if gui and gui:IsA("ScreenGui") then
                gui.Enabled = false
            end
        end
    end
end

-- Connect to each GUI's Enabled property
for i, guiName in guiNames do
    local gui = PlayerGui:FindFirstChild(guiName)
    if gui and gui:IsA("ScreenGui") then
        gui:GetPropertyChangedSignal("Enabled"):Connect(function()
            if gui.Enabled then
                closeOtherGuis(guiName)
            end
        end)
    end
end

-- Listen for new GUIs being added to PlayerGui (in case they are reset or re-added)
PlayerGui.ChildAdded:Connect(function(child)
    for i, guiName in guiNames do
        if child.Name == guiName and child:IsA("ScreenGui") then
            child:GetPropertyChangedSignal("Enabled"):Connect(function()
                if child.Enabled then
                    closeOtherGuis(guiName)
                end
            end)
        end
    end
end)

