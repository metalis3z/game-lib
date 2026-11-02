-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ELOBar = require(Players.LocalPlayer.PlayerScripts.Modules.ELOBar);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), ELOBar (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Rank");
    v3.ELOBar = ELOBar.new();
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 27
    p4.ELOBar:Update(true);
    p4:_UpdateLayoutOrder();
end;

function u1.Close(p5) -- Line: 32
    p5.ELOBar:Update(false);
    p5:_UpdateLayoutOrder();
end;

function u1._UpdateLayoutOrder(p6) -- Line: 41
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy)
    local v7 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v7 then
        v7 = v7.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    if v7 then
        v7 = v7.CurrentELO ~= nil;
    end;

    p6.Frame.LayoutOrder = v7 and 0 or 20;
end;

function u1._Setup(p8) -- Line: 49
    p8.ELOBar:SetParent(p8.Frame);
end;

function u1._Init(p9) -- Line: 53
    p9:_Setup();
    p9:_UpdateLayoutOrder();
end;

return u1;