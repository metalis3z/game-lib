-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local ImpactMarkerSplat = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ImpactMarkerSplat");
local u1 = { "rbxassetid://17098901439", "rbxassetid://17098901515", "rbxassetid://16833617681" };
local u2 = setmetatable({}, Gun);
u2.__index = u2;

function u2.new(...) -- Line: 15
    -- upvalues: Gun (copy), u2 (copy)
    local v3 = Gun.new(...);
    local v4 = setmetatable(v3, u2);
    v4._grenade_cooldown = 0;
    v4:_Init();

    return v4;
end;

function u2.StartAiming(p5, p6) -- Line: 29
    if p6 or tick() >= p5._grenade_cooldown and (tick() >= p5._reload_cooldown and not p5:IsEquipping()) then
        p5._grenade_cooldown = tick() + p5.Info.GrenadeCooldown;
        local _shoot_cooldown = p5._shoot_cooldown;
        local v7 = tick() + p5.Info.GrenadeShootCooldown;
        p5._shoot_cooldown = math.max(_shoot_cooldown, v7);
        p5.ViewModel:StopAnimation("Inspect");
        p5.ViewModel:PlayAnimation("Throw", 1);
        p5:CooldownEffect("rbxassetid://77802568386086", p5.Info.GrenadeCooldown, "Cooldown");

        return true, "StartAiming", p5.ClientFighter:GetCameraData();
    end;
end;

function u2.FinishAiming(p8, p9) -- Line: 45
    return false;
end;

function u2.StartSprinting(p10, p11) -- Line: 49
    return false;
end;

function u2.ReplicateFromServer(p12, p13, ...) -- Line: 53
    -- upvalues: Utility (copy), Gun (copy)
    if p13 ~= "PaintballSplatter" then
        Gun.ReplicateFromServer(p12, p13, ...);

        return;
    end;

    if not p12:IsRendered() then
        return;
    end;

    local v14, v15, v16 = ...;

    if not (v14 and (v15 and (v16 and not v14:FuzzyEq(v15)))) then
        return;
    end;

    local v17 = Utility:Raycast(v14, v15, (v14 - v15).Magnitude + 1, { v16 }, Enum.RaycastFilterType.Whitelist);

    if not v17.Instance then
        return;
    end;

    p12:_ImpactMarkers({ v17 });
end;

function u2._ImpactMarker(p18, p19) -- Line: 81
    -- upvalues: ImpactMarkerSplat (copy), BetterDebris (copy), u1 (copy)
    local v20;

    if p19.IsFromPaintGrenade then
        v20 = Color3.fromHSV(math.random(), 0.75, 1);
    else
        v20 = p18.ViewModel:GetPaintballColor();
    end;

    local v21 = ImpactMarkerSplat.Size * (0.5 + 0.75 * math.random()) * 2;

    for i = #p18._impact_markers, 1, -1 do
        local v22 = p18._impact_markers[i];
        local v23;

        if (v22.Position - p19.Position).Magnitude <= v21.X / 2 + v22.Size.X / 2 and v22.Size.Magnitude < 10 then
            v21 = v21 + v22.Size;
            v20:Lerp(v22.Decal.Color3, 0.5);
            v22.Decal.Transparency = 1;
            BetterDebris:AddItem(v22, 1);
            table.remove(p18._impact_markers, i);
            v23 = i;
        else
            v23 = i;
        end;
    end;

    local v24 = ImpactMarkerSplat:Clone();
    v24.Decal.Color3 = v20;
    v24.Decal.Texture = u1[math.random(#u1)];
    v24.Decal.ZIndex = 0.75 + 0.5 * math.random();
    v24.Attachment.Particles.Color = ColorSequence.new(v20);
    local math_min_ret = math.min(v21.X, 10);
    local math_min_ret2 = math.min(v21.X, 10);
    v24.Size = Vector3.new(math_min_ret, math_min_ret2, 0);
    v24.CFrame = CFrame.new(p19.Position, p19.Position + p19.Normal) * CFrame.Angles(0, 0, math.random() * 3.141592653589793 * 2);
    v24.Parent = p19.Part or workspace;
    p18:_AddImpactMarker(v24, 10, 40);
    local v25 = v21.Magnitude / ImpactMarkerSplat.Size.Magnitude;
    v24.Attachment.Particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.075 * v25, 0.05 * v25), NumberSequenceKeypoint.new(1, 0.05 * v25, 0.05 * v25) });
    v24.Attachment.Particles:Emit(10);
    p18.ViewModel:CustomImpactMarker(v24);

    if not p19.IsFromPaintGrenade then
        p18.ViewModel:PlaySplatSound(v24);
    end;
end;

function u2._Tracers(p26, p27) -- Line: 125
    -- upvalues: Gun (copy)
    local v28 = {
        MaxLength = 2,
        MaxLengthFirstPerson = 5,
        Color = ColorSequence.new(p26.ViewModel:GetPaintballColor()),
        BeamProperties = {
            LightEmission = 0,
            Brightness = 2
        }
    };

    return Gun._Tracers(p26, p27, v28);
end;

function u2._Init(u29) -- Line: 139
    u29.ProjectileShot:Connect(function(p30, p31) -- Line: 140
        -- upvalues: u29 (copy)
        if p31.Name == "_paintballgun_grenade" then
            return;
        end;

        local PaintballColor = u29.ViewModel:GetPaintballColor();
        p31.Ball.Color = PaintballColor;
        p31.Ball.Trail.Color = ColorSequence.new(PaintballColor);
    end);
end;

return u2;