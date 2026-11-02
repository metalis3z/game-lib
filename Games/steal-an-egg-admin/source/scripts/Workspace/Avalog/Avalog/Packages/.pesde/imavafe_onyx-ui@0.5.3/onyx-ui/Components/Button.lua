-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local ColorUtils = require(Parent.Parent.ColorUtils)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local innerScope = Fusion.innerScope
local v1 = {
    BaseButton = require(script.Parent.BaseButton),
    IconText = require(script.Parent.IconText)
}
return function(v2, v3) -- line 54 | captures: Fusion, ColorUtils, Util, Themer, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local Medium = Util.Fallback(v3.SizeVariant, "Medium")
    local v6 = Util.Fallback(v3.Disabled, false)
    local v7 = Util.Fallback(v3.Content, {})
    local Filled = Util.Fallback(v3.Style, "Filled")
    local v8 = Util.Fallback(v3.Color, v5.Colors.Neutral.Main)
    local v9 = Util.Fallback(v3.ContentColor, v4:Computed(function(v10) -- line 65 | captures: v5, v8, ColorUtils
        return ColorUtils.Emphasize(v10(v8), v10(v5.Emphasis.Contrast))
    end))
    local v11 = Util.Fallback(v3.ContentSize, v4:Computed(function(v12) -- line 71 | captures: v5, Medium
        return ({
                ExtraSmall = v12(v5.TextSize["0.875"]),
                Small = v12(v5.TextSize["1"]),
                Medium = v12(v5.TextSize["1"]),
                Large = v12(v5.TextSize["1.25"]),
                ExtraLarge = v12(v5.TextSize["1.25"])
            })[v12(Medium)]
    end))
    local v13 = Util.Fallback(v3.ContentWrapped, false)
    local v14 = v4:EnsureValue(Util.Fallback(v3.IsHovering, false))
    local v15 = v4:EnsureValue(Util.Fallback(v3.IsHolding, false))
    local v16 = v4:Computed(function(v17) -- line 88 | captures: v5, v6, v8, v14, v15, ColorUtils
        if v17(v6) then
            return v17(v5.Colors.BaseContent.Main)
        end
        if v17(v15) then
            return ColorUtils.Emphasize(v17(v8), v17(v5.Emphasis.Regular))
        end
        if v17(v14) then
            return ColorUtils.Emphasize(v17(v8), v17(v5.Emphasis.Light))
        end
        return v17(v8)
    end)
    local v18 = v4:Computed(function(v19) -- line 101 | captures: v5, v6, Filled, v9, v16
        if v19(v6) then
            return v19(v5.Colors.BaseContent.Main)
        end
        if v19(Filled) ~= "Filled" then
            if v19(Filled) == "Outlined" then
                return v19(v16)
            end
            if v19(Filled) == "Ghost" then
                return v19(v16)
            end
        end
        return v19(v9)
    end)
    local v20 = v4:Computed(function(v21) -- line 116 | captures: v6
        if v21(v6) then
            return 0.75
        end
        return 0
    end)
    local v22 = v4:Computed(function(v23) -- line 123 | captures: v5, Medium
        local v24 = {
            ExtraSmall = v23(v5.Spacing["0.25"]),
            Small = v23(v5.Spacing["0.5"]),
            Medium = v23(v5.Spacing["0.75"]),
            Large = v23(v5.Spacing["1"]),
            ExtraLarge = v23(v5.Spacing["1.5"])
        }
        return UDim.new(0, v24[v23(Medium)])
    end)
    local v25 = v4:Computed(function(v26) -- line 134 | captures: v5, Medium
        local v27 = {
            ExtraSmall = 0.5,
            Small = 0.75,
            Medium = 1.25,
            Large = 1.5,
            ExtraLarge = 2
        }
        return UDim.new(0, v26(v5.Spacing["0.25"]) * v27[v26(Medium)])
    end)
    local CombineProps = Util.CombineProps
    local v28 = { Name = "Button" }
    v28.BackgroundTransparency = v4:Computed(function(v29) -- line 148 | captures: v6, Filled
        if v29(Filled) == "Filled" then
            if v29(v6) then
                return 0.925
            end
            return 0
        end
        return 1
    end)
    v28.BackgroundColor3 = v4:Spring(v16, v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v28.PaddingLeft = v22
    v28.PaddingRight = v22
    v28.PaddingTop = v25
    v28.PaddingBottom = v25
    v28.CornerRadius = v4:Computed(function(v30) -- line 164 | captures: v5
        return UDim.new(0, v30(v5.CornerRadius["1"]))
    end)
    v28.ListEnabled = true
    v28.ListFillDirection = Enum.FillDirection.Horizontal
    v28.ListHorizontalAlignment = Enum.HorizontalAlignment.Center
    v28.ListVerticalAlignment = Enum.VerticalAlignment.Center
    v28.ListWraps = false
    v28.StrokeEnabled = true
    v28.StrokeColor = v4:Spring(v16, v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v28.StrokeTransparency = v4:Computed(function(v31) -- line 174 | captures: v6, Filled
        if v31(Filled) == "Ghost" then
            return 1
        end
        if v31(v6) then
            return 0.925
        end
        return 0
    end)
    v28.IsHolding = v15
    v28.IsHovering = v14
    local v32 = {
        Content = v7,
        ContentColor = v18,
        ContentTransparency = v20,
        ContentSize = v11,
        ContentWrapped = v13
    }
    v32.ListPadding = v4:Computed(function(v33) -- line 193 | captures: v5
        return UDim.new(0, v33(v5.Spacing["0.25"]))
    end)
    v32.ListHorizontalAlignment = Enum.HorizontalAlignment.Center
    v32.ListVerticalAlignment = Enum.VerticalAlignment.Center
    v28[Children] = { v4:IconText(v32) }
    return v4:BaseButton(CombineProps(v3, v28))
end
