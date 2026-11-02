-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = getfenv(0)

Tool = script.Parent
Plugin = Tool.Parent:IsA("Plugin") and Tool.Parent or nil

if Plugin then
    Mode = "Plugin"
else
    Mode = "Tool"
end
local Loaded = Tool:WaitForChild("Loaded")
while not Loaded.Value do
    Loaded.Changed:Wait()
end
Security = require(script.Security)
History = require(script.History)
Selection = require(script.Selection)
Targeting = require(script.Targeting)
Region = require(Tool.Libraries.Region)
Signal = require(Tool.Libraries.Signal)
Support = require(Tool.Libraries.SupportLibrary)
Try = require(Tool.Libraries.Try)
Make = require(Tool.Libraries.Make)

local v2 = require(Tool.Vendor:WaitForChild("Roact"))
local v3 = require(Tool.Libraries:WaitForChild("Maid"))
local v4 = require(Tool.Libraries:WaitForChild("Cryo"))
Support.ImportServices()
SyncAPI = Tool.SyncAPI
Player = Players.LocalPlayer

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

Assets = require(Tool.Assets)
ToolChanged = Signal.new()

function EquipTool(v5) -- line 43
    if CurrentTool and CurrentTool.Equipped then
        CurrentTool:Unequip()
        CurrentTool.Equipped = false
    end
    CurrentTool = v5
    CurrentTool.Equipped = true
    ToolChanged:Fire(v5)
    v5:Equip()
end

function RecolorHandle(v6) -- line 64
    SyncAPI:Invoke("RecolorHandle", v6)
end

ToolChanged:Connect(function(v7) -- line 69
    coroutine.wrap(RecolorHandle)(v7.Color)
    coroutine.wrap(Selection.RecolorOutlines)(v7.Color)
end)
Hotkeys = {}

function AssignHotkey(v8, v9) -- line 77
    local v10
    if type(v8) == "userdata" then
        v10 = { v8 }
    elseif type(v8) == "string" then
        v10 = { Enum.KeyCode[v8] }
    elseif type(v8) == "table" then
        v10 = v8
        for v11, v12 in ipairs(v8) do
            if type(v12) == "string" then
                v8[v11] = Enum.KeyCode[v12]
            end
            v10 = v8
        end
    else
        v10 = v8
    end
    local v13 = Hotkeys
    local v14 = {
        Keys = v10,
        Callback = v9
    }
    table.insert(v13, v14)
end

function EnableHotkeys() -- line 102
    Connections.Hotkeys = Support.AddUserInputListener("Began", "Keyboard", false, function(v15) -- line 106
        local KeyCode = Support.GetListMembers(UserInputService:GetKeysPressed(), "KeyCode")
        local v16 = {}
        local v17 = Support.FlipTable({ "LeftAlt", "W", "S", "A", "D", "Space" })
        for v18, v19 in ipairs(KeyCode) do
            if not v17[v19.Name] then
                table.insert(v16, v19)
            end
        end
        local v20 = #v16
        table.sort(Hotkeys, function(v21, v22) -- line 122
            local v23 = #v21.Keys
            if #v22.Keys < v23 then
                return true
            end
        end)
        for v24, v25 in ipairs(Hotkeys) do
            if v20 == #v25.Keys then
                local v26 = Support.FlipTable(v25.Keys)
                local v27 = 0
                for v28, v29 in pairs(v16) do
                    if v26[v29] then
                        v27 += 1
                    end
                end
                if v27 == v20 then
                    v25.Callback()
                    return
                end
            end
        end
    end)
end

Enabling = Signal.new()
Disabling = Signal.new()
Enabled = Signal.new()
Disabled = Signal.new()

