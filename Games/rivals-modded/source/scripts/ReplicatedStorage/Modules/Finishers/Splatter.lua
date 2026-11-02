-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {
    Color3.fromRGB(255, 50, 50),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 215, 0),
    Color3.fromRGB(100, 255, 50),
    Color3.fromRGB(0, 190, 255),
    Color3.fromRGB(122, 56, 255)
};
local u2 = { "rbxassetid://14796313307", "rbxassetid://14796313578" };
local u3 = { "rbxassetid://14796313153", "rbxassetid://14796313025" };
local u4 = setmetatable({}, Ragdoll);
u4.__index = u4;

function u4.new(...) -- Line: 13
    -- upvalues: Ragdoll (copy), u4 (copy)
    local v5 = Ragdoll.new(...);
    local v6 = setmetatable(v5, u4);
    v6:_Init();

    return v6;
end;

function u4.PlayClient(p7, ...) -- Line: 25
    -- upvalues: Ragdoll (copy), u1 (copy), Utility (copy), u2 (copy), u3 (copy)
    Ragdoll.PlayClient(p7, ...);
    local v8 = u1[math.random(#u1)]:ToHSV();

    for _, v in pairs(p7:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromHSV((v8 + 0.1 * (math.random() - 0.5)) % 1, 1, 1);
            local v9 = v;
            local v10 = {};

            for _, child in pairs(script.Particles:GetChildren()) do
                local v11 = child:Clone();
                v11.Color = ColorSequence.new(v9.Color);
                v11.Parent = v9;
                table.insert(p7._destroy_these, v11);
                table.insert(v10, v11);
            end;

            Utility:PlayParticles(v10);
            p7:CreateSound(u2[math.random(#u2)], 1, 1 + 0.2 * math.random(), nil, true, 5);
            p7:CreateSound(u3[math.random(#u3)], 1, 1 + 0.2 * math.random(), nil, true, 5);
            wait(0.025 + 0.05 * math.random());
        end;
    end;
end;

function u4._Init(p12) -- Line: 60
end;

return u4;