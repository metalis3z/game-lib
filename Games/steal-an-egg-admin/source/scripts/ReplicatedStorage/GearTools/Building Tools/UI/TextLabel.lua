-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local TextService = game:GetService("TextService")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
local createElement = v2.createElement
local TextLabel = v2.PureComponent:extend("TextLabel")

TextLabel.defaultProps = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    TextSize = 16,
    Font = "SourceSans",
    TextXAlignment = "Left",
    Size = UDim2.new(1, 0, 1, 0),
    TextColor3 = Color3.new(0, 0, 0)
}

local v3 = Vector2.new((1/0), (1/0))

function TextLabel.getSize(v4) -- line 30 | captures: TextService, v3
    if not v4.props.Width and not v4.props.Height and v4.props.Size ~= "WRAP_CONTENT" then
        return v4.props.Size
    end
    local Width = v4.props.Width
    local Width_2, Height
    if typeof(Width) == "UDim" then
        Width_2 = v4.props.Width
    else
        local Height_2 = v4.props.Height
        if typeof(Height_2) == "UDim" then
            Width_2, Height = nil, v4.props.Height
        end
    end
    local TextSize = v4.props.TextSize
    if v4.props.TextScaled and v4.AbsoluteSize then
        TextSize = v4.AbsoluteSize.Y
    end
    local v5 = TextService:GetTextSize(v4.props.Text, TextSize, v4.props.Font, v3)
    local v6, v7
    if Width_2 then
        v6 = Width_2
        v7 = true
    elseif v4.props.Width == "WRAP_CONTENT" or v4.props.Size == "WRAP_CONTENT" then
        v7 = false
    else
        v6 = Width_2
        v7 = true
    end
    if not v7 then
        v6 = UDim.new(0, v5.X)
    end
    local v8, v9
    if Height then
        v8 = Height
        v9 = true
    elseif v4.props.Height == "WRAP_CONTENT" or v4.props.Size == "WRAP_CONTENT" then
        v9 = false
    else
        v8 = Height
        v9 = true
    end
    if not v9 then
        v8 = UDim.new(0, v5.Y)
    end
    local new = UDim2.new
    local v10, v11
    if v6 then
        v10 = v6
        v11 = true
    elseif v4.props.Size then
        local X = v4.props.Size.X
        if X then
            v10 = X
            v11 = true
        else
            v11 = false
        end
    else
        v11 = false
    end
    if not v11 then
        v10 = UDim.new()
    end
    local v12, v13
    if v8 then
        v12 = v8
        v13 = true
    elseif v4.props.Size then
        local Y = v4.props.Size.Y
        if Y then
            v12 = Y
            v13 = true
        else
            v13 = false
        end
    else
        v13 = false
    end
    if not v13 then
        v12 = UDim.new()
    end
    return new(v10, v12)
end

local function updateSize(v14) -- line 75
    if not v14.Mounted then
        return
    end
    local v15 = v14:getSize()
    local v16, v17
    if v14.props.TextScaled and v14.AbsoluteSize then
        local Y = v14.AbsoluteSize.Y
        if Y then
            v16 = Y
            v17 = true
        else
            v17 = false
        end
    else
        v17 = false
    end
    if not v17 then
        v16 = v14.props.TextSize
    end
    if not (v14.state.Size == v15 and v14.state.TextSize == v16) then
        v14:setState({
            Size = v15,
            TextSize = v16
        })
    end
end

TextLabel.updateSize = updateSize

local function init(v18) -- line 98
    v18.Updating = true
    v18.state = {
        TextSize = 0,
        Size = UDim2.new()
    }
end

TextLabel.init = init

local function willUpdate(v19, v20, v21) -- line 106
    v19.Updating = true
end

TextLabel.willUpdate = willUpdate

function TextLabel.render(v22) -- line 110 | captures: v1, v2, createElement, TextLabel
    local Merge = v1.Merge
    local v23 = {}
    local props = v22.props
    local v24 = {
        Size = v22.state.Size,
        TextSize = v22.state.TextSize,
        TextScaled = false
    }

    v24[v2.Ref] = function(v25) -- line 119 | captures: v22
        local AbsoluteSize = v25 and v25.AbsoluteSize or v22.AbsoluteSize
        v22.AbsoluteSize = AbsoluteSize
    end

    v24[v2.Change.AbsoluteSize] = function(v26) -- line 126 | captures: v22
        v22.AbsoluteSize = v26.AbsoluteSize
        if not v22.Updating then
            v22:updateSize()
        end
    end

    local v27 = Merge(v23, props, v24)
    local TextColor = v27.TextColor
    if type(TextColor) == "string" then
        local v28, v29, v30 = v27.TextColor:lower():match("#?(..)(..)(..)")
        v27.TextColor3 = Color3.fromRGB(tonumber(v28, 16), tonumber(v29, 16), (tonumber(v30, 16)))
    end
    local v31 = v1.Merge({}, v22.props[v2.Children])
    v27.Width = nil
    v27.Height = nil
    v27.Bold = nil
    v27.TextColor = nil
    v27.AspectRatio = nil
    v27[v2.Children] = nil
    if v22.props.AspectRatio then
        v31.AspectRatio = createElement("UIAspectRatioConstraint", { AspectRatio = v22.props.AspectRatio })
    end
    if v22.props.Bold then
        local v32 = v1.CloneTable(v27)
        v32.Size = UDim2.new(1, 0, 1, 0)
        v32.Position = nil
        v32.TextScaled = true
        v32.AnchorPoint = nil
        v31.Bold = createElement(TextLabel, v32)
    end
    return createElement("TextLabel", v27, v31)
end

local function didMount(v33) -- line 177
    v33.Updating = nil
    v33.Mounted = true
    v33:updateSize()
end

TextLabel.didMount = didMount

local function willUnmount(v34) -- line 183
    v34.Mounted = nil
end

TextLabel.willUnmount = willUnmount

local function didUpdate(v35, v36, v37) -- line 187
    v35.Updating = nil
    v35:updateSize()
end

TextLabel.didUpdate = didUpdate
return TextLabel
