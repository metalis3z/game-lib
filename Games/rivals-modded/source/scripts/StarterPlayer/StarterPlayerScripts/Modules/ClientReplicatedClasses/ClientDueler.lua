-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local HeadHoncho = require(script:WaitForChild("HeadHoncho"));
local TeammateLabel = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TeammateLabel");
local DefaultDueler = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("DefaultDueler");
local IS_MATCHMAKING_SERVER = CONSTANTS.IS_MATCHMAKING_SERVER;
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 22
    -- upvalues: ReplicatedClass (copy), u1 (copy), Signal (copy), HeadHoncho (copy)
    local v5 = ReplicatedClass.new(p2);
    local v6 = setmetatable(v5, u1);
    v6.Died = Signal.new();
    v6.EntityAdded = Signal.new();
    v6.HealthChanged = Signal.new();
    v6.Eliminated = Signal.new();
    v6.ItemAdded = Signal.new();
    v6.ItemRemoved = Signal.new();
    local Player = p2.Player;

    if not Player then
        if p3 then
            Player = p3.Player;
        else
            Player = p3;
        end;
    end;

    v6.Player = Player;
    v6.ClientFighter = p3;
    v6.ClientDuel = p4;
    v6.IsLocalPlayer = v6.ClientFighter.IsLocalPlayer;
    v6.HeadHoncho = HeadHoncho.new(v6);
    v6._destroyed = false;
    v6._connections = {};
    v6._is_ally = false;
    v6._ally_highlight = nil;
    v6._ally_label = nil;
    v6._preloaded_character_model = nil;
    v6._is_preloading_character_model = false;
    v6._recorded_viewmodel_details = {};
    v6._viewmodel_detail_check = {};
    v6:_Init();

    return v6;
end;

function u1.IsAlive(p7) -- Line: 57
    local v8 = p7.ClientFighter and p7.ClientFighter:IsAlive();

    return v8;
end;

function u1.IsRendered(p9) -- Line: 61
    return p9.ClientDuel:IsRendered();
end;

function u1.CanShowRankToLocalPlayer(p10) -- Line: 65
    -- upvalues: IS_MATCHMAKING_SERVER (copy)
    local v11 = not IS_MATCHMAKING_SERVER or (p10.IsLocalPlayer or not p10.ClientDuel.LocalDueler) or p10.ClientDuel.LocalDueler:Get("TeamID") and p10.ClientDuel.LocalDueler:Get("TeamID") == p10:Get("TeamID");

    return v11;
end;

function u1.GetHealth(p12) -- Line: 69
    return p12.ClientFighter and p12.ClientFighter:GetHealth() or 0;
end;

function u1.GetMaxHealth(p13) -- Line: 73
    return p13.ClientFighter and p13.ClientFighter:GetMaxHealth() or 100;
end;

function u1.GetCharacterModel(p14) -- Line: 77
    -- upvalues: DefaultDueler (copy)
    return (p14._preloaded_character_model or DefaultDueler):Clone();
end;

