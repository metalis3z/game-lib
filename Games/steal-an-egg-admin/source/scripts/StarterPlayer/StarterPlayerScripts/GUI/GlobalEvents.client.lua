-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local GUI = require(ReplicatedStorage.Client.GUI)
local InfoOverlay = require(ReplicatedStorage.Client.InfoOverlay)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local PlatformSignals = require(ReplicatedStorage.Client.PlatformSignals)
local PlayerEarningsBoost = require(ReplicatedStorage.Shared.Util.PlayerEarningsBoost)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local Save = require(ReplicatedStorage.Shared.Save)
local ServerLuck = require(ReplicatedStorage.Shared.Types.ServerLuck)
local v1 = { "RecoveryEvent" }
local v2 = GUI.BottomUI()
local BottomFrame = v2.BottomFrame
local Holder = BottomFrame.Holder
local List = Holder.List
local Luck = List.Luck
local Button = Luck.Button
local TextLabel = Button.Content.Value.TextLabel
local x2Luck = List.x2Luck
local Timer = x2Luck.Timer
local x2Growth = List.x2Growth
local Timer_2 = x2Growth.Timer
local PlayerEarningsBoost_2 = List.PlayerEarningsBoost
local Timer_3 = PlayerEarningsBoost_2.Timer
local Value = PlayerEarningsBoost_2.Value
local PlayerSpeedBoost = List:FindFirstChild("PlayerSpeedBoost")
local v3 = MonsterParasite.BoostMultiplier(MonsterParasite_2.BoostKinds.Speed)
local PlayerEggGrowthBoost = List:FindFirstChild("PlayerEggGrowthBoost")
local v4 = MonsterParasite.BoostMultiplier(MonsterParasite_2.BoostKinds.EggGrowth)
local LocalPlayer = Players.LocalPlayer
local v5 = {
    Countdown = {
        Frame = List:FindFirstChild("Countdown"),
        Tooltip = { { "Title", "SOMETHING BIG COMING SOON!" } }
    },
    DemonicEvent = {
        Frame = List:FindFirstChild("DemonicEvent"),
        Tooltip = { { "Title", "A DEMONIC EGG HAS SPAWNED" } }
    },
    DragonEggEvent = {
        HideTimer = true,
        Frame = List:FindFirstChild("DragonEggEvent"),
        Tooltip = { { "Title", "A DRAGON HAS DESCENDED" } }
    },
    GreatBloom = {
        Frame = List:FindFirstChild("GreatBloom"),
        Tooltip = {
            { "Title", "\240\159\140\184 THE GREAT BLOOM \240\159\140\184" },
            { "Div" },
            { "Title", "Bat Crystal Sakura Trees for Sakura Crystals!" }
        }
    },
    EggLuckBoost = {
        ShowMultiplier = true,
        Frame = List:FindFirstChild("EggLuckBoost"),
        Tooltip = {
            { "Title", "EGG LUCK BOOST" },
            { "Div" },
            { "Title", "Rarer eggs are spawning on the map!" }
        }
    },
    EggSizeBoost = {
        ShowMultiplier = true,
        Frame = List:FindFirstChild("EggSizeBoost"),
        Tooltip = {
            { "Title", "EGG SIZE BOOST" },
            { "Div" },
            { "Title", "Bigger eggs are spawning on the map!" }
        }
    },
    EarningsBoost = {
        ShowMultiplier = true,
        Frame = List:FindFirstChild("EarningsBoost"),
        Tooltip = {
            { "Title", "EARNINGS BOOST" },
            { "Div" },
            { "Title", "Your pets earn more cash!" }
        }
    },
    SpeedBoost = {
        ShowMultiplier = true,
        Frame = List:FindFirstChild("SpeedBoost"),
        Tooltip = {
            { "Title", "SPEED BOOST" },
            { "Div" },
            { "Title", "Everyone runs faster!" }
        }
    },
    MutationBoost = {
        ShowMultiplier = true,
        Frame = List:FindFirstChild("MutationBoost"),
        Tooltip = {
            { "Title", "MUTATION BOOST" },
            { "Div" },
            { "Title", "Mutated eggs are more common!" }
        }
    },
    AdminTreadmill = {
        ShowMultiplier = true,
        Frame = List:FindFirstChild("AdminTreadmill"),
        Tooltip = {
            { "Title", "ADMIN TREADMILL" },
            { "Div" },
            { "Title", "Run on the Admin Treadmill in the base for multiplied speed gains!" }
        }
    },
    MonsterEvent = {
        Frame = List:FindFirstChild("MonsterEvent"),
        Tooltip = { { "Title", "A MONSTER HAS SPAWNED" } }
    }
}
local AnchorPoint = BottomFrame.AnchorPoint
local Position = BottomFrame.Position
local AnchorPoint_2 = Holder.AnchorPoint
local Position_2 = Holder.Position
local AnchorPoint_3 = List.AnchorPoint
local Position_3 = List.Position
local Size = List.Size
local v6 = { Multiplier = 1 }
local v7 = {}
local v8 = {}

