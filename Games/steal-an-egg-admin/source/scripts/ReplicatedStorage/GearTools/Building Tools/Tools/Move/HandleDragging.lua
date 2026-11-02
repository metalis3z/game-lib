-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local Core = require(Parent.Core)
local Selection = Core.Selection
local Security = Core.Security
local BoundingBox = require(Parent.Core.BoundingBox)
local Libraries = Parent:WaitForChild("Libraries")
local v1 = require(script.Parent:WaitForChild("Util"))
local v2 = {}

v2.__index = v2

local v3 = {}

v3[Enum.NormalId.Top] = Vector3.new(0, 1, 0)
v3[Enum.NormalId.Bottom] = Vector3.new(0, -1, 0)
v3[Enum.NormalId.Front] = Vector3.new(0, 0, -1)
v3[Enum.NormalId.Back] = Vector3.new(0, 0, 1)
v3[Enum.NormalId.Left] = Vector3.new(-1, 0, 0)
v3[Enum.NormalId.Right] = Vector3.new(1, 0, 0)

function v2.new(v4) -- line 27 | captures: v2
    local v5 = {
        IsHandleDragging = false,
        Handles = nil,
        InitialExtentsSize = nil,
        InitialExtentsCFrame = nil,
        InitialState = nil,
        InitialFocusCFrame = nil,
        Tool = v4
    }
    return (setmetatable(v5, v2))
end

function v2.AttachHandles(v6, v7, v8) -- line 45 | captures: Core, Selection, Security, BoundingBox, Libraries, v1, v3
    if not v8 or v6.Tool.Maid.AutofocusHandle then
        if not v8 and v6.Tool.Maid.AutofocusHandle then
            v6.Tool.Maid.AutofocusHandle = nil
        end
    else
        v6.Tool.Maid.AutofocusHandle = Selection.FocusChanged:Connect(function() -- line 50 | captures: v6, Selection
            v6:AttachHandles(Selection.Focus, true)
        end)
    end
    if v6.Handles then
        v6.Handles:BlacklistObstacle(BoundingBox.GetBoundingBox())
        v6.Handles:SetAdornee(v7)
    else
        local v9

        local function OnHandleDragStart() -- line 67 | captures: v9, v6, Core, Selection, Security, BoundingBox
            Core.Targeting.CancelSelecting()
            v6.IsHandleDragging = true
            if BoundingBox.GetBoundingBox() then
                local v10, v11 = BoundingBox.CalculateExtents(Selection.Parts, BoundingBox.StaticExtents)
                v6.InitialExtentsSize = v10
                v6.InitialExtentsCFrame = v11
                BoundingBox.PauseMonitoring()
            end
            local v12, v13, v14 = v6.Tool:PrepareSelectionForDragging()
            v6.InitialPartStates = v12
            v6.InitialModelStates = v13
            v6.InitialFocusCFrame = v14
            v6.Tool:TrackChange()
            if Core.Mode == "Tool" then
                v9 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
            end
        end

        local function OnHandleDrag(v15, v16) -- line 101 | captures: v9, v6, Core, Selection, Security, BoundingBox, v1, v3
            if not v6.IsHandleDragging then
                return
            end
            local v17 = v1.GetIncrementMultiple(v16, v6.Tool.Increment)
            v6.Tool:MovePartsAlongAxesByFace(v15, v17, v6.InitialPartStates, v6.InitialModelStates, v6.InitialFocusCFrame)
            if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v9) then
                local v18, v19 = next(v6.InitialPartStates)
                v18.CFrame = v19.CFrame
                v1.TranslatePartsRelativeToPart(v18, v6.InitialPartStates, v6.InitialModelStates)
                v17 = 0
            end
            v6.Tool.DragChanged:Fire(v17)
            if v6.Tool.Axes == "Global" and BoundingBox.GetBoundingBox() then
                BoundingBox.GetBoundingBox().CFrame = v6.InitialExtentsCFrame + v3[v15] * v17
            end
        end

        local function OnHandleDragEnd() -- line 133 | captures: v6, Core, BoundingBox
            if not v6.IsHandleDragging then
                return
            end
            v6.IsHandleDragging = false
            for v20, v21 in pairs(v6.InitialPartStates) do
                v20:MakeJoints()
                Core.RestoreJoints(v21.Joints)
                v20.CanCollide = v21.CanCollide
                v20.Anchored = v21.Anchored
            end
            v6.Tool:RegisterChange()
            BoundingBox.RecalculateStaticExtents()
            BoundingBox.ResumeMonitoring()
        end

        v6.Handles = require(Libraries:WaitForChild("Handles")).new({
            Color = v6.Tool.Color.Color,
            Parent = Core.UIContainer,
            Adornee = v7,
            ObstacleBlacklist = { BoundingBox.GetBoundingBox() },
            OnDragStart = OnHandleDragStart,
            OnDrag = OnHandleDrag,
            OnDragEnd = OnHandleDragEnd
        })
    end
end

local function HideHandles(v22) -- line 171
    if v22.Handles then
        v22.Handles = v22.Handles:Destroy()
        v22.Tool.Maid.AutofocusHandle = nil
    end
end

v2.HideHandles = HideHandles
return v2
