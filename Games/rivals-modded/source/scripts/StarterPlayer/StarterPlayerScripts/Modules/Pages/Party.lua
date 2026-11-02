-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local QueuePadController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local SocialController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"));
local PartyController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"));
local MatchmakingCountdown = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("MatchmakingCountdown"));
local PartyInviteSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PartyInviteSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local PartyMemberBigSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PartyMemberBigSlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 21
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.MembersFrame = v3.PageFrame:WaitForChild("Members");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.EmptyFrame = v3.Container:WaitForChild("Empty");
    v3.TopFrame = v3.Container:WaitForChild("Top");
    v3.SearchBox = v3.TopFrame:WaitForChild("Search"):WaitForChild("Box");
    v3.TabsFrame = v3.TopFrame:WaitForChild("Tabs");
    v3.AllButton = v3.TabsFrame:WaitForChild("All");
    v3.AllButtonText = v3.AllButton:WaitForChild("Title");
    v3.AllButtonBackground = v3.AllButton:WaitForChild("Background");
    v3.AllButtonBackgroundGradient = v3.AllButtonBackground:WaitForChild("UIGradient");
    v3.FriendsButton = v3.TabsFrame:WaitForChild("Friends");
    v3.FriendsButtonText = v3.FriendsButton:WaitForChild("Title");
    v3.FriendsButtonBackground = v3.FriendsButton:WaitForChild("Background");
    v3.FriendsButtonBackgroundGradient = v3.FriendsButtonBackground:WaitForChild("UIGradient");
    v3.LobbyButton = v3.TabsFrame:WaitForChild("Lobby");
    v3.LobbyButtonText = v3.LobbyButton:WaitForChild("Title");
    v3.LobbyButtonBackground = v3.LobbyButton:WaitForChild("Background");
    v3.LobbyButtonBackgroundGradient = v3.LobbyButtonBackground:WaitForChild("UIGradient");
    v3.PlayersFrame = v3.Container:WaitForChild("Players");
    v3.PlayersContainer = v3.PlayersFrame:WaitForChild("Container");
    v3.PlayersLayout = v3.PlayersContainer:WaitForChild("Layout");
    v3.HidePartyDisplay = true;
    v3._member_slots = {};
    v3._invite_slots = {};
    v3._offline_invite_slots = {};
    v3._invite_generation_disabled = 0;
    v3._leave_buttons = {};
    v3:_Init();

    return v3;
end;

function u1.Open(u4, ...) -- Line: 66
    -- upvalues: Page (copy), QueuePadController (copy), PartyController (copy)
    Page.Open(u4, ...);
    table.insert(u4._open_connections, QueuePadController.ChallengeRequestCooldownChanged:Connect(function() -- Line: 69
        -- upvalues: u4 (copy)
        u4:_UpdateCooldowns();
    end));
    table.insert(u4._open_connections, PartyController.InviteRequestCooldownChanged:Connect(function() -- Line: 73
        -- upvalues: u4 (copy)
        u4:_UpdateCooldowns();
    end));
    u4:_GenerateMembers();
    u4:_GeneratePlayers(true);
    u4:_UpdateCooldowns();
    u4._invite_generation_disabled = tick() + 0.375;
    task.delay(0.375, u4._GeneratePlayers, u4);
    u4.SearchBox.Text = "";
end;

function u1._UpdateLayouts(p5) -- Line: 91
    p5.List.CanvasSize = UDim2.new(0, 0, 0, p5.Layout.AbsoluteContentSize.Y);
    p5.PlayersFrame.Size = UDim2.new(1, 0, 0, p5.PlayersLayout.AbsoluteContentSize.Y);
    p5.EmptyFrame.Visible = p5.PlayersLayout.AbsoluteContentSize.Y < 5;
end;

function u1._UpdateLeaveButtons(p6) -- Line: 97
    -- upvalues: MatchmakingCountdown (copy)
    local v7 = MatchmakingCountdown:IsVisible();

    for _, v in pairs(p6._leave_buttons) do
        v.Visible = v7;
    end;
end;

function u1._UpdateCooldowns(p8) -- Line: 105
    for _, v in pairs(p8._invite_slots) do
        v:UpdateCooldowns();
    end;
end;

function u1._SetTab(p9, p10) -- Line: 111
    p9._current_tab = p10;
    p9.AllButtonText.TextColor3 = p9._current_tab == "All" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p9.AllButtonBackground.ImageColor3 = p9._current_tab == "All" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    p9.AllButtonBackground.ImageTransparency = p9._current_tab == "All" and 0 or 0.25;
    p9.AllButtonBackgroundGradient.Enabled = p9._current_tab ~= "All";
    p9.FriendsButtonText.TextColor3 = p9._current_tab == "Friends" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p9.FriendsButtonBackground.ImageColor3 = p9._current_tab == "Friends" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    p9.FriendsButtonBackground.ImageTransparency = p9._current_tab == "Friends" and 0 or 0.25;
    p9.FriendsButtonBackgroundGradient.Enabled = p9._current_tab ~= "Friends";
    p9.LobbyButtonText.TextColor3 = p9._current_tab == "Lobby" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p9.LobbyButtonBackground.ImageColor3 = p9._current_tab == "Lobby" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    p9.LobbyButtonBackground.ImageTransparency = p9._current_tab == "Lobby" and 0 or 0.25;
    p9.LobbyButtonBackgroundGradient.Enabled = p9._current_tab ~= "Lobby";
    p9:_UpdatePlayersVisibility();
