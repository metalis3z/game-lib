-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Spring = require(ReplicatedStorage.Modules.Spring);
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.AirborneChanged = Signal.new();
    v3.ClientFighterCharacter = p2;
    v3.IsAirborne = false;
    v3._destroyed = false;
    v3._airborne_spring = nil;
    v3._airborne_velocity = nil;
    v3._airborne_start = 0;
    v3._effect_objects = {};
    v3._animation_hash = 0;
    v3._animation_track = nil;
    v3._cleanup = {};
    v3:_Init();

    return v3;
end;

function u1.IsActive(p4) -- Line: 41
    if p4.ClientFighterCharacter.ClientFighter.IsLocalPlayer then
        return p4.IsAirborne;
    end;

    return p4.ClientFighterCharacter:Get("IsAirborne");
end;

function u1.Redirect(p5, p6, p7) -- Line: 45
    if not p5._airborne_spring then
        return;
    end;

    p5._airborne_spring.Value = (p6 or p5._airborne_spring.Target) * (p7 or 1);
end;

function u1.Trigger(u8, p9, u10, p11, u12, p13, p14, p15, u16) -- Line: 56
    -- upvalues: BetterDebris (copy), Spring (copy), Utility (copy), RunService (copy)
    local u17 = p13 or 1;
    local u18 = p14 or 1;
    local u19 = p15 or 1;

    if not (u8.ClientFighterCharacter.ClientFighter.IsLocalPlayer and (p9.Magnitude > 0.01 and not u8.ClientFighterCharacter:Get("IsFrozen"))) then
        return;
    end;

    if u8._airborne_velocity and p11 then
        return;
    end;

    local v20 = u8._airborne_velocity and (u8._airborne_velocity.Velocity or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);
    local v21;

    if u8._airborne_velocity then
        v21 = u8._airborne_velocity.Velocity or p9;
    else
        v21 = p9;
    end;

    local math_abs_ret = math.abs(p9.X);
    local math_abs_ret2 = math.abs(v20.X);
    local v22 = math.max(math_abs_ret, math_abs_ret2) * math.sign(v21.X);
    local Y = p9.Y;
    local math_abs_ret3 = math.abs(p9.Z);
    local math_abs_ret4 = math.abs(v20.Z);
    local v23 = math.max(math_abs_ret3, math_abs_ret4) * math.sign(v21.Z);
    local Vector3_new_ret = Vector3.new(v22, Y, v23);

    if u8._airborne_velocity then
        u8._airborne_velocity:Destroy();
        u8._airborne_velocity = nil;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BetterDebris:AddItem(BodyVelocity, 5);
    u8._airborne_start = tick();
    u8._airborne_velocity = BodyVelocity;
    u8.ClientFighterCharacter.ClientFighter.StopSliding:Fire();
    u8:_SetIsAirborne(true);
    task.spawn(function() -- Line: 93
        -- upvalues: BodyVelocity (copy), u8 (copy), Spring (ref), u12 (copy), Vector3_new_ret (copy), u10 (copy), u16 (copy), Utility (ref), u17 (copy), u18 (copy), u19 (copy), RunService (ref)
        BodyVelocity.Parent = u8.ClientFighterCharacter.RootPart;
        u8._airborne_spring = Spring.new(u12 and u12.Unit or Vector3_new_ret.Unit, 1, u10);
        local v24 = u12 and u12.Magnitude or (Vector3_new_ret * Vector3.new(1, 0, 1)).Magnitude;
        local v25 = tick();
        local v26 = false;
        local v27 = nil;
        local v28 = nil;

        while tick() < v25 + (u16 or (1 / 0)) and not (u8._destroyed or (BodyVelocity ~= u8._airborne_velocity or not (BodyVelocity:IsDescendantOf(u8.ClientFighterCharacter.RootPart) and (u8.ClientFighterCharacter:IsAlive() and (tick() - v25 <= 0.2 or u8.ClientFighterCharacter.RootPart.Velocity.Magnitude >= 5))))) do
            if not v26 and tick() - v25 > 0.2 then
                local v29 = BodyVelocity;
                v29.MaxForce = v29.MaxForce * Vector3.new(0.1, 1, 0.1);
                v26 = true;
            end;

            local Floor, v30 = u8.ClientFighterCharacter:GetFloor();

            if Floor then
                Floor = Utility:AngleBetweenVectors(Vector3.new(0, 1, 0), v30.Normal) < 0.1308996938995747;
            end;

            if tick() - v25 > 0.2 and Floor then
                if Vector3_new_ret.Y < 0 then
                    break;
                end;

                if v27 then
                    if tick() - v27 > 1 then
                        break;
                    end;
                else
                    v27 = tick();
                end;
            else
                v27 = nil;
            end;

            if v28 and math.abs(u8.ClientFighterCharacter.RootPart.Position.Y - v28.Y) <= 1 then
                if Floor and ((v28 - u8.ClientFighterCharacter.RootPart.Position) * Vector3.new(1, 0, 1)).Magnitude > 8 then
                    break;
                end;
            else
                v28 = u8.ClientFighterCharacter.RootPart.Position;
            end;

            u8._airborne_spring.Target = u8.ClientFighterCharacter.ClientFighter:GetMoveVector(true, true);
            local v31 = u8._airborne_spring.Value * Vector3.new(1, 0, 1) * v24 + Vector3.new(0, Vector3_new_ret.Y, 0);
            local v32 = (tick() - v25) / u18;
            BodyVelocity.Velocity = v31 * (1 + (u17 - 1) * math.clamp(v32, 0, 1)) * (16 / u8.ClientFighterCharacter.RootPart.AssemblyMass);

            if BodyVelocity.MaxForce.Y > 0 and tick() - v25 > 0.2 then
                local v33 = BodyVelocity;
                v33.MaxForce = v33.MaxForce * Vector3.new(1, 1 - u19, 1);
            end;

            RunService.Heartbeat:Wait();
        end;

        if u8._airborne_velocity ~= BodyVelocity then
            return;
        end;

        u8:Cancel();
    end);
