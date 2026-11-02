local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v4 = v_u_1:WaitForChild("Datas")
local v_u_5 = require(v4.DivineSpinWheel)
local v_u_6 = require(v4.Shop)
local v7 = v_u_1:WaitForChild("Utils")
local v_u_8 = require(v7.TimeUtils)
local v_u_9 = require(v7.NumberUtils)
local v10 = v_u_1:WaitForChild("Controllers")
require(v10.ShopController)
local v_u_11 = require(v10.InterfaceController)
local v12 = v_u_1:WaitForChild("Shared")
local v_u_13 = require(v12.Marketplace)
local v14 = v_u_1:WaitForChild("Packages")
local v_u_15 = require(v14.Trove)
local v_u_16 = require(v14.Timer)
local v_u_17 = require(v14.Synchronizer)
local v_u_18 = v3.LocalPlayer
local v_u_19 = {}
v_u_19.__index = v_u_19
function v_u_19.new(p_u_20)
    local v_u_21 = v_u_17:Wait(v_u_18)
    local v22 = v_u_19
    local v_u_23 = setmetatable({}, v22)
    v_u_23.Instance = p_u_20
    v_u_23.Collector = v_u_15.new()
    local function v_u_40()
        local v24 = p_u_20:WaitForChild("Main"):WaitForChild("SurfaceGui").Wheel
        local v25 = v24.Items
        local v26 = v24.Names
        local v27 = v24.Odds
        for v28 = 1, #v_u_5.Rewards do
            local v29 = v_u_5.Rewards[v28]
            if v29 then
                if v29.Type == "Item" and v_u_21:Get((("Items.%*"):format(v29.Index))) then
                    v29 = v_u_5.AltRewards[v28]
                end
                local v30 = v25:FindFirstChild(v28)
                local v31 = v26:FindFirstChild(v28)
                local v32 = v27:FindFirstChild(v28)
                local v33 = ""
                local v34
                if v29.Type == "Cash-Pack" then
                    local v35 = v_u_6[v29.Index].Value
                    local v36 = v_u_21:Get("Rebirth") or 0
                    if v36 > 0 then
                        v35 = v35 * (v36 <= 1 and 1.5 or v36)
                    end
                    v33 = ("$%*"):format((v_u_9:ToString(v35, 2)))
                    v34 = v_u_13:GetProductInfo(v29.Index, "Product").Icon
                else
                    v34 = v29.Icon
                end
                local v37 = v29.Display
                local v38 = v33 == "" and v37 and v37 or v33
                local v39 = ("%*%%"):format(v29.Weight)
                v30.Image = v34 or ""
                v31.Text = v38
                v32.Text = v39
            end
        end
    end
    v_u_40()
    v_u_23.Collector:Add(v_u_21:OnDictionaryInserted("Items", function(_, p41)
        local v42 = false
        for v43 = 1, #v_u_5.Rewards do
            local v44 = v_u_5.Rewards[v43]
            if v44.Type == "Item" and p41 == v44.Index then
                v42 = true
                break
            end
        end
        if v42 then
            v_u_40()
        end
    end))
    v_u_23.Collector:Add(v_u_2.RenderStepped:Connect(function(p45)
        debug.profilebegin("DivineSpinWheel:Rotate3D")
        local v46 = v_u_23.Instance.Main
        local v47 = v46.CFrame
        local v48 = CFrame.Angles
        local v49 = p45 * 45
        v46.CFrame = v47 * v48(0, 0, (math.rad(v49)))
        debug.profileend()
    end))
    v_u_23.Collector:Add(v_u_23.Instance.Root.ProximityPrompt.Triggered:Connect(function()
        v_u_11:Toggle("DivineWheel", true)
    end))
    local v50 = v_u_16.new(1)
    v_u_23.Collector:Add(v50, "Destroy")
    v_u_23.Collector:Add(v50.Tick:Connect(function()
        if v_u_1:GetAttribute("DivineEvent") then
            if v_u_21:Get("DivineSpinWheel.LastFreeClaimed") == v_u_1:GetAttribute("DivineEventLastTime") then
                v_u_23.Instance.Overhead.BillboardGui.Countdown.Text = ("Free Spin in %*"):format((v_u_8:D((v_u_1:GetAttribute("NextDivineEvent") or 0) - workspace:GetServerTimeNow())))
            else
                v_u_23.Instance.Overhead.BillboardGui.Countdown.Text = "SPIN NOW"
            end
        else
            v_u_23.Instance.Overhead.BillboardGui.Countdown.Text = ("Free Spin in %*"):format((v_u_8:D((v_u_1:GetAttribute("NextDivineEvent") or 0) - workspace:GetServerTimeNow())))
            return
        end
    end))
    v50:StartNow()
    return v_u_23
end
function v_u_19.Destroy(p51)
    p51.Collector:Destroy()
end
return v_u_19