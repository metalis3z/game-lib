-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
local GUI = require(ReplicatedStorage.Client.GUI)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformSignals = require(ReplicatedStorage.Client.PlatformSignals)
local t = require(ReplicatedStorage.Packages.t)
local v1 = table.freeze({
    ButtonA = Enum.KeyCode.ButtonA,
    ButtonB = Enum.KeyCode.ButtonB,
    ButtonLB = Enum.KeyCode.ButtonL1,
    ButtonLS = Enum.KeyCode.ButtonL3,
    ButtonLT = Enum.KeyCode.ButtonL2,
    ButtonRB = Enum.KeyCode.ButtonR1,
    ButtonRS = Enum.KeyCode.ButtonR3,
    ButtonRT = Enum.KeyCode.ButtonR2,
    ButtonSelect = Enum.KeyCode.ButtonSelect,
    ButtonStart = Enum.KeyCode.ButtonStart,
    ButtonX = Enum.KeyCode.ButtonX,
    ButtonY = Enum.KeyCode.ButtonY,
    DPadDown = Enum.KeyCode.DPadDown,
    DPadLeft = Enum.KeyCode.DPadLeft,
    DPadRight = Enum.KeyCode.DPadRight,
    DPadUp = Enum.KeyCode.DPadUp
})
local v2 = {}
for v3, v4 in v1 do
    v2[v4] = v3
end
table.freeze(v2)
local Value = Enum.ContextActionPriority.High.Value
local Sink = Enum.ContextActionResult.Sink
local Pass = Enum.ContextActionResult.Pass
local ButtonB = Enum.KeyCode.ButtonB
local v5 = table.freeze({
    ActivePets = 900,
    DropHeldEgg = 200,
    GrowingEggs = 900,
    Message = 1000,
    RunButton = 100
})
local v6 = table.freeze({
    BackpackGui = true,
    PhoneVideoUI = true,
    Treadmill = true,
    TreadmillScreenButtonSwapLeft = true,
    TreadmillScreenButtonSwapRight = true,
    TreadmillScreenComments = true,
    TreadmillUI = true
})
local v7 = table.freeze({
    ActivePets = true,
    FreeGift = true,
    GrowingEggs = true,
    Index = true,
    MonsterChestRewards = true,
    PetFuse = true,
    PopupPrompt = true,
    RobuxShop = true,
    Settings = true,
    SpeedShop = true,
    TrailShop = true
})
local v8 = table.freeze({
    PlayStation = "O",
    Xbox = "B"
})
local v9 = {}
local v10 = t.strict(t.string)
local v11 = t.strict(t.Instance)
local v12 = t.strict(t.instanceIsA("GuiButton"))
local v13 = t.strict(t.boolean)
local v14 = Log.new()
local v15 = GUI.PlayerGui()
local v16 = {}
local v17 = {}
local v18 = {}
local v19 = {}
local v20, v21
local v22 = true

local function rankOf(v23) -- line 91 | captures: v5
    return v5[v23.Name] or v23.DisplayOrder
end

local function brandNow() -- line 98 | captures: InputIconsConfig
    return (InputIconsConfig.Platform())
end

local function label(v24) -- line 101
    if v24 then
        return (v24:GetFullName())
    end
    return "-"
end

local function screenOf(v25) -- line 107
    if v25:IsA("ScreenGui") then
        return v25
    end
    return (v25:FindFirstAncestorOfClass("ScreenGui"))
end

local function buttonAbove(v26) -- line 113
    local Parent = v26.Parent
    while Parent ~= nil do
        if Parent:IsA("ScreenGui") then
            break
        end
        if Parent:IsA("GuiButton") then
            break
        end
        Parent = Parent.Parent
    end
    if Parent ~= nil and Parent:IsA("GuiButton") then
        return Parent
    end
    return nil
end

local function isBlocked(v27) -- line 129 | captures: v6
    local v28
    if v27:IsA("LayerCollector") then
        v28 = v27
    else
        v28 = v27:FindFirstAncestorWhichIsA("LayerCollector")
    end
    if v28 == nil then
        return false
    end
    return v6[v28.Name] == true
end

local function isOnScreen(v29) -- line 139
    local v30 = v29
    while true do
        if v30 == nil or v30:IsA("ScreenGui") then
            break
        end
        if v30:IsA("GuiObject") and not v30.Visible then
            v30 = nil
        else
            v30 = v30.Parent
        end
    end
    if v30 == nil then
        return false
    end
    return v30.Enabled
end

local function dressMarker(v31, v32) -- line 159 | captures: ClientGlobals, v9
    v31.Visible = ClientGlobals.Console and v31:GetAttribute("HideOnLoad") ~= true
    local v33 = if v31:IsA("ImageLabel") or v31:IsA("ImageButton") then v31 else nil
    if ClientGlobals.Console and v33 ~= nil then
        v33.Image = v9.GlyphFor(v32)
    end
