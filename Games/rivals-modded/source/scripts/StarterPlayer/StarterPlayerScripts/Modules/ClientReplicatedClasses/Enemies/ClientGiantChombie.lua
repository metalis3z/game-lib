-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local SlamParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.SlamParticles;
local u1 = { "rbxassetid://72483809453170", "rbxassetid://129922197154277", "rbxassetid://113975047764762" };
local u2 = setmetatable({}, ClientEnemy);
u2.__index = u2;

function u2.new(...) -- Line: 21
    -- upvalues: ClientEnemy (copy), u2 (copy), SoundLibrary (copy), u1 (copy)
    local v3 = ClientEnemy.new(...);
    local v4 = setmetatable(v3, u2);
    v4._slam_vulnerable_animation = v4:_CreateAnimation("rbxassetid://129758877701887");
    v4._slam_animation = v4:_CreateAnimation("rbxassetid://97481875605208");
    v4._preloaded_sounds = SoundLibrary:PreloadSounds(u1, nil, "rbxassetid://98587858115094");
    v4:_Init();

    return v4;
end;

function u2.ReplicateFromServer(p5, p6, ...) -- Line: 37
    -- upvalues: Utility (copy), CameraController (copy), SlamParticles (copy), BetterDebris (copy), u1 (copy), ClientEnemy (copy)
    if p6 ~= "SlamEffect" then
        ClientEnemy.ReplicateFromServer(p5, p6, ...);

        return;
    end;

    if not p5:IsRendered() then
        return;
    end;

    local v7, v8, v9, v10, v11 = ...;
    local v12;

    if v11 then
        v12 = p5._slam_vulnerable_animation;
    else
        v12 = p5._slam_animation;
    end;

    local success, result = pcall(p5.Humanoid.LoadAnimation, p5.Humanoid, v12);

    if success then
        table.insert(p5._animation_cleanup, result);
        result:Play();
    end;

    wait(v9);
    Utility:CreateSound("rbxassetid://98587858115094", 0.875 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5.RootPart, true, 10, 400, 400);
    wait(v10);

    if not p5:IsAlive() then
        return;
    end;

    local math_max_ret = math.max(0, 1 - (p5.RootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude / 400);
    CameraController:ShakeOnce(math_max_ret * 50, math_max_ret * 10, 0.1, 0.4, Vector3.new(1, 1, 0), Vector3.new(0, 0, 0));
    local v13 = SlamParticles:Clone();
    v13.CFrame = CFrame.new(v7) + Vector3.new(0, 0.1, 0);
    v13.Parent = workspace;
    BetterDebris:AddItem(v13, 10);
    Utility:ScaleParticleEmitter(v13, v8 / 32);
    Utility:PlayParticles(v13);

    for _, v in pairs(u1) do
        Utility:CreateSound(v, 0.875 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p5.RootPart, true, 10, 400, 400);
    end;
end;

function u2.Destroy(p14) -- Line: 82
    -- upvalues: ClientEnemy (copy)
    for _, v in pairs(p14._preloaded_sounds) do
        v:Destroy();
    end;

    ClientEnemy.Destroy(p14);
end;

function u2._Setup(p15) -- Line: 94
    -- upvalues: ContentProvider (copy)
    task.spawn(pcall, ContentProvider.PreloadAsync, ContentProvider, { p15._slam_animation, p15._slam_vulnerable_animation });
end;

function u2._Init(p16) -- Line: 98
    p16:_Setup();
end;

return u2;