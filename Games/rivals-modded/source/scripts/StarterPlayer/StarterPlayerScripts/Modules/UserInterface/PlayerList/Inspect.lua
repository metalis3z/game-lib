-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local StarterGui = game:GetService("StarterGui");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PrivateServerController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PrivateServerController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local QueuePadController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"));
local PartyController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"));
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local UDim2_new_ret = UDim2.new(1.25, 0, 0.5, 0);
local UDim2_new_ret2 = UDim2.new(0, 0, 0.5, 0);
local PlayerListInspectActionSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PlayerListInspectActionSlot");
local u1 = {
    HoverRatio = 1,
    ReleaseRatio = 1
};
local u2 = {
    {
        "Invite",
        "Party Invite",
        Color3.fromRGB(100, 255, 0),
        "rbxassetid://89570813431745",
        0.55
    },
    {
        "Friend",
        "Add Friend",
        Color3.fromRGB(100, 255, 0),
        "rbxassetid://95245645462537"
    },
    {
        "Challenge",
        "Challenge",
        Color3.fromRGB(255, 150, 0),
        "rbxassetid://18525954682"
    },
    {
        "Spectate",
        "Spectate",
        Color3.fromRGB(255, 150, 0),
        "rbxassetid://77908042044589"
    },
    {
        "ViewProfile",
        "View Profile",
        Color3.fromRGB(0, 150, 255),
        "rbxassetid://113844621753627",
        0.65
    },
    {
        "ViewAvatar",
        "View Avatar",
        Color3.fromRGB(0, 150, 255),
        "rbxassetid://113844621753627",
        0.65
    },
    {
        "Gift",
        "Send Gift",
        Color3.fromRGB(255, 149, 253),
        "rbxassetid://127400882945494",
        0.65
    },
    {
        "Unfriend",
        "Remove Friend",
        Color3.fromRGB(255, 50, 50),
        "rbxassetid://99528569460280"
    },
    {
        "Block",
        "Block",
        Color3.fromRGB(255, 50, 50),
        "rbxassetid://71490041005019"
    },
    {
        "Unblock",
        "Unblock",
        Color3.fromRGB(255, 50, 50),
        "rbxassetid://71490041005019"
    },
    {
        "Kick",
        "Server Kick",
        Color3.fromRGB(255, 50, 50),
        "rbxassetid://76417427319315",
        0.65
    },
    {
        "Ban",
        "Server Ban",
        Color3.fromRGB(255, 50, 50),
        "rbxassetid://76417427319315"
    }
};
local u3 = {};
u3.__index = u3;

function u3.new(p4) -- Line: 43
    -- upvalues: u3 (copy)
    local v5 = setmetatable({}, u3);
    v5.PlayerList = p4;
    v5.Frame = v5.PlayerList.Container:WaitForChild("Inspect");
    v5.Container = v5.Frame:WaitForChild("Container");
    v5.Layout = v5.Container:WaitForChild("Layout");
    v5.PlayerFrame = v5.Container:WaitForChild("Player");
    v5.PlayerHeadshot = v5.PlayerFrame:WaitForChild("Headshot");
    v5.PlayerUsername = v5.PlayerFrame:WaitForChild("Username");
    v5.PlayerDisplayName = v5.PlayerFrame:WaitForChild("DisplayName");
    v5._selected_player_list_slot = false;
    v5._action_slots = {};
    v5:_Init();

    return v5;
end;

function u3.SetScale(p6, p7) -- Line: 67
    p6.Frame.Size = UDim2.new(0.95 * p7, 0, 5, 0);
end;

