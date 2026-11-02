-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.EmoteController = p2;
    v3._emotes_order = {};
    v3:_Init();

    return v3;
end;

function u1._GetDistance(p4, p5) -- Line: 35
    local Position = workspace.CurrentCamera.CFrame.Position;
    local v6 = p5.Entity and p5.Entity.RootPart and p5.Entity.RootPart.Position;

    if v6 then
        return (Position - v6).Magnitude;
    end;

    return nil;
end;

function u1._IsValidFighter(p7, p8) -- Line: 46
    -- upvalues: SpectateController (copy)
    local v9;

    if SpectateController.CurrentSubject then
        v9 = SpectateController.CurrentSubject:Get("EnvironmentID");
    elseif SpectateController.CurrentDuelSubject then
        v9 = SpectateController.CurrentDuelSubject:Get("EnvironmentID");
    else
        v9 = nil;
    end;

    if v9 ~= p8:Get("EnvironmentID") then
        return false;
    end;

    local v10 = p7:_GetDistance(p8);

    return v10 and v10 <= 128 and true or false;
end;

function u1._VerifyEmotesOrder(u11) -- Line: 65
    -- upvalues: FighterController (copy), CosmeticLibrary (copy)
    local v12 = {};

    for i = #u11._emotes_order, 1, -1 do
        local v13 = u11._emotes_order[i];
        v12[v13.ClientFighter] = true;
        local v14;

        if v13.Emote:IsDestroyed() or not u11:_IsValidFighter(v13.ClientFighter) then
            v13.Emote:HideSounds(false);
            table.remove(u11._emotes_order, i);
            v14 = i;
        else
            v14 = i;
        end;
    end;

    for _, v in pairs(FighterController.Objects) do
        if not v12[v] then
            local v15 = v.Entity and v.Entity:IsEmoting() and v.Entity:GetCurrentEmote();

            if v15 and (CosmeticLibrary.Cosmetics[v15.Name].IsAudioIntrusive and u11:_IsValidFighter(v)) then
                table.insert(u11._emotes_order, {
                    Emote = v15,
                    ClientFighter = v
                });
            end;
        end;
    end;

    table.clear(v12);
    table.sort(u11._emotes_order, function(p16, p17) -- Line: 100
        -- upvalues: u11 (copy)
        return u11:_GetDistance(p16.ClientFighter) < u11:_GetDistance(p17.ClientFighter);
    end);
end;

function u1._Check(p18) -- Line: 105
    -- upvalues: SpectateController (copy), CosmeticLibrary (copy)
    p18:_VerifyEmotesOrder();
    local v19 = SpectateController:IsSubjectEmoting() and CosmeticLibrary.Cosmetics[SpectateController.CurrentSubject.Entity:GetCurrentEmote().Name].IsAudioIntrusive;

    for i, v in pairs(p18._emotes_order) do
        if v19 then
            v.Emote:HideSounds(v.ClientFighter ~= SpectateController.CurrentSubject);
        else
            v.Emote:HideSounds(i > 1);
        end;
    end;
end;

function u1._CheckLoop(p20) -- Line: 121
    while true do
        p20:_Check();
        wait(1);
    end;
end;

function u1._FighterAdded(u21, p22, u23) -- Line: 128
    local function entity_added(p24) -- Line: 129
        -- upvalues: u21 (copy), u23 (copy)
        p24.EmoteStatusChanged:Connect(function() -- Line: 130
            -- upvalues: u21 (ref)
            u21:_Check();
        end);

        if not u23 then
            u21:_Check();
        end;
    end;

    p22.EntityAdded:Connect(entity_added);

    if p22.Entity then
        task.spawn(entity_added, p22.Entity);
    end;

    if not u23 then
        u21:_Check();
    end;
end;

function u1._Init(u25) -- Line: 150
    -- upvalues: SpectateController (copy), FighterController (copy)
    SpectateController.SubjectEmoteStatusChanged:Connect(function() -- Line: 151
        -- upvalues: u25 (copy)
        u25:_Check();
    end);
    FighterController.ObjectAdded:Connect(function(p26) -- Line: 155
        -- upvalues: u25 (copy)
        u25:_FighterAdded(p26);
    end);

    for _, v in pairs(FighterController.Objects) do
        task.spawn(u25._FighterAdded, u25, v, true);
    end;

    task.defer(u25._CheckLoop, u25);
end;

return u1;