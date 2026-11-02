-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("RunService");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 7
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._is_playing = false;
    v2._next_flicker = {};
    v2:_Init();

    return v2;
end;

function u1._Play(p3) -- Line: 28
    -- upvalues: CollectionService (copy)
    if p3._is_playing then
        return;
    end;

    p3._is_playing = true;

    while true do
        local Tagged = CollectionService:GetTagged("FlickeringLight");

        if #Tagged == 0 then
            break;
        end;

        for _, v in pairs(Tagged) do
            if tick() >= (p3._next_flicker[v] or 0) then
                p3._next_flicker[v] = tick() + 1 + 4 * math.random();
                task.spawn(function() -- Line: 49
                    -- upvalues: v (copy)
                    for i = 1, math.random(1, 3) do
                        local v4 = v:FindFirstChildOfClass("SurfaceLight");
                        v.Material = Enum.Material.Neon;

                        if v4 then
                            v4.Enabled = true;
                        end;

                        wait(0.1);
                        v.Material = Enum.Material.SmoothPlastic;

                        if v4 then
                            v4.Enabled = false;
                        end;

                        wait(0.1);
                        local _ = i;
                    end;
                end);
            end;
        end;

        wait(0.1);
    end;

    p3._is_playing = false;
end;

function u1._Init(u5) -- Line: 78
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("FlickeringLight"):Connect(function(p6) -- Line: 79
        -- upvalues: u5 (copy)
        u5._next_flicker[p6] = tick() + 1;
        u5:_Play();
    end);
    CollectionService:GetInstanceRemovedSignal("FlickeringLight"):Connect(function(p7) -- Line: 84
        -- upvalues: u5 (copy)
        u5._next_flicker[p7] = nil;
    end);
    task.spawn(u5._Play, u5);
end;

return u1._new();