-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
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
    -- upvalues: Players (copy), Utility (copy), Spring (copy), RunService (copy)
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
    local u7 = script.Model:Clone();
    u7.Extra.Screen.SurfaceGui.TextLabel.Text = v6 and v6.DisplayName or "RIP";
    u7.Parent = u4._subject;
    Utility:PlayParticles(u7.Extra.Particles);
    local u8 = u4:_GetObjects(true);
    local u9 = Spring.new(u5.Position, 1, 2);
    local v10 = RunService.RenderStepped:Connect(function() -- Line: 47
        -- upvalues: u9 (copy), u4 (copy), u5 (copy), u8 (copy), u7 (copy), CFrame_Angles_ret (copy)
        u9.Target = u4:_GetGroundPosition(u5.Position, u8);
        u7:PivotTo(CFrame.new(u9.Value.X, u9.Target.Y, u9.Value.Z) * CFrame_Angles_ret);
    end);
    table.insert(u4._connections, v10);
    u4:CreateSound("rbxassetid://123329322643049", 1, 0.95 + 0.1 * math.random(), u5, true, 10);
    wait(3);
    v10:Disconnect();
    wait(7);
end;

function u1._Init(p11) -- Line: 67
end;

return u1;