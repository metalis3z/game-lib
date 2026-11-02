-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local Assets = require(ReplicatedStorage.Data.Assets)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Eggs.Types)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggState = require(ReplicatedStorage.Client.EggState)
require(ReplicatedStorage.Shared.Types.Eggs)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local GrowingEggListRow = require(ReplicatedStorage.Shared.Eggs.GrowingEggListRow)
local Log = require(ReplicatedStorage.Packages.Log)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local SlideDock = require(ReplicatedStorage.Client.UI.SlideDock)

local function optionalBadge(v1, v2) -- line 28
    if v1 == nil then
        return nil
    end
    local v3 = v1:FindFirstChild(v2)
    if v3 == nil then
        return nil
    end
    return v3
end

local LocalPlayer = Players.LocalPlayer
local v4 = GUI.GrowingEggs()
local Frame = v4.Frame
local Close = Frame.Close
local GrowAll = Frame.Header.GrowAll
local ScrollingFrame = Frame.ScrollingFrame
local EmptyLast = ScrollingFrame:FindFirstChild("EmptyLast")
local v5
for v6, v7 in ScrollingFrame:GetChildren() do
    if v7.Name == "Template" and v7:IsA("GuiObject") then
        if v5 == nil then
            v5 = v7
        else
            v7:Destroy()
        end
    end
end
local EggsButton = v5 ~= nil
assert(EggsButton, "GrowingEggs.Frame.ScrollingFrame has no Template row")
EggsButton = Hud.Every("EggsButton")
local EggsButton_2 = Hud.Find("EggsButton")
local v8

if EggsButton_2 == nil then
else
    v8 = EggsButton_2:FindFirstChild("NightImage")
end
local v9

if EggsButton_2 == nil then
else
    v9 = EggsButton_2:FindFirstChild("NightText")
end
local Notification, Notification_2

if EggsButton_2 == nil then
else
    local Notification_3 = EggsButton_2:FindFirstChild("Notification")
    if Notification_3 == nil then
    else
        Notification = Notification_3
        Notification_2 = Notification_3
    end
end
local TextLabel, TextLabel_2

if Notification_2 == nil then
else
    local TextLabel_3 = Notification_2.InletTexture.TextLabel
    TextLabel = TextLabel_3
    TextLabel_2 = TextLabel_3
end
local Shadow

if TextLabel_2 == nil then
else
    Shadow = TextLabel_2.Shadow
end
local ReadyNotification, ReadyNotification_2

if EggsButton_2 == nil then
else
    local ReadyNotification_3 = EggsButton_2:FindFirstChild("ReadyNotification")
    if ReadyNotification_3 == nil then
    else
        ReadyNotification = ReadyNotification_3
        ReadyNotification_2 = ReadyNotification_3
    end
end
local TextLabel_3, TextLabel_4

if ReadyNotification_2 == nil then
else
    local TextLabel = ReadyNotification_2.InletTexture.TextLabel
    TextLabel_3 = TextLabel
    TextLabel_4 = TextLabel
end
local Shadow_2

if TextLabel_4 == nil then
else
    Shadow_2 = TextLabel_4.Shadow
end
local v10 = {}
local v11 = {}
local v12 = {}
local v13 = {}
local v14 = {}
local v15 = {}
local v16 = 0
local v17 = 0
local v18 = 0
local ScreenGui = v4:IsA("ScreenGui")
assert(ScreenGui, "PlayerGui.GrowingEggs must be a ScreenGui")
local GuiObject = Frame:IsA("GuiObject")
assert(GuiObject, "GrowingEggs.Frame must be a GuiObject")
GuiObject = Close:IsA("GuiButton")
assert(GuiObject, "GrowingEggs.Frame.Close must be a GuiButton")
GuiObject = GrowAll:IsA("GuiButton")
assert(GuiObject, "GrowingEggs.Frame.Header.GrowAll must be a GuiButton")
GuiObject = ScrollingFrame:IsA("ScrollingFrame")
assert(GuiObject, "GrowingEggs.Frame.ScrollingFrame must be a ScrollingFrame")
ScreenGui = #EggsButton > 0
assert(ScreenGui, "the HUD has no EggsButton to open GrowingEggs with")
v4.ResetOnSpawn = false
GamepadBindings.TrackCloseButton(Close)
local v19 = SlideDock.new(v4, Frame, SlideDock.EscortFramesOf(EggsButton))
local v20 = Log.new()

