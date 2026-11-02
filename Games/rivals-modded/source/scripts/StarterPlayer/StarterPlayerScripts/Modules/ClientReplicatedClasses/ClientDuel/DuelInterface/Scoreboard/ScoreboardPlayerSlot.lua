-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local ScoreboardPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ScoreboardPlayerSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 18
    -- upvalues: u1 (copy), ScoreboardPlayerSlot (copy)
    local v4 = setmetatable({}, u1);
    v4.Scoreboard = p2;
    v4.ClientDueler = p3;
    v4.Frame = ScoreboardPlayerSlot:Clone();
    v4.UIGradient = v4.Frame:WaitForChild("UIGradient");
    v4.TeammateSlotContainer = v4.Frame:WaitForChild("TeammateSlotContainer");
    v4.RankContainer = v4.Frame:WaitForChild("RankContainer");
    v4.ConnectionLevel = v4.Frame:WaitForChild("ConnectionLevel");
    v4.ConnectionLevelIcon = v4.ConnectionLevel:WaitForChild("Icon");
    v4.DisplayNameText = v4.Frame:WaitForChild("DisplayName");
    v4.UsernameText = v4.Frame:WaitForChild("Username");
    v4.EliminationsText = v4.Frame:WaitForChild("Eliminations");
    v4.DeathsText = v4.Frame:WaitForChild("Deaths");
    v4.AssistsText = v4.Frame:WaitForChild("Assists");
    v4.PingText = v4.Frame:WaitForChild("Ping");
    v4.ScoreText = v4.Frame:WaitForChild("Score");
    v4.WeaponIcon = v4.Frame:WaitForChild("Weapon");
    v4._destroyed = false;
    v4._update_ping_connection = nil;
    v4._teammate_slot = nil;
    v4._rank_icon = nil;
    v4:_Init();

    return v4;
end;

function u1.UpdatePreferredTransparency(p5, p6) -- Line: 52
    p5.UIGradient.Transparency = NumberSequence.new(0, p6 or p5.Scoreboard:GetBackgroundTransparency());
end;

