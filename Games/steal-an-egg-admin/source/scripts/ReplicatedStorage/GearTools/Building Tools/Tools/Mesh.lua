-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local Vendor = Tool:WaitForChild("Vendor")
local UI = Tool:WaitForChild("UI")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))
local v2 = require(Vendor:WaitForChild("Roact"))
local v3 = require(UI:WaitForChild("ColorPicker"))
local v4 = require(UI:WaitForChild("Dropdown"))
local v5 = require(Libraries:WaitForChild("Signal"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v6 = {
    Name = "Mesh Tool",
    CurrentType = nil,
    Color = BrickColor.new("Bright violet"),
    OnTypeChanged = v5.new()
}

v6.ManualText = "<font face=\"GothamBlack\" size=\"16\">Mesh Tool  \240\159\155\160</font>\nLets you add meshes to parts.<font size=\"6\"><br /></font>\n\n<b>TIP:</b> You can paste the link to anything with a mesh (e.g. a hat, gear, etc) and it will automatically find the right mesh and texture IDs.<font size=\"6\"><br /></font>\n\n<b>NOTE:</b> If HttpService is not enabled, you must type the mesh or image asset ID directly."

local v7 = {}

local function Equip() -- line 42
    ShowUI()
end

v6.Equip = Equip

local function Unequip() -- line 50
    HideUI()
    ClearConnections()
end

v6.Unequip = Unequip

function ClearConnections() -- line 59 | captures: v7
    for v8, v9 in pairs(v7) do
        v9:Disconnect()
        v7[v8] = nil
    end
end

function ShowUI() -- line 69 | captures: v1, v2, v3, v4, v6
    if v6.UI then
        v6.UI.Visible = true
    else
        v6.UI = Core.Tool.Interfaces.BTMeshToolGUI:Clone()
        v6.UI.Parent = Core.UI
        v6.UI.Visible = true
        local AddButton = v6.UI.AddButton
        local RemoveButton = v6.UI.RemoveButton
        local TextBox = v6.UI.MeshIdOption.TextBox
        local TextBox_2 = v6.UI.TextureIdOption.TextBox
        local HSVPicker = v6.UI.TintOption.HSVPicker
        MeshTypes = {
            Block = Enum.MeshType.Brick,
            Cylinder = Enum.MeshType.Cylinder,
            File = Enum.MeshType.FileMesh,
            Head = Enum.MeshType.Head,
            Sphere = Enum.MeshType.Sphere,
            Wedge = Enum.MeshType.Wedge
        }
        SortedMeshTypes = Support.Keys(MeshTypes)
        table.sort(SortedMeshTypes)

        local function BuildTypeDropdown() -- line 112 | captures: v2, v4, v6
            return v2.createElement(v4, {
                MaxRows = 6,
                Position = UDim2.new(0, 40, 0, 0),
                Size = UDim2.new(1, -40, 0, 25),
                Options = SortedMeshTypes,
                CurrentOption = v6.CurrentType,
                OnOptionSelected = function(v10) -- OnOptionSelected | line 119
                    SetProperty("MeshType", MeshTypes[v10])
                end
            })
        end

        local Dropdown = v2.mount(BuildTypeDropdown(), v6.UI.TypeOption, "Dropdown")
        v6.OnTypeChanged:Connect(function() -- line 127 | captures: BuildTypeDropdown, Dropdown, v2
            v2.update(Dropdown, BuildTypeDropdown())
        end)
        local TextBox_3 = v6.UI.ScaleOption.XInput.TextBox
        local TextBox_4 = v6.UI.ScaleOption.YInput.TextBox
        local TextBox_5 = v6.UI.ScaleOption.ZInput.TextBox
        TextBox_3.FocusLost:Connect(function(v11) -- line 135 | captures: TextBox_3
            local Text = TextBox_3.Text
            local v12 = tonumber(Text)
            SetAxisScale("X", v12)
        end)
        TextBox_4.FocusLost:Connect(function(v13) -- line 139 | captures: TextBox_4
            local Text = TextBox_4.Text
            local v14 = tonumber(Text)
            SetAxisScale("Y", v14)
        end)
        TextBox_5.FocusLost:Connect(function(v15) -- line 143 | captures: TextBox_5
            local Text = TextBox_5.Text
            local v16 = tonumber(Text)
            SetAxisScale("Z", v16)
        end)
        local TextBox_6 = v6.UI.OffsetOption.XInput.TextBox
        local TextBox_7 = v6.UI.OffsetOption.YInput.TextBox
        local TextBox_8 = v6.UI.OffsetOption.ZInput.TextBox
        TextBox_6.FocusLost:Connect(function(v17) -- line 152 | captures: TextBox_6
            local Text = TextBox_6.Text
            local v18 = tonumber(Text)
            SetAxisOffset("X", v18)
        end)
        TextBox_7.FocusLost:Connect(function(v19) -- line 156 | captures: TextBox_7
            local Text = TextBox_7.Text
            local v20 = tonumber(Text)
            SetAxisOffset("Y", v20)
        end)
        TextBox_8.FocusLost:Connect(function(v21) -- line 160 | captures: TextBox_8
            local Text = TextBox_8.Text
            local v22 = tonumber(Text)
            SetAxisOffset("Z", v22)
        end)
        TextBox.FocusLost:Connect(function(v23) -- line 166 | captures: TextBox
            SetMeshId(ParseAssetId(TextBox.Text))
        end)
        TextBox_2.FocusLost:Connect(function(v24) -- line 171 | captures: TextBox_2
            SetTextureId(ParseAssetId(TextBox_2.Text))
        end)
        local v25
        HSVPicker.MouseButton1Click:Connect(function() -- line 177 | captures: v25, v2, v3
            local v26 = VectorToColor(Support.IdentifyCommonProperty(GetMeshes(), "VertexColor"))
            local createElement = v2.createElement
            local v27 = {}
            v27.InitialColor = v26 or Color3.fromRGB(255, 255, 255)

            function v27.SetPreviewColor(v28) -- line 181
                SetPreviewTint(ColorToVector(v28))
            end

            function v27.OnConfirm(v29) -- line 184 | captures: v25, v2
                SetProperty("VertexColor", ColorToVector(v29))
                v25 = v2.unmount(v25)
            end

            function v27.OnCancel() -- line 188 | captures: v25, v2
                v25 = v2.unmount(v25)
            end

            local v30 = createElement(v3, v27)
            v25 = v25 and v2.update(v25, v30) or v2.mount(v30, Core.UI, "ColorPicker")
        end)
        AddButton.Button.MouseButton1Click:Connect(function() -- line 198
            AddMeshes()
        end)
        RemoveButton.Button.MouseButton1Click:Connect(function() -- line 201
            RemoveMeshes()
        end)
        local Signature = v6.UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v6.ManualText, v6.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function UpdateUI() -- line 214 | captures: v6
    local function v31(v32, ...)
        table.insert(v32, ...)
    end

    local function v33(v34, ...)
        table.insert(v34, ...)
    end

    local function v35(v36, ...)
        table.insert(v36, ...)
    end

    local function v37(v38, ...)
        table.insert(v38, ...)
    end

    local function v39(v40, ...)
        table.insert(v40, ...)
    end

    local function v41(v42, ...)
        table.insert(v42, ...)
    end

    if not v6.UI then
        return
    end
    local v43 = GetMeshes()
    local MeshType = Support.IdentifyCommonProperty(v43, "MeshType")
    local MeshId = Support.IdentifyCommonProperty(v43, "MeshId")
    local TextureId = Support.IdentifyCommonProperty(v43, "TextureId")
    local v44 = VectorToColor(Support.IdentifyCommonProperty(v43, "VertexColor"))
    local v45 = false
    for v46, v47 in pairs(GetMeshes()) do
        if v47.MeshType == Enum.MeshType.FileMesh then
            v45 = true
            break
        end
        v45 = false
    end
    local v48 = {}
    local v49 = {}
    local v50 = {}
    local v51 = {}
    local v52 = {}
    local v53 = {}
    for v54, v55 in pairs(GetMeshes()) do
        v31(v48, Support.Round(v55.Scale.X, 3))
        v33(v49, Support.Round(v55.Scale.Y, 3))
        v35(v50, Support.Round(v55.Scale.Z, 3))
        v37(v51, Support.Round(v55.Offset.X, 3))
        v39(v52, Support.Round(v55.Offset.Y, 3))
        v41(v53, Support.Round(v55.Offset.Z, 3))
    end
    local v56 = Support.IdentifyCommonItem(v48)
    local v57 = Support.IdentifyCommonItem(v49)
    local v58 = Support.IdentifyCommonItem(v50)
    local v59 = Support.IdentifyCommonItem(v51)
    local v60 = Support.IdentifyCommonItem(v52)
    local v61 = Support.IdentifyCommonItem(v53)
    local AddButton = v6.UI.AddButton
    local RemoveButton = v6.UI.RemoveButton
    local TextBox = v6.UI.MeshIdOption.TextBox
    local TextBox_2 = v6.UI.TextureIdOption.TextBox
    local Indicator = v6.UI.TintOption.Indicator
    local TextBox_3 = v6.UI.ScaleOption.XInput.TextBox
    local TextBox_4 = v6.UI.ScaleOption.YInput.TextBox
    local TextBox_5 = v6.UI.ScaleOption.ZInput.TextBox
    local TextBox_6 = v6.UI.OffsetOption.XInput.TextBox
    local TextBox_7 = v6.UI.OffsetOption.YInput.TextBox
    local TextBox_8 = v6.UI.OffsetOption.ZInput.TextBox
    local v62 = UpdateDataInputs
    local v63 = {}
    v63[TextBox] = MeshId and ParseAssetId(MeshId) or MeshId or "*"
    v63[TextBox_2] = TextureId and ParseAssetId(TextureId) or TextureId or "*"
    v63[TextBox_3] = v56 or "*"
    v63[TextBox_4] = v57 or "*"
    v63[TextBox_5] = v58 or "*"
    v63[TextBox_6] = v59 or "*"
    v63[TextBox_7] = v60 or "*"
    v63[TextBox_8] = v61 or "*"
    v62(v63)
    UpdateColorIndicator(Indicator, v44)
    local v64 = Support.FindTableOccurrence(MeshTypes, MeshType)
    if v6.CurrentType ~= v64 then
        v6.CurrentType = v64
        v6.OnTypeChanged:Fire(v64)
    end
    AddButton.Visible = false
    RemoveButton.Visible = false
    v6.UI.TypeOption.Visible = false
    TextBox.Parent.Visible = false
    TextBox_2.Parent.Visible = false
    Indicator.Parent.Visible = false
    v6.UI.ScaleOption.Visible = false
    v6.UI.OffsetOption.Visible = false
    local v65
    if #v43 == 0 then
        v65 = { AddButton }
    elseif #v43 ~= #Selection.Parts or not v45 then
        if #v43 ~= #Selection.Parts or v45 then
            if #v43 == #Selection.Parts or not v45 then
                if #v43 == #Selection.Parts or v45 then
                else
                    v65 = {
                        AddButton,
                        v6.UI.TypeOption,
                        v6.UI.ScaleOption,
                        v6.UI.OffsetOption,
                        RemoveButton
                    }
                end
            else
                v65 = {
                    AddButton,
                    v6.UI.TypeOption,
                    v6.UI.ScaleOption,
                    v6.UI.OffsetOption,
                    TextBox.Parent,
                    TextBox_2.Parent,
                    Indicator.Parent,
                    RemoveButton
                }
            end
        else
            v65 = {
                v6.UI.TypeOption,
                v6.UI.ScaleOption,
                v6.UI.OffsetOption,
                RemoveButton
            }
        end
    else
        v65 = {
            v6.UI.TypeOption,
            v6.UI.ScaleOption,
            v6.UI.OffsetOption,
            TextBox.Parent,
            TextBox_2.Parent,
            Indicator.Parent,
            RemoveButton
        }
    end
    DisplayLinearLayout(v65, v6.UI, UDim2.new(0, 0, 0, 20), 10)
end

function HideUI() -- line 328 | captures: v6
    if v6.UI then
        v6.UI.Visible = false
        UIUpdater:Stop()
    end
end

function GetMeshes() -- line 344
    local function v66(v67, ...)
        table.insert(v67, ...)
    end

    local v68 = {}
    for v69, v70 in pairs(Selection.Parts) do
        v66(v68, Support.GetChildOfClass(v70, "SpecialMesh"))
    end
    return v68
end

function ParseAssetId(v71) -- line 358
    local function v72(...)
        return (tonumber(...))
    end

    local function v73(...)
        return (tonumber(...))
    end

    local function v74(...)
        return (tonumber(...))
    end

    return tonumber(v71) or v72(v71:lower():match("%?id=([0-9]+)")) or v73(v71:match("/([0-9]+)/")) or v74(v71:lower():match("rbxassetid://([0-9]+)"))
end

function VectorToColor(v75) -- line 371
    if v75 then
        return Color3.new(v75.X, v75.Y, v75.Z)
    end
end

function ColorToVector(v76) -- line 381
    if not v76 then
        return
    end
    local r = v76.r
    local g = v76.g
    local b = v76.b
    return (Vector3.new(r, g, b))
end

function UpdateDataInputs(v77) -- line 391
    for v78, v79 in pairs(v77) do
        if not v78:IsFocused() then
            v78.Text = tostring(v79)
        end
    end
end

function UpdateColorIndicator(v80, v81) -- line 409
    if v81 then
        v80.BackgroundColor3 = v81
        v80.Varies.Text = ""
    else
        v80.BackgroundColor3 = Color3.new(0.8705882352941177, 0.8705882352941177, 0.8705882352941177)
        v80.Varies.Text = "*"
    end
end

function DisplayLinearLayout(v82, v83, v84, v85) -- line 425
    local v86 = 0
    for v87, v88 in ipairs(v82) do
        v88.Visible = true
        v88.Position = v84 + UDim2.new(v88.Position.X.Scale, v88.Position.X.Offset, 0, v86 + v85)
        v86 = v86 + v85 + v88.AbsoluteSize.Y
    end
    v83.Size = UDim2.new(0, 200, 0, v86 + 30)
end

function AddMeshes() -- line 454
    local v89 = {}
    for v90, v91 in pairs(Selection.Parts) do
        if not Support.GetChildOfClass(v91, "SpecialMesh") then
            local v92 = { Part = v91 }
            table.insert(v89, v92)
        end
    end
    local v93 = {
        Meshes = Core.SyncAPI:Invoke("CreateMeshes", v89),
        Selection = Selection.Items,
        Unapply = function(v94) -- Unapply | line 480
            Selection.Replace(v94.Selection)
            Core.SyncAPI:Invoke("Remove", v94.Meshes)
        end,
        Apply = function(v95) -- Apply | line 491
            Core.SyncAPI:Invoke("UndoRemove", v95.Meshes)
            Selection.Replace(v95.Selection)
        end
    }
    Core.History.Add(v93)
end

function RemoveMeshes() -- line 509
    local v96 = GetMeshes()
    local v97 = {
        Meshes = v96,
        Selection = Selection.Items,
        Unapply = function(v98) -- Unapply | line 519
            Core.SyncAPI:Invoke("UndoRemove", v98.Meshes)
            Selection.Replace(v98.Selection)
        end,
        Apply = function(v99) -- Apply | line 530
            Selection.Replace(v99.Selection)
            Core.SyncAPI:Invoke("Remove", v99.Meshes)
        end
    }
    Core.SyncAPI:Invoke("Remove", v96)
    Core.History.Add(v97)
end

local v100

function SetPreviewTint(v101) -- line 553 | captures: v100
    if v101 or not v100 then
        if v101 then
            if not v100 then
                v100 = {}
                for v102, v103 in pairs(GetMeshes()) do
                    v100[v103] = { VertexColor = v103.VertexColor }
                end
            end
            for v104 in pairs(v100) do
                v104.VertexColor = v101
            end
        end
    else
        for v105, v106 in pairs(v100) do
            v105.VertexColor = v106.VertexColor
        end
        v100 = nil
    end
end

function SetProperty(v107, v108) -- line 586
    if not v108 then
        return
    end
    TrackChange()
    for v109, v110 in pairs(GetMeshes()) do
        local Before = HistoryRecord.Before
        local v111 = { Part = v110.Parent }
        v111[v107] = v110[v107]
        table.insert(Before, v111)
        local After = HistoryRecord.After
        local v112 = { Part = v110.Parent }
        v112[v107] = v108
        table.insert(After, v112)
    end
    RegisterChange()
end

function SetAxisScale(v113, v114) -- line 612
    TrackChange()
    for v115, v116 in pairs(GetMeshes()) do
        local Before = HistoryRecord.Before
        local v117 = {
            Part = v116.Parent,
            Scale = v116.Scale
        }
        table.insert(Before, v117)
        local v118 = if v113 == "X" and v114 then v114 else v116.Scale.X
        local v119 = if v113 == "Y" and v114 then v114 else v116.Scale.Y
        local v120 = if v113 == "Z" and v114 then v114 else v116.Scale.Z
        local v121 = Vector3.new(v118, v119, v120)
        local After = HistoryRecord.After
        local v122 = {
            Part = v116.Parent,
            Scale = v121
        }
        table.insert(After, v122)
    end
    RegisterChange()
end

function SetAxisOffset(v123, v124) -- line 641
    TrackChange()
    for v125, v126 in pairs(GetMeshes()) do
        local Before = HistoryRecord.Before
        local v127 = {
            Part = v126.Parent,
            Offset = v126.Offset
        }
        table.insert(Before, v127)
        local v128 = if v123 == "X" and v124 then v124 else v126.Offset.X
        local v129 = if v123 == "Y" and v124 then v124 else v126.Offset.Y
        local v130 = if v123 == "Z" and v124 then v124 else v126.Offset.Z
        local v131 = Vector3.new(v128, v129, v130)
        local After = HistoryRecord.After
        local v132 = {
            Part = v126.Parent,
            Offset = v131
        }
        table.insert(After, v132)
    end
    RegisterChange()
end

function SetMeshId(v133) -- line 670
    if not v133 then
        return
    end
    local v134 = { MeshId = "rbxassetid://" .. v133 }
    Core.Try(Core.SyncAPI.Invoke, Core.SyncAPI, "ExtractMeshFromAsset", v133):Then(function(v135) -- line 685 | captures: v134
        local success = v135.success
        assert(success, "Extraction failed")
        local meshID = v135.meshID
        if meshID then
            v134.MeshId = "rbxassetid://" .. meshID
        end
        local textureID = v135.textureID
        if textureID then
            v134.TextureId = "rbxassetid://" .. textureID
        end
        local tint = v135.tint
        if tint then
            local x = tint.x
            local y = tint.y
            local z = tint.z
            v134.VertexColor = Vector3.new(x, y, z)
        end
        local scale = v135.scale
        if not scale then
            return
        end
        local x = scale.x
        local y = scale.y
        local z = scale.z
        v134.Scale = Vector3.new(x, y, z)
    end)
    TrackChange()
    for v136, v137 in pairs(GetMeshes()) do
        local v138 = { Part = v137.Parent }
        local v139 = { Part = v137.Parent }
        for v140, v141 in pairs(v134) do
            v138[v140] = v137[v140]
            v139[v140] = v141
        end
        local Before = HistoryRecord.Before
        table.insert(Before, v138)
        local After = HistoryRecord.After
        table.insert(After, v139)
    end
    RegisterChange()
end

function SetTextureId(v142) -- line 744
    if not v142 then
        return
    end
    local v143 = { TextureId = "rbxassetid://" .. v142 }
    Core.Try(Core.SyncAPI.Invoke, Core.SyncAPI, "ExtractImageFromDecal", v142):Then(function(v144) -- line 759 | captures: v143
        v143.TextureId = "rbxassetid://" .. v144
    end)
    TrackChange()
    for v145, v146 in pairs(GetMeshes()) do
        local v147 = { Part = v146.Parent }
        local v148 = { Part = v146.Parent }
        for v149, v150 in pairs(v143) do
            v147[v149] = v146[v149]
            v148[v149] = v150
        end
        local Before = HistoryRecord.Before
        table.insert(Before, v147)
        local After = HistoryRecord.After
        table.insert(After, v148)
    end
    RegisterChange()
end

function TrackChange() -- line 791
    HistoryRecord = {
        Before = {},
        After = {},
        Selection = Selection.Items,
        Unapply = function(v151) -- Unapply | line 799
            Selection.Replace(v151.Selection)
            Core.SyncAPI:Invoke("SyncMesh", v151.Before)
        end,
        Apply = function(v152) -- Apply | line 810
            Selection.Replace(v152.Selection)
            Core.SyncAPI:Invoke("SyncMesh", v152.After)
        end
    }
end

function RegisterChange() -- line 825
    if not HistoryRecord then
        return
    end
    Core.SyncAPI:Invoke("SyncMesh", HistoryRecord.After)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

return v6