local function isBloomUnlocked() -- line 144 | captures: SakuraBloomPolicy, Save
    local v9 = Save.IsLocalDataLoaded()
    local v10
    if v9 then
        v10 = Save.Get()
    end
    return SakuraBloomPolicy.HasBloomUnlocked(v9, v10)
end

local function escapeRichText(v11) -- line 154
    return v11:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
end

local function getMultiplierText() -- line 159 | captures: v6
    local Multiplier = v6.Multiplier
    local v12 = math.floor(Multiplier)
    return (("x%*"):format((math.max(1, v12))))
end

local function getBoosterText() -- line 162 | captures: v6
    local BoostedByDisplayName = v6.BoostedByDisplayName
    if BoostedByDisplayName == nil or BoostedByDisplayName == "" then
        return "<font color=\"#38E839\">@Server</font>"
    end
    return (("<font color=\"#38E839\">@%*</font>"):format((BoostedByDisplayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))))
end

local function formatMultiplier(v13) -- line 171
    local v14 = v13 * 100 + 0.5
    return (("x%*"):format(math.floor(v14) / 100))
end

local function getEventMultiplierText(v15) -- line 175 | captures: v8
    local v16 = v8[v15]
    local v17 = if type(v16) == "table" then v16.Multiplier else nil
    if type(v17) == "number" then
        local v18 = v17 * 100 + 0.5
        return (("x%*"):format(math.floor(v18) / 100))
    end
    return ""
end

local function getRemainingSeconds(v19, v20) -- line 189 | captures: v7
    local v21 = v7[v19]
    if v21 == nil then
        return 0
    end
    local v22 = v21 - v20
    local v23 = math.ceil(v22)
    return (math.max(0, v23))
end

local function getBuffRemainingSeconds(v24) -- line 196 | captures: v1, v7
    local v25 = 0
    for v26, v27 in v1 do
        local v28 = v7[v27]
        local v29
        if v28 == nil then
            v29 = 0
        else
            local v30 = v28 - v24
            local v31 = math.ceil(v30)
            v29 = math.max(0, v31)
        end
        v25 = math.max(v25, v29)
    end
    return v25
end

local function getMonsterBoostSeconds(v32, v33, v34) -- line 214 | captures: MonsterParasite_2
    if v32 == nil then
        return 0
    end
    return MonsterParasite_2.BoostRemainingSeconds(v32.MonsterParasite, v33, v34)
end

