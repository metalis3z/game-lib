-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
require(script.Parent.ThemeSpec)
local ColorUtils = require(Parent.Parent.ColorUtils)
local Util = require(Parent.Util)
local peek = Fusion.peek
local innerScope = Fusion.innerScope
local ReconcileValues

local function ReconcileValues_2(v1, v2) -- line 12 | captures: peek, ReconcileValues
    for v3, v4 in pairs(v1) do
        if typeof(v4) == "table" and v4.set then
            local v5 = v2[v3]
            if typeof(v5) == "table" and v2[v3].get then
                v4:set(peek(v2[v3]))
            elseif v2[v3] ~= nil then
                v4:set(v2[v3])
            end
        elseif typeof(v4) == "table" then
            local v6 = v2[v3]
            if typeof(v6) == "table" then
                ReconcileValues(v4, v2[v3])
            end
        end
    end
end

ReconcileValues = ReconcileValues_2

local function ProcessColors(v7) -- line 28 | captures: ColorUtils, peek
    for v8, v9 in pairs(v7.Colors) do
        local v10 = peek(v9.Main)
        if v10 ~= nil then
            if peek(v9.Contrast) == nil then
                v9.Contrast:set(ColorUtils.Emphasize(v10, peek(v7.Emphasis.Contrast)))
            end
            if peek(v9.Dark) == nil then
                v9.Dark:set(ColorUtils.Darken(v10, peek(v7.Emphasis.Strong)))
            end
            if peek(v9.Light) == nil then
                v9.Light:set(ColorUtils.Lighten(v10, peek(v7.Emphasis.Strong)))
            end
        end
    end
end

local function ProcessMultipliers(v11) -- line 47 | captures: peek
    local v12 = peek(v11.Base)
    for v13, v14 in pairs(v11) do
        if peek(v14) == nil then
            local v15 = tonumber(v13)
            if v15 ~= nil then
                v14:set(v12 * v15)
            end
        end
    end
    if v11.Full ~= nil then
        v11.Full:set(v12 * 10000)
    end
end

