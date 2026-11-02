-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local LeaderboardController = require(Players.LocalPlayer.PlayerScripts.Controllers.LeaderboardController);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local TeammateSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TeammateSlot");
local UDim2_new_ret = UDim2.new(0.5, 0, 0.5, 0);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7, p8) -- Line: 17
    -- upvalues: u1 (copy), TeammateSlot (copy)
    local v9 = setmetatable({}, u1);
    v9.SlotFrame = TeammateSlot:Clone();
    v9._destroyed = false;
    v9._connections = {};
    v9._user_id = p2;
    v9._controls = p3;
    v9._health_percent = p4 or 1;
    v9._disconnected = p5;
    v9._hide_health = p6;

    if not (p7 and (p7 > 0 and p7)) then
        p7 = nil;
    end;

    v9._win_streak = p7;
    v9._level = p8 or nil;
    v9._display_elo_set = false;
    v9._display_elo = nil;
    v9._rank_icon = nil;
    v9._override_icon = nil;
    v9._override_icon_size = nil;
    v9._override_icon_color = nil;
    v9._override_icon_text = nil;
    v9._override_icon_text_color = nil;
    v9:_Init();

    return v9;
end;

function u1.SetDetails(p10, p11, p12, p13, p14, p15, p16) -- Line: 49
    p10._controls = p11;
    p10:SetHealthPercent(p12, true);
    p10:SetDisconnected(p13, true);
    p10._hide_health = p14;

    if not (p15 and (p15 > 0 and p15)) then
        p15 = nil;
    end;

    p10._win_streak = p15;
    p10._level = p16 or nil;
    p10:_UpdateDetails();
end;

function u1.SetDisplayELO(p17, p18) -- Line: 59
    p17._display_elo_set = true;
    p17._display_elo = p18;
    p17:_UpdateRankIcon();
end;

function u1.SetDisconnected(p19, p20, p21) -- Line: 65
    if p20 then
        p19:OverrideIcon(nil, nil, nil, nil, nil, p21);
    end;

    p19._disconnected = p20;

    if not p21 then
        p19:_UpdateDetails();
    end;
end;

function u1.SetHealthPercent(p22, p23, p24) -- Line: 77
    p22._health_percent = p23 or 1;

    if not p24 then
        p22:_UpdateDetails();
    end;
end;

function u1.OverrideIcon(p25, p26, p27, p28, p29, p30, p31) -- Line: 85
    if p25._disconnected then
        return;
    end;

    p25._override_icon = p26;
    p25._override_icon_size = p27;
    p25._override_icon_color = p28;
    p25._override_icon_text = p29;
    p25._override_icon_text_color = p30;

    if not p31 then
        p25:_UpdateDetails();
    end;
end;

function u1.SetStaggeredSpawnsTurn(p32, p33, p34) -- Line: 101
    -- upvalues: DuelLibrary (copy)
    if p33 then
        p32:OverrideIcon("rbxassetid://15319354627", UDim2.new(0.75, 0, 0.75, 0), Color3.fromRGB(0, 0, 0), p33, DuelLibrary:GetTeamColor(p34, Color3.fromRGB(255, 255, 255)));

        return;
    end;

    p32:OverrideIcon();
end;

function u1.Destroy(u35) -- Line: 109
    u35._destroyed = true;

    for _, v in pairs(u35._connections) do
        v:Disconnect();
    end;

    u35._connections = {};
    u35:SetDisplayELO(nil);
    pcall(function() -- Line: 120
        -- upvalues: u35 (copy)
        u35.SlotFrame:Destroy();
    end);
end;

function u1._UpdateRankIcon(p36) -- Line: 129
    -- upvalues: RankIcon (copy)
    if p36._rank_icon then
        p36._rank_icon:Destroy();
        p36._rank_icon = nil;
    end;

    if p36._destroyed or not p36._display_elo_set then
        return;
    end;

    local v37 = p36.SlotFrame:FindFirstChild("Container") and p36.SlotFrame.Container:FindFirstChild("Rank");

    if not v37 then
        return;
    end;

    p36._rank_icon = RankIcon.new(p36._display_elo, p36._user_id);
    p36._rank_icon:SetParent(v37);
