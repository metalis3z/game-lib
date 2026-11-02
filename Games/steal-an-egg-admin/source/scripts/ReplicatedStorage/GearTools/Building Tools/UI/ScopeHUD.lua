-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local Workspace = game:GetService("Workspace")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Maid"))
local v3 = require(Libraries:WaitForChild("SupportLibrary"))
local createElement = v1.createElement
local v4 = require(script:WaitForChild("ScopeHierarchyItemButton"))
local v5 = require(script:WaitForChild("HotkeyTooltip"))
local v6 = require(script:WaitForChild("ModeToggle"))
local ScopeHUD = v1.PureComponent:extend("ScopeHUD")

function ScopeHUD.init(v7, v8) -- line 23 | captures: v1, v2
    v7.Maid = v2.new()
    v7.LayoutRef = v1.createRef()
    local v9, v10 = v1.createBinding(UDim2.new(0, 0, 0, 19))
    v7.ContainerSize = v9
    v7.UpdateContainerSize = v10

    function v7.OnInputBegin(v11, v12, v13) -- line 29 | captures: v7
        if not v13 and (v12.UserInputType.Name == "MouseMovement" or v12.UserInputType.Name == "Touch") then
            v7:setState({ IsHovering = true })
        end
    end

    function v7.OnInputEnd(v14, v15, v16) -- line 44 | captures: v7
        if v15.UserInputType.Name == "MouseMovement" or v15.UserInputType.Name == "Touch" then
            v7:setState({ IsHovering = false })
        end
    end

    function v7.SetScopeFromButton(v17) -- line 54 | captures: v7
        v7.props.Core.Targeting:SetScope(v17)
    end

    v7:UpdateTargetingState()
    v7:setState({
        IsHovering = false,
        IsToolModeEnabled = v7.props.Core.Mode == "Tool"
    })
end

function ScopeHUD.UpdateTargetingState(v18) -- line 67 | captures: v1
    local Targeting = v18.props.Core.Targeting
    local Scope = Targeting.Scope
    local v19, v20 = Targeting:UpdateTarget()
    local v21 = {}
    v21.Scope = Scope or v1.None
    v21.ScopeTarget = v20 or v1.None
    v21.DirectTarget = v19 or v1.None
    v21.IsScopeLocked = Targeting.IsScopeLocked
    return v18:setState(v21)
end

function ScopeHUD.didMount(v22) -- line 80 | captures: ContextActionService, v1
    v22:UpdateTargetingState()
    local Targeting = v22.props.Core.Targeting
    v22.Maid.ScopeChangeListener = Targeting.ScopeChanged:Connect(function(v23) -- line 85 | captures: v22, Targeting, v1
        Targeting:UpdateTarget()
        local v24 = {}
        v24.Scope = v23 or v1.None
        v22:setState(v24)
    end)
    v22.Maid.ScopeTargetChangeListener = Targeting.ScopeTargetChanged:Connect(function(v25) -- line 91 | captures: v22, v1
        local v26 = {}
        v26.ScopeTarget = v25 or v1.None
        v22:setState(v26)
    end)
    v22.Maid.TargetChangeListener = Targeting.TargetChanged:Connect(function(v27) -- line 96 | captures: v22, v1
        local v28 = {}
        v28.DirectTarget = v27 or v1.None
        v22:setState(v28)
    end)
    v22.Maid.ScopeLockChangeListener = Targeting.ScopeLockChanged:Connect(function(v29) -- line 101 | captures: v22
        v22:setState({ IsScopeLocked = v29 })
    end)

    local function AltKeyCallback(v30, v31, v32) -- line 108 | captures: v22
        if v31.Name == "Begin" then
            v22:setState({ IsAltDown = true })
        elseif v31.Name == "End" then
            v22:setState({ IsAltDown = false })
        end
        return Enum.ContextActionResult.Pass
    end

    local LeftAlt = Enum.KeyCode.LeftAlt
    local RightAlt = Enum.KeyCode.RightAlt
    ContextActionService:BindAction("BT/ScopeHUD: Scope", AltKeyCallback, false, LeftAlt, RightAlt)
    if not v22.LayoutRef.current then
        return
    end
    local current = v22.LayoutRef.current
    local AbsoluteContentSize = current:GetPropertyChangedSignal("AbsoluteContentSize")
    v22.UpdateContainerSize(UDim2.new(0, current.AbsoluteContentSize.X, 0, 19))
    v22.Maid.LayoutListener = AbsoluteContentSize:Connect(function() -- line 130 | captures: v22, current
        v22.UpdateContainerSize(UDim2.new(0, current.AbsoluteContentSize.X, 0, 19))
    end)
