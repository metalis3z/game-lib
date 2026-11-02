-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local v_u_4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp")).Client("Input")
local m_Keybinds = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Keybinds"))
task.spawn(function()
    repeat
        local v6 = pcall(function()
            game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
        end)
        task.wait(1)
    until v6
end)
local v_u_7 = false
local v_u_8 = false
UserInputService.InputBegan:Connect(function(p9, p10)
    if p10 then
        return
    elseif (p9.KeyCode == Enum.KeyCode.Three or p9.KeyCode == Enum.KeyCode.ButtonB) and game:GetService("Players").LocalPlayer.Character:HasTag("Selecting") then
        v_u_4:Fire(true, {
            "Ability",
            2,
            "Stealth",
            true
        })
        game:GetService("ContextActionService"):UnbindAction("LockRightStick")
        return
    elseif (p9.KeyCode == Enum.KeyCode.Two or p9.KeyCode == Enum.KeyCode.ButtonY) and game:GetService("Players").LocalPlayer.Character:HasTag("Selecting") then
        v_u_4:Fire(true, {
            "Ability",
            2,
            "Speed",
            true
        })
        game:GetService("ContextActionService"):UnbindAction("LockRightStick")
        return
    elseif (p9.KeyCode == Enum.KeyCode.One or p9.KeyCode == Enum.KeyCode.ButtonX) and game:GetService("Players").LocalPlayer.Character:HasTag("Selecting") then
        v_u_4:Fire(true, {
            "Ability",
            2,
            "Strength",
            true
        })
        game:GetService("ContextActionService"):UnbindAction("LockRightStick")
        return
    elseif table.find(m_Keybinds.Run, p9.KeyCode) then
        v_u_8 = true
        if LocalPlayer:GetAttribute("HoldToRun") then
            v_u_4:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
        else
            v_u_7 = not v_u_7
            v_u_4:Fire(true, { v_u_7, Enum.KeyCode.LeftShift.Value })
        end
    elseif table.find(m_Keybinds.M1, p9.UserInputType) or table.find(m_Keybinds.M1, p9.KeyCode) then
        v_u_4:Fire(true, { "Ability", 1 })
        return
    elseif table.find(m_Keybinds.Q, p9.KeyCode) then
        v_u_4:Fire(true, { "Ability", 2, "Cancel" })
        game:GetService("ContextActionService"):UnbindAction("LockRightStick")
        return
    elseif table.find(m_Keybinds.E, p9.KeyCode) then
        v_u_4:Fire(true, { "Ability", 3 })
    elseif table.find(m_Keybinds.R, p9.KeyCode) then
        v_u_4:Fire(true, { "Ability", 4 })
    end
end)
UserInputService.InputEnded:Connect(function(p11, p12)
    if not p12 then
        if table.find(m_Keybinds.Run, p11.KeyCode) then
            if LocalPlayer:GetAttribute("HoldToRun") then
                v_u_4:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
            end
            v_u_8 = false
        end
    end
end)
local v_u_13 = false
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Sprint.Button.MouseButton1Down:Connect(function()
    v_u_4:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
    v_u_13 = true
    if LocalPlayer:GetAttribute("HoldToRun") then
        v_u_4:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
    else
        v_u_7 = not v_u_7
        v_u_4:Fire(true, { v_u_7, Enum.KeyCode.LeftShift.Value })
    end
end)
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Sprint.Button.MouseButton1Up:Connect(function()
    if LocalPlayer:GetAttribute("HoldToRun") then
        v_u_4:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
    end
    v_u_13 = false
end)
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Crouch.Button.MouseButton1Click:Connect(function()
    v_u_4:Fire(true, { "Crouch" })
end)
game:GetService("RunService").Heartbeat:Connect(function()
    if LocalPlayer:GetAttribute("HoldToRun") and (v_u_8 or v_u_13) and (Character:GetAttribute("CanRun") and (not Character:HasTag("Battery") and (not Character:GetAttribute("Ragdoll") and (Character:GetAttribute("Stamina") or 0) > 0))) then
        if not Character:GetAttribute("Running") then
            v_u_4:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
            Character:SetAttribute("Running", true)
            return
        end
    elseif LocalPlayer:GetAttribute("HoldToRun") or (not Character:GetAttribute("CanRun") or (Character:HasTag("Battery") or (Character:GetAttribute("Ragdoll") or (Character:GetAttribute("Stamina") or 0) <= 0))) then
        if Character:GetAttribute("Running") then
            v_u_4:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
            Character:SetAttribute("Running", false)
        end
        v_u_7 = false
        v_u_8 = false
    elseif v_u_7 ~= Character:GetAttribute("Running") then
        v_u_4:Fire(true, { v_u_7, Enum.KeyCode.LeftShift.Value })
        Character:SetAttribute("Running", v_u_7)
        return
    end
end)
