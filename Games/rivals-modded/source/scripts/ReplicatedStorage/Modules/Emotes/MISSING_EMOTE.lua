-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(nil, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 23
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_PlayAnimation("rbxassetid://71250144811352");
end;

function u1._Recolor(p5) -- Line: 32
    for _, descendant in pairs(p5._humanoid.Parent:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Transparency < 0.99 then
            local v6 = descendant;

            for _, child in pairs(script.Textures:GetChildren()) do
                child:Clone().Parent = v6;
            end;
        end;
    end;
end;

function u1._Init(p7) -- Line: 42
    task.spawn(p7._Recolor, p7);
end;

return u1;