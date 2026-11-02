-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local ColorUtils = require(Parent.Parent.ColorUtils)
local innerScope = Fusion.innerScope
local Children = Fusion.Children
local peek = Fusion.peek
local v1 = {
    BaseButton = require(script.Parent.BaseButton),
    Text = require(script.Parent.Text),
    IconButton = require(script.Parent.IconButton)
}
return function(v2, v3) -- line 43 | captures: Fusion, Util, Themer, ColorUtils, innerScope, Children, peek, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Options, {})
    local v7 = v4:EnsureValue(Util.Fallback(v3.Selection, 1))
    local v8 = Util.Fallback(v3.Color, v5.Colors.BaseContent.Main)
    local v9 = Util.Fallback(v3.Disabled, false)
    local v10 = Util.Fallback(v3.ContentSize, v5.TextSize["1"])
    local v11 = v4:Value(false)
    local v12 = v4:Value(false)
    local v13 = v4:Value(0)
    local v14 = v4:Computed(function(v15) -- line 57 | captures: v6, v7
        return v15(v6)[v15(v7)]
    end)
    local v16 = v4:Computed(function(v17) -- line 63 | captures: v5, v8, v9, v11, v12, ColorUtils
        if v17(v9) then
            return v17(v5.Colors.BaseContent.Main)
        end
        if v17(v11) then
            return ColorUtils.Emphasize(v17(v8), v17(v5.Emphasis.Regular))
        end
        if v17(v12) then
            return ColorUtils.Emphasize(v17(v8), v17(v5.Emphasis.Light))
        end
        return v17(v8)
    end)
    local v18 = v4:Computed(function(v19) -- line 76 | captures: v10
        return v19(v10) * 1.25
    end)
    v4:Observer(v6):onChange(function() -- line 82 | captures: v7
        v7:set(1)
    end)

    local function RotateSelection(v20) -- line 86 | captures: v6, v7, peek
        local v21 = peek(v6)
        local v22 = peek(v7) + v20
        if #v21 < v22 then
            v22 = 1
        elseif v22 < 1 then
            v22 = #v21
        end
        v7:set(v22)
    end

    local v23 = peek(v3.Selection) or 1
    v4:Observer(v7):onChange(function() -- line 101 | captures: v7, v13, v23, peek
        local v24 = peek(v7)
        local v25 = if v23 < v24 then 1 else -1
        v13:set(v25)
        task.wait(0.1)
        v13:set(0)
    end)
    local CombineProps = Util.CombineProps
    local v26 = {
        Name = "SwapInput",
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListVerticalAlignment = Enum.VerticalAlignment.Center
    }
    v26.Padding = v4:Computed(function(v27) -- line 116 | captures: v5
        local v28 = v27(v5.Spacing["0.25"])
        return UDim.new(0, v28)
    end)
    v26.StrokeEnabled = true
    v26.StrokeColor = v8
    v26.StrokeTransparency = v4:Spring(v4:Computed(function(v29) -- line 123 | captures: v9
        if v29(v9) then
            return 0.9
        end
        return 0.8
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v26.CornerRadius = v4:Computed(function(v30) -- line 133 | captures: v5
        return UDim.new(0, v30(v5.CornerRadius["1"]))
    end)
    v26.Disabled = v9
    v26.IsHolding = v11
    v26.IsHovering = v12

    function v26.OnActivated() -- line 141 | captures: v6, v7, peek
        local v31 = peek(v6)
        local v32 = peek(v7) + 1
        if #v31 < v32 then
            v32 = 1
        elseif v32 < 1 then
            v32 = #v31
        end
        v7:set(v32)
    end

    local v33 = {
        Image = "rbxassetid://136326079088976",
        Style = "Ghost",
        Color = v8,
        Disabled = v9
    }
    v33.ContentSize = v4:Spring(v4:Computed(function(v34) -- line 152 | captures: v5, v13, v18
        local v35 = v34(v13)
        local v36 = v34(v18)
        if v35 < 0 then
            return v34(v36 * (1 - v34(v5.Emphasis.Regular)))
        end
        return v34(v36)
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])

    function v33.OnActivated() -- line 166 | captures: v6, v7, peek
        local v37 = peek(v6)
        local v38 = peek(v7) + -1
        if #v37 < v38 then
            v38 = 1
        elseif v38 < 1 then
            v38 = #v37
        end
        v7:set(v38)
    end

    local v39 = v4:IconButton(v33)
    local v40 = {}
    v40.Text = v4:Computed(function(v41) -- line 171 | captures: v14
        local v42 = v41(v14)
        if v42 == nil then
            return ""
        end
        return v42
    end)
    v40.TextColor3 = v16
    v40.TextTransparency = v4:Computed(function(v43) -- line 180 | captures: v9
        if v43(v9) then
            return 0.75
        end
        return 0
    end)
    local v44 = v4:Text(v40)
    local v45 = {
        Image = "rbxassetid://85293585205481",
        Style = "Ghost",
        Color = v8,
        Disabled = v9
    }
    v45.ContentSize = v4:Spring(v4:Computed(function(v46) -- line 194 | captures: v5, v13, v18
        local v47 = v46(v13)
        local v48 = v46(v18)
        if v47 > 0 then
            return v46(v48 * (1 - v46(v5.Emphasis.Regular)))
        end
        return v46(v48)
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])

    function v45.OnActivated() -- line 208 | captures: v6, v7, peek
        local v49 = peek(v6)
        local v50 = peek(v7) + 1
        if #v49 < v50 then
            v50 = 1
        elseif v50 < 1 then
            v50 = #v49
        end
        v7:set(v50)
    end

    v26[Children] = {
        v39,
        v44,
        v4:IconButton(v45)
    }
    return v4:BaseButton(CombineProps(v3, v26))
end