local function setNightDecoration(v21) -- line 137 | captures: v8, v9
    if v8 ~= nil then
        v8.Visible = v21
    end
    if v9 ~= nil then
        v9.Visible = v21
    end
end

local function setOpen(v22, v23) -- line 145 | captures: v19
    v19:SetOpen(v22, v23)
end

local function getGrowthAlpha(v24) -- line 148 | captures: Workspace, EggRecords, LocalPlayer
    local v25 = Workspace:GetServerTimeNow()
    local v26 = EggRecords.CurrentNightCredit(v24, v25, v24.GrowthSpeedMultiplier)
    return EggRecords.GrowthAlpha(v24, v25, v24.GrowthSpeedMultiplier, v26, LocalPlayer)
end

local function isReady(v27) -- line 153 | captures: Workspace, EggRecords, LocalPlayer
    local v28 = Workspace:GetServerTimeNow()
    local v29 = EggRecords.CurrentNightCredit(v27, v28, v27.GrowthSpeedMultiplier)
    return EggRecords.GrowthAlpha(v27, v28, v27.GrowthSpeedMultiplier, v29, LocalPlayer) >= 1
end

local function getRemainingSeconds(v30) -- line 159 | captures: Workspace, EggRecords, LocalPlayer
    if v30.Placement == nil then
        return 0
    end
    local v31 = Workspace:GetServerTimeNow()
    local v32 = EggRecords.CurrentNightCredit(v30, v31, v30.GrowthSpeedMultiplier)
    if EggRecords.GrowthAlpha(v30, v31, v30.GrowthSpeedMultiplier, v32, LocalPlayer) >= 1 then
        return 0
    end
    local v33 = Workspace:GetServerTimeNow()
    local v34 = EggRecords.CurrentNightCredit(v30, v33, v30.GrowthSpeedMultiplier)
    return EggRecords.GrowthSecondsRemaining(v30, v33, v30.GrowthSpeedMultiplier, v34, LocalPlayer)
end

local function getRemainingText(v35) -- line 173 | captures: Workspace, EggRecords, Elapsed, LocalPlayer
    local Placement = v35.Placement
    local v36, v37
    if Placement == nil then
        v37 = true
    elseif Placement.ReadyAt == nil then
        if v35.Placement == nil then
            v36 = 0
        else
            local v38 = Workspace:GetServerTimeNow()
            local v39 = EggRecords.CurrentNightCredit(v35, v38, v35.GrowthSpeedMultiplier)
            if EggRecords.GrowthAlpha(v35, v38, v35.GrowthSpeedMultiplier, v39, LocalPlayer) >= 1 then
                v36 = 0
            else
                local v40 = Workspace:GetServerTimeNow()
                local v41 = EggRecords.CurrentNightCredit(v35, v40, v35.GrowthSpeedMultiplier)
                v36 = EggRecords.GrowthSecondsRemaining(v35, v40, v35.GrowthSpeedMultiplier, v41, LocalPlayer)
            end
        end
        v37 = false
    else
        v37 = true
    end
    if v37 then
        return "Ready!"
    end
    if v36 <= 0 then
        return "Ready!"
    end
    return (Elapsed(v36))
end

local function updateRow(v42) -- line 198 | captures: Workspace, Assets, EggRecords, Elapsed, GrowingEggListRow, Mutations, LocalPlayer
    local Record = v42.Record
    local v43 = Workspace:GetServerTimeNow()
    local v44 = EggRecords.CurrentNightCredit(Record, v43, Record.GrowthSpeedMultiplier)
    local v45 = EggRecords.GrowthAlpha(Record, v43, Record.GrowthSpeedMultiplier, v44, LocalPlayer)
    local v46 = v45 >= 1
    local v47 = not v46
    local Update = GrowingEggListRow.Update
    local v48 = Mutations.EggIcon(Record.Mutations, Record.BaseMutation) or Assets.Directory[Record.AssetCategory].Egg.Icon
    local Placement = Record.Placement
    local v49
    if Placement == nil then
        v49 = "Ready!"
    elseif Placement.ReadyAt == nil then
        local v50
        if Record.Placement == nil then
            v50 = 0
        else
            local v51 = Workspace:GetServerTimeNow()
            local v52 = EggRecords.CurrentNightCredit(Record, v51, Record.GrowthSpeedMultiplier)
            if EggRecords.GrowthAlpha(Record, v51, Record.GrowthSpeedMultiplier, v52, LocalPlayer) >= 1 then
                v50 = 0
            else
                local v53 = Workspace:GetServerTimeNow()
                local v54 = EggRecords.CurrentNightCredit(Record, v53, Record.GrowthSpeedMultiplier)
                v50 = EggRecords.GrowthSecondsRemaining(Record, v53, Record.GrowthSpeedMultiplier, v54, LocalPlayer)
            end
        end
        if v50 > 0 then
            v49 = Elapsed(v50)
        else
            v49 = "Ready!"
        end
    else
        v49 = "Ready!"
    end
    Update(v42, v48, v45, v49, v46, v47)
