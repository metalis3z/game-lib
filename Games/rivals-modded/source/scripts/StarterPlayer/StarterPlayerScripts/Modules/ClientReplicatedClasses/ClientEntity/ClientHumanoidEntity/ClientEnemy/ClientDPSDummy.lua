-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local DPSGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DPSGui");
local u1 = setmetatable({}, ClientEnemy);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: ClientEnemy (copy), u1 (copy), DPSGui (copy)
    local v2 = ClientEnemy.new(...);
    local v3 = setmetatable(v2, u1);
    v3._gui = DPSGui:Clone();
    v3._dps_start = nil;
    v3._dps_initial_damage = 0;
    v3._dps_total_damage = 0;
    v3._dps_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(u4, p5, ...) -- Line: 29
    -- upvalues: ClientEnemy (copy)
    if p5 ~= "RegisterDPS" then
        ClientEnemy.ReplicateFromServer(u4, p5, ...);

        return;
    end;

    if not u4:IsRendered() then
        return;
    end;

    local v6 = ...;
    u4._dps_start = u4._dps_start or tick();
    u4._dps_initial_damage = u4._dps_initial_damage or v6;
    u4._dps_total_damage = u4._dps_total_damage + v6;
    u4._dps_hash = u4._dps_hash + 1;
    local v7 = u4._dps_total_damage - (math.abs(u4._dps_initial_damage - u4._dps_total_damage) < 0.001 and 0 or u4._dps_initial_damage);
    u4._gui.MainFrame.Bar.Bar.Size = UDim2.new(1, 0, 1, 0);
    u4._gui.MainFrame.Bar.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", 3, true);
    local DPS = u4._gui.MainFrame.DPS;
    local string_format = string.format;
    local v8 = tick() - u4._dps_start;
    DPS.Text = string_format("DPS: %.1f", v7 / math.max(1, v8));
    u4._gui.MainFrame.Total.Text = string.format("Total: %.1f", u4._dps_total_damage);
    u4._gui.Enabled = true;
    local _dps_hash = u4._dps_hash;
    task.delay(3, function() -- Line: 54
        -- upvalues: u4 (copy), _dps_hash (copy)
        if u4._destroyed or u4._dps_hash ~= _dps_hash then
            return;
        end;

        u4._dps_start = nil;
        u4._dps_initial_damage = 0;
        u4._dps_total_damage = 0;
        u4._gui.Enabled = false;
    end);
end;

function u1._Setup(p9) -- Line: 73
    p9._gui.Enabled = false;
    p9._gui.Parent = p9.RootPart;
end;

function u1._Init(p10) -- Line: 78
    p10:_Setup();
end;

return u1;