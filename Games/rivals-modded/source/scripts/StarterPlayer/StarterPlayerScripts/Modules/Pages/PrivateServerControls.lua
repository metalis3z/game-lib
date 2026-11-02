-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local SettingsInfo = require(ReplicatedStorage.Modules.SettingsInfo);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
require(ReplicatedStorage.Modules.Utility);
local PrivateServerController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PrivateServerController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local ArcadeController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local PrivateServerPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PrivateServerPlayerSlot");
local Settings = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings");
local u1 = {
    {
        "ArcadeStart",
        "",
        "",
        "Private Arcade",
        "rbxassetid://81276179444570",
        "Launch a private Arcade duel",
        "DropdownConfirm",
        DuelLibrary:GetArcadeModeDisplayNames()[1],
        DuelLibrary:GetArcadeModeDisplayNames(),
        true
    },
    { "ArcadeCanPlayAllMaps", "", "", "Play Any Map", "rbxassetid://18129688386", "Allows you to vote for any map in this duel", "Toggle", false },
    { "ArcadeEnd", "", "", "Private Arcade", "rbxassetid://81276179444570", "End the private Arcade duel", "Confirm", false },
    { "FreecamEnabled", "", "", "Freecam Access", "rbxassetid://17548980857", "Activated by pressing [Shift] + [P]", "Dropdown", "Everyone", { "Everyone", "Server Owner", "Nobody" } },
    { "UseLockedWeapons", "", "", "Use Locked Weapons", "rbxassetid://17229230506", "Allows all players to use locked weapons in duels", "Toggle", true },
    { "ShootingRangePVP", "", "", "Shooting Range PVP", "rbxassetid://119084789924359", "Allows you to battle each other in the Shooting Range", "Toggle", false }
};
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 29
    -- upvalues: Page (copy), u2 (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.CloseButton = v4.PageFrame:WaitForChild("Close");
    v4.LockedFrame = v4.PageFrame:WaitForChild("Locked");
    v4.List = v4.PageFrame:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.PlayersFrame = v4.Container:WaitForChild("Players");
    v4.PlayersContainer = v4.PlayersFrame:WaitForChild("Container");
    v4.PlayersLayout = v4.PlayersContainer:WaitForChild("Layout");
    v4.BannedPlayersFrame = v4.Container:WaitForChild("BannedPlayers");
    v4.BannedPlayersContainer = v4.BannedPlayersFrame:WaitForChild("Container");
    v4.BannedPlayersLayout = v4.BannedPlayersContainer:WaitForChild("Layout");
    v4._setting_objects = {};
    v4._player_slots = {};
    v4._arcade_mode_display_names = nil;
    v4._to_arcade_mode_name = nil;
    v4:_Init();

    return v4;
end;

function u2.Open(p5, ...) -- Line: 58
    -- upvalues: Page (copy)
    Page.Open(p5, ...);
    p5:_UpdatePlayers();
    p5:_UpdateArcadeStatus();
end;

function u2._UpdateArcade(p6) -- Line: 68
    -- upvalues: DuelLibrary (copy)
    local ArcadeModeDisplayNames, v7 = DuelLibrary:GetArcadeModeDisplayNames();
    p6._arcade_mode_display_names = ArcadeModeDisplayNames;
    p6._to_arcade_mode_name = v7;
end;

function u2._UpdateArcadeStatus(p8) -- Line: 72
    -- upvalues: ArcadeController (copy)
    if not p8:IsOpen() then
        return;
    end;

    local v9 = ArcadeController.CurrentDuel ~= nil;
    p8._setting_objects.ArcadeStart.SettingFrame.Visible = not v9;
    p8._setting_objects.ArcadeCanPlayAllMaps.SettingFrame.Visible = not v9;
    p8._setting_objects.ArcadeEnd.SettingFrame.Visible = v9;
end;

function u2._CreatePlayerSlot(p10, p11, p12, p13, p14, p15, p16, p17, p18) -- Line: 84
    -- upvalues: PrivateServerPlayerSlot (copy), CONSTANTS (copy), ButtonEffect (copy)
    local u19 = PrivateServerPlayerSlot:Clone();
    u19.Kick.Visible = p16;
    u19.Ban.Visible = p17;
    u19.Unban.Visible = p18;
    u19.Icon.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p13);
    u19.DisplayName.Controls.Image = "";
    u19.DisplayName.Text = p14;
    u19.Username.Text = "@" .. p15;
    u19.LayoutOrder = p11;
    u19.Parent = p12;
    p10._player_slots[tostring(p13)] = u19;
    u19.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 97, Name: update
        -- upvalues: u19 (copy)
        u19.DisplayName.Controls.Position = UDim2.new(0, u19.DisplayName.TextBounds.X, 0.5, 0);
    end);
    u19.DisplayName.Controls.Position = UDim2.new(0, u19.DisplayName.TextBounds.X, 0.5, 0);
    ButtonEffect:Add(u19.Kick);
    ButtonEffect:Add(u19.Ban);
    ButtonEffect:Add(u19.Unban);

    return u19;
