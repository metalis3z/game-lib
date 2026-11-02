-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SoundService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("TweenService")
local v6 = v_u_1:WaitForChild("Controllers")
local v_u_7 = require(v6.InterfaceController)
require(v6.ShopController)
local v_u_8 = require(v6.NotificationController)
require(v6.SoundController)
local v9 = v_u_1:WaitForChild("Packages")
local v_u_10 = require(v9.Observers)
local v_u_11 = require(v9.Synchronizer)
local v_u_12 = require(v9.Timer)
require(v9.Trove)
local v13 = require(v9.Net)
local v14 = v_u_1:WaitForChild("Utils")
local v_u_15 = require(v14.TimeUtils)
local v_u_16 = require(v14.NumberUtils)
local v17 = v_u_1:WaitForChild("Datas")
local v_u_18 = require(v17.CursedSpinWheel)
local v_u_19 = require(v17.Shop)
local v20 = v_u_1:WaitForChild("Classes")
local v_u_21 = require(script.CursedSpinWheel)
local v_u_22 = require(v20.AnimatedButton)
local v23 = v_u_1:WaitForChild("Shared")
local v_u_24 = require(v23.Marketplace)
local v_u_25 = v4.LocalPlayer
local v_u_26 = v_u_25.PlayerGui:WaitForChild("CursedWheel").CursedWheel
local v_u_27 = nil
local v_u_28 = false
local v_u_29 = v13:RemoteEvent("ShopService/Purchase")
local v_u_30 = v13:RemoteEvent("CursedEventService/Spin")
v13:RemoteFunction("CursedEventService/RequestBuy")
local v_u_31 = false
local v32 = {}
local function v_u_51(p33, p34)
    -- upvalues: (copy) v_u_11, (copy) v_u_25, (ref) v_u_31, (copy) v_u_26, (copy) v_u_2, (ref) v_u_28, (copy) v_u_3, (copy) v_u_5, (copy) v_u_18, (copy) v_u_19, (copy) v_u_16, (copy) v_u_8
    local v35 = v_u_11:Wait(v_u_25)
    if not v_u_31 then
        v_u_31 = true
        local v_u_36 = v_u_26.Wheel
        local v37 = v_u_2:FindFirstChild("Spinning")
        local v38 = v_u_28 and 1 or 0.8
        if v37 then
            v37.Looped = true
            v37.Volume = v38
            v37:Play()
        end
        local v39 = (p33 - 1) * -60 - (math.random() - 0.5) * 0.7 * 60
        local v40 = v39 + (v_u_28 and 1 or 9) * 360
        local v41 = v_u_28 and 0.5 or 5
        local v_u_42 = nil
        local v44 = v_u_3.PostSimulation:Connect(function()
            -- upvalues: (copy) v_u_36, (ref) v_u_42, (ref) v_u_26, (ref) v_u_5
            debug.profilebegin("CursedEventController:ResultAnimation")
            local v43 = (v_u_36.Rotation + 30) / 60 // 1
            if v_u_42 ~= v43 then
                v_u_42 = v43
                v_u_26.Tick.Rotation = -40
                v_u_5:Create(v_u_26.Tick, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Rotation"] = 0
                }):Play()
            end
            debug.profileend()
        end)
        local v45 = v_u_5:Create(v_u_36, TweenInfo.new(v41, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Rotation"] = v40
        })
        if v37 then
            v_u_5:Create(v37, TweenInfo.new(v41, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
        end
        v45:Play()
        v45.Completed:Wait()
        v44:Disconnect()
        v_u_36.Rotation = v39
        if v37 then
            v37:Stop()
            v37.Volume = v38
        end
        local v46 = p34 == true and v_u_18.AltRewards[p33] or v_u_18.Rewards[p33]
        local v47
        if v46.Type == "Cash-Pack" then
            local v48 = v_u_19[v46.Index]
            if not v_u_19 then
                return false
            end
            local v49 = v48.Value or 0
            local v50 = v35:Get("Rebirth") or 0
            if v50 > 0 then
                v49 = v49 * (v50 <= 1 and 1.5 or v50)
            end
            v47 = ("$%*"):format((v_u_16:ToString(v49, 2)))
        else
            v47 = v46.Display
        end
        v_u_8:Success((("You received %*!"):format(v47)))
        v_u_31 = false
    end
end
function v32.SetupCursedWheel(_)
    -- upvalues: (ref) v_u_27, (copy) v_u_7, (copy) v_u_26, (copy) v_u_11, (copy) v_u_25, (copy) v_u_18, (copy) v_u_19, (copy) v_u_16, (copy) v_u_24, (ref) v_u_31, (copy) v_u_22, (ref) v_u_28, (copy) v_u_29, (copy) v_u_30, (copy) v_u_1, (copy) v_u_15, (copy) v_u_51, (copy) v_u_12, (copy) v_u_10, (copy) v_u_21
    v_u_27 = v_u_7:Register("CursedWheel", v_u_26, "TopQuint")
    v_u_27:AttachCloseButton(v_u_26.Close)
    v_u_27:Close()
    local v_u_52 = v_u_11:Wait(v_u_25)
    local function v_u_75()
        -- upvalues: (ref) v_u_26, (ref) v_u_18, (copy) v_u_52, (ref) v_u_19, (ref) v_u_16, (ref) v_u_24
        local v53 = v_u_26.Wheel
        local v54 = v53.Items
        local v55 = v53.Names
        local v56 = v53.Odds
        local v57 = {}
        for v58 = 1, #v_u_18.Rewards do
            local v59 = v_u_18.Rewards[v58]
            if v59 then
                if v59.Type == "Item" and v_u_52:Get((("Items.%*"):format(v59.Index))) then
                    v59 = v_u_18.AltRewards[v58]
                end
                v57[v58] = v59.Weight
            end
        end
        local v60 = 0
        for _, v61 in v57 do
            v60 = v60 + v61
        end
        v57[5] = v57[5] + (100 - v60)
        for v62 = 1, #v_u_18.Rewards do
            local v63 = v_u_18.Rewards[v62]
            if v63 then
                if v63.Type == "Item" and v_u_52:Get((("Items.%*"):format(v63.Index))) then
                    v63 = v_u_18.AltRewards[v62]
                end
                local v64 = v54:FindFirstChild(v62)
                local v65 = v55:FindFirstChild(v62)
                local v66 = v56:FindFirstChild(v62)
                local v67 = ""
                local v68
                if v63.Type == "Cash-Pack" then
                    local v69 = v_u_19[v63.Index].Value
                    local v70 = v_u_52:Get("Rebirth") or 0
                    if v70 > 0 then
                        v69 = v69 * (v70 <= 1 and 1.5 or v70)
                    end
                    v67 = ("$%*"):format((v_u_16:ToString(v69, 2)))
                    v68 = v_u_24:GetProductInfo(v63.Index, "Product").Icon
                else
                    v68 = v63.Icon
                end
                local v71 = v63.Display
                local v72 = v67 == "" and v71 and v71 or v67
                local v73 = v57[v62] * 100
                local v74 = ("%*%%"):format(math.floor(v73) / 100)
                v64.Image = v68
                v65.Text = v72
                v66.Text = v74
            end
        end
    end
    v_u_75()
    v_u_52:OnDictionaryInserted("Items", function(_, p76)
        -- upvalues: (ref) v_u_18, (ref) v_u_31, (copy) v_u_75
        local v77 = false
        for v78 = 1, #v_u_18.Rewards do
            local v79 = v_u_18.Rewards[v78]
            if v79.Type == "Item" and p76 == v79.Index then
                v77 = true
                break
            end
        end
        if v77 then
            while v_u_31 do
                task.wait()
            end
            v_u_75()
        end
    end)
    local v_u_80 = v_u_26.FastSpin.Toggle
    local v81 = v_u_22.new(v_u_80)
    v81:Animate()
    v81.OnActivated:Connect(function()
        -- upvalues: (ref) v_u_28, (copy) v_u_80
        v_u_28 = not v_u_28
        v_u_80.Checkmark.Visible = v_u_28
    end)
    v_u_80.Checkmark.Visible = v_u_28
    for _, v_u_82 in v_u_26.Buttons:GetChildren() do
        if v_u_82:IsA("ImageButton") and v_u_82.Name ~= "Spin" then
            local v83 = v_u_22.new(v_u_82)
            v83:Animate()
            v83.OnActivated:Connect(function()
                -- upvalues: (ref) v_u_29, (copy) v_u_82
                v_u_29:FireServer(v_u_82:GetAttribute("ProductId"))
            end)
            local v84 = v_u_24:GetProductInfo(v_u_82:GetAttribute("ProductId"), "Product")
            v_u_82.RbxAmount.Text = v84.PriceInRobux
        end
    end
    local v_u_85 = v_u_26.Buttons.Spin
    local v86 = v_u_22.new(v_u_85)
    v86:Animate()
    v86.OnActivated:Connect(function()
        -- upvalues: (ref) v_u_31, (ref) v_u_30
        if v_u_31 ~= true then
            v_u_30:FireServer()
        end
    end)
    local function v_u_91()
        -- upvalues: (ref) v_u_1, (copy) v_u_52, (copy) v_u_85, (ref) v_u_15, (ref) v_u_26
        local v87 = 0
        if v_u_1:GetAttribute("CursedEvent") then
            if v_u_52:Get("CursedSpinWheel.LastFreeClaimed") == v_u_1:GetAttribute("CursedEventLastTime") then
                v_u_85.Main.Timer.Text = ("Free Spin in %*"):format((v_u_15:D((v_u_1:GetAttribute("NextCursedEvent") or 0) - workspace:GetServerTimeNow())))
            else
                v87 = v87 + 1
                v_u_85.Main.Timer.Text = "SPIN NOW"
            end
        else
            v_u_85.Main.Timer.Text = ("Free Spin in %*"):format((v_u_15:D((v_u_1:GetAttribute("NextCursedEvent") or 0) - workspace:GetServerTimeNow())))
        end
        local v88 = v87 + v_u_52:Get("CursedSpinWheel.Spins")
        v_u_85.Main.Spins.Text = v88 > 1 and ("Spins (%*)"):format(v88) or ("Spin (%*)"):format(v88)
        v_u_85.Main.UIGradient.Enabled = v88 <= 0
        local v89 = workspace:GetServerTimeNow() - v_u_52:Get("CursedSpinWheel.LastDailyDiscount") >= 86400
        v_u_26.Buttons.Buy1.Visible = not v89
        v_u_26.Buttons.Buy1Discount.Visible = v89
        local v90 = v_u_52:Get("CursedSpinWheel.PaidSpins.x3") >= 5
        v_u_26.Buttons.Buy10.Visible = v90
        v_u_26.Buttons.Buy3.Visible = not v90
    end
    v_u_30.OnClientEvent:Connect(function(p92, p93)
        -- upvalues: (copy) v_u_91, (ref) v_u_51
        task.spawn(v_u_91)
        v_u_51(p92, p93)
    end)
    v_u_12.Simple(1, v_u_91)
    v_u_10.observeTag("CursedSpinWheel", function(p94)
        -- upvalues: (ref) v_u_21
        local v_u_95 = v_u_21.new(p94)
        return function()
            -- upvalues: (copy) v_u_95
            v_u_95:Destroy()
        end
    end)
    v_u_1:GetAttributeChangedSignal("CursedWheelActive"):Connect(function()
        -- upvalues: (ref) v_u_1, (ref) v_u_27, (ref) v_u_7
        if v_u_1:GetAttribute("CursedWheelActive") == false and v_u_27:IsOpened() then
            v_u_7:Toggle("CursedWheel", false)
        end
    end)
end
function v32.Start(p96)
    p96:SetupCursedWheel()
end
return v32