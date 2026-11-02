-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SocialService = game:GetService("SocialService");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.CanSendGameInviteChanged = Signal.new();
    v2.FriendsFetched = Signal.new();
    v2.CanSendGameInvite = nil;
    v2.Friends = {};
    v2._is_friends_with = {};
    v2:_Init();

    return v2;
end;

function u1.IsFriendsWith(p3, p4) -- Line: 31
    -- upvalues: Players (copy)
    local v5 = p3._is_friends_with[tostring(p4)];

    if v5 then
        return v5;
    end;

    local success, result = pcall(Players.LocalPlayer.IsFriendsWithAsync, Players.LocalPlayer, p4);

    if success then
        return result;
    end;

    warn("Failed to check IsFriendsWithAsync, error:", result);

    return false;
end;

function u1.PromptFriendInvite(p6) -- Line: 48
    -- upvalues: HttpService (copy), ReplicatedStorage (copy), SocialService (copy), Players (copy)
    local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
    ExperienceInviteOptions.PromptMessage = "Challenge your friends to a duel!";
    ExperienceInviteOptions.InviteMessageId = "1dc4ba3b-4978-ea4f-9c63-35babfc20045";
    ExperienceInviteOptions.LaunchData = HttpService:JSONEncode({
        SenderHash = ReplicatedStorage.Remotes.Misc.RequestInviteData:InvokeServer()
    });
    SocialService:PromptGameInvite(Players.LocalPlayer, ExperienceInviteOptions);
end;

function u1._FetchFriends(p7) -- Line: 61
    -- upvalues: Players (copy)
    for i = 1, 3 do
        local success, result = pcall(Players.LocalPlayer.GetFriendsOnlineAsync, Players.LocalPlayer, 50);

        if success then
            p7.Friends = result;
            break;
        end;

        warn("Failed to fetch GetFriendsOnlineAsync, error:", result);
        wait(1);
        local _ = i;
    end;

    for _, v in pairs(p7.Friends) do
        p7._is_friends_with[tostring(v.VisitorId)] = true;
    end;

    p7.FriendsFetched:Fire();
end;

function u1._FetchCanSendGameInvite(p8) -- Line: 82
    -- upvalues: SocialService (copy), Players (copy)
    for i = 1, 3 do
        local success, result = pcall(SocialService.CanSendGameInviteAsync, SocialService, Players.LocalPlayer);

        if success then
            p8.CanSendGameInvite = result;
            break;
        end;

        warn("Failed to fetch CanSendGameInviteAsync:", result);
        wait(1);
        local _ = i;
    end;

    p8.CanSendGameInviteChanged:Fire();
end;

function u1._Init(p9) -- Line: 99
    task.defer(p9._FetchFriends, p9);
    task.defer(p9._FetchCanSendGameInvite, p9);
end;

return u1._new();