end

local function updateNotification(v55, v56, v57, v58) -- line 240
    if v55 == nil or v56 == nil or v57 == nil then
        return
    end
    local v59 = v58 > 0
    v55.Visible = v59
    if not v59 then
        return
    end
    local v60 = tostring(v58)
    v56.Text = v60
    v57.Text = v60
end

local function updatePlacedNotification() -- line 252 | captures: Shadow, TextLabel, Notification, v16
    local Notification_2 = Notification
    local TextLabel_2 = TextLabel
    local Shadow_2 = Shadow
    local v61 = v16
    if Notification_2 == nil or TextLabel_2 == nil or Shadow_2 == nil then
        return
    end
    local v62 = v61 > 0
    Notification_2.Visible = v62
    if not v62 then
        return
    end
    local v63 = tostring(v61)
    TextLabel_2.Text = v63
    Shadow_2.Text = v63
end

local function updateReadyNotification() -- line 268 | captures: Shadow_2, TextLabel_3, ReadyNotification, v17
    local ReadyNotification_2 = ReadyNotification
    local TextLabel = TextLabel_3
    local Shadow = Shadow_2
    local v64 = v17
    if ReadyNotification_2 == nil or TextLabel == nil or Shadow == nil then
        return
    end
    local v65 = v64 > 0
    ReadyNotification_2.Visible = v65
    if not v65 then
        return
    end
    local v66 = tostring(v64)
    TextLabel.Text = v66
    Shadow.Text = v66
end

local function clearPlacedNotification() -- line 284 | captures: Shadow, TextLabel, Notification, v16, v14
    v16 = 0
    table.clear(v14)
    local Notification_2 = Notification
    local TextLabel_2 = TextLabel
    local Shadow_2 = Shadow
    local v67 = v16
    if Notification_2 == nil or TextLabel_2 == nil or Shadow_2 == nil then
        return
    end
    local v68 = v67 > 0
    Notification_2.Visible = v68
    if not v68 then
        return
    end
    local v69 = tostring(v67)
    TextLabel_2.Text = v69
    Shadow_2.Text = v69
end

local function clearReadyNotification() -- line 302 | captures: Shadow_2, TextLabel_3, ReadyNotification, v17, v15
    v17 = 0
    table.clear(v15)
    local ReadyNotification_2 = ReadyNotification
    local TextLabel = TextLabel_3
    local Shadow = Shadow_2
    local v70 = v17
    if ReadyNotification_2 == nil or TextLabel == nil or Shadow == nil then
        return
    end
    local v71 = v70 > 0
    ReadyNotification_2.Visible = v71
    if not v71 then
        return
    end
    local v72 = tostring(v70)
    TextLabel.Text = v72
    Shadow.Text = v72
end

local function incrementPlacedNotification(v73) -- line 320 | captures: Shadow, TextLabel, Notification, v16, v4, v14
    if v4.Enabled or v14[v73] then
        return
    end
    v14[v73] = true
    v16 += 1
    local Notification_2 = Notification
    local TextLabel_2 = TextLabel
    local Shadow_2 = Shadow
    local v74 = v16
    if Notification_2 == nil or TextLabel_2 == nil or Shadow_2 == nil then
        return
    end
    local v75 = v74 > 0
    Notification_2.Visible = v75
    if not v75 then
        return
    end
    local v76 = tostring(v74)
    TextLabel_2.Text = v76
    Shadow_2.Text = v76
end

local function incrementReadyNotification(v77) -- line 341 | captures: Shadow_2, TextLabel_3, ReadyNotification, v17, v4, v15
    if v4.Enabled or v15[v77] then
        return
    end
    v15[v77] = true
    v17 += 1
    local ReadyNotification_2 = ReadyNotification
    local TextLabel = TextLabel_3
    local Shadow = Shadow_2
    local v78 = v17
    if ReadyNotification_2 == nil or TextLabel == nil or Shadow == nil then
        return
    end
    local v79 = v78 > 0
    ReadyNotification_2.Visible = v79
    if not v79 then
        return
    end
    local v80 = tostring(v78)
    TextLabel.Text = v80
    Shadow.Text = v80
