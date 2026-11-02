
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TextService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Packages.Synchronizer)
local v_u_6 = require(v_u_1.Packages.Observers)
local v_u_7 = require(v_u_1.Packages.Gradients)
local v_u_8 = require(v_u_1.Packages.FFlags)
local v_u_9 = require(v_u_1.Packages.Timer)
local v_u_10 = require(v_u_1.Packages.Trove)
local v11 = require(v_u_1.Packages.Net)
local v_u_12 = require(v_u_1.Packages.Spr)
local v_u_13 = require(v_u_1.Classes.AnimatedButton)
local v_u_14 = require(v_u_1.Shared.Animals)
local v_u_15 = require(v_u_1.Shared.Mutations)
local v_u_16 = require(v_u_1.Shared.Marketplace)
local v_u_17 = require(v_u_1.Shared.UsersAPI)
local v_u_18 = require(v_u_1.Shared.Friends)
local v_u_19 = require(v_u_1.Shared.Updates)
local v_u_20 = require(v_u_1.Shared.Policy)
local v_u_21 = require(v_u_1.Packages.CreateTween)
local v_u_22 = require(v_u_1.Datas.ValentinesShop)
local v_u_23 = require(v_u_1.Datas.LuckyBlocks)
local v_u_24 = require(v_u_1.Datas.ServerData)
local v_u_25 = require(v_u_1.Datas.Rarities)
local v_u_26 = require(v_u_1.Datas.Animals)
local v_u_27 = require(v_u_1.Datas.Mutations)
local v_u_28 = require(v_u_1.Datas.Shop)
local v_u_29 = require(v_u_1.Utils.TimeUtils)
local v_u_30 = require(v_u_1.Controllers.CornerNotificationController)
local v_u_31 = require(v_u_1.Controllers.NotificationController)
local v_u_32 = require(v_u_1.Controllers.InterfaceController)
local v_u_33 = require(v_u_1.Controllers.SoundController)
local v_u_34 = require(v_u_1.Controllers.ShopController)
local v_u_35 = require(v_u_1.Shared.VFX)
local v_u_36 = v_u_4.LocalPlayer
local v_u_37 = v_u_36.PlayerGui
local v_u_38 = v11:RemoteFunction("ValentinesShopService/SearchUser")
local v_u_39 = v11:RemoteFunction("ValentinesShopService/OpenGift")
local v_u_40 = v11:RemoteFunction("ValentinesShopService/Gift")
local v_u_41 = v11:RemoteEvent("ValentinesShopService/GiftNotify")
local v_u_42 = v_u_37:WaitForChild("ValentinesShop").ValentinesShop
local v_u_43 = v_u_42.Sections.Send.List
local v_u_44 = v_u_37:WaitForChild("ValentinesSendGift").ValentinesSendGift
local v_u_45 = v_u_37:WaitForChild("ValentinesCard"):WaitForChild("ValentinesCard")
local v_u_46 = nil
local v_u_47 = nil
local v_u_48 = {}
local v_u_49 = nil
local v_u_50 = nil
local v_u_51 = nil
local v_u_316 = nil
local function v_u_61()
    local v_u_52
    if v_u_8:GetInstant("ValentinesShop/MessagesDisabled", true) then
        v_u_52 = v_u_44.Right
    else
        v_u_52 = v_u_44.RightMessage
    end
    if v_u_8:GetInstant("ValentinesShop/MessagesDisabled", true) then
        v_u_44.RightMessage.Visible = false
        v_u_44.Right.Visible = true
    else
        v_u_44.RightMessage.Visible = true
        v_u_44.Right.Visible = false
    end
    if v_u_51 then
        v_u_51:Destroy()
        v_u_51 = nil
    end
    local v53 = v_u_52.Box.Item:FindFirstChild("BrainrotViewport")
    if v53 then
        v53:Destroy()
    end
    v_u_52.Cost.Text = "???"
    if v_u_50 then
        local v54 = v_u_28[v_u_50.rawId]
        v_u_48:BindLabelToProductPrice(v_u_52.Cost, v_u_50.remappedId, "Product")
        v_u_52.Title.Text = v54 and (v54.Display or "???") or "???"
        if not v54 or (v54.Type ~= "LuckyBlock" or not v54.Value) then
            if v54 and v54.Icon then
                v_u_52.Box.Item.Image = v54.Icon
            else
                task.spawn(function()
                    local v55 = v_u_50
                    local v56 = v_u_16:GetProductInfo(v_u_50.rawId, "Product")
                    if v56 then
                        if v_u_50 == v55 then
                            v_u_52.Box.Item.Image = v56.Icon or ""
                        end
                    else
                        return
                    end
                end)
            end
        end
        v_u_52.Box.Item.Image = ""
        local v57 = v54.Value
        local v58
        if typeof(v57) == "table" then
            v58 = v54.Value[1]
        else
            v58 = v54.Value
        end
        local v59 = Instance.new("ViewportFrame")
        v59.Name = "BrainrotViewport"
        v59.Size = UDim2.fromScale(1, 1)
        v59.Position = UDim2.fromScale(0.5, 0.5)
        v59.AnchorPoint = Vector2.new(0.5, 0.5)
        v59.BackgroundTransparency = 1
        v59.Parent = v_u_52.Box.Item
        local v60 = v_u_14:AttachOnViewport(v58, v59, true, (v_u_15.get()))
        if v60 then
            v_u_51 = v60
            return
        end
    else
        v_u_34:UnbindLabelProductPrice(v_u_52.Cost)
        v_u_52.Title.Text = "NONE"
        v_u_52.Box.Item.Image = ""
    end
end
local function v_u_63(p62)
    if p62 == nil then
        v_u_50 = nil
        v_u_61()
        return true
    end
    if not v_u_22.Products[p62] then
        return false
    end
    v_u_50 = {
        ["remappedId"] = v_u_48:GetProductId(p62),
        ["rawId"] = p62
    }
    v_u_61()
    return true
end
local function v_u_70(p64, p65)
    local v66 = v_u_26[p65]
    if not v66 then
        return nil
    end
    local v67 = v_u_10.new()
    local v68 = v_u_25[v66.Rarity]
    p64.Title.Text = p65
    p64.UIStroke.Color = Color3.new(0, 0, 0)
    if v68.GradientPreset then
        p64.Title.TextColor3 = Color3.new(1, 1, 1)
        v67:Add(v_u_7.apply(p64.Title, v68.GradientPreset))
    else
        p64.Title.TextColor3 = v68.Color
    end
    p64.Visible = true
    local v69 = v_u_14:AttachOnViewportWithOptimizations(p65, p64.ViewportFrame, true)
    if v69 then
        v67:Add(v69)
    end
    return v67
