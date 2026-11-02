-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local NametagGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("NametagGui");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7, p8) -- Line: 17
    -- upvalues: u1 (copy), NametagGui (copy)
    local v9 = setmetatable({}, u1);
    v9.BillboardGui = NametagGui:Clone();
    v9._player_object = p2;
    v9._controls = p3;
    v9._win_streak = p4 or 0;
    v9._level = p5 or 0;
    v9._elo = p6;
    v9._status = p7;
    v9._rank_icon = nil;
    v9._is_matchmaking = p8;
    v9:_Init();

    return v9;
end;

function u1.GetWinStreak(p10) -- Line: 40
    return p10._win_streak;
end;

function u1.SetParent(p11, p12) -- Line: 44
    p11.BillboardGui.Parent = p12;
    p11:_UpdateLayout();
end;

function u1.Destroy(p13) -- Line: 49
    -- upvalues: WeaponStatusHandler (copy)
    WeaponStatusHandler:ClearStatusElements(p13.BillboardGui.Elements.NameDisplay.DisplayName);
    WeaponStatusHandler:ClearStatusElements(p13.BillboardGui.Elements.NameDisplay.Username);
    p13.BillboardGui:Destroy();

    if p13._rank_icon then
        p13._rank_icon:Destroy();
    end;

    if p13._matchmaking_connection then
        p13._matchmaking_connection:Disconnect();
        p13._matchmaking_connection = nil;
    end;
end;

function u1._UpdateLayout(p14) -- Line: 69
    p14.BillboardGui.Elements.NameDisplay.Size = UDim2.new(0, math.max(p14.BillboardGui.Elements.NameDisplay.DisplayName.TextBounds.X, p14.BillboardGui.Elements.NameDisplay.Username.TextBounds.X), 1, 0);
    p14.BillboardGui.Elements.Data.Streak.Position = UDim2.new(0.5, -math.max(0, (p14.BillboardGui.Elements.Data.Streak.Value.TextBounds.X - p14.BillboardGui.Elements.Data.Streak.AbsoluteSize.X) / 2), 0.5, 0);
    p14.BillboardGui.Elements.Data.Level.Position = UDim2.new(0.5, -math.max(0, (p14.BillboardGui.Elements.Data.Level.Title.TextBounds.X - p14.BillboardGui.Elements.Data.Level.AbsoluteSize.X) / 2), 0.5, 0);
end;

function u1._SetupMatchmaking(p15) -- Line: 75
    -- upvalues: RunService (copy)
    p15.BillboardGui.Matchmaking.Visible = p15._is_matchmaking;

    if not p15.BillboardGui.Matchmaking.Visible then
        return;
    end;

    local Container = p15.BillboardGui.Matchmaking.Container;
    local Scroller = Container.Scroller;
    local Icon1 = Scroller.Icon1;
    local Icon2 = Scroller.Icon2;
    p15._matchmaking_connection = RunService.RenderStepped:Connect(function() -- Line: 87
        -- upvalues: Icon1 (copy), Container (copy), Scroller (copy), Icon2 (copy)
        local v16 = tick() * 0.75;
        local math_sin_ret = math.sin(v16);
        local v17 = tick() * 1.5;
        local math_sin_ret2 = math.sin(v17);
        local v18 = math_sin_ret * 10;
        local v19 = -math_sin_ret * 0.625 % Icon1.Size.X.Scale;
        local v20 = -math_sin_ret2 * 0.125;
        Container.Position = UDim2.new(math_sin_ret * 0.025 + 0.5, 0, math_sin_ret2 * 0.025 + 0.25, 0);
        Container.Rotation = v18;
        Scroller.Rotation = -v18;
        Icon1.Position = UDim2.new(v19, 0, v20, 0);
        Icon2.Position = UDim2.new(v19 - 1.5, 0, v20, 0);
    end);
end;

function u1._Setup(p21) -- Line: 105
    -- upvalues: CONSTANTS (copy), Utility (copy), ComplianceController (copy), WeaponStatusHandler (copy), PlayerDataController (copy), RankIcon (copy)
    p21.BillboardGui.Elements.Controls.Icon.Image = CONSTANTS.CONTROLS_IMAGES_CENTERED[p21._controls] or "";
    local v22 = Utility:SanitizeName(p21._player_object.Name);
    p21.BillboardGui.Elements.NameDisplay.Username.Text = p21._player_object.DisplayName == v22 and "" or "@" .. v22;
    p21.BillboardGui.Elements.NameDisplay.DisplayName.Text = ComplianceController:GetName(p21._player_object);
    WeaponStatusHandler:ApplyItemStatusToText(p21.BillboardGui.Elements.NameDisplay.DisplayName, p21._status);
    local Setting = PlayerDataController:GetSetting("PlayerList Leaderstat");
    local v23;

    if Setting == "Current ELO" then
        v23 = p21._elo;
    else
        v23 = false;
    end;

    p21.BillboardGui.Elements.Data.Rank.Visible = v23;

    if p21._elo then
        p21._rank_icon = RankIcon.new(p21._elo, p21._player_object.UserId);
        p21._rank_icon:SetParent(p21.BillboardGui.Elements.Data.Rank);
    end;

    local v24;

    if Setting == "Win Streak" then
        v24 = p21._win_streak > 0;
    else
        v24 = false;
    end;

    p21.BillboardGui.Elements.Data.Streak.Visible = v24;
    p21.BillboardGui.Elements.Data.Streak.Value.Text = Utility:PrettyNumber(p21._win_streak);
    local v25;

    if Setting == "Level" then
        v25 = true;
    else
        v25 = not p21.BillboardGui.Elements.Data.Streak.Visible and not p21.BillboardGui.Elements.Data.Rank.Visible;
    end;

    p21.BillboardGui.Elements.Data.Level.Visible = v25;
    p21.BillboardGui.Elements.Data.Level.Title.Text = Utility:PrettyNumber(p21._level);
    p21:_SetupMatchmaking();
    p21:_UpdateLayout();
end;

function u1._Init(u26) -- Line: 133
    u26.BillboardGui.Elements:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 134
        -- upvalues: u26 (copy)
        u26:_UpdateLayout();
    end);
    u26.BillboardGui.Elements.NameDisplay.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 138
        -- upvalues: u26 (copy)
        u26:_UpdateLayout();
    end);
    u26.BillboardGui.Elements.NameDisplay.Username:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 142
        -- upvalues: u26 (copy)
        u26:_UpdateLayout();
    end);
    u26.BillboardGui.Elements.Data.Streak:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 146
        -- upvalues: u26 (copy)
        u26:_UpdateLayout();
    end);
    u26.BillboardGui.Elements.Data.Streak.Value:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 150
        -- upvalues: u26 (copy)
        u26:_UpdateLayout();
    end);
    u26.BillboardGui.Elements.Data.Level:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 154
        -- upvalues: u26 (copy)
        u26:_UpdateLayout();
    end);
    u26.BillboardGui.Elements.Data.Level.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 158
        -- upvalues: u26 (copy)
        u26:_UpdateLayout();
    end);
    task.spawn(u26._Setup, u26);
end;

return u1;