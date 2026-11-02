-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local ScoreboardPlayerSlot = require(script:WaitForChild("ScoreboardPlayerSlot"));
local BanIcon = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BanIcon");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.VisibilityChanged = Signal.new();
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Scoreboard");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.TopFrame = v3.Container:WaitForChild("Top");
    v3.TopBackground = v3.TopFrame:WaitForChild("Background");
    v3.TopText = v3.TopFrame:WaitForChild("Score");
    v3.BottomFrame = v3.Container:WaitForChild("Bottom");
    v3.BottomBackground = v3.BottomFrame:WaitForChild("Background");
    v3.BottomInformationText = v3.BottomFrame:WaitForChild("Information");
    v3.ButtonsFrame = v3.Container:WaitForChild("Buttons");
    v3.ButtonsContainer = v3.ButtonsFrame:WaitForChild("Container");
    v3.BannedWeaponsFrame = v3.Container:WaitForChild("BannedWeapons");
    v3.BannedWeaponsContainer = v3.BannedWeaponsFrame:WaitForChild("Container");
    v3.PlayersFrame = v3.Container:WaitForChild("Players");
    v3.PlayersBottomFade = v3.PlayersFrame:WaitForChild("BottomFade");
    v3.PlayersTopFade = v3.PlayersFrame:WaitForChild("TopFade");
    v3.PlayersList = v3.PlayersFrame:WaitForChild("List");
    v3.PlayersContainer = v3.PlayersList:WaitForChild("Container");
    v3.PlayersLayout = v3.PlayersContainer:WaitForChild("Layout");
    v3._destroyed = false;
    v3._scoreboard_open = false;
    v3._scoreboard_player_slots = {};
    v3._scoreboard_local_player_slot = nil;
    v3._neutral_team_color_index = 0;
    v3._banned_weapon_icons = {};
    v3:_Init();

    return v3;
end;

function u1.IsOpen(p4) -- Line: 61
    return not p4._destroyed and p4.Frame.Visible;
end;

function u1.GetTeamColor(p5, p6) -- Line: 65
    -- upvalues: DuelLibrary (copy)
    local TeamColor = DuelLibrary:GetTeamColor(p6);

    if p6 then
        return TeamColor;
    end;

    local v7, v8, v9 = TeamColor:ToHSV();
    p5._neutral_team_color_index = p5._neutral_team_color_index + 1;

    return Color3.fromHSV(v7, v8, v9 - (p5._neutral_team_color_index % 2 == 0 and 0.05 or 0));
end;

function u1.GetBackgroundTransparency(p10) -- Line: 80
    -- upvalues: GuiService (copy)
    return 0 + 0.25 * GuiService.PreferredTransparency;
end;

function u1.Open(p11, p12) -- Line: 84
    if p11._destroyed then
        return;
    end;

    if p12 == nil then
        p12 = p11._scoreboard_open;
    end;

    p11._scoreboard_open = p12;
    local Frame = p11.Frame;
    local v13 = p11._scoreboard_open and not p11.DuelInterface:IsPageOpen() and not (p11.DuelInterface.Voting:IsOpen() or p11.DuelInterface.FinalResults:IsActive()) and p11.DuelInterface.ClientDuel:Get("Status") ~= "GameOver";
    Frame.Visible = v13;
    p11.VisibilityChanged:Fire();
    p11:Generate();
end;

function u1.UpdatePreferredTransparency(p14) -- Line: 95
    local BackgroundTransparency = p14:GetBackgroundTransparency();
    p14.TopBackground.ImageTransparency = BackgroundTransparency;
    p14.BottomBackground.ImageTransparency = BackgroundTransparency;

    for _, v in pairs(p14._scoreboard_player_slots) do
        v:UpdatePreferredTransparency(BackgroundTransparency);
    end;
end;