end;

function u1._UpdatePlayerVisibility(p11, p12) -- Line: 132
    local string_lower_ret = string.lower(p11.SearchBox.Text);
    local Frame = p12.Frame;
    local v13;

    if p11._current_tab == "All" or p11._current_tab == p12.Frame.Name then
        v13 = string.find(string.lower(p12.Frame.DisplayName.Text), string_lower_ret) or string.find(string.lower(p12.Frame.Username.Text), string_lower_ret);
    else
        v13 = false;
    end;

    Frame.Visible = v13;
end;

function u1._UpdatePlayersVisibility(p14) -- Line: 139
    for _, v in pairs(p14._invite_slots) do
        p14:_UpdatePlayerVisibility(v);
    end;

    for _, v in pairs(p14._offline_invite_slots) do
        p14:_UpdatePlayerVisibility(v);
    end;
end;

function u1._GeneratePlayers(u15, p16) -- Line: 149
    -- upvalues: Players (copy), CONSTANTS (copy), PartyInviteSlot (copy), FighterController (copy), SocialController (copy)
    if not u15:IsOpen() then
        return;
    end;

    for i = #u15._invite_slots, 1, -1 do
        local v17 = u15._invite_slots[i];
        local v18;

        if p16 or not v17:StillHere() then
            v17:Destroy();
            table.remove(u15._invite_slots, i);
            v18 = i;
        else
            v18 = i;
        end;
    end;

    if p16 then
        for _, v in pairs(u15._offline_invite_slots) do
            v:Destroy();
        end;

        u15._offline_invite_slots = {};
    end;

    if tick() < u15._invite_generation_disabled then
        return;
    end;

    local u19 = {};

    for _, v in pairs(u15._invite_slots) do
        u19[tostring(v:GetUserID())] = true;
    end;

    local u20 = 0;

    local function generate_slot(p21, p22, p23, p24, p25) -- Line: 185
        -- upvalues: Players (ref), CONSTANTS (ref), u19 (copy), u20 (ref), PartyInviteSlot (ref), u15 (copy)
        if not p23 then
            if p22 then
                p23 = p22.UserId or nil;
            else
                p23 = nil;
            end;
        end;

        if p23 == Players.LocalPlayer.UserId and not CONSTANTS.IS_STUDIO or u19[tostring(p23)] then
            return;
        end;

        u19[tostring(p23)] = true;
        u20 = u20 + 1;
        local v26 = PartyInviteSlot.new(p22, p23, p24, p25);
        local Frame = v26.Frame;
        Frame.LayoutOrder = Frame.LayoutOrder + u20;
        v26.Frame.Parent = u15.PlayersContainer;
        u15:_UpdatePlayerVisibility(v26);

        if p21 then
            table.insert(p21, v26);
        end;
    end;

    for _, v in pairs(FighterController.Objects) do
        generate_slot(u15._invite_slots, v.Player);
    end;

    if #u15._offline_invite_slots == 0 then
        for _, v in pairs(SocialController.Friends) do
            generate_slot(u15._offline_invite_slots, nil, v.VisitorId, v.DisplayName, v.UserName);
        end;
    end;

    u15:_UpdatePlayersVisibility();
end;

