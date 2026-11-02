-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.Updated = Signal.new();
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Buttons");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.ContentsFrame = v3.Container:WaitForChild("Contents");
    v3.SwitchItemsFrame = v3.ContentsFrame:WaitForChild("SwitchItems");
    v3.SwitchItemsButton = v3.SwitchItemsFrame:WaitForChild("Button");
    v3.SwitchItemsTitle = v3.SwitchItemsButton:WaitForChild("Title");
    v3.SwitchItemsRemaining = v3.SwitchItemsButton:WaitForChild("Remaining");
    v3.SwitchItemsBackgroundOn = v3.SwitchItemsButton:WaitForChild("BackgroundOn");
    v3.SwitchItemsBackgroundOff = v3.SwitchItemsButton:WaitForChild("BackgroundOff");
    v3.SwitchItemsLastPickedFrame = v3.SwitchItemsButton:WaitForChild("LastPickedWeapons");
    v3.LeaveDuelFrame = v3.ContentsFrame:WaitForChild("LeaveDuel");
    v3.LeaveDuelButton = v3.LeaveDuelFrame:WaitForChild("Button");
    v3.RespawnNowFrame = v3.ContentsFrame:WaitForChild("RespawnNow");
    v3.RespawnNowButton = v3.RespawnNowFrame:WaitForChild("Button");
    v3.RespawnNowVisualsFrame = v3.RespawnNowButton:WaitForChild("Visuals");
    v3.RespawnNowBar = v3.RespawnNowVisualsFrame:WaitForChild("Bar"):WaitForChild("Bar");
    v3.RespawnInputsFrame = v3.RespawnNowVisualsFrame:WaitForChild("Inputs");
    v3.RespawnVisualsTitle = v3.RespawnNowVisualsFrame:WaitForChild("Title");
    v3.RespawnNowWaitingFrame = v3.RespawnNowButton:WaitForChild("Waiting");
    v3.RespawnNowWaitingDotsFrame = v3.RespawnNowWaitingFrame:WaitForChild("Dots");
    v3.SwitchTeamFrame = v3.ContentsFrame:WaitForChild("SwitchTeam");
    v3.SwitchTeamButton = v3.SwitchTeamFrame:WaitForChild("Button");
    v3.SwitchTeamText = v3.SwitchTeamButton:WaitForChild("Team");
    v3.SwitchTeamBackground = v3.SwitchTeamButton:WaitForChild("Background");
    v3._destroyed = false;
    v3._respawn_now_animation_hash = 0;
    v3._respawn_now_visible_until = 0;
    v3._respawn_now_is_timer_only = false;
    v3._last_picked_weapon_images = {};
    v3:_Init();

    return v3;
end;

function u1.IsLeaveDuelVisible(p4) -- Line: 63
    return p4.LeaveDuelFrame.Visible;
end;

function u1.IsSwitchItemsVisible(p5) -- Line: 67
    return p5.SwitchItemsFrame.Visible;
end;

function u1.IsRespawnNowVisible(p6) -- Line: 71
    return p6.RespawnNowFrame.Visible;
end;

function u1.IsSwitchTeamVisible(p7) -- Line: 75
    return p7.SwitchTeamFrame.Visible;
end;

function u1.IsAnythingVisible(p8) -- Line: 79
    return p8:IsLeaveDuelVisible() or p8:IsSwitchItemsVisible() or (p8:IsRespawnNowVisible() or p8:IsSwitchTeamVisible());
end;

function u1.SwitchItemsRequest(p9) -- Line: 83
    -- upvalues: Pages (copy), ReplicatedStorage (copy)
    if p9.DuelInterface.ClientDuel.LocalDueler and p9.DuelInterface.ClientDuel.LocalDueler:GetStaggeredSpawnsTurn() then
        Pages:OpenPickWeaponsPage();

        return;
    end;

    ReplicatedStorage.Remotes.Duels.SwitchItems:FireServer();
end;

