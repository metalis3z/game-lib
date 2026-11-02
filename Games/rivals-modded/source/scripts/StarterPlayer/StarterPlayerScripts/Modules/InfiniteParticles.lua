-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local InfiniteAmmoParticle = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InfiniteAmmoParticle");
local u1 = { "RichText", "Text", "TextColor", "TextTransparency" };
local u2 = {};
u2.__index = u2;

function u2.new(p3, p4) -- Line: 10
    -- upvalues: u2 (copy)
    local v5 = setmetatable({}, u2);
    v5._ammo_element = p3;
    v5._reserve_element = p4;
    v5._is_active = false;
    v5._ammo_active = false;
    v5._reserve_active = false;
    v5._particles = {};
    v5._next_particle = 0;
    v5:_Init();

    return v5;
end;

function u2.SetActive(p6, p7, p8) -- Line: 30
    p6._ammo_active = p7 and true or false;
    p6._reserve_active = p8 and true or false;
    p6._is_active = p6._ammo_active or p6._reserve_active;

    if not p6._is_active then
        p6:_Clear();
    end;
end;

function u2.Update(p9, p10) -- Line: 40
    if p9._is_active then
        p9:_UpdateInfiniteAmmo(p10, p9._ammo_active, p9._reserve_active);
    end;
end;

function u2.Destroy(p11) -- Line: 46
    p11:_Clear();
end;

function u2._Clear(p12) -- Line: 54
    for i = #p12._particles, 1, -1 do
        p12:_CleanupParticle(i);
        local _ = i;
    end;
end;

function u2._CleanupParticle(p13, p14) -- Line: 60
    local v15 = p13._particles[p14];

    for _, v in pairs(v15.Connections) do
        v:Disconnect();
    end;

    v15.Particle:Destroy();
    table.remove(p13._particles, p14);
end;

function u2._SpawnInfiniteAmmoParticle(p16, u17) -- Line: 71
    -- upvalues: Players (copy), InfiniteAmmoParticle (copy), u1 (copy)
    if not (u17 and u17:IsDescendantOf(Players)) then
        return;
    end;

    local u18 = InfiniteAmmoParticle:Clone();
    u18.Position = UDim2.new(u17.TextXAlignment == Enum.TextXAlignment.Left and 0 or 1, u17.TextBounds.X * math.random() * (u17.TextXAlignment == Enum.TextXAlignment.Left and 1 or -1), 0.5, u17.TextBounds.Y * 0.5 * (math.random() - 0.5));
    u18.Parent = u17;
    u18:TweenSize(UDim2.new(), "In", "Back", 0.75, true);

    local function update() -- Line: 88
        -- upvalues: u1 (ref), u18 (copy), u17 (copy)
        for _, v in pairs(u1) do
            u18[v] = u17[v];
        end;
    end;

    local v19 = {};

    for _, v in pairs(u1) do
        local PropertyChangedSignal = u17:GetPropertyChangedSignal(v);
        table.insert(v19, PropertyChangedSignal:Connect(update));
    end;

    for _, v in pairs(u1) do
        u18[v] = u17[v];
    end;

    local _particles = p16._particles;
    local v20 = {
        Particle = u18,
        Connections = v19,
        Position = u18.Position,
        Velocity = Vector2.new(math.random() - 0.5, -math.random() - 0.5) * 100,
        Start = tick()
    };
    table.insert(_particles, v20);
end;

function u2._UpdateInfiniteAmmo(p21, p22) -- Line: 109
    for i = #p21._particles, 1, -1 do
        local v23 = p21._particles[i];
        local v24;

        if tick() - v23.Start >= 1 or not v23.Particle.Parent then
            p21:_CleanupParticle(i);
            v24 = i;
        else
            local math_min_ret = math.min(v23.Particle.Parent.AbsoluteSize.X, v23.Particle.Parent.AbsoluteSize.Y);
            local v25 = v23.Velocity.X * p22 / 60 * 4;
            local v26 = v23.Velocity.Y * p22 / 60 + 0.25 * (tick() - v23.Start) ^ 2;
            v23.Position = v23.Position + UDim2.new(0, math_min_ret * v25, 0, math_min_ret * v26);
            v23.Particle.Position = v23.Position;
            local Particle = v23.Particle;
            Particle.Rotation = Particle.Rotation + v25 * 200;
            v24 = i;
        end;
    end;

    if tick() < p21._next_particle then
        return;
    end;

    p21._next_particle = tick() + 0.1;

    if p21._ammo_active then
        p21:_SpawnInfiniteAmmoParticle(p21._ammo_element);
    end;

    if p21._reserve_active then
        p21:_SpawnInfiniteAmmoParticle(p21._reserve_element);
    end;
end;

function u2._Init(p27) -- Line: 143
end;

return u2;