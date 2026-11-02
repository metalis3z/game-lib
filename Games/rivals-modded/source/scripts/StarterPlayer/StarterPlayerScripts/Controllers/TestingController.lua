-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local TestLibrary = require(ReplicatedStorage.Modules.TestLibrary);
local ShootingRangeController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController);
local TestAttribute = TestLibrary:GetTestAttribute("StudioFinisherTest");
local TestAttribute2 = TestLibrary:GetTestAttribute("StudioSkinTest");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 15
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1._SetupFinisherTest(p3) -- Line: 33
    -- upvalues: TestAttribute (copy), Players (copy), ShootingRangeController (copy)
    if not TestAttribute then
        return;
    end;

    if not Players.LocalPlayer.Character then
        Players.LocalPlayer.CharacterAdded:Wait();
    end;

    ShootingRangeController:Enter("Sniper");
end;

function u1._SetupSkinTest(p4) -- Line: 45
    -- upvalues: TestAttribute2 (copy), Players (copy), ShootingRangeController (copy), CosmeticLibrary (copy)
    if not TestAttribute2 then
        return;
    end;

    if not Players.LocalPlayer.Character then
        Players.LocalPlayer.CharacterAdded:Wait();
    end;

    ShootingRangeController:Enter(CosmeticLibrary.Cosmetics[TestAttribute2] and CosmeticLibrary.Cosmetics[TestAttribute2].ItemName or TestAttribute2);
end;

function u1._Init(p5) -- Line: 57
    task.defer(p5._SetupSkinTest, p5);
    task.defer(p5._SetupFinisherTest, p5);
end;

return u1._new();