end

local function consumePlacedNotification(v81) -- line 362 | captures: Shadow, TextLabel, Notification, v16, v14
    if not v14[v81] then
        return
    end
    v14[v81] = nil
    local v82 = v16 - 1
    v16 = math.max(v82, 0)
    local Notification_2 = Notification
    local TextLabel_2 = TextLabel
    local Shadow_2 = Shadow
    local v83 = v16
    if Notification_2 == nil or TextLabel_2 == nil or Shadow_2 == nil then
        return
    end
    local v84 = v83 > 0
    Notification_2.Visible = v84
    if not v84 then
        return
    end
    local v85 = tostring(v83)
    TextLabel_2.Text = v85
    Shadow_2.Text = v85
end

local function consumeReadyNotification(v86) -- line 383 | captures: Shadow_2, TextLabel_3, ReadyNotification, v17, v15
    if not v15[v86] then
        return
    end
    v15[v86] = nil
    local v87 = v17 - 1
    v17 = math.max(v87, 0)
    local ReadyNotification_2 = ReadyNotification
    local TextLabel = TextLabel_3
    local Shadow = Shadow_2
    local v88 = v17
    if ReadyNotification_2 == nil or TextLabel == nil or Shadow == nil then
        return
    end
    local v89 = v88 > 0
    ReadyNotification_2.Visible = v89
    if not v89 then
        return
    end
    local v90 = tostring(v88)
    TextLabel.Text = v90
    Shadow.Text = v90
end

local function syncReadyState(v91, v92, v93) -- line 404 | captures: Shadow_2, TextLabel_3, ReadyNotification, v17, Workspace, EggRecords, LocalPlayer, v4, v13, v15
    local v94 = Workspace:GetServerTimeNow()
    local v95 = EggRecords.CurrentNightCredit(v92, v94, v92.GrowthSpeedMultiplier)
    local v96 = EggRecords.GrowthAlpha(v92, v94, v92.GrowthSpeedMultiplier, v95, LocalPlayer) >= 1
    if v96 then
        if v13[v91] then
            return
        end
        v13[v91] = true
        if v93 and not v4.Enabled and not v15[v91] then
            v15[v91] = true
            v17 += 1
            local ReadyNotification_2 = ReadyNotification
            local TextLabel = TextLabel_3
            local Shadow = Shadow_2
            local v97 = v17
            if ReadyNotification_2 == nil or TextLabel == nil or Shadow == nil then
                return v96
            end
            local v98 = v97 > 0
            ReadyNotification_2.Visible = v98
            if v98 then
                local v99 = tostring(v97)
                TextLabel.Text = v99
                Shadow.Text = v99
            end
            return v96
        end
    else
        local v100 = v13[v91]
        if not v96 and v100 then
            v13[v91] = nil
            if v15[v91] then
                v15[v91] = nil
                local v101 = v17 - 1
                v17 = math.max(v101, 0)
                local ReadyNotification_2 = ReadyNotification
                local TextLabel = TextLabel_3
                local Shadow = Shadow_2
                local v102 = v17
                if ReadyNotification_2 == nil or TextLabel == nil or Shadow == nil then
                    return v96
                end
                local v103 = v102 > 0
                ReadyNotification_2.Visible = v103
                if v103 then
                    local v104 = tostring(v102)
                    TextLabel.Text = v104
                    Shadow.Text = v104
                end
            end
        end
    end
    return v96
end

local function rowSortKey(v105, v106) -- line 459 | captures: EggRecords, LocalPlayer
    local Record = v105.Record
    local v107 = EggRecords.CurrentNightCredit(Record, v106, Record.GrowthSpeedMultiplier)
    local v108 = EggRecords.GrowthAlpha(Record, v106, Record.GrowthSpeedMultiplier, v107, LocalPlayer) >= 1
    local v109 = {
        Row = v105,
        Grown = v108,
        Remaining = Record.Placement ~= nil and not v108 and EggRecords.GrowthSecondsRemaining(Record, v106, Record.GrowthSpeedMultiplier, v107, LocalPlayer) or 0
    }
    local Uid = v105.Uid
    v109.Uid = tostring(Uid)
    return v109
end

