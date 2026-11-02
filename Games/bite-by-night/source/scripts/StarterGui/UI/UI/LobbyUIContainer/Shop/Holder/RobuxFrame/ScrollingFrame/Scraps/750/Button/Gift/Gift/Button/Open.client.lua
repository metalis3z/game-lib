-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local Parent = script.Parent
local Shop = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer"):WaitForChild("Shop")
Shop:WaitForChild("Holder")
local Gifting = Shop:WaitForChild("Gifting")
local Holder = Gifting:WaitForChild("Holder")
local Back = Gifting:WaitForChild("Back")
local function v_u_19(p7, p8)
    local Text = p7.Text
    local v_u_10 = { "#", "\226\128\150" }
    local function v15(p11, p12)
        local v13 = ""
        for v14 = 1, #Text do
            v13 = v13 .. (v14 <= p11 and Text:sub(v14, v14) or v_u_10[p12])
        end
        return v13
    end
    local v16 = p8 or 0.005
    for v17 = 0, #Text do
        if v17 == 0 then
            p7.Text = v15(0, 2)
            task.wait(v16)
        else
            for v18 = 1, 4 do
                p7.Text = v15(v17 - 1, (v18 - 1) % 2 + 1)
                task.wait(0.0025)
            end
            p7.Text = v15(v17, 1)
            if v17 < #Text then
                task.wait(v16)
            end
        end
    end
    p7.Text = Text
end
Parent.MouseButton1Click:Connect(function()
    Gifting.Visible = true
    Holder.Visible = true
    Back.Visible = true
    Gifting:WaitForChild("BG").BackgroundTransparency = 1
    Holder.Size = UDim2.new(0.495, 0, 0.495, 0)
    Holder:WaitForChild("Dim").Transparency = 0
    TweenService:Create(Gifting:WaitForChild("BG"), TweenInfo.new(1.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.5
    }):Play()
    TweenService:Create(Holder, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.48, 0, 0.48, 0)
    }):Play()
    TweenService:Create(Holder:WaitForChild("Dim"), TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
    v_u_19(Holder:WaitForChild("Text"))
end)
Back:WaitForChild("Button").MouseButton1Click:Connect(function()
    Holder.Visible = false
    Back.Visible = false
    local v20 = TweenService:Create(Gifting:WaitForChild("BG"), TweenInfo.new(1.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    })
    v20:Play()
    v20.Completed:Connect(function()
        Gifting.Visible = false
    end)
end)
