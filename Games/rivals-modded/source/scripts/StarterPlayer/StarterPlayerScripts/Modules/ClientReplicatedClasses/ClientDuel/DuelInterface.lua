-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local EliminatedEffect = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.EliminatedEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local Inset = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Inset);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local EliminationFeed = require(script:WaitForChild("EliminationFeed"));
local HardcoreParkour = require(script:WaitForChild("HardcoreParkour"));
local FinalResults = require(script:WaitForChild("FinalResults"));
local RoundResult = require(script:WaitForChild("RoundResult"));
local StoryDialog = require(script:WaitForChild("StoryDialog"));
local MatchPoint = require(script:WaitForChild("MatchPoint"));
local Scoreboard = require(script:WaitForChild("Scoreboard"));
local HeadHoncho = require(script:WaitForChild("HeadHoncho"));
local Buttons = require(script:WaitForChild("Buttons"));
local Scores = require(script:WaitForChild("Scores"));
local Voting = require(script:WaitForChild("Voting"));
local UpNext = require(script:WaitForChild("UpNext"));
local Timer = require(script:WaitForChild("Timer"));
local Blur = require(script:WaitForChild("Blur"));
local DuelInterface = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelInterface");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 31
    -- upvalues: u1 (copy), DuelInterface (copy), FinalResults (copy), Voting (copy), EliminationFeed (copy), Scoreboard (copy), RoundResult (copy), MatchPoint (copy), Scores (copy), Timer (copy), UpNext (copy), HeadHoncho (copy), HardcoreParkour (copy), StoryDialog (copy), Buttons (copy), Blur (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientDuel = p2;
    v3.Frame = DuelInterface:Clone();
    v3.FinalResults = FinalResults.new(v3);
    v3.Voting = Voting.new(v3);
    v3.EliminationFeed = EliminationFeed.new(v3);
    v3.Scoreboard = Scoreboard.new(v3);
    v3.RoundResult = RoundResult.new(v3);
    v3.MatchPoint = MatchPoint.new(v3);
    v3.Scores = Scores.new(v3);
    v3.Timer = Timer.new(v3);
    v3.UpNext = UpNext.new(v3);
    v3.HeadHoncho = HeadHoncho.new(v3);
    v3.HardcoreParkour = HardcoreParkour.new(v3);
    v3.StoryDialog = StoryDialog.new(v3);
    v3.Buttons = Buttons.new(v3);
    v3.Blur = Blur.new(v3);
    v3._destroyed = false;
    v3._connections = {};
    v3._sounds = {};
    v3._client_duelers = {};
    v3:_Init();

    return v3;
end;

function u1.IsActive(p4) -- Line: 65
    return p4.Frame.Visible;
end;

function u1.IsPageOpen(p5) -- Line: 69
    -- upvalues: Pages (copy)
    return Pages.PageSystem.CurrentPage ~= nil;
end;

function u1.GetLoggedClientDuelers(p6, p7) -- Line: 73
    if p6.ClientDuel:Get("ArcadeMode") then
        local v8 = {};

        for i in pairs(p6._client_duelers) do
            if not table.find(p6.ClientDuel.Duelers, i) then
                v8[i] = true;
            end;
        end;

        for i in pairs(v8) do
            p6._client_duelers[i] = nil;
        end;
    end;

    if not p7 then
        return p6._client_duelers;
    end;

    local v9 = {};

    for i in pairs(p6._client_duelers) do
        local v10 = {
            ClientDueler = i
        };
        local v11;

        if p6.ClientDuel:Get("ArcadeMode") then
            if p6.ClientDuel:Get("ScoresBehavior") == "Duelers" then
                v11 = p6.ClientDuel:Get("Scores")[i:Get("DuelerID")] or -1;
            else
                v11 = p6.ClientDuel:Get("ScoresBehavior") == "Teams" and (p6.ClientDuel:Get("Scores")[i:Get("TeamID")] or -1) or false;
            end;
        else
            v11 = -1;
        end;

        v10.Score = v11;
        v10.Damage = i:Get("Damage") or -1;
        v10.DamageTaken = i:Get("DamageTaken") or -1;
        table.insert(v9, v10);
    end;

    table.sort(v9, function(p12, p13) -- Line: 106
        local v14 = p12.Score or -1;
        local v15 = p13.Score or -1;

        if math.abs(v14 - v15) > 0.01 then
            return v15 < v14;
        end;

        local v16 = p12.Damage or -1;
        local v17 = p13.Damage or -1;

        if math.abs(v16 - v17) > 0.01 then
            return v17 < v16;
        end;

        return (p12.DamageTaken or -1) < (p13.DamageTaken or -1);
    end);
    local v18 = {};

    for _, v in pairs(v9) do
        table.insert(v18, v.ClientDueler);
    end;

    return v18;
end;

function u1.CreateSound(p19, ...) -- Line: 136
    -- upvalues: Utility (copy)
    if p19:IsActive() then
        local v20 = Utility:CreateSound(...);
        table.insert(p19._sounds, v20);

        return v20;
    end;
end;

function u1.RawCreateSound(p21, ...) -- Line: 148
    local v22 = p21:CreateSound(...);
    local v23;

    if v22 then
        v23 = table.find(p21._sounds, v22);
    else
        v23 = v22;
    end;

    if v23 then
        table.remove(p21._sounds, v23);
    end;

    return v22;
end;

function u1.Destroy(p24) -- Line: 159
    p24._destroyed = true;

    for _, v in pairs(p24._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p24._sounds) do
        v:Destroy();
    end;

    p24._client_duelers = {};
    p24.EliminationFeed:Destroy();
    p24.HardcoreParkour:Destroy();
    p24.FinalResults:Destroy();
    p24.StoryDialog:Destroy();
    p24.RoundResult:Destroy();
    p24.MatchPoint:Destroy();
    p24.Scoreboard:Destroy();
    p24.HeadHoncho:Destroy();
    p24.Buttons:Destroy();
    p24.Scores:Destroy();
    p24.Voting:Destroy();
    p24.UpNext:Destroy();
    p24.Timer:Destroy();
    p24.Blur:Destroy();
    p24.Frame:Destroy();
end;

function u1._UpdateSpectating(u25) -- Line: 194
    -- upvalues: GuiService (copy), EliminatedEffect (copy), Pages (copy), Inset (copy)
    for _, v in pairs(u25._connections) do
        v:Disconnect();
    end;

    u25._connections = {};
    u25.Frame.Visible = u25.ClientDuel:Get("IsSpectating");
    u25.Blur:Update();
    u25.HardcoreParkour:Update();

    if not u25.Frame.Visible then
        return;
    end;

    table.insert(u25._connections, u25.ClientDuel.DuelerRemoved:Connect(function(p26) -- Line: 209
        -- upvalues: u25 (copy)
        if u25.ClientDuel:Get("ArcadeMode") then
            u25._client_duelers[p26] = nil;
        end;

        u25.Scoreboard:Generate();
    end));
    local _connections = u25._connections;
    local DataChangedSignal = u25.ClientDuel:GetDataChangedSignal("MaxMapBansPerTeam");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 217
        -- upvalues: u25 (copy)
        u25.Voting:Generate();
    end));
    local _connections2 = u25._connections;
    local DataChangedSignal2 = u25.ClientDuel:GetDataChangedSignal("VoteBansRemaining");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 221
        -- upvalues: u25 (copy)
        u25.Voting:Generate();
    end));
    local _connections3 = u25._connections;
    local DataChangedSignal3 = u25.ClientDuel:GetDataChangedSignal("VoteOptions");
    table.insert(_connections3, DataChangedSignal3:Connect(function() -- Line: 225
        -- upvalues: u25 (copy)
        u25.Voting:Generate();
        u25.Timer:UpdateSizeAndPosition();
        u25.Scores:Generate();
    end));
    local _connections4 = u25._connections;
    local DataChangedSignal4 = u25.ClientDuel:GetDataChangedSignal("ScoreNeededToWin");
    table.insert(_connections4, DataChangedSignal4:Connect(function() -- Line: 231
        -- upvalues: u25 (copy)
        u25.Scores:Generate();
    end));
    local _connections5 = u25._connections;
    local DataChangedSignal5 = u25.ClientDuel:GetDataChangedSignal("ScoresBehavior");
    table.insert(_connections5, DataChangedSignal5:Connect(function() -- Line: 235
        -- upvalues: u25 (copy)
        u25.Scores:Generate();
    end));
    local _connections6 = u25._connections;
    local DataChangedSignal6 = u25.ClientDuel:GetDataChangedSignal("Status");
    table.insert(_connections6, DataChangedSignal6:Connect(function() -- Line: 239
        -- upvalues: u25 (copy)
        u25.Buttons:Update();
        u25.Scoreboard:Open();
        u25.HeadHoncho:Update();
        u25.HardcoreParkour:Update();
        u25.StoryDialog:Update();
        u25.UpNext:Update();

        if u25.ClientDuel:Get("ArcadeMode") and u25.ClientDuel:Get("Status") == "GameOver" then
            u25:CreateSound("rbxassetid://99135525400251", 2, 1, script, true, 5);
        end;
    end));
    local _connections7 = u25._connections;
    local DataChangedSignal7 = u25.ClientDuel:GetDataChangedSignal("CanSwitchItems");
    table.insert(_connections7, DataChangedSignal7:Connect(function() -- Line: 253
        -- upvalues: u25 (copy)
        u25.Buttons:Update();
    end));
    local _connections8 = u25._connections;
    local DataChangedSignal8 = u25.ClientDuel:GetDataChangedSignal("RoundNum");
    table.insert(_connections8, DataChangedSignal8:Connect(function() -- Line: 257
        -- upvalues: u25 (copy)
        u25.Buttons:Update();
    end));
    local _connections9 = u25._connections;
    local DataChangedSignal9 = u25.ClientDuel:GetDataChangedSignal("CanTrackStatistics");
    table.insert(_connections9, DataChangedSignal9:Connect(function() -- Line: 261
        -- upvalues: u25 (copy)
        u25.Buttons:Update();
    end));
    local _connections10 = u25._connections;
    local DataChangedSignal10 = u25.ClientDuel:GetDataChangedSignal("RematchCount");
    table.insert(_connections10, DataChangedSignal10:Connect(function() -- Line: 265
        -- upvalues: u25 (copy)
        u25.FinalResults.Buttons:Update();
    end));
    local _connections11 = u25._connections;
    local DataChangedSignal11 = u25.ClientDuel:GetDataChangedSignal("RematchGoal");
    table.insert(_connections11, DataChangedSignal11:Connect(function() -- Line: 269
        -- upvalues: u25 (copy)
        u25.FinalResults.Buttons:Update();
    end));
    local _connections12 = u25._connections;
    local DataChangedSignal12 = u25.ClientDuel:GetDataChangedSignal("RematchAvailable");
    table.insert(_connections12, DataChangedSignal12:Connect(function() -- Line: 273
        -- upvalues: u25 (copy)
        u25.FinalResults.Buttons:Update();
    end));
    local _connections13 = u25._connections;
    local DataChangedSignal13 = u25.ClientDuel:GetDataChangedSignal("RematchSuccess");
    table.insert(_connections13, DataChangedSignal13:Connect(function() -- Line: 277
        -- upvalues: u25 (copy)
        u25.FinalResults.Buttons:Update();
    end));
    local _connections14 = u25._connections;
    local DataChangedSignal14 = u25.ClientDuel:GetDataChangedSignal("StaggeredSpawnsOrder");
    table.insert(_connections14, DataChangedSignal14:Connect(function() -- Line: 281
        -- upvalues: u25 (copy)
        u25.Scoreboard:Generate();
        u25.UpNext:Update();
        u25.Buttons:Update();
    end));
    local _connections15 = u25._connections;
    local DataChangedSignal15 = u25.ClientDuel:GetDataChangedSignal("HideMostDuelInterfaceElements");
    table.insert(_connections15, DataChangedSignal15:Connect(function() -- Line: 287
        -- upvalues: u25 (copy)
        u25.Timer:Update();
        u25.Scores:UpdateVisibility();
    end));
    local _connections16 = u25._connections;
    local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("PreferredTransparency");
    table.insert(_connections16, PropertyChangedSignal:Connect(function() -- Line: 292
        -- upvalues: u25 (copy)
        u25.Scoreboard:UpdatePreferredTransparency();
    end));
    table.insert(u25._connections, EliminatedEffect.VisibilityChanged:Connect(function() -- Line: 296
        -- upvalues: u25 (copy)
        u25.UpNext:Update();
    end));
    table.insert(u25._connections, Pages.PageSystem.PagesActivity:Connect(function() -- Line: 300
        -- upvalues: u25 (copy)
        u25.Buttons:Update();
        u25.Scores:UpdateVisibility();
        u25.EliminationFeed:Update();
        u25.Timer:Update();
        u25.Scoreboard:Open();
        u25.Voting:Generate();
        u25.RoundResult:UpdateVisibility();
        u25.FinalResults:UpdateVisibility();
        u25.HeadHoncho:Update();
        u25.HardcoreParkour:Update();
        u25.StoryDialog:Update();
    end));
    local _connections17 = u25._connections;
    local PropertyChangedSignal2 = Inset.MainFrame:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(_connections17, PropertyChangedSignal2:Connect(function() -- Line: 314
        -- upvalues: u25 (copy)
        u25.EliminationFeed:UpdatePosition();
    end));

    local function map_added(p27, p28) -- Line: 318
        -- upvalues: u25 (copy)
        local _connections18 = u25._connections;
        local DataChangedSignal16 = p27:GetDataChangedSignal("ObbyStartPosition");
        table.insert(_connections18, DataChangedSignal16:Connect(function() -- Line: 319
            -- upvalues: u25 (ref)
            u25.HardcoreParkour:Update();
        end));
        local _connections19 = u25._connections;
        local DataChangedSignal17 = p27:GetDataChangedSignal("ObbyFinishPosition");
        table.insert(_connections19, DataChangedSignal17:Connect(function() -- Line: 323
            -- upvalues: u25 (ref)
            u25.HardcoreParkour:Update();
        end));
        u25.HardcoreParkour:Update();
    end;

    table.insert(u25._connections, u25.ClientDuel.MapAdded:Connect(map_added));

    if u25.ClientDuel.Map then
        task.spawn(map_added, u25.ClientDuel.Map, true);
    end;

    local function dueler_added(u29, p30) -- Line: 336
        -- upvalues: u25 (copy)
        local _connections18 = u25._connections;
        local DataChangedSignal16 = u29:GetDataChangedSignal("LastVote");
        table.insert(_connections18, DataChangedSignal16:Connect(function() -- Line: 337
            -- upvalues: u25 (ref)
            u25.Voting:Generate();
        end));
        local _connections19 = u25._connections;
        local DataChangedSignal17 = u29:GetDataChangedSignal("IsHeadHoncho");
        table.insert(_connections19, DataChangedSignal17:Connect(function() -- Line: 341
            -- upvalues: u25 (ref)
            u25.HeadHoncho:Update();
        end));
        local _connections20 = u25._connections;
        local DataChangedSignal18 = u29:GetDataChangedSignal("Eliminations");
        table.insert(_connections20, DataChangedSignal18:Connect(function() -- Line: 345
            -- upvalues: u25 (ref)
            u25.Scoreboard:Generate();
        end));
        local _connections21 = u25._connections;
        local DataChangedSignal19 = u29:GetDataChangedSignal("Deaths");
        table.insert(_connections21, DataChangedSignal19:Connect(function() -- Line: 349
            -- upvalues: u25 (ref)
            u25.Scoreboard:Generate();
        end));
        local _connections22 = u25._connections;
        local DataChangedSignal20 = u29:GetDataChangedSignal("Assists");
        table.insert(_connections22, DataChangedSignal20:Connect(function() -- Line: 353
            -- upvalues: u25 (ref)
            u25.Scoreboard:Generate();
        end));
        local _connections23 = u25._connections;
        local DataChangedSignal21 = u29:GetDataChangedSignal("Damage");
        table.insert(_connections23, DataChangedSignal21:Connect(function() -- Line: 357
            -- upvalues: u25 (ref)
            u25.Scoreboard:Generate();
        end));
        table.insert(u25._connections, u29.ItemAdded:Connect(function() -- Line: 361
            -- upvalues: u25 (ref)
            u25.Scoreboard:Generate();
        end));
        table.insert(u25._connections, u29.ItemRemoved:Connect(function() -- Line: 365
            -- upvalues: u25 (ref)
            u25.Scoreboard:Generate();
        end));
        table.insert(u25._connections, u29.Died:Connect(function() -- Line: 369
            -- upvalues: u25 (ref), u29 (copy)
            u25.UpNext:Update();

            if u29.IsLocalPlayer then
                u25.Buttons:Update();
            end;
        end));
        table.insert(u25._connections, u29.EntityAdded:Connect(function() -- Line: 377
            -- upvalues: u25 (ref), u29 (copy)
            u25.UpNext:Update();

            if u29.IsLocalPlayer then
                u25.Buttons:Update();
            end;
        end));
        table.insert(u25._connections, u29.HealthChanged:Connect(function() -- Line: 385
            -- upvalues: u25 (ref), u29 (copy)
            u25.Scoreboard:Generate();
            u25.UpNext:Update();

            if u29.IsLocalPlayer then
                u25.Buttons:Update();
            end;
        end));
        local _connections24 = u25._connections;
        local DataChangedSignal22 = u29.ClientFighter:GetDataChangedSignal("ConnectionLevel");
        table.insert(_connections24, DataChangedSignal22:Connect(function() -- Line: 394
            -- upvalues: u25 (ref)
            u25.Scoreboard:Generate();
        end));

        if u29.IsLocalPlayer then
            local _connections25 = u25._connections;
            local DataChangedSignal23 = u29:GetDataChangedSignal("SwitchItemsCount");
            table.insert(_connections25, DataChangedSignal23:Connect(function() -- Line: 399
                -- upvalues: u25 (ref)
                u25.Buttons:Update();
            end));
            local _connections26 = u25._connections;
            local DataChangedSignal24 = u29:GetDataChangedSignal("SwitchItemsMax");
            table.insert(_connections26, DataChangedSignal24:Connect(function() -- Line: 403
                -- upvalues: u25 (ref)
                u25.Buttons:Update();
            end));
            local _connections27 = u25._connections;
            local DataChangedSignal25 = u29:GetDataChangedSignal("TeamID");
            table.insert(_connections27, DataChangedSignal25:Connect(function() -- Line: 407
                -- upvalues: u25 (ref)
                u25.Scores:Generate();
            end));
            local _connections28 = u25._connections;
            local DataChangedSignal26 = u29.ClientFighter:GetDataChangedSignal("CanPickWeapons");
            table.insert(_connections28, DataChangedSignal26:Connect(function() -- Line: 411
                -- upvalues: u25 (ref)
                u25.Buttons:Update();
            end));
            local _connections29 = u25._connections;
            local DataChangedSignal27 = u29.ClientFighter:GetDataChangedSignal("LastPickedWeapons");
            table.insert(_connections29, DataChangedSignal27:Connect(function() -- Line: 415
                -- upvalues: u25 (ref)
                u25.Buttons:Update();
            end));
            table.insert(u25._connections, u29.ClientFighter.InvincibilityChanged:Connect(function() -- Line: 419
                -- upvalues: u25 (ref)
                u25.Buttons:Update();
            end));
        end;

        u25._client_duelers[u29] = true;

        if not p30 then
            u25.Buttons:Update();
            u25.Scoreboard:Generate();
            u25.StoryDialog:Update();

            if u29.IsLocalPlayer then
                u25.Scores:Generate();
            end;
        end;
    end;

    table.insert(u25._connections, u25.ClientDuel.DuelerAdded:Connect(dueler_added));

    for _, v in pairs(u25.ClientDuel.Duelers) do
        task.spawn(dueler_added, v, true);
    end;

    u25.Buttons:Update();
    u25.Scores:UpdateVisibility();
    u25.Scores:Generate();
    u25.Voting:Generate();
    u25.Timer:UpdateSizeAndPosition();
    u25.Timer:Update();
    u25.Scoreboard:Generate();
    u25.Scoreboard:UpdatePreferredTransparency();
    u25.Scoreboard:Open(false);
    u25.EliminationFeed:Update();
    u25.RoundResult:UpdateVisibility();
    u25.FinalResults:UpdateVisibility();
    u25.UpNext:Update();
    u25.HeadHoncho:Update();
    u25.HardcoreParkour:Update();
    u25.StoryDialog:Update();
end;

function u1._Setup(p31) -- Line: 468
    -- upvalues: UILibrary (copy)
    p31.Frame.Visible = false;
    p31.Frame.Parent = UILibrary:GetTo("MainFrame", "DuelInterfaces");
end;

function u1._Init(u32) -- Line: 473
    u32.ClientDuel:GetDataChangedSignal("IsSpectating"):Connect(function() -- Line: 474
        -- upvalues: u32 (copy)
        u32:_UpdateSpectating();
    end);
    u32:_Setup();
    task.spawn(u32._UpdateSpectating, u32);
end;

return u1;