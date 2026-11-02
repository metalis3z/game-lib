-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local QuaternionSpring = require(ReplicatedStorage.Modules.QuaternionSpring);
local Quaternion = require(ReplicatedStorage.Modules.Quaternion);
local Spring = require(ReplicatedStorage.Modules.Spring);
local SmokeCloud = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SmokeCloud"));
local u1 = setmetatable({}, SmokeCloud);
u1.__index = u1;

function u1.new(...) -- Line: 19
    -- upvalues: SmokeCloud (copy), u1 (copy), QuaternionSpring (copy), Quaternion (copy), Spring (copy)
    local v2 = SmokeCloud.new(...);
    local v3 = setmetatable(v2, u1);
    v3._direction_spring = QuaternionSpring.new(Quaternion.fromCFrame(CFrame.identity), 0.75, 10);
    v3._pupil_size_spring = Spring.new(0.187, 0.75, 5);
    v3._next_direction_update = 0;
    v3._direction_update_count = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 36
    -- upvalues: Quaternion (copy)
    if p4:_UpdateCoreLogic() then
        return;
    end;

    if tick() > p4._next_direction_update then
        p4._direction_update_count = p4._direction_update_count + 1;
        local v6;

        if p4._direction_update_count % 30 == 0 then
            v6 = CFrame.new(p4.Part.Position, workspace.CurrentCamera.CFrame.Position);
            p4._direction_spring.Speed = 10;
            p4._pupil_size_spring.Target = 0.3;
            p4._next_direction_update = tick() + 3;
        else
            local v7 = Random.new():NextUnitVector();
            v6 = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(v7.X, (v7.Y + 1) / 2, v7.Z)));
            p4._direction_spring.Speed = 10;
            p4._pupil_size_spring.Target = 0.187;
            p4._next_direction_update = tick() + 0.1;
        end;

        p4._direction_spring.Target = Quaternion.fromCFrame(v6);
    elseif p4._direction_update_count % 30 == 0 then
        p4._direction_spring.Target = Quaternion.fromCFrame(CFrame.new(p4.Part.Position, workspace.CurrentCamera.CFrame.Position));
    end;

    p4.Model.Pupil.Size = Vector3.new(p4._pupil_size_spring.Value, p4._pupil_size_spring.Value, 0.009) * p4.Model:GetScale();
    p4.Model:PivotTo(CFrame.new(p4.Part.Position) * p4._direction_spring.Position:ToCFrame().Rotation);
end;

function u1._Setup(p8) -- Line: 73
    p8.Model.Iris.Color = Color3.fromHSV(math.random(), 1, 1);
end;

function u1._Init(p9) -- Line: 77
    p9:_Setup();
end;

return u1;