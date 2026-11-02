-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local SmokeClouds = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("SmokeClouds");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 13
    -- upvalues: u1 (copy), Spring (copy)
    local v4 = setmetatable({}, u1);
    v4.Part = p2;
    v4.Name = v4.Part.Name;
    v4.EnvironmentID = v4.Part:GetAttribute("EnvironmentID");
    v4.Model = nil;
    v4._destroyed = false;
    v4._start_spring = Spring.new(0, 0.875, 10);
    v4._finish_spring = Spring.new(0, 1, 2);
    v4._position_spring = Spring.new(v4.Part.Position, 1, 20);
    v4._speed = 0.75 + 0.25 * math.random();
    v4._spin = 6.283185307179586 * math.random();
    v4._last_size = v4.Part.Size;
    v4._idle_sound = nil;
    v4._idle_sound_original_volume = nil;
    v4:_Init();

    return v4;
end;

function u1.IsDestroyed(p5) -- Line: 40
    return p5._destroyed;
end;

function u1.Update(p6, p7) -- Line: 44
    if p6:_UpdateCoreLogic() then
        return true;
    end;

    p6._position_spring.Target = p6.Part.Position;
    p6:_StepSpin(p7);
    p6.Model:PivotTo(CFrame.new(p6._position_spring.Value) * CFrame.Angles(0, p6._spin, 0));
end;

function u1.Clear(p8) -- Line: 54
    -- upvalues: BetterDebris (copy)
    p8._finish_spring.Target = 1;
    BetterDebris:AddItem(p8, 10);
end;

function u1.Destroy(p9) -- Line: 59
    if p9._destroyed then
        return;
    end;

    p9._destroyed = true;
    p9.Model:Destroy();
end;

function u1._CreateIdleSound(p10) -- Line: 72
    -- upvalues: Utility (copy)
    return Utility:CreateSound("rbxassetid://16540273153", 0.1, 1, nil, true);
end;

function u1._StepSpin(p11, p12) -- Line: 76
    p11._spin = (p11._spin + p11._speed * (1 + 5 * p11._start_spring.Velocity) * p12) % 6.283185307179586;
end;

function u1._UpdateCoreLogic(p13) -- Line: 80
    if not p13._idle_sound then
        p13._idle_sound = p13:_CreateIdleSound();
        p13._idle_sound.Parent = p13.Part;
        p13._idle_sound_original_volume = p13._idle_sound.Volume;
    end;

    p13.Model:ScaleTo(p13.Part.Size.Y * p13._start_spring.Value);

    if p13._finish_spring.Target <= 0 then
        p13._idle_sound.Volume = p13._start_spring.Value * p13._idle_sound_original_volume;

        return;
    end;

    if p13._finish_spring.Value >= 1 then
        p13:Destroy();

        return true;
    end;

    for _, descendant in pairs(p13.Model:GetDescendants()) do
        local v14 = p13._finish_spring.Value * (descendant:GetAttribute("DecaySpeed") or 1) + (descendant:GetAttribute("DecayOffset") or 0);
        descendant.LocalTransparencyModifier = math.clamp(v14, 0, 1);
    end;

    p13._idle_sound.Volume = p13._idle_sound_original_volume * math.clamp(1 - p13._finish_spring.Value * 2, 0, 1);
end;

function u1._AppearSound(p15) -- Line: 105
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://16540273321", 1, 1 + 0.1 * math.random(), p15.Part, true, 5);
end;

function u1._Setup(u16) -- Line: 109
    -- upvalues: SmokeClouds (copy)
    local Attribute = u16.Part:GetAttribute("Template");
    local v17 = SmokeClouds:FindFirstChild(u16.Part.Name);
    u16.Model = (v17 and v17:IsA("Folder") and (Attribute and v17[Attribute] or v17:GetChildren()[math.random(#v17:GetChildren())]) or (v17 or SmokeClouds.Default)):Clone();
    u16.Model.Destroying:Connect(function() -- Line: 115
        -- upvalues: u16 (copy)
        u16:Destroy();
    end);
    u16._start_spring.Target = 1;
end;

function u1._Init(u18) -- Line: 122
    u18.Part:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 123
        -- upvalues: u18 (copy)
        u18:_AppearSound();
        u18._start_spring.Value = u18._last_size.Magnitude / u18.Part.Size.Magnitude;
        u18._last_size = u18.Part.Size;
    end);
    u18:_Setup();
    u18:_AppearSound();
end;

return u1;