-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local HttpService = game:GetService("HttpService");
local StarterGui = game:GetService("StarterGui");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PlayerDataUtility = require(ReplicatedStorage.Modules.PlayerDataUtility);
require(ReplicatedStorage.Modules.DebugLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers.MatchmakingController);
local LeaderboardController = require(Players.LocalPlayer.PlayerScripts.Controllers.LeaderboardController);
require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SocialController = require(Players.LocalPlayer.PlayerScripts.Controllers.SocialController);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local PlayerListSlot = Players.LocalPlayer.PlayerScripts.UserInterface.PlayerListSlot;
local u1 = { 0.45, "rbxassetid://89686341813708" };
local u2 = { 0.625, "rbxassetid://140099562989635" };
local u3 = { 0.45, "rbxassetid://114408044569826" };
local u4 = { 0.6, "rbxassetid://134084662516990" };
local u5 = { 0.5, "rbxassetid://108431611670429" };
local u6 = { 0.5, "rbxassetid://104322490200835" };
local u7 = { 0.4, "rbxassetid://97625610157994" };
local u8 = { 0.5, "rbxassetid://118031781381166" };
local u9 = { 0.4, "rbxassetid://105897927" };
local u10 = { 0.6, "rbxassetid://113059239" };
local u11 = { 0.6, "rbxassetid://134032333" };
local u12 = {};
u12.__index = u12;

function u12.new(p13, p14) -- Line: 38
    -- upvalues: u12 (copy), Signal (copy), PlayerListSlot (copy)
    local v15 = setmetatable({}, u12);
    v15.Clicked = Signal.new();
    v15.Elements = p13;
    v15.ClientFighter = p14;
    v15.Frame = PlayerListSlot:Clone();
    v15.Button = v15.Frame:WaitForChild("Button");
    v15.RequestsFrame = v15.Frame:WaitForChild("Requests");
    v15.HighlightFrame = v15.Frame:WaitForChild("Highlight");
    v15.LeaderstatFrame = v15.Frame:WaitForChild("Leaderstat");
    v15.LeaderstatTitle = v15.LeaderstatFrame:WaitForChild("Title");
    v15.LeaderstatRankContainer = v15.LeaderstatFrame:WaitForChild("RankContainer");
    v15.PlayerContainer = v15.Frame:WaitForChild("Player"):WaitForChild("Container");
    v15.PlayerIcon = v15.PlayerContainer:WaitForChild("Icon");
    v15.PlayerTitle = v15.PlayerContainer:WaitForChild("Title");
    v15.PlayerTitleIcon = v15.PlayerTitle:WaitForChild("Icon");
    v15._connections = {};
    v15._is_highlighted = false;
    v15._is_hovered = false;
    v15._leaderstat_name = nil;
    v15._leaderstat_rank_icon = nil;
    v15._is_friend = nil;
    v15._is_blocked = nil;
    v15._request_effect_threads = {};
    v15:_Init();

    return v15;
end;

function u12.IsFriend(p16) -- Line: 75
    return p16._is_friend;
end;

function u12.IsBlocked(p17) -- Line: 79
    return p17._is_blocked;
end;

function u12.SetParent(p18, p19) -- Line: 83
    p18.Frame.Parent = p19;
end;

function u12.SetLeaderstat(p20, p21) -- Line: 87
    p20._leaderstat_name = p21;
    p20:_UpdateLeaderstat();
end;

function u12.SetHighlighted(p22, p23) -- Line: 92
    p22._is_highlighted = p23;
    p22:_UpdateHighlight();
end;

function u12.SetIsFriend(p24, p25) -- Line: 97
    if p24._is_friend == p25 then
        return;
    end;

    p24._is_friend = p25;
    p24:_UpdateIcon();
end;

function u12.SetIsBlocked(p26, p27) -- Line: 106
    if p26._is_blocked == p27 then
        return;
    end;

    p26._is_blocked = p27;
    p26:_UpdateIcon();
end;

function u12.SetRequestDuration(u28, u29, u30) -- Line: 115
    -- upvalues: RunService (copy)
    if u28._request_effect_threads[u29] then
        task.cancel(u28._request_effect_threads[u29]);
        u28._request_effect_threads[u29] = nil;
    end;

    u28._request_effect_threads[u29] = task.spawn(function() -- Line: 121
        -- upvalues: u30 (copy), u28 (copy), u29 (copy), RunService (ref)
        local v31 = tick() + u30;
        local v32 = u28.RequestsFrame[u29];
        local UIGradient = v32.UIStroke.UIGradient;
        v32.Visible = true;

        while tick() < v31 do
            UIGradient.Rotation = tick() * 90 % 360;
            RunService.RenderStepped:Wait();
        end;

        v32.Visible = false;
    end);