function Enable(v30) -- line 160 | captures: v1, v2, RunService
    if not (not IsEnabled or IsDisabling) or IsEnabling then
        return
    end
    if IsDisabling then
        Disabled:Wait()
        return Enable(v30)
    end
    IsEnabling = true
    Enabling:Fire()
    getfenv(0).Mouse = v30
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    if Mode == "Tool" then
        coroutine.resume(coroutine.create(function() -- line 184
            SyncAPI:Invoke("SetMouseLockEnabled", false)
        end))
    end
    while not UI do
        wait(0.1)
    end
    UI.Parent = UIContainer
    if not v1.StartupNotificationsDisplayed then
        local v31 = require(Tool:WaitForChild("UI"):WaitForChild("Notifications"))
        local v32 = v2.createElement(v31, { Core = v1 })
        v2.mount(v32, UI, "Notifications")
        v1.StartupNotificationsDisplayed = true
    end
    EnableHotkeys()
    Targeting:EnableTargeting()
    Selection.EnableOutlines()
    Selection.EnableMultiselectionHotkeys()
    if Mode == "Plugin" then
        local v33
        Connections.StudioSelectionListener = SelectionService.SelectionChanged:Connect(function() -- line 216 | captures: v33, RunService
            local v34 = {}
            v33 = v34
            RunService.Heartbeat:Wait()
            if v33 == v34 then
                Selection.Replace(SelectionService:Get(), false)
            end
        end)
    end
    EquipTool(CurrentTool or require(Tool.Tools.Move))
    IsEnabled = true
    IsEnabling = false
    Enabled:Fire()
end

function Disable() -- line 238
    if not (IsEnabled or IsEnabling) or IsDisabling then
        return
    end
    if IsEnabling then
        Enabled:Wait()
        return Disable()
    end
    IsDisabling = true
    Disabling:Fire()
    if Mode == "Tool" then
        coroutine.resume(coroutine.create(function() -- line 256
            SyncAPI:Invoke("SetMouseLockEnabled", true)
        end))
    end
    if UI then
        UI.Parent = script
    end
    if CurrentTool then
        CurrentTool:Unequip()
        CurrentTool.Equipped = false
    end
    ClearConnections()
    IsEnabled = false
    IsDisabling = false
    Disabled:Fire()
end

Connections = {}

function ClearConnections() -- line 286
    for v35, v36 in pairs(Connections) do
        v36:Disconnect()
        Connections[v35] = nil
    end
end

function InitializeUI() -- line 294 | captures: v1, v2, v3, v4
    if UI then
        return
    end
    UI = Instance.new("ScreenGui")
    UI.Name = "Building Tools by F3X (UI)"
    local v37 = {}
    local v38 = require(Tool:WaitForChild("UI"):WaitForChild("Dock"))
    local v39 = v2.createElement(v38, {
        Core = v1,
        Tools = v37
    })
    local Dock = v2.mount(v39, UI, "Dock")

    local function AddToolButton(v40, v41, v42) -- line 316 | captures: v37, v38, Dock, v1, v2, v4
        local v43 = {
            IconAssetId = v40,
            HotkeyLabel = v41,
            Tool = v42
        }
        table.insert(v37, v43)
        v2.update(Dock, v2.createElement(v38, {
            Core = v1,
            Tools = v4.List.join(v37)
        }))
    end

    v1.AddToolButton = AddToolButton
    UIMaid = v3.new()
    Tool.AncestryChanged:Connect(function(v44, v45) -- line 333
        if v45 == nil then
            UIMaid:Destroy()
        end
    end)
end

local UI_2 = Tool:WaitForChild("UI")
local v46 = require(UI_2:WaitForChild("Explorer"))

v1.ExplorerVisibilityChanged = Signal.new()
v1.ExplorerVisible = false

function ToggleExplorer() -- line 345 | captures: v1
    if v1.ExplorerVisible then
        CloseExplorer()
    else
        OpenExplorer()
    end
end

function OpenExplorer() -- line 353 | captures: v1, v2, v46
    if ExplorerHandle then
        return
    end
    Explorer = v2.createElement(v46, {
        Core = getfenv(0),
        Close = CloseExplorer,
        Scope = Targeting.Scope
    })
    ExplorerHandle = v2.mount(Explorer, UI, "Explorer")
    v1.ExplorerVisible = true
    UIMaid.Explorer = Support.Call(v2.unmount, ExplorerHandle)
    UIMaid.ExplorerScope = Targeting.ScopeChanged:Connect(function(v47) -- line 373 | captures: v2, v46
        local v48 = Support.Merge({}, Explorer.props, { Scope = v47 })
        local v49 = v2.createElement(v46, v48)
        ExplorerHandle = v2.update(ExplorerHandle, v49)
    end)
    v1.ExplorerVisibilityChanged:Fire()
end

function CloseExplorer() -- line 383 | captures: v1
    UIMaid.Explorer = nil
    UIMaid.ExplorerScope = nil
    ExplorerHandle = nil
    v1.ExplorerVisible = false
    v1.ExplorerVisibilityChanged:Fire()
