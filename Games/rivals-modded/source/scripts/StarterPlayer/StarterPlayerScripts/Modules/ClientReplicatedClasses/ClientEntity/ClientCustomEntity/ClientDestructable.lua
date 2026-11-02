-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ClientCustomEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientCustomEntity);
local ShatterVisuals = Players.LocalPlayer.PlayerScripts.Assets.Destructables.ShatterVisuals;
local Visuals = Players.LocalPlayer.PlayerScripts.Assets.Destructables.Visuals;
local CFrame_Angles_ret = CFrame.Angles(0, 1.5707963267948966, 0);
local u1 = setmetatable({}, ClientCustomEntity);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: ClientCustomEntity (copy), u1 (copy), Signal (copy), ShatterVisuals (copy)
    local v2 = ClientCustomEntity.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ShatterModelAdded = Signal.new();
    v3.AimAssistBlacklist = true;
    v3.PlayRubbleEffectOnDeath = nil;
    v3._shatter_template = ShatterVisuals:FindFirstChild(v3.Model.Name);
    v3._death_animation_override = true;
    v3._death_sound_override = true;
    v3._visual = nil;
    v3._always_face_camera = v3.Model:GetAttribute("AlwaysFaceCamera") or false;
    v3._shatter_sound_id = v3.Model:GetAttribute("ShatterSoundID") or (v3._shatter_template and (v3._shatter_template:GetAttribute("ShatterSoundID") or "rbxassetid://14441658101") or "rbxassetid://14441658101");
    v3._next_update = 0;
    v3._shatter_effect_chance = 1;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 54
    -- upvalues: ClientCustomEntity (copy)
    p4.ShatterModelAdded:Destroy();
    ClientCustomEntity.Destroy(p4);
end;

function u1._RubbleEffect(p5, p6) -- Line: 63
    for _, descendant in pairs(p5.Model:GetDescendants()) do
        local v7 = descendant:HasTag("IsRubble");

        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            descendant.Transparency = v7 and 0 or 1;
        end;

        if descendant:IsA("BasePart") then
            descendant.CanCollide = v7;
        end;
    end;
end;

function u1._ShatterEffect(p8, p9) -- Line: 77
    -- upvalues: CFrame_Angles_ret (copy), Utility (copy)
    local v10 = p8._visual and p8._visual.CFrame * CFrame_Angles_ret:Inverse() * CFrame.Angles(0, 6.283185307179586 * math.random(), 0) or p8.Model:GetPivot();
    p8.Model:ClearAllChildren();

    if math.random() > p8._shatter_effect_chance and (workspace.CurrentCamera.CFrame.Position - v10.Position).Magnitude > 24 then
        return;
    end;

    local v11 = p8._shatter_template:Clone();
    v11.Parent = p8.Model;
    v11.PrimaryPart = v11.Primary;
    v11:PivotTo(v10);
    v11.PrimaryPart:Destroy();
    local v12 = v11:GetAttribute("ShatterStrength") or 1;
    local Random_new_ret = Random.new();

    for _, child in pairs(v11:GetChildren()) do
        local LookVector = CFrame.new(p8.RootPart.Position, child.Position).LookVector;
        local X = LookVector.X;
        local v13 = math.max(0, LookVector.Y) * 2;
        local v14 = Vector3.new(X, v13, LookVector.Z) * (10 + 10 * math.random()) * v12;
        child.CanCollide = true;
        child.CanTouch = false;
        child.Anchored = false;
        child.RotVelocity = Random_new_ret:NextUnitVector() * 25 * math.random();
        child.Velocity = v14;
        local v15 = child;

        for _, child2 in pairs(v11:GetChildren()) do
            if child2 ~= v15 then
                local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
                NoCollisionConstraint.Part0 = v15;
                NoCollisionConstraint.Part1 = child2;
                NoCollisionConstraint.Parent = v15;
            end;
        end;
    end;

    if not p9 then
        Utility:CreateSound(p8._shatter_sound_id, 0.625 + 0.25 * math.random(), 1.5 + 0.5 * math.random(), v10.Position, true, 10);
    end;

    if p8._visual then
        p8._visual:Destroy();
        p8._visual = nil;
    end;

    p8.ShatterModelAdded:Fire(v11);
end;

function u1._CheckDead(p16, p17) -- Line: 132
    if p16:IsAlive() then
        return;
    end;

    if p16.PlayRubbleEffectOnDeath then
        p16:_RubbleEffect(p17);

        return;
    end;

    p16:_ShatterEffect(p17);
end;

function u1._Setup(p18) -- Line: 144
    -- upvalues: Visuals (copy)
    local v19 = Visuals:FindFirstChild(p18.Model.Name);

    if v19 then
        p18._visual = v19:Clone();
        p18._visual.CanCollide = false;
        p18._visual.CanQuery = false;
        p18._visual.CanTouch = false;
        p18._visual.Anchored = true;
        p18._visual.Parent = p18.Model;
    end;
end;

function u1._Init(u20) -- Line: 157
    u20.Died:Connect(function() -- Line: 158
        -- upvalues: u20 (copy)
        u20:_CheckDead();
    end);
    u20:_Setup();
    task.defer(u20._CheckDead, u20, true);
end;

return u1;