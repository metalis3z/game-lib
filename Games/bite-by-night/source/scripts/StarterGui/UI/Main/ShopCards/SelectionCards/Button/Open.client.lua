-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local Shop = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer"):WaitForChild("Shop")
require(game:GetService("ReplicatedStorage").Characters.Springtrap.Normal.Configuration)
local LobbyUIContainer = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer")
local Parent = script.Parent
local List = Shop:WaitForChild("Holder"):WaitForChild("List")
local Expanded = Shop:WaitForChild("Holder"):WaitForChild("Expanded")
local Topbar = Shop:WaitForChild("Holder"):WaitForChild("Topbar")
local Back = Shop:WaitForChild("Button"):WaitForChild("Back")
local Back_0 = Expanded:WaitForChild("Back")
local TabButtons = Shop:WaitForChild("Holder"):WaitForChild("TabButtons")
local Purchase = Shop:WaitForChild("Holder"):WaitForChild("Purchase")
local Search = Shop:WaitForChild("Holder"):WaitForChild("Search")
local Robux = Shop:WaitForChild("Holder"):WaitForChild("Robux")
LobbyUIContainer:WaitForChild("Settings")
game.Workspace:WaitForChild("MAPS"):WaitForChild("ShopModel"):WaitForChild("CameraPart2")
local Black = LobbyUIContainer:WaitForChild("Black")
TweenService:Create(Black, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
    ["Transparency"] = 0
})
TweenService:Create(Black, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
    ["Transparency"] = 1
})
local function v_u_28(p16, p17)
    local Text = script.Parent:FindFirstChild("NameText").Text
    local v_u_19 = { "#", "\226\128\150" }
    local function v24(p20, p21)
        local v22 = ""
        for v23 = 1, #Text do
            v22 = v22 .. (v23 <= p20 and Text:sub(v23, v23) or v_u_19[p21])
        end
        return v22
    end
    local v25 = p17 or 0.005
    for v26 = 0, string.len(Text) do
        if v26 == 0 then
            p16.Text = v24(0, 2)
            task.wait(v25)
        else
            for v27 = 1, 4 do
                p16.Text = v24(v26 - 1, (v27 - 1) % 2 + 1)
                task.wait(0.0025)
            end
            p16.Text = v24(v26, 1)
            if v26 < #Text then
                task.wait(v25)
            end
        end
    end
    p16.Text = Text
end
Parent.MouseButton1Click:Connect(function()
    Robux.Visible = false
    Expanded:WaitForChild("Render").Position = UDim2.new(0.185, 0, -0.024, 0)
    Expanded:WaitForChild("Render"):FindFirstChild("Render").ImageTransparency = 1
    Expanded:WaitForChild("Map").ImageTransparency = 1
    Expanded:WaitForChild("Map").ImageTransparency = 1
    Shop:WaitForChild("Holder").Position = UDim2.new(0.003, 0, 0.113, 0)
    TweenService:Create(Expanded:WaitForChild("Render"), TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.265, 0, -0.024, 0)
    }):Play()
    TweenService:Create(Expanded:WaitForChild("Render"):FindFirstChild("Render"), TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0
    }):Play()
    TweenService:Create(Expanded:WaitForChild("Map"), TweenInfo.new(1.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0
    }):Play()
    TweenService:Create(Shop:WaitForChild("Holder"), TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.023, 0, 0.113, 0)
    }):Play()
    Topbar.Visible = false
    Back.Visible = false
    List.Visible = false
    TabButtons.Visible = false
    Search.Visible = false
    Purchase.Visible = true
    Expanded:WaitForChild("Page"):WaitForChild("UIPageLayout"):JumpTo(Expanded:WaitForChild("Page"):WaitForChild("Information"))
    Expanded.Visible = true
    Back_0.Visible = true
    v_u_28(Expanded:WaitForChild("NameText"))
end)
Back_0:WaitForChild("Button").MouseButton1Click:Connect(function()
    Robux.Visible = true
    Purchase.Visible = false
    Topbar.Visible = true
    Back.Visible = true
    List.Visible = true
    TabButtons.Visible = true
    Search.Visible = true
    Expanded:WaitForChild("Page"):WaitForChild("UIPageLayout"):JumpTo(Expanded:WaitForChild("Page"):WaitForChild("Information"))
    Expanded.Visible = false
    Back_0.Visible = false
end)
