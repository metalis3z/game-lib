-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local Parent = script.Parent
game:GetService("UserInputService")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local LobbyUIContainer = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer")
local Spectate = LobbyUIContainer:WaitForChild("Spectate")
local Button = Spectate:WaitForChild("Back"):WaitForChild("Button")
local Black = LobbyUIContainer:WaitForChild("Black")
local function v_u_21(p9, p10)
    local Text = p9.Text
    local v_u_12 = { "#", "\226\128\150" }
    local function v17(p13, p14)
        local v15 = ""
        for v16 = 1, #Text do
            v15 = v15 .. (v16 <= p13 and Text:sub(v16, v16) or v_u_12[p14])
        end
        return v15
    end
    local v18 = p10 or 0.005
    for v19 = 0, #Text do
        if v19 == 0 then
            p9.Text = v17(0, 2)
            task.wait(v18)
        else
            for v20 = 1, 4 do
                p9.Text = v17(v19 - 1, (v20 - 1) % 2 + 1)
                task.wait(0.0025)
            end
            p9.Text = v17(v19, 1)
            if v19 < #Text then
                task.wait(v18)
            end
        end
    end
    p9.Text = Text
end
local function v_u_25()
    Spectate:WaitForChild("Static"):WaitForChild("Static"):WaitForChild("UIGradient").Enabled = false
    Spectate:WaitForChild("Static").GroupTransparency = 0
    Spectate:WaitForChild("Static"):WaitForChild("Static").ImageTransparency = 0
    local v22 = TweenService:Create(Spectate:WaitForChild("Static"), TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["GroupTransparency"] = 0.19
    })
    local v23 = TweenService:Create(Spectate:WaitForChild("Static"):WaitForChild("Static"), TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["ImageTransparency"] = 1
    })
    local v_u_24 = TweenService:Create(Spectate:WaitForChild("Static"):WaitForChild("Static"), TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.63
    })
    v22:Play()
    v23:Play()
    v23.Completed:Connect(function()
        v_u_24:Play()
        Spectate:WaitForChild("Static"):WaitForChild("Static"):WaitForChild("UIGradient").Enabled = true
    end)
end
Parent.MouseButton1Click:Connect(function()
    if not Black.Visible or Black.Transparency == 1 then
        PlayerGui:WaitForChild("UI"):WaitForChild("sfx"):FindFirstChild("pop_up"):Play()
        v_u_25()
        Spectate.Visible = true
        LobbyUIContainer:WaitForChild("Settings").Visible = false
        LobbyUIContainer:WaitForChild("Currency").Visible = false
        LobbyUIContainer:WaitForChild("Buttons").Visible = false
        v_u_21(Spectate:WaitForChild("User"):WaitForChild("Display"))
    end
end)
Button.MouseButton1Click:Connect(function()
    Spectate.Visible = false
    LobbyUIContainer:WaitForChild("Currency").Visible = true
    LobbyUIContainer:WaitForChild("Buttons").Visible = true
end)
