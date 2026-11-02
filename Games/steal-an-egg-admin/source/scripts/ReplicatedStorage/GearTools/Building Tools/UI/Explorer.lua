-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local UI = Parent:WaitForChild("UI")
game:GetService("RunService")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
local v3 = require(Libraries:WaitForChild("Maid"))
require(Libraries:WaitForChild("Signal"))
local createElement = v2.createElement
require(UI:WaitForChild("Frame"))
local v4 = require(UI:WaitForChild("ImageLabel"))
local v5 = require(UI:WaitForChild("ImageButton"))
local v6 = require(UI:WaitForChild("TextLabel"))
local v7 = require(script:WaitForChild("ItemList"))
local Explorer = v2.PureComponent:extend("Explorer")

function Explorer.init(v8, v9) -- line 24
    v8:setState({
        RowHeight = 18,
        Items = {}
    })
    v8.UpdateQueues = {}
    v8.QueueTimers = {}
    v8.LastId = 0
    v8.IdMap = {}
    v8.PendingParent = {}

    function v8.ToggleExpand(v10) -- line 40 | captures: v8
        return v8:setState(function(v11) -- line 41 | captures: v10
            local v12 = v11.Items[v10]
            v12.Expanded = not v12.Expanded
            return { Items = v11.Items }
        end)
    end
end

function Explorer.didUpdate(v13, v14, v15) -- line 49
    if v14.Scope ~= v13.props.Scope then
        v13:UpdateScope(v13.props.Scope)
    end
end

function Explorer.UpdateScope(v16, v17) -- line 58 | captures: v1, v2, v3
    local Core = v16.props.Core
    local Selection = Core.Selection
    if v16.ScopeMaid then
        v16.ScopeMaid:Destroy()
    end
    v16.ScopeMaid = v3.new()
    if not v17 then
        return
    end
    coroutine.resume(coroutine.create(function() -- line 76 | captures: v16, Selection, v2
        v16:UpdateTree()
        if #Selection.Items > 0 then
            local Focus = Selection.IsSelected(Selection.Focus) and Selection.Focus or Selection.Items[1]
            v16:setState({ ScrollTo = v16.IdMap[Focus] })
        else
            v16:setState({ ScrollTo = v2.None })
        end
    end))
    local Scope = Core.Targeting.Scope
    v16.ScopeMaid.Add = Scope.DescendantAdded:Connect(function(v18) -- line 94 | captures: v16
        v16:UpdateTree()
    end)
    v16.ScopeMaid.Remove = Scope.DescendantRemoving:Connect(function(v19) -- line 97 | captures: v16
        v16:UpdateTree()
    end)
    v16.ScopeMaid.Select = Selection.ItemsAdded:Connect(function(v20) -- line 102 | captures: v16, v1
        v16:UpdateSelection(v20)
        local v21 = if #v20 == 1 then v16.IdMap[v20[1]] else false
        v16:setState(function(v22) -- line 109 | captures: v21, v16, v1
            local v23 = {}
            local v24 = v22.Items[v21]
            local v25 = v24 and v16.IdMap[v24.Parent]
            local v26 = v25 and v22.Items[v25]
            while v26 do
                v26.Expanded = true
                v23[v25] = v26
                v25 = v16.IdMap[v26.Parent]
                v26 = v22.Items[v25]
            end
            return {
                Items = v1.Merge(v22.Items, v23),
                ScrollTo = v21
            }
        end)
    end)
    v16.ScopeMaid.Deselect = Selection.ItemsRemoved:Connect(function(v27) -- line 128 | captures: v16
        v16:UpdateSelection(v27)
    end)
end

function Explorer.didMount(v28) -- line 134 | captures: v3
    v28.Mounted = true
    v28.ItemMaid = v3.new()
    v28:UpdateScope(v28.props.Scope)
end

function Explorer.willUnmount(v29) -- line 144
    v29.Mounted = false
    v29.ScopeMaid:Destroy()
    v29.ItemMaid:Destroy()
