-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local ExpandedLobby = require(ReplicatedStorage.Data.ExpandedLobby)
local ExperienceEventPromptPolicy = require(ReplicatedStorage.Shared.Modules.ExperienceEventPromptPolicy)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Timer = require(ReplicatedStorage.Packages.Timer)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = Trove.new()
local v2 = {}
local v3 = false
local v4 = false
local v5 = false
local v6 = 0

local function IsExpandedLobbyServer() -- line 25 | captures: Workspace, ExpandedLobby
    return Workspace:GetAttribute(ExpandedLobby.ServerAttribute) == ExpandedLobby.Groups.Variant
end

local function IsInSafeArea() -- line 30 | captures: ExperienceEventPromptPolicy, Player, ToolGameplayGuard, LocalPlayer
    if Player.Optional.HumanoidRootPart(LocalPlayer) then
        return ExperienceEventPromptPolicy.IsSafeToPrompt(true, ToolGameplayGuard.IsLocalInsideArena())
    end
    return false
end

local function GetSoonestUnseenEvent() -- line 36 | captures: SocialService, ExperienceEventPromptPolicy, v2
    local v7, v8 = pcall(function() -- line 38 | captures: SocialService
        return SocialService:GetUpcomingExperienceEventsAsync()
    end)
    if v7 then
        if type(v8) == "table" then
            return ExperienceEventPromptPolicy.GetSoonestUnseenEvent(v8, v2), true
        end
    else
        warn((("Failed to get upcoming experience events: %*"):format(v8)))
    end
    return nil, false
end

local function MarkSeen(v9) -- line 56 | captures: Remotes, v2
    v2[v9] = true
    local v10, v11 = pcall(function() -- line 59 | captures: v9, Remotes
        return Remotes.SeasonBanner.FlagSeen:InvokeServer(v9)
    end)
    if v10 then
        if v11 ~= true then
            warn((("Server rejected experience event prompt acknowledgement for %*"):format(v9)))
        end
    else
        warn((("Failed to mark experience event prompt as seen: %*"):format(v11)))
    end
end

local function PromptSoonestEvent() -- line 70 | captures: SocialService, ExperienceEventPromptPolicy, Player, ToolGameplayGuard, LocalPlayer, GetSoonestUnseenEvent, MarkSeen
    local v12, v13 = GetSoonestUnseenEvent()
    if v13 and v12 then
        local v14, v15 = pcall(SocialService.GetEventRsvpStatusAsync, SocialService, v12.Id)
        if v14 then
            if v15 == Enum.RsvpStatus.None then
                if Player.Optional.HumanoidRootPart(LocalPlayer) and ExperienceEventPromptPolicy.IsSafeToPrompt(true, ToolGameplayGuard.IsLocalInsideArena()) then
                    local v16, v17 = pcall(SocialService.PromptRsvpToEventAsync, SocialService, v12.Id)
                    if v16 then
                        MarkSeen(v12.Id)
                        return "Complete"
                    end
                    warn((("Failed to prompt for experience event RSVP: %*"):format(v17)))
                    return "Retry"
                end
                return "WaitForSafeArea"
            end
            MarkSeen(v12.Id)
            return "Complete"
        end
        warn((("Failed to get experience event RSVP status: %*"):format(v15)))
    end
    return "Retry"
end

local v18 = v1:Add(Timer.new(0.1))
local v19 = v1:Add(Timer.new(ExperienceEventPromptPolicy.RetryDelaySeconds))

local function u82() -- line 103 | captures: v18
    if not v18:IsRunning() then
        v18:Start()
    end
end

local function u83() -- line 108 | captures: v6, ExperienceEventPromptPolicy, v19
    v6 += 1
    if ExperienceEventPromptPolicy.MaxAttempts <= v6 then
        warn((("Experience event prompt stopped after %* failed attempts"):format(v6)))
    elseif not v19:IsRunning() then
        v19:Start()
    end
end

local function u84() -- line 118 | captures: v3, v4, v5, v6, Workspace, ExpandedLobby, ExperienceEventPromptPolicy, Player, Remotes, ToolGameplayGuard, LocalPlayer, v2, PromptSoonestEvent, v18, v19
    if not v5 then
        v5 = true
        if v3 then
            if v4 then
                if Workspace:GetAttribute(ExpandedLobby.ServerAttribute) == ExpandedLobby.Groups.Variant then
                    v5 = false
                elseif Player.Optional.HumanoidRootPart(LocalPlayer) and ExperienceEventPromptPolicy.IsSafeToPrompt(true, ToolGameplayGuard.IsLocalInsideArena()) then
                    local v20 = PromptSoonestEvent()
                    v5 = false
                    if v20 == "Retry" then
                        v6 += 1
                        if ExperienceEventPromptPolicy.MaxAttempts <= v6 then
                            warn((("Experience event prompt stopped after %* failed attempts"):format(v6)))
                        elseif not v19:IsRunning() then
                            v19:Start()
                        end
                    elseif v20 == "WaitForSafeArea" and not v18:IsRunning() then
                        v18:Start()
                    end
                else
                    v5 = false
                    if not v18:IsRunning() then
                        v18:Start()
                    end
                end
            else
                v5 = false
            end
        else
            local v21, v22, v23 = pcall(function() -- line 157 | captures: Remotes
                return Remotes.SeasonBanner.FetchState:InvokeServer()
            end)
            if v21 then
                if type(v22) == "boolean" and type(v23) == "table" then
                    v3 = true
                    v4 = v22
                    v6 = 0
                    for v24, v25 in v23 do
                        if type(v24) == "string" and v25 == true then
                            v2[v24] = true
                        end
                    end
                else
                    v5 = false
                    v6 += 1
                    if ExperienceEventPromptPolicy.MaxAttempts <= v6 then
                        warn((("Experience event prompt stopped after %* failed attempts"):format(v6)))
                    elseif not v19:IsRunning() then
                        v19:Start()
                    end
                end
            else
                warn((("Failed to get experience event prompt state: %*"):format(v22)))
                v5 = false
                v6 += 1
                if ExperienceEventPromptPolicy.MaxAttempts <= v6 then
                    warn((("Experience event prompt stopped after %* failed attempts"):format(v6)))
                elseif not v19:IsRunning() then
                    v19:Start()
                end
            end
        end
    end
end

v1:Connect(v18.Tick, function() -- line 197 | captures: ExperienceEventPromptPolicy, Player, ToolGameplayGuard, LocalPlayer, v18, u84
    if Player.Optional.HumanoidRootPart(LocalPlayer) and ExperienceEventPromptPolicy.IsSafeToPrompt(true, ToolGameplayGuard.IsLocalInsideArena()) then
        v18:Stop()
        u84()
    end
end)
v1:Connect(v19.Tick, function() -- line 210 | captures: v19, u84
    v19:Stop()
    u84()
end)
local v26 = v1:Add(Timer.new(ExperienceEventPromptPolicy.PromptDelaySeconds))
v1:Connect(v26.Tick, function() -- line 215 | captures: u84, v26
    v26:Stop()
    u84()
end)
v1:AttachToInstance(script)
v26:Start()
