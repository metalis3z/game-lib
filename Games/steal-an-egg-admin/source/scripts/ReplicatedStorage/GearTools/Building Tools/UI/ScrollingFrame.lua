-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
local createElement = v2.createElement
local ScrollingFrame = v2.PureComponent:extend("ScrollingFrame")

ScrollingFrame.defaultProps = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(1, 0, 1, 0)
}

function ScrollingFrame.render(v3) -- line 23 | captures: v1, v2, createElement
    local v4 = v1.CloneTable(v3.props)
    local state = v3.state
    if v4.AspectRatio then
        local v5 = createElement("UIAspectRatioConstraint", { AspectRatio = v4.AspectRatio })
        v4[v2.Children] = v1.Merge({ AspectRatio = v5 }, v4[v2.Children] or {})
    end
    if v4.Layout == "List" then
        local v6 = {
            FillDirection = v4.LayoutDirection,
            Padding = v4.LayoutPadding,
            HorizontalAlignment = v4.HorizontalAlignment,
            VerticalAlignment = v4.VerticalAlignment,
            SortOrder = v4.SortOrder or "LayoutOrder"
        }

        v6[v2.Ref] = function(v7) -- line 48 | captures: v3
            v3:UpdateContentSize(v7)
        end

        v6[v2.Change.AbsoluteContentSize] = function(v8) -- line 51 | captures: v3
            v3:UpdateContentSize(v8)
        end

        local v9 = createElement("UIListLayout", v6)
        v4.Size = v3:GetSize()
        v4.CanvasSize = v3:GetCanvasSize()
        v4[v2.Children] = v1.Merge({ Layout = v9 }, v4[v2.Children] or {})
    end
    v4.AspectRatio = nil
    v4.Layout = nil
    v4.LayoutDirection = nil
    v4.LayoutPadding = nil
    v4.HorizontalAlignment = nil
    v4.VerticalAlignment = nil
    v4.SortOrder = nil
    v4.Width = nil
    v4.Height = nil
    v4.CanvasWidth = nil
    v4.CanvasHeight = nil
    return createElement("ScrollingFrame", v4)
end

function ScrollingFrame.GetSize(v10, v11) -- line 85
    local props = v10.props
    local v12 = if props.Size == "WRAP_CONTENT" then true else props.Width == "WRAP_CONTENT"
    local v13 = if props.Size == "WRAP_CONTENT" then true else props.Height == "WRAP_CONTENT"
    local new = UDim2.new
    local v14, v15
    if v11 and v12 then
        local v16 = UDim.new(0, v11.X)
        if v16 then
            v14 = v16
            v15 = true
        else
            v15 = false
        end
    else
        v15 = false
    end
    if not v15 then
        local Width = props.Width
        local v17 = typeof(Width) == "UDim"
        local Width_2 = if v17 then props.Width else nil
        if not v17 or not Width_2 then
            v14 = props.Size.X
        else
            v14 = Width_2
        end
    end
    local v18, v19
    if v11 and v13 then
        local v20 = UDim.new(0, v11.Y)
        if v20 then
            v18 = v20
            v19 = true
        else
            v19 = false
        end
    else
        v19 = false
    end
    if not v19 then
        local Height = props.Height
        local v21 = typeof(Height) == "UDim"
        local Height_2 = if v21 then props.Height else nil
        if not v21 or not Height_2 then
            v18 = props.Size.Y
        else
            v18 = Height_2
        end
    end
    return new(v14, v18)
end

function ScrollingFrame.GetCanvasSize(v22, v23) -- line 104
    local props = v22.props
    local v24 = if props.CanvasSize == "WRAP_CONTENT" then true else props.CanvasWidth == "WRAP_CONTENT"
    local v25 = if props.CanvasSize == "WRAP_CONTENT" then true else props.CanvasHeight == "WRAP_CONTENT"
    local new = UDim2.new
    local v26, v27
    if v23 and v24 then
        local v28 = UDim.new(0, v23.X)
        if v28 then
            v26 = v28
            v27 = true
        else
            v27 = false
        end
    else
        v27 = false
    end
    if not v27 then
        local CanvasWidth = props.CanvasWidth
        local v29 = typeof(CanvasWidth) == "UDim"
        local CanvasWidth_2 = if v29 then props.CanvasWidth else nil
        if not v29 or not CanvasWidth_2 then
            v26 = props.CanvasSize.X
        else
            v26 = CanvasWidth_2
        end
    end
    local v30, v31
    if v23 and v25 then
        local v32 = UDim.new(0, v23.Y)
        if v32 then
            v30 = v32
            v31 = true
        else
            v31 = false
        end
    else
        v31 = false
    end
    if not v31 then
        local CanvasHeight = props.CanvasHeight
        local v33 = typeof(CanvasHeight) == "UDim"
        local CanvasHeight_2 = if v33 then props.CanvasHeight else nil
        if not v33 or not CanvasHeight_2 then
            v30 = props.CanvasSize.Y
        else
            v30 = CanvasHeight_2
        end
    end
    return new(v26, v30)
end

function ScrollingFrame.UpdateContentSize(v34, v35) -- line 123
    if v35 and v35.Parent then
        v35.Parent.Size = v34:GetSize(v35.AbsoluteContentSize)
        v35.Parent.CanvasSize = v34:GetCanvasSize(v35.AbsoluteContentSize)
    end
end

return ScrollingFrame