end

local function redress(v34) -- line 177 | captures: v21, ClientGlobals, InputIconsConfig, ButtonB, v8, v17
    local v35 = v17[v34]
    local v36 = assert(v35, "a close decoration must be stashed before it is redressed")
    local Console = ClientGlobals.Console
    if v36.image == nil then
        if v36.caption ~= nil then
            if Console then
                local v37 = v21 or InputIconsConfig.Platform()
                v34.Text = v8[v37]
            else
                v34.Text = v36.caption
            end
        end
    else
        v34.Image = Console and InputIconsConfig.Image(ButtonB) or v36.image
    end
    if Console then
        v34.Visible = true
    else
        v34.Visible = v36.visible
    end
end

local function stash(v38, v39) -- line 213 | captures: v17
    if v17[v38] ~= nil then
        return
    end
    v17[v38] = v39
    v38.Destroying:Once(function() -- line 218 | captures: v38, v17
        v17[v38] = nil
    end)
end

local function forgetButton(v40) -- line 222 | captures: v19, v16
    v16[v40] = nil
    for v41, v42 in v19 do
        local v43
        if v42 == v40 then
        else
            v43 = v42
        end
        v19[v41] = v43
    end
end

local function bindButton(v44, v45, v46, v47) -- line 238 | captures: v19, v1, v16
    local v48 = v1[v45] ~= nil
    local v49 = ("there is no gamepad action called %*"):format(v45)
    assert(v48, v49)
    local v50
    if v44:IsA("ScreenGui") then
        v50 = v44
    else
        v50 = v44:FindFirstAncestorOfClass("ScreenGui")
    end
    local v51
    if v44 then
        v51 = v44:GetFullName()
    else
        v51 = "-"
    end
    local v52 = ("%* needs a ScreenGui above it to take a binding"):format(v51)
    local v53 = assert(v50, v52)
    local v54 = v16[v44] == nil
    local v55 = {
        action = v45,
        button = v44,
        marker = v46,
        screen = v53,
        isClose = v47
    }
    v16[v44] = v55
    if v54 then
        v44.Destroying:Once(function() -- line 263 | captures: v44, v19, v16
            v16[v44] = nil
            for v56, v57 in v19 do
                local v58
                if v57 == v44 then
                else
                    v58 = v57
                end
                v19[v56] = v58
            end
        end)
    end
end

local function fits(v59, v60) -- line 281 | captures: v20, isOnScreen
    local v61
    if v59.action == v60 then
        v61 = isOnScreen(v59.button)
    else
        v61 = false
    end
    local v62 = if v59.marker == nil then true else v59.marker.Visible
    if v61 then
        if v62 then
            if v20 ~= nil then
                return v59.screen == v20
            end
            v62 = true
        end
    else
        v62 = v61
    end
    return v62
end

local function outranks(v63, v64) -- line 294 | captures: v5
    local screen = v63.screen
    local v65 = v5[screen.Name] or screen.DisplayOrder
    local v66
    if v64 == nil then
        v66 = v65
    else
        local screen = v64.screen
        v66 = v5[screen.Name] or screen.DisplayOrder
    end
    if v64 ~= nil and v65 <= v66 then
        if v65 == v66 then
            return v64.isClose and not v63.isClose
        end
        return false
    end
    return true
end

local function bestTarget(v67) -- line 325 | captures: v20, v5, v16, isOnScreen
    local v68
    for v69, v70 in v16 do
        local v71
        if v70.action == v67 then
            v71 = isOnScreen(v70.button)
        else
            v71 = false
        end
        local v72 = if v70.marker == nil then true else v70.marker.Visible
        if v71 then
            if v72 then
                if v20 == nil then
                    v72 = true
                else
                    v72 = v70.screen == v20
                end
            end
        else
            v72 = v71
        end
        if v72 then
            local screen = v70.screen
            local v73 = v5[screen.Name] or screen.DisplayOrder
            local v74
            if v68 == nil then
                v74 = v73
            else
                local screen = v68.screen
                v74 = v5[screen.Name] or screen.DisplayOrder
            end
            if v68 == nil or not (v73 <= v74) or v73 == v74 and v68.isClose and not v70.isClose then
                v68 = v70
            end
        end
    end
    if v68 == nil then
        return nil
    end
    return v68.button
end

local function selectionOwnsA() -- line 381 | captures: GuiService, isOnScreen
    local SelectedObject = GuiService.SelectedObject
    if SelectedObject == nil then
        return false
    end
    return (isOnScreen(SelectedObject))
end

