-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local innerScope = Fusion.innerScope
return function(v1, v2) -- line 247 | captures: Fusion, Util, Themer, Children, innerScope
    local v3 = innerScope(v1, Fusion, Util)
    local v4 = Themer.Theme:now()
    local Frame = Util.Fallback(v2.ClassName, "Frame")
    local Base = Util.Fallback(v2.Name, "Base")
    local v5 = Util.Fallback(v2.AutomaticSize, Enum.AutomaticSize.XY)
    local v6 = Util.Fallback(v2.CornerRadius, UDim.new(0, 0))
    local v7 = Util.Fallback(v2.StrokeThickness, v4.StrokeThickness["1"])
    local v8 = Util.Fallback(v2.StrokeColor, v4.Colors.Neutral.Main)
    local v9 = Util.Fallback(v2.StrokeApplyStrokeMode, Enum.ApplyStrokeMode.Border)
    local v10 = Util.Fallback(v2.StrokeLineJoinMode, v3:Computed(function(v11) -- line 260 | captures: v6
        local v12 = v11(v6)
        if v12 ~= nil and (v12.Offset > 1 or v12.Scale > 1) then
            return Enum.LineJoinMode.Round
        end
        return Enum.LineJoinMode.Miter
    end))
    local v13 = Util.Fallback(v2.Padding, v3:Computed(function(v14) -- line 271 | captures: v4
        return UDim.new(0, v14(v4.Spacing["1"]))
    end))
    local v15 = Util.Fallback(v2.PaddingBottom, v2.Padding)
    local v16 = Util.Fallback(v2.PaddingLeft, v2.Padding)
    local v17 = Util.Fallback(v2.PaddingRight, v2.Padding)
    local v18 = Util.Fallback(v2.PaddingTop, v2.Padding)
    local v19 = Util.Fallback(v2.ListPadding, v3:Computed(function(v20) -- line 281 | captures: v4
        return UDim.new(0, v20(v4.Spacing["1"]))
    end))
    local v21 = Util.Fallback(v2.ListSortOrder, Enum.SortOrder.LayoutOrder)
    local v22 = Util.Fallback(v2.GridCellPadding, v3:Computed(function(v23) -- line 288 | captures: v4
        return UDim2.fromOffset(v23(v4.Spacing["0.5"]), v23(v4.Spacing["0.5"]))
    end))
    local v24 = Util.Fallback(v2.GridSortOrder, Enum.SortOrder.LayoutOrder)
    local v25 = Util.Fallback(v2.PagePadding, v3:Computed(function(v26) -- line 295 | captures: v4
        return UDim.new(0, v26(v4.Spacing["0.5"]))
    end))
    local v27 = Util.Fallback(v2.PageSortOrder, Enum.SortOrder.LayoutOrder)
    local v28 = Util.Fallback(v2.TablePadding, v3:Computed(function(v29) -- line 302 | captures: v4
        return UDim.new(0, v29(v4.Spacing["0.5"]))
    end))
    local v30 = Util.Fallback(v2.TableSortOrder, Enum.SortOrder.LayoutOrder)
    local v31 = v3:Computed(function(v32) -- line 308 | captures: v2
        local v33 = {
            v2.Padding,
            v2.PaddingTop,
            v2.PaddingLeft,
            v2.PaddingRight,
            v2.PaddingBottom
        }
        for v34, v35 in pairs(v33) do
            local v36 = v32(v35)
            if typeof(v36) == "UDim" then
                return true
            end
        end
        return false
    end)
    local v37 = v3:New(Frame)
    local v38 = {
        Name = Base,
        AutomaticSize = v5,
        Parent = v2.Parent,
        Position = v2.Position,
        Rotation = v2.Rotation,
        AnchorPoint = v2.AnchorPoint,
        Size = v2.Size,
        Visible = v2.Visible,
        ZIndex = v2.ZIndex,
        LayoutOrder = v2.LayoutOrder,
        ClipsDescendants = v2.ClipsDescendants,
        Active = v2.Active,
        Selectable = v2.Selectable,
        Interactable = v2.Interactable,
        BackgroundColor3 = v2.BackgroundColor3,
        BackgroundTransparency = v2.BackgroundTransparency,
        NextSelectionDown = v2.NextSelectionDown,
        NextSelectionUp = v2.NextSelectionUp,
        NextSelectionRight = v2.NextSelectionRight,
        NextSelectionLeft = v2.NextSelectionLeft,
        SelectionImageObject = v2.SelectionImageObject,
        SelectionOrder = v2.SelectionOrder,
        SizeConstraint = v2.SizeConstraint,
        AutoLocalize = v2.AutoLocalize,
        RootLocalizationTable = v2.RootLocalizationTable,
        SelectionBehaviorDown = v2.SelectionBehaviorDown,
        SelectionBehaviorUp = v2.SelectionBehaviorUp,
        SelectionBehaviorRight = v2.SelectionBehaviorRight,
        SelectionBehaviorLeft = v2.SelectionBehaviorLeft,
        SelectionGroup = v2.SelectionGroup
    }
    local v39 = v3:Computed(function(v40) -- line 355 | captures: v3, v6
        local v41 = v40(v6)
        if not (v41 == nil or v41.Offset == 0 and v41.Scale == 0) then
            return v3:New("UICorner")({ CornerRadius = v6 })
        end
    end)
    local v42 = v3:Computed(function(v43) -- line 368 | captures: v3, v13, v15, v16, v17, v18, v31
        if v43(v31) == true then
            return v3:New("UIPadding")({
                PaddingTop = v3:Computed(function(v44) -- line 372 | captures: v13, v18
                    local v45 = v44(v18)
                    local v46 = v44(v13)
                    if typeof(v45) == "UDim" then
                        return v45
                    end
                    if typeof(v46) == "UDim" then
                        return v46
                    end
                    return UDim.new()
                end),
                PaddingBottom = v3:Computed(function(v47) -- line 383 | captures: v13, v15
                    local v48 = v47(v15)
                    local v49 = v47(v13)
                    if typeof(v48) == "UDim" then
                        return v48
                    end
                    if typeof(v49) == "UDim" then
                        return v49
                    end
                    return UDim.new()
                end),
                PaddingLeft = v3:Computed(function(v50) -- line 394 | captures: v13, v16
                    local v51 = v50(v16)
                    local v52 = v50(v13)
                    if typeof(v51) == "UDim" then
                        return v51
                    end
                    if typeof(v52) == "UDim" then
                        return v52
                    end
                    return UDim.new()
                end),
                PaddingRight = v3:Computed(function(v53) -- line 405 | captures: v13, v17
                    local v54 = v53(v17)
                    local v55 = v53(v13)
                    if typeof(v54) == "UDim" then
                        return v54
                    end
                    if typeof(v55) == "UDim" then
                        return v55
                    end
                    return UDim.new()
                end)
            })
        end
    end)
    local v56 = v3:Computed(function(v57) -- line 421 | captures: v2, v3
        local v58 = v57(v2.Scale)
        if v58 == nil or v58 == 1 then
            return
        end
        return v3:New("UIScale")({ Scale = v58 })
    end)
    local v59 = v3:Computed(function(v60) -- line 431 | captures: v2, v3, v7, v8, v9, v10
        if v60(v2.StrokeEnabled) == true then
            return v3:New("UIStroke")({
                Enabled = v2.StrokeEnabled,
                Thickness = v7,
                Color = v8,
                Transparency = v2.StrokeTransparency,
                ApplyStrokeMode = v9,
                LineJoinMode = v10
            })
        end
    end)
    local v61 = v3:Computed(function(v62) -- line 445 | captures: v2, v3
        if v62(v2.GradientEnabled) == true then
            return v3:New("UIGradient")({
                Enabled = v2.GradientEnabled,
                Color = v2.GradientColor,
                Offset = v2.GradientOffset,
                Rotation = v2.GradientRotation,
                Transparency = v2.GradientTransparency
            })
        end
    end)
    local v63 = v3:Computed(function(v64) -- line 458 | captures: v2, v3
        if v64(v2.AspectRatio) == nil then
            return
        end
        return v3:New("UIAspectRatioConstraint")({
            AspectRatio = v2.AspectRatio,
            DominantAxis = v2.DominantAxis,
            AspectType = v2.AspectType
        })
    end)
    local v65 = v3:Computed(function(v66) -- line 469 | captures: v2, v3
        if not (v66(v2.MaxSize) == nil and v66(v2.MinSize) == nil) then
            return v3:New("UISizeConstraint")({
                MaxSize = v2.MaxSize,
                MinSize = v2.MinSize
            })
        end
    end)
    local v67 = v3:Computed(function(v68) -- line 479 | captures: v2, v3
        if not (v68(v2.MaxTextSize) == nil and v68(v2.MinTextSize) == nil) then
            return v3:New("UITextSizeConstraint")({
                MaxTextSize = v2.MaxTextSize,
                MinTextSize = v2.MinTextSize
            })
        end
    end)
    local v69 = v3:Computed(function(v70) -- line 489 | captures: v2, v3, v19, v21
        if v70(v2.ListEnabled) == true then
            return v3:New("UIListLayout")({
                Padding = v19,
                FillDirection = v2.ListFillDirection,
                SortOrder = v21,
                Wraps = v2.ListWraps,
                HorizontalAlignment = v2.ListHorizontalAlignment,
                HorizontalFlex = v2.ListHorizontalFlex,
                ItemLineAlignment = v2.ListItemLineAlignment,
                VerticalAlignment = v2.ListVerticalAlignment,
                VerticalFlex = v2.ListVerticalFlex
            })
        end
    end)
    local v71 = v3:Computed(function(v72) -- line 506 | captures: v2, v3, v22, v24
        if v72(v2.GridEnabled) == true then
            return v3:New("UIGridLayout")({
                CellPadding = v22,
                CellSize = v2.GridCellSize,
                FillDirection = v2.GridFillDirection,
                FillDirectionMaxCells = v2.GridFillDirectionMaxCells,
                SortOrder = v24,
                StartCorner = v2.GridStartCorner,
                HorizontalAlignment = v2.GridHorizontalAlignment,
                VerticalAlignment = v2.GridVerticalAlignment
            })
        end
    end)
    local v73 = v3:Computed(function(v74) -- line 522 | captures: v2, v3, v28, v30
        if v74(v2.TableEnabled) == true then
            return v3:New("UITableLayout")({
                Padding = v28,
                FillEmptySpaceColumns = v2.TableFillEmptySpaceColumns,
                FillEmptySpaceRows = v2.TableFillEmptySpaceRows,
                FillDirection = v2.TableFillDirection,
                SortOrder = v30,
                MajorAxis = v2.TableMajorAxis,
                HorizontalAlignment = v2.TableHorizontalAlignment,
                VerticalAlignment = v2.TableVerticalAlignment
            })
        end
    end)
    local v75 = v3:Computed(function(v76) -- line 538 | captures: v2, v3, v25, v27
        if v76(v2.PageEnabled) == true then
            return v3:New("UIPageLayout")({
                Animated = v2.PageAnimated,
                Circular = v2.PageCircular,
                EasingDirection = v2.PageEasingDirection,
                EasingStyle = v2.PageEasingStyle,
                Padding = v25,
                TweenTime = v2.PageTweenTime,
                FillDirection = v2.PageFillDirection,
                SortOrder = v27,
                HorizontalAlignment = v2.PageHorizontalAlignment,
                VerticalAlignment = v2.PageVerticalAlignment,
                GamepadInputEnabled = v2.PageGamepadInputEnabled,
                ScrollWheelInputEnabled = v2.PageScrollWheelInputEnabled,
                TouchInputEnabled = v2.PageTouchInputEnabled
            })
        end
    end)
    v38[Children] = {
        v39,
        v42,
        v56,
        v59,
        v61,
        v63,
        v65,
        v67,
        v69,
        v71,
        v73,
        v75,
        v3:Computed(function(v77) -- line 559 | captures: v2, v3
            local v78 = v77(v2.FlexMode)
            if v78 == nil or v78 == Enum.UIFlexMode.None then
                return
            end
            return v3:New("UIFlexItem")({
                FlexMode = v2.FlexMode,
                FlexItemLineAlignment = v2.FlexItemLineAlignment,
                FlexGrowRatio = v2.FlexGrowRatio,
                FlexShrinkRatio = v2.FlexShrinkRatio
            })
        end),
        v2[Children]
    }
    return v37(v38)
end