end
local v_u_71 = false
function v_u_48.OpenAnimation(_, p_u_72)
    while v_u_71 do
        task.wait()
    end
    v_u_71 = true
    local v_u_73 = true
    v_u_21(v_u_45.Parent.Frame, TweenInfo.new(0.25), {
        ["BackgroundTransparency"] = 0.5
    })
    v_u_45.bgbtmback.ImageTransparency = 0
    v_u_45.bgbtmfront.ImageTransparency = 0
    v_u_45.CardInside.ZIndex = 1
    v_u_45.bgtopseal.Visible = true
    v_u_45.bgtopseal.Position = UDim2.fromScale(0.5, 0.486)
    v_u_45.bgtopseal.HeartSeal.Position = UDim2.fromScale(0.5, 0.5)
    v_u_45.bgtopseal.HeartSeal.ImageTransparency = 0
    v_u_45.Visible = false
    v_u_45.Position = UDim2.fromScale(0.5, 2)
    local v74 = v_u_45.CardInside:FindFirstChild("Message")
    if v74 then
        v74.Text = ""
        v74.Visible = false
    end
    v_u_45.bgtopseal.Title.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(p_u_72.Sender)
    if p_u_72.SenderUsername then
        v_u_45.bgtopseal.Title.User.Text = ("@%*"):format(p_u_72.SenderUsername)
    else
        v_u_45.bgtopseal.Title.User.Text = "???"
        task.spawn(function()
            local v75 = v_u_17:GetUser(p_u_72.Sender)
            if v75 and v_u_73 then
                v_u_45.bgtopseal.Title.User.Text = ("@%*"):format(v75.Username)
            end
        end)
    end
    local v76 = p_u_72.GiftType or "purchased"
    local v77 = "Gift"
    local v78 = nil
    local v79 = nil
    local v_u_80 = v_u_10.new()
    if v76 == "purchased" then
        local v81 = nil
        for v82, v83 in v_u_22.Products do
            if p_u_72.ProductId == v83.discountedProductId then
                v81 = v_u_28[v82]
                break
            end
        end
        if v81 then
            v77 = v81.Display
            if v81.Type == "LuckyBlock" and v81.Value then
                local v84 = v81.Value
                if typeof(v84) == "table" then
                    v79 = v81.Value[1]
                else
                    v79 = v81.Value
                end
            else
                v78 = v81.Icon
            end
        end
    elseif v76 == "pool" then
        v77 = p_u_72.RewardName or "Mystery Gift"
    elseif v76 == "brainrot" then
        v77 = p_u_72.RewardName or (p_u_72.BrainrotName or "Special Gift")
        v_u_45.CardInside.Box.Visible = false
        v_u_45.CardInside.BoxBrainrot.Visible = true
        v_u_80:Add(function()
            v_u_45.CardInside.BoxBrainrot.Visible = false
            v_u_45.CardInside.Box.Visible = true
        end)
        local v85 = v_u_70(v_u_45.CardInside.BoxBrainrot, p_u_72.RewardName or p_u_72.BrainrotName)
        if v85 then
            v_u_80:Add(v85)
        end
    end
    v_u_45.CardInside.Box.Title.Text = v77
    local v_u_86 = v_u_45.CardInside.Box.Item
    local v87 = v_u_86:FindFirstChild("BrainrotViewport")
    if v87 then
        v87:Destroy()
    end
    v_u_86.Image = ""
    if v79 then
        local v88 = v_u_80:Add(Instance.new("ViewportFrame"))
        v88.Name = "BrainrotViewport"
        v88.Size = UDim2.fromScale(1, 1)
        v88.Position = UDim2.fromScale(0.5, 0.5)
        v88.AnchorPoint = Vector2.new(0.5, 0.5)
        v88.BackgroundTransparency = 1
        v88.Parent = v_u_86
        local v89 = v_u_14:AttachOnViewport(v79, v88, true, p_u_72.Mutation)
        if v89 then
            v_u_80:Add(v89)
        end
    elseif v78 then
        v_u_86.Image = v78
    elseif v76 == "purchased" and p_u_72.ProductId then
        local v_u_90 = nil
        for v91, v92 in v_u_22.Products do
            if p_u_72.ProductId == v92.discountedProductId then
                v_u_90 = v91
                break
            end
        end
        task.spawn(function()
            local v93 = v_u_50
            local v94 = v_u_16:GetProductInfo(v_u_90 or p_u_72.ProductId, "Product")
            if v94 then
                if v_u_50 == v93 then
                    v_u_86.Image = v94.Icon or ""
                end
            else
                return
            end
        end)
    elseif (v76 == "pool" or v76 == "brainrot") and (p_u_72.RewardName or p_u_72.BrainrotName) then
        local v95 = p_u_72.RewardName or p_u_72.BrainrotName
        local v96 = v_u_80:Add(Instance.new("ViewportFrame"))
        v96.Name = "BrainrotViewport"
        v96.Size = UDim2.fromScale(1, 1)
        v96.Position = UDim2.fromScale(0.5, 0.5)
        v96.AnchorPoint = Vector2.new(0.5, 0.5)
        v96.BackgroundTransparency = 1
        v96.Parent = v_u_86
        local v97 = v_u_14:AttachOnViewport(v95, v96, true, p_u_72.Mutation)
        if v97 then
            v_u_80:Add(v97)
        end
    end
    if p_u_72.Message then
        local v98 = p_u_72.Message
        local v99 = typeof(v98) == "string" and #p_u_72.Message > 0 and v_u_45.CardInside:FindFirstChild("Message")
        if v99 then
            v99.Text = p_u_72.Message
            v99.Visible = true
        end
    end
    task.wait(0.5)
    v_u_45.Visible = true
    v_u_21(v_u_45, TweenInfo.new(0.75), {
        ["Position"] = UDim2.fromScale(0.5, 0.5)
    })
    task.wait(0.75)
    v_u_33:PlaySound(v_u_1.Sounds.Sfx.ValentinesLetter, nil, false)
    v_u_21(v_u_45.bgtopseal.HeartSeal, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        ["Position"] = UDim2.fromScale(0.5, 2)
    })
    task.wait(0.8)
    v_u_45.bgtopseal.HeartSeal.ImageTransparency = 1
    v_u_21(v_u_45.bgtopseal, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        ["Position"] = UDim2.fromScale(0.5, -1)
    })
    task.wait(0.6)
    v_u_21(v_u_45.CardInside, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["Position"] = UDim2.fromScale(0.5, -0.4)
    })
    task.wait(0.3)
    v_u_45.bgtopseal.Visible = false
    v_u_45.CardInside.ZIndex = 20
    v_u_21(v_u_45.CardInside, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["Position"] = UDim2.fromScale(0.5, 0.5)
    })
    v_u_45.CardInside.Close.Activated:Once(function()
        v_u_21(v_u_45.Parent.Frame, TweenInfo.new(0.25), {
            ["BackgroundTransparency"] = 1
        })
        v_u_21(v_u_45, TweenInfo.new(0.5), {
            ["Position"] = UDim2.fromScale(0.5, 2)
        })
        task.wait(1)
        v_u_80:Destroy()
        v_u_71 = false
        v_u_73 = false
    end)
    task.delay(1, function()
        v_u_21(v_u_45.bgbtmback, TweenInfo.new(0.5), {
            ["ImageTransparency"] = 1
        })
        v_u_21(v_u_45.bgbtmfront, TweenInfo.new(0.5), {
            ["ImageTransparency"] = 1
        })
    end)