end

coroutine.wrap(function() -- line 396 | captures: v2, UI_2
    Enabled:Wait()
    local v50 = require(UI_2:WaitForChild("ScopeHUD"))
    local v51 = v2.createElement(v50, { Core = getfenv(0) })
    v2.mount(v51, UI, "ScopeHUD")
end)()
AssignHotkey({ "LeftShift", "H" }, ToggleExplorer)
AssignHotkey({ "RightShift", "H" }, ToggleExplorer)

if Mode == "Plugin" then
    UIContainer = CoreGui
    PluginButton = Plugin:CreateToolbar("Building Tools by F3X"):CreateButton("Building Tools by F3X", "Building Tools by F3X", Assets.PluginIcon)
    PluginButton.Click:Connect(function() -- line 427
        PluginEnabled = not PluginEnabled
        PluginButton:SetActive(PluginEnabled)
        if PluginEnabled then
            Plugin:Activate(true)
            Enable(Plugin:GetMouse())
        else
            Disable()
        end
    end)
    Plugin.Deactivation:Connect(Disable)
    Selection.Changed:Connect(function() -- line 444
        SelectionService:Set(Selection.Items)
    end)
    Enabling:Connect(function() -- line 449
        Selection.Replace(SelectionService:Get())
    end)
    History.Changed:Connect(function() -- line 454
        ChangeHistoryService:SetWaypoint("Building Tools by F3X")
    end)
    Plugin:CreatePluginAction("F3X/ToggleBuildingTools", "Toggle Building Tools", "Toggles the Building Tools by F3X plugin.", Assets.PluginIcon, true).Triggered:Connect(function() -- line 466
        PluginEnabled = not PluginEnabled
        PluginButton:SetActive(PluginEnabled)
        if PluginEnabled then
            Plugin:Activate(true)
            Enable(Plugin:GetMouse())
        else
            Disable()
        end
    end)
elseif Mode == "Tool" then
    UIContainer = Player:WaitForChild("PlayerGui")
    Tool.Equipped:Connect(Enable)
    Tool.Unequipped:Connect(Disable)
    if not Tool.Parent then
        Disable()
    end
    Tool.AncestryChanged:Connect(function(v52, v53) -- line 494
        if not (v53 and (v53:IsA("Backpack") or v53:IsA("Model") and Players:GetPlayerFromCharacter(v53))) then
            Disable()
        end
    end)
end
AssignHotkey({ "LeftShift", "Z" }, History.Undo)
AssignHotkey({ "RightShift", "Z" }, History.Undo)
AssignHotkey({ "LeftShift", "Y" }, History.Redo)
AssignHotkey({ "RightShift", "Y" }, History.Redo)

if Mode == "Tool" then
    AssignHotkey({ "LeftControl", "Z" }, History.Undo)
    AssignHotkey({ "RightControl", "Z" }, History.Undo)
    AssignHotkey({ "LeftControl", "Y" }, History.Redo)
    AssignHotkey({ "RightControl", "Y" }, History.Redo)
end

local function GetDepthFromAncestor(v54, v55) -- line 518
    local v56 = v54
    local v57 = 0
    while v56 ~= v55 do
        v57 += 1
        v56 = v56.Parent
    end
    return v57
end

local function GetHighestParent(v58) -- line 533 | captures: GetDepthFromAncestor
    local v59, v60
    for v61, v62 in ipairs(v58) do
        local v63 = GetDepthFromAncestor(v62, game)
        if v60 then
            if v63 < v60 then
                v59 = v62
                v60 = v63
            end
        else
            v59 = v62
            v60 = v63
        end
    end
    return v59 and v59.Parent or nil
end

