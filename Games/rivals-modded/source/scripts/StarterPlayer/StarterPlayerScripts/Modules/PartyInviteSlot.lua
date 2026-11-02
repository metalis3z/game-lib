-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SocialService = game:GetService("SocialService");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local QueuePadController = require(Players.LocalPlayer.PlayerScripts.Controllers.QueuePadController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local SocialController = require(Players.LocalPlayer.PlayerScripts.Controllers.SocialController);
local PartyController = require(Players.LocalPlayer.PlayerScripts.Controllers.PartyController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local PartyInviteSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PartyInviteSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5) -- Line: 19
    -- upvalues: u1 (copy), PartyInviteSlot (copy)
    local v6 = setmetatable({}, u1);
    v6.Frame = PartyInviteSlot:Clone();
    v6._destroyed = false;
    v6._player_object = p2;

    if not p3 then
        if v6._player_object then
            p3 = v6._player_object.UserId or nil;
        else
            p3 = nil;
        end;
    end;

    v6._user_id = p3;

    if not p4 then
        if v6._player_object then
            p4 = v6._player_object.DisplayName or nil;
        else
            p4 = nil;
        end;
    end;

    v6._display_name = p4;

    if not p5 then
        if v6._player_object then
            p5 = v6._player_object.Name or nil;
        else
            p5 = nil;
        end;
    end;

    v6._username = p5;
    v6:_Init();

    return v6;
end;

function u1.StillHere(p7) -- Line: 39
    -- upvalues: Players (copy)
    return p7._player_object and p7._player_object.Parent == Players;
end;

function u1.GetUserID(p8) -- Line: 43
    return p8._user_id;
end;

function u1.UpdateCooldowns(p9) -- Line: 47
    -- upvalues: QueuePadController (copy), PartyController (copy)
    p9.Frame.Buttons.Challenge.Button.Off.Visible = QueuePadController:IsChallengeRequestOnCooldown(p9._player_object);
    p9.Frame.Buttons.Challenge.Button.On.Visible = not p9.Frame.Buttons.Challenge.Button.Off.Visible;
    p9.Frame.Buttons.Invite.Button.Off.Visible = PartyController:IsInviteRequestOnCooldown(p9._player_object);
    p9.Frame.Buttons.Invite.Button.On.Visible = not p9.Frame.Buttons.Invite.Button.Off.Visible;
end;

function u1.Destroy(p10) -- Line: 54
    p10._destroyed = true;
    p10.Frame:Destroy();
end;

function u1._Update(p11) -- Line: 63
    p11.Frame.DisplayName.Controls.Position = UDim2.new(0, p11.Frame.DisplayName.TextBounds.X, 0.5, 0);
end;

function u1._CheckFriendsWith(p12) -- Line: 67
    -- upvalues: SocialController (copy)
    if p12._destroyed then
        return;
    end;

    if not SocialController:IsFriendsWith(p12._user_id) then
        return;
    end;

    p12.Frame.Name = "Friends";
    local Frame = p12.Frame;
    Frame.LayoutOrder = Frame.LayoutOrder + 999999;
end;

function u1._Setup(p13) -- Line: 80
    -- upvalues: FighterController (copy), QueuePadController (copy), PartyController (copy), CONSTANTS (copy), ComplianceController (copy)
    local Fighter = FighterController:GetFighter(p13._player_object);
    p13.Frame.Buttons.Challenge.Visible = QueuePadController:CanChallenge(p13._player_object);
    p13.Frame.Buttons.Invite.Visible = PartyController:CanInvitePlayerToParty(p13._player_object);
    p13.Frame.Buttons.InviteExternal.Visible = not p13._player_object;
    p13.Frame.Icon.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p13._user_id);
    p13.Frame.DisplayName.Controls.Image = Fighter and CONSTANTS.CONTROLS_IMAGES[Fighter:Get("Controls")] or "";
    p13.Frame.DisplayName.Text = p13._player_object and ComplianceController:GetName(p13._player_object) or (p13._display_name or "");
    p13.Frame.Username.Text = p13._player_object and "@" .. p13._player_object.Name or (p13._username and ("@" .. p13._username or "") or "");
    p13.Frame.Name = "Lobby";
    p13.Frame.LayoutOrder = 0;
end;

function u1._Init(u14) -- Line: 94
    -- upvalues: QueuePadController (copy), PartyController (copy), HttpService (copy), ReplicatedStorage (copy), SocialService (copy), Players (copy), ButtonEffect (copy)
    u14.Frame.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 95
        -- upvalues: u14 (copy)
        u14:_Update();
    end);
    u14.Frame.Buttons.Challenge.Button.MouseButton1Click:Connect(function() -- Line: 99
        -- upvalues: QueuePadController (ref), u14 (copy)
        QueuePadController:SendChallengeRequest(u14._player_object);
    end);
    u14.Frame.Buttons.Invite.Button.MouseButton1Click:Connect(function() -- Line: 103
        -- upvalues: PartyController (ref), u14 (copy)
        PartyController:SendPartyInvite(u14._player_object);
    end);
    u14.Frame.Buttons.InviteExternal.Button.MouseButton1Click:Connect(function() -- Line: 107
        -- upvalues: u14 (copy), HttpService (ref), ReplicatedStorage (ref), SocialService (ref), Players (ref)
        local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
        ExperienceInviteOptions.PromptMessage = "Invite to your party!";
        ExperienceInviteOptions.InviteMessageId = "466fc19d-8334-514f-80e7-cba27e22bc22";
        ExperienceInviteOptions.InviteUser = u14._user_id;
        ExperienceInviteOptions.LaunchData = HttpService:JSONEncode({
            PartyInviteHash = ReplicatedStorage.Remotes.Matchmaking.RequestPartyInviteData:InvokeServer()
        });
        SocialService:PromptGameInvite(Players.LocalPlayer, ExperienceInviteOptions);
        u14.Frame.Buttons.InviteExternal.Button.On.Visible = false;
        u14.Frame.Buttons.InviteExternal.Button.Off.Visible = true;
    end);
    u14:_Setup();
    u14:_Update();
    u14:UpdateCooldowns();
    task.defer(u14._CheckFriendsWith, u14);
    ButtonEffect:Add(u14.Frame.Buttons.Invite.Button);
    ButtonEffect:Add(u14.Frame.Buttons.InviteExternal.Button);
    ButtonEffect:Add(u14.Frame.Buttons.Challenge.Button);
end;

return u1;