local function pressBegan(v75) -- line 386 | captures: v19, v20, v22, GuiService, ClientGlobals, ConsoleSignals, v2, v14, isOnScreen, bestTarget
    local v76 = v2[v75.KeyCode]
    local v77 = not ClientGlobals.Console
    if not v77 then
        v77 = not v22
        if not v77 then
            if v76 == nil then
                v77 = true
            elseif v76 == "ButtonA" then
                local SelectedObject = GuiService.SelectedObject
                if SelectedObject == nil then
                    v77 = false
                else
                    v77 = isOnScreen(SelectedObject)
                end
            else
                v77 = false
            end
        end
    end
    if not v77 then
        local v78 = bestTarget(v76)
        if v78 == nil then
            local v79 = v14:AtDebug()
            local v80 = v20
            local v81
            if v80 then
                v81 = v80:GetFullName()
            else
                v81 = "-"
            end
            local SelectedObject = GuiService.SelectedObject
            local v82
            if SelectedObject then
                v82 = SelectedObject:GetFullName()
            else
                v82 = "-"
            end
            v79:Log((("%* found nobody: focus %*, selection %*"):format(v76, v81, v82)))
        else
            v19[v75.KeyCode] = v78
            ConsoleSignals.PressedButton:Fire(v78, v76)
        end
    end
end

local function pressEnded(v83) -- line 427 | captures: v19, ClientGlobals, ConsoleSignals, v2, isOnScreen
    local v84 = v2[v83.KeyCode]
    if ClientGlobals.Console and v84 ~= nil then
        local v85 = v19[v83.KeyCode]
        v19[v83.KeyCode] = nil
        if v85 ~= nil and v85.Active and isOnScreen(v85) then
            ConsoleSignals.ReleasedButton:Fire(v85, v84)
        end
    end
end

local function onGamepadAction(v86, v87, v88) -- line 438 | captures: v19, ClientGlobals, ConsoleSignals, v2, Sink, Pass, isOnScreen, pressBegan
    if v87 == Enum.UserInputState.Begin then
        pressBegan(v88)
        if v19[v88.KeyCode] == nil then
            return Pass
        end
        return Sink
    end
    local v89 = v19[v88.KeyCode] ~= nil
    if v87 == Enum.UserInputState.Cancel then
        v19[v88.KeyCode] = nil
    else
        local v90 = v2[v88.KeyCode]
        if ClientGlobals.Console and v90 ~= nil then
            local v91 = v19[v88.KeyCode]
            v19[v88.KeyCode] = nil
            if v91 ~= nil and v91.Active and isOnScreen(v91) then
                ConsoleSignals.ReleasedButton:Fire(v91, v90)
            end
        end
    end
    if v89 then
        return Sink
    end
    return Pass
end

function v9.ReadBrand() -- line 464 | captures: v21
    return v21
end

function v9.GlyphFor(v92) -- line 467 | captures: InputIconsConfig, v1, v10, v18
    v10(v92)
    local v93 = v1[v92]
    local v94 = ("there is no gamepad action called %*"):format(v92)
    local v95 = assert(v93, v94)
    local v96 = v18[v92] or InputIconsConfig.Image(v95) or ""
    v18[v92] = v96
    return v96
end

function v9.IsOnScreen(v97) -- line 480 | captures: v11, isOnScreen
    v11(v97)
    return (isOnScreen(v97))
end

function v9.TrackCloseButton(v98) -- line 484 | captures: v6, v7, v12, v17, redress, bindButton
    v12(v98)
    local v99
    if v98:IsA("LayerCollector") then
        v99 = v98
    else
        v99 = v98:FindFirstAncestorWhichIsA("LayerCollector")
    end
    if v99 ~= nil and v6[v99.Name] == true then
        return
    end
    local v100
    if v98:IsA("ScreenGui") then
        v100 = v98
    else
        v100 = v98:FindFirstAncestorOfClass("ScreenGui")
    end
    local v101
    if v98 then
        v101 = v98:GetFullName()
    else
        v101 = "-"
    end
    local v102 = ("close button %* needs a ScreenGui above it"):format(v101)
    local v103 = assert(v100, v102)
    if v7[v103.Name] then
        local TextLabel = v98:FindFirstChild("TextLabel")
        local v104
        if TextLabel == nil then
            v104 = false
        else
            v104 = TextLabel:IsA("TextLabel")
        end
        local v105
        if v98 then
            v105 = v98:GetFullName()
        else
            v105 = "-"
        end
        local v106 = ("%*.TextLabel has to be a TextLabel"):format(v105)
        assert(v104, v106)
        local TextLabel_2 = TextLabel:FindFirstChild("TextLabel")
        local v107 = {
            visible = TextLabel.Visible,
            caption = TextLabel.Text
        }
        if v17[TextLabel] == nil then
            v17[TextLabel] = v107
            TextLabel.Destroying:Once(function() -- line 521 | captures: TextLabel, v17
                v17[TextLabel] = nil
            end)
        end
        redress(TextLabel)
        if TextLabel_2 ~= nil then
            local TextLabel_3 = TextLabel_2:IsA("TextLabel")
            local v108
            if TextLabel then
                v108 = TextLabel:GetFullName()
            else
                v108 = "-"
            end
            local v109 = ("%*.TextLabel has to be a TextLabel as well"):format(v108)
            assert(TextLabel_3, v109)
            local v110 = {
                visible = TextLabel_2.Visible,
                caption = TextLabel_2.Text
            }
            if v17[TextLabel_2] == nil then
                v17[TextLabel_2] = v110
                TextLabel_2.Destroying:Once(function() -- line 538 | captures: TextLabel_2, v17
                    v17[TextLabel_2] = nil
                end)
            end
            redress(TextLabel_2)
        end
    end
    bindButton(v98, "ButtonB", nil, true)
