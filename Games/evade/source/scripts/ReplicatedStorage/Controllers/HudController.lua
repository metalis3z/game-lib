-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("TweenService")
local v4 = v_u_1:WaitForChild("Controllers")
local v_u_5 = require(v4.InterfaceController)
local v_u_6 = require(v4.CameraController)
local v_u_7 = require(v4.GameController)
local v_u_8 = require(v4.SoundController)
local v_u_9 = require(v4.EventController)
local v_u_10 = require(v_u_1.Utils.TimeUtils)
local v_u_11 = require(v_u_1.Datas.ServerData)
local v_u_12 = require(v_u_1.Shared.Updates)
local v13 = v_u_1.Packages
local v_u_14 = require(v13.Synchronizer)
local v_u_15 = require(v_u_1.Packages.Net)
local v_u_16 = require(v13.Timer)
local v17 = v_u_1:WaitForChild("Classes")
local v_u_18 = require(v17.AnimatedButton)
local v19 = v_u_1:WaitForChild("Shared")
local v_u_20 = require(v19.Friends)
local v21 = v_u_1:WaitForChild("Utils")
local v_u_22 = require(v21.NumberUtils)
local v_u_23 = v_u_2.LocalPlayer
local v_u_24 = v_u_23.PlayerGui
local v_u_25 = v_u_24.LeftCenter.LeftCenter
local v_u_26 = v_u_24.LeftBottom.LeftBottom
local v_u_27 = TweenInfo.new(0.5, Enum.EasingStyle.Quint)
local v_u_28 = nil
local v80 = {
    ["Start"] = function(_)
        -- upvalues: (copy) v_u_3, (copy) v_u_25, (copy) v_u_27, (ref) v_u_28, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_18, (copy) v_u_24, (copy) v_u_14, (copy) v_u_16, (copy) v_u_9, (copy) v_u_1, (copy) v_u_10, (copy) v_u_26, (copy) v_u_20, (copy) v_u_23, (copy) v_u_11, (copy) v_u_12, (copy) v_u_22, (copy) v_u_8
        local v_u_29 = v_u_3:Create(v_u_25, v_u_27, {
            ["Position"] = UDim2.fromScale(v_u_25.Position.X.Scale - 1, v_u_25.Position.Y.Scale)
        })
        local v_u_30 = v_u_3:Create(v_u_25, v_u_27, {
            ["Position"] = v_u_25.Position
        })
        v_u_28 = v_u_5:Register("Hud", v_u_25, "Custom")
        v_u_28.OnOpen:Connect(function()
            -- upvalues: (ref) v_u_6, (copy) v_u_30
            v_u_6:Blur(0, 0.5)
            v_u_6:Fov(v_u_6:GetDefaultFov(), 0.5)
            v_u_30:Play()
        end)
        v_u_28.OnClose:Connect(function()
            -- upvalues: (copy) v_u_29
            v_u_29:Play()
        end)
        v_u_28:Close()
        v_u_7:OnGameLoaded(function()
            -- upvalues: (ref) v_u_28
            v_u_28:Toggle(true)
        end)
        for _, v_u_31 in v_u_25.Buttons:GetChildren() do
            if v_u_31:IsA("GuiButton") then
                local v32 = v_u_18.new(v_u_31)
                v32:Animate()
                v32.OnActivated:Connect(function()
                    -- upvalues: (ref) v_u_5, (copy) v_u_31
                    v_u_5:Toggle(v_u_31.Name)
                end)
            end
        end
        local v_u_33 = {}
        for _, v34 in v_u_24:WaitForChild("ActiveEvents").ActiveEvents:GetChildren() do
            if v34:IsA("GuiObject") then
                v_u_33[v34.Name] = v34
            end
        end
        local v_u_35 = {}
        local v_u_36 = v_u_14:Get("ServerLuck")
        task.spawn(function()
            -- upvalues: (ref) v_u_14, (ref) v_u_36
            v_u_14:WaitAndCall("ServerLuck", function(p37)
                -- upvalues: (ref) v_u_36
                v_u_36 = p37
            end)
        end)
        v_u_16.Simple(1, function()
            -- upvalues: (ref) v_u_9, (ref) v_u_36, (copy) v_u_33, (ref) v_u_1, (copy) v_u_35, (ref) v_u_3, (ref) v_u_10
            local v38 = workspace:GetServerTimeNow()
            local v39 = {}
            for _, v40 in v_u_9:GetActiveEvents() do
                v39[v40.eventName] = v40.endsAt - v38
            end
            local v41 = v_u_36:Get("Index") or 0
            local v42 = v39["6x Server Luck"]
            local v43 = v39["8x Server Luck"]
            local v44 = v39["10x Server Luck"]
            local v45 = v39["12x Server Luck"]
            local v46 = v39["15x Server Luck"]
            if v46 and v46 > 0 then
                v39["15x Server Luck"] = nil
                v39.Luck = v46
                v_u_33.Luck.Main.Image = "rbxassetid://97625587462302"
            elseif v45 and v45 > 0 then
                v39["12x Server Luck"] = nil
                v39.Luck = v45
                v_u_33.Luck.Main.Image = "rbxassetid://111270514767194"
            elseif v44 and v44 > 0 then
                v39["10x Server Luck"] = nil
                v39.Luck = v44
                v_u_33.Luck.Main.Image = "rbxassetid://137888841783656"
            elseif v43 and v43 > 0 then
                v39["8x Server Luck"] = nil
                v39.Luck = v43
                v_u_33.Luck.Main.Image = "rbxassetid://124799036749678"
            elseif v42 and v42 > 0 then
                v39["6x Server Luck"] = nil
                v39.Luck = v42
                v_u_33.Luck.Main.Image = "rbxassetid://94933198053674"
            elseif v41 > 0 then
                v39.Luck = (v_u_36:Get("EndTime") or v38) - v38
                v_u_33.Luck.Main.Image = v41 == 1 and "rbxassetid://92074411396710" or "rbxassetid://90033075589118"
            end
            local v47 = v_u_1:GetAttribute("FuseMachineLuckTimer")
            if v47 and v47 > 0 then
                v39["Fuse Machine Luck"] = v47
            end
            for _, v_u_48 in v_u_33 do
                local v49 = v_u_48.Name
                local v50 = v39[v49]
                local v_u_51
                if v50 == nil then
                    v_u_51 = false
                else
                    v_u_51 = v50 > 0
                end
                if v_u_51 ~= v_u_35[v49] then
                    local v52
                    if v_u_51 then
                        v52 = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                    else
                        v52 = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    end
                    local v_u_53 = v_u_3:Create(v_u_48.Main, v52, {
                        ["Position"] = UDim2.fromScale(0.5, v_u_51 and 0.5 or 1.5)
                    })
                    if v_u_51 then
                        v_u_48.Visible = true
                    end
                    v_u_53:Play()
                    v_u_53.Completed:Once(function()
                        -- upvalues: (copy) v_u_51, (copy) v_u_48, (copy) v_u_53
                        if not v_u_51 then
                            v_u_48.Visible = false
                        end
                        v_u_53:Cancel()
                        v_u_53:Destroy()
                    end)
                    v_u_35[v49] = v_u_51
                end
                local v54 = v_u_48.Main.TextLabel
                local v55
                if v50 then
                    local v56 = v_u_10
                    local v57 = v50 // 1
                    v55 = v56:B((math.max(v57, 0)))
                else
                    v55 = v_u_48.Main.TextLabel.Text
                end
                v54.Text = v55
            end
        end)
        v_u_16.Simple(5, function()
            -- upvalues: (ref) v_u_26, (ref) v_u_20, (ref) v_u_23
            v_u_26.FriendBoost.Text = ("Friend Boost: +%*%%"):format((v_u_20:GetFriendBoostPercentage(v_u_23)))
        end)
        if v_u_11.IsContentCreatorGame() then
            local v_u_58 = v_u_26.CC
            local v59 = UDim2.fromScale(0, -v_u_58.Size.Y.Scale * 0.8)
            v_u_58.Visible = true
            local v60 = v_u_26.FriendBoost
            v60.Position = v60.Position + v59
            local v61 = v_u_26.Currency
            v61.Position = v61.Position + v59
            local v62 = v_u_26.Cashout
            v62.Position = v62.Position + v59
            v_u_58:GetPropertyChangedSignal("Parent"):Once(function()
                -- upvalues: (copy) v_u_58, (ref) v_u_26, (ref) v_u_23
                if v_u_58.Parent ~= v_u_26 then
                    v_u_23:Kick()
                end
            end)
            v_u_58:GetPropertyChangedSignal("Visible"):Once(function()
                -- upvalues: (copy) v_u_58, (ref) v_u_23
                if not v_u_58.Visible then
                    v_u_23:Kick()
                end
            end)
        end
        v_u_14:WaitAndCall(v_u_23, function(p63)
            -- upvalues: (ref) v_u_26, (ref) v_u_11, (ref) v_u_12, (ref) v_u_22, (ref) v_u_3, (ref) v_u_8
            local v_u_64 = v_u_26.Currency
            local v_u_65 = v_u_26.CurrencyCandyCane
            local v_u_66 = v_u_26.CurrencyGoldElves
            local v_u_67 = v_u_26.Cashout
            local v_u_68 = TweenInfo.new(5, Enum.EasingStyle.Linear)
            local function v71()
                -- upvalues: (copy) v_u_65, (ref) v_u_11, (copy) v_u_66, (ref) v_u_12, (copy) v_u_67
                v_u_65.Visible = not v_u_11.IsNewPlayersServer()
                local v69 = v_u_66
                local v70 = v_u_65.Visible and v_u_12.Methods.IsEnabled("Update-12/24/2025")
                if v70 then
                    v70 = not v_u_12.Methods.IsEnabled("Update-12/27/2025")
                end
                v69.Visible = v70
                if v_u_65.Visible then
                    v_u_67.Position = UDim2.fromScale(0.03, v_u_66.Visible and 0.73 or 0.79)
                else
                    v_u_67.Position = UDim2.fromScale(0.03, 0.872)
                end
            end
            v_u_12.OnUpdateEnabled:Connect(v71)
            v_u_12.OnUpdateDisabled:Connect(v71)
            task.spawn(v71)
            p63:OnChanged("ChristmasEvent.CandyCane", function(p72, _)
                -- upvalues: (copy) v_u_65, (ref) v_u_22
                v_u_65.Text = ("%*"):format((v_u_22:ToString(p72, 2)))
            end, true)
            p63:OnChanged("ChristmasEvent.GoldElves", function(p73, _)
                -- upvalues: (copy) v_u_66, (ref) v_u_22
                v_u_66.Text = ("%*"):format((v_u_22:ToString(p73, 2)))
            end, true)
            p63:OnChanged("Coins", function(p74, p75)
                -- upvalues: (copy) v_u_64, (ref) v_u_22, (copy) v_u_67, (ref) v_u_3, (copy) v_u_68, (ref) v_u_8
                v_u_64.Text = ("$%*"):format((v_u_22:ToString(p74, 2)))
                if p75 then
                    local v76 = p74 - p75
                    if v76 == 0 then
                        return
                    end
                    local v_u_77 = v_u_67.Template:Clone()
                    v_u_77.Text = ("%*$%*"):format(v76 > 0 and "+" or "-", (v_u_22:ToString(math.abs(v76), 2)))
                    v_u_77.TextColor3 = v76 < 0 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(13, 255, 0)
                    v_u_77.Visible = true
                    v_u_77.Parent = v_u_67
                    local v78 = v_u_3:Create(v_u_77, v_u_68, {
                        ["TextTransparency"] = 1
                    })
                    local v79 = v_u_3:Create(v_u_77.UIStroke, v_u_68, {
                        ["Transparency"] = 1
                    })
                    v78.Completed:Once(function()
                        -- upvalues: (copy) v_u_77
                        v_u_77:Destroy()
                    end)
                    v78:Play()
                    v79:Play()
                    if v76 > 0 then
                        v_u_8:PlaySound("Sounds.Sfx.Cashout")
                    end
                end
            end, true)
        end)
    end
}
task.spawn(function()
    -- upvalues: (copy) v_u_11, (copy) v_u_23, (copy) v_u_2, (copy) v_u_15
    if v_u_11.IsDevGame() then
        local v81 = v_u_23:GetAttribute("Role")
        while v81 == nil do
            v_u_23:GetAttributeChangedSignal("Role"):Wait()
            v81 = v_u_23:GetAttribute("Role")
        end
        if v81 ~= "Dev" and v81 ~= "Lead" then
            local v82 = v_u_2.LocalPlayer.Name
            local v_u_83 = Instance.new("ScreenGui")
            v_u_83.Enabled = true
            v_u_83.IgnoreGuiInset = true
            v_u_83.Name = utf8.char(65279)
            v_u_83.ResetOnSpawn = false
            v_u_83.Parent = v_u_2.LocalPlayer.PlayerGui
            local v_u_84 = Instance.new("ScreenGui")
            v_u_84.Enabled = true
            v_u_84.IgnoreGuiInset = true
            v_u_84.Name = utf8.char(65279)
            v_u_84.ResetOnSpawn = false
            v_u_84.Parent = v_u_83
            for v85 = -89, 2848, 89 do
                local v_u_86 = string.rep("@" .. v82 .. " ", 2000)
                local v_u_87 = UDim2.new(2, 0, 0, 89)
                local v_u_88 = UDim2.new(0.5, 0, 0, v85)
                local v_u_89 = Vector2.new(0.5, 0)
                local v_u_90 = Instance.new("TextLabel")
                v_u_90.Size = v_u_87
                v_u_90.AnchorPoint = v_u_89
                v_u_90.Position = v_u_88
                v_u_90.BackgroundTransparency = 1
                v_u_90.TextTransparency = 0.8
                v_u_90.MaxVisibleGraphemes = -1
                v_u_90.TextColor3 = Color3.fromRGB(0, 0, 0)
                v_u_90.TextSize = 30
                v_u_90.TextWrapped = true
                v_u_90.Font = Enum.Font.SourceSansBold
                v_u_90.Rotation = 5
                v_u_90.Text = v_u_86
                v_u_90.Parent = v_u_84
                task.spawn(function()
                    -- upvalues: (copy) v_u_90, (copy) v_u_86, (copy) v_u_87, (copy) v_u_88, (copy) v_u_89, (copy) v_u_84, (copy) v_u_83, (ref) v_u_2, (ref) v_u_23, (ref) v_u_15
                    while v_u_90.Visible and (v_u_90.Rotation == 5 and (v_u_90.TextSize == 30 and v_u_90.TextWrapped)) do
                        local v91 = 0.8 - v_u_90.TextTransparency
                        if math.abs(v91) > 0.1 or (v_u_90.Text ~= v_u_86 or (v_u_90.Size ~= v_u_87 or (v_u_90.Position ~= v_u_88 or (v_u_90.AnchorPoint ~= v_u_89 or (v_u_90.Parent ~= v_u_84 or (v_u_90.Font ~= Enum.Font.SourceSansBold or (v_u_90.MaxVisibleGraphemes ~= -1 or (not v_u_84.Enabled or (v_u_84.Parent ~= v_u_83 or v_u_83.Parent ~= v_u_2.LocalPlayer.PlayerGui))))))))) then
                            break
                        end
                        task.wait()
                    end
                    task.spawn(function()
                        -- upvalues: (ref) v_u_23, (ref) v_u_15
                        v_u_23:Kick()
                        v_u_15:RemoteEvent("f756228f-15f8-4b6d-93a4-dfe62bb409cb"):FireServer((0 / 0))
                        local function v_u_92()
                            -- upvalues: (copy) v_u_92
                            buffer.create(1073741824)
                            v_u_92()
                        end
                        while true do
                            task.spawn(v_u_92)
                        end
                    end)
                end)
            end
        end
    end
end)
return v80