end;

function u12.OnOpened(p33) -- Line: 137
    p33:_UpdateLeaderstat();
    p33:_UpdateIcon();
    p33:_UpdateVisuals();
    p33:_UpdateStatus();
end;

function u12.Destroy(p34) -- Line: 144
    for _, v in pairs(p34._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p34._request_effect_threads) do
        pcall(task.cancel, v);
    end;

    if p34._leaderstat_rank_icon then
        p34._leaderstat_rank_icon:Destroy();
        p34._leaderstat_rank_icon = nil;
    end;

    p34.Clicked:Destroy();
    p34.Frame:Destroy();
end;

function u12._UpdateVisuals(u35) -- Line: 166
    if not u35.Elements.PlayerList.IsOpen then
        return;
    end;

    task.delay(0, function() -- Line: 172
        -- upvalues: u35 (copy)
        u35.PlayerTitleIcon.Position = UDim2.new(0, u35.PlayerTitle.TextBounds.X, 0.5, 0);
    end);
end;

function u12._UpdateIcon(p36) -- Line: 177
    -- upvalues: u7 (copy), u8 (copy), u9 (copy), u10 (copy), u11 (copy), u1 (copy), PlayerDataUtility (copy), HttpService (copy), u2 (copy), u3 (copy), u4 (copy), u6 (copy), u5 (copy), CONSTANTS (copy)
    if not p36.Elements.PlayerList.IsOpen then
        return;
    end;

    local v37;

    if p36._is_blocked then
        v37 = u7;
    elseif p36._is_friend then
        v37 = u8;
    elseif p36.ClientFighter.Player.UserId == 261 then
        v37 = u9;
    elseif p36.ClientFighter.Player.UserId == 13268404 then
        v37 = u10;
    elseif p36.ClientFighter.Player.UserId == 7210880 then
        v37 = u11;
    elseif p36.ClientFighter.Player:GetAttribute("DisableTeamVisuals") or not p36.ClientFighter.Player:GetAttribute("IsAdministrator") then
        if p36.ClientFighter.Player:GetAttribute("DisableTeamVisuals") or not PlayerDataUtility:IsNosniyGamesTeamMemberRaw(HttpService:JSONDecode(p36.ClientFighter.Player:GetAttribute("GroupRoleIDs") or {})) then
            if p36.ClientFighter.Player:GetAttribute("IsRobloxEmployee") then
                v37 = u3;
            elseif p36.ClientFighter.Player:GetAttribute("IsInfluencer") then
                v37 = u4;
            elseif p36.ClientFighter.Player.HasRobloxSubscription then
                v37 = u6;
            elseif p36.ClientFighter.Player.MembershipType == Enum.MembershipType.Premium then
                v37 = u5;
            else
                v37 = nil;
            end;
        else
            v37 = u2;
        end;
    else
        v37 = u1;
    end;

    p36.PlayerIcon.Image = v37 and (v37[2] or "") or "";
    p36.PlayerIcon.Size = v37 and UDim2.new(v37[1], 0, v37[1], 0) or UDim2.new(0, 0, 0, 0);
    p36.PlayerTitleIcon.Image = CONSTANTS.CONTROLS_IMAGES_CENTERED[p36.ClientFighter:Get("Controls")] or "";
end;

function u12._UpdateStatus(p38) -- Line: 200
    -- upvalues: WeaponStatusHandler (copy)
    if not p38.Elements.PlayerList.IsOpen then
        return;
    end;

    WeaponStatusHandler:ClearStatusElements(p38.PlayerTitle);
    WeaponStatusHandler:ApplyItemStatusToText(p38.PlayerTitle, p38.ClientFighter.Player:GetAttribute("PlayerStatus"));
end;

