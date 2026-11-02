-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("TweenService")
local v5 = v_u_1:WaitForChild("Controllers")
local v_u_6 = require(v5.InterfaceController)
require(v5.ShopController)
local v_u_7 = require(v5.NotificationController)
require(v5.SoundController)
local v8 = v_u_1:WaitForChild("Packages")
local v_u_9 = require(v8.Observers)
local v_u_10 = require(v8.Synchronizer)
local v_u_11 = require(v8.Timer)
require(v8.Trove)
local v12 = require(v8.Net)
local v13 = v_u_1:WaitForChild("Utils")
require(v13.TimeUtils)
local v_u_14 = require(v13.NumberUtils)
local v15 = v_u_1:WaitForChild("Datas")
local v_u_16 = require(v15.ChristmasSpinWheel)
local v_u_17 = require(v15.Shop)
local v18 = v_u_1:WaitForChild("Classes")
local v_u_19 = require(script.ChristmasSpinWheel)
local v_u_20 = require(v18.AnimatedButton)
local v21 = v_u_1:WaitForChild("Shared")
local v_u_22 = require(v21.Marketplace)
local v_u_23 = require(v_u_1.Shared.Animals)
local v_u_24 = v3.LocalPlayer
local v_u_25 = v_u_24.PlayerGui:WaitForChild("ChristmasWheel").ChristmasWheel
local v_u_26 = nil
local v_u_27 = false
local v_u_28 = v12:RemoteEvent("ShopService/Purchase")
local v_u_29 = v12:RemoteEvent("ChristmasEventService/Spin")
v12:RemoteFunction("ChristmasEventService/RequestBuy")
local v_u_30 = false
local v31 = {}
local function v_u_50(p32, p33)
    -- upvalues: (copy) v_u_10, (copy) v_u_24, (ref) v_u_30, (copy) v_u_25, (ref) v_u_27, (copy) v_u_2, (copy) v_u_4, (copy) v_u_16, (copy) v_u_17, (copy) v_u_14, (copy) v_u_7
    local v34 = v_u_10:Wait(v_u_24)
    if not v_u_30 then
        v_u_30 = true
        local v_u_35 = v_u_25.Wheel
        local v36 = v_u_35:FindFirstChild("Spinning")
        local v37 = v_u_27 and 1 or 0.8
        if v36 then
            v36.Looped = true
            v36.Volume = v37
            v36:Play()
        end
        local v38 = (p32 - 1) * -60 - (math.random() - 0.5) * 0.7 * 60
        local v39 = v38 + (v_u_27 and 1 or 9) * 360
        local v40 = v_u_27 and 0.5 or 5
        local v_u_41 = nil
        local v43 = v_u_2.PostSimulation:Connect(function()
            -- upvalues: (copy) v_u_35, (ref) v_u_41, (ref) v_u_25, (ref) v_u_4
            debug.profilebegin("ChristmasEventController:ResultAnimation")
            local v42 = (v_u_35.Rotation + 30) / 60 // 1
            if v_u_41 ~= v42 then
                v_u_41 = v42
                v_u_25.Tick.Rotation = -40
                v_u_4:Create(v_u_25.Tick, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Rotation"] = 0
                }):Play()
            end
            debug.profileend()
        end)
        local v44 = v_u_4:Create(v_u_35, TweenInfo.new(v40, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Rotation"] = v39
        })
        if v36 then
            v_u_4:Create(v36, TweenInfo.new(v40, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
        end
        v44:Play()
        v44.Completed:Wait()
        v43:Disconnect()
        v_u_35.Rotation = v38
        if v36 then
            v36:Stop()
            v36.Volume = v37
        end
        local v45 = p33 == true and v_u_16.AltRewards[p32] or v_u_16.Rewards[p32]
        local v46
        if v45.Type == "Cash-Pack" then
            local v47 = v_u_17[v45.Index]
            if not v_u_17 then
                return false
            end
            local v48 = v47.Value or 0
            local v49 = v34:Get("Rebirth") or 0
            if v49 > 0 then
                v48 = v48 * (v49 <= 1 and 1.5 or v49)
            end
            v46 = ("$%*"):format((v_u_14:ToString(v48, 2)))
        else
            v46 = v45.Display
        end
        v_u_7:Success((("You received %*!"):format(v46)))
        v_u_30 = false
    end
end
function v31.SetupChristmasWheel(_)
    -- upvalues: (ref) v_u_26, (copy) v_u_6, (copy) v_u_25, (copy) v_u_10, (copy) v_u_24, (copy) v_u_1, (copy) v_u_16, (copy) v_u_17, (copy) v_u_14, (copy) v_u_22, (ref) v_u_30, (copy) v_u_20, (ref) v_u_27, (copy) v_u_28, (copy) v_u_29, (copy) v_u_50, (copy) v_u_11, (copy) v_u_9, (copy) v_u_19, (copy) v_u_23
    v_u_26 = v_u_6:Register("ChristmasWheel", v_u_25, "TopQuint")
    v_u_26:AttachCloseButton(v_u_25.Close)
    v_u_26:Close()
    local v_u_51 = v_u_10:Wait(v_u_24)
    local function v_u_78()
        -- upvalues: (ref) v_u_25, (ref) v_u_16, (copy) v_u_51, (ref) v_u_1, (ref) v_u_17, (ref) v_u_14, (ref) v_u_22
        local v52 = v_u_25.Wheel
        local v53 = v52.Items
        local v54 = v52.Names
        local v55 = v52.Odds
        local v56 = {}
        for v57 = 1, #v_u_16.Rewards do
            local v58 = v_u_16.Rewards[v57]
            if v58 then
                if v58.Type == "Item" and (v_u_51:Get((("Items.%*"):format(v58.Index))) and v_u_16.AltRewards[v57]) then
                    v58 = v_u_16.AltRewards[v57]
                elseif v58.Stock ~= nil then
                    local v59 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
                    local v60
                    if typeof(v59) == "number" then
                        v60 = v59 <= 0
                    else
                        v60 = false
                    end
                    if v60 and v_u_16.AltRewards[v57] then
                        v58 = v_u_16.AltRewards[v57]
                    end
                end
                v56[v57] = v58.Weight
            end
        end
        local v61 = 0
        for _, v62 in v56 do
            v61 = v61 + v62
        end
        v56[5] = v56[5] + (100 - v61)
        for v63 = 1, #v_u_16.Rewards do
            local v64 = v_u_16.Rewards[v63]
            if v64 then
                if v64.Type == "Item" and (v_u_51:Get((("Items.%*"):format(v64.Index))) and v_u_16.AltRewards[v63]) then
                    ::l27::
                    v64 = v_u_16.AltRewards[v63]
                    goto l29
                end
                if v64.Stock ~= nil then
                    local v65 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
                    local v66
                    if typeof(v65) == "number" then
                        v66 = v65 <= 0
                    else
                        v66 = false
                    end
                    if not (v66 and v_u_16.AltRewards[v63]) then
                        goto l29
                    end
                    goto l27
                end
                ::l29::
                local v67 = v53:FindFirstChild(v63)
                local v68 = v54:FindFirstChild(v63)
                local v69 = v55:FindFirstChild(v63)
                local v70 = ""
                local v71
                if v64.Type == "Cash-Pack" then
                    local v72 = v_u_17[v64.Index].Value
                    local v73 = v_u_51:Get("Rebirth") or 0
                    if v73 > 0 then
                        v72 = v72 * (v73 <= 1 and 1.5 or v73)
                    end
                    v70 = ("$%*"):format((v_u_14:ToString(v72, 2)))
                    v71 = v_u_22:GetProductInfo(v64.Index, "Product").Icon
                else
                    v71 = v64.Icon
                end
                local v74 = v64.Display
                local v75 = v70 == "" and v74 and v74 or v70
                local v76 = v56[v63] * 100
                local v77 = ("%*%%"):format(math.floor(v76) / 100)
                v67.Image = v71
                v68.Text = v75
                v69.Text = v77
            end
        end
    end
    v_u_78()
    local v79 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
    local v_u_80
    if typeof(v79) == "number" then
        v_u_80 = v79 <= 0
    else
        v_u_80 = false
    end
    v_u_1:GetAttributeChangedSignal("ChristmasWheelLimitedStock"):Connect(function()
        -- upvalues: (ref) v_u_1, (ref) v_u_80, (ref) v_u_30, (copy) v_u_78
        local v81 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
        local v82
        if typeof(v81) == "number" then
            v82 = v81 <= 0
        else
            v82 = false
        end
        if v_u_80 ~= v82 then
            v_u_80 = v82
            while v_u_30 do
                task.wait()
            end
            v_u_78()
        end
    end)
    v_u_51:OnDictionaryInserted("Items", function(_, p83)
        -- upvalues: (ref) v_u_16, (ref) v_u_30, (copy) v_u_78
        local v84 = false
        for v85 = 1, #v_u_16.Rewards do
            local v86 = v_u_16.Rewards[v85]
            if v86.Type == "Item" and p83 == v86.Index then
                v84 = true
                break
            end
        end
        if v84 then
            while v_u_30 do
                task.wait()
            end
            v_u_78()
        end
    end)
    local v_u_87 = v_u_25.FastSpin.Toggle
    local v88 = v_u_20.new(v_u_87)
    v88:Animate()
    v88.OnActivated:Connect(function()
        -- upvalues: (ref) v_u_27, (copy) v_u_87
        v_u_27 = not v_u_27
        v_u_87.Checkmark.Visible = v_u_27
    end)
    v_u_87.Checkmark.Visible = v_u_27
    for _, v_u_89 in v_u_25.Buttons:GetChildren() do
        if v_u_89:IsA("ImageButton") and v_u_89.Name ~= "Spin" then
            local v90 = v_u_20.new(v_u_89)
            v90:Animate()
            v90.OnActivated:Connect(function()
                -- upvalues: (ref) v_u_28, (copy) v_u_89
                v_u_28:FireServer(v_u_89:GetAttribute("ProductId"))
            end)
            local v91 = v_u_22:GetProductInfo(v_u_89:GetAttribute("ProductId"), "Product")
            v_u_89.RbxAmount.Text = v91.PriceInRobux
        end
    end
    local v_u_92 = v_u_25.Buttons.Spin
    local v93 = v_u_20.new(v_u_92)
    v93:Animate()
    v93.OnActivated:Connect(function()
        -- upvalues: (ref) v_u_30, (ref) v_u_29
        if v_u_30 ~= true then
            v_u_29:FireServer()
        end
    end)
    local function v_u_99()
        -- upvalues: (copy) v_u_51, (copy) v_u_92, (ref) v_u_25
        local v94 = 0 + v_u_51:Get("ChristmasSpinWheel.Spins")
        v_u_92.Main.Spins.Text = ("Spins (%*)"):format(v94)
        v_u_92.Main.Spins.Visible = v94 > 0
        v_u_92.Main.Frame.Visible = v94 == 0
        local v95 = v_u_92.Main.UIGradient
        local v96
        if v_u_51:Get("ChristmasEvent.GoldElves") < 5 then
            v96 = v94 <= 0
        else
            v96 = false
        end
        v95.Enabled = v96
        local v97 = workspace:GetServerTimeNow() - v_u_51:Get("ChristmasSpinWheel.LastDailyDiscount") >= 86400
        v_u_25.Buttons.Buy1.Visible = not v97
        v_u_25.Buttons.Buy1Discount.Visible = v97
        local v98 = v_u_51:Get("ChristmasSpinWheel.PaidSpins.x3") >= 5
        v_u_25.Buttons.Buy10.Visible = v98
        v_u_25.Buttons.Buy3.Visible = not v98
    end
    v_u_29.OnClientEvent:Connect(function(p100, p101)
        -- upvalues: (copy) v_u_99, (ref) v_u_50
        task.spawn(v_u_99)
        v_u_50(p100, p101)
    end)
    v_u_11.Simple(1, v_u_99)
    v_u_51:OnChanged("ChristmasEvent.GoldElves", v_u_99)
    v_u_9.observeTag("ChristmasSpinWheel", function(p102)
        -- upvalues: (ref) v_u_19
        local v_u_103 = v_u_19.new(p102)
        return function()
            -- upvalues: (copy) v_u_103
            v_u_103:Destroy()
        end
    end)
    local function v107()
        -- upvalues: (ref) v_u_1, (ref) v_u_14, (ref) v_u_25
        local v104 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
        local v105 = Color3.fromRGB(255, 255, 255)
        local v106
        if typeof(v104) == "number" then
            if v104 <= 0 then
                v105 = Color3.fromRGB(255, 67, 67)
                v106 = "SOLD OUT"
            else
                v106 = ("%* LEFT!"):format((v_u_14:Comma(v104)))
            end
        else
            v106 = "??? LEFT!"
        end
        v_u_25.Limited.Quantity.Text = v106
        v_u_25.Limited.Quantity.TextColor3 = v105
    end
    v_u_1:GetAttributeChangedSignal("ChristmasWheelLimitedStock"):Connect(v107)
    task.spawn(v107)
    v_u_1:GetAttributeChangedSignal("ChristmasWheelActive"):Connect(function()
        -- upvalues: (ref) v_u_1, (ref) v_u_26, (ref) v_u_6
        if v_u_1:GetAttribute("ChristmasWheelActive") == false and v_u_26:IsOpened() then
            v_u_6:Toggle("ChristmasWheel", false)
        end
    end)
    v_u_23:AttachOnViewportWithOptimizations("La Jolly Grande", v_u_25.Limited.ViewportFrame)
end
function v31.Start(p108)
    p108:SetupChristmasWheel()
end
return v31