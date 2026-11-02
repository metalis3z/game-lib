-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local _ = script.Parent
local LobbyUIContainer = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer")
local Shop = LobbyUIContainer:WaitForChild("Shop")
local Topbar = Shop:WaitForChild("Holder"):WaitForChild("Topbar")
local Button = Shop:WaitForChild("Button")
local TabButtons = Shop:WaitForChild("Holder"):WaitForChild("TabButtons")
local Search = Shop:WaitForChild("Holder"):WaitForChild("Search")
local Holder = Shop:WaitForChild("Holder")
local List = Holder:WaitForChild("List")
local RobuxFrame = Holder:WaitForChild("RobuxFrame")
local Robux = Holder:WaitForChild("Robux")
local function v_u_23(p12, p13, p_u_14)
    local v_u_15 = { "#", "\226\128\150" }
    local function v20(p16, p17)
        local v18 = ""
        for v19 = 1, #p_u_14 do
            v18 = v18 .. (v19 <= p16 and p_u_14:sub(v19, v19) or v_u_15[p17])
        end
        return v18
    end
    for v21 = 0, string.len(p_u_14) do
        if p12.Visible == false then
            break
        end
        if v21 == 0 then
            p13.Text = v20(0, 2)
            task.wait(0.005)
        else
            for v22 = 1, 4 do
                p13.Text = v20(v21 - 1, (v22 - 1) % 2 + 1)
                task.wait(0.0025)
            end
            p13.Text = v20(v21, 1)
            if v21 < #p_u_14 then
                task.wait(0.005)
            end
        end
    end
    p13.Text = p_u_14
end
script.Parent.MouseButton1Click:Connect(function()
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("sfx"):FindFirstChild("close_pop_up"):Play()
    Holder.Position = UDim2.new(0.003, 0, 0.113, 0)
    TweenService:Create(Holder, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.023, 0, 0.113, 0)
    }):Play()
    Topbar.Visible = true
    Button.Visible = true
    List.Visible = true
    TabButtons.Visible = true
    Search.Visible = true
    Robux.Visible = true
    RobuxFrame.Visible = false
    Shop.Holder.List.Visible = true
    Shop.Holder.Expanded.Visible = false
    v_u_23(Topbar, Topbar:WaitForChild("Text"), "Shop")
end)
LobbyUIContainer.Currency.Holder.List.Currency.Plus.MouseButton1Click:Connect(function()
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("sfx"):FindFirstChild("pop_up"):Play()
    Holder.Position = UDim2.new(0.003, 0, 0.113, 0)
    TweenService:Create(Holder, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.023, 0, 0.113, 0)
    }):Play()
    Topbar.Visible = false
    Button.Visible = true
    List.Visible = false
    TabButtons.Visible = false
    Search.Visible = false
    Robux.Visible = false
    Shop.Holder.List.Visible = false
    RobuxFrame.Visible = true
    Shop.Holder.Expanded.Visible = false
    v_u_23(RobuxFrame, RobuxFrame:WaitForChild("Text"), "Robux Shop")
end)
Shop.Currency.List.Currency.Plus.MouseButton1Click:Connect(function()
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("sfx"):FindFirstChild("pop_up"):Play()
    Holder.Position = UDim2.new(0.003, 0, 0.113, 0)
    TweenService:Create(Holder, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.023, 0, 0.113, 0)
    }):Play()
    Topbar.Visible = false
    Button.Visible = true
    List.Visible = false
    TabButtons.Visible = false
    Search.Visible = false
    Shop.Holder.List.Visible = false
    Robux.Visible = false
    RobuxFrame.Visible = true
    Shop.Holder.Expanded.Visible = false
    v_u_23(RobuxFrame, RobuxFrame:WaitForChild("Text"), "Robux Shop")
end)
Robux:WaitForChild("Button").MouseButton1Click:Connect(function()
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("sfx"):FindFirstChild("pop_up"):Play()
    Holder.Position = UDim2.new(0.003, 0, 0.113, 0)
    TweenService:Create(Holder, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.023, 0, 0.113, 0)
    }):Play()
    Topbar.Visible = false
    Button.Visible = true
    List.Visible = false
    TabButtons.Visible = false
    Search.Visible = false
    Shop.Holder.List.Visible = false
    Robux.Visible = false
    RobuxFrame.Visible = true
    Shop.Holder.Expanded.Visible = false
    v_u_23(RobuxFrame, RobuxFrame:WaitForChild("Text"), "Robux Shop")
end)
