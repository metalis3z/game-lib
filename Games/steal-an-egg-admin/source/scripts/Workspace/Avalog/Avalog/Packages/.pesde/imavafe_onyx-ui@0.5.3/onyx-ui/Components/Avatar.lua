-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local innerScope = Fusion.innerScope
local v1 = {
    Image = require(script.Parent.Image),
    Group = require(script.Parent.Group),
    Icon = require(script.Parent.Icon)
}
return function(v2, v3) -- line 52 | captures: Fusion, Util, Themer, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = {
        Image = Util.Fallback(v3.Image, nil),
        RingEnabled = Util.Fallback(v3.RingEnabled, false),
        RingColor = Util.Fallback(v3.RingColor, v5.Colors.Primary.Main),
        RingThickness = Util.Fallback(v3.RingThickness, v5.StrokeThickness["2"]),
        IndicatorEnabled = Util.Fallback(v3.IndicatorEnabled, false),
        IndicatorColor = Util.Fallback(v3.IndicatorColor, v5.Colors.Primary.Main)
    }
    local Fallback = Util.Fallback
    local IndicatorCornerRadius = v3.IndicatorCornerRadius
    v6.IndicatorCornerRadius = Fallback(IndicatorCornerRadius, v4:Computed(function(v7) -- line 65 | captures: v5
        return UDim.new(0, v7(v5.CornerRadius.Full))
    end))
    v6.IndicatorIcon = Util.Fallback(v3.IndicatorIcon, nil)
    v6.IndicatorIconColor = Util.Fallback(v3.IndicatorIconColor, Util.Colors.White)
    local CombineProps = Util.CombineProps
    local v8 = {
        Name = "Avatar",
        Image = v6.Image
    }
    v8.Size = v4:Computed(function(v9) -- line 76 | captures: v5
        return UDim2.fromOffset(v9(v5.TextSize["4.5"]), v9(v5.TextSize["4.5"]))
    end)
    v8.BackgroundColor3 = v5.Colors.Neutral.Dark
    v8.StrokeEnabled = v6.RingEnabled
    v8.StrokeColor = v4:Spring(v6.RingColor, v5.SpringSpeed["0.5"], v5.SpringDampening["1"])
    v8.StrokeThickness = v4:Spring(v6.RingThickness, v5.SpringSpeed["0.5"], v5.SpringDampening["1"])
    v8.CornerRadius = v4:Computed(function(v10) -- line 87 | captures: v5
        return UDim.new(0, v10(v5.CornerRadius["1"]))
    end)
    v8[Children] = {
        v4:Computed(function(v11) -- line 92 | captures: v4, v5, v6, Children
            if not v11(v6.IndicatorEnabled) then
                return
            end
            local v12 = {
                Name = "Indicator",
                BackgroundColor3 = v4:Spring(v6.IndicatorColor, v5.SpringSpeed["0.5"], v5.SpringDampening["1"]),
                BackgroundTransparency = 0,
                Size = UDim2.fromScale(0.25, 0.25),
                AutomaticSize = Enum.AutomaticSize.None,
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.fromScale(1, 1),
                AspectRatio = 1,
                CornerRadius = v6.IndicatorCornerRadius
            }
            v12[Children] = {
                v4:Icon({
                    Image = v6.IndicatorIcon,
                    ImageColor3 = v6.IndicatorIconColor,
                    ImageTransparency = v4:Computed(function(v13) -- line 113 | captures: v6
                        if v13(v6.IndicatorIcon) then
                            return 0
                        end
                        return 1
                    end),
                    Size = UDim2.fromScale(1, 1),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5)
                })
            }
            return v4:Group(v12)
        end)
    }
    return v4:Image(CombineProps(v3, v8))
end
