-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(game.ReplicatedStorage.GlobalTypes)
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Debris")
local v_u_5 = game:GetService("UserInputService")
local v6 = game:GetService("Players")
local v_u_7 = require(v1.Modules.Network)
local v8 = require(v1.Modules.Misc.Trove)
local v_u_9 = require(v1.Modules.Misc.Signal)
local v_u_10 = require(v1.Modules.Sounds)
local v_u_11 = require(v1.Modules.Util)
local v_u_12 = require(v1.Systems.Player.Miscellaneous.NotificationDisplay)
local v_u_13 = require(script.Parent.Parent.Meta.EventShopMeta)
local v_u_14 = require(script.Dialog)
local v_u_15 = v_u_2:IsStudio()
local v_u_16 = script:GetFullName()
local v_u_17 = script:FindFirstChild("EventUI").EventShop
local v_u_18 = {
    ["Normal"] = "Bribe Nosferatu",
    ["MakeSure"] = "Are you sure?",
    ["Processing"] = "PROCESSING..."
}
local v_u_19 = {
    ["Normal"] = "Purchase",
    ["MakeSure"] = "Are you sure?",
    ["Processing"] = "PROCESSING..."
}
local v_u_20 = Color3.fromRGB(177, 26, 28)
local v_u_21 = v6.LocalPlayer
local v_u_22
if v_u_21 then
    v_u_22 = v_u_21.PlayerGui
else
    v_u_22 = v_u_21
end
local v_u_23
if v_u_21 then
    v_u_23 = v_u_21:FindFirstChild("PlayerData")
else
    v_u_23 = v_u_21
end
local v_u_24
if v_u_21 then
    v_u_24 = v_u_21:GetMouse()
else
    v_u_24 = v_u_21
end
local v_u_25 = script.Presets
local v_u_26 = math.max
local v_u_27 = math.floor
local v_u_28 = math.clamp
local v_u_29 = os.time
local v_u_30 = task.delay
local v_u_31 = v1:WaitForChild("Assets")
local function v_u_35(p32)
    local v33 = v_u_31
    for _, v34 in string.split(p32, "/") do
        if not v33 then
            return nil
        end
        v33 = v33:FindFirstChild(v34)
    end
    return v33
end
local v_u_36 = nil
local function v_u_43()
    local v37 = nil
    local v38 = 0
    while true do
        while true do
            if typeof(v37) == "table" then
                return v37
            end
            v37 = v_u_7:FireServerConnection("GetCurrentStockAsync", "REMOTE_FUNCTION")
            if v37 then
                break
            end
            ::l4::
            v38 = v38 + 1
            if v38 >= 3 then
                assert(true, "bad message")
                if v_u_15 then
                    warn((("[%*]: Failed to get current stock."):format(v_u_16)))
                end
                return nil
            end
            local v39 = ("Failed to get stock, retrying... (attempt #%*/%*)"):format(v38, 3)
            local v40 = type(v39) == "string"
            assert(v40, "bad message")
            if v_u_15 then
                warn((("[%*]: %*"):format(v_u_16, v39)))
            end
            task.wait(v38 * 2 + 1)
        end
        local v41
        if v37 then
            v41 = v37.Stock
        else
            v41 = v37
        end
        local v42 = v_u_36
        if v42 then
            v42 = v_u_36.Stock
        end
        if v41 ~= v42 then
            goto l4
        end
    end