local function compareRows(v110, v111) -- line 469
    if v110.Grown == v111.Grown then
        if v110.Remaining == v111.Remaining then
            return v110.Uid < v111.Uid
        end
        return v110.Remaining < v111.Remaining
    end
    return v110.Grown
end

local function pinEmptyLast() -- line 478 | captures: EmptyLast
    if EmptyLast ~= nil then
        EmptyLast.LayoutOrder = 1000000
    end
end

local function relayoutRows() -- line 483 | captures: Workspace, EmptyLast, v10, rowSortKey, compareRows
    local v112 = {}
    local v113 = Workspace:GetServerTimeNow()
    for v114, v115 in pairs(v10) do
        local v116 = rowSortKey(v115, v113)
        table.insert(v112, v116)
    end
    table.sort(v112, compareRows)
    for v117, v118 in ipairs(v112) do
        v118.Row.Root.LayoutOrder = v117
    end
    if EmptyLast ~= nil then
        EmptyLast.LayoutOrder = 1000000
    end
end

local function destroyRow(v119) -- line 497 | captures: GrowingEggListRow, v10
    local v120 = v10[v119]
    if v120 ~= nil then
        v10[v119] = nil
        GrowingEggListRow.Destroy(v120)
    end
end

local function requestGrow(v121) -- line 505 | captures: PlacedEggRenderer, v20
    local v122, v123 = PlacedEggRenderer.RequestSkipGrowthForLocalEgg(v121)
    if not v122 then
        v20:AtWarning():Log((("Failed to request egg growth skip from list for %*: %*"):format(v121, v123 or "unknown")))
    end
end

local function showNoGrowingEggs(v124) -- line 512 | captures: Message
    Message.Bottom({
        Time = 2,
        Message = v124 or "You have no growing eggs!",
        Color = Color3.fromRGB(255, 80, 80)
    })
end

local function requestGrowAll() -- line 515 | captures: EggState, Message
    local v125, v126 = EggState.MayBuyGrowAll()
    if v125 then
        EggState.ForgetChosenSkip()
        local __GROW_ALL__, __GROW_ALL___2 = EggState.BeginSkipGrowth("__GROW_ALL__")
        if not __GROW_ALL__ then
            Message.Bottom({
                Time = 2,
                Message = __GROW_ALL___2 or "Could not grow the eggs.",
                Color = Color3.fromRGB(255, 80, 80)
            })
        end
    else
        Message.Bottom({
            Time = 2,
            Message = v126 or "You have no growing eggs!",
            Color = Color3.fromRGB(255, 80, 80)
        })
    end
end

local function requestHatch(v127) -- line 528 | captures: PlacedEggRenderer, v20
    local v128, v129 = PlacedEggRenderer.ActivateLocalEgg(v127)
    if not v128 then
        v20:AtWarning():Log((("Failed to hatch egg from list for %*: %*"):format(v127, v129 or "unknown")))
    end
end

local function removeHatchingRow(v130) -- line 535 | captures: Shadow, Shadow_2, TextLabel, TextLabel_3, Notification, ReadyNotification, v16, v17, GrowingEggListRow, v10, v11, v14, v15
    v11[v130] = true
    local Notification_2, TextLabel_2, Shadow_3, v131, v132, v133
    if v14[v130] then
        v14[v130] = nil
        local v134 = v16 - 1
        v16 = math.max(v134, 0)
        Notification_2 = Notification
        TextLabel_2 = TextLabel
        Shadow_3 = Shadow
        v131 = v16
        if Notification_2 == nil or TextLabel_2 == nil or Shadow_3 == nil then
            v133 = true
        else
            v132 = v131 > 0
            v133 = false
        end
    else
        v133 = true
    end
    if not v133 then
        Notification_2.Visible = v132
        if v132 then
            local v135 = tostring(v131)
            TextLabel_2.Text = v135
            Shadow_3.Text = v135
        end
    end
    local ReadyNotification_2, TextLabel_4, Shadow_4, v136, v137, v138
    if v15[v130] then
        v15[v130] = nil
        local v139 = v17 - 1
        v17 = math.max(v139, 0)
        ReadyNotification_2 = ReadyNotification
        TextLabel_4 = TextLabel_3
        Shadow_4 = Shadow_2
        v136 = v17
        if ReadyNotification_2 == nil or TextLabel_4 == nil or Shadow_4 == nil then
            v138 = true
        else
            v137 = v136 > 0
            v138 = false
        end
    else
        v138 = true
    end
    if not v138 then
        ReadyNotification_2.Visible = v137
        if v137 then
            local v140 = tostring(v136)
            TextLabel_4.Text = v140
            Shadow_4.Text = v140
        end
    end
    local v141 = v10[v130]
    if v141 ~= nil then
        v10[v130] = nil
        GrowingEggListRow.Destroy(v141)
    end