end;

function u1.Cancel(p34) -- Line: 169
    if not p34.ClientFighterCharacter.ClientFighter.IsLocalPlayer then
        return;
    end;

    p34._airborne_spring = nil;

    if p34._airborne_velocity then
        p34._airborne_velocity:Destroy();
        p34._airborne_velocity = nil;
    end;

    p34:_SetIsAirborne(false);
end;

function u1.FromServer(p35, p36, p37, p38, p39) -- Line: 184
    if not p35.ClientFighterCharacter.ClientFighter.IsLocalPlayer then
        return;
    end;

    if p39 then
        p35:Cancel();
    end;

    p35:Trigger(p36 * 0.75, p38 or 4, nil, nil, nil, nil, nil, p37);
end;

function u1.Update(p40, p41, p42) -- Line: 196
end;

function u1.Destroy(p43) -- Line: 200
    p43._destroyed = true;

    for _, v in pairs(p43._cleanup) do
        v:Destroy();
    end;

    p43.AirborneChanged:Destroy();
    p43:Cancel();
end;

function u1._UpdateEffect(p44) -- Line: 216
    -- upvalues: BetterDebris (copy)
    for _, v in pairs(p44._effect_objects) do
        if v:IsA("Trail") then
            v.Enabled = false;
        end;

        BetterDebris:AddItem(v, 0.25);
    end;

    p44._effect_objects = {};

    if not p44:IsActive() or (p44.ClientFighterCharacter.ClientFighter:Get("IsHiddenByEmotes") or p44.ClientFighterCharacter.ClientFighter:Get("IsHiddenByCutscene")) then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Position = Vector3.new(-0.5, -2.9, 0);
    Attachment.Name = "Airborne0";
    Attachment.Parent = p44.ClientFighterCharacter.RootPart;
    table.insert(p44._effect_objects, Attachment);
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Position = Vector3.new(0.5, -2.9, 0);
    Attachment2.Name = "Airborne1";
    Attachment2.Parent = p44.ClientFighterCharacter.RootPart;
    table.insert(p44._effect_objects, Attachment2);
    local Trail = Instance.new("Trail");
    Trail.Transparency = NumberSequence.new(1, 0);
    Trail.WidthScale = NumberSequence.new(1, 0);
    Trail.LightEmission = 1;
    Trail.FaceCamera = true;
    Trail.Lifetime = 0.25;
    Trail.Attachment0 = Attachment;
    Trail.Attachment1 = Attachment2;
    Trail.Parent = p44.ClientFighterCharacter.RootPart;
    table.insert(p44._effect_objects, Trail);