end
function v_u_48._createRightFrame(_)
    local v_u_100 = nil
    v_u_8:OnUpdate(function()
        local v101 = not v_u_8:GetInstant("ValentinesShop/MessagesDisabled", true)
        if v_u_100 ~= v101 then
            v_u_100 = v101
            v_u_61()
        end
    end)
    local v_u_102 = v_u_44.RightMessage.Frame.ScrollingFrame.TextBox
    if v_u_102 then
        v_u_102.TextSize = 22
    end
    local v_u_103 = false
    local function v108()
        if v_u_103 then
            return
        elseif v_u_49 then
            if v_u_50 then
                local v104 = nil
                local v_u_105
                if v_u_102 then
                    local v106 = string.gsub(v_u_102.Text, "^%s+", "")
                    v_u_105 = string.gsub(v106, "%s+$", "")
                    if #v_u_105 <= 0 then
                        v_u_105 = v104
                    end
                else
                    v_u_105 = v104
                end
                local v107
                if v_u_8:GetInstant("ValentinesShop/MessagesDisabled", true) then
                    v107 = v_u_44.RightMessage
                else
                    v107 = v_u_44.Right
                end
                if v_u_8:GetInstant("ValentinesShop/MessagesDisabled", true) then
                    v_u_105 = nil
                end
                v_u_103 = true
                v107.Buy.BackgroundColor3 = Color3.fromRGB(115, 152, 172)
                v107.Buy.Price.Text = "..."
                pcall(function()
                    if v_u_40:InvokeServer(v_u_50.rawId, v_u_49.user.userId, v_u_105) then
                        if v_u_102 then
                            v_u_102.Text = ""
                        end
                        v_u_32:SetState("ValentinesSendGift", false)
                        v_u_32:SetState("ValentinesShop", true)
                    end
                end)
                v107.Buy.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
                v107.Buy.Price.Text = "GIFT"
                v_u_103 = false
            end
        else
            v_u_31:Error("You need to select a user to send a gift to!")
            return
        end
    end
    v_u_44.RightMessage.Buy.Activated:Connect(v108)
    v_u_44.Right.Buy.Activated:Connect(v108)
    if v_u_102 then
        local v_u_109 = v_u_102.Parent
        local v_u_110 = Instance.new("GetTextBoundsParams")
        v_u_110.Size = v_u_102.TextSize
        v_u_110.Font = v_u_102.FontFace
        v_u_110.Width = v_u_102.AbsoluteSize.X
        local function v122()
            local v111 = v_u_102.Text
            if not utf8.len(v111) or utf8.len(v111) <= 60 then
                v_u_110.Text = v_u_102.Text
                if #v_u_102.Text == 0 then
                    v_u_110.Text = v_u_102.PlaceholderText or " "
                end
                v_u_110.Width = v_u_102.AbsoluteSize.X
                local v112, v113 = pcall(function()
                    return v_u_2:GetTextBoundsAsync(v_u_110)
                end)
                if v112 and v113 then
                    local v114 = v113.Y + 10
                    local v115 = v_u_102.TextSize + 10
                    local v116 = math.max(v114, v115)
                    v_u_102.Size = UDim2.new(0.975, 0, 0, v116)
                    if v_u_109 then
                        v_u_109.CanvasSize = UDim2.new(0, 0, 0, v116)
                        if v_u_102.CursorPosition > 0 then
                            v_u_109.CanvasPosition = Vector2.new(0, v_u_109.AbsoluteCanvasSize.Y)
                        end
                    end
                end
                return
            end
            local v117 = 0
            local v118 = 0
            for v119, _ in utf8.codes(v111) do
                v117 = v117 + 1
                if v117 > 60 then
                    break
                end
                v118 = v119
            end
            if v118 > 0 then
                local v120 = v_u_102
                local v121 = (utf8.offset(v111, 2, v118) or #v111 + 1) - 1
                v120.Text = string.sub(v111, 1, v121)
            end
        end
        v_u_102:GetPropertyChangedSignal("Text"):Connect(v122)
        v_u_102:GetPropertyChangedSignal("CursorPosition"):Connect(function()
            if v_u_102.CursorPosition > 0 and v_u_109 then
                v_u_109.CanvasPosition = Vector2.new(0, v_u_109.AbsoluteCanvasSize.Y)
            end
        end)
        task.spawn(v122)
    end
    return nil
end
function v_u_48._createGiftsTab(_)
    if true then return end
    local v_u_123 = v_u_5:Wait(v_u_36)
    if v_u_123 then
        local v_u_124 = v_u_42.Sections.Gifts.List
        local v_u_125 = {}
        local function v138()
            local v126 = v_u_123:Get({ "ValentinesEvent", "GiftInventory" })
            v_u_124.Parent.NoGifts.Visible = false
            local v127 = {}
            for v128, v_u_129 in v126 do
                v127[v_u_129.Id] = true
                local v130 = v_u_125[v_u_129.Id]
                if not v130 then
                    v130 = {}
                    local v_u_131 = v_u_124.Template:Clone()
                    v_u_131.Name = v_u_129.Id
                    v_u_131.Visible = true
                    v_u_131.Frame.PlayerIcon.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v_u_129.Sender)
                    if v_u_129.SenderUsername then
                        v_u_131.Frame.Username.Text = ("@%*"):format(v_u_129.SenderUsername)
                    else
                        v_u_131.Frame.Username.Text = "???"
                        v130.thread = task.spawn(function()
                            local v132 = v_u_17:GetUser(v_u_129.Sender)
                            if v132 then
                                v_u_131.Frame.Username.Text = ("@%*"):format(v132.Username)
                            end
                        end)
                    end
                    local v133 = v_u_13.new(v_u_131.Frame.Send)
                    v133:Animate()
                    v133.OnActivated:Connect(function()
                        local v134, v135 = v_u_39:InvokeServer(v_u_129.Id)
                        if v134 then
                            v_u_48:OpenAnimation(v135)
                        end
                    end)
                    v_u_131.Parent = v_u_124
                    v130.frame = v_u_131
                    v_u_125[v_u_129.Id] = v130
                end
                v130.frame.LayoutOrder = v128
            end
            for v136, v137 in v_u_125 do
                if not v127[v136] then
                    pcall(task.cancel, v137.thread)
                    v137.frame:Destroy()
                    v_u_125[v136] = nil
                end
            end
        end
        v_u_123:OnArrayInserted({ "ValentinesEvent", "GiftInventory" }, v138)
        v_u_123:OnArrayRemoved({ "ValentinesEvent", "GiftInventory" }, v138)
        task.spawn(v138)
    end
end
local v_u_139 = nil
function v_u_48.Open(_, p140, p141)
    v_u_32:SetState("ValentinesShop", true)
    v_u_139 = p141
    if p140 ~= nil then
        v_u_48:SetTab(p140)
    end
end
function v_u_48.SetTab(_, p142)
    for _, v143 in v_u_42.Sections:GetChildren() do
        v143.Visible = v143.Name == p142
    end
    local v144 = p142 == "Gifts" and "GIFT INVENTORY" or "GIFT SHOP"
    v_u_42.Header.Txts.Txt1.Text = v144
    for _, v145 in v_u_42.SideBtns:GetChildren() do
        if v145:IsA("GuiButton") then
            local v146
            if v145.Name == p142 then
                v146 = Color3.fromRGB(244, 102, 190)
            else
                v146 = Color3.fromRGB(244, 181, 241)
            end
            v145.BackgroundColor3 = v146
        end
    end