function u3.SelectPlayer(p8, p9) -- Line: 71
    -- upvalues: UDim2_new_ret2 (copy), UDim2_new_ret (copy), Players (copy), CONSTANTS (copy), PartyController (copy), QueuePadController (copy), DuelController (copy), Utility (copy), WeaponStatusHandler (copy)
    if p9 == p8._selected_player_list_slot then
        return;
    end;

    if p9 and not p8.PlayerList.IsOpen then
        return;
    end;

    p8._selected_player_list_slot = p9;

    for _, v in pairs(p8.PlayerList.Elements.PlayerListSlots) do
        v:SetHighlighted(p8._selected_player_list_slot == v);
    end;

    local v10;

    if p8._selected_player_list_slot then
        v10 = UDim2.new(0, -4, 0, p8._selected_player_list_slot.Frame.AbsolutePosition.Y - p8.PlayerList.Container.AbsolutePosition.Y);
    else
        v10 = p8.Frame.Position;
    end;

    local v11;

    if p8._selected_player_list_slot then
        v11 = UDim2_new_ret2;
    else
        v11 = UDim2_new_ret;
    end;

    p8.Frame.Position = v10;
    local v12;

    if p8._selected_player_list_slot then
        v12 = UDim2_new_ret;
    else
        v12 = p8.Container.Position;
    end;

    p8.Container.Position = v12;

    if p8.Container:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
        p8.Container:TweenPosition(v11, "Out", "Quint", 0.25, true);
    else
        p8.Container.Position = v11;
    end;

    if not p8._selected_player_list_slot then
        return;
    end;

    local Player = p8._selected_player_list_slot.ClientFighter.Player;
    local IsLocalPlayer = p8._selected_player_list_slot.ClientFighter.IsLocalPlayer;
    local v13 = p8._selected_player_list_slot:IsBlocked();
    local v14 = not v13 and p8._selected_player_list_slot:IsFriend();
    local v15 = CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId);
    local Invite = p8._action_slots.Invite;
    local v16 = not v13 and PartyController:CanInvitePlayerToParty(Player);
    Invite.Visible = v16;
    local v17 = not (v13 or v14);

    if v17 then
        v17 = not IsLocalPlayer and true;
    end;

    p8._action_slots.Friend.Visible = v17;
    local Challenge = p8._action_slots.Challenge;
    local v18 = not v13 and QueuePadController:CanChallenge(Player);
    Challenge.Visible = v18;
    local Spectate = p8._action_slots.Spectate;
    local v19 = not v13 and DuelController:GetDuel(Player) ~= nil;
    Spectate.Visible = v19;
    p8._action_slots.ViewProfile.Visible = not v13;
    p8._action_slots.ViewAvatar.Visible = not v13;
    local v20 = not v13;

    if v20 then
        if v14 then
            v14 = not IsLocalPlayer and true;
        end;
    else
        v14 = v20;
    end;

    p8._action_slots.Unfriend.Visible = v14;
    p8._action_slots.Block.Visible = not v13 and not IsLocalPlayer;
    local v21;

    if v13 then
        v21 = not IsLocalPlayer;
    else
        v21 = v13;
    end;

    p8._action_slots.Unblock.Visible = v21;
    p8._action_slots.Gift.Visible = not v13 and not IsLocalPlayer;
    p8._action_slots.Kick.Visible = not IsLocalPlayer and v15;
    p8._action_slots.Ban.Visible = not IsLocalPlayer and v15;
    p8.PlayerHeadshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, Player.UserId);
    p8.PlayerDisplayName.Text = Utility:GetName(p8._selected_player_list_slot.ClientFighter.Player, Player.DisplayName, true);
    p8.PlayerUsername.Text = "@" .. Player.Name;
    WeaponStatusHandler:ClearStatusElements(p8.PlayerDisplayName);
    WeaponStatusHandler:ApplyItemStatusToText(p8.PlayerDisplayName, Player:GetAttribute("PlayerStatus"));
    p8:_UpdateCooldowns();
end;

function u3.OnOpened(u22) -- Line: 134
    -- upvalues: QueuePadController (copy), PartyController (copy), UserInputService (copy), UILibrary (copy)
    u22.PlayerList:AddOpenedConnection(QueuePadController.ChallengeRequestCooldownChanged:Connect(function() -- Line: 135
        -- upvalues: u22 (copy)
        u22:_UpdateCooldowns();
    end));
    u22.PlayerList:AddOpenedConnection(PartyController.InviteRequestCooldownChanged:Connect(function() -- Line: 139
        -- upvalues: u22 (copy)
        u22:_UpdateCooldowns();
    end));
    u22.PlayerList:AddOpenedConnection(UserInputService.InputBegan:Connect(function(p23) -- Line: 143
        -- upvalues: UILibrary (ref), u22 (copy)
        if UILibrary:IsMouseWithinBounds(u22.Container.AbsolutePosition, u22.Layout.AbsoluteContentSize) then
            return;
        end;

        if UILibrary:IsMouseWithinBounds(u22.PlayerList.Elements.Frame.AbsolutePosition, u22.PlayerList.Elements.Frame.AbsoluteSize) then
            return;
        end;

        if p23.UserInputType == Enum.UserInputType.MouseButton1 or p23.UserInputType == Enum.UserInputType.Touch then
            u22:SelectPlayer(nil);
        end;
    end));
    u22:_UpdateCooldowns();
