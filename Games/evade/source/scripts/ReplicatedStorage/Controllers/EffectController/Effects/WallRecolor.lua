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
    ["Color"] = Color3.fromRGB(106, 57, 9)
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
            ["Color"] = Color3.fromRGB(46, 71, 89)
        }
    elseif v_u_1:GetAttribute("RapConcertEvent") then
        v10 = {
            ["Context"] = "RapConcert",
            ["Color"] = Color3.fromRGB(46, 71, 89)
        }
    elseif v_u_1:GetAttribute("MexicoEvent") then
        v10 = {
            ["Context"] = "MexicoEvent",
            ["Color"] = Color3.fromRGB(180, 91, 68)
        }
    elseif v_u_1:GetAttribute("IndonesiaEvent") then
        v10 = {
            ["Context"] = "IndonesiaEvent",
            ["Color"] = Color3.fromRGB(113, 61, 31)
        }
    elseif v_u_1:GetAttribute("DulDulDulEvent") then
        v10 = {
            ["Context"] = "DulDulDulEvent",
            ["Color"] = Color3.fromRGB(84, 81, 83)
        }
    elseif v_u_1:GetAttribute("ChicleteiraBicicleteiraEvent") then
        v10 = {
            ["Context"] = "ChicleteiraBicicleteiraEvent",
            ["Color"] = Color3.fromRGB(116, 85, 85)
        }
    elseif v_u_1:GetAttribute("MeowlEvent") then
        v10 = {
            ["Context"] = "MeowlEvent",
            ["Color"] = Color3.fromRGB(125, 93, 58)
        }
    elseif v_u_1:GetAttribute("TrickOrTreatEvent") then
        v10 = {
            ["Context"] = "TrickOrTreatEvent",
            ["Color"] = Color3.fromRGB(148, 71, 33)
        }
    elseif v_u_1:GetAttribute("GraveyardEvent") then
        v10 = {
            ["Context"] = "GraveyardEvent",
            ["Color"] = Color3.fromRGB(92, 94, 180)
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
            ["Color"] = Color3.fromRGB(108, 120, 136),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("WitchingHourEvent") then
        v10 = {
            ["Context"] = "WitchingHourEvent",
            ["Color"] = Color3.fromRGB(68, 42, 77),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("YinYangEvent") then
        v10 = {
            ["Context"] = "YinYangEvent",
            ["Color"] = Color3.fromRGB(0, 0, 0),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("CursedEvent") then
        v10 = {
            ["Context"] = "CursedEvent",
            ["Color"] = Color3.fromRGB(177, 0, 0),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("RadioactiveEvent") then
        v10 = {
            ["Context"] = "RadioactiveEvent",
            ["Color"] = Color3.fromRGB(128, 136, 117),
            ["TweenTime"] = 0
        }
    else
        v10 = v_u_1:GetAttribute("GalaxyEvent") and {
            ["Context"] = "GalaxyEvent",
            ["Color"] = Color3.fromRGB(20, 57, 67)
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
    v_u_4.observeTag("Wall", function(p_u_12)
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