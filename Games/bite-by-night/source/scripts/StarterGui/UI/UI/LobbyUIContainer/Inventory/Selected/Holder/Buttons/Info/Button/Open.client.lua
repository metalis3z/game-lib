-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local _ = script.Parent
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local Inventory = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer"):WaitForChild("Inventory")
local Selected = Inventory:WaitForChild("Selected")
local Holder = Selected:WaitForChild("Holder")
local Information = Selected:WaitForChild("Information")
local Back = Information:WaitForChild("Back")
local List = Inventory:WaitForChild("List")
Inventory:WaitForChild("BackgroundL")
Inventory:WaitForChild("Button")
local _ = game.Workspace:WaitForChild("MAPS"):WaitForChild("InventoryModel"):WaitForChild("CameraPart").CFrame
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
        if Information.Visible == false then
            break
        end
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
script.Parent.MouseButton1Click:Connect(function()
    PlayerGui:FindFirstChild("UI").sfx.open:Play()
    List:WaitForChild("Topbar"):WaitForChild("Text").Text = "Inventory"
    Selected.Position = UDim2.new(1, 0, 0.5, 0)
    Holder.Visible = false
    Information.Visible = true
    TweenService:Create(Selected, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.974, 0, 0.5, 0)
    }):Play()
    v_u_21(Information:WaitForChild("Text"))
end)
Back:WaitForChild("Button").MouseButton1Click:Connect(function()
    Selected.Position = UDim2.new(1, 0, 0.5, 0)
    Information:WaitForChild("Text").Text = "Information"
    Holder.Visible = true
    Information.Visible = false
    TweenService:Create(Selected, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.974, 0, 0.5, 0)
    }):Play()
    v_u_21(List:WaitForChild("Topbar"):WaitForChild("Text"))
end)
Back:WaitForChild("Button").MouseButton1Click:Connect(function()
    v_u_21(Selected:WaitForChild("Holder"):WaitForChild("Name"))
end)
