-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local Out = Fusion.Out
local innerScope = Fusion.innerScope
local v1 = { Group = require(script.Parent.Group) }
return function(v2, v3) -- line 29 | captures: Fusion, Themer, Util, Out, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = v4:EnsureValue(Util.Fallback(v3.AutomaticSize, Enum.AutomaticSize.None))
    local CombineProps = Util.CombineProps
    local v7 = {
        Name = "MenuFrame",
        GroupTransparency = v3.GroupTransparency,
        BackgroundColor3 = v5.Colors.Base.Main,
        BackgroundTransparency = 0
    }
    v7.Padding = v4:Computed(function(v8) -- line 40 | captures: v5
        return UDim.new(0, v8(v5.Spacing["1"]))
    end)
    v7.CornerRadius = v4:Computed(function(v9) -- line 43 | captures: v5
        return UDim.new(0, v9(v5.CornerRadius["3"]))
    end)
    v7.StrokeEnabled = true
    v7.StrokeColor = v5.Colors.Neutral.Main
    v7[Out("AutomaticSize")] = v6
    return v4:Group(CombineProps(v3, v7))
end