end;

function u2._UpdatePlayers(p20) -- Line: 111
    -- upvalues: FighterController (copy), CONSTANTS (copy), Players (copy), PrivateServerController (copy), ReplicatedStorage (copy)
    if not p20:IsOpen() then
        for _, v in pairs(p20._player_slots) do
            v:Destroy();
        end;

        p20._player_slots = {};

        return;
    end;

    local v21 = {};

    for i, v in pairs(FighterController.Objects) do
        local Player = v.Player;

        if CONSTANTS.IS_STUDIO or Player ~= Players.LocalPlayer then
            v21[tostring(Player.UserId)] = true;

            if not p20._player_slots[tostring(Player.UserId)] then
                local v22 = p20:_CreatePlayerSlot(i, p20.PlayersContainer, Player.UserId, Player.DisplayName, Player.Name, CONSTANTS.IS_STUDIO or Player ~= Players.LocalPlayer, true, false);
                v22.Kick.MouseButton1Click:Connect(function() -- Line: 142
                    -- upvalues: PrivateServerController (ref), Player (copy)
                    PrivateServerController:ServerKick(Player);
                end);
                v22.Ban.MouseButton1Click:Connect(function() -- Line: 146
                    -- upvalues: PrivateServerController (ref), Player (copy)
                    PrivateServerController:ServerBan(Player);
                end);
            end;
        end;
    end;

    for i, v in pairs(PrivateServerController.BannedPlayers) do
        local table_unpack_ret, v23, v24 = table.unpack(v);
        v21[tostring(table_unpack_ret)] = true;

        if not p20._player_slots[tostring(table_unpack_ret)] then
            p20:_CreatePlayerSlot(i, p20.BannedPlayersContainer, table_unpack_ret, v23, v24, false, false, true).Unban.MouseButton1Click:Connect(function() -- Line: 164
                -- upvalues: ReplicatedStorage (ref), table_unpack_ret (copy)
                ReplicatedStorage.Remotes.PrivateServer.UnbanPlayer:FireServer(table_unpack_ret);
            end);
        end;
    end;

    local v25 = {};

    for i, v in pairs(p20._player_slots) do
        if not v21[i] then
            v25[i] = true;
            v:Destroy();
        end;
    end;

    for i in pairs(v25) do
        p20._player_slots[i] = nil;
    end;
end;

