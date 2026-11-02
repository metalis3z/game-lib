-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local v1 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v2 = {
    Name = "Weld Tool",
    Color = BrickColor.new("Really black")
}

v2.ManualText = "<font face=\"GothamBlack\" size=\"16\">Weld Tool  \240\159\155\160</font>\nAllows you to weld parts to hold them together.<font size=\"6\"><br /></font>\n\n<b>NOTE: </b>Welds may break if parts are individually moved."

local v3 = {}

local function Equip() -- line 27
    ShowUI()
    EnableFocusHighlighting()
end

v2.Equip = Equip

local function Unequip() -- line 36
    HideUI()
    ClearConnections()
end

v2.Unequip = Unequip

function ClearConnections() -- line 45 | captures: v3
    for v4, v5 in pairs(v3) do
        v5:Disconnect()
        v3[v4] = nil
    end
end

function ShowUI() -- line 55 | captures: v1, v2
    if UI then
        UI.Visible = true
    else
        UI = Core.Tool.Interfaces.BTWeldToolGUI:Clone()
        UI.Parent = Core.UI
        UI.Visible = true
        UI.Interface.WeldButton.MouseButton1Click:Connect(CreateWelds)
        UI.Interface.BreakWeldsButton.MouseButton1Click:Connect(BreakWelds)
        local Signature = UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v2.ManualText, v2.Color.Color, Signature)
    end
end

function HideUI() -- line 84
    if UI then
        UI.Visible = false
    end
end

local GetConnectedParts = Instance.new("Part").GetConnectedParts
local GetChildren = script.GetChildren

function GetPartWelds(v6) -- line 101 | captures: GetConnectedParts
    local v7 = {}
    for v8 in pairs(SearchWelds(v6, v6)) do
        v7[v8] = true
    end
    for v9, v10 in pairs(GetConnectedParts(v6)) do
        for v11 in pairs(SearchWelds(v10, v6)) do
            v7[v11] = true
        end
    end
    return v7
end

function SearchWelds(v12, v13) -- line 123 | captures: GetChildren
    local v14 = {}
    for v15, v16 in pairs(GetChildren(v12)) do
        if v16.Name == "BTWeld" and v16.ClassName == "Weld" and (v16.Part0 == v13 or v16.Part1 == v13) then
            v14[v16] = true
        end
    end
    return v14
end

function CreateWelds() -- line 147
    local v17, v18
    if Selection.Focus:IsA("BasePart") then
        local Focus = Selection.Focus
        if Focus then
            v17 = Focus
            v18 = true
        elseif Selection.Focus:IsA("Model") then
            local PrimaryPart = Selection.Focus.PrimaryPart
            if PrimaryPart then
                v17 = PrimaryPart
                v18 = true
            else
                v18 = false
            end
        else
            v18 = false
        end
    elseif Selection.Focus:IsA("Model") then
        local PrimaryPart = Selection.Focus.PrimaryPart
        if PrimaryPart then
            v17 = PrimaryPart
            v18 = true
        else
            v18 = false
        end
    else
        v18 = false
    end
    if not v18 then
        v17 = Selection.Focus:FindFirstChildWhichIsA("BasePart", true)
    end
    local v19 = Core.SyncAPI:Invoke("CreateWelds", Selection.Parts, v17)
    local Text = UI.Changes.Text
    local v20 = #v19
    local v21 = if #v19 == 1 then "" else "s"
    Text.Text = ("created %s weld%s"):format(v20, v21)
    local v22 = {
        Welds = v19,
        Unapply = function(v23) -- Unapply | line 165
            Core.SyncAPI:Invoke("RemoveWelds", v23.Welds)
        end,
        Apply = function(v24) -- Apply | line 173
            Core.SyncAPI:Invoke("UndoRemovedWelds", v24.Welds)
        end
    }
    Core.History.Add(v22)
end

function BreakWelds() -- line 188
    local v25 = {}
    for v26, v27 in pairs(Selection.Parts) do
        for v28 in pairs(GetPartWelds(v27)) do
            v25[v28] = true
        end
    end
    local v29 = Support.Keys(v25)
    local v30 = Core.SyncAPI:Invoke("RemoveWelds", v29)
    local Text = UI.Changes.Text
    local v31 = if v30 == 1 then "" else "s"
    Text.Text = ("removed %s weld%s"):format(v30, v31)
    local v32 = {
        Welds = v29,
        Unapply = function(v33) -- Unapply | line 213
            Core.SyncAPI:Invoke("UndoRemovedWelds", v33.Welds)
        end,
        Apply = function(v34) -- Apply | line 221
            Core.SyncAPI:Invoke("RemoveWelds", v34.Welds)
        end
    }
    Core.History.Add(v32)
end

function EnableFocusHighlighting() -- line 236 | captures: v3
    if Core.Mode ~= "Tool" then
        return
    end
    Core.Selection.RecolorOutlines(Core.Selection.Color)
    if Selection.Focus and #Selection.Parts > 1 then
        Core.Selection.RecolorOutline(Selection.Focus, BrickColor.new("Deep orange"))
    end
    v3.FocusHighlighting = Selection.FocusChanged:Connect(function(v35) -- line 253
        Core.Selection.RecolorOutlines(Core.Selection.Color)
        if v35 and #Selection.Parts > 1 then
            Core.Selection.RecolorOutline(v35, BrickColor.new("Deep orange"))
        end
    end)
end

return v2
