-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v4 = v_u_1:WaitForChild("Datas")
local v_u_5 = require(v4.ChristmasSpinWheel)
local v_u_6 = require(v4.Shop)
local v7 = v_u_1:WaitForChild("Utils")
require(v7.TimeUtils)
local v_u_8 = require(v7.NumberUtils)
local v9 = v_u_1:WaitForChild("Controllers")
require(v9.ShopController)
local v_u_10 = require(v9.InterfaceController)
local v11 = v_u_1:WaitForChild("Shared")
local v_u_12 = require(v11.Marketplace)
local v13 = v_u_1:WaitForChild("Packages")
local v_u_14 = require(v13.Trove)
local v_u_15 = require(v13.Timer)
local v_u_16 = require(v13.Synchronizer)
local v_u_17 = v3.LocalPlayer
local v_u_18 = {}
v_u_18.__index = v_u_18
function v_u_18.new(p_u_19)
    -- upvalues: (copy) v_u_16, (copy) v_u_17, (copy) v_u_18, (copy) v_u_14, (copy) v_u_1, (copy) v_u_5, (copy) v_u_6, (copy) v_u_8, (copy) v_u_12, (copy) v_u_2, (copy) v_u_10, (copy) v_u_15
    local v_u_20 = v_u_16:Wait(v_u_17)
    local v21 = v_u_18
    local v_u_22 = setmetatable({}, v21)
    v_u_22.Instance = p_u_19
    v_u_22.Collector = v_u_14.new()
    local function v_u_41()
        -- upvalues: (copy) p_u_19, (ref) v_u_5, (copy) v_u_20, (ref) v_u_1, (ref) v_u_6, (ref) v_u_8, (ref) v_u_12
        local v23 = p_u_19:WaitForChild("Main"):WaitForChild("SurfaceGui").Wheel
        local v24 = v23.Items
        local v25 = v23.Names
        local v26 = v23.Odds
        for v27 = 1, #v_u_5.Rewards do
            local v28 = v_u_5.Rewards[v27]
            if v28 then
                if v28.Type == "Item" and (v_u_20:Get((("Items.%*"):format(v28.Index))) and v_u_5.AltRewards[v27]) then
                    ::l8::
                    v28 = v_u_5.AltRewards[v27]
                    goto l10
                end
                if v28.Stock == nil then
                    goto l10
                end
                local v29 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
                local v30
                if typeof(v29) == "number" then
                    v30 = v29 <= 0
                else
                    v30 = false
                end
                if v30 and v_u_5.AltRewards[v27] then
                    goto l8
                end
                ::l10::
                local v31 = v24:FindFirstChild(v27)
                local v32 = v25:FindFirstChild(v27)
                local v33 = v26:FindFirstChild(v27)
                local v34 = ""
                local v35
                if v28.Type == "Cash-Pack" then
                    local v36 = v_u_6[v28.Index].Value
                    local v37 = v_u_20:Get("Rebirth") or 0
                    if v37 > 0 then
                        v36 = v36 * (v37 <= 1 and 1.5 or v37)
                    end
                    v34 = ("$%*"):format((v_u_8:ToString(v36, 2)))
                    v35 = v_u_12:GetProductInfo(v28.Index, "Product").Icon
                else
                    v35 = v28.Icon
                end
                local v38 = v28.Display
                local v39 = v34 == "" and v38 and v38 or v34
                local v40 = ("%*%%"):format(v28.Weight)
                v31.Image = v35 or ""
                v32.Text = v39
                v33.Text = v40
            end
        end
    end
    v_u_41()
    local v42 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
    local v_u_43
    if typeof(v42) == "number" then
        v_u_43 = v42 <= 0
    else
        v_u_43 = false
    end
    v_u_1:GetAttributeChangedSignal("ChristmasWheelLimitedStock"):Connect(function()
        -- upvalues: (ref) v_u_1, (ref) v_u_43, (copy) v_u_41
        local v44 = v_u_1:GetAttribute("ChristmasWheelLimitedStock")
        local v45
        if typeof(v44) == "number" then
            v45 = v44 <= 0
        else
            v45 = false
        end
        if v_u_43 ~= v45 then
            v_u_43 = v45
            v_u_41()
        end
    end)
    v_u_22.Collector:Add(v_u_20:OnDictionaryInserted("Items", function(_, p46)
        -- upvalues: (ref) v_u_5, (copy) v_u_41
        local v47 = false
        for v48 = 1, #v_u_5.Rewards do
            local v49 = v_u_5.Rewards[v48]
            if v49.Type == "Item" and p46 == v49.Index then
                v47 = true
                break
            end
        end
        if v47 then
            v_u_41()
        end
    end))
    v_u_22.Collector:Add(v_u_2.RenderStepped:Connect(function(p50)
        -- upvalues: (copy) v_u_22
        debug.profilebegin("ChristmasSpinWheel:Rotate3D")
        local v51 = v_u_22.Instance.Main
        local v52 = v51.CFrame
        local v53 = CFrame.Angles
        local v54 = p50 * 45
        v51.CFrame = v52 * v53(0, 0, (math.rad(v54)))
        debug.profileend()
    end))
    v_u_22.Collector:Add(v_u_22.Instance.Root.ProximityPrompt.Triggered:Connect(function()
        -- upvalues: (ref) v_u_10
        v_u_10:Toggle("ChristmasWheel", true)
    end))
    local v55 = v_u_15.new(1)
    v_u_22.Collector:Add(v55, "Destroy")
    v55:StartNow()
    return v_u_22
end
function v_u_18.Destroy(p56)
    p56.Collector:Destroy()
end
return v_u_18