function u2._Setup(u26) -- Line: 186
    -- upvalues: u1 (copy), SettingsInfo (copy), Settings (copy), ReplicatedStorage (copy), CONSTANTS (copy), Players (copy)
    for i, v in pairs(u1) do
        local v27 = v[1];
        local v28 = SettingsInfo.new(select(2, table.unpack(v)));
        require(Settings:WaitForChild(v28.InputType));
        local v29 = require(Settings:WaitForChild(v28.InputType)).new(v28);
        v29.SettingFrame.LayoutOrder = i;
        v29.SettingFrame.Parent = u26.Container;
        u26._setting_objects[v27] = v29;
    end;

    u26._setting_objects.UseLockedWeapons.Replicate:Connect(function(p30) -- Line: 198
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.PrivateServer.SetUseLockedWeapons:FireServer(p30 or false);
    end);
    u26._setting_objects.ShootingRangePVP.Replicate:Connect(function(p31) -- Line: 202
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.PrivateServer.SetShootingRangePVP:FireServer(p31 or false);
    end);
    u26._setting_objects.FreecamEnabled.Replicate:Connect(function(p32) -- Line: 206
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.PrivateServer.SetFreecamEnabled:FireServer(p32);
    end);
    u26._setting_objects.ArcadeCanPlayAllMaps.Replicate:Connect(function(p33) -- Line: 210
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.PrivateServer.SetArcadeCanPlayAllMaps:FireServer(p33);
    end);
    u26._setting_objects.ArcadeStart.Replicate:Connect(function(p34) -- Line: 214
        -- upvalues: u26 (copy), ReplicatedStorage (ref)
        u26:_UpdateArcade();
        ReplicatedStorage.Remotes.PrivateServer.StartArcadeMode:FireServer(u26._to_arcade_mode_name[p34]);
    end);
    u26._setting_objects.ArcadeEnd.Replicate:Connect(function() -- Line: 219
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.PrivateServer.EndArcadeMode:FireServer();
    end);
    u26._setting_objects.ArcadeEnd:SetConfirmColor("Red");
    u26._setting_objects.ArcadeCanPlayAllMaps:Scale(0.95);
    local v35 = CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId);
    u26.LockedFrame.Visible = not v35;
    u26.List.Visible = v35;
end;

function u2._Init(u36) -- Line: 232
    -- upvalues: FighterController (copy), PrivateServerController (copy), ArcadeController (copy), ButtonEffect (copy)
    u36.CloseButton.MouseButton1Click:Connect(function() -- Line: 233
        -- upvalues: u36 (copy)
        u36:CloseRequest();
    end);
    u36.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 237
        -- upvalues: u36 (copy)
        u36.List.CanvasSize = UDim2.new(0, 0, 0, u36.Layout.AbsoluteContentSize.Y);
        u36.List.Active = u36.Layout.AbsoluteContentSize.Y >= u36.List.AbsoluteSize.Y;
    end);
    u36.PlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 242
        -- upvalues: u36 (copy)
        u36.PlayersFrame.Size = UDim2.new(1, 0, 0, u36.PlayersLayout.AbsoluteContentSize.Y);
    end);
    u36.PlayersFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 246
        -- upvalues: u36 (copy)
        u36.PlayersFrame.Visible = u36.PlayersFrame.AbsoluteSize.Y > 0;
    end);
    u36.BannedPlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 250
        -- upvalues: u36 (copy)
        u36.BannedPlayersFrame.Size = UDim2.new(1, 0, 0, u36.BannedPlayersLayout.AbsoluteContentSize.Y);
    end);
    u36.BannedPlayersFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 254
        -- upvalues: u36 (copy)
        u36.BannedPlayersFrame.Visible = u36.BannedPlayersFrame.AbsoluteSize.Y > 0;
    end);
    FighterController.ObjectAdded:Connect(function() -- Line: 258
        -- upvalues: u36 (copy)
        u36:_UpdatePlayers();
    end);
    FighterController.ObjectRemoved:Connect(function() -- Line: 262
        -- upvalues: u36 (copy)
        u36:_UpdatePlayers();
    end);
    PrivateServerController.BannedPlayersChanged:Connect(function() -- Line: 266
        -- upvalues: u36 (copy)
        u36:_UpdatePlayers();
    end);
    ArcadeController.DuelSet:Connect(function() -- Line: 270
        -- upvalues: u36 (copy)
        u36:_UpdateArcadeStatus();
    end);
    u36:_Setup();
    u36:_UpdateArcade();
    ButtonEffect:Add(u36.CloseButton);
end;

return u2._new();