end

function ScopeHUD.willUnmount(v33) -- line 137
    v33.Maid:Destroy()
end

function ScopeHUD.render(v34) -- line 141 | captures: v1, v3, createElement, v6
    local v35 = {
        Active = true,
        Draggable = true
    }
    v35.Position = v34.state.IsToolModeEnabled and UDim2.new(0, 5, 1, -4) or UDim2.new(0, 5, 0, 4)
    v35.AnchorPoint = v34.state.IsToolModeEnabled and Vector2.new(0, 1) or Vector2.new(0, 0)
    v35.Size = v34.ContainerSize
    v35.BackgroundTransparency = 1
    v35[v1.Event.InputBegan] = v34.OnInputBegin
    v35[v1.Event.InputEnded] = v34.OnInputEnd
    local Merge = v3.Merge
    local v36 = v34:BuildScopeHierarchyButtons()
    local v37 = {}
    local v38 = {}
    v38[v1.Ref] = v34.LayoutRef
    v38.FillDirection = Enum.FillDirection.Horizontal
    v38.HorizontalAlignment = Enum.HorizontalAlignment.Left
    v38.VerticalAlignment = Enum.VerticalAlignment.Center
    v38.SortOrder = Enum.SortOrder.LayoutOrder
    v38.Padding = UDim.new(0, 2.5)
    v37.Layout = createElement("UIListLayout", v38)
    v37.ModeToggle = createElement(v6, {
        Core = v34.props.Core,
        IsToolModeEnabled = v34.state.IsToolModeEnabled
    })
    return createElement("Frame", v35, Merge(v36, v37))
end

local function IsItemScopable(v39) -- line 174
    return v39:IsA("Model") or v39:IsA("Folder") or v39:IsA("Tool") or v39:IsA("Accessory") or v39:IsA("Accoutrement") or v39:IsA("BasePart") and v39:FindFirstChildWhichIsA("BasePart", true)
end

function ScopeHUD.BuildScopeHierarchyButtons(v40) -- line 185 | captures: Workspace, UserInputService, createElement, v4, v5, IsItemScopable
    local v41 = {}
    local v42 = {}
    local v43 = v40.state.ScopeTarget or v40.state.Scope
    while v43 ~= nil do
        if v43 == Workspace.Parent then
            break
        end
        table.insert(v41, 1, v43)
        v43 = v43.Parent
    end
    for v44, v45 in ipairs(v41) do
        local v46 = {
            Instance = v45,
            IsTarget = v40.state.ScopeTarget == v45
        }
        v46.IsScopeParent = v40.state.Scope and v40.state.Scope.Parent == v45
        v46.IsScope = v40.state.Scope == v45
        if v40.state.ScopeTarget == v45 then
            v46.IsScopable = IsItemScopable(v45)
        else
            v46.IsScopable = false
        end
        v46.IsScopeLocked = v40.state.IsScopeLocked
        v46.SetScopeFromButton = v40.SetScopeFromButton
        v46.IsAltDown = v40.state.IsAltDown
        v46.LayoutOrder = v44 + 1
        v42[v44] = createElement(v4, v46)
    end
    if not v40.state.IsAltDown then
        v42[#v41 + 1] = createElement(v5, {
            IsAltDown = false,
            DisplayAltHotkey = UserInputService.KeyboardEnabled,
            LayoutOrder = #v41 + 2
        })
    end
    return v42
end

return ScopeHUD