end;

function u3._UpdateCooldowns(p24) -- Line: 164
    -- upvalues: QueuePadController (copy), PartyController (copy)
    local v25 = p24._selected_player_list_slot and p24._selected_player_list_slot.ClientFighter.Player;
    local Cooldown = p24._action_slots.Challenge.Button.Cooldown;
    local v26;

    if v25 then
        v26 = QueuePadController:IsChallengeRequestOnCooldown(v25);
    else
        v26 = v25;
    end;

    Cooldown.Visible = v26;
    p24._action_slots.Challenge.Button.Icon.Visible = not p24._action_slots.Challenge.Button.Cooldown.Visible;
    local Cooldown2 = p24._action_slots.Invite.Button.Cooldown;

    if v25 then
        v25 = PartyController:IsInviteRequestOnCooldown(v25);
    end;

    Cooldown2.Visible = v25;
    p24._action_slots.Invite.Button.Icon.Visible = not p24._action_slots.Invite.Button.Cooldown.Visible;
end;

function u3._SlotAdded(u27, u28) -- Line: 174
    u28.Clicked:Connect(function() -- Line: 175
        -- upvalues: u27 (copy), u28 (copy)
        local v29;

        if u27._selected_player_list_slot == u28 then
            v29 = nil;
        else
            v29 = u28;
        end;

        u27:SelectPlayer(v29);
    end);
    u28:SetHighlighted(u27._selected_player_list_slot == u28);
end;

