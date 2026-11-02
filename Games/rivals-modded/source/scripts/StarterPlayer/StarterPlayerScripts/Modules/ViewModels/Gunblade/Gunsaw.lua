-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gunblade = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Gunblade);
local u1 = setmetatable({}, Gunblade);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Gunblade (copy), u1 (copy)
    local v2 = Gunblade.new(...);
    local v3 = setmetatable(v2, u1);
    v3._spike_toggle = false;
    v3._next_toggle = 0;
    v3._spikes1 = v3.ItemModel:WaitForChild("Body"):WaitForChild("Spikes1");
    v3._spikes2 = v3.ItemModel:WaitForChild("Body"):WaitForChild("Spikes2");
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6, p7) -- Line: 27
    -- upvalues: Gunblade (copy)
    Gunblade.Update(p4, p5, p6, p7);

    if not p7.IsActive then
        return;
    end;

    if tick() < p4._next_toggle then
        return;
    end;

    p4._next_toggle = tick() + 0.03;
    p4._spike_toggle = not p4._spike_toggle;
    p4:_LocalTransparencyModifier(p4._spikes1, "Update", p4._spike_toggle and 0 or 1);
    p4:_LocalTransparencyModifier(p4._spikes2, "Update", p4._spike_toggle and 1 or 0);
end;

function u1._PlayIdleSound(p8) -- Line: 48
    local v9 = p8:CreateSound("rbxassetid://13645858587", 0.375, 1, true, nil, 10, 40);

    if v9 then
        v9.Looped = true;
    end;

    local v10 = p8:CreateSound("rbxassetid://13646484249", 0.375, 1, true, nil, 10, 40);

    if v10 then
        v10.Looped = true;
    end;

    local v11 = p8:CreateSound("rbxassetid://13646484113", 0.25, 1, true, nil, 10, 40);

    if v11 then
        v11.Looped = true;
    end;
end;

function u1._Init(u12) -- Line: 68
    u12.Equipped:Connect(function() -- Line: 69
        -- upvalues: u12 (copy)
        u12:_PlayIdleSound();
    end);
end;

return u1;