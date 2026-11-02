-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local Selection = require(script.Parent.Selection)
local Libraries = Parent:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Libraries:WaitForChild("Signal"))
local v3 = require(Libraries:WaitForChild("Make"))
local v4 = require(Libraries:WaitForChild("InstancePool"))

TargetingModule = {}
TargetingModule.TargetingMode = "Scoped"
TargetingModule.TargetingModeChanged = v2.new()
TargetingModule.Scope = Workspace
TargetingModule.IsScopeLocked = true
TargetingModule.TargetChanged = v2.new()
TargetingModule.ScopeChanged = v2.new()
TargetingModule.ScopeTargetChanged = v2.new()
TargetingModule.ScopeLockChanged = v2.new()

local function EnableTargeting(v5) -- line 24 | captures: Selection, v1
    local v6 = GetCore()
    local Connections = v6.Connections
    Mouse = v6.Mouse
    Connections.Targeting = Mouse.Move:Connect(function() -- line 35 | captures: v5
        v5:UpdateTarget(v5.Scope)
    end)
    Connections.Selecting = Mouse.Button1Up:Connect(v5.SelectTarget)
    Connections.SiblingSelecting = v1.AddUserInputListener("Began", "MouseButton3", true, function() -- line 43 | captures: v5, Selection
        v5.SelectSiblings(Mouse.Target, not Selection.Multiselecting)
    end)
    Connections.RectSelectionStarted = Mouse.Button1Down:Connect(v5.StartRectangleSelecting)
    Connections.RectSelectionFinished = v1.AddUserInputListener("Ended", "MouseButton1", true, v5.FinishRectangleSelecting)
    Connections.HideTargetBoxOnDisable = v6.Disabling:Connect(v5.HighlightTarget)
    Connections.CancelSelectionOnDisable = v6.Disabling:Connect(v5.CancelRectangleSelecting)
    v5:EnableScopeSelection()
    v5:EnableScopeAutoReset()
    v5:BindTargetingModeHotkeys()
end

TargetingModule.EnableTargeting = EnableTargeting

local function SetScope(v7, v8) -- line 68
    if v7.Scope ~= v8 then
        v7.Scope = v8
        v7.ScopeChanged:Fire(v8)
    end
end

TargetingModule.SetScope = SetScope

local function IsVisible(v9) -- line 75
    return v9:IsA("Model") or v9:IsA("BasePart")
end

local function IsTargetable(v10) -- line 79
    return v10:IsA("Model") or v10:IsA("BasePart") or v10:IsA("Tool") or v10:IsA("Accessory") or v10:IsA("Accoutrement")
end

local function FindTargetInScope(v11, v12, v13) -- line 91 | captures: IsTargetable
    if not v12 or not v13 then
        return nil
    end
    if v11.TargetingMode == "Direct" and v12:IsDescendantOf(v13) then
        return v12
    end
    local v14 = { v12 }
    local v15 = v12
    while v15 do
        if v15.Parent == v13 then
            break
        end
        local Parent = v15.Parent
        table.insert(v14, 1, Parent)
        v15 = v15.Parent
    end
    for v16, v17 in ipairs(v14) do
        if IsTargetable(v17) then
            return v17
        end
    end
end

TargetingModule.FindTargetInScope = FindTargetInScope

local function UpdateTarget(v18, v19, v20) -- line 119
    local v21 = v19 or v18.Scope
    local Target = Mouse.Target
    local v22 = v18:FindTargetInScope(Target, v21)
    if v18.LastTarget == Target and not v20 then
        return Target, v22
    end
    v18.LastTarget = Target
    v18.TargetChanged:Fire(Target)
    local v23 = GetCore()
    if v23.IsSelectable({ Target }) then
        if v18.LastScopeTarget ~= v22 or v20 then
            v18.LastScopeTarget = v22
            v18.ScopeTargetChanged:Fire(v22)
            if not v23.Selection.IsSelected(v22) then
                v18.HighlightTarget(v22)
            end
        end
        return Target, v22
    end
    v18.HighlightTarget(nil)
    v18.LastTarget = nil
    v18.LastScopeTarget = nil
    v18.TargetChanged:Fire(nil)
    v18.ScopeTargetChanged:Fire(nil)
