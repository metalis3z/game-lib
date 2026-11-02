-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._last_footstep = 0;
    v3._falling_start = nil;
    v3._falling_sound = nil;
    v3._footsteps_disabled = 0;
    v3:_Init();

    return v3;
end;

function u1.DisableFootsteps(p4, p5) -- Line: 27
    p4._footsteps_disabled = tick() + p5;
end;

function u1.Update(p6, p7, p8) -- Line: 31
    p6:_UpdateFalling(p7, p8);
    p6:_UpdateFootstep(p7, p8);
end;

function u1.Destroy(p9) -- Line: 36
    p9:_ClearFallingSound();
end;

function u1._ClearFallingSound(p10) -- Line: 44
    if p10._falling_sound then
        p10._falling_sound:Destroy();
        p10._falling_sound = nil;
    end;
end;

function u1._UpdateFalling(p11, p12, p13) -- Line: 51
    local v14 = p13.IsGrounded or p13.IsHiddenByCutscene;

    if v14 or p11._falling_start then
        if v14 and (p11._falling_start and tick() - p11._falling_start > 0.25) then
            p11:_ClearFallingSound();
            local ClientFighter = p11.ClientFighterCharacter.ClientFighter;
            local v15 = (tick() - p11._falling_start - 1) * 0.45;
            ClientFighter:CreateSound("rbxassetid://16736552001", math.clamp(v15, 0, 0.9) + 0.1, 1 + 0.75 * math.random(), true, 5);
            p11._falling_start = nil;
            p13.JustLanded = true;

            return true;
        end;
    else
        p11._falling_start = tick();
        local v16 = p11.ClientFighterCharacter.ClientFighter.IsLocalPlayer and p11.ClientFighterCharacter.ClientFighter:CreateSound("rbxassetid://16737738355", 0, 1, true);
        p11._falling_sound = v16;
        p11.ClientFighterCharacter.ClientFighter:CreateSound("rbxassetid://16736552098", 0.5, 1 + 0.5 * math.random(), true, 5);

        if p11._falling_sound then
            p11._falling_sound.Looped = true;
        end;
    end;

    if p11._falling_sound then
        local _falling_sound = p11._falling_sound;
        local math_max_ret = math.max(0, -p11.ClientFighterCharacter.RootPart.Velocity.Y - 24);
        local v17 = (math.sqrt(math_max_ret) / 15) ^ 2 * 2;
        _falling_sound.Volume = math.min(1, v17);
    end;
end;

function u1._UpdateFootstep(p18, p19, p20) -- Line: 77
    -- upvalues: SoundLibrary (copy)
    if not p20.IsAlive or (p20.IsCrouching or (p20.IsSliding or not (p20.IsGrounded or p20.IsClimbing))) or (p20.IsHiddenByEmotes or p20.IsHiddenByCutscene) then
        return;
    end;

    if tick() < p18._footsteps_disabled then
        return;
    end;

    local CurrentEmote = p18.ClientFighterCharacter:GetCurrentEmote();

    if CurrentEmote and (CurrentEmote.Info.HideFootsteps and not p18.ClientFighterCharacter.ClientFighter:Get("IsInDuel")) then
        return;
    end;

    local v21 = p18.ClientFighterCharacter.ClientFighter.Entity:Get("Scale") or 1;
    local v22 = p20.IsClimbing and math.abs(p20.PlayerVelocity.Y * 1.25) or p20.MoveSpeed / (1 + (v21 - 1) / 2);

    if v22 < 1 or tick() < p18._last_footstep + 4.5 / v22 then
        return;
    end;

    p18._last_footstep = tick();
    local v23 = p20.IsClimbing and "Climbing" or (v21 >= 2 and "Stomping" or (SoundLibrary.FootstepSounds[p18.ClientFighterCharacter.Humanoid.FloorMaterial.Name] and (p18.ClientFighterCharacter.Humanoid.FloorMaterial.Name or "Default") or "Default"));
    local v24 = SoundLibrary.FootstepSounds[v23];
    local v25 = SoundLibrary.FootstepSounds[v24] or v24;

    if #v25 == 0 then
        return;
    end;

    local v26 = (0.875 + 0.25 * math.random()) * (1 + 0.1 * (v22 / 16));
    local v27 = v22 / 32 * (v23 == "Default" and 2 or 1) * (v23 == "Stomping" and 2 or 1) * (p18.ClientFighterCharacter.ClientFighter:Get("IsSpectating") and 0.5 or 1);
    p18.ClientFighterCharacter.ClientFighter:CreateSound(v25[math.random(#v25)], v27 * 0.75, v26, true, 5, 32, 100);
end;

function u1._Init(u28) -- Line: 121
    u28.ClientFighterCharacter.Died:Connect(function() -- Line: 122
        -- upvalues: u28 (copy)
        u28:_ClearFallingSound();
    end);
end;

return u1;