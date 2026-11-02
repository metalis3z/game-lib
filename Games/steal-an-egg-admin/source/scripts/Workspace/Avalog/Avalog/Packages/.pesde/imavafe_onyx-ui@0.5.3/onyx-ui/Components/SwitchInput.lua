-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local ColorUtils = require(Parent.Parent.ColorUtils)
local peek = Fusion.peek
local Children = Fusion.Children
local innerScope = Fusion.innerScope
local v1 = {
    Frame = require(script.Parent.Frame),
    BaseButton = require(script.Parent.BaseButton)
}
return function(v2, v3) -- line 39 | captures: Fusion, Util, Themer, ColorUtils, peek, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = v4:EnsureValue(Util.Fallback(v3.Switched, false))
    local v7 = v4:EnsureValue(Util.Fallback(v3.Disabled, false))
    local v8 = Util.Fallback(v3.Color, v5.Colors.Primary.Main)
    local v9 = Util.Fallback(v3.Size, v4:Computed(function(v10) -- line 48 | captures: v5
        return UDim2.fromOffset(v10(v5.TextSize["1"]) * 2, v10(v5.TextSize["1"]))
    end))
    local v11 = Util.Fallback(v3.AutomaticSize, Enum.AutomaticSize.None)
    local v12 = v4:EnsureValue(Util.Fallback(v3.IsHovering, false))
    local v13 = v4:EnsureValue(Util.Fallback(v3.IsHolding, false))
    local v14 = v4:Computed(function(v15) -- line 56 | captures: v5, v6, v7, v8, v12, v13, ColorUtils
        local v16
        if v15(v6) then
            v16 = v15(v8)
        else
            v16 = v15(v5.Colors.NeutralContent.Dark)
        end
        if not v15(v7) then
            if v15(v13) then
                return ColorUtils.Emphasize(v15(v16), v15(v5.Emphasis.Regular))
            end
            if v15(v12) then
                return ColorUtils.Emphasize(v15(v16), v15(v5.Emphasis.Light))
            end
        end
        return v16
    end)
    local v17 = v4:Computed(function(v18) -- line 74 | captures: v5, v6, v7, v12, v13, ColorUtils
        local v19
        if v18(v6) then
            v19 = v18(v5.Colors.Base.Main)
        else
            v19 = v18(v5.Colors.NeutralContent.Dark)
        end
        if not v18(v7) then
            if v18(v13) then
                if v18(v6) then
                    return v19
                end
                return ColorUtils.Emphasize(v18(v19), v18(v5.Emphasis.Regular))
            end
            if v18(v12) then
                if v18(v6) then
                    return v19
                end
                return ColorUtils.Emphasize(v18(v19), v18(v5.Emphasis.Light))
            end
        end
        return v19
    end)
    local v20 = Util.Fallback(v3.CornerRadius, v4:Computed(function(v21) -- line 102 | captures: v5
        return UDim.new(0, v21(v5.CornerRadius.Full))
    end))
    local CombineProps = Util.CombineProps
    local v22 = {
        Name = "SwitchInput",
        Size = v9,
        AutomaticSize = v11,
        Disabled = v7,
        StrokeEnabled = true
    }
    v22.StrokeTransparency = v4:Spring(v4:Computed(function(v23) -- line 114 | captures: v6, v7
        if v23(v7) then
            return 0.8
        end
        if v23(v6) then
            return 0
        end
        return 0.6
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v22.StrokeColor = v4:Spring(v14, v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v22.CornerRadius = v20
    v22.ClickSound = v5.Sound.Switch
    v22.IsHovering = v12
    v22.IsHolding = v13

    function v22.OnActivated() -- line 133 | captures: v6, peek
        v6:set(not peek(v6))
    end

    local v24 = {
        Name = "Switch",
        Size = v9,
        AutomaticSize = v11,
        BackgroundColor3 = v4:Spring(v14, v5.SpringSpeed["1"], v5.SpringDampening["1"])
    }
    v24.BackgroundTransparency = v4:Spring(v4:Computed(function(v25) -- line 144 | captures: v6
        if v25(v6) then
            return 0
        end
        return 1
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v24.Padding = UDim.new(0, 2)
    v24.CornerRadius = v20
    local v26 = { Name = "Ball" }
    v26.AnchorPoint = v4:Spring(v4:Computed(function(v27) -- line 161 | captures: v6
        if v27(v6) then
            return Vector2.new(1, 0.5)
        end
        return Vector2.new(0, 0.5)
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v26.Position = v4:Spring(v4:Computed(function(v28) -- line 172 | captures: v6
        if v28(v6) then
            return UDim2.fromScale(1, 0.5)
        end
        return UDim2.fromScale(0, 0.5)
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v26.Size = v4:Spring(v4:Computed(function(v29) -- line 183 | captures: v12
        local v30 = if v29(v12) then 0.85 * 1.1 else 0.85
        return UDim2.fromScale(0, v30)
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v26.AutomaticSize = Enum.AutomaticSize.None
    v26.BackgroundTransparency = v4:Spring(v4:Computed(function(v31) -- line 196 | captures: v6, v7
        if v31(v7) then
            return 0.7
        end
        if v31(v6) then
        end
        return 0
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v26.BackgroundColor3 = v4:Spring(v17, v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v26.AspectRatio = v4:Spring(v4:Computed(function(v32) -- line 215 | captures: v13
        if v32(v13) then
            return 1.2
        end
        return 1
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v26.AspectType = Enum.AspectType.ScaleWithParentSize
    v26.DominantAxis = Enum.DominantAxis.Height
    v26.CornerRadius = v20
    v24[Children] = { v4:Frame(v26) }
    v22[Children] = { v4:Frame(v24) }
    return v4:BaseButton(CombineProps(v3, v22, { "Size", "AutomaticSize" }))
end
