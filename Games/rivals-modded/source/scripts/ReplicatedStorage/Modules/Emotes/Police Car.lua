-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
Color3.fromRGB(20, 82, 214);
Color3.fromRGB(202, 42, 42);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 18
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(nil, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 30
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    local v5 = p4:_SetupMultipleProps(script.CarProp);
    p4:_PlayAnimation("rbxassetid://131715664984592", "rbxassetid://121062198562083", 3.15);
    p4:CreateSound("rbxassetid://139395743852964", 1, 1, nil, true).Looped = true;
    p4:CreateSound("rbxassetid://77259408745181", 0.75, 1, nil, true).Looped = true;
    local _ = v5.Base.Frame.vfx;
    local _ = v5.Base.RedLights;
    local _ = v5.Base.BlueLights;
    local _ = tick() + 4;

    for i = 1, (1 / 0) do
        if p4._destroyed then
            return;
        end;

        local _ = i % 2 == 1;
        wait(0.5);
        local _ = i;
    end;
end;

function u1._Init(p6) -- Line: 68
end;

return u1;