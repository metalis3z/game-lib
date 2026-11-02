-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local Vendor = Tool:WaitForChild("Vendor")
local UI = Tool:WaitForChild("UI")
local Libraries = Tool:WaitForChild("Libraries")
local ContextActionService = game:GetService("ContextActionService")
local v1 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))
local v2 = require(Vendor:WaitForChild("Roact"))
local v3 = require(UI:WaitForChild("Dropdown"))
local v4 = require(Libraries:WaitForChild("Signal"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v5 = {
    Name = "New Part Tool",
    Type = "Normal",
    Color = BrickColor.new("Really black"),
    OnTypeChanged = v4.new()
}

v5.ManualText = "<font face=\"GothamBlack\" size=\"16\">New Part Tool  \240\159\155\160</font>\nLets you create new parts.<font size=\"6\"><br /></font>\n\n<b>TIP:</b> Click and drag where you want your part to be."

local v6 = {}

function v5.Equip(v7) -- line 42 | captures: v5
    v7:ShowUI()
    EnableClickCreation()
    v7:SetType(v5.Type)
end

function v5.Unequip(v8) -- line 54 | captures: ContextActionService
    v8:HideUI()
    ClearConnections()
    ContextActionService:UnbindAction("BT: Create part")
end

function ClearConnections() -- line 64 | captures: v6
    for v9, v10 in pairs(v6) do
        v10:Disconnect()
        v6[v9] = nil
    end
end

function v5.ShowUI(v11) -- line 74 | captures: v1, v2, v3, v5
    if v11.UI then
        v11.UI.Visible = true
    else
        v11.UI = Core.Tool.Interfaces.BTNewPartToolGUI:Clone()
        v11.UI.Parent = Core.UI
        v11.UI.Visible = true
        Types = {
            "Normal",
            "Truss",
            "Wedge",
            "Corner",
            "Cylinder",
            "Ball",
            "Seat",
            "Vehicle Seat",
            "Spawn"
        }

        local function BuildTypeDropdown() -- line 107 | captures: v11, v2, v3
            return v2.createElement(v3, {
                MaxRows = 5,
                Position = UDim2.new(0, 70, 0, 0),
                Size = UDim2.new(0, 140, 0, 25),
                Options = Types,
                CurrentOption = v11.Type,
                OnOptionSelected = function(v12) -- OnOptionSelected | line 114 | captures: v11
                    v11:SetType(v12)
                end
            })
        end

        local Dropdown = v2.mount(BuildTypeDropdown(), v11.UI.TypeOption, "Dropdown")
        v11.OnTypeChanged:Connect(function() -- line 122 | captures: BuildTypeDropdown, Dropdown, v2
            v2.update(Dropdown, BuildTypeDropdown())
        end)
        local Signature = v11.UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v5.ManualText, v5.Color.Color, Signature)
    end
end

local function HideUI(v13) -- line 131
    if v13.UI then
        v13.UI.Visible = false
    end
end

v5.HideUI = HideUI

local function SetType(v14, v15) -- line 144
    if v14.Type ~= v15 then
        v14.Type = v15
        v14.OnTypeChanged:Fire(v15)
    end
end

v5.SetType = SetType

function EnableClickCreation() -- line 151 | captures: ContextActionService, v5
    local function CreateAtTarget(v16, v17, v18) -- line 154 | captures: v5
        if v17.Name == "Begin" then
            DragNewParts = true
            Core.Targeting.CancelSelecting()
            CreatePart(v5.Type)
        elseif v17.Name == "End" then
            DragNewParts = nil
        end
    end

    local MouseButton1 = Enum.UserInputType.MouseButton1
    local Touch = Enum.UserInputType.Touch
    ContextActionService:BindAction("BT: Create part", CreateAtTarget, false, MouseButton1, Touch)
end

function CreatePart(v19) -- line 179
    local v20 = Core.SyncAPI:Invoke("CreatePart", v19, CFrame.new(Core.Mouse.Hit.p), Core.Targeting.Scope)
    if not v20 then
        return
    end
    local v21 = {
        Part = v20,
        Unapply = function(v22) -- Unapply | line 193
            Core.SyncAPI:Invoke("Remove", { v22.Part })
        end,
        Apply = function(v23) -- Apply | line 201
            Core.SyncAPI:Invoke("UndoRemove", { v23.Part })
        end
    }
    Core.History.Add(v21)
    Selection.Replace({ v20 })
    local Move = require(Core.Tool.Tools.Move)
    Core.EquipTool(Move)
    if DragNewParts then
        Move.FreeDragging:SetUpDragging(v20)
    end
end

return v5