function u1._GenerateMembers(u27) -- Line: 218
    -- upvalues: PartyController (copy), Players (copy), FighterController (copy), PartyMemberBigSlot (copy), CONSTANTS (copy), ComplianceController (copy), ButtonEffect (copy), ReplicatedStorage (copy)
    if not u27:IsOpen() then
        return;
    end;

    for _, v in pairs(u27._member_slots) do
        v:Destroy();
    end;

    u27._member_slots = {};
    u27._leave_buttons = {};
    local u28 = PartyController.CurrentParty or { Players.LocalPlayer };

    local function v35(p29, u30) -- Line: 232
        -- upvalues: FighterController (ref), PartyMemberBigSlot (ref), CONSTANTS (ref), PartyController (ref), Players (ref), u28 (copy), ComplianceController (ref), u27 (copy), ButtonEffect (ref), ReplicatedStorage (ref)
        local v31;

        if u30 then
            v31 = FighterController:GetFighter(u30);
        else
            v31 = u30;
        end;

        local u32 = PartyMemberBigSlot:Clone();
        u32.Icon.Image = not u30 and "" or string.format(CONSTANTS.HEADSHOT_IMAGE, u30.UserId);
        u32.Leader.Visible = u30 and PartyController.CurrentParty and p29 == 1;
        local v33 = u30 and PartyController.CurrentParty;

        if v33 then
            if Players.LocalPlayer == u28[1] then
                v33 = u30 ~= Players.LocalPlayer;
            else
                v33 = false;
            end;
        end;

        u32.Kick.Visible = v33;
        local v34 = u30 and PartyController.CurrentParty;

        if v34 then
            if Players.LocalPlayer == u28[1] then
                v34 = u30 ~= Players.LocalPlayer;
            else
                v34 = false;
            end;
        end;

        u32.Promote.Visible = v34;
        u32.Leave.Visible = u30 and PartyController.CurrentParty and u30 == Players.LocalPlayer;
        u32.DisplayName.Controls.Image = v31 and CONSTANTS.CONTROLS_IMAGES[v31:Get("Controls")] or "";
        u32.DisplayName.Text = not u30 and "" or ComplianceController:GetName(u30);
        u32.Username.Text = not u30 and "" or "@" .. u30.Name;
        u32.Background.Visible = u30 ~= nil;
        u32.TransparentBackground.Visible = not u30;
        u32.LayoutOrder = p29;
        u32.Parent = u27.MembersFrame;
        table.insert(u27._member_slots, u32);
        table.insert(u27._leave_buttons, u32.Leave);
        ButtonEffect:Add(u32.Kick);
        ButtonEffect:Add(u32.Leave);
        ButtonEffect:Add(u32.Promote);
        u32.Kick.MouseButton1Click:Connect(function() -- Line: 254
            -- upvalues: ReplicatedStorage (ref), u30 (copy)
            ReplicatedStorage.Remotes.Matchmaking.KickPlayerFromParty:FireServer(u30);
        end);
        u32.Leave.MouseButton1Click:Connect(function() -- Line: 258
            -- upvalues: ReplicatedStorage (ref)
            ReplicatedStorage.Remotes.Matchmaking.TryLeaveParty:FireServer();
        end);
        u32.Promote.MouseButton1Click:Connect(function() -- Line: 262
            -- upvalues: ReplicatedStorage (ref), u30 (copy)
            ReplicatedStorage.Remotes.Matchmaking.TransferPartyLeader:FireServer(u30);
        end);
        u32.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 266, Name: update
            -- upvalues: u32 (copy)
            u32.DisplayName.Controls.Position = UDim2.new(0, u32.DisplayName.TextBounds.X, 0.5, 0);
        end);
        u32.DisplayName.Controls.Position = UDim2.new(0, u32.DisplayName.TextBounds.X, 0.5, 0);
    end;

    for i, v in pairs(u28) do
        v35(i, v);
    end;

    for i = #u28 + 1, CONSTANTS.MAX_PARTY_SIZE do
        v35(i, nil);
        local _ = i;
    end;
end;

function u1._Init(u36) -- Line: 283
    -- upvalues: PartyController (copy), SocialController (copy), FighterController (copy), MatchmakingCountdown (copy), ButtonEffect (copy)
    u36.CloseButton.MouseButton1Click:Connect(function() -- Line: 284
        -- upvalues: u36 (copy)
        u36:CloseRequest();
    end);
    u36.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 288
        -- upvalues: u36 (copy)
        u36:_UpdateLayouts();
    end);
    u36.PlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 292
        -- upvalues: u36 (copy)
        u36:_UpdateLayouts();
    end);
    u36.AllButton.MouseButton1Click:Connect(function() -- Line: 296
        -- upvalues: u36 (copy)
        u36:_SetTab("All");
    end);
    u36.FriendsButton.MouseButton1Click:Connect(function() -- Line: 300
        -- upvalues: u36 (copy)
        u36:_SetTab("Friends");
    end);
    u36.LobbyButton.MouseButton1Click:Connect(function() -- Line: 304
        -- upvalues: u36 (copy)
        u36:_SetTab("Lobby");
    end);
    u36.SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 308
        -- upvalues: u36 (copy)
        u36:_UpdatePlayersVisibility();
    end);
    PartyController.PartyChanged:Connect(function() -- Line: 312
        -- upvalues: u36 (copy)
        u36:_GenerateMembers();
        u36:_GeneratePlayers();
    end);
    SocialController.FriendsFetched:Connect(function() -- Line: 317
        -- upvalues: u36 (copy)
        u36:_GeneratePlayers();
    end);
    FighterController.ObjectAdded:Connect(function() -- Line: 321
        -- upvalues: u36 (copy)
        u36:_GeneratePlayers();
    end);
    FighterController.ObjectRemoved:Connect(function() -- Line: 325
        -- upvalues: u36 (copy)
        u36:_GeneratePlayers();
    end);
    MatchmakingCountdown.VisibilityChanged:Connect(function() -- Line: 329
        -- upvalues: u36 (copy)
        u36:_UpdateLeaveButtons();
    end);
    u36:_UpdateLayouts();
    u36:_UpdateLeaveButtons();
    task.defer(u36._SetTab, u36, "All");
    task.defer(u36._GeneratePlayers, u36);
    task.defer(u36._GenerateMembers, u36);
    ButtonEffect:Add(u36.CloseButton);
    ButtonEffect:Add(u36.AllButton);
    ButtonEffect:Add(u36.FriendsButton);
    ButtonEffect:Add(u36.LobbyButton);
end;

return u1._new();