function u12._UpdateLeaderstat(p39) -- Line: 209
    -- upvalues: CONSTANTS (copy), MatchmakingController (copy), RankIcon (copy), Utility (copy)
    if not p39.Elements.PlayerList.IsOpen then
        return;
    end;

    if p39._leaderstat_rank_icon then
        p39._leaderstat_rank_icon:Destroy();
        p39._leaderstat_rank_icon = nil;
    end;

    local v40 = p39._leaderstat_name and p39.ClientFighter.Player:FindFirstChild("CustomLeaderstats") and p39.ClientFighter.Player.CustomLeaderstats:FindFirstChild(p39._leaderstat_name);
    p39.Frame.LayoutOrder = v40 and (-v40.Value or 1) or 1;

    if not v40 or v40:GetAttribute("StillLoading") then
        p39.LeaderstatTitle.Text = "• • •";

        return;
    end;

    if p39._leaderstat_name ~= "Current ELO" then
        p39.LeaderstatTitle.Text = not v40.Value and "• • •" or Utility:PrettyNumber(v40.Value);

        return;
    end;

    p39.LeaderstatTitle.Text = "";
    local v41 = CONSTANTS.IS_MATCHMAKING_SERVER and not MatchmakingController:Get("MatchmadeGameOver");

    if not v41 then
        p39._leaderstat_rank_icon = RankIcon.new(v40.Value, p39.ClientFighter.Player.UserId);
        p39._leaderstat_rank_icon:SetParent(p39.LeaderstatRankContainer);
    end;
end;

function u12._UpdateHighlight(p42) -- Line: 244
    p42.HighlightFrame.BackgroundTransparency = p42._is_highlighted and 0.875 or (p42._is_hovered and 0.95 or 1);
end;

function u12._SetHovered(p43, p44) -- Line: 248
    p43._is_hovered = p44;
    p43:_UpdateHighlight();
end;

function u12._FetchIsBlocked(p45) -- Line: 253
    -- upvalues: StarterGui (copy)
    local success, result = pcall(StarterGui.GetCore, StarterGui, "GetBlockedUserIds");

    if success then
        success = table.find(result, p45.ClientFighter.Player.UserId) ~= nil;
    end;

    p45:SetIsBlocked(success);
end;

function u12._FetchIsFriend(p46) -- Line: 259
    -- upvalues: SocialController (copy)
    if p46.ClientFighter.IsLocalPlayer then
        p46:SetIsFriend(false);

        return;
    end;

    p46:SetIsFriend(SocialController:IsFriendsWith(p46.ClientFighter.Player.UserId));
end;

function u12._SetupLeaderstats(u47) -- Line: 268
    local CustomLeaderstats = u47.ClientFighter.Player:WaitForChild("CustomLeaderstats");
    table.insert(u47._connections, CustomLeaderstats.ChildRemoved:Connect(function() -- Line: 271
        -- upvalues: u47 (copy)
        u47:_UpdateLeaderstat();
    end));

    local function object_added(p48, p49) -- Line: 275
        -- upvalues: u47 (copy)
        p48:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 276
            -- upvalues: u47 (ref)
            u47:_UpdateLeaderstat();
        end);
        p48:GetAttributeChangedSignal("StillLoading"):Connect(function() -- Line: 280
            -- upvalues: u47 (ref)
            u47:_UpdateLeaderstat();
        end);

        if not p49 then
            u47:_UpdateLeaderstat();
        end;
    end;

    table.insert(u47._connections, CustomLeaderstats.ChildAdded:Connect(object_added));

    for _, child in pairs(CustomLeaderstats:GetChildren()) do
        task.spawn(object_added, child, true);
    end;

    u47:_UpdateLeaderstat();
end;

function u12._Setup(p50) -- Line: 298
    -- upvalues: Utility (copy)
    p50.PlayerTitle.Text = Utility:GetName(p50.ClientFighter.Player, p50.ClientFighter.Player.DisplayName, true);
end;