function u1.RespawnNowRequest(p10) -- Line: 91
    -- upvalues: ReplicatedStorage (copy)
    if p10._respawn_now_is_timer_only then
        return;
    end;

    p10.RespawnNowWaitingFrame.Visible = true;
    p10.RespawnNowVisualsFrame.Visible = false;
    ReplicatedStorage.Remotes.Duels.RespawnNow:FireServer();
end;

function u1.RespawnNowAnimation(u11, p12) -- Line: 102
    local v13 = u11.DuelInterface.ClientDuel:Get("RespawnDelay") or 0;
    u11._respawn_now_visible_until = tick() + v13;
    u11._respawn_now_is_timer_only = p12;
    u11._respawn_now_animation_hash = u11._respawn_now_animation_hash + 1;
    local _respawn_now_animation_hash = u11._respawn_now_animation_hash;
    u11.RespawnInputsFrame.Visible = not u11._respawn_now_is_timer_only;
    u11.RespawnVisualsTitle.Text = u11._respawn_now_is_timer_only and "Respawning" or "Respawn";
    u11.RespawnVisualsTitle.Size = u11._respawn_now_is_timer_only and UDim2.new(0.9, 0, 0.5, 0) or UDim2.new(0.9, 0, 0.575, 0);
    u11.RespawnNowWaitingFrame.Visible = false;
    u11.RespawnNowVisualsFrame.Visible = true;
    u11.RespawnNowBar.Size = UDim2.new(0, 0, 1, 0);
    u11.RespawnNowBar:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", v13, true, function() -- Line: 117
        -- upvalues: _respawn_now_animation_hash (copy), u11 (copy)
        wait(1);

        if _respawn_now_animation_hash ~= u11._respawn_now_animation_hash then
            return;
        end;

        u11.RespawnNowBar.Size = UDim2.new(0, 0, 1, 0);
    end);
    u11:Update();
end;

