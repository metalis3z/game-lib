-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Vendor = Tool:WaitForChild("Vendor")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Maid"))
local createElement = v1.createElement
local v3 = require(script.Parent:WaitForChild("SelectionButton"))
local v4 = v1.PureComponent:extend(script.Name)

function v4.init(v5) -- line 16 | captures: v1, v2
    v5.Maid = v2.new()
    local v6, v7 = v1.createBinding(UDim2.new())
    v5.PaneSize = v6
    v5.SetPaneSize = v7
    v5:UpdateHistoryState()
    v5.Maid.TrackHistory = v5.props.Core.History.Changed:Connect(function() -- line 21 | captures: v5
        v5:UpdateHistoryState()
    end)
    v5:UpdateSelectionState()
    v5.Maid.TrackSelection = v5.props.Core.Selection.Changed:Connect(function() -- line 26 | captures: v5
        v5:UpdateSelectionState()
    end)
    v5:UpdateExplorerState()
    v5.Maid.TrackExplorer = v5.props.Core.ExplorerVisibilityChanged:Connect(function() -- line 31 | captures: v5
        v5:UpdateExplorerState()
    end)
end

function v4.UpdateHistoryState(v8) -- line 36
    v8:setState({
        CanUndo = v8.props.Core.History.Index > 0,
        CanRedo = v8.props.Core.History.Index ~= #v8.props.Core.History.Stack
    })
end

function v4.UpdateSelectionState(v9) -- line 43
    v9:setState({ IsSelectionEmpty = #v9.props.Core.Selection.Items == 0 })
end

function v4.UpdateExplorerState(v10) -- line 49
    v10:setState({ IsExplorerOpen = v10.props.Core.ExplorerVisible })
end

function v4.willUnmount(v11) -- line 55
    v11.Maid:Destroy()
end

function v4.render(v12) -- line 59 | captures: v1, createElement, v3
    local v13 = {
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Size = v12.PaneSize,
        LayoutOrder = v12.props.LayoutOrder
    }
    local v14 = {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
        SizeConstraint = createElement("UISizeConstraint", { MinSize = Vector2.new(70, 0) })
    }
    local v15 = {
        CellPadding = UDim2.new(0, 0, 0, 0),
        CellSize = UDim2.new(0, 35, 0, 35),
        FillDirection = Enum.FillDirection.Horizontal,
        FillDirectionMaxCells = 0,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        StartCorner = Enum.StartCorner.TopLeft
    }

    v15[v1.Ref] = function(v16) -- line 82 | captures: v12
        if v16 then
            v12.SetPaneSize(UDim2.fromOffset(v16.AbsoluteContentSize.X, v16.AbsoluteContentSize.Y))
        end
    end

    v15[v1.Change.AbsoluteContentSize] = function(v17) -- line 87 | captures: v12
        v12.SetPaneSize(UDim2.fromOffset(v17.AbsoluteContentSize.X, v17.AbsoluteContentSize.Y))
    end

    v14.Layout = createElement("UIGridLayout", v15)
    v14.UndoButton = createElement(v3, {
        LayoutOrder = 0,
        IconAssetId = "rbxassetid://141741408",
        TooltipText = "<b>UNDO</b><br />Shift-Z",
        IsActive = v12.state.CanUndo,
        OnActivated = v12.props.Core.History.Undo
    })
    v14.RedoButton = createElement(v3, {
        LayoutOrder = 1,
        IconAssetId = "rbxassetid://141741327",
        TooltipText = "<b>REDO</b><br />Shift-Y",
        IsActive = v12.state.CanRedo,
        OnActivated = v12.props.Core.History.Redo
    })
    v14.DeleteButton = createElement(v3, {
        LayoutOrder = 2,
        IconAssetId = "rbxassetid://141896298",
        TooltipText = "<b>DELETE</b><br />Shift-X",
        IsActive = not v12.state.IsSelectionEmpty,
        OnActivated = v12.props.Core.DeleteSelection
    })
    v14.ExportButton = createElement(v3, {
        LayoutOrder = 3,
        IconAssetId = "rbxassetid://141741337",
        TooltipText = "<b>EXPORT</b><br />Shift-P",
        IsActive = not v12.state.IsSelectionEmpty,
        OnActivated = v12.props.Core.ExportSelection
    })
    v14.CloneButton = createElement(v3, {
        LayoutOrder = 4,
        IconAssetId = "rbxassetid://142073926",
        TooltipText = "<b>CLONE</b><br />Shift-C",
        IsActive = not v12.state.IsSelectionEmpty,
        OnActivated = v12.props.Core.CloneSelection
    })
    v14.ExplorerButton = createElement(v3, {
        LayoutOrder = 5,
        IconAssetId = "rbxassetid://2326621485",
        TooltipText = "<b>EXPLORER</b><br />Shift-H",
        IsActive = v12.state.IsExplorerOpen,
        OnActivated = v12.props.Core.ToggleExplorer
    })
    return createElement("Frame", v13, v14)
end

return v4