end;

function u1._UpdateAnimation(u45) -- Line: 255
    -- upvalues: PreloadController (copy)
    if not u45.ClientFighterCharacter.ClientFighter.IsLocalPlayer then
        return;
    end;

    local v46 = u45:IsActive();
    local v47 = v46 and 0 or nil;

    if u45._animation_track then
        u45._animation_track:Stop(v47);
        u45._animation_track:Destroy();
        u45._animation_track = nil;
    end;

    u45._animation_hash = u45._animation_hash + 1;

    if not v46 then
        return;
    end;

    local _animation_hash = u45._animation_hash;
    local success, result = pcall(u45.ClientFighterCharacter.Humanoid.LoadAnimation, u45.ClientFighterCharacter.Humanoid, PreloadController:GetPreloadedAnimation("SlidingJump"));

    if not success then
        return;
    end;

    table.insert(u45._cleanup, result);
    result:Play(0);
    u45.ClientFighterCharacter:DisableIKArms(1, true);
    task.delay(0.18333333333333332, function() -- Line: 286
        -- upvalues: _animation_hash (copy), u45 (copy), PreloadController (ref)
        if _animation_hash ~= u45._animation_hash or not u45.ClientFighterCharacter:IsAlive() then
            return;
        end;

        local success2, result2 = pcall(u45.ClientFighterCharacter.Humanoid.LoadAnimation, u45.ClientFighterCharacter.Humanoid, PreloadController:GetPreloadedAnimation("SlidingJumpFall"));

        if success2 then
            table.insert(u45._cleanup, result2);
            u45._animation_track = result2;
            u45._animation_track:Play(0);
        end;
    end);
end;

function u1._SetIsAirborne(p48, p49) -- Line: 301
    p48.IsAirborne = p49;
    p48.AirborneChanged:Fire();
end;

function u1._Init(u50) -- Line: 306
    u50.AirborneChanged:Connect(function() -- Line: 307
        -- upvalues: u50 (copy)
        u50:_UpdateAnimation();
        u50:_UpdateEffect();
    end);
    u50.ClientFighterCharacter:GetDataChangedSignal("IsFrozen"):Connect(function() -- Line: 312
        -- upvalues: u50 (copy)
        if u50.ClientFighterCharacter:Get("IsFrozen") then
            u50:Cancel();
        end;
    end);
    u50.ClientFighterCharacter:AddConnection(u50.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByEmotes"):Connect(function() -- Line: 318
        -- upvalues: u50 (copy)
        u50:_UpdateEffect();
    end));
    u50.ClientFighterCharacter:AddConnection(u50.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByCutscene"):Connect(function() -- Line: 322
        -- upvalues: u50 (copy)
        u50:_UpdateEffect();
    end));

    if u50.ClientFighterCharacter.ClientFighter.IsLocalPlayer then
        u50.ClientFighterCharacter:AddConnection(u50.ClientFighterCharacter.Humanoid.StateChanged:Connect(function(p51, p52) -- Line: 327
            -- upvalues: u50 (copy)
            if u50._airborne_velocity and (not u50.ClientFighterCharacter:IsHumanoidStateAirborne(p52) and tick() > u50._airborne_start + 0.1) then
                u50:Cancel();
            end;
        end));

        return;
    end;

    u50.ClientFighterCharacter:GetDataChangedSignal("IsAirborne"):Connect(function() -- Line: 333
        -- upvalues: u50 (copy)
        u50:_UpdateEffect();
    end);
end;

return u1;