end

TargetingModule.UpdateTarget = UpdateTarget

local function GetVisibleChildren(v24, v25) -- line 162 | captures: GetVisibleChildren
    local v26 = v25 or {}
    for v27, v28 in pairs(v24:GetChildren()) do
        if v28:IsA("Model") or v28:IsA("BasePart") then
            v26[#v26 + 1] = v28
        else
            GetVisibleChildren(v28, v26)
        end
    end
    return v26
end

local v29 = v4.new(60, function() -- line 179 | captures: v3
    return v3("SelectionBox")({
        Name = "BTTargetBox",
        LineThickness = 0.025,
        Transparency = 0.5,
        Parent = GetCore().UI,
        Color = BrickColor.new("Institutional white")
    })
end)

local function Cleanup(v30) -- line 190
    v30.Adornee = nil
    v30.Visible = nil
end

v29.Cleanup = Cleanup

local function HighlightTarget(v31) -- line 195 | captures: v1, GetVisibleChildren, v29
    v29:ReleaseAll()
    if not v31 then
        return
    end
    local v32 = v1.FlipTable({ v31 })
    if not (v31:IsA("Model") or v31:IsA("BasePart")) then
        v32 = v1.FlipTable((GetVisibleChildren(v31)))
    end
    for v33 in pairs(v32) do
        local v34 = v29:Get()
        v34.Adornee = v33
        v34.Visible = true
    end
end

TargetingModule.HighlightTarget = HighlightTarget

local function IsAncestorSelected(v35) -- line 220 | captures: Selection
    local v36 = v35
    while true do
        if v36 then
            if v36 == TargetingModule.Scope then
                return
            end
            if Selection.IsSelected(v36) then
                break
            end
            v36 = v36.Parent
            continue
        end
        return
    end
    return true
end

local function SelectTarget(v37) -- line 230 | captures: Selection, IsAncestorSelected
    local Scope = TargetingModule.Scope
    local v38, v39 = TargetingModule:UpdateTarget(Scope, true)
    if v37 or not SelectionCancelled then
        if not Selection.Multiselecting and (Selection.IsSelected(v39) or IsAncestorSelected(v39)) then
            Selection.SetFocus(v39)
        elseif GetCore().IsSelectable({ v38 }) then
            if not (Selection.Multiselecting and Selection.IsSelected(v39)) then
                if Selection.Multiselecting then
                    Selection.Add({ v39 }, true)
                else
                    Selection.Replace({ v39 }, true)
                end
                Selection.SetFocus(v39)
            else
                Selection.Remove({ v39 }, true)
            end
        else
            Selection.Clear(true)
        end
    else
        SelectionCancelled = false
    end
end

TargetingModule.SelectTarget = SelectTarget

local function SelectSiblings(v40, v41) -- line 273 | captures: Selection, v1
    local v42 = v40 or Selection.Focus
    if not (v42 and v42.Parent ~= TargetingModule.Scope) then
        return
    end
    local BasePart = v1.GetDescendantsWhichAreA(v42.Parent, "BasePart")
    if GetCore().IsSelectable(BasePart) then
        if v41 then
            Selection.Replace(BasePart, true)
        else
            Selection.Add(BasePart, true)
        end
    end
end

TargetingModule.SelectSiblings = SelectSiblings

local function StartRectangleSelecting() -- line 301
    if not SelectionCancelled then
        RectangleSelectStart = Vector2.new(Mouse.X, Mouse.Y)
        GetCore().Connections.WatchRectangleSelection = Mouse.Move:Connect(function() -- line 312
            if RectangleSelecting then
                TargetingModule.UpdateSelectionRectangle()
            elseif RectangleSelectStart and (Vector2.new(Mouse.X, Mouse.Y) - RectangleSelectStart).magnitude >= 10 then
                RectangleSelecting = true
                SelectionCancelled = true
            end
        end)
    end
end

TargetingModule.StartRectangleSelecting = StartRectangleSelecting

local function UpdateSelectionRectangle() -- line 328 | captures: v3
    if not RectangleSelecting then
        return
    end
    local v43 = GetCore()
    if not SelectionRectangle then
        SelectionRectangle = v3("Frame")({
            Name = "SelectionRectangle",
            BackgroundTransparency = 0.5,
            BorderSizePixel = 1,
            Parent = v43.UI,
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            BorderColor3 = Color3.new(0, 0, 0)
        })
    end
    local new = Vector2.new
    local X = RectangleSelectStart.X
    local X_2 = Mouse.X
    local v44 = math.min(X, X_2)
    local Y = RectangleSelectStart.Y
    local Y_2 = Mouse.Y
    local v45 = new(v44, (math.min(Y, Y_2)))
    local new_2 = Vector2.new
    local X_3 = RectangleSelectStart.X
    local X_4 = Mouse.X
    local v46 = math.max(X_3, X_4)
    local Y_3 = RectangleSelectStart.Y
    local Y_4 = Mouse.Y
    local v47 = new_2(v46, (math.max(Y_3, Y_4)))
    SelectionRectangle.Parent = v43.UI
    SelectionRectangle.Position = UDim2.new(0, v45.X, 0, v45.Y)
    SelectionRectangle.Size = UDim2.new(0, v47.X - v45.X, 0, v47.Y - v45.Y)
end

TargetingModule.UpdateSelectionRectangle = UpdateSelectionRectangle

local function CancelRectangleSelecting() -- line 366
    RectangleSelectStart = nil
    RectangleSelecting = false
    local Connections = GetCore().Connections
    if Connections.WatchRectangleSelection then
        Connections.WatchRectangleSelection:Disconnect()
        Connections.WatchRectangleSelection = nil
    end
    if SelectionRectangle then
        SelectionRectangle.Parent = nil
    end
end

TargetingModule.CancelRectangleSelecting = CancelRectangleSelecting

local function CancelSelecting() -- line 388
    SelectionCancelled = true
    TargetingModule.CancelRectangleSelecting()
end

TargetingModule.CancelSelecting = CancelSelecting

local function FinishRectangleSelecting() -- line 393 | captures: Workspace, Selection, v1
    local v48 = GetCore()
    local v49 = RectangleSelecting
    local v50 = RectangleSelectStart
    TargetingModule.CancelRectangleSelecting()
    if not (v49 and TargetingModule.Scope) then
        return
    end
    local new = Vector2.new
    local X = v50.X
    local X_2 = Mouse.X
    local v51 = math.min(X, X_2)
    local Y = v50.Y
    local Y_2 = Mouse.Y
    local v52 = new(v51, (math.min(Y, Y_2)))
    local new_2 = Vector2.new
    local X_3 = v50.X
    local X_4 = Mouse.X
    local v53 = math.max(X_3, X_4)
    local Y_3 = v50.Y
    local Y_4 = Mouse.Y
    local v54 = new_2(v53, (math.max(Y_3, Y_4)))
    local v55 = {}
    local BasePart = v1.GetDescendantsWhichAreA(TargetingModule.Scope, "BasePart")
    for v56, v57 in pairs(BasePart) do
        local v58, v59 = Workspace.CurrentCamera:WorldToScreenPoint(v57.Position)
        if v59 then
            local X = v58.X
            local v60 = v52.X <= X
            local v61 = v58.X <= v54.X
            local Y = v58.Y
            local v62 = v52.Y <= Y
            local v63 = v58.Y <= v54.Y
            if v60 and v61 and v62 and v63 and v48.IsSelectable({ v57 }) then
                v55[TargetingModule:FindTargetInScope(v57, TargetingModule.Scope)] = true
            end
        end
    end
    if Selection.Multiselecting then
        Selection.Add(v1.Keys(v55), true)
    else
        Selection.Replace(v1.Keys(v55), true)
    end
end

TargetingModule.FinishRectangleSelecting = FinishRectangleSelecting

local function PrismSelect() -- line 451 | captures: Workspace, Selection, v1
    if #Selection.Items == 0 then
        return
    end
    local v64 = GetCore()
    local v65 = require(v64.Tool.Core.BoundingBox).CalculateExtents(Selection.Items, nil, true)
    local v66 = Region3.new(v65.Min, v65.Max)
    local v67 = Workspace:FindPartsInRegion3WithIgnoreList(v66, Selection.Items, (1/0))
    local v68 = {}
    for v69, v70 in pairs(v67) do
        v68[v70] = {
            Anchored = v70.Anchored,
            CanCollide = v70.CanCollide
        }
        v70.Anchored = true
        v70.CanCollide = true
    end
    local v71 = {}
    for v72, v73 in pairs(Selection.Items) do
        local v74 = v73:GetTouchingParts()
        for v75, v76 in pairs(v74) do
            if not Selection.IsSelected(v76) then
                v71[v76] = true
            end
        end
    end
    for v77, v78 in pairs(v68) do
        v77.CanCollide = v78.CanCollide
        v77.Anchored = v78.Anchored
    end
    v64.DeleteSelection()
    Selection.Replace(v1.Keys(v71), true)
end

TargetingModule.PrismSelect = PrismSelect

local function EnableScopeSelection(v79) -- line 501 | captures: UserInputService, ContextActionService
    local v80 = false
    local Scope

    local function HandleScopeInput(v81, v82, v83) -- line 508 | captures: v80, Scope, v79, UserInputService
        if v82.Name == "Begin" then
            local v84 = UserInputService:IsKeyDown("LeftAlt") or UserInputService:IsKeyDown("RightAlt")
            local v85 = UserInputService:IsKeyDown("LeftShift") or UserInputService:IsKeyDown("RightShift")
            if v80 or not v83.KeyCode.Name:match("Alt") then
                if v80 and v84 and v85 and v83.KeyCode.Name == "Z" then
                    local v86 = v79.Scope.Parent or Scope
                    if GetCore().Security.IsLocationAllowed(v86, GetCore().Player) then
                        v79:SetScope(v86)
                        v79:UpdateTarget(v79.Scope, true)
                        v79.IsScopeLocked = false
                        v79.ScopeLockChanged:Fire(false)
                        v80 = v79.Scope
                    end
                    return Enum.ContextActionResult.Sink
                end
                if v80 and v84 and v83.KeyCode.Name == "Z" then
                    local v87, v88 = v79:UpdateTarget(v79.Scope, true)
                    if v87 ~= v88 then
                        v79:SetScope(v88 or v79.Scope)
                        v79:UpdateTarget(v79.Scope, true)
                        v79.IsScopeLocked = false
                        v79.ScopeLockChanged:Fire(false)
                        v80 = v79.Scope
                    end
                    return Enum.ContextActionResult.Sink
                end
                if v80 and v84 and v83.KeyCode.Name == "F" then
                    v80 = true
                    v79.IsScopeLocked = true
                    v79.ScopeLockChanged:Fire(true)
                    return Enum.ContextActionResult.Sink
                end
            else
                v80 = v79.Scope
                Scope = v79.Scope
                local v89, v90 = v79:UpdateTarget(v79.Scope, true)
                if v89 ~= v90 then
                    local v91 = v90 or v79.Scope
                    v79:SetScope(v91)
                    v79:UpdateTarget(v79.Scope, true)
                    v79.IsScopeLocked = false
                    v79.ScopeLockChanged:Fire(false)
                    v80 = v79.Scope
                end
            end
        elseif v82.Name == "End" and v80 and v83.KeyCode.Name:match("Alt") then
            if v79.Scope == v80 then
                v79:SetScope(Scope)
                v79.IsScopeLocked = true
                v79.ScopeLockChanged:Fire(true)
            end
            v79:UpdateTarget(v79.Scope, true)
            v80 = nil
            Scope = nil
        end
        if v80 and v83.UserInputType.Name == "Focus" then
            if v79.Scope == v80 then
                v79:SetScope(Scope)
                v79.IsScopeLocked = true
                v79.ScopeLockChanged:Fire(true)
            end
            v79:UpdateTarget(v79.Scope, true)
            v80 = nil
            Scope = nil
        end
        return Enum.ContextActionResult.Pass
    end

    local LeftAlt = Enum.KeyCode.LeftAlt
    local RightAlt = Enum.KeyCode.RightAlt
    local Z = Enum.KeyCode.Z
    local F = Enum.KeyCode.F
    local Focus = Enum.UserInputType.Focus
    ContextActionService:BindAction("BT: Scope", HandleScopeInput, false, LeftAlt, RightAlt, Z, F, Focus)
    GetCore().Disabling:Connect(function() -- line 602 | captures: ContextActionService
        ContextActionService:UnbindAction("BT: Scope")
    end)
end

TargetingModule.EnableScopeSelection = EnableScopeSelection

local function EnableScopeAutoReset(v92) -- line 608 | captures: Workspace
    local v93, v94
    GetCore().UIMaid.ScopeReset = v92.ScopeChanged:Connect(function(v95) -- line 614 | captures: v93, v94, v92, Workspace
        v93 = v93 and v93:Disconnect()
        if not v95 then
            return
        end
        v94 = {}
        local Parent = v95.Parent
        while Parent:IsDescendantOf(Workspace) do
            local v96 = v94
            table.insert(v96, Parent)
            Parent = Parent.Parent
        end
        v93 = v95.AncestryChanged:Connect(function(v97, v98) -- line 633 | captures: v95, v94, v92, Workspace
            if v98 == nil then
                local v99
                if v94 then
                    for v100, v101 in ipairs(v94) do
                        if v101:IsDescendantOf(Workspace) then
                            v99 = v101
                            break
                        end
                        v99 = nil
                    end
                end
                if v99 then
                    v92:SetScope(v99)
                else
                    v92:SetScope(Workspace, true)
                end
            else
                v94 = {}
                local Parent = v95.Parent
                while Parent:IsDescendantOf(Workspace) do
                    local v102 = v94
                    table.insert(v102, Parent)
                    Parent = Parent.Parent
                end
            end
        end)
    end)
end

TargetingModule.EnableScopeAutoReset = EnableScopeAutoReset

local function SetTargetingMode(v103, v104) -- line 670
    if v104 == "Scoped" or v104 == "Direct" then
        v103.TargetingMode = v104
        v103.TargetingModeChanged:Fire(v104)
    else
        error("Invalid targeting mode", 2)
    end
end

TargetingModule.SetTargetingMode = SetTargetingMode

local function ToggleTargetingMode(v105) -- line 681
    if v105.TargetingMode == "Scoped" then
        v105:SetTargetingMode("Direct")
    elseif v105.TargetingMode == "Direct" then
        v105:SetTargetingMode("Scoped")
    end
end

TargetingModule.ToggleTargetingMode = ToggleTargetingMode

local function BindTargetingModeHotkeys(v106) -- line 691 | captures: UserInputService, ContextActionService
    local function Callback(v107, v108, v109) -- line 692 | captures: v106, UserInputService
        if v108.Name == "End" then
            return Enum.ContextActionResult.Pass
        end
        local v110 = UserInputService:GetKeysPressed()
        local v111 = v109:IsModifierKeyDown(Enum.ModifierKey.Shift)
        if #v110 ~= 2 or not v111 then
            return Enum.ContextActionResult.Pass
        end
        v106:ToggleTargetingMode()
        v106:UpdateTarget(nil, true)
        return Enum.ContextActionResult.Sink
    end

    local T = Enum.KeyCode.T
    ContextActionService:BindAction("BT: Toggle Targeting Mode", Callback, false, T)
    local v112 = GetCore()
    v112.Connections.UnbindTargetingModeHotkeys = v112.Disabling:Connect(function() -- line 717 | captures: ContextActionService
        ContextActionService:UnbindAction("BT: Toggle Targeting Mode")
    end)
end

TargetingModule.BindTargetingModeHotkeys = BindTargetingModeHotkeys

function GetCore() -- line 722
    return require(script.Parent)
end

return TargetingModule
