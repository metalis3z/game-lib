-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local Vendor = Tool:WaitForChild("Vendor")
local UI = Tool:WaitForChild("UI")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))
local v2 = require(Vendor:WaitForChild("Roact"))
local v3 = require(UI:WaitForChild("Dropdown"))
local v4 = require(Libraries:WaitForChild("Signal"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v5 = {
    Name = "Texture Tool",
    Type = "Decal",
    Color = BrickColor.new("Bright violet"),
    Face = Enum.NormalId.Front,
    OnFaceChanged = v4.new()
}

v5.ManualText = "<font face=\"GothamBlack\" size=\"16\">Texture Tool  \240\159\155\160</font>\nLets you add decals and textures to parts.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Click on any part's surface to quickly change a decal/texture's side.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>You can paste the link to any decal and it'll automatically get the right image ID.<font size=\"6\"><br /></font>\n\n<b>NOTE: </b>If HttpService isn't enabled, you must manually type an image's ID."

local v6 = {}

local function Equip(v7) -- line 44
    v7:ShowUI()
    v7:EnableSurfaceClickSelection()
    v7:SetTextureType(v7.Type)
    v7:SetFace(v7.Face)
end

v5.Equip = Equip

local function Unequip(v8) -- line 57
    v8:HideUI()
    ClearConnections()
end

v5.Unequip = Unequip

function ClearConnections() -- line 66 | captures: v6
    for v9, v10 in pairs(v6) do
        v10:Disconnect()
        v6[v9] = nil
    end
end

function v5.ShowUI(v11) -- line 76 | captures: v1, v2, v3, v5
    if v11.UI then
        v11.UI.Visible = true
        local Loop = Support.Loop
        v11.StopUpdatingUI = Loop(0.1, function() -- line 86 | captures: v11
            v11:UpdateUI()
        end)
    else
        v11.UI = Core.Tool.Interfaces.BTTextureToolGUI:Clone()
        v11.UI.Parent = Core.UI
        v11.UI.Visible = true
        local AddButton = v11.UI.AddButton
        local RemoveButton = v11.UI.RemoveButton
        local Button = v11.UI.ModeOption.Decal.Button
        local Button_2 = v11.UI.ModeOption.Texture.Button
        local TextBox = v11.UI.ImageIDOption.TextBox
        local TextBox_2 = v11.UI.TransparencyOption.Input.TextBox
        local TextBox_3 = v11.UI.RepeatOption.XInput.TextBox
        local TextBox_4 = v11.UI.RepeatOption.YInput.TextBox
        Button.MouseButton1Click:Connect(function() -- line 111 | captures: v11
            v11:SetTextureType("Decal")
        end)
        Button_2.MouseButton1Click:Connect(function() -- line 114 | captures: v11
            v11:SetTextureType("Texture")
        end)
        local v12 = { "Top", "Bottom", "Front", "Back", "Left", "Right" }

        local function BuildFaceDropdown() -- line 127 | captures: v11, v12, v2, v3
            local createElement = v2.createElement
            local v13 = {
                MaxRows = 6,
                Position = UDim2.new(0, 30, 0, 0),
                Size = UDim2.new(1, -45, 0, 25),
                Options = v12
            }
            v13.CurrentOption = v11.Face and v11.Face.Name

            function v13.OnOptionSelected(v14) -- line 134 | captures: v11
                v11:SetFace(Enum.NormalId[v14])
            end

            return createElement(v3, v13)
        end

        local Dropdown = v2.mount(BuildFaceDropdown(), v11.UI.SideOption, "Dropdown")
        v11.OnFaceChanged:Connect(function() -- line 142 | captures: BuildFaceDropdown, Dropdown, v2
            v2.update(Dropdown, BuildFaceDropdown())
        end)
        TextBox.FocusLost:Connect(function(v15) -- line 147 | captures: TextBox, v5
            SetTextureId(v5.Type, v5.Face, ParseAssetId(TextBox.Text))
        end)
        SyncInputToProperty("Transparency", TextBox_2)
        SyncInputToProperty("StudsPerTileU", TextBox_3)
        SyncInputToProperty("StudsPerTileV", TextBox_4)
        AddButton.Button.MouseButton1Click:Connect(function() -- line 157 | captures: v5
            AddTextures(v5.Type, v5.Face)
        end)
        RemoveButton.Button.MouseButton1Click:Connect(function() -- line 160 | captures: v5
            RemoveTextures(v5.Type, v5.Face)
        end)
        local Signature = v11.UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v5.ManualText, v5.Color.Color, Signature)
        local Loop = Support.Loop
        v11.StopUpdatingUI = Loop(0.1, function() -- line 169 | captures: v11
            v11:UpdateUI()
        end)
    end
end

function SyncInputToProperty(v16, v17) -- line 175 | captures: v5
    v17.FocusLost:Connect(function() -- line 179 | captures: v16, v17, v5
        local v18 = SetProperty
        local Type = v5.Type
        local Face = v5.Face
        local Text = v17.Text
        v18(Type, Face, v16, (tonumber(Text)))
    end)
end

function v5.EnableSurfaceClickSelection(v19) -- line 185 | captures: v6
    if v6.SurfaceClickSelection then
        v6.SurfaceClickSelection:Disconnect()
        v6.SurfaceClickSelection = nil
    end
    local Button1Down = Core.Mouse.Button1Down
    v6.SurfaceClickSelection = Button1Down:Connect(function() -- line 195 | captures: v19
        local v20, v21 = Core.Targeting:UpdateTarget()
        if Selection.IsSelected(v21) then
            v19:SetFace(Core.Mouse.TargetSurface)
        end
    end)
end

local function HideUI(v22) -- line 204
    if v22.UI then
        v22.UI.Visible = false
        v22.StopUpdatingUI()
    end
end

v5.HideUI = HideUI

function GetTextures(v23, v24) -- line 220
    local v25 = {}
    for v26, v27 in pairs(Selection.Parts) do
        for v28, v29 in pairs(v27:GetChildren()) do
            if v29.ClassName == v23 and v29.Face == v24 then
                table.insert(v25, v29)
            end
        end
    end
    return v25
end

local v30 = { "Decal", "Texture" }
local v31 = {
    EmptySelection = { "SelectNote" },
    NoTextures = { "ModeOption", "SideOption", "AddButton" },
    SomeDecals = { "ModeOption", "SideOption", "ImageIDOption", "TransparencyOption", "AddButton", "RemoveButton" },
    AllDecals = { "ModeOption", "SideOption", "ImageIDOption", "TransparencyOption", "RemoveButton" },
    SomeTextures = { "ModeOption", "SideOption", "ImageIDOption", "TransparencyOption", "RepeatOption", "AddButton", "RemoveButton" },
    AllTextures = { "ModeOption", "SideOption", "ImageIDOption", "TransparencyOption", "RepeatOption", "RemoveButton" }
}
local v32 = { "SelectNote", "ModeOption", "SideOption", "ImageIDOption", "TransparencyOption", "RepeatOption", "AddButton", "RemoveButton" }
local v33

function v5.ChangeLayout(v34, v35) -- line 261 | captures: v33, v32
    if v33 == v35 then
        return
    end
    v33 = v35
    for v36, v37 in pairs(v32) do
        v34.UI[v37].Visible = false
    end
    local v38 = 0
    for v39, v40 in ipairs(v35) do
        local v41 = v34.UI[v40]
        v41.Visible = true
        v41.Position = UDim2.new(0, 0, 0, 20) + UDim2.new(v41.Position.X.Scale, v41.Position.X.Offset, 0, v38 + 10)
        v38 = v38 + 10 + v41.AbsoluteSize.Y
    end
    v34.UI.Size = UDim2.new(0, 200, 0, v38 + 30)
end

function v5.UpdateUI(v42) -- line 307 | captures: v5, v31
    if not v42.UI then
        return
    end
    local v43 = GetTextures(v5.Type, v5.Face)
    local TextBox = v42.UI.ImageIDOption.TextBox
    local TextBox_2 = v42.UI.TransparencyOption.Input.TextBox
    local v44 = v5.Type .. "s"
    if #Selection.Parts == 0 then
        v42:ChangeLayout(v31.EmptySelection)
    elseif #v43 == 0 then
        v42:ChangeLayout(v31.NoTextures)
    else
        if #Selection.Parts == #v43 then
            if #Selection.Parts == #v43 then
                v42:ChangeLayout(v31["All" .. v44])
            end
        else
            v42:ChangeLayout(v31["Some" .. v44])
        end
        local Texture = Support.IdentifyCommonProperty(v43, "Texture")
        local Transparency = Support.IdentifyCommonProperty(v43, "Transparency")
        local v45 = UpdateDataInputs
        local v46 = {}
        v46[TextBox] = Texture and ParseAssetId(Texture) or Texture or "*"
        v46[TextBox_2] = Transparency and Support.Round(Transparency, 3) or "*"
        v45(v46)
        if v5.Type == "Texture" then
            local TextBox = v42.UI.RepeatOption.XInput.TextBox
            local TextBox_2 = v42.UI.RepeatOption.YInput.TextBox
            local StudsPerTileU = Support.IdentifyCommonProperty(v43, "StudsPerTileU")
            local StudsPerTileV = Support.IdentifyCommonProperty(v43, "StudsPerTileV")
            local v47 = UpdateDataInputs
            local v48 = {}
            v48[TextBox] = StudsPerTileU and Support.Round(StudsPerTileU, 3) or "*"
            v48[TextBox_2] = StudsPerTileV and Support.Round(StudsPerTileV, 3) or "*"
            v47(v48)
        end
    end
end

function UpdateDataInputs(v49) -- line 383
    for v50, v51 in pairs(v49) do
        if not v50:IsFocused() then
            v50.Text = tostring(v51)
        end
    end
end

function ParseAssetId(v52) -- line 401
    local function v53(...)
        return (tonumber(...))
    end

    local function v54(...)
        return (tonumber(...))
    end

    local function v55(...)
        return (tonumber(...))
    end

    return tonumber(v52) or v53(v52:lower():match("%?id=([0-9]+)")) or v54(v52:match("/([0-9]+)/")) or v55(v52:lower():match("rbxassetid://([0-9]+)"))
end

local function SetFace(v56, v57) -- line 414
    v56.Face = v57
    v56.OnFaceChanged:Fire(v57)
end

v5.SetFace = SetFace

local function SetTextureType(v58, v59) -- line 419
    v58.Type = v59
    Core.ToggleSwitch(v59, v58.UI.ModeOption)
    v58.UI.AddButton.Button.Text = "ADD " .. v59:upper()
    v58.UI.RemoveButton.Button.Text = "REMOVE " .. v59:upper()
end

v5.SetTextureType = SetTextureType

function SetProperty(v60, v61, v62, v63) -- line 431
    if not v63 then
        return
    end
    TrackChange()
    for v64, v65 in pairs(GetTextures(v60, v61)) do
        local Before = HistoryRecord.Before
        local v66 = {
            Part = v65.Parent,
            TextureType = v60,
            Face = v61
        }
        v66[v62] = v65[v62]
        table.insert(Before, v66)
        local After = HistoryRecord.After
        local v67 = {
            Part = v65.Parent,
            TextureType = v60,
            Face = v61
        }
        v67[v62] = v63
        table.insert(After, v67)
    end
    RegisterChange()
end

function SetTextureId(v68, v69, v70) -- line 457
    if not v70 then
        return
    end
    local v71 = { Texture = "rbxassetid://" .. v70 }
    Core.Try(Core.SyncAPI.Invoke, Core.SyncAPI, "ExtractImageFromDecal", v70):Then(function(v72) -- line 472 | captures: v71
        v71.Texture = "rbxassetid://" .. v72
    end)
    TrackChange()
    for v73, v74 in pairs(GetTextures(v68, v69)) do
        local v75 = {
            Part = v74.Parent,
            TextureType = v68,
            Face = v69
        }
        local v76 = {
            Part = v74.Parent,
            TextureType = v68,
            Face = v69
        }
        for v77, v78 in pairs(v71) do
            v75[v77] = v74[v77]
            v76[v77] = v78
        end
        local Before = HistoryRecord.Before
        table.insert(Before, v75)
        local After = HistoryRecord.After
        table.insert(After, v76)
    end
    RegisterChange()
end

function AddTextures(v79, v80) -- line 504
    local v81 = {}
    for v82, v83 in pairs(Selection.Parts) do
        local v84
        for v85, v86 in pairs(v83:GetChildren()) do
            if v86.ClassName == v79 and v86.Face == v80 then
                v84 = true
            end
        end
        if not v84 then
            local v87 = {
                Part = v83,
                TextureType = v79,
                Face = v80
            }
            table.insert(v81, v87)
        end
    end
    local v88 = {
        Textures = Core.SyncAPI:Invoke("CreateTextures", v81),
        Selection = Selection.Items,
        Unapply = function(v89) -- Unapply | line 535
            Selection.Replace(v89.Selection)
            Core.SyncAPI:Invoke("Remove", v89.Textures)
        end,
        Apply = function(v90) -- Apply | line 546
            Core.SyncAPI:Invoke("UndoRemove", v90.Textures)
            Selection.Replace(v90.Selection)
        end
    }
    Core.History.Add(v88)
end

function RemoveTextures(v91, v92) -- line 564
    local v93 = GetTextures(v91, v92)
    local v94 = {
        Textures = v93,
        Selection = Selection.Items,
        Unapply = function(v95) -- Unapply | line 574
            Core.SyncAPI:Invoke("UndoRemove", v95.Textures)
            Selection.Replace(v95.Selection)
        end,
        Apply = function(v96) -- Apply | line 585
            Selection.Replace(v96.Selection)
            Core.SyncAPI:Invoke("Remove", v96.Textures)
        end
    }
    Core.SyncAPI:Invoke("Remove", v93)
    Core.History.Add(v94)
end

function TrackChange() -- line 606
    HistoryRecord = {
        Before = {},
        After = {},
        Selection = Selection.Items,
        Unapply = function(v97) -- Unapply | line 614
            Selection.Replace(v97.Selection)
            Core.SyncAPI:Invoke("SyncTexture", v97.Before)
        end,
        Apply = function(v98) -- Apply | line 625
            Selection.Replace(v98.Selection)
            Core.SyncAPI:Invoke("SyncTexture", v98.After)
        end
    }
end

function RegisterChange() -- line 640
    if not HistoryRecord then
        return
    end
    Core.SyncAPI:Invoke("SyncTexture", HistoryRecord.After)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

return v5