local function NewTheme(v16, v17) -- line 66 | captures: Fusion, Util, innerScope, ReconcileValues_2, ProcessColors, ProcessMultipliers
    local v18 = innerScope(v16, Fusion)
    local v19 = {
        Colors = {
            Primary = {
                Main = v18:Value(Util.Colors.Black),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Secondary = {
                Main = v18:Value(Util.Colors.Black),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Accent = {
                Main = v18:Value(Util.Colors.Black),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Neutral = {
                Main = v18:Value(Util.Colors.Gray["300"]),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            NeutralContent = {
                Main = v18:Value(Util.Colors.Gray["800"]),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Base = {
                Main = v18:Value(Util.Colors.White),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            BaseContent = {
                Main = v18:Value(Util.Colors.Black),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Success = {
                Main = v18:Value(Util.Colors.Green["400"]),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Error = {
                Main = v18:Value(Util.Colors.Red["400"]),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Warning = {
                Main = v18:Value(Util.Colors.Orange["400"]),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            },
            Info = {
                Main = v18:Value(Util.Colors.Blue["400"]),
                Dark = v18:Value(nil),
                Light = v18:Value(nil),
                Contrast = v18:Value(nil)
            }
        },
        Font = {
            Body = v18:Value("GothamSsm"),
            Heading = v18:Value("GothamSsm"),
            Monospace = v18:Value("GothamSsm")
        },
        FontWeight = {
            Body = v18:Value(Enum.FontWeight.Regular),
            Bold = v18:Value(Enum.FontWeight.Bold),
            Heading = v18:Value(Enum.FontWeight.Bold)
        },
        TextSize = {
            Base = v18:Value(16),
            ["0.75"] = v18:Value(nil),
            ["0.875"] = v18:Value(nil),
            ["1"] = v18:Value(nil),
            ["1.125"] = v18:Value(nil),
            ["1.25"] = v18:Value(nil),
            ["1.5"] = v18:Value(nil),
            ["1.875"] = v18:Value(nil),
            ["2.25"] = v18:Value(nil),
            ["3"] = v18:Value(nil),
            ["3.75"] = v18:Value(nil),
            ["4.5"] = v18:Value(nil)
        },
        Spacing = {
            Base = v18:Value(16),
            ["0"] = v18:Value(0),
            ["0.25"] = v18:Value(nil),
            ["0.5"] = v18:Value(nil),
            ["0.75"] = v18:Value(nil),
            ["1"] = v18:Value(nil),
            ["1.5"] = v18:Value(nil),
            ["2"] = v18:Value(nil),
            ["3"] = v18:Value(nil),
            ["4"] = v18:Value(nil),
            ["6"] = v18:Value(nil),
            ["8"] = v18:Value(nil),
            ["12"] = v18:Value(nil),
            ["16"] = v18:Value(nil),
            ["24"] = v18:Value(nil),
            ["32"] = v18:Value(nil),
            ["40"] = v18:Value(nil),
            ["48"] = v18:Value(nil)
        },
        CornerRadius = {
            Base = v18:Value(4),
            ["0"] = v18:Value(0),
            ["0.5"] = v18:Value(nil),
            ["1"] = v18:Value(nil),
            ["1.5"] = v18:Value(nil),
            ["2"] = v18:Value(nil),
            ["3"] = v18:Value(nil),
            ["4"] = v18:Value(nil),
            ["6"] = v18:Value(nil),
            Full = v18:Value(nil)
        },
        StrokeThickness = {
            Base = v18:Value(2),
            ["0"] = v18:Value(0),
            ["1"] = v18:Value(nil),
            ["2"] = v18:Value(nil),
            ["3"] = v18:Value(nil),
            ["4"] = v18:Value(nil),
            ["8"] = v18:Value(nil)
        },
        SpringSpeed = {
            Base = v18:Value(40),
            ["0.1"] = v18:Value(nil),
            ["0.175"] = v18:Value(nil),
            ["0.25"] = v18:Value(nil),
            ["0.375"] = v18:Value(nil),
            ["0.5"] = v18:Value(nil),
            ["0.75"] = v18:Value(nil),
            ["1"] = v18:Value(nil),
            ["1.5"] = v18:Value(nil),
            ["2"] = v18:Value(nil),
            Immediate = v18:Value(1000)
        },
        SpringDampening = {
            Base = v18:Value(1),
            ["0.1"] = v18:Value(nil),
            ["0.175"] = v18:Value(nil),
            ["0.25"] = v18:Value(nil),
            ["0.375"] = v18:Value(nil),
            ["0.5"] = v18:Value(nil),
            ["0.75"] = v18:Value(nil),
            ["1"] = v18:Value(nil),
            ["1.5"] = v18:Value(nil),
            ["2"] = v18:Value(nil),
            ["5"] = v18:Value(nil),
            ["10"] = v18:Value(nil),
            Full = v18:Value(1000)
        },
        Sound = {
            Hover = v18:Value(v18:New("Sound")({
                SoundId = "rbxassetid://10066936758",
                Volume = 0.05
            })),
            Click = v18:Value(v18:New("Sound")({
                SoundId = "rbxassetid://16480549841",
                Volume = 0.5
            })),
            Focus = v18:Value(v18:New("Sound")({
                SoundId = "rbxassetid://16480549841",
                Volume = 0.5
            })),
            Switch = v18:Value(v18:New("Sound")({
                SoundId = "rbxassetid://9119713951",
                Volume = 0.5
            }))
        },
        Emphasis = {
            Light = v18:Value(0.15),
            Regular = v18:Value(0.3),
            Strong = v18:Value(0.5),
            Contrast = v18:Value(1)
        }
    }
    ReconcileValues_2(v19, v17)
    ProcessColors(v19)
    ProcessMultipliers(v19.Spacing)
    ProcessMultipliers(v19.TextSize)
    ProcessMultipliers(v19.CornerRadius)
    ProcessMultipliers(v19.StrokeThickness)
    ProcessMultipliers(v19.SpringSpeed)
    ProcessMultipliers(v19.SpringDampening)
    return v19
end

return NewTheme
