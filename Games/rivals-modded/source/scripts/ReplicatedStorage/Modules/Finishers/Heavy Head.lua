-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 24
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    v5.Anchored = true;

    if p4._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://90573604180891";
        local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

        if success then
            result:Play(0);
        end;
    end;

    wait(1.8);
    v5.Anchored = false;
    p4:_Ragdoll();
    p4:_AnchorModel();
end;

function u1.PlayClient(p6) -- Line: 48
    -- upvalues: RunService (copy)
    if not p6._is_humanoid then
        return;
    end;

    local Head = p6._subject.Parent.Head;
    local u7 = Head:Clone();
    u7.CanCollide = false;
    u7.CanTouch = false;
    u7.CanQuery = false;
    u7.Anchored = true;
    u7.Parent = Head;

    for _, child in pairs(u7:GetChildren()) do
        if not child:IsA("Decal") then
            child:Destroy();
        end;
    end;

    for _, child in pairs(Head:GetChildren()) do
        if child:IsA("Decal") then
            child.LocalTransparencyModifier = 1;
        end;
    end;

    Head.LocalTransparencyModifier = 1;
    local u8 = tick();
    table.insert(p6._connections, RunService.RenderStepped:Connect(function(p9) -- Line: 77
        -- upvalues: u8 (copy), u7 (copy), Head (copy)
        local v10 = (tick() - u8) / 1.8;
        local math_clamp_ret = math.clamp(v10, 0, 1);
        u7.Size = Head.Size * (math_clamp_ret * 2 + 1);
        u7.CFrame = Head.CFrame * CFrame.new(0, -Head.Size.Y / 2 + u7.Size.Y / 2, 0);
    end));
    p6:CreateSound("rbxassetid://102780719481956", 1, 1, nil, true, 5);
end;

function u1._Init(p11) -- Line: 91
end;

return u1;