function u1.Update(p14) -- Line: 130
    -- upvalues: GameplayUtility (copy), PlayerDataController (copy), ItemLibrary (copy), DuelLibrary (copy)
    for _, v in pairs(p14._last_picked_weapon_images) do
        v:Destroy();
    end;

    p14._last_picked_weapon_images = {};
    local Visible = p14.LeaveDuelFrame.Visible;
    local Visible2 = p14.SwitchItemsFrame.Visible;
    local Visible3 = p14.SwitchItemsBackgroundOn.Visible;
    local Visible4 = p14.SwitchItemsBackgroundOff.Visible;
    local Visible5 = p14.RespawnNowFrame.Visible;
    local Visible6 = p14.SwitchTeamFrame.Visible;
    local v15 = p14.DuelInterface.ClientDuel.LocalDueler and not p14.DuelInterface:IsPageOpen() and not p14.DuelInterface.Voting:IsOpen();
    local v16 = p14.DuelInterface.ClientDuel.LocalDueler and p14.DuelInterface.ClientDuel.LocalDueler.ClientFighter and p14.DuelInterface.ClientDuel.LocalDueler.ClientFighter:IsAlive();
    local v17 = not v16 or p14.DuelInterface.ClientDuel:Get("WasSelfQueued") or p14.DuelInterface.ClientDuel:Get("IsCurrentArcadeDuel") and p14.DuelInterface.Scoreboard:IsOpen();
    local v18 = v15 and (v17 and p14.DuelInterface.ClientDuel:CanLeave());

    if v18 then
        if p14.DuelInterface.ClientDuel:Get("Status") == "GameOver" then
            v18 = false;
        else
            v18 = p14.DuelInterface.Scoreboard:IsOpen();
        end;
    end;

    p14.LeaveDuelFrame.Visible = v18;
    local v19 = v15 and not v16 and tick() < p14._respawn_now_visible_until;
    p14.RespawnNowFrame.Visible = v19;
    local v20 = not v15 and 0 or (p14.DuelInterface.ClientDuel.LocalDueler:Get("SwitchItemsMax") or (1 / 0)) - p14.DuelInterface.ClientDuel.LocalDueler:Get("SwitchItemsCount");
    local v21 = p14.DuelInterface.ClientDuel:Get("CanSwitchItems") == "WhileInvincible" and v16 and p14.DuelInterface.ClientDuel.LocalDueler.ClientFighter.Entity:Get("IsInvincible") or p14.DuelInterface.ClientDuel:Get("CanSwitchItems") == true;
    local v22 = v15 and p14.DuelInterface.ClientDuel.LocalDueler and p14.DuelInterface.ClientDuel.LocalDueler:GetStaggeredSpawnsTurn();
    local v23;

    if v15 then
        if v16 and v21 or v22 then
            v23 = not p14.DuelInterface.ClientDuel.LocalDueler.ClientFighter:Get("CanPickWeapons");

            if v23 then
                if p14.DuelInterface.ClientDuel:Get("ArcadeMode") or (p14.DuelInterface.ClientDuel:Get("RoundNum") > 1 or v22) then
                    if p14.DuelInterface.ClientDuel:Get("Status") == "GameOver" then
                        v23 = false;
                    else
                        v23 = GameplayUtility:SwitchingWeaponsMakesSense(p14.DuelInterface.ClientDuel.LocalDueler.ClientFighter, PlayerDataController);
                    end;
                else
                    v23 = v22;
                end;
            end;
        else
            v23 = v22;
        end;
    else
        v23 = v15;
    end;

    local v24 = v20 < (1 / 0) and true or v22;
    p14.SwitchItemsFrame.Visible = v23;
    p14.SwitchItemsTitle.Position = v24 and UDim2.new(0.5, 0, 0.375, 0) or UDim2.new(0.5, 0, 0.5, 0);
    p14.SwitchItemsTitle.Text = v22 and "Pick Weapons" or "Switch Weapons";
    p14.SwitchItemsRemaining.Text = v22 and "before you spawn" or (not v24 and "" or string.format("%s switch%s remaining", v20, v20 == 1 and "" or "es"));
    p14.SwitchItemsBackgroundOn.Visible = v22 or v20 > 0;
    p14.SwitchItemsBackgroundOff.Visible = not p14.SwitchItemsBackgroundOn.Visible;

    if v22 then
        for i, v in pairs(p14.DuelInterface.ClientDuel.LocalDueler.ClientFighter:Get("LastPickedWeapons") or {}) do
            local WeaponData = PlayerDataController:GetWeaponData(v);
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Size = UDim2.new(3, 0, 3, 0);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.LayoutOrder = i;
            ImageLabel.ZIndex = i;
            ImageLabel.Image = WeaponData and ItemLibrary:GetViewModelImageFromWeaponData(WeaponData) or (ItemLibrary:GetViewModelImage(v) or "");
            ImageLabel.Parent = p14.SwitchItemsLastPickedFrame;
            table.insert(p14._last_picked_weapon_images, ImageLabel);
        end;
    end;

    local v25 = p14:_GetNextTeamID();
    local v26 = p14.DuelInterface.ClientDuel.LocalDueler and p14.DuelInterface.ClientDuel:CountTeam(p14.DuelInterface.ClientDuel.LocalDueler:Get("TeamID"));
    local v27;

    if v25 then
        v27 = p14.DuelInterface.ClientDuel:CountTeam(v25);
    else
        v27 = v25;
    end;

    local v28 = v15 and (v23 and (v25 and p14.DuelInterface.ClientDuel:Get("ArcadeMode"))) and (p14.DuelInterface.ClientDuel.LocalDueler and not p14.DuelInterface.ClientDuel.LocalDueler:Get("JustSwitchedTeam")) and p14.DuelInterface.Scoreboard:IsOpen();

    if v28 then
        if v26 then
            if v27 then
                if v26 > 1 then
                    v27 = v27 < v26;
                else
                    v27 = false;
                end;
            end;
        else
            v27 = v26;
        end;
    else
        v27 = v28;
    end;

    p14.SwitchTeamFrame.Visible = v28;
    p14.SwitchTeamText.Text = not v25 and "" or "to " .. DuelLibrary.TeamsByID[v25].TeamName;
    p14.SwitchTeamBackground.ImageColor3 = v27 and DuelLibrary:GetTeamColor(v25) or DuelLibrary.EMPTY_TEAM_COLOR;

    if (p14.LeaveDuelFrame.Visible ~= Visible or (p14.SwitchItemsFrame.Visible ~= Visible2 or (p14.SwitchItemsBackgroundOn.Visible ~= Visible3 or (p14.SwitchItemsBackgroundOff.Visible ~= Visible4 or p14.RespawnNowFrame.Visible ~= Visible5)))) and true or p14.SwitchTeamFrame.Visible ~= Visible6 then
        p14.Updated:Fire();
    end;
