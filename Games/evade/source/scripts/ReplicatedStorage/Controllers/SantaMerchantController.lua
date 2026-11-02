-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
game:GetService("ServerStorage")
game:GetService("SoundService")
local v_u_2 = game:GetService("TweenService")
game:GetService("HttpService")
game:GetService("RunService")
game:GetService("StarterGui")
local v_u_3 = game:GetService("Players")
require(v_u_1.Packages.Serialization)
local v_u_4 = require(v_u_1.Packages.Synchronizer)
require(v_u_1.Packages.CreateTween)
require(v_u_1.Packages.TopbarPlus)
local v_u_5 = require(v_u_1.Packages.Gradients)
local v_u_6 = require(v_u_1.Packages.Observers)
require(v_u_1.Shared.Mutations)
local v_u_7 = require(v_u_1.Packages.FFlags)
local v_u_8 = require(v_u_1.Packages.Signal)
local v_u_9 = require(v_u_1.Packages.Timer)
local v_u_10 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Spr)
local v11 = require(v_u_1.Packages.Net)
local v_u_12 = require(v_u_1.Shared.Marketplace)
local v_u_13 = require(v_u_1.Controllers.NotificationController)
require(v_u_1.Controllers.NewPlayersController)
local v_u_14 = require(v_u_1.Controllers.InterfaceController)
require(v_u_1.Controllers.CharacterController)
local v_u_15 = require(v_u_1.Controllers.SoundController)
require(v_u_1.Controllers.PlotController)
local v_u_16 = require(v_u_1.Controllers.ShopController)
local v_u_17 = require(v_u_1.Utils.NumberUtils)
local v_u_18 = require(v_u_1.Utils.TimeUtils)
require(v_u_1.Utils.MathUtils)
local v_u_19 = require(v_u_1.Shared.VFX)
local v_u_20 = require(v_u_1.Classes.AnimatedButton)
local v_u_21 = require(v_u_1.Shared.Updates)
require(v_u_1.Shared.Animals)
local v_u_22 = require(v_u_1.Shared.Animals)
require(v_u_1.Shared.Index)
require(v_u_1.Datas.Mutations)
local v_u_23 = require(v_u_1.Datas.Rarities)
local v_u_24 = require(v_u_1.Datas.Animals)
local v_u_25 = require(v_u_1.Datas.SantaMerchantData)
local v_u_26 = v_u_3.LocalPlayer
local v_u_27 = v_u_26.PlayerGui:WaitForChild("SantaMerchant").SantaMerchant
local v_u_28 = v_u_27.Brainrots
local v_u_29 = v_u_27.Header.Close
local v30 = v_u_27.GiftPlayerSelect
local v_u_31 = v30:WaitForChild("GiftButton")
local v_u_32 = v_u_31:WaitForChild("Txt")
local v_u_33 = v30:WaitForChild("PlayerSelected")
local v_u_34 = v_u_33:WaitForChild("PlayerImage"):WaitForChild("Headshot")
local v_u_35 = v_u_33:WaitForChild("PlayerName")
local v_u_36 = v11:RemoteEvent("SantaMerchantService/CollectGoldElf")
local v_u_37 = v11:RemoteEvent("SantaMerchantService/SetFocused")
local v_u_38 = v11:RemoteEvent("SantaMerchantService/Animation")
local v_u_39 = v11:RemoteFunction("SantaMerchantService/Buy")
local v_u_40 = v11:RemoteEvent("ShopService/Purchase")
local v_u_41 = nil
return {
    ["Start"] = function(_)
        -- upvalues: (copy) v_u_27, (ref) v_u_41, (copy) v_u_14, (copy) v_u_29, (copy) v_u_37, (copy) v_u_24, (copy) v_u_23, (copy) v_u_5, (copy) v_u_22, (copy) v_u_25, (copy) v_u_8, (copy) v_u_28, (copy) v_u_1, (copy) v_u_17, (copy) v_u_12, (copy) v_u_20, (copy) v_u_39, (copy) v_u_15, (copy) v_u_40, (copy) v_u_16, (copy) v_u_3, (copy) v_u_32, (copy) v_u_33, (copy) v_u_35, (copy) v_u_34, (copy) v_u_31, (copy) v_u_9, (copy) v_u_7, (copy) v_u_18, (copy) v_u_21, (copy) v_u_13, (copy) v_u_4, (copy) v_u_26, (copy) v_u_2, (copy) v_u_36, (copy) v_u_6, (copy) v_u_10, (copy) v_u_38, (copy) v_u_19
        v_u_27.Visible = false
        v_u_41 = v_u_14:Register("SantaMerchant", v_u_27, "TopQuint")
        v_u_41:AttachCloseButton(v_u_29)
        v_u_41.OnOpen:Connect(function()
            -- upvalues: (ref) v_u_37
            v_u_37:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", true)
        end)
        v_u_41.OnClose:Connect(function()
            -- upvalues: (ref) v_u_37
            v_u_37:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", false)
        end)
        v_u_41:Close()
        local function v46(p42, p43)
            -- upvalues: (ref) v_u_24, (ref) v_u_23, (ref) v_u_5, (ref) v_u_22
            local v44 = v_u_24[p43]
            if v44 then
                local v45 = v_u_23[v44.Rarity]
                p42.Title.Text = p43
                if v45.GradientPreset then
                    p42.Title.TextColor3 = Color3.new(1, 1, 1)
                    v_u_5.apply(p42.Title, v45.GradientPreset)
                else
                    p42.Title.TextColor3 = v45.Color
                end
                p42.Visible = true
                v_u_22:AttachOnViewportWithOptimizations(p43, p42.ViewportFrame)
            end
        end
        local v_u_47 = table.create(#v_u_25.Brainrots)
        local v_u_48 = v_u_8.new()
        for v_u_49, v_u_50 in v_u_25.Brainrots do
            local v_u_51 = v_u_50.Brainrot
            local _ = v_u_24[v_u_51]
            local v_u_52 = v_u_28:FindFirstChild((tostring(v_u_49))) or v_u_28.UIGridLayout.Template:Clone()
            v_u_47[v_u_49] = v_u_52
            v_u_52.Visible = true
            v_u_52.LayoutOrder = v_u_49
            v46(v_u_52, v_u_51)
			local function v57()
				local v53 = v_u_51
				local v54 = v_u_1:GetAttribute(("SantaMerchant_%*"):format(string.gsub(v53, "%s", "_"))) or 0

				v_u_52.Quantity.Text = v54 <= 0 and "SOLD OUT" or ("%* Left"):format(v_u_17:Comma(v54))

				local v55 = v_u_52.Quantity
				local v56 = v54 > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 72, 72)  
				v55.TextColor3 = v56
			end

			v57()
			v_u_48:Connect(v57)
			v_u_1:GetAttributeChangedSignal(("SantaMerchant_%*"):format(string.gsub(v_u_51, "%s", "_"))):Connect(v57)
			v57()
			v_u_48:Connect(v57)
			v_u_1:GetAttributeChangedSignal(("SantaMerchant_%*"):format(string.gsub(v_u_51, "%s", "_"))):Connect(v57)
            v57()
            v_u_48:Connect(v57)
            v_u_1:GetAttributeChangedSignal((("SantaMerchant_%*"):format((string.gsub(v_u_51, "%s", "_"))))):Connect(v57)
            v_u_52.DropRate.Text = ("$%*/s"):format((v_u_17:ToString(v_u_22:GetGeneration(v_u_51))))
            v_u_52.BuyYellow.Price.Text = v_u_17:ToString(v_u_50.Price or 0)
            if v_u_50.ProductId then
                v_u_52.Buy.Price.Text = "\238\128\130???"
                task.spawn(function()
                    -- upvalues: (ref) v_u_17, (ref) v_u_12, (copy) v_u_50, (copy) v_u_52
                    local v58 = v_u_12:GetProductInfo(v_u_50.ProductId, "Product")
                    local v59 = v_u_52.Buy.Price
                    local v60 = v58.PriceInRobux or 999999999
                    v59.Text = ("\238\128\130%*"):format(v60 == 999999999 and "???" or v_u_17:Comma(v60))
                end)
            end
            v_u_52.Parent = v_u_28
            local v61 = v_u_20.new(v_u_52.BuyYellow)
            v61:Animate()
            v61.OnActivated:Connect(function()
                -- upvalues: (ref) v_u_39, (copy) v_u_49, (ref) v_u_15, (ref) v_u_14
                if v_u_39:InvokeServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", v_u_49) then
                    v_u_15:PlaySound("Sounds.Sfx.Success")
                    v_u_14:SetState("SantaMerchant", false)
                end
            end)
            if v_u_50.ProductId then
                local v62 = v_u_20.new(v_u_52.Buy)
                v62:Animate()
                v62.OnActivated:Connect(function()
                    -- upvalues: (ref) v_u_40, (copy) v_u_50, (ref) v_u_16
                    v_u_40:FireServer(v_u_50.ProductId, v_u_16:GetGiftingTarget())
                end)
            end
        end
        local function v69()
            -- upvalues: (ref) v_u_16, (ref) v_u_3, (ref) v_u_32, (ref) v_u_33, (ref) v_u_35, (ref) v_u_34, (copy) v_u_47
            local v63 = v_u_16:GetGiftingTarget()
            if v63 then
                local v64 = v_u_3:GetPlayerByUserId(v63)
                v_u_32.Text = "Back"
                v_u_33.Visible = true
                local v65 = v_u_35
                local v66
                if v64 then
                    v66 = "@" .. v64.Name or v63
                else
                    v66 = v63
                end
                v65.Text = v66
                v_u_34.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v63)
                for _, v67 in v_u_47 do
                    v67.BuyYellow.Visible = false
                end
            else
                v_u_33.Visible = false
                v_u_32.Text = "Gift Player"
                for _, v68 in v_u_47 do
                    v68.BuyYellow.Visible = true
                end
            end
        end
        v_u_16.ToggleGiftSignal:Connect(v69)
        task.spawn(v69)
        local v70 = v_u_20.new(v_u_31)
        v70:Animate()
        v70.OnActivated:Connect(function()
            -- upvalues: (ref) v_u_16
            if v_u_16:GetGiftingTarget() then
                v_u_16:RemoveGiftingTarget()
            else
                v_u_16:OpenGiftingScreen()
            end
        end)
        v_u_41.OnClose:Connect(function()
            -- upvalues: (ref) v_u_16
            if v_u_16:GetGiftingTarget() then
                v_u_16:RemoveGiftingTarget()
            end
        end)
        local v_u_71 = v_u_1:GetAttribute("SantaMerchantStockId")
        v_u_9.Simple(1, function()
            -- upvalues: (ref) v_u_1, (ref) v_u_7, (ref) v_u_18, (ref) v_u_71, (copy) v_u_48, (ref) v_u_21, (ref) v_u_13, (ref) v_u_27
            local v72 = workspace:GetServerTimeNow() + (v_u_1:GetAttribute("__timeSkipDebugSantaMerchant") or 0)
            local v73 = v_u_1
            local v74 = tonumber(v73:GetAttribute("SantaMerchantNextStockId"))
            local v75
            if v74 then
                local v76 = v_u_7:GetInstant("SantaMerchantService/LeavingTimestamp", 1766790000)
                if v74 + 1 < v72 then
                    v75 = ("Leaves in %*"):format((v_u_18:E(v76 - v72)))
                else
                    v75 = ("Restocking in %*"):format((v_u_18:E(v74 - v72)))
                end
            else
                v75 = ""
            end
            local v77 = workspace:FindFirstChild("Santa Merchant")
            local v78 = v_u_1:GetAttribute("SantaMerchantStockId")
            if v_u_71 ~= v78 then
                local v79 = v_u_71
                v_u_71 = v78
                v_u_48:Fire()
                if v79 ~= nil and (v_u_71 ~= nil and (v_u_21.Methods.IsEnabled("Update-12/24/2025") and (v77 ~= nil and not v77:GetAttribute("Hidden")))) then
                    v_u_13:Notify("The <font color=\'#ce4d4c\'>Santa\'s Shop</font> has Restocked!", 10, "Sounds.Sfx.Success")
                end
            end
            v_u_27.Header.Title.Text = v75
            if v77 then
                v77.Overhead.BillboardGui.Countdown.Text = v75
            end
        end)
        v_u_4:WaitAndCall(v_u_26, function(p_u_80)
            -- upvalues: (ref) v_u_27, (ref) v_u_17
            local function v82()
                -- upvalues: (copy) p_u_80, (ref) v_u_27, (ref) v_u_17
                local v81 = p_u_80:Get("ChristmasEvent.GoldElves") or 0
                v_u_27.Header.Elves.Amount.Text = v_u_17:Comma(v81)
            end
            p_u_80:OnChanged("ChristmasEvent.GoldElves", v82)
            task.spawn(v82)
        end)
        local function v_u_88(p83, p84)
            -- upvalues: (ref) v_u_2
            local v85 = p83.Character
            if v85 then
                local v86 = v85:FindFirstChild("HumanoidRootPart")
                if v86 then
                    local v_u_87 = script.Reward:Clone()
                    v_u_87.Currency.Text = ("+%*"):format(p84)
                    v_u_87.Parent = v86
                    v_u_2:Create(v_u_87, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        ["StudsOffset"] = Vector3.new(0, 2.5, 2.2)
                    }):Play()
                    v_u_2:Create(v_u_87.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                        ["ImageTransparency"] = 1
                    }):Play()
                    v_u_2:Create(v_u_87.Currency, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                        ["TextTransparency"] = 1
                    }):Play()
                    v_u_2:Create(v_u_87.Currency.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                        ["Transparency"] = 1
                    }):Play()
                    task.delay(5, function()
                        -- upvalues: (copy) v_u_87
                        v_u_87:Destroy()
                    end)
                end
            else
                return
            end
        end
        v_u_36.OnClientEvent:Connect(function(p89, p_u_90)
            -- upvalues: (ref) v_u_15, (ref) v_u_1, (copy) v_u_88
            local v_u_91 = script.Smoke:Clone()
            v_u_91:PivotTo(p_u_90)
            v_u_91.Parent = workspace
            v_u_91.smoke1:Emit(5)
            task.spawn(function()
                -- upvalues: (ref) v_u_15, (ref) v_u_1, (copy) p_u_90
                v_u_15:PlaySound(v_u_1.Sounds.Sfx.Puff2, p_u_90.Position, false)
            end)
            task.delay(3, function()
                -- upvalues: (copy) v_u_91
                v_u_91:Destroy()
            end)
            v_u_88(p89, 1)
        end)
        v_u_6.observeTag("SantaMerchantNPC", function(p92)
            -- upvalues: (ref) v_u_10
            local v93 = v_u_10.new()
            local v_u_94 = p92.Humanoid.Animator:LoadAnimation(script.Idle)
            v93:Add(function()
                -- upvalues: (copy) v_u_94
                v_u_94:Stop(0)
                v_u_94:Destroy()
            end)
            v_u_94.Priority = Enum.AnimationPriority.Idle
            v_u_94.Looped = true
            v_u_94:Play()
            return v93:WrapClean()
        end, { workspace })
		v_u_38.OnClientEvent:Connect(function(_, p95)
			print("[Client VFX] Received animation: " .. tostring(p95))
            -- upvalues: (ref) v_u_15, (ref) v_u_1, (ref) v_u_19
            local v_u_96 = workspace:FindFirstChild("Santa Merchant")
            if v_u_96 then
                local v97 = v_u_96.VFX:FindFirstChild(p95) or script.VFX["1"]
                if v97 then
                    task.spawn(function()
                        -- upvalues: (ref) v_u_15, (ref) v_u_1, (copy) v_u_96
                        v_u_15:PlaySound(v_u_1.Sounds.Sfx.SantaMerchantSFX, v_u_96.SpawnPart.Position, false)
                    end)
                    v_u_19.emit(v97)
                end
            else
                return
            end
        end)
        v_u_6.observeTag("SantaMerchantPrompt", function(p_u_98)
            -- upvalues: (ref) v_u_10, (ref) v_u_4, (ref) v_u_26, (ref) v_u_9, (ref) v_u_14
            local v_u_99 = v_u_10.new()
            local function v_u_100()
                -- upvalues: (ref) v_u_4, (ref) v_u_26, (copy) p_u_98
                if v_u_4:Wait(v_u_26) then
                    p_u_98.ObjectText = "Santa\'s Shop"
                    p_u_98.ActionText = "View" 
 
                end
            end
            v_u_99:Add(task.spawn(function()
                -- upvalues: (ref) v_u_4, (ref) v_u_26, (copy) v_u_99, (ref) v_u_9, (copy) v_u_100
                if v_u_4:Wait(v_u_26) then
                    v_u_99:Add(v_u_9.Simple(1, v_u_100))
                    task.spawn(v_u_100)
                end
            end))
            v_u_99:Add(p_u_98.Triggered:Connect(function()
                -- upvalues: (ref) v_u_4, (ref) v_u_26, (ref) v_u_14
                if v_u_4:Get(v_u_26) then
                    v_u_14:Toggle("SantaMerchant")
                end
            end))
            return function()
                -- upvalues: (copy) v_u_99
                v_u_99:Destroy()
            end
        end)
    end
}