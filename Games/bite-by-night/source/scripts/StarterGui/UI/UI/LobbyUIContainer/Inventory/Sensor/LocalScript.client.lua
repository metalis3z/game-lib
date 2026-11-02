-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local v3 = Players.LocalPlayer:GetMouse()
local Parent = script.Parent
local InventoryModel = game.Workspace:WaitForChild("MAPS"):WaitForChild("InventoryModel")
local v_u_6 = false
local function v7()
    v_u_6 = false
end
Parent.MouseButton1Down:Connect(function()
    v_u_6 = true
end)
Parent.MouseButton1Up:Connect(v7)
v3.Button1Up:Connect(v7)
game:GetService("UserInputService").InputEnded:Connect(function(p8, _)
    if p8.UserInputType == Enum.UserInputType.MouseButton1 then
        v_u_6 = false
    end
end)
local v_u_9 = 0
local v_u_10 = game:GetService("Players").LocalPlayer:GetMouse()
local v_u_11 = v_u_10.X
local v_u_12 = nil
RunService.RenderStepped:Connect(function(p13)
    local v14 = 0
    if v_u_6 and game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        v14 = v_u_10.X - v_u_11
    elseif v_u_6 then
        v_u_6 = false
    end
    v_u_11 = v_u_10.X
    v_u_9 = v_u_9 + (v14 - v_u_9) * p13 * 2
    local Model = InventoryModel:FindFirstChildOfClass("Model")
    if Model then
        local v16 = v_u_9
        if math.abs(v16) > 0.1 then
            Model:PivotTo(Model:GetPivot() * CFrame.Angles(0, v_u_9 * p13 * 2, 0))
        end
    end
    if Model ~= Model then
        v_u_9 = 0
    end
    v_u_12 = Model
end)
