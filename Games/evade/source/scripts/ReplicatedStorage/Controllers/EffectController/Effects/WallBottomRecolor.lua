-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
require(script:FindFirstAncestor("Effects").Parent.Types)
local v2 = {}
local v_u_3 = require(v_u_1.Packages.CreateTween)
local v_u_4 = require(v_u_1.Packages.Observers)
local v5 = require(v_u_1.Packages.Signal)
local _ = script.Name
local v_u_6 = {
    ["Context"] = "Default",
    ["Color"] = Color3.fromRGB(99, 95, 98)
}
local v_u_7 = v_u_6
local v_u_8 = v5.new()
local function v_u_11()
    -- upvalues: (copy) v_u_6, (copy) v_u_1, (ref) v_u_7, (copy) v_u_8
    local v9 = v_u_6
    local v10
    if v_u_1:GetAttribute("ConcertEvent") then
        v10 = {
            ["Context"] = "Concert",
            ["Color"] = Color3.fromRGB(17, 17, 17)
        }
    elseif v_u_1:GetAttribute("RapConcertEvent") then
        v10 = {
            ["Context"] = "RapConcert",
            ["Color"] = Color3.fromRGB(17, 17, 17)
        }
    elseif v_u_1:GetAttribute("DulDulDulEvent") then
        v10 = {
            ["Context"] = "DulDulDulEvent",
            ["Color"] = Color3.fromRGB(129, 124, 128)
        }
    elseif v_u_1:GetAttribute("MexicoEvent") then
        v10 = {
            ["Context"] = "MexicoEvent",
            ["Color"] = Color3.fromRGB(138, 81, 45)
        }
    elseif v_u_1:GetAttribute("IndonesiaEvent") then
        v10 = {
            ["Context"] = "IndonesiaEvent",
            ["Color"] = Color3.fromRGB(95, 44, 0)
        }
    elseif v_u_1:GetAttribute("MeowlEvent") then
        v10 = {
            ["Context"] = "MeowlEvent",
            ["Color"] = Color3.fromRGB(111, 71, 30)
        }
    elseif v_u_1:GetAttribute("TrickOrTreatEvent") then
        v10 = {
            ["Context"] = "TrickOrTreatEvent",
            ["Color"] = Color3.fromRGB(83, 56, 33)
        }
    elseif v_u_1:GetAttribute("GraveyardEvent") then
        v10 = {
            ["Context"] = "GraveyardEvent",
            ["Color"] = Color3.fromRGB(72, 63, 138)
        }
    elseif v_u_1:GetAttribute("GingerbreadTownEvent") then
        v10 = {
            ["Context"] = "GingerbreadTownEvent",
            ["Color"] = Color3.fromRGB(99, 42, 16),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("WinterHourEvent") then
        v10 = {
            ["Context"] = "WinterHourEvent",
            ["Color"] = Color3.fromRGB(99, 42, 16),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("WitchingHourEvent") then
        v10 = {
            ["Context"] = "WitchingHourEvent",
            ["Color"] = Color3.fromRGB(99, 95, 98),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("YinYangEvent") then
        v10 = {
            ["Context"] = "YinYangEvent",
            ["Color"] = Color3.fromRGB(204, 204, 204),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("CursedEvent") then
        v10 = {
            ["Context"] = "CursedEvent",
            ["Color"] = Color3.fromRGB(33, 33, 33),
            ["TweenTime"] = 0
        }
    else
        v10 = v_u_1:GetAttribute("RadioactiveEvent") and {
            ["Context"] = "RadioactiveEvent",
            ["Color"] = Color3.fromRGB(42, 42, 42),
            ["TweenTime"] = 0
        } or v9
    end
    if v_u_7.Context ~= v10.Context then
        v_u_7 = v10
        v_u_8:Fire()
    end
end
function v2.OnStart(_)
    -- upvalues: (copy) v_u_11
    v_u_11()
end
function v2.OnUpdate(_)
    -- upvalues: (copy) v_u_11
    v_u_11()
end
function v2.OnLoad(_)
    -- upvalues: (copy) v_u_4, (copy) v_u_3, (ref) v_u_7, (copy) v_u_8
    v_u_4.observeTag("WallBottom", function(p_u_12)
        -- upvalues: (ref) v_u_3, (ref) v_u_7, (ref) v_u_8
        local v_u_13 = nil
        local function v20()
            -- upvalues: (ref) v_u_13, (ref) v_u_3, (copy) p_u_12, (ref) v_u_7
            if v_u_13 then
                v_u_13:Cancel()
            end
            local v14 = v_u_3
            local v15 = p_u_12
            local v16 = TweenInfo.new(2)
            local v17 = {}
            local v18 = v_u_7.Color
            local v19
            if type(v18) == "table" then
                v19 = v_u_7.Color[p_u_12:GetAttribute("Side") or "Left"] or (v_u_7.Color.Left or select(2, next(v_u_7)))
            else
                v19 = v_u_7.Color
            end
            v17.Color = v19
            v_u_13 = v14(v15, v16, v17)
        end
        local v_u_21 = v_u_8:Connect(v20)
        task.spawn(v20)
        return function()
            -- upvalues: (copy) v_u_21, (ref) v_u_13
            v_u_21:Disconnect()
            v_u_13:Cancel()
        end
    end, { workspace })
end
return v2