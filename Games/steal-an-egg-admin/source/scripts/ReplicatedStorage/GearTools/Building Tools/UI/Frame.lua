-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
local createElement = v2.createElement
local Frame = v2.PureComponent:extend("Frame")

Frame.defaultProps = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0)
}

function Frame.render(v3) -- line 22 | captures: v1, v2, createElement
    local v4 = v1.CloneTable(v3.props)
    local state = v3.state
    if v4.AspectRatio then
        local v5 = createElement("UIAspectRatioConstraint", { AspectRatio = v4.AspectRatio })
        v4[v2.Children] = v1.Merge({ AspectRatio = v5 }, v4[v2.Children] or {})
        if v4.DominantAxis == "Width" then
            v4.SizeConstraint = "RelativeXX"
            local Width = v4.Width
            if typeof(Width) == "UDim" then
                v4.Height = UDim.new(v4.Width.Scale / v4.AspectRatio, 0)
            else
                v4.Size = UDim2.new(v4.Size.X, UDim.new(v4.Size.X.Scale / v4.AspectRatio, 0))
            end
        elseif v4.DominantAxis == "Height" then
            v4.SizeConstraint = "RelativeYY"
            local Height = v4.Height
            if typeof(Height) == "UDim" then
                v4.Width = UDim.new(v4.Height.Scale * v4.AspectRatio, 0)
            else
                v4.Size = UDim2.new(UDim.new(v4.Size.Y.Scale * v4.AspectRatio, 0), v4.Size.Y)
            end
        end
    end
    if v4.Layout == "List" then
        local v6 = {
            FillDirection = v4.LayoutDirection,
            Padding = v4.LayoutPadding,
            HorizontalAlignment = v4.HorizontalAlignment,
            VerticalAlignment = v4.VerticalAlignment,
            SortOrder = v4.SortOrder or "LayoutOrder"
        }

        v6[v2.Ref] = function(v7) -- line 72 | captures: v3
            v3:UpdateContentSize(v7)
        end

        v6[v2.Change.AbsoluteContentSize] = function(v8) -- line 75 | captures: v3
            v3:UpdateContentSize(v8)
        end

        local v9 = createElement("UIListLayout", v6)
        v4.Size = v3:GetSize()
        v4[v2.Children] = v1.Merge({ Layout = v9 }, v4[v2.Children])
    end
    v4.AspectRatio = nil
    v4.DominantAxis = nil
    v4.Layout = nil
    v4.LayoutDirection = nil
    v4.LayoutPadding = nil
    v4.HorizontalAlignment = nil
    v4.VerticalAlignment = nil
    v4.HorizontalPadding = nil
    v4.VerticalPadding = nil
    v4.SortOrder = nil
    v4.Width = nil
    v4.Height = nil
    v4.ResizeParent = nil
    return createElement("Frame", v4)
end

function Frame.GetSize(v10, v11) -- line 110
    local props = v10.props
    local v12 = if props.Size == "WRAP_CONTENT" then true else props.Width == "WRAP_CONTENT"
    local v13 = if props.Size == "WRAP_CONTENT" then true else props.Height == "WRAP_CONTENT"
    local v14 = UDim2.new(0, props.HorizontalPadding or 0, 0, props.VerticalPadding or 0)
    local new = UDim2.new
    local v15, v16
    if v11 and v12 then
        local v17 = UDim.new(0, v11.X)
        if v17 then
            v15 = v17
            v16 = true
        else
            v16 = false
        end
    else
        v16 = false
    end
    if not v16 then
        local Width = props.Width
        local v18 = typeof(Width) == "UDim"
        local Width_2 = if v18 then props.Width else nil
        if not v18 or not Width_2 then
            v15 = props.Size.X
        else
            v15 = Width_2
        end
    end
    local v19, v20
    if v11 and v13 then
        local v21 = UDim.new(0, v11.Y)
        if v21 then
            v19 = v21
            v20 = true
        else
            v20 = false
        end
    else
        v20 = false
    end
    if not v20 then
        local Height = props.Height
        local v22 = typeof(Height) == "UDim"
        local Height_2 = if v22 then props.Height else nil
        if not v22 or not Height_2 then
            v19 = props.Size.Y
        else
            v19 = Height_2
        end
    end
    return v14 + new(v15, v19)
end

function Frame.UpdateContentSize(v23, v24) -- line 135 | captures: v1
    local ResizeParent, v25
    if v24 and v24.Parent then
        v24.Parent.Size = v23:GetSize(v24.AbsoluteContentSize)
        ResizeParent = v23.props.ResizeParent
        v25 = ResizeParent and v24.Parent.Parent
    else
        return
    end
    if not (ResizeParent and v25) then
        return
    end
    local X = v25.Size.X
    local Y = v25.Size.Y
    if v1.IsInTable(ResizeParent, "WIDTH") then
        X = UDim.new(0, v24.Parent.AbsoluteSize.X)
    end
    if v1.IsInTable(ResizeParent, "HEIGHT") then
        Y = UDim.new(0, v24.Parent.AbsoluteSize.Y)
    end
    v25.Size = UDim2.new(X, Y)
end

return Frame
