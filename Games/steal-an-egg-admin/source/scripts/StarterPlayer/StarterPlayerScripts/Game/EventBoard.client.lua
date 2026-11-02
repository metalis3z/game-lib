-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SocialService = game:GetService("SocialService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local EventBoardView = require(ReplicatedStorage.Shared.Modules.EventBoardView)
local Log = require(ReplicatedStorage.Packages.Log)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local LocalPlayer = Players.LocalPlayer
local v1 = Log.new()
local v2 = {}
local v3 = false
local v4, Id, TextLabel, Sound, v5, v6

local function setShown(v7, v8) -- line 25
    for v9, v10 in v7:GetDescendants() do
        if v10:IsA("BasePart") then
            local BoardClear = v10:GetAttribute("BoardClear")
            if v8 then
                if typeof(BoardClear) ~= "number" then
                    BoardClear = 0
                end
            else
                BoardClear = 1
            end
            v10.Transparency = BoardClear
        elseif v10:IsA("SurfaceGui") or v10:IsA("ProximityPrompt") then
            v10.Enabled = v8
        end
    end
end

local function getOwnBoard() -- line 46 | captures: Workspace, PlotState
    local v11 = PlotState.ResolveLocalSlot()
    if v11 ~= nil then
        local Plots = Workspace:FindFirstChild("Plots")
        local v12
        if Plots == nil then
        else
            v12 = Plots:FindFirstChild((tostring(v11)))
        end
        local v13
        if v12 == nil then
        else
            v13 = v12:FindFirstChild("EventBoard")
        end
        if v13 ~= nil and v13:IsA("Model") then
            return v13
        end
    end
    return nil
end

local function formatTimer(v14) -- line 71 | captures: EventBoardView
    return (("NEXT UPDATE\n%*"):format((EventBoardView.Countdown(v14.StartsAt - os.time()))))
end

local function takeDown() -- line 74 | captures: v4, Id, TextLabel, Sound, v2, setShown
    for v15, v16 in v2 do
        v16:Disconnect()
    end
    table.clear(v2)
    if TextLabel ~= nil then
        TextLabel:Destroy()
        TextLabel = nil
    end
    if Sound ~= nil then
        Sound:Destroy()
        Sound = nil
    end
    local v17 = v4
    if v17 ~= nil and v17.Parent ~= nil then
        setShown(v17, false)
    end
    v4 = nil
    Id = nil
end

local function onTriggered(v18) -- line 97 | captures: v3, SocialService, v1, takeDown
    if v3 then
        return
    end
    v3 = true
    local v19, v20 = pcall(SocialService.PromptRsvpToEventAsync, SocialService, v18.Id)
    if v19 then
        local v21, v22 = pcall(SocialService.GetEventRsvpStatusAsync, SocialService, v18.Id)
        if v21 and v22 == Enum.RsvpStatus.Going then
            takeDown()
        end
    else
        v1:AtWarning():Log((("EventBoard RSVP prompt failed: %*"):format(v20)))
    end
    v3 = false
end

local function mount(v23, v24) -- line 115 | captures: v4, Id, TextLabel, Sound, v5, RunService, SoundService, EventBoardView, LocalPlayer, v1, v2, setShown, onTriggered
    local function v25(v26, ...)
        table.insert(v26, ...)
    end

    local function v27(v28, ...)
        table.insert(v28, ...)
    end

    setShown(v24, true)
    local Display = v24:FindFirstChild("Display")
    local v29
    if Display == nil then
    else
        v29 = Display:FindFirstChildWhichIsA("SurfaceGui")
    end
    if v29 ~= nil then
        local v30 = v29:FindFirstChild("Frame") or v29
        local EventCountdown = v30:FindFirstChild("EventCountdown")
        if EventCountdown ~= nil then
            EventCountdown:Destroy()
        end
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "EventCountdown"
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel_2.Position = UDim2.fromScale(0.5, 0.5)
        TextLabel_2.Size = UDim2.fromScale(0.9, 0.45)
        TextLabel_2.TextScaled = true
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        local StartsAt = v23.StartsAt
        TextLabel_2.Text = ("NEXT UPDATE\n%*"):format((EventBoardView.Countdown(StartsAt - os.time())))
        TextLabel_2.ZIndex = 5
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 3
        UIStroke.Color = Color3.fromRGB(0, 0, 0)
        UIStroke.Parent = TextLabel_2
        TextLabel_2.Parent = v30
        TextLabel = TextLabel_2
    end
    local v31 = v24:FindFirstChildWhichIsA("ProximityPrompt", true)
    if v31 == nil then
        v1:AtWarning():Log("EventBoard has no ProximityPrompt, sign-up is display only")
    else
        v31.RequiresLineOfSight = false
        v31.MaxActivationDistance = EventBoardView.PromptDistance
        v31.HoldDuration = 0
        if v23.Title ~= "" then
            v31.ObjectText = v23.Title
        end
        if v31.ActionText == "" then
            v31.ActionText = "Follow Event"
        end
        local Triggered = v31.Triggered
        v25(v2, Triggered:Connect(function(v32) -- line 161 | captures: v23, LocalPlayer, onTriggered
            if v32 == LocalPlayer then
                task.spawn(onTriggered, v23)
            end
        end))
    end
    if Display ~= nil and Display:IsA("BasePart") then
        local Sound_2 = Instance.new("Sound")
        Sound_2.Name = "EventBoardAmbience"
        Sound_2.SoundId = "rbxassetid://111368755766526"
        Sound_2.Looped = true
        Sound_2.Volume = 0.5
        Sound_2.RollOffMode = Enum.RollOffMode.Linear
        Sound_2.RollOffMinDistance = 4
        Sound_2.RollOffMaxDistance = 14
        Sound_2.SoundGroup = SoundService:FindFirstChild("Default")
        Sound_2.Parent = Display
        Sound = Sound_2
        local Heartbeat = RunService.Heartbeat
        v27(v2, Heartbeat:Connect(function() -- line 179 | captures: Display, Sound_2, LocalPlayer
            local Character = LocalPlayer.Character
            local v33
            if Character == nil then
            else
                v33 = Character:FindFirstChild("HumanoidRootPart")
            end
            if v33 ~= nil and v33:IsA("BasePart") and (v33.Position - Display.Position).Magnitude <= 14 then
                if not Sound_2.IsPlaying then
                    Sound_2:Play()
                end
            elseif Sound_2.IsPlaying then
                Sound_2:Stop()
            end
        end))
    end
    v4 = v24
    Id = v23.Id
    v5 = nil
    local Id_2 = v23.Id
    v1:AtInfo():Log((("EventBoard mounted for event %*"):format(Id_2)))
end

local function reportBail(v34) -- line 215 | captures: v5, v1
    if v5 ~= v34 then
        v5 = v34
        v1:AtInfo():Log((("EventBoard hidden: %*"):format(v34)))
    end
end

local function isVariantServer() -- line 222 | captures: Workspace
    return Workspace:GetAttribute("ExpandedLobbyServerGroup") == "Variant"
end

local function waitForVariantServer() -- line 226 | captures: Workspace
    while Workspace:GetAttribute("ExpandedLobbyServerGroup") == nil do
        local v35 = os.clock()
        if os.clock() + 60 <= v35 then
            break
        end
        task.wait(0.5)
    end
    return Workspace:GetAttribute("ExpandedLobbyServerGroup") == "Variant"
end

local function apply() -- line 236 | captures: v3, v4, Id, v5, v6, Workspace, EventBoardView, PlotState, v1, getOwnBoard, takeDown, mount
    local function v36(...)
        return (tostring(...))
    end

    local function v37(...)
        return (tostring(...))
    end

    local function v38(...)
        return (tostring(...))
    end

    if v3 then
        return
    end
    if v4 ~= nil and v4.Parent == nil then
        takeDown()
    end
    local v39 = v6
    if Workspace:GetAttribute("ExpandedLobbyServerGroup") == "Variant" then
        if v39 == nil then
            if v5 ~= "no upcoming event (none active and not yet started for this universe)" then
                v5 = "no upcoming event (none active and not yet started for this universe)"
                v1:AtInfo():Log("EventBoard hidden: no upcoming event (none active and not yet started for this universe)")
            end
            takeDown()
        elseif EventBoardView.ShouldShow(v39) then
            if v4 == nil then
                local v40 = getOwnBoard()
                if v40 == nil then
                    local v41 = ("no EventBoard model found on plot %*"):format((v37(PlotState.ResolveLocalSlot())))
                    if v5 ~= v41 then
                        v5 = v41
                        v1:AtInfo():Log((("EventBoard hidden: %*"):format(v41)))
                    end
                else
                    takeDown()
                    mount(v39, v40)
                end
            elseif Id ~= v39.Id then
                local v42 = getOwnBoard()
                if v42 == nil then
                    local v43 = ("no EventBoard model found on plot %*"):format((v38(PlotState.ResolveLocalSlot())))
                    if v5 ~= v43 then
                        v5 = v43
                        v1:AtInfo():Log((("EventBoard hidden: %*"):format(v43)))
                    end
                else
                    takeDown()
                    mount(v39, v42)
                end
            end
        else
            local v44 = ("event %* hidden: player is already going"):format(v39.Id)
            if v5 ~= v44 then
                v5 = v44
                v1:AtInfo():Log((("EventBoard hidden: %*"):format(v44)))
            end
            takeDown()
        end
    else
        local v45 = ("server group is %*, not Variant"):format((v36(Workspace:GetAttribute("ExpandedLobbyServerGroup"))))
        if v5 ~= v45 then
            v5 = v45
            v1:AtInfo():Log((("EventBoard hidden: %*"):format(v45)))
        end
        takeDown()
    end
end

local function refreshUpcoming() -- line 303 | captures: v6, SocialService, EventBoardView, v1
    local v46, v47 = pcall(function() -- line 305 | captures: SocialService
        return SocialService:GetUpcomingExperienceEventsAsync()
    end)
    if v46 then
        v6 = EventBoardView.Pick(v47, os.time())
        return true
    end
    v1:AtWarning():Log((("EventBoard failed to fetch experience events: %*"):format(v47)))
    return false
end

task.spawn(function() -- line 315 | captures: v4, TextLabel, v6, Workspace, EventBoardView, PlotState, v1, waitForVariantServer, apply, refreshUpcoming
    local function v48(...)
        return (tostring(...))
    end

    if waitForVariantServer() then
        PlotState.LocalPlotChanged:Connect(function() -- line 320 | captures: apply
            apply()
        end)
        task.spawn(function() -- line 323 | captures: EventBoardView, apply, refreshUpcoming
            while true do
                apply()
                if refreshUpcoming() then
                    local RefreshSeconds = EventBoardView.RefreshSeconds
                else
                    task.wait(EventBoardView.RetryBackoffSeconds)
                end
            end
        end)
        task.spawn(function() -- line 334 | captures: TextLabel, v6, EventBoardView
            while true do
                task.wait(EventBoardView.TimerUpdateSeconds)
                local TextLabel_2 = TextLabel
                local v49 = v6
                if TextLabel_2 ~= nil and TextLabel_2.Parent ~= nil and v49 ~= nil then
                    TextLabel_2.Text = ("NEXT UPDATE\n%*"):format((EventBoardView.Countdown(v49.StartsAt - os.time())))
                end
            end
        end)
        task.spawn(function() -- line 345 | captures: v4, v6, apply
            while true do
                task.wait(5)
                if v6 == nil then
                    continue
                end
                if v4 == nil or v4.Parent == nil then
                end
                apply()
            end
        end)
    else
        v1:AtInfo():Log((("EventBoard idle, server group is %*"):format((v48(Workspace:GetAttribute("ExpandedLobbyServerGroup"))))))
    end
end)