end;

function u1.Destroy(p29) -- Line: 240
    p29._destroyed = true;
    p29.Updated:Destroy();
end;

function u1._GetNextTeamID(p30) -- Line: 249
    -- upvalues: DuelLibrary (copy)
    local v31 = p30.DuelInterface.ClientDuel.LocalDueler and p30.DuelInterface.ClientDuel.LocalDueler:Get("TeamID");
    local v32 = p30.DuelInterface.ClientDuel:Get("NumTeams");

    if v31 and (v32 and v32 > 1) then
        return DuelLibrary.Teams[DuelLibrary.TeamsByID[v31].TeamIndex % v32 + 1].TeamID;
    end;
end;

function u1._UpdateRespawnNowDots(p33) -- Line: 260
    if p33.RespawnNowWaitingFrame.Visible then
        p33.RespawnNowWaitingDotsFrame:AddTag("UILoadingDots");

        return;
    end;

    p33.RespawnNowWaitingDotsFrame:RemoveTag("UILoadingDots");
end;

function u1._UpdateVisibility(p34) -- Line: 268
    p34.Frame.Visible = not p34.DuelInterface.FinalResults:IsActive();
end;

function u1._UpdateParent(u35) -- Line: 272
    if u35._destroyed then
        return;
    end;

    pcall(function() -- Line: 277
        -- upvalues: u35 (copy)
        u35.ContentsFrame.Parent = u35.DuelInterface.Scoreboard:IsOpen() and u35.DuelInterface.Scoreboard.ButtonsContainer or u35.Container;
    end);
end;

function u1._Init(u36) -- Line: 282
    -- upvalues: ReplicatedStorage (copy), Utility (copy), ButtonEffect (copy)
    u36.SwitchItemsButton.MouseButton1Click:Connect(function() -- Line: 283
        -- upvalues: u36 (copy)
        u36:SwitchItemsRequest();
    end);
    u36.RespawnNowButton.MouseButton1Click:Connect(function() -- Line: 287
        -- upvalues: u36 (copy)
        u36:RespawnNowRequest();
    end);
    u36.LeaveDuelButton.MouseButton1Click:Connect(function() -- Line: 291
        -- upvalues: u36 (copy)
        u36.DuelInterface.ClientDuel:LeaveDuelRequest();
    end);
    u36.SwitchTeamButton.MouseButton1Click:Connect(function() -- Line: 295
        -- upvalues: ReplicatedStorage (ref), u36 (copy), Utility (ref)
        if not ReplicatedStorage.Remotes.Duels.SwitchTeam:InvokeServer(u36:_GetNextTeamID()) then
            Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
        end;
    end);
    u36.DuelInterface.FinalResults.Activated:Connect(function() -- Line: 303
        -- upvalues: u36 (copy)
        u36:_UpdateVisibility();
    end);
    u36.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 307
        -- upvalues: u36 (copy)
        u36:Update();
        u36:_UpdateParent();
    end);
    u36.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 312
        -- upvalues: u36 (copy)
        u36:Update();
    end);
    u36.RespawnNowWaitingFrame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 316
        -- upvalues: u36 (copy)
        u36:_UpdateRespawnNowDots();
    end);
    u36:_UpdateVisibility();
    task.defer(u36._UpdateParent, u36);
    ButtonEffect:Add(u36.LeaveDuelButton);
    ButtonEffect:Add(u36.RespawnNowButton);
    ButtonEffect:Add(u36.SwitchItemsButton);
    ButtonEffect:Add(u36.SwitchTeamButton);
end;

return u1;