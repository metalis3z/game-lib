-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local TextService = game:GetService("TextService")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Maid"))
local createElement = v1.createElement
local v3 = require(script.Parent:WaitForChild("HotkeyTooltip"))
local ScopeHierarchyItemButton = v1.PureComponent:extend("ScopeHierarchyItemButton")

function ScopeHierarchyItemButton.init(v4) -- line 18 | captures: v1, v2
    v4.Maid = v2.new()
    v4.LayoutRef = v1.createRef()
    local v5, v6 = v1.createBinding(UDim2.new(0, 0, 1, 0))
    v4.ContainerSize = v5
    v4.UpdateContainerSize = v6

    function v4.OnClicked() -- line 24 | captures: v4
        v4.props.SetScopeFromButton(v4.props.Instance)
    end

    v4:UpdateInstanceState()
end

local v7 = {
    Part = Vector2.new(2, 1),
    MeshPart = Vector2.new(4, 8),
    UnionOperation = Vector2.new(4, 8),
    NegateOperation = Vector2.new(3, 8),
    VehicleSeat = Vector2.new(6, 4),
    Seat = Vector2.new(6, 4),
    TrussPart = Vector2.new(2, 1),
    CornerWedgePart = Vector2.new(2, 1),
    WedgePart = Vector2.new(2, 1),
    SpawnLocation = Vector2.new(6, 3),
    Model = Vector2.new(3, 1),
    Folder = Vector2.new(8, 8),
    Tool = Vector2.new(8, 2),
    Workspace = Vector2.new(10, 2),
    Accessory = Vector2.new(3, 4),
    Accoutrement = Vector2.new(3, 4)
}

function ScopeHierarchyItemButton.UpdateInstanceState(v8) -- line 52 | captures: TextService
    local Name = v8.props.Instance.Name
    local v9 = Vector2.new((1/0), (1/0))
    v8:setState({
        InstanceName = Name,
        InstanceNameLength = TextService:GetTextSize(Name, 16.5, Enum.Font.SourceSans, v9).X
    })
end

function ScopeHierarchyItemButton.StartTrackingInstance(v10) -- line 65
    local Name = v10.props.Instance:GetPropertyChangedSignal("Name")
    v10.Maid.NameListener = Name:Connect(function() -- line 67 | captures: v10
        v10:UpdateInstanceState()
    end)
end

function ScopeHierarchyItemButton.didMount(v11) -- line 73
    v11:UpdateInstanceState()
    v11:StartTrackingInstance()
    if not v11.LayoutRef.current then
        return
    end
    local current = v11.LayoutRef.current
    local AbsoluteContentSize = current:GetPropertyChangedSignal("AbsoluteContentSize")
    v11.UpdateContainerSize(UDim2.new(0, current.AbsoluteContentSize.X, 0, 19))
    v11.Maid.LayoutListener = AbsoluteContentSize:Connect(function() -- line 82 | captures: v11, current
        v11.UpdateContainerSize(UDim2.new(0, current.AbsoluteContentSize.X, 0, 19))
    end)
end

function ScopeHierarchyItemButton.willUnmount(v12) -- line 89
    v12.Maid:Destroy()
end

function ScopeHierarchyItemButton.didUpdate(v13, v14, v15) -- line 94
    if v14.Instance ~= v13.props.Instance then
        v13:UpdateInstanceState()
        v13:StartTrackingInstance()
    end
end

function ScopeHierarchyItemButton.render(v16) -- line 101 | captures: v1, createElement, v3, v7
    local ClassName = v16.props.Instance.ClassName
    local v17 = v7[ClassName] or Vector2.new(1, 1)
    local v18
    if v16.props.LayoutOrder == 2 then
    else
        v18 = true
    end
    local v19 = {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = v16.ContainerSize,
        LayoutOrder = v16.props.LayoutOrder
    }
    v19[v1.Event.InputBegan] = v16.OnInputBegin
    v19[v1.Event.InputEnded] = v16.OnInputEnd
    v19[v1.Event.Activated] = v16.OnClicked
    local v20 = {}
    local v21 = {}
    v21[v1.Ref] = v16.LayoutRef
    v21.FillDirection = Enum.FillDirection.Horizontal
    v21.HorizontalAlignment = Enum.HorizontalAlignment.Left
    v21.VerticalAlignment = Enum.VerticalAlignment.Center
    v21.SortOrder = Enum.SortOrder.LayoutOrder
    v21.Padding = UDim.new(0, 2.5)
    v20.Layout = createElement("UIListLayout", v21)
    v20.ArrowWrapper = v18 and
    createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = 0,
        Size = UDim2.new(0, 19, 0, 19)
    }, {
        Arrow = createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = "rbxassetid://2244452978",
            ImageTransparency = 0,
            Rotation = 90,
            Size = UDim2.new(1, 0, 1, 0),
            ImageRectOffset = Vector2.new(42, 0) * 2,
            ImageRectSize = Vector2.new(14, 14) * 2
        })
    })
    local v22 = {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Size = UDim2.new(0, v16.state.InstanceNameLength + 14 + 5, 1, 0)
    }
    local v23 = {}
    local v24 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://2245672825",
        LayoutOrder = 0,
        ImageRectOffset = (v17 - Vector2.new(1, 1)) * Vector2.new(16, 16),
        ImageRectSize = Vector2.new(16, 16)
    }
    if v16.props.IsTarget then
        v24.ImageTransparency = 0.5
    else
        v24.ImageTransparency = 0
    end
    v24.AnchorPoint = Vector2.new(0, 0.5)
    v24.Position = UDim2.new(0, 0, 0.5, 0)
    v24.Size = UDim2.new(0, 14, 0, 14)
    v23.InstanceIcon = createElement("ImageLabel", v24)
    local v25 = {
        BackgroundTransparency = 1,
        TextSize = 16.5,
        LayoutOrder = 1,
        Size = UDim2.new(0, v16.state.InstanceNameLength, 0, 14),
        Position = UDim2.new(0, 19, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Font = Enum.Font.SourceSans,
        Text = v16.state.InstanceName
    }
    if v16.props.IsTarget then
        v25.TextTransparency = 0.5
    else
        v25.TextTransparency = 0
    end
    v25.TextYAlignment = Enum.TextYAlignment.Center
    v25.TextColor3 = Color3.fromRGB(255, 255, 255)
    local v26 = {}
    local v27 = {
        BackgroundTransparency = 1,
        TextSize = 16.5,
        TextStrokeTransparency = 0.77,
        ZIndex = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 1),
        Font = Enum.Font.SourceSans,
        Text = v16.state.InstanceName,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextColor3 = Color3.fromRGB(112, 112, 112),
        TextStrokeColor3 = Color3.fromRGB(112, 112, 112)
    }
    if v16.props.IsTarget then
        v27.TextTransparency = 1
    else
        v27.TextTransparency = 0.77
    end
    v26.TextShadow = createElement("TextLabel", v27)
    v23.InstanceName = createElement("TextLabel", v25, v26)
    v20.InstanceInfo = createElement("Frame", v22, v23)
    v20.Tooltip = createElement(v3, {
        IsScopeParent = v16.props.IsScopeParent,
        IsScope = v16.props.IsScope,
        IsScopable = v16.props.IsScopable,
        IsScopeLocked = v16.props.IsScopeLocked,
        IsAltDown = v16.props.IsAltDown
    })
    return createElement("ImageButton", v19, v20)
end

return ScopeHierarchyItemButton
