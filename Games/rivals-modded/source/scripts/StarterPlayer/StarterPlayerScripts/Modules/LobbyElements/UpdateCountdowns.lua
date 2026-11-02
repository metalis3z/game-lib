-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local SocialService = game:GetService("SocialService");
local Players = game:GetService("Players");
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 14
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3._models = {};
    v3._countdown_hash = 0;
    v3._next_event_details = nil;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 30
    if not p4._next_event_details then
        return;
    end;

    for _, v in pairs(p4._models) do
        local Vector3_new_ret = Vector3.new(workspace.CurrentCamera.CFrame.X, v.CountdownCFrame.Y + (workspace.CurrentCamera.CFrame.Y - v.CountdownCFrame.Y) / 2, workspace.CurrentCamera.CFrame.Z);
        v.CountdownPart.CFrame = CFrame.new(v.CountdownCFrame.Position, Vector3_new_ret) * CFrame.Angles(0.2617993877991494, 0, 0);
    end;
end;

function u1._GetDateTime(p6, p7) -- Line: 50
    return DateTime.fromUniversalTime(p7.Year, p7.Month, p7.Day, p7.Hour, p7.Minute, p7.Second, p7.Millisecond);
end;

function u1._UpdateCountdown(u8) -- Line: 62
    -- upvalues: PlayerDataController (copy), SocialService (copy), ServerOsTime (copy), Utility (copy)
    for i, v in pairs(u8._models) do
        v.CountdownModel.Parent = nil;
        v.LogoModel.Parent = i;
    end;

    u8._next_event = nil;
    u8._countdown_hash = u8._countdown_hash + 1;
    local _countdown_hash = u8._countdown_hash;

    if PlayerDataController:GetStatistic("StatisticDuelsPlayed") < 10 then
        return;
    end;

    local success, result = pcall(SocialService.GetUpcomingExperienceEventsAsync, SocialService);

    if not success then
        warn("Failed to fetch upcoming events, error:", result);

        return;
    end;

    if u8._countdown_hash ~= _countdown_hash then
        return;
    end;

    table.sort(result, function(p9, p10) -- Line: 88
        -- upvalues: u8 (copy)
        local v11 = u8:_GetDateTime(p9.StartTime);
        local v12 = u8:_GetDateTime(p10.StartTime);

        return v11.UnixTimestamp < v12.UnixTimestamp;
    end);
    local v13 = nil;

    for _, v in pairs(result) do
        if not (v.HasStarted or (v.HasEnded or v.Status ~= Enum.ExperienceEventStatus.Active)) then
            v13 = v;
            break;
        end;
    end;

    if not v13 then
        return;
    end;

    local success2, result2 = pcall(SocialService.GetExperienceEventAsync, SocialService, v13.Id);

    if not success2 then
        warn("Failed to fetch event details, error:", result);

        return;
    end;

    if u8._countdown_hash ~= _countdown_hash then
        return;
    end;

    u8._next_event_details = result2;

    for i, v in pairs(u8._models) do
        v.CountdownModel.Parent = i;
        v.LogoModel.Parent = nil;
        v.CountdownTitle.Text = string.upper(u8._next_event_details.Title);
    end;

    local v14 = u8:_GetDateTime(u8._next_event_details.StartTime);

    while true do
        local v15 = v14.UnixTimestamp - ServerOsTime:Get();
        local math_ceil_ret = math.ceil(v15);

        for _, v in pairs(u8._models) do
            v.CountdownText.Text = math_ceil_ret <= 0 and "ANY SECOND NOW" or Utility:TimeFormat2(math_ceil_ret);
        end;

        wait(1);

        if u8._countdown_hash ~= _countdown_hash then
            return;
        end;
    end;
end;

function u1._ModelAdded(u16, p17) -- Line: 147
    -- upvalues: SocialService (copy)
    p17:WaitForChild("Countdown"):PivotTo(p17:WaitForChild("Countdown"):GetPivot() + Vector3.new(0, 100, 0));
    local v18 = {
        CountdownModel = p17:WaitForChild("Countdown"),
        CountdownPart = p17:WaitForChild("Countdown"):WaitForChild("Part"),
        CountdownCFrame = p17:WaitForChild("Countdown"):WaitForChild("Part").CFrame,
        CountdownTitle = p17:WaitForChild("Countdown"):WaitForChild("Part"):WaitForChild("SurfaceGui"):WaitForChild("Title"),
        CountdownText = p17:WaitForChild("Countdown"):WaitForChild("Part"):WaitForChild("SurfaceGui"):WaitForChild("Countdown"),
        LogoModel = p17:WaitForChild("Logo")
    };
    u16._models[p17] = v18;
    p17:WaitForChild("Countdown"):WaitForChild("Prompt"):WaitForChild("ProximityPrompt").Triggered:Connect(function() -- Line: 161
        -- upvalues: u16 (copy), SocialService (ref)
        if u16._next_event_details then
            local success, result = pcall(SocialService.PromptRsvpToEventAsync, SocialService, u16._next_event_details.Id);

            if not success then
                warn("Failed to prompt event RSVP, error:", result);
            end;
        end;
    end);
    u16:_UpdateCountdown();
end;

function u1._Init(u19) -- Line: 174
    -- upvalues: PlayerDataController (copy), CollectionService (copy)
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 175
        -- upvalues: u19 (copy)
        u19:_UpdateCountdown();
    end);
    CollectionService:GetInstanceAddedSignal("LobbyUpdateCountdown"):Connect(function(p20) -- Line: 179
        -- upvalues: u19 (copy)
        u19:_ModelAdded(p20);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyUpdateCountdown")) do
        task.defer(u19._ModelAdded, u19, v);
    end;
end;

return u1._new();