-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local TrajectoryVisualNode = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("TrajectoryVisualNode");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._num_segments = p2 or 100;
    v3._folder = Instance.new("Folder");
    v3._impact_sphere = Instance.new("Part");
    v3._segments = {};
    v3._renderstep_connection = nil;
    v3._last_args = {};
    v3:_Init();

    return v3;
end;

function u1.OnStep(p4, p5) -- Line: 38
    -- upvalues: RunService (copy)
    if p4._renderstep_connection then
        p4._renderstep_connection:Disconnect();
        p4._renderstep_connection = nil;
    end;

    p4._renderstep_connection = RunService.RenderStepped:Connect(p5);
end;

function u1.Update(p6, p7, p8, p9, p10, p11, p12) -- Line: 49
    -- upvalues: Utility (copy)
    if p6._last_args[1] == p7 and (p6._last_args[2] == p8 and (p6._last_args[3] == p9 and (p6._last_args[4] == p10 and (p6._last_args[5] == p11 and p6._last_args[6] == p12)))) then
        return;
    end;

    p6._last_args = {
        p7,
        p8,
        p9,
        p10,
        p11,
        p12
    };
    local v13 = p7;
    local v14 = p9 or 196.2;
    local v15 = false;
    local v16 = p10 or 0.05;
    local v17 = p12 or (1 / 0);

    for i, v in pairs(p6._segments) do
        if v15 then
            v.CFrame = CFrame.new(v13);
        else
            local math_min_ret = math.min(v17, (i - 1) * v16 + 0);
            local v18 = p7 + p8 * math_min_ret - Vector3.new(0, 1, 0) * v14 * math_min_ret ^ 2;

            if v13:FuzzyEq(v18) then
                v.CFrame = CFrame.new(v13);
            else
                local v19 = Utility:Raycast(v13, v18, (v13 - v18).Magnitude, p11, Enum.RaycastFilterType.Include);
                v.CFrame = v13:FuzzyEq(v19.Position) and CFrame.new(v13) or CFrame.new(v13, v19.Position);
                v13 = v19.Position;

                if v19.Instance or v17 <= math_min_ret then
                    v15 = true;
                end;
            end;
        end;
    end;

    p6._impact_sphere.CFrame = CFrame.new(v13);
end;

function u1.Destroy(p20) -- Line: 91
    if p20._renderstep_connection then
        p20._renderstep_connection:Disconnect();
        p20._renderstep_connection = nil;
    end;

    p20._folder:Destroy();
end;

function u1._Setup(p21) -- Line: 104
    -- upvalues: TrajectoryVisualNode (copy)
    for i = 1, p21._num_segments do
        local v22 = TrajectoryVisualNode:Clone();
        v22.Size = Vector3.new(1, 2, 1) * (i * 0.02 + 0.1);
        v22.Parent = p21._folder;
        p21._segments[i] = v22;
        local v23 = p21._segments[i - 1];
        local v24;

        if v23 then
            v22.Beam.Attachment0 = v23.Attachment;
            v22.Beam.Width0 = v23.Size.Y / 4;
            v22.Beam.Width1 = v22.Beam.Width0;
            v24 = i;
        else
            v24 = i;
        end;
    end;

    p21._impact_sphere.Shape = "Ball";
    p21._impact_sphere.Color = Color3.fromRGB(255, 255, 255);
    p21._impact_sphere.Material = Enum.Material.ForceField;
    p21._impact_sphere.Size = Vector3.new(3, 3, 3);
    p21._impact_sphere.Anchored = true;
    p21._impact_sphere.CanCollide = false;
    p21._impact_sphere.CanTouch = false;
    p21._impact_sphere.CanQuery = false;
    p21._impact_sphere.CastShadow = false;
    p21._impact_sphere.Parent = p21._folder;
    p21._folder.Parent = workspace;
end;

function u1._Init(p25) -- Line: 134
    p25:_Setup();
end;

return u1;