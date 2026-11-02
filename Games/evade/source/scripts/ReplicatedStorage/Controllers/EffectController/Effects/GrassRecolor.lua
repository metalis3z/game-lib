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
local v_u_6 = { "WitchingHourEvent", "IndonesiaEvent" }
local v_u_7 = {
    ["Context"] = "Default",
    ["Top"] = Color3.fromRGB(31, 128, 29),
    ["Bottom"] = Color3.fromRGB(31, 128, 29),
    ["TweenTime"] = 0,
    ["Carpet"] = Color3.fromRGB(196, 40, 28)
}
local v_u_8 = v_u_7
local v_u_9 = v5.new()
local function v_u_12()
    -- upvalues: (copy) v_u_7, (copy) v_u_1, (ref) v_u_8, (copy) v_u_9
    local v10 = v_u_7
    local v11
    if v_u_1:GetAttribute("ConcertEvent") then
        v11 = {
            ["Context"] = "Concert",
            ["Top"] = Color3.fromRGB(157, 155, 151),
            ["Bottom"] = Color3.fromRGB(46, 71, 89),
            ["TweenTime"] = 2
        }
    elseif v_u_1:GetAttribute("RapConcertEvent") then
        v11 = {
            ["Context"] = "RapConcert",
            ["Top"] = Color3.fromRGB(157, 155, 151),
            ["Bottom"] = Color3.fromRGB(46, 71, 89),
            ["TweenTime"] = 2
        }
    elseif v_u_1:GetAttribute("BrazilEvent") then
        v11 = {
            ["Context"] = "Brazil",
            ["Top"] = Color3.fromRGB(215, 92, 31),
            ["Bottom"] = Color3.fromRGB(215, 92, 31),
            ["TweenTime"] = 2
        }
    elseif v_u_1:GetAttribute("MexicoEvent") then
        v11 = {
            ["Context"] = "MexicoEvent",
            ["Top"] = Color3.fromRGB(160, 95, 53),
            ["Bottom"] = Color3.fromRGB(175, 126, 67),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("IndonesiaEvent") then
        v11 = {
            ["Context"] = "IndonesiaEvent",
            ["Top"] = Color3.fromRGB(160, 95, 53),
            ["Bottom"] = Color3.fromRGB(56, 109, 63),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("CrabRave") then
        v11 = {
            ["Context"] = "CrabRave",
            ["Top"] = Color3.fromRGB(235, 178, 55),
            ["Bottom"] = Color3.fromRGB(235, 178, 55),
            ["TweenTime"] = 1.95
        }
    elseif v_u_1:GetAttribute("WaterEvent") then
        v11 = {
            ["Context"] = "WaterEvent",
            ["Top"] = Color3.fromRGB(226, 155, 64),
            ["Bottom"] = Color3.fromRGB(226, 155, 64),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("StrawberryEvent") then
        v11 = {
            ["Context"] = "StrawberryEvent",
            ["Top"] = Color3.fromRGB(255, 255, 255),
            ["Bottom"] = Color3.fromRGB(255, 255, 255),
            ["TweenTime"] = 0,
            ["MaterialVariant"] = "Strawberry Stud",
            ["Carpet"] = Color3.fromRGB(31, 128, 29)
        }
    elseif v_u_1:GetAttribute("MeowlEvent") then
        v11 = {
            ["Context"] = "MeowlEvent",
            ["Top"] = Color3.fromRGB(69, 97, 44),
            ["Bottom"] = Color3.fromRGB(18, 65, 29),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("DulDulDulEvent") then
        v11 = {
            ["Context"] = "DulDulDulEvent",
            ["Top"] = Color3.fromRGB(137, 136, 139),
            ["Bottom"] = Color3.fromRGB(87, 127, 41),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("ChicleteiraBicicleteiraEvent") then
        v11 = {
            ["Context"] = "ChicleteiraBicicleteiraEvent",
            ["Top"] = Color3.fromRGB(85, 67, 67),
            ["Bottom"] = Color3.fromRGB(31, 128, 29),
            ["TweenTime"] = 0,
            ["Carpet"] = Color3.fromRGB(61, 53, 57)
        }
    elseif v_u_1:GetAttribute("TrickOrTreatEvent") then
        v11 = {
            ["Context"] = "TrickOrTreatEvent",
            ["Top"] = Color3.fromRGB(56, 109, 60),
            ["Bottom"] = Color3.fromRGB(56, 109, 60),
            ["TweenTime"] = 0,
            ["Carpet"] = Color3.fromRGB(27, 42, 53)
        }
    elseif v_u_1:GetAttribute("GraveyardEvent") then
        v11 = {
            ["Context"] = "GraveyardEvent",
            ["Top"] = Color3.fromRGB(47, 102, 72),
            ["Bottom"] = Color3.fromRGB(255, 255, 255),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("GingerbreadTownEvent") then
        v11 = {
            ["Context"] = "GingerbreadTownEvent",
            ["Top"] = Color3.fromRGB(145, 161, 168),
            ["Bottom"] = Color3.fromRGB(145, 161, 168),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("WinterHourEvent") then
        v11 = {
            ["Context"] = "WinterHourEvent",
            ["Top"] = Color3.fromRGB(145, 161, 168),
            ["Bottom"] = Color3.fromRGB(145, 161, 168),
            ["Carpet"] = Color3.fromRGB(87, 153, 166),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("WitchingHourEvent") then
        v11 = {
            ["Context"] = "WitchingHourEvent",
            ["Top"] = Color3.fromRGB(39, 10, 59),
            ["Bottom"] = Color3.fromRGB(39, 10, 59),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("YinYangEvent") then
        v11 = {
            ["Context"] = "YinYangEvent",
            ["Top"] = Color3.fromRGB(204, 204, 204),
            ["Bottom"] = Color3.fromRGB(0, 0, 0),
            ["TweenTime"] = 0
        }
    elseif v_u_1:GetAttribute("CursedEvent") then
        v11 = {
            ["Context"] = "CursedEvent",
            ["Top"] = Color3.fromRGB(0, 0, 0),
            ["Bottom"] = Color3.fromRGB(177, 0, 0),
            ["TweenTime"] = 0,
            ["Carpet"] = Color3.fromRGB(33, 33, 33)
        }
    elseif v_u_1:GetAttribute("RadioactiveEvent") then
        v11 = {
            ["Context"] = "RadioactiveEvent",
            ["Top"] = Color3.fromRGB(31, 128, 29),
            ["Bottom"] = Color3.fromRGB(27, 42, 53),
            ["TweenTime"] = 0,
            ["Carpet"] = Color3.fromRGB(196, 147, 0)
        }
    elseif v_u_1:GetAttribute("GalaxyEvent") then
        v11 = {
            ["Context"] = "GalaxyEvent",
            ["Top"] = Color3.fromRGB(42, 99, 255),
            ["Bottom"] = Color3.fromRGB(42, 99, 255),
            ["TweenTime"] = 2
        }
    elseif v_u_1:GetAttribute("ExtinctEvent") then
        v11 = {
            ["Context"] = "ExtinctEvent",
            ["Top"] = Color3.fromRGB(108, 83, 58),
            ["Bottom"] = Color3.fromRGB(108, 83, 58),
            ["TweenTime"] = 0.5
        }
    elseif v_u_1:GetAttribute("MoltenEvent") then
        v11 = {
            ["Context"] = "Molten",
            ["Top"] = Color3.fromRGB(0, 0, 0),
            ["Bottom"] = Color3.fromRGB(0, 0, 0),
            ["TweenTime"] = 0.5
        }
    else
        v11 = v_u_1:GetAttribute("Snow") and {
            ["Context"] = "Snow",
            ["Top"] = Color3.fromRGB(190, 190, 190),
            ["Bottom"] = Color3.fromRGB(190, 190, 190),
            ["TweenTime"] = 8
        } or v10
    end
    if v_u_8.Context ~= v11.Context then
        v_u_8 = v11
        v_u_9:Fire()
    end
end
function v2.OnStart(_)
    -- upvalues: (copy) v_u_12
    v_u_12()
end
function v2.OnUpdate(_)
    -- upvalues: (copy) v_u_12
    v_u_12()
end
function v2.OnLoad(_)
    -- upvalues: (copy) v_u_4, (ref) v_u_8, (copy) v_u_3, (copy) v_u_9, (copy) v_u_6, (copy) v_u_1, (copy) v_u_7
    v_u_4.observeTag("Grass", function(p_u_13)
        -- upvalues: (ref) v_u_8, (ref) v_u_3, (ref) v_u_9
        local v_u_14 = nil
        local function v22()
            -- upvalues: (ref) v_u_14, (copy) p_u_13, (ref) v_u_8, (ref) v_u_3
            if v_u_14 then
                v_u_14:Cancel()
            end
            p_u_13.MaterialVariant = v_u_8.MaterialVariant or ""
            local v15 = p_u_13:GetAttribute("Bottom") and "Bottom" or "Top"
            local v16 = v_u_3
            local v17 = p_u_13
            local v18 = TweenInfo.new(v_u_8.TweenTime)
            local v19 = {}
            local v20 = v_u_8[v15]
            local v21
            if type(v20) == "table" then
                v21 = v_u_8[v15][p_u_13:GetAttribute("Side") or "Left"] or (v_u_8[v15].Left or select(2, next(v_u_8[v15])))
            else
                v21 = v_u_8[v15]
            end
            v19.Color = v21
            v_u_14 = v16(v17, v18, v19)
        end
        local v_u_23 = v_u_9:Connect(v22)
        task.spawn(v22)
        return function()
            -- upvalues: (copy) v_u_23, (ref) v_u_14
            v_u_23:Disconnect()
            v_u_14:Cancel()
        end
    end, { workspace })
    v_u_4.observeTag("Carpet", function(p_u_24)
        -- upvalues: (ref) v_u_6, (ref) v_u_1, (ref) v_u_3, (ref) v_u_8, (ref) v_u_7, (ref) v_u_9
        local v_u_25 = nil
        local function v28()
            -- upvalues: (ref) v_u_25, (ref) v_u_6, (ref) v_u_1, (copy) p_u_24, (ref) v_u_3, (ref) v_u_8, (ref) v_u_7
            if v_u_25 then
                v_u_25:Cancel()
            end
            local v26 = false
            for _, v27 in v_u_6 do
                if v_u_1:GetAttribute(v27) then
                    v26 = true
                    break
                end
            end
            p_u_24.Transparency = v26 and 1 or 0
            v_u_25 = v_u_3(p_u_24, TweenInfo.new(v_u_8.TweenTime), {
                ["Color"] = v_u_8.Carpet or v_u_7.Carpet
            })
        end
        local v_u_29 = { v_u_9:Connect(v28) }
        local v_u_30 = v_u_25
        for _, v31 in v_u_6 do
            local v32 = v_u_1:GetAttributeChangedSignal(v31)
            table.insert(v_u_29, v32:Connect(v28))
        end
        task.spawn(v28)
        return function()
            -- upvalues: (copy) v_u_29, (ref) v_u_30
            for _, v33 in v_u_29 do
                v33:Disconnect()
            end
            v_u_30:Cancel()
        end
    end, { workspace })
end
return v2