end

local v142 = v5

local function mountRow(v143, v144) -- line 579 | captures: ButtonFX, GrowingEggListRow, ScrollingFrame, v10, updateRow, requestGrow, requestHatch, v142
    local v145 = GrowingEggListRow.Mount(v142, ScrollingFrame, v143, requestGrow, requestHatch)
    v145.Record = v144
    v10[v143] = v145
    v145.Trove:Add(ButtonFX(v145.GrowButton, 1.08))
    if v145.HatchButton ~= v145.GrowButton then
        v145.Trove:Add(ButtonFX(v145.HatchButton, 1.08))
    end
    updateRow(v145)
    return v145
end

local function refreshRows(v146, v147) -- line 590 | captures: Shadow, Shadow_2, TextLabel, TextLabel_3, Notification, ReadyNotification, v16, v17, Workspace, EggRecords, EggState, GrowingEggListRow, LocalPlayer, v4, v10, v11, v12, v13, v14, v15, updateRow, relayoutRows, mountRow
    local v148 = EggState.ReadOwnerEggs(LocalPlayer.UserId)
    local v149 = {}
    local v150 = {}
    for v151, v152 in pairs(v148) do
        if v152.Placement ~= nil then
            v150[v151] = true
            if not v12[v151] then
                v12[v151] = true
                if v146 and not v4.Enabled and not v14[v151] then
                    v14[v151] = true
                    v16 += 1
                    local Notification_2 = Notification
                    local TextLabel_2 = TextLabel
                    local Shadow_2 = Shadow
                    local v153 = v16
                    if Notification_2 ~= nil and TextLabel_2 ~= nil and Shadow_2 ~= nil then
                        local v154 = v153 > 0
                        Notification_2.Visible = v154
                        if v154 then
                            local v155 = tostring(v153)
                            TextLabel_2.Text = v155
                            Shadow_2.Text = v155
                        end
                    end
                end
            end
            local v156 = Workspace:GetServerTimeNow()
            local v157 = EggRecords.CurrentNightCredit(v152, v156, v152.GrowthSpeedMultiplier)
            if EggRecords.GrowthAlpha(v152, v156, v152.GrowthSpeedMultiplier, v157, LocalPlayer) >= 1 then
                if not v13[v151] then
                    v13[v151] = true
                    if v147 and not v4.Enabled and not v15[v151] then
                        v15[v151] = true
                        v17 += 1
                        local ReadyNotification_2 = ReadyNotification
                        local TextLabel = TextLabel_3
                        local Shadow = Shadow_2
                        local v158 = v17
                        if ReadyNotification_2 ~= nil and TextLabel ~= nil and Shadow ~= nil then
                            local v159 = v158 > 0
                            ReadyNotification_2.Visible = v159
                            if v159 then
                                local v160 = tostring(v158)
                                TextLabel.Text = v160
                                Shadow.Text = v160
                            end
                        end
                    end
                end
            elseif v13[v151] then
                v13[v151] = nil
                if v15[v151] then
                    v15[v151] = nil
                    local v161 = v17 - 1
                    v17 = math.max(v161, 0)
                    local ReadyNotification_2 = ReadyNotification
                    local TextLabel = TextLabel_3
                    local Shadow = Shadow_2
                    local v162 = v17
                    if ReadyNotification_2 ~= nil and TextLabel ~= nil and Shadow ~= nil then
                        local v163 = v162 > 0
                        ReadyNotification_2.Visible = v163
                        if v163 then
                            local v164 = tostring(v162)
                            TextLabel.Text = v164
                            Shadow.Text = v164
                        end
                    end
                end
            end
            if v11[v151] then
                local v165 = v10[v151]
                if v165 ~= nil then
                    v10[v151] = nil
                    GrowingEggListRow.Destroy(v165)
                end
            else
                v149[v151] = true
                local v166 = v10[v151]
                if v166 == nil then
                    mountRow(v151, v152)
                else
                    v166.Record = v152
                    updateRow(v166)
                end
            end
        end
    end
    for v167 in pairs(v10) do
        if not v149[v167] then
            local v168 = v10[v167]
            if v168 ~= nil then
                v10[v167] = nil
                GrowingEggListRow.Destroy(v168)
            end
        end
    end
    for v169 in pairs(v12) do
        if not v150[v169] then
            if v14[v169] then
                v14[v169] = nil
                local v170 = v16 - 1
                v16 = math.max(v170, 0)
                local Notification_2 = Notification
                local TextLabel_2 = TextLabel
                local Shadow_2 = Shadow
                local v171 = v16
                if Notification_2 ~= nil and TextLabel_2 ~= nil and Shadow_2 ~= nil then
                    local v172 = v171 > 0
                    Notification_2.Visible = v172
                    if v172 then
                        local v173 = tostring(v171)
                        TextLabel_2.Text = v173
                        Shadow_2.Text = v173
                    end
                end
            end
            if v15[v169] then
                v15[v169] = nil
                local v174 = v17 - 1
                v17 = math.max(v174, 0)
                local ReadyNotification_2 = ReadyNotification
                local TextLabel = TextLabel_3
                local Shadow = Shadow_2
                local v175 = v17
                if ReadyNotification_2 ~= nil and TextLabel ~= nil and Shadow ~= nil then
                    local v176 = v175 > 0
                    ReadyNotification_2.Visible = v176
                    if v176 then
                        local v177 = tostring(v175)
                        TextLabel.Text = v177
                        Shadow.Text = v177
                    end
                end
            end
            v12[v169] = nil
            v13[v169] = nil
            v11[v169] = nil
        end
    end
    relayoutRows()
