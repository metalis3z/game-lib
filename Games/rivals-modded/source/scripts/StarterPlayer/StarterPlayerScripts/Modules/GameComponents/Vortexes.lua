-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local MechanicsController = require(Players.LocalPlayer.PlayerScripts.Controllers.MechanicsController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local Vortexes = Players.LocalPlayer.PlayerScripts.Assets.Misc.Vortexes;
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._vortexes = {};
    v2._forces = {};
    v2._was_sitting = false;
    v2:_Init();

    return v2;
end;

function u1.UpdateForces(p3) -- Line: 34
    -- upvalues: FighterController (copy), Players (copy), MechanicsController (copy)
    local v4 = FighterController.LocalFighter and FighterController.LocalFighter.Entity and FighterController.LocalFighter.Entity.Humanoid;
    local v5;

    if v4 then
        v5 = v4.RootPart;
    else
        v5 = v4;
    end;

    if not v5 then
        for _, v in pairs(p3._forces) do
            p3:_Cleanup(v);
        end;

        p3._forces = {};

        return;
    end;

    for i, v in pairs(p3._vortexes) do
        local Magnitude = (i.Position - v5.Position).Magnitude;

        if i.Size.X / 2 < Magnitude then
            if i.Size.X * 1 < Magnitude then
                local v6 = p3._forces[i];

                if v6 then
                    p3:_Cleanup(v6);
                    p3._forces[i] = nil;
                end;
            end;
        elseif not (v.UserID == Players.LocalPlayer.UserId or v.TeamID and v.TeamID == Players.LocalPlayer:GetAttribute("TeamID") or p3._forces[i]) then
            local VectorForce = Instance.new("VectorForce");
            VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World;
            VectorForce.Attachment0 = v5.RootRigAttachment;
            VectorForce.Parent = nil;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
            BodyVelocity.Parent = v5;
            p3._forces[i] = {
                RootPart = v5,
                VectorForce = VectorForce,
                BodyVelocity = BodyVelocity
            };
        end;
    end;

    if not next(p3._forces) then
        if p3._was_sitting then
            p3._was_sitting = false;
            v4.Sit = false;
        end;

        return;
    end;

    if MechanicsController.IsSliding then
        MechanicsController:StopSliding();
    end;

    for i, v in pairs(p3._forces) do
        if not v5.Position:FuzzyEq(i.Position) then
            local CFrame_new_ret = CFrame.new(v5.Position, i.Position);
            local v7 = (CFrame_new_ret.RightVector * 0.15 + CFrame_new_ret.LookVector) * 5000;
            v.VectorForce.Force = v7.Unit * math.min(v7.Magnitude, 5000);
            v.BodyVelocity.Velocity = CFrame_new_ret.LookVector * 50;
        end;

        v4.Sit = true;
        p3._was_sitting = true;
    end;
end;

function u1.UpdateVisuals(p8, p9) -- Line: 124
    for i, v in pairs(p8._vortexes) do
        local v10 = (tick() - v.Start) / v.Lifetime;
        local math_clamp_ret = math.clamp(v10, 0, 1);
        v.Clock = v.Clock + p9 * (math_clamp_ret ^ 4 + 1);
        local math_max_ret = math.max(0.01, 1 - math_clamp_ret ^ 4);
        local v11 = CFrame.new(i.Position, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(0, v.Clock * (math_clamp_ret ^ 4 * 4 + 4) % 6.283185307179586, 0) * CFrame.Angles((1 - math_clamp_ret ^ 6 * 3) * 0.7853981633974483, 0, 0) * CFrame.Angles(0, v.Clock * (math_clamp_ret ^ 4 * 4 + 4) % 6.283185307179586, 0);
        v.Visual:ScaleTo(v.OriginalScale * v.ScaleSpring.Value * math_max_ret);
        v.Visual:PivotTo(v11);

        if tick() > v.NextShrink then
            v.NextShrink = tick() + 0.25;
            local ScaleSpring = v.ScaleSpring;
            ScaleSpring.Value = ScaleSpring.Value - 0.125;
        end;
    end;
end;

function u1.Update(p12, p13) -- Line: 147
    p12:UpdateForces(p13);
    p12:UpdateVisuals(p13);
end;

function u1._Cleanup(p14, p15) -- Line: 156
    p15.VectorForce:Destroy();
    p15.BodyVelocity:Destroy();
end;

function u1._ObjectAdded(p16, p17) -- Line: 161
    -- upvalues: Utility (copy), Vortexes (copy), Spring (copy)
    p16:_ObjectRemoved(p17);
    Utility:CreateSound("rbxassetid://90138246017443", 1.25, 0.75 + 0.1 * math.random(), p17, true);
    local v18 = (Vortexes:FindFirstChild(p17:GetAttribute("ViewModelName") or "Default") or Vortexes.Default):Clone();
    v18:ScaleTo(v18:GetScale() * p17.Size.X / 24);
    v18.Parent = p17;
    local v19 = Spring.new(1, 0.75, 20);
    v19.Value = 0;
    p16._vortexes[p17] = {
        Clock = 0,
        Visual = v18,
        OriginalScale = v18:GetScale(),
        ScaleSpring = v19,
        NextShrink = tick() + 0.5,
        Start = tick(),
        Lifetime = p17:GetAttribute("Lifetime"),
        TeamID = p17:GetAttribute("TeamID"),
        UserID = p17:GetAttribute("UserID")
    };
end;

function u1._ObjectRemoved(p20, p21) -- Line: 187
    p20._vortexes[p21] = nil;

    if p20._forces[p21] then
        p20:_Cleanup(p20._forces[p21]);
        p20._forces[p21] = nil;
    end;
end;

function u1._Init(u22) -- Line: 196
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceRemovedSignal("Vortex"):Connect(function(p23) -- Line: 197
        -- upvalues: u22 (copy)
        u22:_ObjectRemoved(p23);
    end);
    CollectionService:GetInstanceAddedSignal("Vortex"):Connect(function(p24) -- Line: 201
        -- upvalues: u22 (copy)
        u22:_ObjectAdded(p24);
    end);

    for _, v in pairs(CollectionService:GetTagged("Vortex")) do
        task.defer(u22._ObjectAdded, u22, v);
    end;
end;

return u1._new();