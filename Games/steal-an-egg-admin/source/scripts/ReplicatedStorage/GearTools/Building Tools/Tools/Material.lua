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
    Name = "Material Tool",
    CurrentMaterial = nil,
    Color = BrickColor.new("Bright violet"),
    OnMaterialChanged = v4.new()
}

v5.ManualText = "<font face=\"GothamBlack\" size=\"16\">Material Tool  \240\159\155\160</font>\nLets you change the material, transparency, and reflectance of parts."

local v6 = {}

local function Equip(v7) -- line 37
    v7:ShowUI()
end

v5.Equip = Equip

local function Unequip(v8) -- line 45
    v8:HideUI()
    ClearConnections()
end

v5.Unequip = Unequip

function ClearConnections() -- line 54 | captures: v6
    for v9, v10 in pairs(v6) do
        v10:Disconnect()
        v6[v9] = nil
    end
end

local v11 = {}

v11[Enum.Material.SmoothPlastic] = "Smooth Plastic"
v11[Enum.Material.Plastic] = "Plastic"
v11[Enum.Material.Brick] = "Brick"
v11[Enum.Material.Cobblestone] = "Cobblestone"
v11[Enum.Material.Concrete] = "Concrete"
v11[Enum.Material.CorrodedMetal] = "Corroded Metal"
v11[Enum.Material.DiamondPlate] = "Diamond Plate"
v11[Enum.Material.Fabric] = "Fabric"
v11[Enum.Material.Foil] = "Foil"
v11[Enum.Material.ForceField] = "Forcefield"
v11[Enum.Material.Granite] = "Granite"
v11[Enum.Material.Grass] = "Grass"
v11[Enum.Material.Ice] = "Ice"
v11[Enum.Material.Marble] = "Marble"
v11[Enum.Material.Metal] = "Metal"
v11[Enum.Material.Neon] = "Neon"
v11[Enum.Material.Pebble] = "Pebble"
v11[Enum.Material.Sand] = "Sand"
v11[Enum.Material.Slate] = "Slate"
v11[Enum.Material.Wood] = "Wood"
v11[Enum.Material.WoodPlanks] = "Wood Planks"
v11[Enum.Material.Glass] = "Glass"

function v5.ShowUI(v12) -- line 90 | captures: v1, v2, v3, v5, v11
    if v12.UI then
        v12.UI.Visible = true
        local Loop = Support.Loop
        v12.StopUpdatingUI = Loop(0.1, function() -- line 100 | captures: v12
            v12:UpdateUI()
        end)
    else
        v12.UI = Core.Tool.Interfaces.BTMaterialToolGUI:Clone()
        v12.UI.Parent = Core.UI
        v12.UI.Visible = true
        local TextBox = v12.UI.TransparencyOption.Input.TextBox
        local TextBox_2 = v12.UI.ReflectanceOption.Input.TextBox
        local v13 = Support.Values(v11)
        table.sort(v13)

        local function BuildMaterialDropdown() -- line 123 | captures: v12, v13, v2, v3, v11
            local createElement = v2.createElement
            local v14 = {
                MaxRows = 6,
                Position = UDim2.new(0, 50, 0, 0),
                Size = UDim2.new(0, 130, 0, 25),
                Options = v13
            }
            v14.CurrentOption = v12.CurrentMaterial and v12.CurrentMaterial.Name

            function v14.OnOptionSelected(v15) -- line 130 | captures: v11
                SetProperty("Material", Support.FindTableOccurrence(v11, v15))
            end

            return createElement(v3, v14)
        end

        local Dropdown = v2.mount(BuildMaterialDropdown(), v12.UI.MaterialOption, "Dropdown")
        v12.OnMaterialChanged:Connect(function() -- line 138 | captures: BuildMaterialDropdown, Dropdown, v2
            v2.update(Dropdown, BuildMaterialDropdown())
        end)
        SyncInputToProperty("Transparency", TextBox)
        SyncInputToProperty("Reflectance", TextBox_2)
        local Signature = v12.UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v5.ManualText, v5.Color.Color, Signature)
        local Loop = Support.Loop
        v12.StopUpdatingUI = Loop(0.1, function() -- line 151 | captures: v12
            v12:UpdateUI()
        end)
    end
