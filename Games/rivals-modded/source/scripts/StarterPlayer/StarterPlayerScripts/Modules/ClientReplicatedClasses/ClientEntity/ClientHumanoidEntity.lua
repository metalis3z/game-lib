-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);
local ClientEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc.HeadshotParticles.Attachment;
local Emotes = ReplicatedStorage.Modules.Emotes;
local u1 = setmetatable({}, ClientEntity);
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: ClientEntity (copy), u1 (copy), Signal (copy), Attachment (copy)
    local v3 = ClientEntity.new(p2);
    local v4 = setmetatable(v3, u1);
    v4.EmoteStatusChanged = Signal.new();
    v4.Humanoid = p2.Humanoid;
    v4._headshot_particles = Attachment:Clone();
    v4._animation_cleanup = {};
    v4._current_emote = nil;
    v4:_Init();

    return v4;
end;

function u1.IsEmoting(p5) -- Line: 36
    return p5._current_emote ~= nil;
end;

function u1.IsHumanoidStateAirborne(p6, p7) -- Line: 40
    -- upvalues: CONSTANTS (copy)
    return CONSTANTS.AIRBORNE_HUMANOID_STATES[p7 or p6.Humanoid:GetState()];
end;

function u1.GetCurrentEmote(p8) -- Line: 44
    return p8._current_emote;
end;

function u1.GetHealth(p9) -- Line: 48
    return p9.Humanoid and p9.Humanoid.Health or 0;
end;

function u1.GetMaxHealth(p10) -- Line: 52
    return p10.Humanoid and p10.Humanoid.MaxHealth or 100;
end;

function u1.CancelEmote(p11, p12) -- Line: 56
    local _current_emote = p11._current_emote;

    if not _current_emote then
        return;
    end;

    if p12 and p11._current_emote.ObjectID ~= p12 then
        return;
    end;

    _current_emote:Destroy();
    p11._current_emote = nil;
    p11.EmoteStatusChanged:Fire();
end;

function u1.PlayEmote(p13, p14) -- Line: 72
    -- upvalues: Emotes (copy)
    p13:CancelEmote();

    if not p13:IsAlive() then
        return;
    end;

    local v15 = require(Emotes[p14.Name]).new(p13.Humanoid);
    v15:SetSerial(p14);
    p13._current_emote = v15;
    p13.EmoteStatusChanged:Fire();
    v15:PlayClient();
end;

function u1.ReplicateFromServer(p16, p17, ...) -- Line: 89
    -- upvalues: ClientEntity (copy)
    if p17 == "PlayAnimation" then
        if not p16:IsRendered() then
            return;
        end;

        p16:_PlayAnimation(...);

        return;
    end;

    if p17 == "EmotePlayed" then
        if not p16:IsRendered() then
            return;
        end;

        p16:PlayEmote(...);

        return;
    end;

    if p17 == "EmoteStopped" then
        p16:CancelEmote(...);

        return;
    end;

    ClientEntity.ReplicateFromServer(p16, p17, ...);
end;

function u1.Destroy(p18) -- Line: 109
    -- upvalues: ClientEntity (copy)
    for _, v in pairs(p18._animation_cleanup) do
        v:Destroy();
    end;

    p18._animation_cleanup = {};
    p18.EmoteStatusChanged:Destroy();
    p18:CancelEmote();
    ClientEntity.Destroy(p18);
end;

function u1._PlayAnimation(p19, p20, ...) -- Line: 125
    -- upvalues: PreloadController (copy)
    local v21 = PreloadController:GetPreloadedAnimationID(p20) or p20;
    local v22 = PreloadController:GetPreloadedAnimation(p20) or p19:_CreateAnimation(v21);
    local v23 = p19.Humanoid:LoadAnimation(v22);
    table.insert(p19._animation_cleanup, v23);
    v23:Play(...);
end;

function u1._CreateAnimation(p24, p25) -- Line: 134
    local v26 = typeof(p25) == "string";
    assert(v26, "Argument 1 invalid, expected a string");
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p25;
    table.insert(p24._animation_cleanup, Animation);

    return Animation;
end;

function u1._Setup(u27) -- Line: 144
    local _headshot_particles = u27._headshot_particles;
    local v28 = u27.Model and u27.Model:FindFirstChild("Head");
    _headshot_particles.Parent = v28;

    if u27.Humanoid then
        u27.Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function() -- Line: 148
            -- upvalues: u27 (copy)
            u27.HealthChanged:Fire();
        end);
        u27.Humanoid:GetPropertyChangedSignal("Health"):Connect(function() -- Line: 152
            -- upvalues: u27 (copy)
            u27.HealthChanged:Fire();
        end);
    end;
end;

function u1._Init(p29) -- Line: 158
    p29:_Setup();
end;

return u1;