function CloneSelection() -- line 549 | captures: CollectionService, GetHighestParent
    if #Selection.Items == 0 then
        return
    end
    local v64, v65, v66 = SyncAPI:Invoke("Clone", Selection.Items, GetHighestParent(Selection.Items))
    local v67 = v64
    if v64 == nil then
        v64 = {}
        v67 = v64
        for v68, v69 in CollectionService:GetTagged("BTStreamingClone") do
            if v69:GetAttribute("BTStreamingCloneID") == v65 then
                table.insert(v64, v69)
            end
        end
        if #v64 < v66 then
            local v70 = coroutine.running()
            local v71 = task.delay(3, function() -- line 577 | captures: v67, v66, v70
                warn((("[Building Tools by F3X] Cloning operation only received %*/%* items after %* seconds, ignoring rest"):format(#v67, v66, 3)))
                coroutine.resume(v70)
            end)
            local v72 = CollectionService:GetInstanceAddedSignal("BTStreamingClone"):Connect(function(v73) -- line 583 | captures: v67, v65, v66, v70, v71
                if v73:GetAttribute("BTStreamingCloneID") ~= v65 then
                    return
                end
                local v74 = v67
                table.insert(v74, v73)
                if #v67 == v66 then
                    task.cancel(v71)
                    coroutine.resume(v70)
                end
            end)
            coroutine.yield()
            v72:Disconnect()
        end
    end
    local v75 = {
        Clones = v67,
        Unapply = function(v76) -- Unapply | line 605
            Selection.Remove(v76.Clones, false)
            SyncAPI:Invoke("Remove", v76.Clones)
        end,
        Apply = function(v77) -- Apply | line 616
            SyncAPI:Invoke("UndoRemove", v77.Clones)
            Selection.Replace(v77.Clones)
        end
    }
    History.Add(v75)
    Selection.Replace(v67)
    coroutine.wrap(Selection.FlashOutlines)()
end

function DeleteSelection() -- line 640
    local v78 = {
        Parts = Support.CloneTable(Selection.Items),
        Unapply = function(v79) -- Unapply | line 647
            SyncAPI:Invoke("UndoRemove", v79.Parts)
            Selection.Replace(v79.Parts)
        end,
        Apply = function(v80) -- Apply | line 658
            Selection.Remove(v80.Parts, false)
            SyncAPI:Invoke("Remove", v80.Parts)
        end
    }
    Selection.Remove(v78.Parts, false)
    SyncAPI:Invoke("Remove", v78.Parts)
    History.Add(v78)
end

AssignHotkey({ "LeftShift", "C" }, CloneSelection)
AssignHotkey({ "RightShift", "C" }, CloneSelection)
AssignHotkey({ "LeftShift", "X" }, DeleteSelection)
AssignHotkey({ "RightShift", "X" }, DeleteSelection)

if Mode == "Tool" then
    AssignHotkey({ "LeftControl", "C" }, CloneSelection)
    AssignHotkey({ "RightControl", "C" }, CloneSelection)
    AssignHotkey({ "LeftControl", "X" }, DeleteSelection)
    AssignHotkey({ "RightControl", "X" }, DeleteSelection)
end
AssignHotkey({ "LeftShift", "K" }, Targeting.PrismSelect)
AssignHotkey({ "RightShift", "K" }, Targeting.PrismSelect)

if Mode == "Tool" then
    AssignHotkey({ "LeftControl", "K" }, Targeting.PrismSelect)
    AssignHotkey({ "RightControl", "K" }, Targeting.PrismSelect)
end
AssignHotkey({ "LeftBracket" }, Support.Call(Targeting.SelectSiblings, false, true))
AssignHotkey({ "LeftShift", "LeftBracket" }, Support.Call(Targeting.SelectSiblings, false, false))
AssignHotkey({ "RightShift", "LeftBracket" }, Support.Call(Targeting.SelectSiblings, false, false))
AssignHotkey({ "LeftShift", "R" }, Support.Call(Selection.Clear, true))
AssignHotkey({ "RightShift", "R" }, Support.Call(Selection.Clear, true))

if Mode == "Tool" then
    AssignHotkey({ "LeftControl", "LeftBracket" }, Support.Call(Targeting.SelectSiblings, false, false))
    AssignHotkey({ "RightControl", "LeftBracket" }, Support.Call(Targeting.SelectSiblings, false, false))
    AssignHotkey({ "LeftControl", "R" }, Support.Call(Selection.Clear, true))
    AssignHotkey({ "RightControl", "R" }, Support.Call(Selection.Clear, true))
end

function GroupSelection(v81) -- line 725 | captures: GetHighestParent
    local v82 = {
        Items = Support.CloneTable(Selection.Items),
        CurrentParents = Support.GetListMembers(Selection.Items, "Parent")
    }

    function v82.Unapply(v83) -- line 734
        SyncAPI:Invoke("SetParent", v83.Items, v83.CurrentParents)
        SyncAPI:Invoke("Remove", { v83.NewParent })
        Selection.Replace(v83.Items)
    end

    function v82.Apply(v84) -- line 740
        SyncAPI:Invoke("UndoRemove", { v84.NewParent })
        SyncAPI:Invoke("SetParent", v84.Items, v84.NewParent)
        Selection.Replace({ v84.NewParent })
    end

    v82.NewParent = SyncAPI:Invoke("CreateGroup", v81, GetHighestParent(v82.Items), v82.Items)
    History.Add(v82)
    Selection.Replace({ v82.NewParent })
end

function UngroupSelection() -- line 760
    local v85 = { Selection = Selection.Items }

    function v85.Unapply(v86) -- line 768
        SyncAPI:Invoke("UndoRemove", v86.Groups)
        for v87, v88 in ipairs(v86.GroupChildren) do
            local resume = coroutine.resume
            local create = coroutine.create
            local v89 = v88
            local v90 = v87
            resume(create(function() -- line 773 | captures: v86, v89, v90
                SyncAPI:Invoke("SetParent", v89, v86.Groups[v90])
            end))
        end
        Selection.Replace(v86.Selection)
    end

    function v85.Apply(v91) -- line 782
        v91.Groups = {}
        for v92, v93 in ipairs(v91.Selection) do
            if v93:IsA("Model") or v93:IsA("Folder") then
                v91.Groups[#v91.Groups + 1] = v93
            end
        end
        v91.GroupParents = Support.GetListMembers(v91.Groups, "Parent")
        v91.GroupChildren = SyncAPI:Invoke("Ungroup", v91.Groups)
        local v94 = Support.CloneTable(v91.Selection)
        for v95, v96 in pairs(v91.GroupChildren) do
            for v97, v98 in ipairs(v96) do
                v94[#v94 + 1] = v98
            end
        end
        Selection.Replace(v94)
    end

    v85:Apply()
    History.Add(v85)
end

AssignHotkey({ "LeftShift", "G" }, Support.Call(GroupSelection, "Model"))
AssignHotkey({ "RightShift", "G" }, Support.Call(GroupSelection, "Model"))
AssignHotkey({ "LeftShift", "F" }, Support.Call(GroupSelection, "Folder"))
AssignHotkey({ "RightShift", "F" }, Support.Call(GroupSelection, "Folder"))
AssignHotkey({ "LeftShift", "U" }, UngroupSelection)
AssignHotkey({ "RightShift", "U" }, UngroupSelection)

function GetPartsFromSelection(v99) -- line 825
    local v100 = {}
    for v101, v102 in pairs(v99) do
        if v102:IsA("BasePart") then
            v100[#v100 + 1] = v102
        else
            for v103, v104 in pairs(v102:GetDescendants()) do
                if v104:IsA("BasePart") then
                    v100[#v100 + 1] = v104
                end
            end
        end
    end
    return v100
end

function IsSelectable(v105) -- line 847
    for v106, v107 in pairs(v105) do
        if v107 and v107.Parent then
            if v107:IsA("BasePart") and v107.Locked then
                return false
            end
            if not Security.IsItemAllowed(v107, Player) then
                return false
            end
        else
            return false
        end
    end
    local v108 = GetPartsFromSelection(v105)
    return not Security.ArePartsViolatingAreas(v108, Player, true)
end

function ExportSelection() -- line 875 | captures: v2
    if #Selection.Items == 0 then
        return
    end
    local v109
    local v110 = require(Tool:WaitForChild("UI"):WaitForChild("ExportDialog"))

    local function v111() -- line 886 | captures: v109, v2
        v109 = v2.unmount(v109)
    end

    local v112 = v2.createElement(v110, {
        Text = "Uploading selection...",
        OnDismiss = v111
    })
    v109 = v2.mount(v112, UI, "ExportDialog")
    Try(SyncAPI.Invoke, SyncAPI, "Export", Selection.Items):Then(function(v113) -- line 899 | captures: v109, v110, v111, v2
        v2.update(v109, v2.createElement(v110, {
            Text = "Your creation's ID:<font size=\"5\"><br /></font>\n" .. "<font face=\"GothamBlack\" size=\"18\">" .. v113 .. "</font><font size=\"6\"><br /></font>\n" .. "<font face=\"Gotham\" size=\"10\">Use the code above to import your creation using the plugin in Studio.</font>",
            OnDismiss = v111
        }))
        print("[Building Tools by F3X] Uploaded Export:", v113)
    end):Catch("Http requests are not enabled", function() -- line 910 | captures: v109, v110, v111, v2
        v2.update(v109, v2.createElement(v110, {
            Text = "Please enable HTTP requests.",
            OnDismiss = v111
        }))
    end):Catch("Export failed due to server-side error", function() -- line 916 | captures: v109, v110, v111, v2
        v2.update(v109, v2.createElement(v110, {
            Text = "An error occurred \226\128\148 please try again.",
            OnDismiss = v111
        }))
    end):Catch("Post data too large", function() -- line 922 | captures: v109, v110, v111, v2
        v2.update(v109, v2.createElement(v110, {
            Text = "Try splitting up your build.",
            OnDismiss = v111
        }))
    end):Catch(function(v114, v115, v116) -- line 928 | captures: v109, v110, v111, v2
        v2.update(v109, v2.createElement(v110, {
            Text = "An unknown error occurred \226\128\148 please try again.",
            OnDismiss = v111
        }))
        warn("\226\157\140 [Building Tools by F3X] Failed to export selection", "\n\nError:\n", v114, "\n\nStack:\n", v115)
    end)
end

AssignHotkey({ "LeftShift", "P" }, ExportSelection)
AssignHotkey({ "RightShift", "P" }, ExportSelection)

if Mode == "Tool" then
    AssignHotkey({ "LeftControl", "P" }, ExportSelection)
    AssignHotkey({ "RightControl", "P" }, ExportSelection)
end

function IsVersionOutdated() -- line 948
    local v117, v118, v119 = MarketplaceService:GetProductInfo(142785488, Enum.InfoType.Asset).Description:match("%[Version: ([0-9]+)%.([0-9]+)%.([0-9]+)%]")
    local v120, v121, v122 = Tool.Version.Value:match("([0-9]+)%.([0-9]+)%.([0-9]+)")
    local v123 = tonumber(v117)
    local v124 = tonumber(v118)
    local v125 = tonumber(v119)
    local v126 = tonumber(v120)
    local v127 = tonumber(v121)
    local v128 = tonumber(v122)
    if v126 < v123 then
        return true
    end
    if v123 == v126 then
        if v127 < v124 then
            return true
        end
        if v124 == v127 then
            return v128 < v125
        end
    end
    return false
end

function ToggleSwitch(v129, v130) -- line 978
    for v131, v132 in pairs(v130:GetChildren()) do
        if v132.Name ~= "Label" then
            v132.SelectedIndicator.BackgroundTransparency = 1
            v132.Background.Image = Assets.LightSlantedRectangle
        end
    end
    if not v129 then
        return
    end
    local v133 = v130[v129]
    v133.SelectedIndicator.BackgroundTransparency = 0
    v133.Background.Image = Assets.DarkSlantedRectangle
end

local GetConnectedParts = Instance.new("Part").GetConnectedParts
local GetChildren = script.GetChildren

function GetPartJoints(v134, v135) -- line 1012 | captures: GetConnectedParts
    local v136 = {}
    for v137, v138 in pairs(SearchJoints(v134, v134, v135)) do
        v136[v137] = v138
    end
    for v139, v140 in pairs(GetConnectedParts(v134)) do
        for v141, v142 in pairs(SearchJoints(v140, v134, v135)) do
            v136[v141] = v142
        end
    end
    return v136
end

local v143 = Support.FlipTable({ "Weld", "ManualWeld", "ManualGlue", "Motor", "Motor6D" })

function SearchJoints(v144, v145, v146) -- line 1037 | captures: GetChildren, v143
    local v147 = {}
    for v148, v149 in pairs(GetChildren(v144)) do
        if v143[v149.ClassName] and v146[v149.Part0] and v146[v149.Part1] then
            v147[v149] = v149.Parent
        end
    end
    return v147
end

function RestoreJoints(v150) -- line 1061
    for v151, v152 in pairs(v150) do
        v151.Parent = v152
    end
end

function PreserveJoints(v153, v154) -- line 1071
    local v155 = GetPartJoints(v153, v154)
    for v156 in pairs(v155) do
        v156.Parent = nil
    end
    return v155
end

InitializeUI()
return getfenv(0)