end

local function updateVisibleRows() -- line 733 | captures: v8, v9, Shadow_2, TextLabel_3, ReadyNotification, v17, v18, Workspace, AreaEggCycle, EggRecords, LocalPlayer, v4, v10, v13, v15, updateRow, relayoutRows
    local v178 = Workspace:GetServerTimeNow()
    if v178 - v18 < 0.25 then
        return
    end
    v18 = v178
    local v179 = AreaEggCycle.IsNightPhase(v178)
    if v8 ~= nil then
        v8.Visible = v179
    end
    if v9 ~= nil then
        v9.Visible = v179
    end
    local v180 = false
    for v181, v182 in pairs(v10) do
        local v183 = v13[v182.Uid] == true
        local Uid = v182.Uid
        local Record = v182.Record
        local v184 = Workspace:GetServerTimeNow()
        local v185 = EggRecords.CurrentNightCredit(Record, v184, Record.GrowthSpeedMultiplier)
        local v186 = EggRecords.GrowthAlpha(Record, v184, Record.GrowthSpeedMultiplier, v185, LocalPlayer) >= 1
        if v186 then
            if not v13[Uid] then
                v13[Uid] = true
                if not v4.Enabled and not v15[Uid] then
                    v15[Uid] = true
                    v17 += 1
                    local ReadyNotification_2 = ReadyNotification
                    local TextLabel = TextLabel_3
                    local Shadow = Shadow_2
                    local v187 = v17
                    if ReadyNotification_2 ~= nil and TextLabel ~= nil and Shadow ~= nil then
                        local v188 = v187 > 0
                        ReadyNotification_2.Visible = v188
                        if v188 then
                            local v189 = tostring(v187)
                            TextLabel.Text = v189
                            Shadow.Text = v189
                        end
                    end
                end
            end
        elseif v13[Uid] then
            v13[Uid] = nil
            if v15[Uid] then
                v15[Uid] = nil
                local v190 = v17 - 1
                v17 = math.max(v190, 0)
                local ReadyNotification_2 = ReadyNotification
                local TextLabel = TextLabel_3
                local Shadow = Shadow_2
                local v191 = v17
                if ReadyNotification_2 ~= nil and TextLabel ~= nil and Shadow ~= nil then
                    local v192 = v191 > 0
                    ReadyNotification_2.Visible = v192
                    if v192 then
                        local v193 = tostring(v191)
                        TextLabel.Text = v193
                        Shadow.Text = v193
                    end
                end
            end
        end
        if v186 ~= v183 then
            v180 = true
        end
        updateRow(v182)
    end
    if v180 then
        relayoutRows()
    end
end

v5.Visible = false
v19:SetOpen(false, true)
local v194 = v16
local v195

if Notification ~= nil and not (TextLabel == nil or Shadow == nil) then
    local v196 = v194 > 0
    Notification.Visible = v196
    if v196 then
        v195 = tostring(v194)
        TextLabel.Text = v195
        Shadow.Text = v195
    end
end
local v197 = v17

