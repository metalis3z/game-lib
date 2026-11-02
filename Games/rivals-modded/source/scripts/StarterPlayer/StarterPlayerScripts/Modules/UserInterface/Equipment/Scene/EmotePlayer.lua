-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local Emotes = ReplicatedStorage.Modules.Emotes;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 12
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Scene = p2;
    v3._playing_hash = 0;
    v3._last_rig = nil;
    v3._last_emote = nil;
    v3:_Init();

    return v3;
end;

function u1.OnCustomizingStateChanged(p4) -- Line: 30
    task.defer(p4._StartPlaying, p4);
end;

function u1.OnStateChanged(p5) -- Line: 34
    task.defer(p5._StartPlaying, p5);
end;

function u1._StartPlaying(p6) -- Line: 42
    -- upvalues: CosmeticLibrary (copy), FighterController (copy), Players (copy), Emotes (copy)
    p6._playing_hash = p6._playing_hash + 1;
    local _playing_hash = p6._playing_hash;

    if p6._last_rig then
        p6._last_rig:Destroy();
        p6._last_rig = nil;
    end;

    if p6._last_emote then
        p6._last_emote:Destroy();
        p6._last_emote = nil;
    end;

    local SelectedCosmetic = p6.Scene.Equipment:GetSelectedCosmetic();
    local CustomizingType = p6.Scene.Equipment:GetCustomizingType();
    local v7 = CosmeticLibrary.Cosmetics[SelectedCosmetic];

    if CustomizingType ~= "Emote" or not v7 then
        return;
    end;

    while true do
        p6._last_rig = FighterController:GenerateCharacterModel(Players.LocalPlayer.UserId).Template:Clone();
        p6._last_rig:PivotTo(p6.Scene:GetHumanoidCFrame() * v7.ViewportCFrameOffset);
        p6._last_rig.HumanoidRootPart.Anchored = true;
        p6._last_rig.Humanoid:SetAttribute("SimulateMoving", true);
        p6._last_rig.Parent = p6.Scene.Model;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://507766388";
        local success, result = pcall(p6._last_rig.Humanoid.LoadAnimation, p6._last_rig.Humanoid, Animation);

        if success then
            result:Play(0);
        end;

        p6._last_emote = require(Emotes[SelectedCosmetic]).new(p6._last_rig.Humanoid);
        task.defer(p6._last_emote.Simulate, p6._last_emote);
        p6._last_emote.Destroying:Wait();

        if p6._playing_hash ~= _playing_hash then
            return;
        end;

        if p6._last_rig then
            p6._last_rig:Destroy();
            p6._last_rig = nil;
        end;

        if p6._last_emote then
            p6._last_emote:Destroy();
            p6._last_emote = nil;
        end;
    end;
end;

function u1._Init(p8) -- Line: 100
end;

return u1;