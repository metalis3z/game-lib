-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local Util = OnyxUI.Util
local Themer = OnyxUI.Themer
return function(v1, v2) -- line 10 | captures: OnyxUI, Fusion, Util, Themer
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components)
    local v4 = Themer.Theme:now()
    local v5 = Util.Fallback(v2.Color, v4.Colors.Neutral.Main)
    local CombineProps = Util.CombineProps
    local v6 = { Color = v5 }
    v6.CornerRadius = v3:Computed(function(v7) -- line 18 | captures: v4
        return UDim.new(0, v7(v4.CornerRadius["1.5"]))
    end)
    v6.PaddingTop = v3:Computed(function(v8) -- line 21 | captures: v4
        return UDim.new(0, v8(v4.Spacing["0.5"]))
    end)
    v6.PaddingBottom = v3:Computed(function(v9) -- line 24 | captures: v4
        return UDim.new(0, v9(v4.Spacing["0.5"]))
    end)
    v6.PaddingLeft = v3:Computed(function(v10) -- line 27 | captures: v4
        return UDim.new(0, v10(v4.Spacing["0.5"]))
    end)
    v6.PaddingRight = v3:Computed(function(v11) -- line 30 | captures: v4
        return UDim.new(0, v11(v4.Spacing["0.5"]))
    end)
    return v3:Button(CombineProps(v2, v6))
end