end

function v9.AdoptCloseButton(v111) -- line 547 | captures: v6, v9, v12, v17, redress
    v12(v111)
    local v112
    if v111:IsA("LayerCollector") then
        v112 = v111
    else
        v112 = v111:FindFirstAncestorWhichIsA("LayerCollector")
    end
    if v112 ~= nil and v6[v112.Name] == true then
        return
    end
    local TextButton = v111:FindFirstChild("TextButton")
    local v113
    if TextButton == nil then
        v113 = false
    else
        v113 = TextButton:IsA("ImageLabel")
    end
    if v111 then
        v111:GetFullName()
    end
    if not v113 then
        return
    end
    local v114 = {
        visible = TextButton.Visible,
        image = TextButton.Image
    }
    if v17[TextButton] == nil then
        v17[TextButton] = v114
        TextButton.Destroying:Once(function() -- line 572 | captures: TextButton, v17
            v17[TextButton] = nil
        end)
    end
    v9.TrackCloseButton(v111)
    redress(TextButton)
end

function v9.Inspect(v115) -- line 579 | captures: v6, v7, v9
    local v116 = v115:IsA("GuiButton") and v115.Name == "Close"
    local v117 = v115:IsA("GuiObject") and v115.Name == "ConsoleButton"
    local v118
    if v115:IsA("LayerCollector") then
        v118 = v115
    else
        v118 = v115:FindFirstAncestorWhichIsA("LayerCollector")
    end
    if v118 ~= nil and v6[v118.Name] == true or not v116 then
        return
    end
    local v119
    if v115:IsA("ScreenGui") then
        v119 = v115
    else
        v119 = v115:FindFirstAncestorOfClass("ScreenGui")
    end
    local v120 = if v7[assert(v119, "a Close button turned up with no ScreenGui above it").Name] then v9.TrackCloseButton else v9.AdoptCloseButton
    v120(v115)
end

function v9.FocusScreen(v121) -- line 630 | captures: v20, v15
    local v122
    if v121 == nil then
        v122 = true
    else
        v122 = v121:IsDescendantOf(v15)
    end
    assert(v122, "a focused screen has to live in the local PlayerGui")
    v20 = v121
end

function v9.EnableMarkers(v123) -- line 635 | captures: v19, v22, v13
    v13(v123)
    v22 = v123
    if v123 then
    else
        v19 = {}
    end
end

function v9.Rescan(v124) -- line 646 | captures: v21, ClientGlobals, InputIconsConfig, v9, v15, v16, v17, v18, dressMarker, redress
    if (v124 or ClientGlobals.Platform) == "Console" then
        v21 = InputIconsConfig.Platform()
    else
        v21 = nil
    end
    table.clear(v18)
    for v125, v126 in v15:GetDescendants() do
        v9.Inspect(v126)
    end
    for v127 in v17 do
        if v127.Parent ~= nil then
            redress(v127)
        end
    end
    for v128, v129 in v16 do
        if v129.marker ~= nil then
            dressMarker(v129.marker, v129.action)
        end
    end
end

local function MayJump() -- line 679
    return true
end

v9.MayJump = MayJump
PlatformSignals.Changed:Connect(v9.Rescan)
InputIconsConfig.Changed:Connect(function() -- line 683 | captures: v9
    v9.Rescan()
end)
local v130 = {}
for v131, v132 in v1 do
    local v133
    if v131 == "ButtonStart" then
    else
        v133 = v132
    end
    v130[#v130 + 1] = v133
end
ContextActionService:BindActionAtPriority("GamepadBindingsMarkers", onGamepadAction, false, Value, table.unpack(v130))
v14:AtInfo():Log("gamepad button routing is live")
return v9