function u1.Generate(p15) -- Line: 106
    -- upvalues: DuelLibrary (copy), SpectateController (copy), BanIcon (copy), ItemLibrary (copy), ScoreboardPlayerSlot (copy)
    for _, v in pairs(p15._scoreboard_player_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p15._banned_weapon_icons) do
        v:Destroy();
    end;

    p15._banned_weapon_icons = {};
    p15._scoreboard_player_slots = {};
    p15._scoreboard_local_player_slot = nil;
    p15._neutral_team_color_index = 0;

    if p15._destroyed or not p15.Frame.Visible then
        return;
    end;

    local v16 = p15.DuelInterface.ClientDuel:Get("PlaySourceName");

    if v16 then
        v16 = DuelLibrary.PlaySources[v16].DisplayName;
    end;

    local v17 = p15.DuelInterface.ClientDuel.Map and p15.DuelInterface.ClientDuel.Map.Name;
    local v18 = p15.DuelInterface.ClientDuel.Map and p15.DuelInterface.ClientDuel.Map:GetScoreboardDisplay();
    local BottomInformationText = p15.BottomInformationText;

    if v18 then
        v17 = v18;
    elseif not (v17 and (v16 and v17 == v16) or v17 and not v16) then
        if v16 and v17 then
            v17 = string.format("%s   •   %s", v16, v17);
        else
            v17 = (not v16 or v17) and "" or v16;
        end;
    end;

    BottomInformationText.Text = v17;
    local CurrentSubject = SpectateController.CurrentSubject;
    local v19;

    if CurrentSubject then
        v19 = CurrentSubject:Get("WeaponPool");
    else
        v19 = CurrentSubject;
    end;

    if CurrentSubject then
        CurrentSubject = CurrentSubject:Get("WeaponPoolFilterType");
    end;

    if CurrentSubject == "Blacklist" and (#v19 > 0 and not p15.DuelInterface.ClientDuel:Get("ArcadeMode")) then
        p15.BannedWeaponsFrame.Visible = true;

        for i, v in pairs(v19) do
            local v20 = BanIcon:Clone();
            v20.ImageColor3 = Color3.fromRGB(127, 25, 25);
            v20.Icon.ImageColor3 = Color3.fromRGB(255, 50, 50);
            v20.LayoutOrder = i;
            v20.Weapon.Icon.Image = ItemLibrary.ViewModels[v].ImageCentered or ItemLibrary.Items[v].Image;
            v20.Weapon.ZIndex = 10;
            v20.Weapon.Visible = true;
            v20.Parent = p15.BannedWeaponsContainer;
            table.insert(p15._banned_weapon_icons, v20);
        end;
    else
        p15.BannedWeaponsFrame.Visible = false;
    end;

    local LoggedClientDuelers = p15.DuelInterface:GetLoggedClientDuelers(true);

    for i, v in pairs(LoggedClientDuelers) do
        local v21 = p15._scoreboard_player_slots[v];

        if v21 then
            v21.Frame.LayoutOrder = i;
            v21:Update();
        else
            local v22 = ScoreboardPlayerSlot.new(p15, v);
            v22.Frame.LayoutOrder = i;
            v22.Frame.Parent = p15.PlayersContainer;
            p15._scoreboard_player_slots[v] = v22;

            if v.IsLocalPlayer then
                p15._scoreboard_local_player_slot = v22;
            end;
        end;
    end;

    local v23 = {};

    for i, v in pairs(p15._scoreboard_player_slots) do
        if not table.find(LoggedClientDuelers, i) then
            v:Destroy();
            v23[i] = true;

            if i.IsLocalPlayer then
                p15._scoreboard_local_player_slot = nil;
            end;
        end;
    end;

    for i in pairs(v23) do
        p15._scoreboard_player_slots[i] = nil;
    end;
end;

function u1.Destroy(p24) -- Line: 203
    p24._destroyed = true;

    for _, v in pairs(p24._scoreboard_player_slots) do
        v:Destroy();
    end;

    p24._scoreboard_player_slots = {};
    p24._scoreboard_local_player_slot = nil;
    p24.VisibilityChanged:Destroy();
end;

function u1._UpdateFade(p25) -- Line: 220
    local v26 = p25.PlayersFrame.AbsoluteSize.X * 0.2;
    local math_max_ret = math.max(0, p25.PlayersList.AbsoluteCanvasSize.Y - p25.PlayersList.AbsoluteWindowSize.Y - 5 - p25.PlayersList.CanvasPosition.Y);
    local math_max_ret2 = math.max(0, p25.PlayersList.CanvasPosition.Y - 5);
    local math_clamp_ret = math.clamp(1 - math_max_ret / v26, 0, 1);
    local math_clamp_ret2 = math.clamp(1 - math_max_ret2 / v26, 0, 1);
    p25.PlayersBottomFade.BackgroundTransparency = math_clamp_ret * 0.5 + 0.5;
    p25.PlayersTopFade.BackgroundTransparency = math_clamp_ret2 * 0.5 + 0.5;
    p25.PlayersList.ClipsDescendants = math.abs(p25.PlayersList.AbsoluteCanvasSize.Y - p25.PlayersList.AbsoluteWindowSize.Y) > 5;
end;

function u1._UpdateLayout(p27) -- Line: 232
    p27.PlayersFrame.Size = UDim2.new(1, 0, 0, (math.min(p27.PlayersLayout.AbsoluteContentSize.Y, (p27.DuelInterface.Frame.AbsoluteSize.Y - (p27.Layout.AbsoluteContentSize.Y - p27.PlayersFrame.AbsoluteSize.Y)) * 0.5)));
    p27.PlayersList.CanvasSize = UDim2.new(0, 0, 0, p27.PlayersLayout.AbsoluteContentSize.Y);
end;

function u1._UpdateButtonsVisibility(p28) -- Line: 239
    p28.ButtonsFrame.Visible = #p28.ButtonsContainer:GetChildren() > 0;
end;

function u1._Setup(p29) -- Line: 243
    p29.TopText.Text = SHOW_WEAPON_IN_GUNGAME and p29.DuelInterface.ClientDuel:Get("IsGunGame") and "WEAPON" or (p29.DuelInterface.ClientDuel:Get("ScoresBehavior") == "Duelers" and "POINTS" or "DMG");
end;

function u1._Init(u30) -- Line: 249
    u30.PlayersFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 250
        -- upvalues: u30 (copy)
        u30:_UpdateLayout();
        u30:_UpdateFade();
    end);
    u30.PlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 255
        -- upvalues: u30 (copy)
        u30:_UpdateLayout();
    end);
    u30.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 259
        -- upvalues: u30 (copy)
        u30:_UpdateLayout();
    end);
    u30.DuelInterface.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 263
        -- upvalues: u30 (copy)
        u30:_UpdateLayout();
    end);
    u30.PlayersList:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 267
        -- upvalues: u30 (copy)
        u30:_UpdateFade();
    end);
    u30.PlayersList:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() -- Line: 271
        -- upvalues: u30 (copy)
        u30:_UpdateFade();
    end);
    u30.PlayersList:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 275
        -- upvalues: u30 (copy)
        u30:_UpdateFade();
    end);
    u30.DuelInterface.FinalResults.Activated:Connect(function() -- Line: 279
        -- upvalues: u30 (copy)
        u30:Open(nil);
    end);
    u30.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 283
        -- upvalues: u30 (copy)
        u30:Open(nil);
    end);
    u30.ButtonsContainer.ChildAdded:Connect(function() -- Line: 287
        -- upvalues: u30 (copy)
        u30:_UpdateButtonsVisibility();
    end);
    u30.ButtonsContainer.ChildRemoved:Connect(function() -- Line: 291
        -- upvalues: u30 (copy)
        u30:_UpdateButtonsVisibility();
    end);
    u30:_Setup();
    u30:_UpdateLayout();
    u30:_UpdateButtonsVisibility();
end;

return u1;