function u1.Update(p7) -- Line: 56
    -- upvalues: Utility (copy), ComplianceController (copy), TeammateSlot (copy), RankIcon (copy)
    p7:_Clear();

    if p7._destroyed then
        return;
    end;

    local v8 = p7.ClientDueler:Get("TeamID");
    local v9 = p7.ClientDueler.ClientFighter:Get("Controls");
    local table_find_ret = table.find(p7.Scoreboard.DuelInterface.ClientDuel.Duelers, p7.ClientDueler);
    local v10 = p7.ClientDueler:GetHealth() / p7.ClientDueler:GetMaxHealth();
    local v11 = p7.ClientDueler:Get("Damage") + 0.5;
    local math_floor_ret = math.floor(v11);
    local v12;

    if p7.Scoreboard.DuelInterface.ClientDuel.IsRanked or (p7.Scoreboard.DuelInterface.ClientDuel:Get("ScoresBehavior") ~= "Teams" or p7.Scoreboard.DuelInterface.ClientDuel:Get("ScoreNeededToWin")) then
        v12 = nil;
    else
        v12 = p7.ClientDueler.Player:GetAttribute("StatisticDuelsWinStreak");
    end;

    local Attribute = p7.ClientDueler.Player:GetAttribute("Level");
    local v13;

    if p7.Scoreboard.DuelInterface.ClientDuel:Get("ScoresBehavior") == "Duelers" then
        v13 = p7.Scoreboard.DuelInterface.ClientDuel:Get("Scores")[p7.ClientDueler:Get("DuelerID")];
    else
        v13 = false;
    end;

    local v14 = Utility:SanitizeName(p7.ClientDueler.Player.Name);
    p7.Frame.BackgroundColor3 = p7.Scoreboard:GetTeamColor(v8);
    p7.UsernameText.Text = p7.ClientDueler.Player.DisplayName == v14 and "" or "@" .. v14;
    p7.DisplayNameText.Text = ComplianceController:GetName(p7.ClientDueler.Player);
    p7.DisplayNameText.Position = p7.UsernameText.Text == "" and UDim2.new(0.1, 0, 0.5, 0) or UDim2.new(0.1, 0, 0.375, 0);
    p7.EliminationsText.Text = Utility:PrettyNumber(p7.ClientDueler:Get("Eliminations"));
    p7.DeathsText.Text = Utility:PrettyNumber(p7.ClientDueler:Get("Deaths"));
    p7.AssistsText.Text = Utility:PrettyNumber(p7.ClientDueler:Get("Assists"));
    p7.ConnectionLevelIcon.Image = Utility:GetConnectionLevelIcon(p7.ClientDueler.ClientFighter:Get("ConnectionLevel")) or "";
    p7.ConnectionLevel.Position = p7.ClientDueler.IsLocalPlayer and UDim2.new(0.925, 0, 0.55, 0) or UDim2.new(0.925, 0, 0.5, 0);
    p7.ConnectionLevel.AnchorPoint = p7.ClientDueler.IsLocalPlayer and Vector2.new(0.5, 1) or Vector2.new(0.5, 0.5);
    p7.PingText.Visible = p7.ClientDueler.IsLocalPlayer;
    p7.ScoreText.Text = v13 and Utility:PrettyNumber(v13) or Utility:PrettyNumber(math_floor_ret);
    p7.WeaponIcon.Image = "";
    local v15 = TeammateSlot.new(p7.ClientDueler.Player.UserId, v9, v10, not table_find_ret, true, v12, Attribute);
    v15.SlotFrame.Parent = p7.TeammateSlotContainer;

    if p7.ClientDueler:GetStaggeredSpawnsTurn() then
        v15:SetStaggeredSpawnsTurn(p7.ClientDueler:GetStaggeredSpawnsTurn(), v8);
    end;

    if p7.Scoreboard.DuelInterface.ClientDuel.IsRanked and p7.ClientDueler:CanShowRankToLocalPlayer() then
        p7._rank_icon = RankIcon.new(p7.ClientDueler.Player:GetAttribute("DisplayELO"), p7.ClientDueler.Player.UserId);
        p7._rank_icon:SetParent(p7.RankContainer);
    end;

    p7:UpdatePreferredTransparency();
end;

function u1.Destroy(p16) -- Line: 111
    p16._destroyed = true;

    if p16._update_ping_connection then
        p16._update_ping_connection:Disconnect();
        p16._update_ping_connection = nil;
    end;

    p16:_Clear();
    p16.Frame:Destroy();
end;

function u1._UpdatePing(p17) -- Line: 128
    -- upvalues: Utility (copy)
    local LocalConnectionPing = Utility:GetLocalConnectionPing();
    local ConnectionLevelIcon = Utility:GetConnectionLevelIcon((Utility:GetConnectionLevel(LocalConnectionPing)));
    p17.PingText.Text = LocalConnectionPing;
    p17.ConnectionLevelIcon.Image = ConnectionLevelIcon or "";
end;

function u1._Clear(p18) -- Line: 137
    if p18._teammate_slot then
        p18._teammate_slot:Destroy();
        p18._teammate_slot = nil;
    end;

    if p18._rank_icon then
        p18._rank_icon:Destroy();
        p18._rank_icon = nil;
    end;
end;

function u1._Setup(u19) -- Line: 149
    -- upvalues: RunService (copy)
    if u19.ClientDueler.IsLocalPlayer then
        u19._update_ping_connection = RunService.RenderStepped:Connect(function() -- Line: 151
            -- upvalues: u19 (copy)
            u19:_UpdatePing();
        end);
        u19:_UpdatePing();
    end;
end;

function u1._Init(p20) -- Line: 159
    p20:_Setup();
    p20:Update();
end;

return u1;