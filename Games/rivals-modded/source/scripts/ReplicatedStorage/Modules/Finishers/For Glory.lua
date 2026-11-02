-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.BetterDebris);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = { "rbxassetid://91261888651237", "rbxassetid://116627376811943", "rbxassetid://131046967935934", "rbxassetid://98510973512946", "rbxassetid://102276174123211", "rbxassetid://119206791261589", "rbxassetid://85250994493837", "rbxassetid://80578622827590", "rbxassetid://108990615121442", "rbxassetid://123917383226893" };
local u2 = setmetatable({}, Finisher);
u2.__index = u2;

function u2.new(...) -- Line: 14
    -- upvalues: Finisher (copy), u2 (copy)
    local v3 = Finisher.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayServer(p5) -- Line: 26
    if not p5._is_humanoid then
        return;
    end;

    local _subject = p5._subject;
    _subject.HipHeight = _subject.HipHeight + 1.5;
    local RootPart = p5._subject.RootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.CFrame = CFrame.new(Vector3.new(0, 0, 0), RootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyGyro.Parent = RootPart;
    table.insert(p5._destroy_these, BodyGyro);
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p5:_GetAnimationID();
    local success, result = pcall(p5._subject.LoadAnimation, p5._subject, Animation);

    if success then
        result:Play(0);
    end;

    wait(1.5);
    p5:_AnchorModel(0);
end;

function u2.PlayClient(u6) -- Line: 55
    -- upvalues: RunService (copy)
    if not u6._is_humanoid then
        return;
    end;

    for _, v in pairs(u6:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(105, 104, 106);
            v.Material = Enum.Material.SmoothPlastic;
            v.MaterialVariant = "";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = u6:_GetAnimationID();
    local u7 = script.Model:Clone();
    u7.PrimaryPart = u7.HumanoidRootPart;
    u7:PivotTo(u6._subject.RootPart.CFrame);
    u7.Parent = workspace;
    table.insert(u6._destroy_these, u7);

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Noclip";
        end;
    end;

    local success, result = pcall(u7.AnimationController.LoadAnimation, u7.AnimationController, Animation);

    if success then
        result:Play(0);
    end;

    local v8 = RunService.RenderStepped:Connect(function() -- Line: 95
        -- upvalues: u7 (copy), u6 (copy)
        u7:PivotTo(u6._subject.RootPart.CFrame * CFrame.new(0, 2.25, 0));
    end);
    table.insert(u6._connections, v8);
    u6:CreateSound("rbxassetid://90323515241815", 1, 1 + 0.1 * math.random(), nil, true, 5);
    wait(1.5);
    v8:Disconnect();

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;
end;

function u2._GetAnimationID(p9) -- Line: 118
    -- upvalues: u1 (copy)
    return u1[Random.new(p9._serial and p9._serial.Seed or p9._seed):NextInteger(1, #u1)];
end;

function u2._Init(p10) -- Line: 122
end;

return u2;