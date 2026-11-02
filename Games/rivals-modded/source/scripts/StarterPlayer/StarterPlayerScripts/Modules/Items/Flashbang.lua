-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FlashbangEffect = require(Players.LocalPlayer.PlayerScripts.Modules.Functions.FlashbangEffect);
local Throwable = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Throwable);
local u1 = setmetatable({}, Throwable);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Throwable (copy), u1 (copy)
    local v2 = Throwable.new(...);
    local v3 = setmetatable(v2, u1);
    v3._play_flash_sound_callback = nil;
    v3._play_ringing_sound_callback = nil;
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 24
    -- upvalues: FlashbangEffect (copy), Throwable (copy)
    if p5 ~= "BlindEffect" then
        Throwable.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    local v6, v7 = ...;
    FlashbangEffect({ v7 }, v6, p4.Info.BlindDuration, p4:Get("ObjectID"), p4.ViewModel.Name, p4._play_flash_sound_callback, p4._play_ringing_sound_callback);
end;

function u1._Setup(u8) -- Line: 46
    function u8._play_flash_sound_callback(p9) -- Line: 47
        -- upvalues: u8 (copy)
        return u8.ViewModel:PlayFlashSound(p9);
    end;

    function u8._play_ringing_sound_callback(p10) -- Line: 51
        -- upvalues: u8 (copy)
        return u8.ViewModel:PlayRingingSound(p10);
    end;
end;

function u1._Init(p11) -- Line: 56
    p11:_Setup();
end;

return u1;