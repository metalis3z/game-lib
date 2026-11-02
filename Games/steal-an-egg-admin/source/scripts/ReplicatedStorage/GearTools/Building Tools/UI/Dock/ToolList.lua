-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Vendor = Tool:WaitForChild("Vendor")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Maid"))
local createElement = v1.createElement
local v3 = require(script.Parent:WaitForChild("ToolButton"))
local v4 = v1.PureComponent:extend(script.Name)

function v4.init(v5) -- line 16 | captures: v1, v2
    v5.Maid = v2.new()
    local v6, v7 = v1.createBinding(UDim2.new())
    v5.CanvasSize = v6
    v5.SetCanvasSize = v7
    v5:setState({ CurrentTool = v5.props.Core.CurrentTool })
    v5.Maid.CurrentTool = v5.props.Core.ToolChanged:Connect(function(v8) -- line 24 | captures: v5
        v5:setState({ CurrentTool = v8 })
    end)
end

function v4.render(v9) -- line 31 | captures: v1, createElement, v3
    local v10 = {}
    local v11 = {
        CellPadding = UDim2.new(0, 0, 0, 0),
        CellSize = UDim2.new(0, 35, 0, 35),
        FillDirection = Enum.FillDirection.Horizontal,
        FillDirectionMaxCells = 2,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        StartCorner = Enum.StartCorner.TopLeft
    }

    v11[v1.Ref] = function(v12) -- line 42 | captures: v9
        if v12 then
            v9.SetCanvasSize(UDim2.fromOffset(v12.AbsoluteContentSize.X, v12.AbsoluteContentSize.Y))
        end
    end

    v11[v1.Change.AbsoluteContentSize] = function(v13) -- line 47 | captures: v9
        v9.SetCanvasSize(UDim2.fromOffset(v13.AbsoluteContentSize.X, v13.AbsoluteContentSize.Y))
    end

    v10.Layout = createElement("UIGridLayout", v11)
    for v14, v15 in ipairs(v9.props.Tools) do
        v10[tostring(v14)] = createElement(v3, {
            CurrentTool = v9.state.CurrentTool,
            IconAssetId = v15.IconAssetId,
            HotkeyLabel = v15.HotkeyLabel,
            Tool = v15.Tool,
            Core = v9.props.Core
        })
    end
    local v16 = {
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        LayoutOrder = v9.props.LayoutOrder
    }
    v16.Size = v9.CanvasSize:map(function(v17) -- line 69
        return UDim2.fromOffset(v17.X.Offset, 245)
    end)
    local v18 = {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
        SizeConstraint = createElement("UISizeConstraint", { MinSize = Vector2.new(70, 0) })
    }
    local v19 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = v9.CanvasSize,
        ScrollBarThickness = 1,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    }
    v19[v1.Children] = v10
    v18.List = createElement("ScrollingFrame", v19)
    return createElement("Frame", v16, v18)
end

return v4
