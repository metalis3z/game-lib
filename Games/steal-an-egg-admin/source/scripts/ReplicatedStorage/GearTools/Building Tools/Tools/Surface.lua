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
    Name = "Surface Tool",
    Surface = "All",
    CurrentSurfaceType = nil,
    Color = BrickColor.new("Bright violet"),
    OnSurfaceChanged = v4.new(),
    OnSurfaceTypeChanged = v4.new()
}

v5.ManualText = "<font face=\"GothamBlack\" size=\"16\">Surface Tool  \240\159\155\160</font>\nLets you change the surfaces of parts.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Click a part's surface to select it quickly."

local v6 = {}

function v5.Equip() -- line 43 | captures: v5
    ShowUI()
    EnableSurfaceSelection()
    SetSurface(v5.Surface)
end

local function Unequip() -- line 55
    HideUI()
    ClearConnections()
end

v5.Unequip = Unequip

function ClearConnections() -- line 64 | captures: v6
    for v7, v8 in pairs(v6) do
        v8:Disconnect()
        v6[v7] = nil
    end
end

function ShowUI() -- line 74 | captures: v1, v2, v3, v5
    if v5.UI then
        v5.UI.Visible = true
    else
        v5.UI = Core.Tool.Interfaces.BTSurfaceToolGUI:Clone()
        v5.UI.Parent = Core.UI
        v5.UI.Visible = true
        local v9 = { "All", "Top", "Bottom", "Front", "Back", "Left", "Right" }

        local function BuildSurfaceDropdown() -- line 108 | captures: v9, v2, v3, v5
            return v2.createElement(v3, {
                MaxRows = 4,
                Position = UDim2.new(0, 30, 0, 0),
                Size = UDim2.new(0, 72, 0, 25),
                Options = v9,
                CurrentOption = v5.Surface,
                OnOptionSelected = function(v10) -- OnOptionSelected | line 115
                    SetSurface(v10)
                end
            })
        end

        local Dropdown = v2.mount(BuildSurfaceDropdown(), v5.UI.SideOption, "Dropdown")
        v5.OnSurfaceChanged:Connect(function() -- line 123 | captures: BuildSurfaceDropdown, Dropdown, v2
            v2.update(Dropdown, BuildSurfaceDropdown())
        end)
        local v11 = { "Smooth", "Studs", "Inlet", "Weld", "Hinge", "Motor", "Universal", "Glue" }

        local function BuildSurfaceTypeDropdown() -- line 138 | captures: v11, v2, v3, v5
            local createElement = v2.createElement
            local v12 = {
                MaxRows = 4,
                Position = UDim2.new(0, 30, 0, 0),
                Size = UDim2.new(0, 91, 0, 25),
                Options = v11
            }
            v12.CurrentOption = v5.CurrentSurfaceType and v5.CurrentSurfaceType.Name

            function v12.OnOptionSelected(v13) -- line 145
                SetSurfaceType(Enum.SurfaceType[v13])
            end

            return createElement(v3, v12)
        end

        local Dropdown_2 = v2.mount(BuildSurfaceTypeDropdown(), v5.UI.TypeOption, "Dropdown")
        v5.OnSurfaceTypeChanged:Connect(function() -- line 153 | captures: BuildSurfaceTypeDropdown, Dropdown_2, v2
            v2.update(Dropdown_2, BuildSurfaceTypeDropdown())
        end)
        local Signature = v5.UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v5.ManualText, v5.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function HideUI() -- line 166 | captures: v5
    if v5.UI then
        v5.UI.Visible = false
        UIUpdater:Stop()
    end
end

function GetSurfaceTypeDisplayName(v14) -- line 182
    if v14 == Enum.SurfaceType.SteppingMotor then
        return "Stepping Motor"
    end
    if v14 == Enum.SurfaceType.SmoothNoOutlines then
        return "No Outline"
    end
    return v14.Name
end