end

local function IsTargetable(v30) -- line 152
    return v30:IsA("Model") or v30:IsA("BasePart") or v30:IsA("Tool") or v30:IsA("Accessory") or v30:IsA("Accoutrement")
end

function Explorer.IsItemIndexable(v31) -- line 160 | captures: IsTargetable
    if not IsTargetable(v31) or v31.ClassName == "Terrain" then
        return (v31:IsA("Folder"))
    end
    return true
end

function Explorer.UpdateTree(v32) -- line 165 | captures: v1
    if not v32:ShouldExecuteQueue("Tree") then
        return
    end
    local v33 = 1
    local IdMap = v32.IdMap
    v32:setState(function(v34) -- line 177 | captures: v33, v32, IdMap, v1
        local v35 = {}
        local v36 = v32.props.Scope:GetDescendants()
        local v37 = v1.FlipTable(v36)
        for v38, v39 in ipairs(v36) do
            local v40 = IdMap[v39]
            local v41 = v40 and v34.Items[v40]
            if v41 then
                if v41.Order ~= v33 then
                    v41 = v1.CloneTable(v41)
                    v41.Order = v33
                    v35[v40] = v41
                end
                v33 += 1
                local v42 = v32.IdMap[v41.Parent]
                if not v34.Items[v42] then
                    v32:UpdateItemParent(v39, v35, v34)
                end
            elseif v32:BuildItemState(v39, v32.props.Scope, v33, v35, v34) then
                v33 += 1
            end
        end
        for v43, v44 in pairs(v34.Items) do
            local Instance = v44.Instance
            if not v37[Instance] then
                v35[v43] = v1.Blank
                IdMap[Instance] = nil
                v32.ItemMaid[v43] = nil
                local v45 = v44.Parent and v32.IdMap[v44.Parent]
                local v46 = v32:GetStagedItemState(v45, v35, v34)
                if v46 then
                    v46.Children[v43] = nil
                    v46.Unlocked[v43] = nil
                    v46.IsLocked = next(v46.Children) and not next(v46.Unlocked)
                    v35[v45] = v46
                    v32:PropagateLock(v46, v35, v34)
                end
            end
        end
        return { Items = v1.MergeWithBlanks(v34.Items, v35) }
    end)
end

function Explorer.UpdateSelection(v47, v48) -- line 242 | captures: v1
    local Selection = v47.props.Core.Selection
    v47:QueueUpdate("Selection", v48)
    if v47:ShouldExecuteQueue("Selection") then
        v47:setState(function(v49) -- line 254 | captures: v47, Selection, v1
            local v50 = {}
            local Selection_2 = v47:GetUpdateQueue("Selection")
            for v51 in pairs(Selection_2) do
                for v52, v53 in ipairs(v51) do
                    local v54 = v47.IdMap[v53]
                    if v54 then
                        local v55 = v1.CloneTable(v49.Items[v54])
                        v55.Selected = Selection.IsSelected(v53)
                        v50[v54] = v55
                    end
                end
            end
            return { Items = v1.Merge(v49.Items, v50) }
        end)
    end
end

