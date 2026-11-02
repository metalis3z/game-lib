-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Drops = game:GetService("Players").LocalPlayer.PlayerScripts.Assets.Drops;

local function set_ltm(p1, p2) -- Line: 7
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("ParticleEmitter") then
            descendant.LocalTransparencyModifier = p2;
        end;
    end;
end;

return function(p3, p4, p5) -- Line: 15
    -- upvalues: Drops (copy), set_ltm (copy)
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p3;
    local v6 = Drops[p4]:Clone();
    v6.PrimaryPart = v6.Primary;
    v6:PivotTo(p3.CFrame * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2));

    for _, descendant in pairs(v6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local v7 = descendant == v6.PrimaryPart;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
            descendant.Anchored = v7;

            if not v7 then
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = v6.Primary;
                WeldConstraint.Part1 = descendant;
                WeldConstraint.Parent = descendant;
            end;
        end;
    end;

    v6.PrimaryPart.Anchored = false;
    v6.Parent = p3;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = v6.PrimaryPart;
    local AngularVelocity = Instance.new("AngularVelocity");
    AngularVelocity.MaxTorque = 1000000;
    local v8 = math.random() - 0.5;
    AngularVelocity.AngularVelocity = Vector3.new(0, 2, 0) * math.sign(v8);
    AngularVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    AngularVelocity.Attachment0 = Attachment2;
    AngularVelocity.Parent = v6.PrimaryPart;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.RigidityEnabled = true;
    AlignPosition.Attachment0 = Attachment2;
    AlignPosition.Attachment1 = Attachment;
    AlignPosition.Parent = v6.PrimaryPart;

    if p5 < (1 / 0) then
        wait(p5 - 4);

        for i = 1, 20 do
            set_ltm(p3, 1);
            wait(0.07500000000000001);
            set_ltm(p3, 0);
            wait(0.125);
            local _ = i;
        end;
    end;
end;