local function render(v35) -- line 220 | captures: v6, Workspace, EggRecords, Elapsed, MonsterParasite_2, PlayerEarningsBoost, Sakura, SakuraBloomPolicy, Save, v1, v2, List, Luck, TextLabel, x2Luck, Timer, x2Growth, Timer_2, PlayerEarningsBoost_2, Timer_3, Value, PlayerSpeedBoost, v3, PlayerEggGrowthBoost, v4, LocalPlayer, v5, v7, v8
    local v36 = v35 or Workspace:GetServerTimeNow()
    local v37 = v6.Multiplier > 1
    local v38 = 0
    for v39, v40 in v1 do
        local v41 = v7[v40]
        local v42
        if v41 == nil then
            v42 = 0
        else
            local v43 = v41 - v36
            local v44 = math.ceil(v43)
            v42 = math.max(0, v44)
        end
        v38 = math.max(v38, v42)
    end
    local v45 = v38 > 0
    local v46 = Elapsed(v38)
    Luck.Visible = v37
    local Multiplier = v6.Multiplier
    local v47 = math.floor(Multiplier)
    TextLabel.Text = ("x%*"):format((math.max(1, v47)))
    local Timer_4 = Luck:FindFirstChild("Timer")
    if Timer_4 then
        local v48 = if v6.ExpiresAt then v6.ExpiresAt - v36 else 0
        Timer_4.Visible = v48 > 0
        if v48 <= 0 then
            Timer_4.Text = ""
        else
            Timer_4.Text = Elapsed((math.ceil(v48)))
        end
    end
    x2Luck.Visible = v45
    Timer.Text = v46
    x2Growth.Visible = v45
    Timer_2.Text = v46
    local v49 = EggRecords.ServerGrowthBoostMultiplier() or 0
    local GrowthBoost = List:FindFirstChild("GrowthBoost")
    if v49 <= 0 then
        GrowthBoost.Visible = false
    else
        local Timer = GrowthBoost:FindFirstChild("Timer")
        local Value = GrowthBoost:FindFirstChild("Value")
        local v50 = EggRecords.ServerGrowthBoostEndsAt() - v36
        Timer.Visible = v50 > 0
        if v50 <= 0 then
            Timer.Text = ""
        else
            Timer.Text = Elapsed((math.ceil(v50)))
        end
        GrowthBoost.Visible = true
        Value.Text = ("x%*"):format(v49 + 1)
    end
    local v51 = PlayerEarningsBoost.GetRemainingSeconds(LocalPlayer, v36)
    local v52 = v51 > 0
    PlayerEarningsBoost_2.Visible = v52
    Timer_3.Text = Elapsed((math.ceil(v51)))
    Value.Text = ("x%*"):format(PlayerEarningsBoost.MULTIPLIER)
    local v53
    if Save.IsLocalDataLoaded() then
        v53 = Save.Get()
    end
    local v54
    if v53 == nil then
        v54 = 0
    else
        v54 = MonsterParasite_2.BoostRemainingSeconds(v53.MonsterParasite, MonsterParasite_2.BoostKinds.Speed, v36)
    end
    local v55
    if v53 == nil then
        v55 = 0
    else
        v55 = MonsterParasite_2.BoostRemainingSeconds(v53.MonsterParasite, MonsterParasite_2.BoostKinds.EggGrowth, v36)
    end
    local v56 = v54 > 0
    local v57 = v55 > 0
    if PlayerSpeedBoost then
        PlayerSpeedBoost.Visible = v56
        PlayerSpeedBoost.Timer.Text = Elapsed((math.ceil(v54)))
        local v58 = v3 * 100 + 0.5
        local v59 = math.floor(v58) / 100
        PlayerSpeedBoost.Value.Text = ("x%*"):format(v59)
    end
    if PlayerEggGrowthBoost then
        PlayerEggGrowthBoost.Visible = v57
        PlayerEggGrowthBoost.Timer.Text = Elapsed((math.ceil(v55)))
        local v60 = v4 * 100 + 0.5
        local v61 = math.floor(v60) / 100
        PlayerEggGrowthBoost.Value.Text = ("x%*"):format(v61)
    end
    if not v37 then
        if v45 then
            v37 = v45
        elseif v49 <= 0 then
            v37 = v52 or v56 or v57
        else
            v37 = true
        end
    end
    for v62, v63 in v5 do
        if v63.Frame then
            local v64 = v7[v62]
            local v65
            if v64 == nil then
                v65 = 0
            else
                local v66 = v64 - v36
                local v67 = math.ceil(v66)
                v65 = math.max(0, v67)
            end
            local v68
            if v62 == Sakura.EventName then
                local v69 = Save.IsLocalDataLoaded()
                local v70
                if v69 then
                    v70 = Save.Get()
                end
                v68 = SakuraBloomPolicy.HasBloomUnlocked(v69, v70)
            else
                v68 = true
            end
            if v65 <= 0 then
                v63.Frame.Visible = false
            elseif v68 then
                v63.Frame.Timer.Text = Elapsed(v65)
                local v71 = v63.HideTimer ~= true
                v63.Frame.Timer.Visible = v71
                if v63.ShowMultiplier then
                    local Value = v63.Frame:FindFirstChild("Value")
                    if Value then
                        local v72 = v8[v62]
                        local v73 = if type(v72) == "table" then v72.Multiplier else nil
                        if type(v73) == "number" then
                            local v74 = v73 * 100 + 0.5
                            Value.Text = ("x%*"):format(math.floor(v74) / 100)
                        else
                            Value.Text = ""
                        end
                    end
                end
                v63.Frame.Visible = true
                v37 = true
            end
        end
    end
    v2.Enabled = v37
end

local function renderPlatform(v75) -- line 386 | captures: ClientGlobals, BottomFrame, Holder, List, AnchorPoint, Position, AnchorPoint_2, Position_2, AnchorPoint_3, Position_3, Size
    if ClientGlobals.Mobile then
        BottomFrame.AnchorPoint = Vector2.new(1, 0)
        BottomFrame.Position = UDim2.fromScale(0.98, 0.07)
        Holder.AnchorPoint = Vector2.new(1, 0)
        Holder.Position = UDim2.fromScale(1, 0)
        List.AnchorPoint = Vector2.new(0.5, 0)
        List.Position = UDim2.fromScale(0.5, 0)
        List.Size = UDim2.fromScale(0.975, 0.5)
    else
        BottomFrame.AnchorPoint = AnchorPoint
        BottomFrame.Position = Position
        Holder.AnchorPoint = AnchorPoint_2
        Holder.Position = Position_2
        List.AnchorPoint = AnchorPoint_3
        List.Position = Position_3
        List.Size = Size
    end