end;

function u1._UpdateDetails(p38) -- Line: 149
    -- upvalues: UDim2_new_ret (copy), CONSTANTS (copy), Utility (copy)
    if p38._destroyed then
        return;
    end;

    local v39 = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(255, 215, 0):Lerp(Color3.fromRGB(100, 255, 50), p38._health_percent), p38._health_percent);
    local Color3_new_ret = Color3.new(v39.R / 2, v39.G / 2, v39.B / 2);
    local v40 = not p38._disconnected and p38._health_percent > 0;
    local v41;

    if v40 then
        v41 = not p38._hide_health;
    else
        v41 = v40;
    end;

    p38.SlotFrame.Container.Health.Visible = v41;
    p38.SlotFrame.Container.Health.Bar.Size = UDim2.new(p38._health_percent, 0, 1, 0);
    p38.SlotFrame.Container.Health.BackgroundColor3 = Color3_new_ret;
    p38.SlotFrame.Container.Health.UIStroke.Color = Color3.new(v39.R * 0.25, v39.G * 0.25, v39.B * 0.25);
    p38.SlotFrame.Container.Health.Bar.BackgroundColor3 = v39;
    p38.SlotFrame.Container.Health.Bar.UIStroke.Color = v39;
    p38.SlotFrame.Container.Headshot.ImageTransparency = v40 and 0 or 0.75;
    p38.SlotFrame.Container.Icon.Visible = not v40;
    p38.SlotFrame.Container.Icon.Image = p38._override_icon or (p38._disconnected and "rbxassetid://16782728353" or (v40 and "" or "rbxassetid://16802957270"));
    p38.SlotFrame.Container.Icon.Size = p38._override_icon_size or UDim2_new_ret;
    p38.SlotFrame.Container.Icon.ImageColor3 = p38._override_icon_color or Color3.fromRGB(255, 255, 255);
    p38.SlotFrame.Container.Icon.TextLabel.Text = p38._override_icon_text or "";
    p38.SlotFrame.Container.Icon.TextLabel.TextColor3 = p38._override_icon_text_color or Color3.fromRGB(0, 0, 0);
    p38.SlotFrame.Container.Controls.Image = v40 and (not p38._win_streak and p38._controls) and (CONSTANTS.CONTROLS_IMAGES[p38._controls] or "") or "";
    p38.SlotFrame.Container.Streak.Visible = v40 and p38._win_streak and p38._win_streak > 0;
    p38.SlotFrame.Container.Streak.Value.Text = Utility:PrettyNumber(p38._win_streak or 0);
    local v42;

    if v40 then
        v42 = p38._level;
    else
        v42 = v40;
    end;

    p38.SlotFrame.Container.Level.Visible = v42;
    p38.SlotFrame.Container.Level.Title.Text = Utility:PrettyNumber(p38._level or 0);
    p38.SlotFrame.Container.Rank.Visible = v40;
end;

function u1._Setup(p43) -- Line: 179
    -- upvalues: CONSTANTS (copy)
    p43.SlotFrame.Container.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p43._user_id);
end;

function u1._Init(u44) -- Line: 183
    -- upvalues: LeaderboardController (copy)
    local _connections = u44._connections;
    local LeaderboardRefreshedSignal = LeaderboardController:GetLeaderboardRefreshedSignal("Highest ELO");
    table.insert(_connections, LeaderboardRefreshedSignal:Connect(function() -- Line: 184
        -- upvalues: u44 (copy)
        u44:_UpdateRankIcon();
    end));
    u44.SlotFrame.Destroying:Connect(function() -- Line: 188
        -- upvalues: u44 (copy)
        u44:Destroy();
    end);
    u44:_Setup();
    u44:_UpdateDetails();
end;

return u1;