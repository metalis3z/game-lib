local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer

local function disableReset()
    for _ = 1, 50 do
        local ok = pcall(function()
            StarterGui:SetCore("ResetButtonCallback", false)
        end)
        if ok then
            return
        end
        task.wait(0.1)
    end
end

disableReset()

localPlayer.CharacterAdded:Connect(disableReset)
