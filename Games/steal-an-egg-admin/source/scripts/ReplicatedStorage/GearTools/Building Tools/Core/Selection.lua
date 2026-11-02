-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local History = require(script.Parent.History)
local Libraries = Parent:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Libraries:WaitForChild("Signal"))
local v3 = require(Libraries:WaitForChild("Maid"))
local v4 = require(Libraries:WaitForChild("Make"))
local v5 = require(Libraries:WaitForChild("InstancePool"))

Selection = {}
Selection.Items = {}
Selection.ItemIndex = {}
Selection.Parts = {}
Selection.PartIndex = {}
Selection.Models = {}
Selection.ModelIndex = {}
Selection.Outlines = {}
Selection.Color = BrickColor.new("Cyan")
Selection.Multiselecting = false
Selection.Maid = v3.new()
Selection.ItemsAdded = v2.new()
Selection.ItemsRemoved = v2.new()
Selection.PartsAdded = v2.new()
Selection.PartsRemoved = v2.new()
Selection.FocusChanged = v2.new()
Selection.Cleared = v2.new()
Selection.Changed = v2.new()

local function IsSelected(v6) -- line 34
    return Selection.ItemIndex[v6]
end

Selection.IsSelected = IsSelected

local function CollectPartsAndModels(v7, v8, v9) -- line 43
    if v7:IsA("BasePart") then
        table.insert(v8, v7)
    else
        if v7:IsA("Model") then
            table.insert(v9, v7)
        end
        local v10 = v7:GetDescendants()
        for v11, v12 in ipairs(v10) do
            if v12:IsA("BasePart") then
                table.insert(v8, v12)
            elseif v12:IsA("Model") then
                table.insert(v9, v12)
            end
        end
    end
end

local function Add(v13, v14) -- line 68 | captures: v1, v3, CollectPartsAndModels
    GetCore()
    local v15 = {}
    for v16, v17 in pairs(v13) do
        if v17.Parent and not Selection.ItemIndex[v17] then
            table.insert(v15, v17)
        end
    end
    local Items = Selection.Items
    local v18 = {}
    local v19 = {}
    for v20, v21 in pairs(v15) do
        Selection.ItemIndex[v21] = true
        CreateSelectionBoxes(v21)
        local v22 = v3.new()
        Selection.Maid[v21] = v22
        local AncestryChanged = v21.AncestryChanged
        local v23 = v21
        v22.RemovalListener = AncestryChanged:Connect(function(v24, v25) -- line 103 | captures: v23
            if v25 == nil then
                Selection.Remove({ v23 })
            end
        end)
        CollectPartsAndModels(v21, v18, v19)
        local v26 = not v21:IsA("BasePart") or nil
        v22.NewPartsOrModels = v26 and
        v21.DescendantAdded:Connect(function(v27) -- line 114 | captures: v1
            if v27:IsA("PVInstance") then
                if v27:IsA("BasePart") then
                    local v28 = (Selection.PartIndex[v27] or 0) + 1
                    Selection.PartIndex[v27] = v28
                    Selection.Parts = v1.Keys(Selection.PartIndex)
                    if v28 == 1 then
                        Selection.PartsAdded:Fire({ v27 })
                    end
                elseif v27:IsA("Model") then
                    local v29 = (Selection.ModelIndex[v27] or 0) + 1
                    Selection.ModelIndex[v27] = v29
                    Selection.Models = v1.Keys(Selection.ModelIndex)
                end
            end
        end)
        v22.RemovingPartsOrModels = v26 and
        v21.DescendantRemoving:Connect(function(v30) -- line 130 | captures: v1
            if Selection.PartIndex[v30] then
                local v31 = (Selection.PartIndex[v30] or 0) - 1
                Selection.PartIndex[v30] = v31 > 0 and v31 or nil
                if v31 == 0 then
                    Selection.Parts = v1.Keys(Selection.PartIndex)
                    Selection.PartsRemoved:Fire({ v30 })
                end
            elseif Selection.ModelIndex[v30] then
                local v32 = (Selection.ModelIndex[v30] or 0) - 1
                Selection.ModelIndex[v30] = v32 > 0 and v32 or nil
                if v32 == 0 then
                    Selection.Models = v1.Keys(Selection.ModelIndex)
                end
            end
        end)
    end
    Selection.Items = v1.Keys(Selection.ItemIndex)
    if v14 and #v15 > 0 then
        TrackSelectionChange(Items)
    end
    local v33 = {}
    for v34, v35 in pairs(v18) do
        local v36 = (Selection.PartIndex[v35] or 0) + 1
        Selection.PartIndex[v35] = v36
        if v36 == 1 then
            table.insert(v33, v35)
        end
    end
    local v37 = 0
    for v38, v39 in ipairs(v19) do
        local v40 = (Selection.ModelIndex[v39] or 0) + 1
        Selection.ModelIndex[v39] = v40
        if v40 == 1 then
            v37 += 1
        end
    end
    if #v33 > 0 then
        Selection.Parts = v1.Keys(Selection.PartIndex)
        Selection.PartsAdded:Fire(v33)
    end
    if v37 > 0 then
        Selection.Models = v1.Keys(Selection.ModelIndex)
    end
    if #v15 > 0 then
        Selection.ItemsAdded:Fire(v15)
        Selection.Changed:Fire()
    end
