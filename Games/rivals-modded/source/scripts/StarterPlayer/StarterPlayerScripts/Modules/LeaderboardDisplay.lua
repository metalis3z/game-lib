-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local LeaderboardLibrary = require(ReplicatedStorage.Modules.LeaderboardLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local LeaderboardController = require(Players.LocalPlayer.PlayerScripts.Controllers.LeaderboardController);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local LeaderboardPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LeaderboardPlayerSlot");
local LeaderboardButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LeaderboardButton");
local LeaderboardGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LeaderboardGui");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy), LeaderboardGui (copy)
    local v3 = setmetatable({}, u1);
    v3.Part = p2;
    v3.SurfaceGui = LeaderboardGui:Clone();
    v3._display_id = v3.Part:GetAttribute("DisplayID");
    v3._leaderboard_buttons = {};
    v3._leaderboard_name = nil;
    v3._leaderboard_serial = nil;
    v3._leaderboard_connections = {};
    v3._generate_hash = 0;
    v3._player_slots = {};
    v3:_Init();

    return v3;
end;

function u1.SelectLeaderboard(u4, p5) -- Line: 42
    -- upvalues: LeaderboardController (copy)
    for _, v in pairs(u4._leaderboard_connections) do
        v:Disconnect();
    end;

    u4._leaderboard_connections = {};
    u4._leaderboard_name = p5;
    u4._leaderboard_serial = LeaderboardController.LeaderboardSerials[u4._leaderboard_name];
    u4:_UpdateButtons();
    task.spawn(u4._Generate, u4);

    if not u4._leaderboard_name then
        return;
    end;

    local _leaderboard_connections = u4._leaderboard_connections;
    local LeaderboardRefreshedSignal = LeaderboardController:GetLeaderboardRefreshedSignal(u4._leaderboard_name);
    table.insert(_leaderboard_connections, LeaderboardRefreshedSignal:Connect(function() -- Line: 58
        -- upvalues: u4 (copy)
        u4:Refresh();
    end));
end;

function u1.Refresh(p6) -- Line: 63
    p6:SelectLeaderboard(p6._leaderboard_name);
end;

function u1._UpdateCanvasSize(p7) -- Line: 71
    p7.SurfaceGui.List.CanvasSize = UDim2.new(0, 0, 0, p7.SurfaceGui.List.Container.Layout.AbsoluteContentSize.Y);
end;

function u1._UpdateButtons(p8) -- Line: 75
    -- upvalues: LeaderboardLibrary (copy)
    for i, v in pairs(p8._leaderboard_buttons) do
        v.Button.Icon.Image = LeaderboardLibrary.DisplayInfo[i][i == p8._leaderboard_name and "IconFilled" or "Icon"];
        v.Button.Icon.Size = i == p8._leaderboard_name and UDim2.new(1, 0, 1, 0) or UDim2.new(0.6, 0, 0.6, 0);
    end;
end;

function u1._LiveDisplay(p9, p10) -- Line: 82
    while true do
        p9.SurfaceGui.Live.Text = "• LIVE";
        wait(1);

        if p10 ~= p9._generate_hash then
            break;
        end;

        p9.SurfaceGui.Live.Text = "LIVE";
        wait(0.25);

        if p10 ~= p9._generate_hash then
            return;
        end;
    end;
end;

function u1._Generate(p11) -- Line: 102
    -- upvalues: LeaderboardLibrary (copy), ComplianceController (copy), Utility (copy), LeaderboardPlayerSlot (copy), CONSTANTS (copy), RankIcon (copy)
    for _, v in pairs(p11._player_slots) do
        v:Destroy();
    end;

    p11._player_slots = {};
    p11._generate_hash = p11._generate_hash + 1;
    p11.SurfaceGui.Title.Text = "Loading...";
    p11.SurfaceGui.LiveBackground.Visible = false;
    p11.SurfaceGui.Live.Visible = false;
    local v12 = LeaderboardLibrary.DisplayInfo[p11._leaderboard_name] or {};
    local _generate_hash = p11._generate_hash;
    local v13 = {};

    for _, v in pairs(p11._leaderboard_serial and (p11._leaderboard_serial.Players or {}) or {}) do
        local v14 = tonumber(v.key);
        table.insert(v13, v14);
    end;

    local v15 = not (p11._leaderboard_serial and (#p11._leaderboard_serial.Players ~= 0 and #v13 ~= 0)) and {} or ComplianceController:GetUserInfos(v13, 25);

    if _generate_hash ~= p11._generate_hash then
        return;
    end;

    p11.SurfaceGui.Title.Text = v12 and (v12.DisplayName or "• • •") or "• • •";
    p11.SurfaceGui.Live.Visible = v12.LiveDisplayEnabled;
    p11.SurfaceGui.LiveBackground.Visible = v12.LiveDisplayEnabled;

    if v12.LiveDisplayEnabled then
        task.spawn(p11._LiveDisplay, p11, _generate_hash);
    end;

    for i, v in pairs(p11._leaderboard_serial and (p11._leaderboard_serial.Players or {}) or {}) do
        local key = v.key;
        local value = v.value;
        local v16 = v15[key];
        local v17 = v16 and (v16.DisplayName .. (v16.HasVerifiedBadge and utf8.char(57344) or "") or "• • •") or "• • •";
        local v18;

        if v16 and v16.Username then
            if v12.SanitizeUsernames then
                v18 = Utility:SanitizeName(v16.Username);
            else
                v18 = v16.Username;
            end;
        else
            v18 = nil;
        end;

        local v19 = LeaderboardPlayerSlot:Clone();
        v19.Left.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, key);
        v19.Left.Rank.Text = "#" .. i;
        v19.Left.Rank.TextColor3 = i == 1 and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 255, 255);
        v19.Left.Rank[i == 1 and "Normal" or "First"]:Destroy();
        v19.Left.DisplayName.Text = v17;
        v19.Left.DisplayName.Size = i == 1 and UDim2.new(2, 0, 0.4, 0) or UDim2.new(3, 0, 0.4, 0);
        v19.Left.Username.Text = v16 and (v18 and "@" .. v18) or "";
        v19.Left.UserID.Text = "#" .. key;
        v19.Right.Icon.Value.Text = Utility:PrettyNumber(value);
        v19.Right.Icon.Image = v12 and (v12.Icon or "") or "";
        v19.Right.Icon.UIGradient.Color = v12.ColorSequence;
        v19.Right.Icon.Value.Position = v12.TextPosition;
        v19.Right.Icon.Value.UIStroke.UIGradient.Color = v12.DarkColorSequence;
        v19.Size = i == 1 and UDim2.new(1, 0, 0.25, 0) or UDim2.new(1, 0, 0.15, 0);
        v19.LayoutOrder = i;
        v19.Parent = p11.SurfaceGui.List.Container;
        table.insert(p11._player_slots, v19);

        if p11._leaderboard_name == "Highest ELO" then
            v19.Right.Icon.Visible = false;
            v19.Right.Rank.Size = i == 1 and UDim2.new(1, 0, 1, 0) or UDim2.new(1.5, 0, 1.5, 0);
            local v20 = RankIcon.new(value, tonumber(key), i);
            v20:SetParent(v19.Right.Rank);
            v20:SetLabelFromELOEvent(nil, value, 10);
            v20:GetLabel().BackgroundTransparency = 1;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Thickness = 2;
            UIStroke.Parent = v20:GetLabelText();
        end;

        wait(0.06);

        if _generate_hash ~= p11._generate_hash then
            return;
        end;
    end;
end;

function u1._Setup(u21) -- Line: 194
    -- upvalues: LeaderboardLibrary (copy), LeaderboardButton (copy), ButtonEffect (copy), Players (copy)
    local v22 = nil;

    for i, v in pairs(LeaderboardLibrary.Order) do
        if LeaderboardLibrary.DisplayInfo[v].DisplayID == u21._display_id then
            local v23 = LeaderboardButton:Clone();
            v23.LayoutOrder = i;
            v23.Parent = u21.SurfaceGui.Buttons;
            u21._leaderboard_buttons[v] = v23;
            v23.Button.MouseButton1Click:Connect(function() -- Line: 209
                -- upvalues: u21 (copy), v (copy)
                u21:SelectLeaderboard(v);
            end);
            ButtonEffect:Add(v23.Button, nil, {
                HoverRatio = 1.05,
                ReleaseRatio = 1.05
            });
            v22 = v22 or v;
        end;
    end;

    u21:SelectLeaderboard(v22);
    u21.SurfaceGui.Adornee = u21.Part;
    u21.SurfaceGui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u24) -- Line: 223
    u24.SurfaceGui.List.Container.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 224
        -- upvalues: u24 (copy)
        u24:_UpdateCanvasSize();
    end);
    u24:_Setup();
    u24:_UpdateButtons();
    u24:_UpdateCanvasSize();
end;

return u1;