end

local function HideUI(v16) -- line 157
    if v16.UI then
        v16.UI.Visible = false
        v16.StopUpdatingUI()
    end
end

v5.HideUI = HideUI

function SyncInputToProperty(v17, v18) -- line 173
    v18.FocusLost:Connect(function() -- line 177 | captures: v17, v18
        local v19 = SetProperty
        local Text = v18.Text
        v19(v17, (tonumber(Text)))
    end)
end

function SetProperty(v20, v21) -- line 183
    if v21 == nil then
        return
    end
    TrackChange()
    for v22, v23 in pairs(Selection.Parts) do
        local Before = HistoryRecord.Before
        local v24 = { Part = v23 }
        v24[v20] = v23[v20]
        table.insert(Before, v24)
        local After = HistoryRecord.After
        local v25 = { Part = v23 }
        v25[v20] = v21
        table.insert(After, v25)
    end
    RegisterChange()
end

function UpdateDataInputs(v26) -- line 209
    for v27, v28 in pairs(v26) do
        if not v27:IsFocused() then
            v27.Text = tostring(v28)
        end
    end
end

local v29 = {
    EmptySelection = { "SelectNote" },
    Normal = { "MaterialOption", "TransparencyOption", "ReflectanceOption" }
}
local v30 = { "SelectNote", "MaterialOption", "TransparencyOption", "ReflectanceOption" }
local v31

function v5.ChangeLayout(v32, v33) -- line 239 | captures: v31, v30
    if v31 == v33 then
        return
    end
    v31 = v33
    for v34, v35 in pairs(v30) do
        v32.UI[v35].Visible = false
    end
    local v36 = 0
    for v37, v38 in ipairs(v33) do
        local v39 = v32.UI[v38]
        v39.Visible = true
        v39.Position = UDim2.new(0, 0, 0, 20) + UDim2.new(v39.Position.X.Scale, v39.Position.X.Offset, 0, v36 + 10)
        v36 = v36 + 10 + v39.AbsoluteSize.Y
    end
    v32.UI.Size = UDim2.new(0, 200, 0, v36 + 40)
end

function v5.UpdateUI(v40) -- line 285 | captures: v29
    if not v40.UI then
        return
    end
    local TextBox = v40.UI.TransparencyOption.Input.TextBox
    local TextBox_2 = v40.UI.ReflectanceOption.Input.TextBox
    if #Selection.Parts == 0 then
        v40:ChangeLayout(v29.EmptySelection)
    else
        v40:ChangeLayout(v29.Normal)
        local Material = Support.IdentifyCommonProperty(Selection.Parts, "Material")
        local Transparency = Support.IdentifyCommonProperty(Selection.Parts, "Transparency")
        local Reflectance = Support.IdentifyCommonProperty(Selection.Parts, "Reflectance")
        if v40.CurrentMaterial ~= Material then
            v40.CurrentMaterial = Material
            v40.OnMaterialChanged:Fire(Material)
        end
        local v41 = UpdateDataInputs
        local v42 = {}
        v42[TextBox] = Transparency and Support.Round(Transparency, 2) or "*"
        v42[TextBox_2] = Reflectance and Support.Round(Reflectance, 2) or "*"
        v41(v42)
    end
end

function TrackChange() -- line 330
    HistoryRecord = {
        Before = {},
        After = {},
        Selection = Selection.Items,
        Unapply = function(v43) -- Unapply | line 338
            Selection.Replace(v43.Selection)
            Core.SyncAPI:Invoke("SyncMaterial", v43.Before)
        end,
        Apply = function(v44) -- Apply | line 349
            Selection.Replace(v44.Selection)
            Core.SyncAPI:Invoke("SyncMaterial", v44.After)
        end
    }
end

function RegisterChange() -- line 364
    if not HistoryRecord then
        return
    end
    Core.SyncAPI:Invoke("SyncMaterial", HistoryRecord.After)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

return v5