end

Selection.Add = Add

local function Remove(v41, v42) -- line 196 | captures: v1, CollectPartsAndModels
    local v43 = {}
    for v44, v45 in pairs(v41) do
        if Selection.IsSelected(v45) then
            table.insert(v43, v45)
        end
    end
    local Items = Selection.Items
    local v46 = {}
    local v47 = {}
    for v48, v49 in pairs(v43) do
        Selection.ItemIndex[v49] = nil
        RemoveSelectionBoxes(v49)
        Selection.Maid[v49] = nil
        CollectPartsAndModels(v49, v46, v47)
    end
    Selection.Items = v1.Keys(Selection.ItemIndex)
    if v42 and #v43 > 0 then
        TrackSelectionChange(Items)
    end
    local v50 = {}
    for v51, v52 in pairs(v46) do
        local v53 = (Selection.PartIndex[v52] or 0) - 1
        Selection.PartIndex[v52] = v53 > 0 and v53 or nil
        if v53 == 0 then
            table.insert(v50, v52)
        end
    end
    local v54 = 0
    for v55, v56 in ipairs(v47) do
        local v57 = (Selection.ModelIndex[v56] or 0) - 1
        Selection.ModelIndex[v56] = v57 > 0 and v57 or nil
        if v57 == 0 then
            v54 += 1
        end
    end
    if #v50 > 0 then
        Selection.Parts = v1.Keys(Selection.PartIndex)
        Selection.PartsRemoved:Fire(v50)
    end
    if v54 > 0 then
        Selection.Models = v1.Keys(Selection.ModelIndex)
    end
    if #v43 > 0 then
        Selection.ItemsRemoved:Fire(v43)
        Selection.Changed:Fire()
    end
end

Selection.Remove = Remove

local function Clear(v58) -- line 278
    Selection.Remove(Selection.Items, v58)
    Selection.Cleared:Fire()
end

Selection.Clear = Clear

local function Replace(v59, v60) -- line 289 | captures: v1
    local Items = Selection.Items
    local v61 = {}
    for v62, v63 in ipairs(v59) do
        if not Selection.ItemIndex[v63] then
            table.insert(v61, v63)
        end
    end
    local v64 = {}
    local v65 = v1.FlipTable(v59)
    for v66, v67 in ipairs(Selection.Items) do
        if not v65[v67] then
            table.insert(v64, v67)
        end
    end
    if #v64 > 0 then
        Selection.Remove(v64, false)
    end
    if #v61 > 0 then
        Selection.Add(v61, false)
    end
    if v60 then
        TrackSelectionChange(Items)
    end
end

Selection.Replace = Replace

local function IsVisible(v68) -- line 327
    return v68:IsA("Model") or v68:IsA("BasePart")
end

local function GetVisibleFocus(v69) -- line 331
    if v69 then
        if v69:IsA("Model") or v69:IsA("BasePart") then
            return v69
        end
        return v69:FindFirstChildWhichIsA("BasePart") or v69:FindFirstChildWhichIsA("Model") or v69:FindFirstChildWhichIsA("BasePart", true) or v69:FindFirstChildWhichIsA("Model", true)
    end
    return nil
end

local function SetFocus(v70) -- line 352 | captures: GetVisibleFocus
    local v71 = GetVisibleFocus(v70)
    if Selection.Focus ~= v71 then
        Selection.Focus = v71
        Selection.FocusChanged:Fire(v71)
    end
end

Selection.SetFocus = SetFocus

