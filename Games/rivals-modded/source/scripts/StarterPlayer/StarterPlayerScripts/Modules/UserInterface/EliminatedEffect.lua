-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("TeammateSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local EliminatedCard = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EliminatedCard");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 22
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.VisibilityChanged = Signal.new();
    v2.Frame = UILibrary:GetTo("MainFrame", "EliminatedEffect");
    v2._last_eliminated_card = nil;
    v2:_Init();

    return v2;
end;

function u1.IsVisible(p3) -- Line: 40
    return p3._last_eliminated_card ~= nil;
end;

function u1.Play(p4, p5, p6, p7, p8, p9) -- Line: 44
    -- upvalues: Utility (copy), Players (copy), EliminatedCard (copy), ComplianceController (copy), ItemLibrary (copy), DuelLibrary (copy), WeaponStatusHandler (copy), BetterDebris (copy), DuelController (copy), TeammateSlot (copy)
    if p4._last_eliminated_card then
        p4._last_eliminated_card:Destroy();
    end;

    Utility:CreateSound("rbxassetid://17016581922", 0.75, 1 + 0.1 * math.random(), script, true, 10);
    local v10 = p5 or Players.LocalPlayer;
    local v11 = v10 == Players.LocalPlayer;
    local v12 = typeof(v10) == "Instance";
    local v13;

    if typeof(v10) == "table" then
        v13 = v10;
    else
        v13 = false;
    end;

    local u14 = EliminatedCard:Clone();
    u14.Frame.Container.Clip.Container.Description.Text = "eliminated " .. (v11 and "yourself" or "you") .. (p8 and (" with " .. p8 or "") or "");
    u14.Frame.Container.Clip.Container.Username.Text = (v11 or (not v12 or v10.Name == v10.DisplayName)) and "" or ("@" .. v10.Name or "");
    u14.Frame.Container.Clip.Container.Player.Text = v11 and "You" or (v12 and ComplianceController:GetName(v10) or (v13 and (v13.DisplayName or "???") or "???"));
    u14.Frame.Container.Clip.Container.Player.Position = u14.Frame.Container.Clip.Container.Username.Text == "" and UDim2.new(0.2, 0, 0.35, 0) or UDim2.new(0.2, 0, 0.225, 0);
    u14.Frame.Container.Clip.Container.Weapon.Image = ItemLibrary:GetViewModelImage(p8, p9, true) or "";
    u14.Frame.Container.Clip.Container.Background.ImageColor3 = v12 and DuelLibrary:GetTeamColor(v10:GetAttribute("TeamID")) or DuelLibrary.EMPTY_TEAM_COLOR;
    u14.Frame.Container.Clip.Container.PlayerSlot.FakeEliminator.Image = v13 and v13.Image or "";
    u14.Frame.Container.Weapon.Image = u14.Frame.Container.Clip.Container.Weapon.Image;

    if p8 and ItemLibrary.Items[p8] then
        WeaponStatusHandler:ApplyItemStatusToText(u14.Frame.Container.Clip.Container.Description, ItemLibrary.Items[p8].Status);
    end;

    u14.Parent = p4.Frame;
    BetterDebris:AddItem(u14, 10);
    p4:_SetLastEliminatedCard(u14);

    if v12 then
        local Duel = DuelController:GetDuel(Players.LocalPlayer);
        local v15;

        if Duel then
            v15 = Duel:GetDueler(v10);
        else
            v15 = Duel;
        end;

        if Duel then
            Duel = Duel.IsRanked;
        end;

        local v16;

        if Duel then
            v16 = nil;
        else
            v16 = v10:GetAttribute("StatisticDuelsWinStreak");
        end;

        local v17;

        if Duel then
            v17 = nil;
        else
            v17 = v10:GetAttribute("Level");
        end;

        local Attribute = v10:GetAttribute("DisplayELO");
        local v18 = TeammateSlot.new(v10.UserId, p6, p7, nil, nil, v16, v17);
        v18.SlotFrame.Parent = u14.Frame.Container.Clip.Container.PlayerSlot;

        if Duel and (v15 and v15:CanShowRankToLocalPlayer()) then
            v18:SetDisplayELO(Attribute);
        end;
    end;

    u14.Frame.Container.Size = UDim2.new(0, 0, 1, 0);
    u14.Frame.Container:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 1, true);
    wait(5);
    Utility:RenderstepForLoop(0, 100, 5, function(p19) -- Line: 99
        -- upvalues: u14 (copy)
        u14.GroupTransparency = (p19 / 100) ^ 5;
    end);
    u14:Destroy();

    if p4._last_eliminated_card ~= u14 then
        return;
    end;

    p4:_SetLastEliminatedCard(nil);
end;

function u1._SetLastEliminatedCard(p20, p21) -- Line: 118
    p20._last_eliminated_card = p21;
    p20.VisibilityChanged:Fire();
end;

function u1._HookLocalFighter(u22) -- Line: 123
    -- upvalues: FighterController (copy), ControlsController (copy)
    FighterController:WaitForLocalFighter().EntityAdded:Connect(function() -- Line: 126
        -- upvalues: u22 (copy), ControlsController (ref)
        if u22._last_eliminated_card and ControlsController.CurrentControls == "Touch" then
            u22._last_eliminated_card:Destroy();
            u22:_SetLastEliminatedCard(nil);
        end;
    end);
end;

function u1._Init(p23) -- Line: 134
    task.defer(p23._HookLocalFighter, p23);
end;

return u1._new();