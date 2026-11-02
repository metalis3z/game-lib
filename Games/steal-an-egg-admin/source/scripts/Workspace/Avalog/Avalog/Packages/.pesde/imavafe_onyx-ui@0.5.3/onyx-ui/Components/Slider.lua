-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local ColorUtils = require(Parent.Parent.ColorUtils)
local innerScope = Fusion.innerScope
local Children = Fusion.Children
local Out = Fusion.Out
local OnEvent = Fusion.OnEvent
local v1 = { BaseButton = require(script.Parent.BaseButton) }

function RoundByUnit(v2, v3) -- line 24
    local v4 = v2 / v3 + 0.5
    return math.floor(v4) * v3
end

return function(v5, v6) -- line 47 | captures: Fusion, Themer, Util, ColorUtils, innerScope, Children, Out, OnEvent, v1
    local v7 = innerScope(v5, Fusion, Util, v1)
    local v8 = Themer.Theme:now()
    local v9 = Util.Fallback(v6.Unit, 0.01)
    local v10 = v7:EnsureValue(Util.Fallback(v6.Value, 1))
    local v11 = Util.Fallback(v6.Color, v8.Colors.Primary.Main)
    local v12 = Util.Fallback(v6.Disabled, false)
    local v13 = v7:EnsureValue(Util.Fallback(v6.IsHovering, false))
    local v14 = v7:EnsureValue(Util.Fallback(v6.IsHolding, false))
    local v15 = v7:Value(nil)
    local v16 = v7:Value(Vector2.new())
    local v17 = v7:Value(Vector2.new())
    local v18 = v7:Computed(function(v19) -- line 62 | captures: v8, v11, v12, v13, v14, ColorUtils
        if v19(v12) then
            return v19(v8.Colors.BaseContent.Main)
        end
        if v19(v14) then
            return ColorUtils.Emphasize(v19(v11), v19(v8.Emphasis.Regular))
        end
        if v19(v13) then
            return ColorUtils.Emphasize(v19(v11), v19(v8.Emphasis.Light))
        end
        return v19(v11)
    end)

    local function ProcessDrag(v20) -- line 76 | captures: v9, v10, v16, v17, Fusion
        local v21 = Fusion.peek(v16)
        local v22 = Fusion.peek(v17)
        local v23 = Fusion.peek(v9)
        local v24 = v20.X - v22.X
        local v25 = RoundByUnit
        local v26 = v24 / v21.X
        v10:set(v25(math.clamp(v26, 0, 1), v23))
    end

    local CombineProps = Util.CombineProps
    local v27 = { Name = script.Name }
    v27.CornerRadius = v7:Computed(function(v28) -- line 88 | captures: v8
        return UDim.new(0, v28(v8.CornerRadius.Full))
    end)
    v27.Size = v7:Computed(function(v29) -- line 91 | captures: v8
        return UDim2.fromOffset(0, v29(v8.TextSize["1"]))
    end)
    v27.AutomaticSize = Enum.AutomaticSize.Y
    v27.Disabled = v12
    v27.IsHovering = v13
    local v30 = { Name = "Progress" }
    v30.CornerRadius = v7:Computed(function(v31) -- line 102 | captures: v8
        return UDim.new(0, v31(v8.CornerRadius.Full))
    end)
    v30.BackgroundTransparency = 0
    v30.BackgroundColor3 = v8.Colors.Neutral.Main
    v30.Size = v7:Computed(function(v32) -- line 107 | captures: v8
        return UDim2.new(UDim.new(1, 0), UDim.new(0, v32(v8.TextSize["0.75"])))
    end)
    v30.FlexMode = Enum.UIFlexMode.Fill
    local v33 = { Name = "Progress" }
    v33.Size = v7:Computed(function(v34) -- line 115 | captures: v10
        local v35 = v34(v10)
        return UDim2.fromScale(v35, 1)
    end)
    v33.BackgroundTransparency = v7:Computed(function(v36) -- line 119 | captures: v12
        if v36(v12) then
            return 0.925
        end
        return 0
    end)
    v33.BackgroundColor3 = v7:Spring(v18, v8.SpringSpeed["1"], v8.SpringDampening["1"])
    v33.CornerRadius = v7:Computed(function(v37) -- line 131 | captures: v8
        return UDim.new(0, v37(v8.CornerRadius.Full))
    end)
    v33.AutomaticSize = Enum.AutomaticSize.None
    local v38 = {
        Name = "Ball",
        AspectRatio = 1
    }
    v38.AnchorPoint = v7:Computed(function(v39) -- line 140 | captures: v10
        local v40 = v39(v10)
        return Vector2.new(v40, 0.5)
    end)
    v38.Position = UDim2.fromScale(1, 0.5)
    v38.Size = v7:Computed(function(v41) -- line 145 | captures: v8
        local v42 = v41(v8.TextSize["1"])
        return UDim2.fromOffset(v42, v42)
    end)
    v38.BackgroundTransparency = 0
    v38.BackgroundColor3 = v7:Computed(function(v43) -- line 150 | captures: v8, v12
        if v43(v12) then
            return v43(v8.Colors.Neutral.Main)
        end
        return v43(v8.Colors.BaseContent.Main)
    end)
    v38.CornerRadius = v7:Computed(function(v44) -- line 157 | captures: v8
        return UDim.new(0, v44(v8.CornerRadius.Full))
    end)
    v38.StrokeEnabled = true
    v38.StrokeColor = v8.Colors.Neutral.Main
    v38.StrokeThickness = v8.StrokeThickness["1"]
    v38.AutomaticSize = Enum.AutomaticSize.None
    local v45 = {
        Name = "SmallBall",
        AspectRatio = 1,
        BackgroundTransparency = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5)
    }
    v45.Size = v7:Computed(function(v46) -- line 171 | captures: v8
        local v47 = v46(v8.TextSize["0.75"])
        return UDim2.fromOffset(v47, v47)
    end)
    v45.BackgroundColor3 = v7:Spring(v7:Computed(function(v48) -- line 177 | captures: v8, v12, v18
        if v48(v12) then
            return v48(v8.Colors.Neutral.Dark)
        end
        return v48(v18)
    end), v8.SpringSpeed["1"], v8.SpringDampening["1"])
    v45.CornerRadius = v7:Computed(function(v49) -- line 187 | captures: v8
        return UDim.new(0, v49(v8.CornerRadius.Full))
    end)
    v45.AutomaticSize = Enum.AutomaticSize.None
    v38[Children] = { v7:Frame(v45) }
    v33[Children] = { v7:Frame(v38) }
    v30[Children] = { v7:Frame(v33) }
    local v50 = v7:Hydrate(v7:Frame(v30))
    local v51 = {}
    v51[Out("AbsoluteSize")] = v16
    v51[Out("AbsolutePosition")] = v17
    v27[Children] = {
        v15,
        v50(v51)
    }
    local v52 = v7:BaseButton(CombineProps(v6, v27))
    local UIDragDetector = v7:New("UIDragDetector")
    local v53 = {
        DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
        DragAxis = Vector2.new(1, 0),
        BoundingUI = v52
    }
    v53.Enabled = v7:Computed(function(v54) -- line 208 | captures: v12
        return not v54(v12)
    end)

    v53[OnEvent("DragContinue")] = function(v55) -- line 212 | captures: ProcessDrag
        ProcessDrag(v55)
    end

    v53[OnEvent("DragStart")] = function(v56) -- line 215 | captures: v14, ProcessDrag
        ProcessDrag(v56)
        v14:set(true)
    end

    v53[OnEvent("DragEnd")] = function() -- line 219 | captures: v14
        v14:set(false)
    end

    v15:set(UIDragDetector(v53))
    return v52
end