function FocusOnLastSelectedPart() -- line 369
    if #Selection.Items == 0 then
        Selection.SetFocus(nil)
    else
        Selection.SetFocus(Selection.Items[#Selection.Items])
    end
end

Selection.Changed:Connect(FocusOnLastSelectedPart)

function GetCore() -- line 386
    return require(script.Parent)
end

local function GetVisibleChildren(v72, v73) -- line 391 | captures: GetVisibleChildren
    local v74 = v73 or {}
    for v75, v76 in pairs(v72:GetChildren()) do
        if v76:IsA("Model") or v76:IsA("BasePart") then
            v74[#v74 + 1] = v76
        else
            GetVisibleChildren(v76, v74)
        end
    end
    return v74
end

local v77 = v5.new(60, function() -- line 408 | captures: v4
    return v4("SelectionBox")({
        Name = "BTSelectionBox",
        LineThickness = 0.025,
        Transparency = 0.5,
        Parent = GetCore().UI,
        Color = Selection.Color
    })
end)

local function Cleanup(v78) -- line 419
    v78.Adornee = nil
    v78.Visible = nil
end

v77.Cleanup = Cleanup

function CreateSelectionBoxes(v79) -- line 424 | captures: v1, GetVisibleChildren, v77
    if not (GetCore().Mode == "Tool") or Selection.Outlines[v79] then
        return
    end
    local v80 = v1.FlipTable({ v79 })
    if not (v79:IsA("Model") or v79:IsA("BasePart")) then
        v80 = v1.FlipTable((GetVisibleChildren(v79)))
    end
    local v81 = {}
    for v82 in pairs(v80) do
        local v83 = v77:Get()
        v83.Adornee = v82
        v83.Visible = true
        v81[v82] = v83
    end
    Selection.Outlines[v79] = v81
end

function RemoveSelectionBoxes(v84) -- line 462 | captures: v77
    local v85 = Selection.Outlines[v84]
    if v85 then
        for v86, v87 in pairs(v85) do
            v77:Release(v87)
        end
        Selection.Outlines[v84] = nil
    end
end

local function RecolorOutlines(v88) -- line 481 | captures: v77
    Selection.Color = v88
    for v89 in pairs(v77.All) do
        v89.Color = Selection.Color
    end
end

Selection.RecolorOutlines = RecolorOutlines

local function RecolorOutline(v90, v91) -- line 494
    local v92 = Selection.Outlines[v90]
    if v92 then
        for v93, v94 in pairs(v92) do
            v94.Color = v91
        end
    end
end

Selection.RecolorOutline = RecolorOutline

local function FlashOutlines() -- line 509 | captures: v77
    for v95 = 1, 0.5, -0.1 do
        for v96 in pairs(v77.InUse) do
            v96.Transparency = v95
        end
        wait(0.1)
    end
end

Selection.FlashOutlines = FlashOutlines

local function EnableMultiselectionHotkeys() -- line 527 | captures: v1
    local v97 = v1.FlipTable({ "LeftShift", "RightShift", "LeftControl", "RightControl" })
    local v98 = GetCore()
    v98.Connections.MultiselectionHotkeys = v1.AddUserInputListener("Began", "Keyboard", false, function(v99) -- line 537 | captures: v97
        if v97[v99.KeyCode.Name] then
            Selection.Multiselecting = true
        end
    end)
    v98.Connections.MultiselectingReleaseHotkeys = v1.AddUserInputListener("Ended", "Keyboard", true, function(v100) -- line 544 | captures: v97, v1
        local Name = v1.GetListMembers(v1.GetListMembers(Game:GetService("UserInputService"):GetKeysPressed(), "KeyCode"), "Name")
        for v101, v102 in pairs(Name) do
            if v97[v102] then
                return
            end
        end
        Selection.Multiselecting = false
    end)
end

Selection.EnableMultiselectionHotkeys = EnableMultiselectionHotkeys

local function EnableOutlines() -- line 563
    for v103 in pairs(Selection.ItemIndex) do
        CreateSelectionBoxes(v103)
    end
end

Selection.EnableOutlines = EnableOutlines

local function HideOutlines() -- line 572
    for v104 in pairs(Selection.Outlines) do
        RemoveSelectionBoxes(v104)
    end
end

Selection.HideOutlines = HideOutlines

function TrackSelectionChange(v105) -- line 581 | captures: History
    if History.Index == #History.Stack then
        History.Add({
            Before = v105,
            After = Selection.Items,
            Unapply = function(v106) -- Unapply | line 595
                Selection.Replace(v106.Before)
            end,
            Apply = function(v107) -- Apply | line 603
                Selection.Replace(v107.After)
            end
        })
    end
end

return Selection
