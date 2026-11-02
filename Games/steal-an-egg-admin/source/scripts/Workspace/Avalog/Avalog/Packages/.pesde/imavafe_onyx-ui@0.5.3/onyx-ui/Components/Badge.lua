-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local ColorUtils = require(Parent.Parent.ColorUtils)
local Children = Fusion.Children
local innerScope = Fusion.innerScope
local v1 = {
    Frame = require(script.Parent.Frame),
    IconText = require(script.Parent.IconText)
}
return function(v2, v3) -- line 44 | captures: Fusion, Util, Themer, ColorUtils, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Content, {})
    local v7 = Util.Fallback(v3.ContentWrapped, true)
    local v8 = Util.Fallback(v3.Color, v5.Colors.Base.Main)
    local v9 = Util.Fallback(v3.ContentColor, v4:Computed(function(v10) -- line 54 | captures: v5, v8, ColorUtils
        return ColorUtils.Emphasize(v10(v8), v10(v5.Emphasis.Contrast))
    end))
    local v11 = Util.Fallback(v3.ContentSize, v5.TextSize["1"])
    local CombineProps = Util.CombineProps
    local v12 = {
        Name = "Badge",
        BackgroundColor3 = v8,
        BackgroundTransparency = 0
    }
    v12.Padding = v4:Computed(function(v13) -- line 64 | captures: v5
        return UDim.new(0, v13(v5.Spacing["0"]))
    end)
    v12.PaddingLeft = v4:Computed(function(v14) -- line 67 | captures: v5
        return UDim.new(0, v14(v5.Spacing["0.5"]))
    end)
    v12.PaddingRight = v4:Computed(function(v15) -- line 70 | captures: v5
        return UDim.new(0, v15(v5.Spacing["0.5"]))
    end)
    v12.CornerRadius = v4:Computed(function(v16) -- line 73 | captures: v5
        return UDim.new(0, v16(v5.CornerRadius["2"]))
    end)
    v12.ListEnabled = true
    v12.ListPadding = v4:Computed(function(v17) -- line 77 | captures: v5
        return UDim.new(0, v17(v5.Spacing["0.25"]))
    end)
    v12.ListFillDirection = Enum.FillDirection.Horizontal
    v12.ListHorizontalAlignment = Enum.HorizontalAlignment.Center
    v12.ListVerticalAlignment = Enum.VerticalAlignment.Center
    v12.ListWraps = v7
    local v18 = {
        Content = v6,
        ContentColor = v9,
        ContentSize = v11,
        ContentWrapped = v7,
        ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
        ListVerticalAlignment = Enum.VerticalAlignment.Center
    }
    v18.ListPadding = v4:Computed(function(v19) -- line 93 | captures: v5
        return UDim.new(0, v19(v5.Spacing["0.25"]))
    end)
    v12[Children] = { v4:IconText(v18) }
    return v4:Frame(CombineProps(v3, v12))
end
