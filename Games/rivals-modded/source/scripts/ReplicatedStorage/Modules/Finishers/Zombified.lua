-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local TweenInfo_new_ret = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
local u1 = {
    Color = Color3.fromRGB(45, 117, 0)
};
local u2 = { "rbxassetid://76551122205423", "rbxassetid://121329175458153", "rbxassetid://86178802108357" };
local u3 = setmetatable({}, Ragdoll);
u3.__index = u3;

function u3.new(...) -- Line: 14
    -- upvalues: Ragdoll (copy), u3 (copy)
    local v4 = Ragdoll.new(...);
    local v5 = setmetatable(v4, u3);
    v5:_Init();

    return v5;
end;

function u3.PlayServer(p6, ...) -- Line: 26
    -- upvalues: Ragdoll (copy)
    local v7 = p6._is_humanoid and p6._subject.RootPart or p6._subject;
    v7.Anchored = true;
    wait(9.9);
    v7.Anchored = false;
    Ragdoll.PlayServer(p6, ...);
end;

function u3.PlayClient(p8) -- Line: 38
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), u1 (copy), Utility (copy), u2 (copy)
    for _, v in pairs(p8:_GetObjects()) do
        if v:IsA("BasePart") then
            TweenService:Create(v, TweenInfo_new_ret, u1):Play();
        end;
    end;

    if p8._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://84937348544434";
        local success, result = pcall(p8._subject.LoadAnimation, p8._subject, Animation);

        if success then
            result:Play(0);
        end;
    end;

    p8:CreateSound("rbxassetid://113907213192044", 1.5, 1, nil, true, 15);
    p8:CreateSound("rbxassetid://103180063975943", 0.25, 0.5 + 0.1 * math.random(), nil, true, 15);
    p8:CreateSound("rbxassetid://84523504613156", 1, 1, nil, true, 15);
    wait(0.8);
    p8:CreateSound("rbxassetid://99312045046993", 1, 1, nil, true, 15);
    wait(0.8);
    p8:CreateSound("rbxassetid://109142509049932", 1, 1, nil, true, 15);
    wait(2.4);
    local v9 = Utility:CloneTable(u2);

    for i = 1, #u2 do
        p8:CreateSound(table.remove(v9, math.random(#v9)), 0.5, 0.5 + 0.1 * math.random(), nil, true, 5);
        wait(5.7 / #u2);
        local _ = i;
    end;

    p8:CreateSound("rbxassetid://126800102156089", 0.5, 0.75, nil, true, 5);
end;

function u3._Init(p10) -- Line: 87
end;

return u3;