function Explorer.BuildItemState(v56, v57, v58, v59, v60, v61) -- line 272 | captures: v1, v3
    local Parent = v57.Parent
    local v62 = v56.IdMap[Parent]
    local v63 = v62 or Parent == v58
    local v64, BasePart, v65, v66
    if v56.IsItemIndexable(v57) and v63 then
        v64 = v56.LastId + 1
        v56.LastId = v64
        v56.IdMap[v57] = v64
        BasePart = v57:IsA("BasePart")
        v65 = v3.new()
        v56.ItemMaid[v64] = v65
        v66 = {
            Expanded = nil,
            Id = v64,
            Name = v57.Name,
            IsPart = BasePart
        }
        v66.IsLocked = BasePart and v57.Locked or nil
    else
        return nil
    end
    v66.Class = v57.ClassName
    v66.Parent = Parent
    v66.Children = {}
    v66.Unlocked = {}
    v66.Order = v59
    v66.Instance = v57
    v66.Selected = v56.props.Core.Selection.IsSelected(v57) or nil
    v60[v64] = v66
    local v67 = v56:GetStagedItemState(v62, v60, v61)
    if v67 then
        v67.Children[v64] = true
        v60[v62] = v67
    end
    for v68 in pairs(v56.PendingParent[v57] or {}) do
        local v69 = v56:GetStagedItemState(v68, v60, v61)
        if v69 then
            v66.Children[v68] = true
            v56:PropagateLock(v69, v60, v61)
        end
    end
    v56:PropagateLock(v66, v60, v61)
    v65.Name = v57:GetPropertyChangedSignal("Name"):Connect(function() -- line 333 | captures: v56, v57, v1
        v56:QueueUpdate("Name", v57)
        if v56:ShouldExecuteQueue("Name") then
            v56:setState(function(v70) -- line 344 | captures: v56, v1
                local v71 = {}
                local Name = v56:GetUpdateQueue("Name")
                for v72 in pairs(Name) do
                    local v73 = v56.IdMap[v72]
                    local v74 = v1.CloneTable(v70.Items[v73])
                    v74.Name = v72.Name
                    v71[v73] = v74
                end
                return { Items = v1.Merge(v70.Items, v71) }
            end)
        end
    end)
    v65.Parent = v57:GetPropertyChangedSignal("Parent"):Connect(function() -- line 359 | captures: v56, v57, v1
        if v57.Parent then
            v56:QueueUpdate("Parent", v57)
            if v56:ShouldExecuteQueue("Parent") then
                v56:setState(function(v75) -- line 373 | captures: v56, v1
                    local v76 = {}
                    local Parent = v56:GetUpdateQueue("Parent")
                    for v77 in pairs(Parent) do
                        v56:UpdateItemParent(v77, v76, v75)
                    end
                    return { Items = v1.MergeWithBlanks(v75.Items, v76) }
                end)
                v56:UpdateTree()
            end
        end
    end)
    if BasePart then
        v65.Locked = v57:GetPropertyChangedSignal("Locked"):Connect(function() -- line 388 | captures: v56, v57, v1
            v56:QueueUpdate("Lock", v57)
            if v56:ShouldExecuteQueue("Lock") then
                v56:setState(function(v78) -- line 399 | captures: v56, v1
                    local v79 = {}
                    local Lock = v56:GetUpdateQueue("Lock")
                    for v80 in pairs(Lock) do
                        v56:UpdateItemLock(v80, v79, v78)
                    end
                    return { Items = v1.MergeWithBlanks(v78.Items, v79) }
                end)
            end
        end)
    end
    return true
end

function Explorer.QueueUpdate(v81, v82, v83) -- line 416 | captures: v1
    v81.UpdateQueues[v82] = v1.Merge(v81.UpdateQueues[v82] or {}, { [v83] = true })
end

function Explorer.GetUpdateQueue(v84, v85) -- line 422
    local v86 = v84.UpdateQueues[v85]
    v84.UpdateQueues[v85] = nil
    return v86
end

function Explorer.ShouldExecuteQueue(v87, v88) -- line 433 | captures: v1
    local v89 = v87.QueueTimers[v88] or v1.CreateConsecutiveCallDeferrer(0.025)
    v87.QueueTimers[v88] = v89
    if v89() and v87.Mounted then
        return true
    end
end

function Explorer.UpdateItemLock(v90, v91, v92, v93) -- line 443
    local v94 = v90.IdMap[v91]
    local v95 = v90:GetStagedItemState(v94, v92, v93)
    if not v95 then
        return
    end
    v95.IsLocked = v91.Locked
    v92[v94] = v95
    v90:PropagateLock(v95, v92, v93)
end

function Explorer.GetStagedItemState(v96, v97, v98, v99) -- line 461 | captures: v1
    local v100 = v97 and v98[v97]
    if not v97 or v100 == v1.Blank or not v100 and not v99.Items[v97] then
        return
    end
    return v100 or v1.CloneTable(v99.Items[v97])
