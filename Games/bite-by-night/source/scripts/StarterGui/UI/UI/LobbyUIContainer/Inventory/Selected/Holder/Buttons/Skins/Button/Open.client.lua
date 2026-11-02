-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local _ = script.Parent
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local Inventory = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer"):WaitForChild("Inventory")
local Selected = Inventory:WaitForChild("Selected")
local Holder = Selected:WaitForChild("Holder")
local Cosmetics = Selected:WaitForChild("Cosmetics")
local Back = Cosmetics:WaitForChild("Back")
local List = Inventory:WaitForChild("List")
local BackgroundL = Inventory:WaitForChild("BackgroundL")
local Button = Inventory:WaitForChild("Button")
local CFrame = game.Workspace:WaitForChild("MAPS"):WaitForChild("InventoryModel"):WaitForChild("CameraPart").CFrame
local function v_u_24(p12, p13)
    local Text = p12.Text
    local v_u_15 = { "#", "\226\128\150" }
    local function v20(p16, p17)
        local v18 = ""
        for v19 = 1, #Text do
            v18 = v18 .. (v19 <= p16 and Text:sub(v19, v19) or v_u_15[p17])
        end
        return v18
    end
    local v21 = p13 or 0.005
    for v22 = 0, string.len(Text) do
        if Cosmetics.Visible == false then
            break
        end
        if v22 == 0 then
            p12.Text = v20(0, 2)
            task.wait(v21)
        else
            for v23 = 1, 4 do
                p12.Text = v20(v22 - 1, (v23 - 1) % 2 + 1)
                task.wait(0.0025)
            end
            p12.Text = v20(v22, 1)
            if v22 < #Text then
                task.wait(v21)
            end
        end
    end
    p12.Text = Text
end
script.Parent.MouseButton1Click:Connect(function()
    PlayerGui:FindFirstChild("UI").sfx.open:Play()
    List:WaitForChild("Topbar"):WaitForChild("Text").Text = "Inventory"
    Selected.Position = UDim2.new(1, 0, 0.5, 0)
    Holder.Visible = false
    Cosmetics.Visible = true
    Button.Visible = false
    BackgroundL.Visible = false
    List.Visible = false
    TweenService:Create(Selected, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.974, 0, 0.5, 0)
    }):Play()
    TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["CFrame"] = CFrame * CFrame.new(-4, 0.2, -4) * CFrame.Angles(0, -0.12217304763960307, 0)
    }):Play()
    v_u_24(Cosmetics:WaitForChild("Text"))
end)
Back:WaitForChild("Button").MouseButton1Click:Connect(function()
    Selected.Position = UDim2.new(1, 0, 0.5, 0)
    Cosmetics:WaitForChild("Text").Text = "Wardrobe"
    Holder.Visible = true
    Cosmetics.Visible = false
    Button.Visible = true
    BackgroundL.Visible = true
    List.Visible = true
    local v25 = {
        ["CFrame"] = CFrame
    }
    TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v25):Play()
    TweenService:Create(Selected, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.974, 0, 0.5, 0)
    }):Play()
    v_u_24(List:WaitForChild("Topbar"):WaitForChild("Text"))
end)
Back:WaitForChild("Button").MouseButton1Click:Connect(function()
    v_u_24(Selected:WaitForChild("Holder"):WaitForChild("Name"))
end)
