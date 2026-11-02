-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Spring = require(ReplicatedStorage.Modules.Spring);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4) -- Line: 25
    -- upvalues: Players (copy), DuelLibrary (copy), CONSTANTS (copy), Spring (copy), RunService (copy)
    for _, v in pairs(u4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.LocalTransparencyModifier = 1;
        elseif v:IsA("Decal") or (v:IsA("Texture") or (v:IsA("Beam") or (v:IsA("ParticleEmitter") or (v:IsA("Trail") or v:IsA("SurfaceAppearance"))))) then
            v:Destroy();
        end;
    end;

    local u5 = u4._is_humanoid and u4._subject.RootPart or u4._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local v6 = u4._is_humanoid and Players:GetPlayerFromCharacter(u4._subject.Parent);
    local v7 = v6 and v6:GetAttribute("TeamID") and DuelLibrary:GetTeamColor(v6:GetAttribute("TeamID"));
    local u8 = script.Model:Clone();
    u8.Part.BillboardGui.Headshot.Image = not v6 and "" or string.format(CONSTANTS.HEADSHOT_IMAGE, v6.UserId);
    u8.Parent = u4._subject;

    if v7 then
        u8.Extra.Neon.Color = v7;
        u8.Extra.Ring.Color = v7;
        u8.Extra.NeonCone.Color = v7;
        u8.Extra.Model["Meshes/HandLamp_01c"].Beam.Color = ColorSequence.new(v7);
    end;

    local u9 = u4:_GetObjects(true);
    local u10 = Spring.new(u5.Position, 1, 2);
    local v11 = RunService.RenderStepped:Connect(function() -- Line: 54
        -- upvalues: u10 (copy), u4 (copy), u5 (copy), u9 (copy), u8 (copy), CFrame_Angles_ret (copy)
        u10.Target = u4:_GetGroundPosition(u5.Position, u9);
        u8:PivotTo(CFrame.new(u10.Value.X, u10.Target.Y, u10.Value.Z) * CFrame_Angles_ret);
    end);
    table.insert(u4._connections, v11);
    u4:CreateSound("rbxassetid://80428386536466", 1.25, 1, nil, true, 5);
    u4:CreateSound("rbxassetid://138661631832263", 1.5, 1, nil, true, 5);
    wait(3);
    v11:Disconnect();
    wait(7);
end;

function u1._Init(p12) -- Line: 75
end;

return u1;