end
function v_u_48._createShopTabs(_)
    for _, v_u_147 in v_u_42.SideBtns:GetChildren() do
        if v_u_147:IsA("GuiButton") then
            local v148 = v_u_13.new(v_u_147)
            v148:Animate()
            v148.OnActivated:Connect(function()
                v_u_48:SetTab(v_u_147.Name)
            end)
        end
    end
    if v_u_48:IsEnabled() then
        v_u_48:SetTab("Send")
    else
        v_u_48:SetTab("Gifts")
    end
end
function v_u_48._createPlayerList(_)
    v_u_47 = v_u_32:Register("ValentinesSendGift", v_u_44, "TopQuint")
    v_u_47:Close()
    v_u_47.OnClose:Connect(function()
        local v149 = v_u_49
        v_u_49 = nil
        local v150 = v149 and (v149.card and (v149.card.Parent and v149.card:FindFirstChild("Fill")))
        if v150 then
            v150.BackgroundColor3 = Color3.fromRGB(255, 189, 240)
        end
        v_u_50 = nil
        v_u_61()
        local v151 = v_u_44.RightMessage.Frame.ScrollingFrame.TextBox
        if v151 then
            v151.Text = ""
        end
    end)
    local v152 = v_u_13.new(v_u_44.Header.Close)
    v152:Animate()
    v152.OnActivated:Connect(function()
        v_u_32:SetState("ValentinesSendGift", false)
        v_u_32:SetState("ValentinesShop", true)
    end)
    local v_u_153 = v_u_44.Left.SearchFrame.SearchBox
    local v_u_154 = nil
    local v_u_155 = nil
    local function v_u_167(p156, p157, p158, p159)
        local v160 = p159 or p156:FindFirstChild((("%*_%*"):format(p157.username, p157.userId)))
        if v160 then
            v160.Fill.Status2.Text = p157.inGame and "Online" or (p157.isFriend and "Away" or "Offline")
            local v161 = v160.Fill.Status2
            local v162
            if p157.inGame then
                v162 = Color3.fromRGB(86, 211, 74)
            elseif p157.isFriend then
                v162 = Color3.fromRGB(239, 225, 69)
            else
                v162 = Color3.fromRGB(211, 38, 38)
            end
            v161.TextColor3 = v162
            local v163 = v160.Fill.PlayerImage.Status
            local v164
            if p157.inGame then
                v164 = Color3.fromRGB(86, 211, 74)
            elseif p157.isFriend then
                v164 = Color3.fromRGB(239, 225, 69)
            else
                v164 = Color3.fromRGB(211, 38, 38)
            end
            v163.BackgroundColor3 = v164
            if not p157.inGame then
                p158 = p158 + 300
            end
            v160.LayoutOrder = p158
            local v165 = v160.Fill
            local v166
            if v_u_49 and (v_u_49.user and v_u_49.user.userId == p157.userId) then
                v166 = Color3.fromRGB(244, 102, 190)
            else
                v166 = Color3.fromRGB(255, 189, 240)
            end
            v165.BackgroundColor3 = v166
        end
    end
    local function v_u_178(p_u_168, p_u_169, p_u_170)
        local v171 = ("%*_%*"):format(p_u_169.username, p_u_169.userId)
        local v_u_172 = v_u_44.Left.LocalList.UIListLayout.Template:Clone()
        v_u_172.Name = v171
        v_u_172.Fill.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(p_u_169.userId)
        v_u_172.Fill.Username.Text = ("@%*"):format(p_u_169.username)
        v_u_167(p_u_168, p_u_169, p_u_170, v_u_172)
        v_u_172.Visible = true
        v_u_172.Parent = p_u_168
        v_u_172.Destroying:Once(function()
            if v_u_49 and v_u_49.card == v_u_172 then
                local v173 = v_u_49
                v_u_49 = nil
                local v174 = v173 and (v173.card and (v173.card.Parent and v173.card:FindFirstChild("Fill")))
                if v174 then
                    v174.BackgroundColor3 = Color3.fromRGB(255, 189, 240)
                end
            end
        end)
        v_u_172.Fill.Activated:Connect(function()
            local v175 = v_u_49
            local v176 = v_u_49
            v_u_49 = {
                ["parent"] = p_u_168,
                ["card"] = v_u_172,
                ["user"] = p_u_169,
                ["index"] = p_u_170
            }
            local v177 = v176 and (v176.card and (v176.card.Parent and v176.card:FindFirstChild("Fill")))
            if v177 then
                v177.BackgroundColor3 = Color3.fromRGB(255, 189, 240)
            end
            if v175 then
                v_u_167(v175.parent, v175.user, v175.index, v175.card)
            end
            v_u_167(p_u_168, p_u_169, p_u_170, v_u_172)
        end)
        return v_u_172
    end
    local v_u_179 = v_u_10.new()
    local function v_u_195()
        local v180 = coroutine.running()
        v_u_155 = v180
        v_u_179:Clean()
        local v181 = v_u_18:GetInGameFriends(v_u_36)
        local v182 = {}
        if v_u_154 == "Server" then
            for _, v183 in v_u_4:GetPlayers() do
                if v183 ~= v_u_36 then
                    local v184 = {
                        ["username"] = v183.Name,
                        ["userId"] = v183.UserId,
                        ["inGame"] = true,
                        ["isFriend"] = table.find(v181, v183) ~= nil
                    }
                    table.insert(v182, v184)
                end
            end
        elseif v_u_154 == "Global" then
            local v185, v186 = v_u_18:GetOnlineFriends()
            if v185 and typeof(v186) == "table" then
                for _, v187 in v186 do
                    local v188 = {
                        ["username"] = v187.UserName,
                        ["userId"] = v187.VisitorId
                    }
                    local v189
                    if v187.PlaceId == nil then
                        v189 = false
                    else
                        v189 = table.find(v_u_24.AllPlaces, v187.PlaceId) ~= nil
                    end
                    v188.inGame = v189
                    v188.isFriend = true
                    table.insert(v182, v188)
                end
            end
        end
        if v180 == v_u_155 then
            for v190, v191 in v182 do
                local v192 = v_u_179
                local v193 = v_u_178
                local v194
                if v_u_154 == "Global" then
                    v194 = v_u_44.Left.GlobalList
                else
                    v194 = v_u_44.Left.LocalList
                end
                v192:Add((v193(v194, v191, v190)))
            end
        end
    end
    local function v_u_199(p196)
        if v_u_154 ~= p196 then
            v_u_154 = p196
            v_u_153.Text = ""
            v_u_44.Left.LocalList.Visible = v_u_154 ~= "Global"
            v_u_44.Left.GlobalList.Visible = v_u_154 == "Global"
            v_u_44.Left.SearchFrame.Visible = v_u_154 == "Global"
            for _, v197 in v_u_44.Left.Btns:GetChildren() do
                if v197:IsA("GuiButton") then
                    local v198
                    if v_u_154 == v197.Name then
                        v198 = Color3.fromRGB(244, 102, 190)
                    else
                        v198 = Color3.fromRGB(225, 162, 220)
                    end
                    v197.BackgroundColor3 = v198
                end
            end
            v_u_195()
        end
    end
    v_u_4.PlayerAdded:Connect(function()
        if v_u_154 == "Server" then
            v_u_195()
        end
    end)
    v_u_4.PlayerRemoving:Connect(function()
        if v_u_154 == "Server" then
            v_u_195()
        end
    end)
    v_u_44.Left.SearchFrame.SearchBox.FocusLost:Connect(function(p200)
        local v201 = v_u_50
        assert(v201)
        if p200 then
            local v_u_202 = v_u_153.Text
            v_u_153.TextEditable = false
            v_u_153.Active = false
            v_u_153.Text = "..."
            v_u_179:Clean()
            local v203, v_u_204 = pcall(function()
                return v_u_4:GetUserIdFromNameAsync(v_u_202)
            end)
            if not v203 or typeof(v_u_204) ~= "number" then
                v_u_153.Text = string.find(v_u_204, "Unknown user") and "User not found!" or "Failed to search for user, try again later"
                task.wait(5)
                v_u_153.Text = ""
                v_u_153.TextEditable = true
                v_u_153.Active = true
                v_u_195()
                return false
            end
            local v205, v206, v207 = pcall(function()
                return v_u_38:InvokeServer(v_u_50.rawId, v_u_204)
            end)
            if not (v205 and v206) then
                local v208 = v_u_153
                if typeof(v206) ~= "string" then
                    v206 = typeof(v207) ~= "string" and "Failed to search for user, try again later" or v207
                end
                v208.Text = v206
                task.wait(5)
                v_u_153.Text = ""
                v_u_153.TextEditable = true
                v_u_153.Active = true
                v_u_195()
                return false
            end
            local v209, v210 = pcall(function()
                return v_u_17:GetUser(v_u_204)
            end)
            local v211 = v_u_179
            local v212 = v_u_178
            local v213 = v_u_44.Left.GlobalList
            local v214 = {
                ["userId"] = v_u_204
            }
            local v215
            if v209 and (typeof(v210) == "table" and v210.IsLoaded) then
                v215 = v210.Username
            else
                v215 = string.upper(v_u_202)
            end
            v214.username = v215
            v214.inGame = v207
            v211:Add((v212(v213, v214, 1)))
            v_u_153.Text = ""
            task.wait(5)
            v_u_153.TextEditable = true
            v_u_153.ClearTextOnFocus = true
            v_u_153.Active = true
        end
    end)
    for _, v216 in v_u_44.Left.Btns:GetChildren() do
        if v216:IsA("GuiButton") then
            local v_u_217 = v216.Name
            local v218 = v_u_13.new(v216)
            v218:Animate()
            v218.OnActivated:Connect(function()
                v_u_199(v_u_217)
            end)
        end
    end
    v_u_199("Server")
