-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local innerScope = Fusion.innerScope
local v1 = { Frame = require(script.Parent.Frame) }
return function(v2, v3) -- line 27 | captures: Fusion, Themer, Util, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local CombineProps = Util.CombineProps
    local v6 = {
        Name = "Card",
        BackgroundTransparency = 0,
        BackgroundColor3 = v5.Colors.Neutral.Main
    }
    v6.CornerRadius = v4:Computed(function(v7) -- line 35 | captures: v5
        return UDim.new(0, v7(v5.CornerRadius["1"]))
    end)
    v6.Padding = v4:Computed(function(v8) -- line 38 | captures: v5
        return UDim.new(0, v8(v5.Spacing["1"]))
    end)
    return v4:Frame(CombineProps(v3, v6))
end