end
local v158 = {
    ["__isInitialized"] = false,
    ["__internalTrove"] = v8.new(),
    ["__internalState"] = {
        ["isSureForPurchase"] = false,
        ["isProcessingRestockPurchase"] = false,
        ["isSureForSkinPurchase"] = false,
        ["isProcessingSkinPurchase"] = false,
        ["isSelectSkinDebounce"] = false,
        ["isDragging"] = false
    },
    ["_currentDialogThread"] = nil,
    ["ShopUI"] = nil,
    ["FirstTimeOpened"] = false,
    ["__switchDialogue"] = function(p_u_44, p45)
        print((("Setting dialog type to %*"):format(p45)))
        local v_u_46 = p_u_44.ShopUI.ConversionFrame.ConversationFrame.Display
        local v47 = v_u_14[p45]
        if typeof(v47) == "table" then
            v47 = v47[math.random(1, #v47)] or v47
        end
        if p_u_44._currentDialogThread then
            task.cancel(p_u_44._currentDialogThread)
            p_u_44._currentDialogThread = nil
        end
        v_u_46.Text = ""
        v_u_46.MaxVisibleGraphemes = 0
        v_u_46.Text = v47
        local v_u_48 = utf8.len(v47)
        if v_u_48 then
            local v_u_49 = 2 / v_u_48
            p_u_44._currentDialogThread = task.spawn(function()
                for v50 = 0, v_u_48 do
                    v_u_46.MaxVisibleGraphemes = v50
                    task.wait(v_u_49)
                end
                p_u_44._currentDialogThread = nil
            end)
        end
    end,
    ["__initializeUI"] = function(p_u_51)
        local v52 = v_u_17
        if v52 then
            v52 = v_u_17.Parent:Clone()
        end
        if v52 then
            local v53 = v52:FindFirstChild("EventShop")
            v53.Visible = false
            local v_u_54 = v_u_36 or v_u_43()
            if v_u_54 then
                v_u_36 = v_u_54
                local v_u_55 = v_u_26(v_u_54.Stock - v_u_54.PlayerAmountBought, 0)
                local v56 = v53.ConversionFrame.ConversionButton
                local v_u_57 = v56:FindFirstChild("Exchange")
                local v_u_58 = v56:FindFirstChild("Display")
                local v_u_59 = v56:FindFirstChild("RestockAmountDisplay")
                if v_u_59 then
                    v_u_59.Text = ("(%*/%*)"):format(v_u_55, v_u_54.Stock)
                end
                v53.InformationFrame.ExitButton.Activated:Connect(function()
                    p_u_51:__closeUI()
                end)
                local v_u_60 = v53.ConversionFrame.ConversionButton.RestockTimeDisplay
                local v_u_61 = 3600 - v_u_29() % 3600
                local v_u_62 = false
                p_u_51.__internalTrove:Connect(v_u_2.Heartbeat, function(p63)
                    if v_u_61 <= 0 and not v_u_62 then
                        v_u_62 = true
                        local v64, v65 = pcall(v_u_43)
                        if v64 and v65 then
                            v_u_60.Text = "Restocking!"
                            v_u_55 = v_u_26(v65.Stock - v65.PlayerAmountBought, 0)
                            v_u_61 = 3600 - v_u_29() % 3600
                            if v_u_59 then
                                v_u_59.Text = ("(%*/%*)"):format(v_u_55, v65.Stock)
                            end
                        end
                        v_u_62 = false
                    end
                    v_u_61 = v_u_26(v_u_61 - p63, 0)
                    local v66 = v_u_27(v_u_61 / 60)
                    local v67 = v_u_27(v_u_61 % 60)
                    local v68 = string.format("%02d:%02d", v66, v67)
                    if v_u_60.Text ~= v68 then
                        v_u_60.Text = v68
                    end
                end)
                local v69 = v_u_21
                if v69 then
                    v69 = v_u_21:FindFirstChild("PlayerData")
                end
                if v69 then
                    v69 = v69.EventCurrency:FindFirstChild("2025_MASQUERADE")
                end
                local v_u_70 = v53.ConversionFrame.CurrencyDisplay.CurrencyText
                if v69 then
                    local function v72(p71)
                        v_u_70.Text = v_u_11:ToCommas(p71)
                    end
                    v_u_70.Text = v_u_11:ToCommas(v69.Value)
                    p_u_51.__internalTrove:Connect(v69.Changed, v72)
                else
                    warn((("[%*]: Failed to get Event currency... not displaying!"):format((script:GetFullName()))))
                end
                v53.ConversionFrame.CurrencyDisplay.Visible = v69 ~= nil
                local v_u_73 = v53.ConversionFrame:FindFirstChild("DragBar")
                local v_u_74
                if v_u_73 then
                    v_u_74 = v_u_73:FindFirstChild("Dragger")
                else
                    v_u_74 = v_u_73
                end
                local v_u_75
                if v_u_74 then
                    v_u_75 = v_u_74:FindFirstChild("Title")
                else
                    v_u_75 = v_u_74
                end
                local v_u_76 = TweenInfo.new(0.1)
                local v_u_77 = 1
                local function v_u_88(p78)
                    if v_u_73 or v_u_74 then
                        local v79 = v_u_24 and v_u_24.X or 0
                        local v80 = v_u_73.AbsoluteSize.X
                        local v81 = (v79 - v_u_73.AbsolutePosition.X) / v80
                        local v82 = p78 and v_u_55 / 2
                        if not v82 then
                            local v83 = v_u_55
                            v82 = v_u_28((v83 - 0) * v81 + 0, 0, v83)
                        end
                        local v84 = v_u_27((v82 + 0.5) / 1) * 1
                        if v_u_77 ~= v84 then
                            v_u_10:Play("tick", {
                                ["Volume"] = 0.025
                            })
                            v_u_77 = v84
                            local v85 = v_u_55
                            local v86 = v_u_28(v_u_28((v_u_77 - 1) / (v85 - 1), 0, 1), 0, 1)
                            v_u_3:Create(v_u_74, v_u_76, {
                                ["Position"] = UDim2.fromScale(v86, 0.5)
                            }):Play()
                            if v_u_75 then
                                local v87 = v_u_77
                                v_u_75.Text = tostring(v87)
                            end
                            if v_u_57 then
                                v_u_57.Text = ("$%* -> %* Candy"):format(v_u_11:ToCommas(v_u_77 * 75), v_u_77)
                            end
                            if v_u_58 and p_u_51.__internalState.isSureForPurchase then
                                p_u_51.__internalState.isSureForPurchase = false
                                v_u_58.Text = v_u_18.Normal
                            end
                        end
                    end
                end
                if v_u_73 and v_u_74 then
                    local function v89()
                        p_u_51.__internalState.isDragging = true
                        v_u_10:Play("switch")
                        while task.wait() and p_u_51.__internalState.isDragging do
                            v_u_88()
                        end
                    end
                    local function v91(p90)
                        if p_u_51.__internalState.isDragging then
                            if p90.UserInputType == Enum.UserInputType.MouseButton1 or (p90.UserInputType == Enum.UserInputType.Touch or p90.UserInputType == Enum.UserInputType.Gamepad1 and p90.KeyCode == Enum.KeyCode.ButtonR2) then
                                p_u_51.__internalState.isDragging = false
                                v_u_10:Play("switch")
                            end
                        end
                    end
                    v_u_88(true)
                    p_u_51.__internalTrove:Connect(v_u_74.MouseButton1Down, v89)
                    p_u_51.__internalTrove:Connect(v_u_5.InputEnded, v91)
                end
                p_u_51.__internalTrove:Connect(v56.MouseButton1Down, function()
                    if v_u_58 and (not p_u_51.__internalState.isProcessingRestockPurchase and v_u_77 > 0) then
                        if p_u_51.__internalState.isSureForPurchase then
                            p_u_51.__internalState.isProcessingRestockPurchase = true
                            v_u_58.Text = v_u_18.Processing
                            if v_u_7:FireServerConnection("PurchaseStockAsync", "REMOTE_FUNCTION", v_u_77) then
                                v_u_55 = v_u_26(v_u_55 - v_u_77, 0)
                                if v_u_36 then
                                    local v92 = v_u_36
                                    v92.PlayerAmountBought = v92.PlayerAmountBought + v_u_77
                                end
                                if v_u_59 then
                                    v_u_59.Text = ("(%*/%*)"):format(v_u_55, v_u_54.Stock)
                                end
                            end
                            v_u_88(true)
                            v_u_58.Text = v_u_18.Normal
                            p_u_51.__internalState.isSureForPurchase = false
                            p_u_51.__internalState.isProcessingRestockPurchase = false
                        else
                            p_u_51.__internalState.isSureForPurchase = true
                            v_u_10:Play("switch")
                            v_u_58.Text = v_u_18.MakeSure
                        end
                    else
                        p_u_51:__switchDialogue("OutOfStock")
                        return
                    end
                end)
                local v_u_93 = v53.InformationFrame:FindFirstChild("Display")
                local v_u_94 = v53.InformationFrame:FindFirstChild("PurchaseFrame")
                if v_u_93 then
                    v_u_93.Gradient.Position = UDim2.fromScale(0, 1)
                end
                local v_u_95
                if v_u_93 then
                    v_u_95 = v_u_93:FindFirstChild("DisplayImage")
                else
                    v_u_95 = v_u_93
                end
                if v_u_95 then
                    v_u_95.Image = ""
                end
                if v_u_94 then
                    v_u_94.Character.Text = ""
                    v_u_94.Quote.Text = ""
                    v_u_94.CurrencyDisplay.Visible = false
                end
                local v96 = v53.ShopFrame:FindFirstChild("Main")
                local v_u_97 = v_u_94.PurchaseButton
                local v_u_98 = ""
                local v_u_99 = nil
                local v_u_100 = false
                local v_u_101 = nil
                local function v_u_139(p_u_102, p_u_103, p_u_104)
                    if v_u_23 then
                        local v105 = p_u_103.ReleaseDate
                        if v105 then
                            p_u_102.Lock.Amount.Text = v105
                            p_u_102.DisplayImage.Image = p_u_103.DisplayImage
                            p_u_102.DisplayImage.ImageTransparency = 0.75
                            p_u_102.Lock.ZIndex = 2
                            return
                        else
                            local v_u_106 = v_u_23 and v_u_23.Purchased.Skins:FindFirstChild(p_u_103.Cosmetic.Name) ~= nil and true or false
                            local v_u_107 = v_u_35(p_u_103.Cosmetic.Directory .. ("/%*"):format(p_u_103.Cosmetic.Name))
                            if v_u_107 then
                                local v108, v_u_109 = pcall(require, v_u_107:FindFirstChild("Config"))
                                if v108 then
                                    local v_u_110 = p_u_102.Lock:GetDescendants()
                                    local v_u_111 = v_u_23.EventCurrency:FindFirstChild("CurrentOwnedSurvivorSkins")
                                    local v_u_112 = p_u_103.RequiredSurvivorSkins
                                    if v_u_112 then
                                        if v105 or (not v_u_111 or v_u_111.Value >= v_u_112) then
                                            if v_u_111 and v_u_112 <= v_u_111.Value then
                                                p_u_102.Lock:Destroy()
                                            end
                                        else
                                            local v113 = p_u_102.Lock.Amount
                                            local v114 = v_u_112 - v_u_111.Value
                                            v113.Text = tostring(v114)
                                            p_u_102.DisplayImage.ImageTransparency = 0.75
                                            p_u_102.Lock.ZIndex = 2
                                            local v_u_115 = nil
                                            v_u_115 = p_u_51.__internalTrove:Connect(v_u_111.Changed, function(p116)
                                                local v117 = v_u_112 - p116
                                                if v117 <= 0 then
                                                    p_u_102.Lock:Destroy()
                                                    p_u_102.DisplayImage.ImageTransparency = 0
                                                    if v_u_115 then
                                                        v_u_115:Disconnect()
                                                        v_u_115 = nil
                                                        return
                                                    end
                                                else
                                                    p_u_102.Lock.Amount.Text = tostring(v117)
                                                end
                                            end)
                                        end
                                    else
                                        local v118 = ("No required survivor skins, removing lock on %*/%*..."):format(p_u_103.Cosmetic.Directory, p_u_103.Cosmetic.Name)
                                        local v119 = type(v118) == "string"
                                        assert(v119, "bad message")
                                        if v_u_15 then
                                            warn((("[%*]: %*"):format(v_u_16, v118)))
                                        end
                                        p_u_102.Lock:Destroy()
                                    end
                                    if v_u_106 then
                                        local v120 = p_u_102:FindFirstChild("DamnedCard")
                                        if v120 then
                                            v120:Destroy()
                                        end
                                        v_u_25.Outline:Clone().Parent = p_u_102
                                    end
                                    p_u_102.DisplayImage.Image = v_u_106 and v_u_109.RenderImage or p_u_103.DisplayImage
                                    local function v_u_134(p121)
                                        v_u_10:Play("switch")
                                        if v_u_111 and (v_u_112 and v_u_111.Value < v_u_112) then
                                            local v122 = v_u_12:DisplayNotification("You do not have enough survivor skins from the event!", Color3.fromRGB(203, 53, 53))
                                            if v122 then
                                                v122.Size = UDim2.new(0.65, 0, 0, 40)
                                            end
                                            for _, v123 in v_u_110 do
                                                local v124 = v123:IsA("TextLabel") and "TextColor3" or "ImageColor3"
                                                if v123:IsA("TextLabel") then
                                                    v123.TextColor3 = v_u_20
                                                elseif v123:IsA("ImageLabel") then
                                                    v123.ImageColor3 = v_u_20
                                                end
                                                v_u_3:Create(v123, TweenInfo.new(1), {
                                                    [v124] = Color3.fromRGB(255, 255, 255)
                                                }):Play()
                                            end
                                            return
                                        elseif (v_u_98 == p_u_104 or v_u_99 == p_u_102) and not p121 then
                                            return
                                        else
                                            v_u_98 = p_u_104
                                            v_u_99 = p_u_102
                                            if not p_u_51.__internalState.isSelectSkinDebounce then
                                                p_u_51.__internalState.isSelectSkinDebounce = true
                                                local v125 = v_u_106 and v_u_109.DisplayName
                                                if not v125 then
                                                    local v126 = v_u_109.DisplayName
                                                    v125 = string.gsub(v126, ".", "?")
                                                end
                                                local v127 = v_u_107 and v_u_107.Parent
                                                if v127 then
                                                    v127 = v_u_107.Parent.Name
                                                end
                                                v_u_95.Image = v_u_106 and v_u_109.RenderImage or p_u_103.DisplayImage
                                                v_u_94.Character.Text = ("%*, %*"):format(v125, v127 or "None")
                                                v_u_94.Quote.Text = v_u_109.Description
                                                v_u_93.Gradient.Position = UDim2.fromScale(0, 0)
                                                local v128 = v_u_3:Create(v_u_93.Gradient, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                    ["Position"] = UDim2.fromScale(0, 1)
                                                })
                                                v128:Play()
                                                p_u_51.__internalTrove:Add(v128)
                                                v_u_93.Outline.Visible = v_u_106
                                                v_u_93.DamnedCard.Visible = not v_u_106
                                                local v129 = v_u_97:FindFirstChild("Display")
                                                if v129 then
                                                    v129.Text = v_u_106 and "Owned" or "Purchase"
                                                end
                                                v_u_94.CurrencyDisplay.CurrencyText.Text = ("%*"):format(v_u_13.PriceTiers[p_u_103.PriceTier])
                                                v_u_94.CurrencyDisplay.Visible = true
                                                if v_u_101 then
                                                    v_u_101:Destroy()
                                                    v_u_101 = nil
                                                end
                                                v_u_100 = v_u_106
                                                v_u_101 = v_u_9.new()
                                                v_u_101:Connect(function(p130)
                                                    if p130 then
                                                        v_u_106 = p130
                                                        local v131 = p_u_102.DisplayImage:Clone()
                                                        v131.Name = "FAKE_DisplayImage"
                                                        v131.Parent = p_u_102
                                                        p_u_102.DisplayImage.Position = UDim2.fromScale(0, -1)
                                                        p_u_102.DisplayImage.Image = v_u_106 and v_u_109.RenderImage or p_u_103.DisplayImage
                                                        local v132 = v_u_3:Create(v131, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                                            ["Position"] = UDim2.fromScale(0, 1)
                                                        })
                                                        local v133 = v_u_3:Create(p_u_102.DisplayImage, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                                            ["Position"] = UDim2.fromScale(0, 0)
                                                        })
                                                        v132:Play()
                                                        v133:Play()
                                                        p_u_51.__internalTrove:Add(v132)
                                                        p_u_51.__internalTrove:Add(v133)
                                                        v_u_4:AddItem(v131, 1)
                                                        p_u_51.__internalTrove:Add(v_u_30(0.5, function()
                                                            v_u_134(true)
                                                        end))
                                                    end
                                                end)
                                                v_u_30(0.25, function()
                                                    p_u_51.__internalState.isSelectSkinDebounce = false
                                                end)
                                            end
                                        end
                                    end
                                    p_u_51.__internalTrove:Connect(p_u_102.Interact.MouseButton1Down, v_u_134)
                                else
                                    local v135 = ("Could not require cosmetic configuration file: %*/%*"):format(p_u_103.Cosmetic.Directory, p_u_103.Cosmetic.Name)
                                    local v136 = type(v135) == "string"
                                    assert(v136, "bad message")
                                    if v_u_15 then
                                        warn((("[%*]: %*"):format(v_u_16, v135)))
                                    end
                                end
                            else
                                local v137 = ("Could not find cosmetic with directory: %*/%*"):format(p_u_103.Cosmetic.Directory, p_u_103.Cosmetic.Name)
                                local v138 = type(v137) == "string"
                                assert(v138, "bad message")
                                if v_u_15 then
                                    warn((("[%*]: %*"):format(v_u_16, v137)))
                                end
                                return
                            end
                        end
                    else
                        assert(true, "bad message")
                        if v_u_15 then
                            warn((("[%*]: Failed to find clients data."):format(v_u_16)))
                        end
                    end
                end
                local function v_u_146(p140, p141, p142)
                    for v143, v144 in p141 do
                        local v145 = p140:FindFirstChild((tostring(v143)))
                        if typeof(v143) == "string" and v145 then
                            v_u_146(v145, v144, p142 .. ("/%*"):format(v143))
                        else
                            v_u_139(v145, v144, p142 .. ("/%*"):format(v143))
                        end
                    end
                end
                p_u_51.__internalTrove:Connect(v_u_97.MouseButton1Down, function()
                    if v_u_100 then
                        return
                    elseif v_u_98 == "" or p_u_51.__internalState.isProcessingSkinPurchase then
                        return
                    else
                        local v147 = v_u_97:FindFirstChild("Display")
                        local v148 = v_u_99
                        if v147 and v148 then
                            v_u_10:Play("switch")
                            if p_u_51.__internalState.isSureForSkinPurchase then
                                p_u_51.__internalState.isProcessingSkinPurchase = true
                                v147.Text = v_u_19.Processing
                                local v149 = v_u_7:FireServerConnection("PurchaseSkinAsync", "REMOTE_FUNCTION", v_u_98)
                                if v149 then
                                    local v150 = v148:FindFirstChild("DamnedCard")
                                    if v150 then
                                        v150:Destroy()
                                    end
                                    v_u_25.Outline:Clone().Parent = v148
                                    if v_u_98 == "CosmeticRows/KillersRow/7" then
                                        p_u_51:__switchDialogue("FinalPurchase")
                                    else
                                        p_u_51:__switchDialogue("SuccessfulPurchase")
                                    end
                                    if v_u_101 then
                                        v_u_101:Fire(v149)
                                    end
                                else
                                    p_u_51:__switchDialogue("InsufficientBribery")
                                end
                                v147.Text = v_u_19.Normal
                                p_u_51.__internalState.isSureForSkinPurchase = false
                                p_u_51.__internalState.isProcessingSkinPurchase = false
                            else
                                p_u_51.__internalState.isSureForSkinPurchase = true
                                if v147 then
                                    v147.Text = v_u_19.MakeSure
                                end
                            end
                        else
                            return
                        end
                    end
                end)
                if v96 then
                    v_u_146(v96, v_u_13.CosmeticRows, "CosmeticRows")
                end
                if v_u_21 then
                    v52.Parent = v_u_21.PlayerGui
                end
                p_u_51.ShopUI = v53
                p_u_51.__isInitialized = true
                local v151 = v_u_21
                if v151 then
                    v151 = v_u_21.Character
                end
                if v151 then
                    p_u_51.__internalTrove:Connect(v151.AncestryChanged, function(_, p152)
                        if p_u_51.__isInitialized then
                            if not p152 or p152.Name ~= "Spectating" then
                                p_u_51:__closeUI()
                            end
                        else
                            return
                        end
                    end)
                end
                return
            else
                assert(true, "bad message")
                if v_u_15 then
                    warn((("[%*]: Failed to get current stock, returning..."):format(v_u_16)))
                end
            end
        else
            assert(true, "bad message")
            if v_u_15 then
                warn((("[%*]: Failed to find the Event Shop UI."):format(v_u_16)))
            end
        end
    end,
    ["__closeUI"] = function(p153)
        if p153.ShopUI and p153.__isInitialized then
            if v_u_22 then
                local v154 = v_u_22:FindFirstChild("MainUI")
                if v154 then
                    v154.Enabled = true
                end
            else
                assert(true, "bad message")
                if v_u_15 then
                    warn((("[%*]: Failed to find the local players PlayerGui, returning..."):format(v_u_16)))
                end
            end
            if p153._currentDialogThread then
                task.cancel(p153._currentDialogThread)
                p153._currentDialogThread = nil
            end
            p153.__internalTrove:Destroy()
            p153.__internalState.isSelectSkinDebounce = false
            p153.__internalState.isProcessingRestockPurchase = false
            p153.__internalState.isSureForSkinPurchase = false
            p153.__internalState.isProcessingSkinPurchase = false
            p153.__internalState.isSureForPurchase = false
            p153.__internalState.isDragging = false
            if p153.__closeCallback then
                p153.__closeCallback()
            end
            p153.ShopUI.Visible = false
            p153.__isInitialized = false
        end
    end,
    ["OpenUI"] = function(p155, p156)
        if not (p155.__isInitialized and p155.ShopUI) then
            p155:__initializeUI()
        end
        if v_u_22 then
            local v157 = v_u_22:FindFirstChild("MainUI")
            if v157 then
                v157.Enabled = false
            end
        else
            assert(true, "bad message")
            if v_u_15 then
                warn((("[%*]: Failed to find the local players PlayerGui, returning..."):format(v_u_16)))
            end
        end
        if p155.FirstTimeOpened then
            p155:__switchDialogue("EnteringShop")
        else
            p155.FirstTimeOpened = true
            p155:__switchDialogue("FirstMeeting")
        end
        p155.ShopUI.Visible = true
        p155.__closeCallback = p156
    end
}
return v158