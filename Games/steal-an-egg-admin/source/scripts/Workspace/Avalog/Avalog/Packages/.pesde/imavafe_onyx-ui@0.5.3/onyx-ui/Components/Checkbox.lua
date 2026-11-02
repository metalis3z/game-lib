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
    BaseButton = require(script.Parent.BaseButton),
    Icon = require(script.Parent.Icon)
}
return function(v2, v3) -- line 42 | captures: Fusion, Util, Themer, ColorUtils, peek, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = v4:EnsureValue(Util.Fallback(v3.Checked, false))
    local v7 = Util.Fallback(v3.Disabled, false)
    local v8 = Util.Fallback(v3.Color, v5.Colors.Primary.Main)
    local v9 = Util.Fallback(v3.Icon, "rbxassetid://13858821963")
    local v10 = v4:EnsureValue(Util.Fallback(v3.IsHovering, false))
    local v11 = v4:EnsureValue(Util.Fallback(v3.IsHolding, false))
    local v12 = v4:Computed(function(v13) -- line 53 | captures: v5, v7, v8, v10, v11, ColorUtils
        if v13(v7) then
            return v13(v5.Colors.BaseContent.Main)
        end
        if v13(v11) then
            return ColorUtils.Emphasize(v13(v8), v13(v5.Emphasis.Regular))
        end
        if v13(v10) then
            return ColorUtils.Emphasize(v13(v8), v13(v5.Emphasis.Light))
        end
        return v13(v8)
    end)
    local CombineProps = Util.CombineProps
    local v14 = {
        Name = "Checkbox",
        BackgroundColor3 = v12
    }
    v14.BackgroundTransparency = v4:Spring(v4:Computed(function(v15) -- line 71 | captures: v6, v7
        if v15(v7) then
            return 0.925
        end
        if v15(v6) then
            return 0
        end
        return 1
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v14.Disabled = v7
    v14.CornerRadius = v4:Computed(function(v16) -- line 86 | captures: v5
        return UDim.new(0, v16(v5.CornerRadius["0.5"]))
    end)
    v14.StrokeEnabled = true
    v14.StrokeColor = v12
    v14.StrokeTransparency = v4:Computed(function(v17) -- line 91 | captures: v7
        if v17(v7) then
            return 0.925
        end
        return 0
    end)
    v14.IsHovering = v10
    v14.IsHolding = v11

    function v14.OnActivated() -- line 102 | captures: v6, peek
        v6:set(not peek(v6))
    end

    local v18 = {
        Name = "CheckIcon",
        Image = v9
    }
    v18.ImageTransparency = v4:Spring(v4:Computed(function(v19) -- line 111 | captures: v6, v7
        if v19(v6) then
            if v19(v7) then
                return 0.75
            end
            return 0
        end
        return 1
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v18.ImageColor3 = v4:Computed(function(v20) -- line 125 | captures: v5, v8, ColorUtils
        return ColorUtils.Emphasize(v20(v8), v20(v5.Emphasis.Contrast))
    end)
    v18.Rotation = v4:Spring(v4:Computed(function(v21) -- line 129 | captures: v6
        if v21(v6) then
            return 0
        end
        return -30
    end), v5.SpringSpeed["1"], v5.SpringDampening["1"])
    v14[Children] = { v4:Icon(v18) }
    return v4:BaseButton(CombineProps(v3, v14))
end