function u1.GetCharacterModelForCutscene(p15) -- Line: 81
    -- upvalues: DefaultDueler (copy)
    local v16 = (p15._preloaded_character_model or DefaultDueler):Clone();

    for _, descendant in pairs(v16:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
        end;
    end;

    if v16:FindFirstChild("HumanoidRootPart") then
        v16.HumanoidRootPart.Anchored = true;
    end;

    return v16;
end;

function u1.GetRandomPlayedViewModelDetails(p17, p18) -- Line: 103
    -- upvalues: Utility (copy)
    table.sort(p17._recorded_viewmodel_details, function(p19, p20) -- Line: 104
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p19.ViewModelName, p20.ViewModelName);
    end);
    local v21;

    if #p17._recorded_viewmodel_details > 0 then
        v21 = p17._recorded_viewmodel_details[(p18 or Random.new()):NextInteger(1, #p17._recorded_viewmodel_details)];
    else
        v21 = false;
    end;

    return v21;
end;

function u1.GetStaggeredSpawnsTurn(p22) -- Line: 111
    return table.find(p22.ClientDuel:Get("StaggeredSpawnsOrder") and (p22.ClientDuel:Get("StaggeredSpawnsOrder")[p22:Get("TeamID")] or {}) or {}, p22.Player.UserId);
end;

function u1.SetAlly(p23, p24) -- Line: 115
    p23._is_ally = p24;
    p23:_UpdateAllyVisuals();
end;

function u1.ReplicateFromServer(p25, p26, ...) -- Line: 120
    -- upvalues: ReplicatedClass (copy)
    if p26 == "EliminationFeed" then
        if not p25:IsRendered() then
            return;
        end;

        p25.ClientDuel.DuelInterface.EliminationFeed:Play(p25.Player, ...);

        return;
    end;

    if p26 ~= "SummaryDetails" then
        ReplicatedClass.ReplicateFromServer(p25, p26, ...);

        return;
    end;

    if not p25.IsLocalPlayer then
        return;
    end;

    p25.ClientDuel.DuelInterface.FinalResults.Summary:SetDetails(...);
end;

function u1.Destroy(p27) -- Line: 138
    -- upvalues: ReplicatedClass (copy)
    p27._destroyed = true;

    for _, v in pairs(p27._connections) do
        v:Disconnect();
    end;

    if p27._ally_highlight then
        p27._ally_highlight:Destroy();
    end;

    if p27._ally_label then
        p27._ally_label:Destroy();
    end;

    p27.HeadHoncho:Destroy();
    p27.Died:Destroy();
    p27.EntityAdded:Destroy();
    p27.HealthChanged:Destroy();
    p27.Eliminated:Destroy();
    p27.ItemAdded:Destroy();
    p27.ItemRemoved:Destroy();

    if p27._preloaded_character_model then
        p27._preloaded_character_model:Destroy();
        p27._preloaded_character_model = nil;
    end;

    if p27.ClientFighter then
        p27.ClientFighter:ClearInterface();

        if p27.ClientFighter.Entity then
            p27.ClientFighter.Entity:SetTranslucent(false);
        end;
    end;

    ReplicatedClass.Destroy(p27);
end;

function u1._UpdateTranslucence(p28) -- Line: 182
    if p28.IsLocalPlayer or not (p28.ClientFighter and (p28.ClientFighter.Entity and p28.ClientDuel:Get("IsSpectating"))) then
        return;
    end;

    p28.ClientFighter.Entity:SetTranslucent(p28.ClientDuel:Get("Status") == "RoundStarting");
end;

function u1._RecordEquippedViewModelDetails(p29) -- Line: 190
    -- upvalues: ItemLibrary (copy)
    if not (p29.ClientFighter and (p29.ClientFighter.EquippedItem and not p29._viewmodel_detail_check[p29.ClientFighter.EquippedItem:Get("ObjectID")])) then
        return;
    end;

    p29._viewmodel_detail_check[p29.ClientFighter.EquippedItem:Get("ObjectID")] = true;
    local ViewModelDetails = p29.ClientFighter.EquippedItem:GetViewModelDetails();

    if not ViewModelDetails or ItemLibrary.THIRD_PERSON_VIEWMODEL_BLACKLIST[ViewModelDetails.ViewModelName] then
        return;
    end;

    table.insert(p29._recorded_viewmodel_details, ViewModelDetails);
end;

function u1._PreloadCharacterModel(p30) -- Line: 206
    -- upvalues: Players (copy)
    if p30._is_preloading_character_model or not p30.ClientDuel:Get("IsSpectating") then
        return;
    end;

    p30._is_preloading_character_model = true;

    for i = 1, 3 do
        wait(1);

        if p30._destroyed then
            return;
        end;

        local success, result = pcall(Players.GetHumanoidDescriptionFromUserIdAsync, Players, p30.Player.UserId);
        local v31;

        if success then
            if p30._destroyed then
                return;
            end;

            result.Torso = 15365012259;
            result.LeftArm = 15365010034;
            result.RightArm = 15365012263;
            result.LeftLeg = 15365010038;
            result.RightLeg = 15365010030;
            local success2, result2 = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, result, Enum.HumanoidRigType.R15);

            if success2 then
                if p30._destroyed then
                    result2:Destroy();

                    return;
                end;

                p30._preloaded_character_model = result2;
                v31 = i;
            else
                warn("Failed to create humanoid model:", result2);
                v31 = i;
            end;
        else
            warn("Failed to fetch humanoid description:", result);
            v31 = i;
        end;
    end;
end;

function u1._ClearAllyVisuals(p32) -- Line: 254
    if p32._ally_highlight then
        p32._ally_highlight:Destroy();
        p32._ally_highlight = nil;
    end;

    if p32._ally_label then
        p32._ally_label:Destroy();
        p32._ally_label = nil;
    end;
end;

function u1._UpdateAllyVisuals(p33) -- Line: 266
    -- upvalues: PlayerDataController (copy), DuelLibrary (copy), TeammateLabel (copy), CONSTANTS (copy)
    p33:_ClearAllyVisuals();

    if p33.ClientDuel.LocalDueler and not (p33._is_ally and p33:IsAlive()) then
        return;
    end;

    if p33.ClientFighter and (p33.ClientFighter:Get("IsSpectating") or p33.ClientFighter:Get("IsHiddenByEmotes")) or PlayerDataController:GetSetting("Hide Teammate Icons") then
        return;
    end;

    local TeamColor = DuelLibrary:GetTeamColor(p33.ClientFighter:Get("TeamID"));
    local v34 = p33.ClientFighter.Entity and (p33.ClientFighter.Entity:GetHealth() / p33.ClientFighter.Entity:GetMaxHealth() or 0) or 0;
    local v35 = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(255, 215, 0):Lerp(Color3.fromRGB(100, 255, 50), v34), v34);
    local Color3_new_ret = Color3.new(v35.R / 2, v35.G / 2, v35.B / 2);
    p33._ally_label = TeammateLabel:Clone();
    p33._ally_label.Player.BackgroundColor3 = TeamColor;
    p33._ally_label.Player.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p33.ClientFighter.Player.UserId);
    p33._ally_label.Health.Bar.Visible = v34 > 0;
    p33._ally_label.Health.Bar.Size = UDim2.new(v34, 0, 1, 0);
    p33._ally_label.Health.BackgroundColor3 = Color3_new_ret;
    p33._ally_label.Health.UIStroke.Color = Color3.new(v35.R * 0.25, v35.G * 0.25, v35.B * 0.25);
    p33._ally_label.Health.Bar.BackgroundColor3 = v35;
    p33._ally_label.Health.Bar.UIStroke.Color = v35;
    p33._ally_label.Parent = p33.ClientFighter and (p33.ClientFighter.Entity and p33.ClientFighter.Entity.RootPart) or nil;
