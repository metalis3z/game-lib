-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
local createElement = v2.createElement
local ImageButton = v2.PureComponent:extend("ImageButton")

ImageButton.defaultProps = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = "",
    Size = UDim2.new(1, 0, 1, 0)
}

function ImageButton.render(v3) -- line 23 | captures: v1, v2, createElement
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

        v6[v2.Ref] = function(v7) -- line 73 | captures: v3
            v3:UpdateContentSize(v7)
        end

        v6[v2.Change.AbsoluteContentSize] = function(v8) -- line 76 | captures: v3
            v3:UpdateContentSize(v8)
        end

        local v9 = createElement("UIListLayout", v6)
        v4.Size = v3:GetSize()
        v4[v2.Children] = v1.Merge({ Layout = v9 }, v4[v2.Children])
    end
    local ImageColor = v4.ImageColor
    if type(ImageColor) == "string" then
        local v10, v11, v12 = v4.ImageColor:lower():match("#?(..)(..)(..)")
        v4.ImageColor3 = Color3.fromRGB(tonumber(v10, 16), tonumber(v11, 16), (tonumber(v12, 16)))
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
    v4.ImageColor = nil
    return createElement("ImageButton", v4)
end

function ImageButton.GetSize(v13, v14) -- line 117
    local props = v13.props
    local v15 = if props.Size == "WRAP_CONTENT" then true else props.Width == "WRAP_CONTENT"
    local v16 = if props.Size == "WRAP_CONTENT" then true else props.Height == "WRAP_CONTENT"
    local v17 = UDim2.new(0, props.HorizontalPadding or 0, 0, props.VerticalPadding or 0)
    local new = UDim2.new
    local v18, v19
    if v14 and v15 then
        local v20 = UDim.new(0, v14.X)
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
        local Width = props.Width
        local v21 = typeof(Width) == "UDim"
        local Width_2 = if v21 then props.Width else nil
        if not v21 or not Width_2 then
            v18 = props.Size.X
        else
            v18 = Width_2
        end
    end
    local v22, v23
    if v14 and v16 then
        local v24 = UDim.new(0, v14.Y)
        if v24 then
            v22 = v24
            v23 = true
        else
            v23 = false
        end
    else
        v23 = false
    end
    if not v23 then
        local Height = props.Height
        local v25 = typeof(Height) == "UDim"
        local Height_2 = if v25 then props.Height else nil
        if not v25 or not Height_2 then
            v22 = props.Size.Y
        else
            v22 = Height_2
        end
    end
    return v17 + new(v18, v22)
end

function ImageButton.UpdateContentSize(v26, v27) -- line 142
    if v27 and v27.Parent then
        v27.Parent.Size = v26:GetSize(v27.AbsoluteContentSize)
    end
end

return ImageButton