function u3._Setup(u30) -- Line: 182
    -- upvalues: u2 (copy), PlayerListInspectActionSlot (copy), ButtonEffect (copy), u1 (copy), PartyController (copy), StarterGui (copy), QueuePadController (copy), DuelController (copy), SpectateController (copy), Pages (copy), GuiService (copy), PrivateServerController (copy)
    for _, v in pairs(u2) do
        local table_unpack_ret, v31, u32, v33, v34 = table.unpack(v);
        local u35 = PlayerListInspectActionSlot:Clone();
        u35.Button.Background.ImageColor3 = u32;
        u35.Button.Icon.Image = v33;
        u35.Button.Icon.Size = UDim2.new(0.2, 0, v34 or 0.75, 0);
        u35.Button.Title.Text = v31;
        u35.Parent = u30.Container;
        u30._action_slots[table_unpack_ret] = u35;
        ButtonEffect:Add(u35.Button, nil, u1);
        u35.Button.MouseLeave:Connect(function() -- Line: 195, Name: unhover
            -- upvalues: u35 (copy), u32 (copy)
            u35.Button.Background.ImageColor3 = u32;
            u35.Button.Background.ImageTransparency = 0.5;
            u35.Button.Background.UIGradient.Enabled = true;
            u35.Button.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255);
            u35.Button.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
        end);
        u35.Button.MouseEnter:Connect(function() -- Line: 205, Name: hover
            -- upvalues: u35 (copy)
            u35.Button.Background.ImageColor3 = Color3.fromRGB(255, 255, 255);
            u35.Button.Background.ImageTransparency = 0;
            u35.Button.Background.UIGradient.Enabled = false;
            u35.Button.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
            u35.Button.Title.TextColor3 = Color3.fromRGB(0, 0, 0);
        end);
    end;

    u30._action_slots.Invite.Button.MouseButton1Click:Connect(function() -- Line: 216
        -- upvalues: PartyController (ref), u30 (copy)
        PartyController:SendPartyInvite(u30._selected_player_list_slot.ClientFighter.Player);
    end);
    u30._action_slots.Friend.Button.MouseButton1Click:Connect(function() -- Line: 220
        -- upvalues: StarterGui (ref), u30 (copy)
        StarterGui:SetCore("PromptSendFriendRequest", u30._selected_player_list_slot.ClientFighter.Player);
    end);
    u30._action_slots.Challenge.Button.MouseButton1Click:Connect(function() -- Line: 224
        -- upvalues: QueuePadController (ref), u30 (copy)
        QueuePadController:SendChallengeRequest(u30._selected_player_list_slot.ClientFighter.Player);
    end);
    u30._action_slots.Spectate.Button.MouseButton1Click:Connect(function() -- Line: 228
        -- upvalues: u30 (copy), DuelController (ref), SpectateController (ref)
        u30._action_slots.Spectate.Visible = false;
        local Duel = DuelController:GetDuel(u30._selected_player_list_slot.ClientFighter.Player);

        if Duel then
            SpectateController:SpectateDuelRequest(Duel);
        end;
    end);
    u30._action_slots.ViewProfile.Button.MouseButton1Click:Connect(function() -- Line: 238
        -- upvalues: u30 (copy), Pages (ref)
        local Player = u30._selected_player_list_slot.ClientFighter.Player;
        Pages.PageSystem:OpenPage("ViewProfile");
        Pages.PageSystem:WaitForPage("ViewProfile"):Fetch(Player);
    end);
    u30._action_slots.ViewAvatar.Button.MouseButton1Click:Connect(function() -- Line: 245
        -- upvalues: GuiService (ref), u30 (copy)
        GuiService:InspectPlayerFromUserId(u30._selected_player_list_slot.ClientFighter.Player.UserId);
    end);
    u30._action_slots.Unfriend.Button.MouseButton1Click:Connect(function() -- Line: 249
        -- upvalues: StarterGui (ref), u30 (copy)
        StarterGui:SetCore("PromptUnfriend", u30._selected_player_list_slot.ClientFighter.Player);
    end);
    u30._action_slots.Block.Button.MouseButton1Click:Connect(function() -- Line: 253
        -- upvalues: StarterGui (ref), u30 (copy)
        StarterGui:SetCore("PromptBlockPlayer", u30._selected_player_list_slot.ClientFighter.Player);
    end);
    u30._action_slots.Unblock.Button.MouseButton1Click:Connect(function() -- Line: 257
        -- upvalues: StarterGui (ref), u30 (copy)
        StarterGui:SetCore("PromptUnblockPlayer", u30._selected_player_list_slot.ClientFighter.Player);
    end);
    u30._action_slots.Gift.Button.MouseButton1Click:Connect(function() -- Line: 261
        -- upvalues: u30 (copy), Pages (ref)
        local Player = u30._selected_player_list_slot.ClientFighter.Player;
        Pages.PageSystem:OpenPage("Gifting");
        Pages.PageSystem:WaitForPage("Gifting"):SelectPlayer(Player);
        Pages.PageSystem:WaitForPage("Gifting"):DontRedirect();
    end);
    u30._action_slots.Kick.Button.MouseButton1Click:Connect(function() -- Line: 269
        -- upvalues: PrivateServerController (ref), u30 (copy)
        PrivateServerController:ServerKick(u30._selected_player_list_slot.ClientFighter.Player);
    end);
    u30._action_slots.Ban.Button.MouseButton1Click:Connect(function() -- Line: 273
        -- upvalues: PrivateServerController (ref), u30 (copy)
        PrivateServerController:ServerBan(u30._selected_player_list_slot.ClientFighter.Player);
    end);
end;

function u3._Init(u36) -- Line: 278
    u36.PlayerList.OpenedChanged:Connect(function() -- Line: 279
        -- upvalues: u36 (copy)
        if not u36.PlayerList.IsOpen then
            u36:SelectPlayer(nil);
        end;
    end);
    u36.PlayerList.Elements.PlayerListSlotRemoved:Connect(function(p37) -- Line: 285
        -- upvalues: u36 (copy)
        if p37 == u36._selected_player_list_slot then
            u36:SelectPlayer(nil);
        end;
    end);
    u36.PlayerList.Elements.PlayerListSlotAdded:Connect(function(p38) -- Line: 291
        -- upvalues: u36 (copy)
        u36:_SlotAdded(p38);
    end);

    for _, v in pairs(u36.PlayerList.Elements.PlayerListSlots) do
        task.defer(u36._SlotAdded, u36, v);
    end;

    u36:_Setup();
    u36:SelectPlayer(nil);
end;

return u3;