end
function v_u_48._createShopObjects(p_u_219)
    v_u_46 = v_u_32:Register("ValentinesShop", v_u_42, "TopQuint")
    local v220 = v_u_13.new(v_u_42.Header.Close)
    v220:Animate(nil, nil, 5)
    v220.OnActivated:Connect(function()
        v_u_32:SetState("ValentinesShop", false)
        if v_u_139 then
            v_u_32:SetState(v_u_139, true)
            v_u_139 = nil
        end
    end)
    v_u_46:Close()
    task.spawn(function()
        v_u_43["Heart Lucky Block"].Visible = false
        v_u_43.LuckyBlocksList.Secret.Visible = false
        local v221 = v_u_20.getPolicy(v_u_36)
        if v221 and not v221.ArePaidRandomItemsRestricted then
            v_u_43["Heart Lucky Block"].Visible = true
            v_u_43.LuckyBlocksList.Secret.Visible = true
        end
    end)
    local function v_u_250(p_u_222, p_u_223)
        local v_u_224 = v_u_10.new()
        local v_u_225 = nil
        local function v_u_249(p226)
            p_u_222.Visible = p226
            if p226 == v_u_225 then
                return
            else
                v_u_225 = p226
                if p226 then
                    local v227 = v_u_15.get()
                    local v228 = {}
                    for _, v229 in p_u_223.Animals do
                        if (not v229.IsEnabled or v229.IsEnabled()) and v229.Chance then
                            local v230 = {
                                ["animal"] = v229.Name,
                                ["chance"] = v229.Chance
                            }
                            table.insert(v228, v230)
                        end
                    end
                    table.sort(v228, function(p231, p232)
                        return p232.chance < p231.chance
                    end)
                    local v233 = p_u_222:GetAttribute("XScalar") or 1
                    local v_u_234 = p_u_222.Template.Size.X.Scale * v233
                    local v235 = 1 / v_u_234
                    local v236 = math.ceil(v235) + 1
                    local v237 = v236 / #v228
                    local v238 = math.ceil(v237) * #v228
                    local v_u_239 = table.create(v238)
                    local v240 = 0
                    for v241 = 1, v238 do
                        local v242 = v228[(v241 - 1) % #v228 + 1]
                        local v243 = v_u_224:Clone(p_u_222.Template)
                        v243.Name = tostring(v241)
                        v243.LayoutOrder = v241
                        v243.Chance.Text = ("%*%%"):format(v242.chance)
                        v243.Visible = true
                        v243.Position = UDim2.fromScale(v240, 0.5)
                        v243.Parent = p_u_222
                        v240 = v240 + v_u_234
                        v_u_239[v241] = v243
                        local v244 = v_u_14:AttachOnViewport(v242.animal, v243, true, v227)
                        if v244 then
                            v_u_224:Add(v244)
                        end
                    end
                    if v236 <= #v_u_239 then
                        local v_u_245 = 0.5
                        if v233 > 1 then
                            v_u_245 = v_u_245 * v233
                        end
                        v_u_224:Add(v_u_3.PreRender:Connect(function(p246)
                            local v247 = v_u_234 * p246 * v_u_245
                            for _, v248 in v_u_239 do
                                v248.Position = v248.Position - UDim2.fromScale(v247, 0)
                                if v248.Position.X.Scale <= -v_u_234 then
                                    v248.Position = v248.Position + UDim2.fromScale(v_u_234 * #v_u_239, 0)
                                end
                            end
                        end))
                    end
                else
                    v_u_224:Clean()
                end
            end
        end
        v_u_19.OnUpdateEnabled:Connect(function()
            if p_u_222.Visible and v_u_46:IsOpened() then
                p_u_222.Visible = false
                if v_u_225 ~= false then
                    v_u_225 = false
                    v_u_224:Clean()
                end
                v_u_249(true)
            end
        end)
        v_u_19.OnUpdateDisabled:Connect(function()
            if p_u_222.Visible and v_u_46:IsOpened() then
                p_u_222.Visible = false
                if v_u_225 ~= false then
                    v_u_225 = false
                    v_u_224:Clean()
                end
                v_u_249(true)
            end
        end)
        v_u_46.OnClose:Connect(function()
            p_u_222.Visible = false
            if v_u_225 ~= false then
                v_u_225 = false
                v_u_224:Clean()
            end
        end)
        v_u_46.OnOpen:Connect(function()
            v_u_249(true)
        end)
        v_u_15.watch(function()
            if p_u_222.Visible and v_u_46:IsOpened() then
                p_u_222.Visible = false
                if v_u_225 ~= false then
                    v_u_225 = false
                    v_u_224:Clean()
                end
                v_u_249(true)
            end
        end)
    end
    for _, v_u_251 in v_u_43:GetChildren() do
        local v252 = v_u_251.Name
        if v252 == "Heart Lucky Block" then
            task.spawn(function()
                local v253 = v_u_20.getPolicy(v_u_36)
                if v253 and not v253.ArePaidRandomItemsRestricted then
                    for _, v254 in v_u_251:GetChildren() do
                        if v254.Name == "Odds" then
                            v_u_250(v254, v_u_23["Premium Heart Lucky Block"])
                        end
                    end
                    local v_u_255 = v_u_10.new()
                    local function v260()
                        v_u_255:Destroy()
                        if v_u_46:IsOpened() then
                            local v256 = v_u_15.get()
                            local v257
                            if v256 then
                                v257 = v_u_27[v256]
                            else
                                v257 = v256
                            end
                            if v257 then
                                v_u_251.Mutation.Text = v257.DisplayWithRichText
                                v_u_251.Mutation.Visible = true
                            else
                                v_u_251.Mutation.Visible = nil
                            end
                            for _, v258 in v_u_251:GetChildren() do
                                if v258:IsA("ViewportFrame") and v258.Name == "IconViewport" then
                                    local v259 = v_u_14:AttachOnViewport("Premium Heart Lucky Block", v258, true, v256)
                                    if v259 then
                                        v_u_255:Add(v259)
                                    end
                                end
                            end
                        end
                    end
                    task.spawn(v260)
                    v_u_46.OnClose:Connect(v260)
                    v_u_46.OnOpen:Connect(v260)
                    v_u_15.watch(v260)
                    local v261 = v_u_13.new(v_u_251.Buttons.Buy)
                    v261:Animate()
                    v261.OnActivated:Connect(function()
                        p_u_219:Purchase(3531057541)
                    end)
                    local v_u_262 = v_u_13.new(v_u_251.Buttons.Buy3)
                    v_u_262:Animate()
                    v_u_262.OnActivated:Connect(function()
                        p_u_219:Purchase(3531057803)
                    end)
                    local v_u_263 = v_u_13.new(v_u_251.Buttons.Buy10)
                    v_u_263:Animate()
                    v_u_263.OnActivated:Connect(function()
                        p_u_219:Purchase(3531057804)
                    end)
                    local function v_u_266()
                        local v264 = v_u_5:Get(v_u_36)
                        if v264 then
                            local v265 = v264:Get({ "LuckyBlocks", (tostring(3531057803)) }) or 0
                            v_u_263.Instance.Visible = v265 >= 5
                            v_u_262.Instance.Visible = v265 < 5
                        end
                    end
                    task.spawn(function()
                        v_u_48:BindLabelToProductPrice(v_u_251.Buttons.Buy.Price, v_u_48:GetProductId(3531057541), "Product")
                        v_u_48:BindLabelToProductPrice(v_u_251.Buttons.Buy3.Price, v_u_48:GetProductId(3531057803), "Product")
                        v_u_48:BindLabelToProductPrice(v_u_251.Buttons.Buy10.Price, v_u_48:GetProductId(3531057804), "Product")
                    end)
                    task.spawn(function()
                        local v267 = v_u_5:Wait(v_u_36)
                        if v267 then
                            v267:OnChanged({ "LuckyBlocks", (tostring(3531057803)) }, v_u_266)
                            v_u_266()
                        end
                    end)
                    task.spawn(v_u_266)
                    local v_u_268 = v_u_251:WaitForChild("Timer")
                    v_u_9.Simple(1, function()
                        v_u_251.Visible = workspace:GetServerTimeNow() < v_u_8:GetInstant("HeartLuckyBlockPackEndTime", 1771704000)
                        local v269 = v_u_8:GetInstant("HeartLuckyBlockPackEndTime", 1771704000)
                        local v270 = workspace:GetServerTimeNow()
                        if v_u_268 then
                            v_u_268.Text = ("%* left"):format((v_u_29:E(v269 - v270)))
                        end
                    end)
                end
            end)
        elseif v252 == "LuckyBlocksList" then
            task.spawn(function()
                local v_u_271 = v_u_251.Secret
                local v272 = v_u_23["Secret Lucky Block"]
                if v272 then
                    local v_u_273 = v272.ProductId
                    if v_u_273 then
                        for _, v274 in ipairs(v_u_271:GetChildren()) do
                            if v274.Name == "Odds" then
                                local _ = v274:GetAttribute("LuckyBlock") or "Secret Lucky Block"
                                v_u_250(v274, v_u_23["Secret Lucky Block"])
                            end
                        end
                        local v_u_275 = v_u_10.new()
                        local function v_u_280()
                            v_u_275:Destroy()
                            if v_u_46:IsOpened() then
                                local v276 = v_u_15.get()
                                local v277
                                if v276 then
                                    v277 = v_u_27[v276]
                                else
                                    v277 = v276
                                end
                                if v277 then
                                    v_u_271.Mutation.Text = v277.DisplayWithRichText
                                    v_u_271.Mutation.Visible = true
                                else
                                    v_u_271.Mutation.Visible = nil
                                end
                                for _, v278 in ipairs(v_u_271:GetChildren()) do
                                    if v278:IsA("ViewportFrame") and v278.Name == "IconViewport" then
                                        local v279 = v_u_14:AttachOnViewport(v278:GetAttribute("LuckyBlock") or "Secret Lucky Block", v278, true, v276)
                                        if v279 then
                                            v_u_275:Add(v279)
                                        end
                                    end
                                end
                            end
                        end
                        task.spawn(v_u_280)
                        v_u_46.OnClose:Connect(function()
                            v_u_280()
                        end)
                        v_u_46.OnOpen:Connect(function()
                            v_u_280()
                        end)
                        v_u_15.watch(function()
                            task.spawn(v_u_280)
                        end)
                        local v281 = v_u_13.new(v_u_271.Buy)
                        v281:Animate()
                        v281.OnActivated:Connect(function()
                            p_u_219:Purchase(v_u_273)
                        end)
                        v_u_48:BindLabelToProductPrice(v_u_271.Buy.Price, v_u_48:GetProductId(v_u_273), "Product", 100)
                    end
                else
                    return
                end
            end)
            task.spawn(function()
                local v282 = v_u_251.Wings
                local v283 = v_u_20.getPolicy(v_u_36)
                local v284 = not v283 or v283.ArePaidRandomItemsRestricted
                local v_u_285 = v284 and 3536298171 or 3536298173
                v282.LuckyBlock.Visible = not v284
                v282.NonLuckyBlock.Visible = v284
                local v286 = v_u_13.new(v282.Buy)
                v286:Animate()
                v286.OnActivated:Connect(function()
                    p_u_219:Purchase(v_u_285)
                end)
                v_u_48:BindLabelToProductPrice(v282.Buy.Price, v_u_48:GetProductId(v_u_285), "Product", 100)
            end)
        elseif v252 == "Rose Base" then
            task.spawn(function()
                local v_u_287 = v_u_20.getPolicy(v_u_36)
                local v288 = v_u_251:WaitForChild("Buy", 5)
                local v289
                if v288 then
                    v289 = v288:WaitForChild("Price", 5)
                else
                    v289 = v288
                end
                local v_u_290 = false
                v_u_251.LuckyBlock.Visible = (v_u_287 and not v_u_287.ArePaidRandomItemsRestricted and 3531055926 or 3531055923) == 3531055926
                v_u_251.Visible = true
                v_u_251:SetAttribute("ProductId", v_u_287 and not v_u_287.ArePaidRandomItemsRestricted and 3531055926 or 3531055923)
                v_u_8:OnUpdate(function()
                    v_u_251.Visible = workspace:GetServerTimeNow() < v_u_8:GetInstant("RoseBasePackEndTime", 1771704000)
                end)
                local v_u_291 = v_u_251:WaitForChild("Timer", 5)
                v_u_9.Simple(1, function()
                    local v292 = v_u_8:GetInstant("RoseBasePackEndTime", 1771704000)
                    local v293 = workspace:GetServerTimeNow()
                    if v_u_291 then
                        v_u_291.Text = ("%* left"):format((v_u_29:E(v292 - v293)))
                    end
                    if v292 <= v293 then
                        if not v_u_290 then
                            v_u_290 = true
                            v_u_251.Visible = workspace:GetServerTimeNow() < v_u_8:GetInstant("RoseBasePackEndTime", 1771704000)
                            return
                        end
                    elseif v_u_290 then
                        v_u_290 = false
                        v_u_251.Visible = workspace:GetServerTimeNow() < v_u_8:GetInstant("RoseBasePackEndTime", 1771704000)
                    end
                end)
                local v294 = v_u_287 and not v_u_287.ArePaidRandomItemsRestricted and 3531055926 or 3531055923
                v_u_251:SetAttribute("ProductId", v294)
                v_u_251.LuckyBlock.Visible = v294 == 3531055926
                if v289 then
                    v_u_48:BindLabelToProductPrice(v289, v_u_48:GetProductId(v294))
                end
                local v295 = v_u_13.new(v288)
                v295:Animate()
                v295.OnActivated:Connect(function()
                    p_u_219:Purchase(v_u_287 and not v_u_287.ArePaidRandomItemsRestricted and 3531055926 or 3531055923)
                end)
            end)
        elseif v252 == "ItemsList" or v252 == "GamepassList" then
            local v296
            if v252 == "GamepassList" then
                v296 = { v_u_251["3296367604"], v_u_251.Main["3296367825"], v_u_251.Main["3296367737"] }
            else
                v296 = v_u_251.Fill:GetChildren()
            end
            for _, v_u_297 in v296 do
                if v_u_297:IsA("GuiObject") then
                    task.spawn(function()
                        local v298 = v_u_297.Name
                        local v_u_299 = tonumber(v298)
                        if v_u_299 then
                            assert(v_u_299)
                            local v_u_300 = v_u_28[v_u_299]
                            if v_u_300 then
                                local v301 = v_u_297:WaitForChild("Buy", 5)
                                local v_u_302
                                if v301 then
                                    v_u_302 = v301:WaitForChild("Price", 5)
                                else
                                    v_u_302 = v301
                                end
                                local v_u_303 = v_u_297:FindFirstChild("Icon", true)
                                if v_u_300.Icon and v_u_303 then
                                    v_u_303.ScaleType = Enum.ScaleType.Fit
                                    v_u_303.Image = v_u_300.Icon
                                end
                                (function()
                                    local v304 = v_u_16:GetProductInfo(v_u_299, "Product")
                                    if v_u_302 then
                                        v_u_48:BindLabelToProductPrice(v_u_302, v_u_48:GetProductId(v_u_299))
                                    end
                                    if v304.Icon and v_u_303 then
                                        v_u_303.ScaleType = Enum.ScaleType.Fit
                                        if not v_u_300.Icon then
                                            v_u_303.Image = v304.Icon
                                        end
                                    end
                                end)()
                                local v305 = v_u_13.new(v301)
                                v305:Animate()
                                v305.OnActivated:Connect(function()
                                    p_u_219:Purchase(v_u_299)
                                end)
                            end
                        else
                            return
                        end
                    end)
                end
            end
        end
    end
end
function v_u_48.GetProductId(_, p306)
    return v_u_22.Products[p306].discountedProductId
end
function v_u_48.Purchase(_, p307)
    if v_u_22.Products[p307] then
        v_u_63(p307)
        v_u_32:SetState("ValentinesSendGift", true)
    end
end
function v_u_48.BindLabelToProductPrice(_, p_u_308, p_u_309, p_u_310, p_u_311)
    local v_u_312 = v_u_5:Wait(v_u_36)
    if not v_u_312 then
        return
    end
    for _, v313 in v_u_22.Products do
        if v313.discountedProductId == p_u_309 then
            local failedGiftKey = v313.failedGiftKey or tostring(p_u_309)
            local function v315()
                local v314 = v_u_312:Get({ "ValentinesEvent", "FailedGifts", failedGiftKey })
                if typeof(v314) == "table" and #v314 > 0 then
                    v_u_34:UnbindLabelProductPrice(p_u_308)
                    p_u_308.Text = ("FREE (%*)"):format(#v314)
                else
                    v_u_34:BindLabelToProductPrice(p_u_308, p_u_309, p_u_310, p_u_311)
                end
            end
            v_u_312:OnChanged({ "ValentinesEvent", "FailedGifts", failedGiftKey }, v315)
            v_u_312:OnArrayInserted({ "ValentinesEvent", "FailedGifts", failedGiftKey }, v315)
            v_u_312:OnArrayRemoved({ "ValentinesEvent", "FailedGifts", failedGiftKey }, v315)
            v315()
            return
        end
    end
    v_u_34:BindLabelToProductPrice(p_u_308, p_u_309, p_u_310, p_u_311)
end
local function v_u_323(p317, p318)
    local v_u_319 = p317:OnChanged({ "ValentinesEvent", "GiftInventory" }, p318)
    local v_u_320 = p317:OnArrayInserted({ "ValentinesEvent", "GiftInventory" }, p318)
    local v_u_321 = p317:OnArrayRemoved({ "ValentinesEvent", "GiftInventory" }, p318)
    local v_u_322 = task.spawn(p318)
    return function()
        pcall(task.cancel, v_u_322)
        if v_u_320 then
            v_u_320:Disconnect()
        end
        if v_u_321 then
            v_u_321:Disconnect()
        end
        if v_u_319 then
            v_u_319:Disconnect()
        end
    end
end
function v_u_48._createGiftSubtitleLabel(_)
    local v_u_324 = v_u_5:Wait(v_u_36)
    if v_u_324 then
        local function v_u_326()
            local v325 = v_u_324:Get({ "ValentinesEvent", "GiftInventory" })
            return (typeof(v325) ~= "table" or #v325 <= 0) and "Send Gifts" or (#v325 == 1 and "1 Gift Available" or ("%* Gifts Available"):format(#v325))
        end
        v_u_6.observeTag("ValentinesGiftSubtitle", function(p_u_327)
            return v_u_323(v_u_324, function()
                p_u_327.Text = v_u_326()
            end)
        end)
        v_u_6.observeTag("ValentinesMailboxRotate", function(p_u_328)
            local v_u_329 = p_u_328:GetPivot()
            local v_u_338 = v_u_323(v_u_324, function()
                local v330 = v_u_324:Get({ "ValentinesEvent", "GiftInventory" })
                local v331
                if typeof(v330) == "table" then
                    v331 = #v330 > 0
                else
                    v331 = false
                end
                local v332 = v_u_12.target
                local v333 = p_u_328
                local v334 = 0.75
                local v335 = 3
                local v336 = {}
                local v337
                if v331 then
                    v337 = v_u_329 * CFrame.Angles(0, 0, 1.5707963267948966)
                else
                    v337 = v_u_329
                end
                v336.Pivot = v337
                v332(v333, v334, v335, v336)
            end)
            return function()
                v_u_338()
                v_u_12.stop(p_u_328)
                p_u_328:PivotTo(v_u_329)
            end
        end)
    end
end
function v_u_48._createMailboxVFX(_)
    local v_u_339 = v_u_5:Wait(v_u_36)
    if v_u_339 then
        v_u_6.observeTag("ValentinesShopModel", function(p_u_340)
            local v341 = p_u_340:WaitForChild("VFX", 5)
            if not v341 then
                return nil
            end
            local v_u_342 = v341:FindFirstChild("MinorGlow")
            local v_u_343 = v341:FindFirstChild("GlowAndHearts")
            local v_u_344 = v341:FindFirstChild("Burst")
            local function v_u_347()
                local v345 = v_u_339:Get({ "ValentinesEvent", "GiftInventory" })
                local v346
                if typeof(v345) == "table" then
                    v346 = #v345 > 0
                else
                    v346 = false
                end
                if v346 then
                    if v_u_342 then
                        v_u_35.disable(v_u_342)
                    end
                    if v_u_343 then
                        v_u_35.enable(v_u_343)
                        return
                    end
                else
                    if v_u_342 then
                        v_u_35.enable(v_u_342)
                    end
                    if v_u_343 then
                        v_u_35.disable(v_u_343)
                    end
                end
            end
            local v_u_348 = v_u_339:OnArrayInserted({ "ValentinesEvent", "GiftInventory" }, function()
                if v_u_344 and v_u_48:IsEnabled() then
                    v_u_35.emit(v_u_344)
                    v_u_33:PlaySound(v_u_1.Sounds.Sfx.ValentinesMailboxBurst, p_u_340:GetPivot().Position, false)
                end
                v_u_347()
            end)
            local v_u_349 = v_u_339:OnArrayRemoved({ "ValentinesEvent", "GiftInventory" }, function()
                v_u_347()
            end)
            local v_u_350 = v_u_339:OnChanged({ "ValentinesEvent", "GiftInventory" }, function()
                v_u_347()
            end)
            v_u_347()
            return function()
                if v_u_348 then
                    v_u_348:Disconnect()
                end
                if v_u_349 then
                    v_u_349:Disconnect()
                end
                if v_u_350 then
                    v_u_350:Disconnect()
                end
            end
        end)
    end
end
function v_u_48._createGiftNotifications(_)
    local v_u_351 = v_u_37:WaitForChild("ValentinesGifts").ValentinesGifts
    v_u_41.OnClientEvent:Connect(function(p_u_352)
        local v_u_353 = v_u_351.Template:Clone()
        v_u_353.Visible = true
        local v354 = v_u_353:FindFirstChild("Icon") or v_u_353:FindFirstChild("PlayerIcon")
        if v354 then
            v354.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(p_u_352.Sender)
        end
        local v_u_355 = v_u_353:FindFirstChild("Username")
        if v_u_355 then
            if p_u_352.SenderUsername then
                v_u_355.Text = ("@%* sent you a gift!"):format(p_u_352.SenderUsername)
            else
                v_u_355.Text = "Someone sent you a gift!"
                task.spawn(function()
                    local v356 = v_u_17:GetUser(p_u_352.Sender)
                    if v356 and v_u_353.Parent then
                        v_u_355.Text = ("@%* sent you a gift!"):format(v356.Username)
                    end
                end)
            end
        end
        local v_u_357 = v_u_30:Add(v_u_353)
        local v358 = v_u_353:FindFirstChild("Yes")
        if v358 then
            local v359 = v_u_13.new(v358)
            v359:Animate()
            v359.OnActivated:Connect(function()
                v_u_33:PlaySound("Sounds.Sfx.Activated")
                v_u_357()
                if p_u_352.Id then
                    local v360, v361 = v_u_39:InvokeServer(p_u_352.Id)
                    if v360 then
                        v_u_48:OpenAnimation(v361)
                    end
                end
            end)
        end
        local v362 = v_u_353:FindFirstChild("No")
        if v362 then
            local v363 = v_u_13.new(v362)
            v363:Animate()
            v363.OnActivated:Connect(function()
                v_u_357()
            end)
        end
        v_u_21(v_u_353.Fill, TweenInfo.new(15), {
            ["Size"] = UDim2.fromScale(0, v_u_353.Fill.Size.Y.Scale)
        })
        task.delay(15, v_u_357)
    end)
end
function v_u_48.IsEnabled(_)
    return false
end
function v_u_48.Start(_)
    local v_u_364 = v_u_5:Wait(v_u_36)
    if v_u_364 then
        task.spawn(v_u_48._createGiftsTab, v_u_48)
        task.spawn(v_u_48._createShopTabs, v_u_48)
        task.spawn(v_u_48._createRightFrame, v_u_48)
        task.spawn(v_u_48._createPlayerList, v_u_48)
        task.spawn(v_u_48._createShopObjects, v_u_48)
        task.spawn(v_u_48._createGiftNotifications, v_u_48)
        task.spawn(v_u_48._createGiftSubtitleLabel, v_u_48)
        task.spawn(v_u_48._createMailboxVFX, v_u_48)
        local v_u_365 = v_u_42.SideBtns.Gifts.Notification
        v_u_323(v_u_364, function()
            local v366 = false
            v_u_365.Visible = false
            v_u_365.Txt.Text = tostring(v366)
        end)
        local function v368()
            local v367 = v_u_48:IsEnabled()
            v_u_42.SideBtns.Visible = v367
            v_u_42.Header.DiscountText1.Visible = v367
            v_u_42.Header.DiscountText2.Visible = v367
            if not (v367 or v_u_42.Sections.Gifts.Visible) then
                v_u_48:SetTab("Gifts")
            end
        end
        v_u_19.OnUpdateEnabled:Connect(v368)
        v_u_19.OnUpdateDisabled:Connect(v368)
        task.spawn(v368)
        v_u_6.observeTag("ValentinesGiftsPrompt", function(p369)
            local v_u_370 = p369.Triggered:Connect(function()
                if v_u_5:Get(v_u_36) then
                    v_u_48:Open()
                end
            end)
            return function()
                v_u_370:Disconnect()
            end
        end)
    end
end
return v_u_48