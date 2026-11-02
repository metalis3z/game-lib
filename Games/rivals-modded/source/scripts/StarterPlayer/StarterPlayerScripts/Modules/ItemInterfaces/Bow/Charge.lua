-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local BowCharge = game:GetService("Players").LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BowCharge");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy), BowCharge (copy)
    local v3 = setmetatable({}, u1);
    v3.ItemInterface = p2;
    v3.Frame = BowCharge:Clone();
    v3.DamageText = v3.Frame:WaitForChild("Damage");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.BackgroundDivider2 = v3.Background:WaitForChild("Divider2");
    v3.BackgroundDivider3 = v3.Background:WaitForChild("Divider3");
    v3.BackgroundBar = v3.Background:WaitForChild("Bar");
    v3.BackgroundEffect = v3.Background:WaitForChild("Effect");
    v3.BackgroundEffectUIStroke = v3.BackgroundEffect:WaitForChild("UIStroke");
    v3.KeyWhiteFrame = v3.Background:WaitForChild("KeyWhite");
    v3.KeyColorFrame = v3.Background:WaitForChild("KeyColor");
    v3.KeyColorCircleStroke = v3.KeyColorFrame:WaitForChild("Circle"):WaitForChild("UIStroke");
    v3._destroyed = false;
    v3._start_time = nil;
    v3._charge_hash = 0;
    v3._max_charge_connection = nil;
    v3:_Init();

    return v3;
end;

function u1.Set(u4, p5) -- Line: 40
    -- upvalues: RunService (copy)
    if u4._destroyed then
        return;
    end;

    if u4._max_charge_connection then
        u4._max_charge_connection:Disconnect();
        u4._max_charge_connection = nil;
    end;

    local ChargeColor = u4.ItemInterface.ClientItem.ViewModel:GetChargeColor(p5);
    local ChargeLevelDamageMultipliers = u4.ItemInterface.ClientItem.Info.ChargeLevelDamageMultipliers;
    u4.Frame.Position = UDim2.new(0.5, 24, 0.5, 24);
    u4.DamageText.Text = "<font family=\"12187365977\"><stroke color=\"rgb(255,255,255)\" joins=\"miter\" thickness=\"3\">" .. math.floor(ChargeLevelDamageMultipliers[p5] * 100) .. "%</stroke></font>";
    u4.DamageText.TextColor3 = ChargeColor;
    u4.DamageText.Size = UDim2.new(1, 0, p5 == 1 and 0.5 or 0.75, 0);
    u4.DamageText:TweenSize(UDim2.new(1, 0, 0.5, 0), "Out", "Quint", 0.5, true);
    u4.BackgroundEffectUIStroke.Color = ChargeColor;
    u4.BackgroundBar.BackgroundColor3 = ChargeColor;
    u4.KeyColorCircleStroke.Color = ChargeColor;

    if #ChargeLevelDamageMultipliers <= p5 then
        u4._max_charge_connection = RunService.RenderStepped:Connect(function(p6) -- Line: 63
            -- upvalues: u4 (copy)
            u4.Frame.Position = UDim2.new(0.5, 24 + 8 * (math.random() - 0.5), 0.5, 24 + 8 * (math.random() - 0.5));
        end);
    end;
end;

function u1.Start(p7, p8) -- Line: 69
    if p7._destroyed then
        return;
    end;

    local v9 = typeof(p8) == "table";
    assert(v9, "Argument 1 invalid, expected a table");
    p7._charge_hash = p7._charge_hash + 1;
    p7._start_time = tick();
    p7.Frame.Visible = true;
    p7.BackgroundBar.Size = UDim2.new(0, 8, 1, 0);
    p7.BackgroundBar:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", p8[#p8], true);
    p7.BackgroundEffect.Size = UDim2.new(1, 0, 1, 0);
    p7.BackgroundEffect.Visible = false;
    local v10 = {};

    for i, v in pairs(p8) do
        local v11 = v / p8[#p8];
        local ChargeColor = p7.ItemInterface.ClientItem.ViewModel:GetChargeColor(i);
        table.insert(v10, ColorSequenceKeypoint.new(v11, ChargeColor));

        if i ~= 1 and i ~= #p8 then
            p7["BackgroundDivider" .. i].Position = UDim2.new(v / p8[#p8], 0, 0, 0);
        end;
    end;
end;

function u1.Play(p12) -- Line: 99
    if p12._destroyed then
        return;
    end;

    p12.Background.Size = UDim2.new(1, 0, 0.375, 0);
    p12.Background:TweenSize(UDim2.new(1, 0, 0.25, 0), "Out", "Quint", 0.5, true);
end;

function u1.Stop(u13, p14) -- Line: 108
    if u13._destroyed then
        return;
    end;

    if u13._max_charge_connection then
        u13._max_charge_connection:Disconnect();
        u13._max_charge_connection = nil;
    end;

    if p14 then
        u13.Frame.Visible = false;
    else
        local _charge_hash = u13._charge_hash;
        u13.BackgroundBar:TweenSize(u13.BackgroundBar.Size, "Out", "Linear", 0, true);
        u13.BackgroundEffect.Visible = true;
        u13.BackgroundEffect:TweenSize(UDim2.new(1, 8, 1, 8), "Out", "Linear", 0.5, true, function() -- Line: 125
            -- upvalues: u13 (copy), _charge_hash (copy)
            wait(0.5);

            if u13._charge_hash ~= _charge_hash then
                return;
            end;

            u13.Frame.Visible = false;
        end);
    end;

    if not u13._start_time then
        return;
    end;

    u13._start_time = nil;
end;

function u1.Destroy(p15) -- Line: 143
    p15._destroyed = true;
    p15.Frame:Destroy();

    if p15._max_charge_connection then
        p15._max_charge_connection:Disconnect();
        p15._max_charge_connection = nil;
    end;
end;

function u1._Setup(p16) -- Line: 158
    local v17 = p16.ItemInterface.ClientItem.ViewModel.Name == "Key Bow";
    local Frame = p16.Frame;
    Frame.Position = Frame.Position + (v17 and UDim2.new(0, 18, 0, 0) or UDim2.new(0, 0, 0, 0));
    p16.KeyWhiteFrame.Visible = v17;
    p16.KeyColorFrame.Visible = v17;
    p16.Frame.Parent = p16.ItemInterface.Mouse.Frame;
end;

function u1._Init(u18) -- Line: 168
    u18.BackgroundEffect:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 169
        -- upvalues: u18 (copy)
        u18.BackgroundEffectUIStroke.Thickness = 4 - u18.BackgroundEffect.Size.X.Offset / 2;
    end);
    u18:_Setup();
    u18:Set(1);
end;

return u1;