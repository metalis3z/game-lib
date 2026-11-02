-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui
local LobbyUIContainer = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer")
local Settings = LobbyUIContainer:WaitForChild("Settings")
local Canvas = Settings:WaitForChild("Canvas")
local Button = Settings:WaitForChild("Holder"):WaitForChild("Topbar"):WaitForChild("Close"):WaitForChild("Button")
LobbyUIContainer:WaitForChild("Buttons"):WaitForChild("Holder")
local v_u_7 = false
local _ = { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0), NumberSequenceKeypoint.new(1, 1) }
local v_u_8 = Instance.new("NumberValue")
v_u_8.Value = 0
v_u_8:GetPropertyChangedSignal("Value"):Connect(function()
    if Canvas ~= nil then
        Canvas.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1 + v_u_8.Value, 0), NumberSequenceKeypoint.new(1, 1) })
    end
end)
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
    v_u_7 = false
end
local function v_u_24()
    v_u_7 = true
    Settings:WaitForChild("Holder").Parent = Canvas
    Settings:WaitForChild("Blood").Parent = Canvas
    Settings:WaitForChild("Blood2").Parent = Canvas
    Settings:WaitForChild("Shadow").Parent = Canvas
    local v22 = TweenService:Create(v_u_8, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        ["Value"] = -1
    })
    local v23 = TweenService:Create(Canvas, TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["GroupTransparency"] = 1
    })
    v22:Play()
    v23:Play()
    v23.Completed:Connect(function()
        v_u_7 = false
        Canvas:WaitForChild("Holder").Parent = Settings
        Canvas:WaitForChild("Blood").Parent = Settings
        Canvas:WaitForChild("Blood2").Parent = Settings
        Canvas:WaitForChild("Shadow").Parent = Settings
        Canvas.GroupTransparency = 0
        Settings.Visible = false
    end)
end
local function v_u_25()
    v_u_7 = true
    Settings:WaitForChild("Holder"):WaitForChild("Topbar"):WaitForChild("Text").Text = "Settings"
    Settings:WaitForChild("Holder"):WaitForChild("Dim").Transparency = 0
    Settings:WaitForChild("Blood").ImageTransparency = 1
    Settings:WaitForChild("Blood2").ImageTransparency = 1
    Settings.Visible = true
    Settings.Size = UDim2.new(1, 0, 1, 0)
    TweenService:Create(Settings, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.9, 0, 0.9, 0)
    }):Play()
    TweenService:Create(Settings:WaitForChild("Holder"):WaitForChild("Dim"), TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
    TweenService:Create(Settings:WaitForChild("Blood"), TweenInfo.new(1.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.43
    }):Play()
    TweenService:Create(Settings:WaitForChild("Blood2"), TweenInfo.new(1.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0
    }):Play()
    v_u_21(Settings:WaitForChild("Holder"):WaitForChild("Topbar"):WaitForChild("Text"))
end
script.Parent.MouseButton1Click:Connect(function()
    if v_u_7 == true then
        return
    elseif Settings.Visible == false then
        PlayerGui:WaitForChild("UI"):WaitForChild("sfx"):FindFirstChild("pop_up"):Play()
        v_u_25()
    else
        PlayerGui:WaitForChild("UI"):WaitForChild("sfx"):FindFirstChild("close_pop_up"):Play()
        v_u_24()
    end
end)
Button.MouseButton1Click:Connect(function()
    v_u_24()
end)
