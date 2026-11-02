-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = { 0.086, 0.156, 0.128 };
local u2 = { 1, 1, 0.639 };
local u3 = setmetatable({}, WrapGroupObject);
u3.__index = u3;

function u3.new(...) -- Line: 22
    -- upvalues: WrapGroupObject (copy), u3 (copy)
    local v4 = WrapGroupObject.new(...);
    local v5 = setmetatable(v4, u3);
    v5._color_objects = {};
    v5._color_sequence_objects = {};
    v5._brick_color_objects = {};
    v5:_Init();

    return v5;
end;

function u3.Update(p6, p7) -- Line: 38
    -- upvalues: u1 (copy), u2 (copy)
    workspace:GetServerTimeNow();
    local v8 = p6:_GetOffset() % 1;

    for _, v in pairs(p6._color_objects) do
        local v9 = v:GetAttribute("WrapGroup") or 1;
        v.Color = Color3.fromHSV(v8, u1[v9], u2[v9]);
    end;

    for _, v in pairs(p6._color_sequence_objects) do
        local v10 = v:GetAttribute("WrapGroup") or 1;
        v.Color = ColorSequence.new(Color3.fromHSV(v8, u1[v10], u2[v10]));
    end;

    for _, v in pairs(p6._brick_color_objects) do
        local v11 = v:GetAttribute("WrapGroup") or 1;
        v.Color = BrickColor.new(Color3.fromHSV(v8, u1[v11], u2[v11]));
    end;
end;

function u3._NormalizeAngle(p12, p13) -- Line: 65
    return math.abs(p13 % 6.283185307179586 / 6.283185307179586 * 2 - 1);
end;

function u3._GetOffset(p14) -- Line: 69
    -- upvalues: workspace_CurrentCamera (copy)
    local Position = workspace_CurrentCamera.CFrame.Position;
    local v15, v16, v17 = workspace_CurrentCamera.CFrame:ToEulerAnglesXYZ();
    local v18 = p14:_NormalizeAngle(v15);
    local v19 = p14:_NormalizeAngle(v16);

    return (Position + Vector3.new(v18, v19, p14:_NormalizeAngle(v17)) * 32).Magnitude / 128;
end;

function u3._Evaluate(p20, p21) -- Line: 76
    if p21:IsA("BasePart") then
        table.insert(p20._color_objects, p21);

        return;
    end;

    if p21:IsA("ParticleEmitter") or (p21:IsA("Beam") or p21:IsA("Trail")) then
        table.insert(p20._color_sequence_objects, p21);

        return;
    end;

    if p21:IsA("RopeConstraint") or p21:IsA("RodConstraint") then
        table.insert(p20._brick_color_objects, p21);
    end;
end;

function u3._Setup(p22) -- Line: 86
    p22:_Evaluate(p22.Object);

    for _, v in p22.ExtraObjects do
        p22:_Evaluate(v);
    end;
end;

function u3._Init(p23) -- Line: 93
    p23:_Setup();
end;

return u3;