if ReadyNotification ~= nil and not (TextLabel_3 == nil or Shadow_2 == nil) then
    local v198 = v197 > 0
    ReadyNotification.Visible = v198
    if v198 then
        v195 = tostring(v197)
        TextLabel_3.Text = v195
        Shadow_2.Text = v195
    end
end
v195 = AreaEggCycle.IsNightPhase(Workspace:GetServerTimeNow())

if v8 ~= nil then
    v8.Visible = v195
end

if v9 ~= nil then
    v9.Visible = v195
end
refreshRows(false, true)
for v199, v200 in EggsButton do
    local ButtonActivated = GUI.ButtonActivated
    ButtonActivated(v200, function() -- line 840 | captures: Shadow, Shadow_2, TextLabel, TextLabel_3, Notification, ReadyNotification, v16, v17, v14, v15, v19, refreshRows
        v19:SetOpen(true, nil)
        v16 = 0
        table.clear(v14)
        local Notification_2 = Notification
        local TextLabel_2 = TextLabel
        local Shadow_3 = Shadow
        local v201 = v16
        if not (Notification_2 == nil or TextLabel_2 == nil or Shadow_3 == nil) then
            local v202 = v201 > 0
            Notification_2.Visible = v202
            if v202 then
                local v203 = tostring(v201)
                TextLabel_2.Text = v203
                Shadow_3.Text = v203
            end
        end
        v17 = 0
        table.clear(v15)
        local ReadyNotification_2 = ReadyNotification
        local TextLabel_4 = TextLabel_3
        local Shadow_4 = Shadow_2
        local v204 = v17
        if not (ReadyNotification_2 == nil or TextLabel_4 == nil or Shadow_4 == nil) then
            local v205 = v204 > 0
            ReadyNotification_2.Visible = v205
            if v205 then
                local v206 = tostring(v204)
                TextLabel_4.Text = v206
                Shadow_4.Text = v206
            end
        end
        refreshRows(true, true)
    end)
    ButtonFX(v200, 1.08)
end
GUI.ButtonActivated(Close, function() -- line 877 | captures: v19
    v19:SetOpen(false, nil)
end)
ButtonFX(Close, 1.08)
GUI.ButtonActivated(GrowAll, requestGrowAll)
ButtonFX(GrowAll, 1.08)
EggState.SnapshotRefreshed:Connect(function() -- line 883 | captures: refreshRows
    refreshRows(true, true)
end)
EggState.OwnerRefreshed:Connect(function(v207) -- line 886 | captures: LocalPlayer, refreshRows
    if v207 == LocalPlayer.UserId then
        refreshRows(true, true)
    end
end)
EggState.OwnerCleared:Connect(function(v208) -- line 891 | captures: Shadow, Shadow_2, TextLabel, TextLabel_3, Notification, ReadyNotification, v16, v17, GrowingEggListRow, LocalPlayer, v10, v11, v12, v13, v14, v15
    if v208 ~= LocalPlayer.UserId then
        return
    end
    for v209 in pairs(v10) do
        local v210 = v10[v209]
        if v210 ~= nil then
            v10[v209] = nil
            GrowingEggListRow.Destroy(v210)
        end
    end
    table.clear(v11)
    table.clear(v12)
    table.clear(v13)
    v16 = 0
    table.clear(v14)
    local Notification_2 = Notification
    local TextLabel_2 = TextLabel
    local Shadow_3 = Shadow
    local v211 = v16
    if not (Notification_2 == nil or TextLabel_2 == nil or Shadow_3 == nil) then
        local v212 = v211 > 0
        Notification_2.Visible = v212
        if v212 then
            local v213 = tostring(v211)
            TextLabel_2.Text = v213
            Shadow_3.Text = v213
        end
    end
    v17 = 0
    table.clear(v15)
    local ReadyNotification_2 = ReadyNotification
    local TextLabel_4 = TextLabel_3
    local Shadow_4 = Shadow_2
    local v214 = v17
    if ReadyNotification_2 == nil or TextLabel_4 == nil or Shadow_4 == nil then
        return
    end
    local v215 = v214 > 0
    ReadyNotification_2.Visible = v215
    if not v215 then
        return
    end
    local v216 = tostring(v214)
    TextLabel_4.Text = v216
    Shadow_4.Text = v216
end)
PlacedEggRenderer.LocalEggHatchStarted:Connect(removeHatchingRow)
RunService.Heartbeat:Connect(updateVisibleRows)
