-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local DamageIndicatorIcon = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DamageIndicatorIcon");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.Frame = v3.FighterInterface.Frame:WaitForChild("DamageIndicators");
    v3._current_damage_indicators = {};
    v3:_Init();

    return v3;
end;

function u1.Create(p4, p5) -- Line: 33
    -- upvalues: Spring (copy), DamageIndicatorIcon (copy), BetterDebris (copy), Utility (copy)
    local v6 = p5[utf8.char(2)];

    if not (v6 and (p5[utf8.char(0)] ~= 0 and p4.FighterInterface:IsActive())) then
        return;
    end;

    for i, v in pairs(p4._current_damage_indicators) do
        if v.Source == v6 then
            i:Destroy();
            p4._current_damage_indicators[i] = nil;
        end;
    end;

    local v7 = typeof(v6) == "Instance";
    local u8 = Spring.new(0, 1, 40);
    local u9 = Spring.new(0.5, 1, 40);
    local u10 = DamageIndicatorIcon:Clone();
    u10.Parent = p4.Frame;
    BetterDebris:AddItem(u10, 10);
    local u11;

    if v7 then
        u11 = v6.Position or v6;
    else
        u11 = v6;
    end;

    local u12 = nil;

    local function update(p13) -- Line: 58
        -- upvalues: u11 (copy), u10 (copy), u8 (copy), u9 (copy), u12 (ref)
        local v14 = (u11 - workspace.CurrentCamera.CFrame.Position) * Vector3.new(1, 0, 1);
        local v15 = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);
        local v16 = v15.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or v15.Unit;

        if v14 ~= v14 or v14.Magnitude == 0 then
            u10.Visible = false;

            return;
        end;

        u10.Visible = true;
        local v17 = v14:Dot(v16) / v14.Magnitude;
        local math_acos_ret = math.acos(v17);
        local Y = v16:Cross(v14).Y;

        if math.sign(Y) == 1 then
            math_acos_ret = 6.283185307179586 - math_acos_ret or math_acos_ret;
        end;

        u8.Target = math_acos_ret + 1.5707963267948966;
        local v18 = 0.5 / math.max(1, (v14.Magnitude - 5) / 25);
        u9.Target = math.max(0.125, v18);

        if p13 then
            if u12 then
                local v19 = u8.Target - u12;

                if v19 > 3.141592653589793 then
                    local v20 = u8;
                    v20.Value = v20.Value + 6.283185307179586;
                elseif v19 < -3.141592653589793 then
                    local v21 = u8;
                    v21.Value = v21.Value - 6.283185307179586;
                end;
            end;
        else
            u9.Value = u9.Target;
            u8.Value = u8.Target;
        end;

        local v22 = Vector2.new(0.5, 0.5) - Vector2.new(math.cos(u8.Value), (math.sin(u8.Value))) * 0.75 / 2;
        u10.Position = UDim2.new(v22.X, 0, v22.Y, 0);
        u10.Rotation = math.deg(u8.Value - 1.5707963267948966);
        u10.Size = UDim2.new(u9.Value, 0, u9.Value, 0);
        u12 = u8.Target;
    end;

    p4._current_damage_indicators[u10] = {
        Source = v6,
        Update = update
    };
    update(nil);
    wait(5);
    Utility:RenderstepForLoop(0, 100, 4, function(p23) -- Line: 103
        -- upvalues: u10 (copy)
        u10.ImageTransparency = (p23 / 100) ^ 4;
    end);
    u10:Destroy();
    p4._current_damage_indicators[u10] = nil;
end;

function u1.Update(p24, p25, p26) -- Line: 111
    for _, v in pairs(p24._current_damage_indicators) do
        pcall(v.Update, p25);
    end;
end;

function u1.Clear(p27) -- Line: 117
    for i in pairs(p27._current_damage_indicators) do
        i:Destroy();
    end;

    p27._current_damage_indicators = {};
end;

function u1.Destroy(p28) -- Line: 125
    p28:Clear();
end;

function u1._Init(p29) -- Line: 133
end;

return u1;