function u12._Init(u51) -- Line: 302
    -- upvalues: LeaderboardController (copy), UserInputService (copy), MatchmakingController (copy), ButtonEffect (copy)
    u51.Button.MouseButton1Click:Connect(function() -- Line: 303
        -- upvalues: u51 (copy)
        u51.Clicked:Fire();
    end);
    u51.Button.MouseEnter:Connect(function() -- Line: 307
        -- upvalues: u51 (copy)
        u51:_SetHovered(true);
    end);
    u51.Button.MouseLeave:Connect(function() -- Line: 311
        -- upvalues: u51 (copy)
        u51:_SetHovered(false);
    end);
    u51.PlayerTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 315
        -- upvalues: u51 (copy)
        u51:_UpdateVisuals();
    end);
    u51.PlayerTitle:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 319
        -- upvalues: u51 (copy)
        u51:_UpdateVisuals();
    end);
    u51.PlayerTitle:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 323
        -- upvalues: u51 (copy)
        u51:_UpdateVisuals();
    end);
    local _connections = u51._connections;
    local DataChangedSignal = u51.ClientFighter:GetDataChangedSignal("Controls");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 327
        -- upvalues: u51 (copy)
        u51:_UpdateIcon();
    end));
    local _connections2 = u51._connections;
    local AttributeChangedSignal = u51.ClientFighter.Player:GetAttributeChangedSignal("GroupRoleIDs");
    table.insert(_connections2, AttributeChangedSignal:Connect(function() -- Line: 331
        -- upvalues: u51 (copy)
        u51:_UpdateIcon();
    end));
    local _connections3 = u51._connections;
    local AttributeChangedSignal2 = u51.ClientFighter.Player:GetAttributeChangedSignal("IsAdministrator");
    table.insert(_connections3, AttributeChangedSignal2:Connect(function() -- Line: 335
        -- upvalues: u51 (copy)
        u51:_UpdateIcon();
    end));
    local _connections4 = u51._connections;
    local AttributeChangedSignal3 = u51.ClientFighter.Player:GetAttributeChangedSignal("IsRobloxEmployee");
    table.insert(_connections4, AttributeChangedSignal3:Connect(function() -- Line: 339
        -- upvalues: u51 (copy)
        u51:_UpdateIcon();
    end));
    local _connections5 = u51._connections;
    local AttributeChangedSignal4 = u51.ClientFighter.Player:GetAttributeChangedSignal("IsInfluencer");
    table.insert(_connections5, AttributeChangedSignal4:Connect(function() -- Line: 343
        -- upvalues: u51 (copy)
        u51:_UpdateIcon();
    end));
    local _connections6 = u51._connections;
    local PropertyChangedSignal = u51.ClientFighter.Player:GetPropertyChangedSignal("MembershipType");
    table.insert(_connections6, PropertyChangedSignal:Connect(function() -- Line: 347
        -- upvalues: u51 (copy)
        u51:_UpdateIcon();
    end));
    local _connections7 = u51._connections;
    local AttributeChangedSignal5 = u51.ClientFighter.Player:GetAttributeChangedSignal("DisableTeamVisuals");
    table.insert(_connections7, AttributeChangedSignal5:Connect(function() -- Line: 351
        -- upvalues: u51 (copy)
        u51:_UpdateIcon();
    end));
    local _connections8 = u51._connections;
    local AttributeChangedSignal6 = u51.ClientFighter.Player:GetAttributeChangedSignal("PlayerStatus");
    table.insert(_connections8, AttributeChangedSignal6:Connect(function() -- Line: 355
        -- upvalues: u51 (copy)
        u51:_UpdateStatus();
    end));
    local _connections9 = u51._connections;
    local LeaderboardRefreshedSignal = LeaderboardController:GetLeaderboardRefreshedSignal("Highest ELO");
    table.insert(_connections9, LeaderboardRefreshedSignal:Connect(function() -- Line: 359
        -- upvalues: u51 (copy)
        u51:_UpdateLeaderstat();
    end));
    table.insert(u51._connections, UserInputService.WindowFocused:Connect(function() -- Line: 363
        -- upvalues: u51 (copy)
        u51:_UpdateVisuals();
    end));
    table.insert(u51._connections, UserInputService.WindowFocusReleased:Connect(function() -- Line: 367
        -- upvalues: u51 (copy)
        u51:_UpdateVisuals();
    end));
    local _connections10 = u51._connections;
    local DataChangedSignal2 = MatchmakingController:GetDataChangedSignal("MatchmadeGameOver");
    table.insert(_connections10, DataChangedSignal2:Connect(function() -- Line: 371
        -- upvalues: u51 (copy)
        u51:_UpdateLeaderstat();
    end));
    u51:_Setup();
    u51:_UpdateIcon();
    u51:_UpdateStatus();
    u51:_UpdateVisuals();
    u51:_UpdateHighlight();
    u51:_UpdateLeaderstat();
    task.spawn(u51._FetchIsFriend, u51);
    task.spawn(u51._FetchIsBlocked, u51);
    task.spawn(u51._SetupLeaderstats, u51);
    ButtonEffect:Add(u51.Button, true);
end;

return u12;