end

function Explorer.UpdateItemParent(v101, v102, v103, v104) -- line 477 | captures: v1
    local v105 = v101.IdMap[v102]
    local v106 = v101:GetStagedItemState(v105, v103, v104)
    if not v106 then
        return
    end
    local v107 = v106.Parent and v101.IdMap[v106.Parent]
    local Parent = v102.Parent
    local v108 = v101.IdMap[Parent]
    v106.Parent = Parent
    v103[v105] = v106
    local PendingParent, Merge, v109, v110
    if v108 or Parent == Scope then
        v110 = true
    elseif Parent:IsDescendantOf(Scope) then
        PendingParent = v101.PendingParent
        Merge = v1.Merge
        v109 = v101.PendingParent[Parent] or {}
        v110 = false
    else
        v110 = true
    end
    if not v110 then
        PendingParent[Parent] = Merge(v109, { [v105] = true })
    end
    local v111 = v101:GetStagedItemState(v107, v103, v104)
    if v111 then
        v111.Children[v105] = nil
        v111.Unlocked[v105] = nil
        v111.IsLocked = next(v111.Children) and not next(v111.Unlocked)
        v103[v107] = v111
    end
    local v112 = v101:GetStagedItemState(v108, v103, v104)
    if not v112 then
        return
    end
    v112.Children[v105] = true
    v103[v108] = v112
    v101:PropagateLock(v106, v103, v104)
end

function Explorer.PropagateLock(v113, v114, v115, v116) -- line 521
    if v114.Parent then
        local v117 = v114.Id
        local v118 = v114
        while true do
            local Parent = v118.Parent
            local v119 = Parent and v113.IdMap[Parent]
            local v120 = v113:GetStagedItemState(v119, v115, v116)
            if v120 then
                local Unlocked = v120.Unlocked
                if v118.IsLocked then
                    Unlocked[v117] = nil
                else
                    Unlocked[v117] = true
                end
                v120.IsLocked = next(v120.Children) and not next(v120.Unlocked)
                v115[v119] = v120
                v117 = v119
                v118 = v120
            else
                v117 = nil
                v118 = nil
            end
            if v118 then
                continue
            end
            break
        end
    end
end

function Explorer.render(v121) -- line 560 | captures: v2, createElement, v4, v5, v6, v7
    local props = v121.props
    local state = v121.state
    local v122 = {
        Active = true,
        Layout = "List",
        LayoutDirection = "Vertical",
        Height = "WRAP_CONTENT",
        Image = "rbxassetid://2244248341",
        ScaleType = "Slice",
        ImageTransparency = 0.06999999999999995,
        ImageColor = "3B3B3B",
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -100, 0.6, -190),
        Width = UDim.new(0, 145),
        SliceCenter = Rect.new(4, 4, 12, 12)
    }
    local v123 = {}
    local v124 = {
        Text = "  EXPLORER",
        TextSize = 9,
        TextColor = "FFFFFF",
        TextTransparency = 0.7,
        Height = UDim.new(0, 14)
    }
    local v125 = {}
    local v126 = {
        Image = "rbxassetid://2244452978",
        ImageRectOffset = Vector2.new(0, 0),
        ImageRectSize = Vector2.new(14, 14) * 2,
        AspectRatio = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        ImageTransparency = 0.6599999999999999
    }
    v126[v2.Event.Activated] = props.Close
    v125.CloseButton = createElement(v5, v126)
    v123.Header = createElement(v6, v124, v125)
    v123.ItemList = createElement(v7, {
        Scope = props.Scope,
        Items = state.Items,
        ScrollTo = state.ScrollTo,
        Core = props.Core,
        IdMap = v121.IdMap,
        RowHeight = state.RowHeight,
        ToggleExpand = v121.ToggleExpand
    })
    return createElement(v4, v122, v123)
end

return Explorer