end

local function applyState(v76) -- line 405 | captures: v6, render
    v6 = v76
    render()
end

InfoOverlay.Hook(Button, function() -- line 409 | captures: v6
    local v77 = {}
    local Multiplier = v6.Multiplier
    local v78 = math.floor(Multiplier)
    local v79 = {
        "Title",
        (("<font color=\"#38E839\">%*</font> Server Luck!"):format((("x%*"):format((math.max(1, v78))))))
    }
    local v80 = {}
    local BoostedByDisplayName = v6.BoostedByDisplayName
    local v81
    if BoostedByDisplayName == nil or BoostedByDisplayName == "" then
        v81 = "<font color=\"#38E839\">@Server</font>"
    else
        v81 = ("<font color=\"#38E839\">@%*</font>"):format((BoostedByDisplayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")))
    end
    v80[1] = "Title"
    v80[2] = ("Boosted by %*!"):format(v81)
    v77[1] = v79
    v77[2] = { "Div" }
    v77[3] = v80
    return v77
end)
InfoOverlay.Hook(x2Luck.Icon, { { "Title", "X2 LUCK" } })
InfoOverlay.Hook(x2Growth.Icon, { { "Title", "X2 EGG GROWTH SPEED" } })
local GrowthBoost = List:FindFirstChild("GrowthBoost")
InfoOverlay.Hook(GrowthBoost, { { "Title", "GROWTH BOOSTED!" } })
local Icon = PlayerEarningsBoost_2.Icon
local v82 = {}
local v83 = {}
local MULTIPLIER = PlayerEarningsBoost.MULTIPLIER

v83[1] = "Title"
v83[2] = ("X%* EARNINGS"):format(MULTIPLIER)
v82[1] = v83
v82[2] = { "Div" }
v82[3] = { "Title", "Your pets earn double cash!" }
InfoOverlay.Hook(Icon, v82)
PlayerEarningsBoost.GetChangedSignal(LocalPlayer):Connect(function() -- line 452 | captures: render
    render()
end)

if PlayerSpeedBoost then
    InfoOverlay.Hook(PlayerSpeedBoost.Icon, {
        {
            "Title",
            (("X%* SPEED"):format(v3))
        },
        { "Div" },
        { "Title", "You run faster!" }
    })
end

if PlayerEggGrowthBoost then
    InfoOverlay.Hook(PlayerEggGrowthBoost.Icon, {
        {
            "Title",
            (("X%* EGG GROWTH"):format(v4))
        },
        { "Div" },
        { "Title", "Your eggs grow faster!" }
    })
end
for v84, v85 in v5 do
    if v85.Frame then
        InfoOverlay.Hook(v85.Frame.Icon, v85.Tooltip)
    end
end
render()
renderPlatform()
PlatformSignals.Changed:Connect(renderPlatform)
Remotes.LuckWindow.StateRefreshed.OnClientEvent:Connect(function(v86) -- line 480 | captures: v6, ServerLuck, render
    if ServerLuck.State(v86) then
        v6 = v86
        render()
    end
end)
local v87 = Remotes.LuckWindow.FetchState:InvokeServer()

if ServerLuck.State(v87) then
    render()
end
Remotes.LiveEvents.Began.OnClientEvent:Connect(function(v88, v89, v90) -- line 490 | captures: Workspace, v7, v8, render
    v7[v88] = Workspace:GetServerTimeNow() + v89
    v8[v88] = v90
    render()
end)
Remotes.LiveEvents.Ended.OnClientEvent:Connect(function(v91) -- line 495 | captures: v7, v8, render
    v7[v91] = nil
    v8[v91] = nil
    render()
end)
Save.WatchFields("Sakura", function() -- line 500 | captures: render
    render()
end)
Save.WatchFields("MonsterParasite", function() -- line 503 | captures: render
    render()
end)
local v92, v93 = Remotes.LiveEvents.FetchRunning:InvokeServer()

if not v93 then
    local v94 = {}
end
render()
task.spawn(function() -- line 512 | captures: render
    while true do
        task.wait(1)
        render()
    end
end)