end;

function u1._Setup(u36) -- Line: 302
    u36:_RecordEquippedViewModelDetails();
    u36:_UpdateAllyVisuals();

    if not u36.ClientFighter then
        return;
    end;

    table.insert(u36._connections, u36.ClientFighter.Died:Connect(function(...) -- Line: 310
        -- upvalues: u36 (copy)
        u36.Died:Fire(...);
    end));
    table.insert(u36._connections, u36.ClientFighter.EntityAdded:Connect(function(...) -- Line: 314
        -- upvalues: u36 (copy)
        u36.EntityAdded:Fire(...);
    end));
    table.insert(u36._connections, u36.ClientFighter.HealthChanged:Connect(function(...) -- Line: 318
        -- upvalues: u36 (copy)
        u36.HealthChanged:Fire(...);
    end));
    table.insert(u36._connections, u36.ClientFighter.Eliminated:Connect(function(...) -- Line: 322
        -- upvalues: u36 (copy)
        u36.Eliminated:Fire(...);
    end));
    table.insert(u36._connections, u36.ClientFighter.ItemAdded:Connect(function(...) -- Line: 326
        -- upvalues: u36 (copy)
        u36.ItemAdded:Fire(...);
    end));
    table.insert(u36._connections, u36.ClientFighter.ItemRemoved:Connect(function(...) -- Line: 330
        -- upvalues: u36 (copy)
        u36.ItemRemoved:Fire(...);
    end));
    local _connections = u36._connections;
    local DataChangedSignal = u36.ClientFighter:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function(...) -- Line: 334
        -- upvalues: u36 (copy)
        u36:_UpdateAllyVisuals();
    end));
    local _connections2 = u36._connections;
    local DataChangedSignal2 = u36.ClientFighter:GetDataChangedSignal("IsHiddenByEmotes");
    table.insert(_connections2, DataChangedSignal2:Connect(function(...) -- Line: 338
        -- upvalues: u36 (copy)
        u36:_UpdateAllyVisuals();
    end));
    table.insert(u36._connections, u36.ClientFighter.EquippedItemChanged:Connect(function() -- Line: 342
        -- upvalues: u36 (copy)
        u36:_RecordEquippedViewModelDetails();
    end));
end;

function u1._Init(u37) -- Line: 347
    -- upvalues: PlayerDataController (copy)
    u37.Died:Connect(function() -- Line: 348
        -- upvalues: u37 (copy)
        u37:_UpdateAllyVisuals();
    end);
    u37.EntityAdded:Connect(function() -- Line: 352
        -- upvalues: u37 (copy)
        u37:SetAlly(u37._is_ally);
    end);
    u37.HealthChanged:Connect(function() -- Line: 356
        -- upvalues: u37 (copy)
        u37:_UpdateAllyVisuals();
        u37:_UpdateTranslucence();
    end);
    local _connections = u37._connections;
    local DataChangedSignal = u37.ClientDuel:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function(...) -- Line: 361
        -- upvalues: u37 (copy)
        u37:_UpdateTranslucence();
        u37:_PreloadCharacterModel();
    end));
    local _connections2 = u37._connections;
    local DataChangedSignal2 = u37.ClientDuel:GetDataChangedSignal("Status");
    table.insert(_connections2, DataChangedSignal2:Connect(function(...) -- Line: 366
        -- upvalues: u37 (copy)
        u37:_UpdateTranslucence();
    end));
    local _connections3 = u37._connections;
    local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal("Hide Teammate Icons");
    table.insert(_connections3, SettingChangedSignal:Connect(function(...) -- Line: 370
        -- upvalues: u37 (copy)
        u37:_UpdateAllyVisuals();
    end));
    u37:_Setup();
    task.spawn(u37._PreloadCharacterModel, u37);
end;

return u1;