function UpdateUI() -- line 201 | captures: v5
    if v5.UI then
        if #Selection.Parts == 0 then
            if v5.CurrentSurfaceType ~= "" then
                v5.CurrentSurfaceType = ""
                v5.OnSurfaceTypeChanged:Fire("")
            end
        else
            local v15 = {}
            for v16, v17 in pairs(Selection.Parts) do
                if v5.Surface == "All" then
                    local TopSurface = v17.TopSurface
                    table.insert(v15, TopSurface)
                    local BottomSurface = v17.BottomSurface
                    table.insert(v15, BottomSurface)
                    local FrontSurface = v17.FrontSurface
                    table.insert(v15, FrontSurface)
                    local BackSurface = v17.BackSurface
                    table.insert(v15, BackSurface)
                    local LeftSurface = v17.LeftSurface
                    table.insert(v15, LeftSurface)
                    local RightSurface = v17.RightSurface
                    table.insert(v15, RightSurface)
                else
                    local v18 = v17[v5.Surface .. "Surface"]
                    table.insert(v15, v18)
                end
            end
            local v19 = Support.IdentifyCommonItem(v15)
            if v5.CurrentSurfaceType ~= v19 then
                v5.CurrentSurfaceType = v19
                v5.OnSurfaceTypeChanged:Fire(v19)
            end
        end
    end
end

function SetSurface(v20) -- line 254 | captures: v5
    v5.Surface = v20
    v5.OnSurfaceChanged:Fire(v20)
end

function SetSurfaceType(v21) -- line 263 | captures: v5
    if not v5.Surface then
        return
    end
    TrackChange()
    for v22, v23 in pairs(Selection.Parts) do
        if v5.Surface == "All" then
            v23.TopSurface = v21
            v23.BottomSurface = v21
            v23.FrontSurface = v21
            v23.BackSurface = v21
            v23.LeftSurface = v21
            v23.RightSurface = v21
        else
            v23[v5.Surface .. "Surface"] = v21
        end
    end
    RegisterChange()
end

function EnableSurfaceSelection() -- line 298 | captures: v6
    v6.SurfaceSelection = Core.Mouse.Button1Down:Connect(function() -- line 302
        local v24, v25 = Core.Targeting:UpdateTarget()
        if Selection.IsSelected(v25) then
            SetSurface(Core.Mouse.TargetSurface.Name)
        end
    end)
end

function TrackChange() -- line 314 | captures: v5
    HistoryRecord = {
        Parts = Support.CloneTable(Selection.Parts),
        BeforeSurfaces = {},
        AfterSurfaces = {},
        Selection = Selection.Items,
        Unapply = function(v26) -- Unapply | line 323
            Selection.Replace(v26.Selection)
            local v27 = {}
            for v28, v29 in pairs(v26.Parts) do
                local v30 = {
                    Part = v29,
                    Surfaces = v26.BeforeSurfaces[v29]
                }
                table.insert(v27, v30)
            end
            Core.SyncAPI:Invoke("SyncSurface", v27)
        end,
        Apply = function(v31) -- Apply | line 340
            Selection.Replace(v31.Selection)
            local v32 = {}
            for v33, v34 in pairs(v31.Parts) do
                local v35 = {
                    Part = v34,
                    Surfaces = v31.AfterSurfaces[v34]
                }
                table.insert(v32, v35)
            end
            Core.SyncAPI:Invoke("SyncSurface", v32)
        end
    }
    for v36, v37 in pairs(HistoryRecord.Parts) do
        HistoryRecord.BeforeSurfaces[v37] = {}
        local v38 = HistoryRecord.BeforeSurfaces[v37]
        if v5.Surface == "All" then
            v38.Top = v37.TopSurface
            v38.Bottom = v37.BottomSurface
            v38.Front = v37.FrontSurface
            v38.Back = v37.BackSurface
            v38.Left = v37.LeftSurface
            v38.Right = v37.RightSurface
        else
            v38[v5.Surface] = v37[v5.Surface .. "Surface"]
        end
    end
end

function RegisterChange() -- line 384 | captures: v5
    if not HistoryRecord then
        return
    end
    local v39 = {}
    for v40, v41 in pairs(HistoryRecord.Parts) do
        HistoryRecord.AfterSurfaces[v41] = {}
        local v42 = HistoryRecord.AfterSurfaces[v41]
        if v5.Surface == "All" then
            v42.Top = v41.TopSurface
            v42.Bottom = v41.BottomSurface
            v42.Front = v41.FrontSurface
            v42.Back = v41.BackSurface
            v42.Left = v41.LeftSurface
            v42.Right = v41.RightSurface
        else
            v42[v5.Surface] = v41[v5.Surface .. "Surface"]
        end
        local v43 = {
            Part = v41,
            Surfaces = v42
        }
        table.insert(v39, v43)
    end
    Core.SyncAPI:Invoke("SyncSurface", v39)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

return v5
