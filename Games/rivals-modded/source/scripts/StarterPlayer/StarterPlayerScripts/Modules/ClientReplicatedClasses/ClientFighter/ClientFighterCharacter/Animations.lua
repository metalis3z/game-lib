-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local AnimationOverrides = require(ReplicatedStorage.Modules.AnimationOverrides);
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);
local u1 = {
    idle = "rbxassetid://17702749856",
    run = "rbxassetid://17702824140",
    walk = "rbxassetid://17702824140",
    runBack = "rbxassetid://17703291282",
    walkBack = "rbxassetid://17703291282",
    runForwardLeft = "rbxassetid://17703649282",
    walkForwardLeft = "rbxassetid://17703649282",
    runBackwardLeft = "rbxassetid://17703612699",
    walkBackwardLeft = "rbxassetid://17703612699",
    runLeft = "rbxassetid://17703296049",
    runLeft2 = "rbxassetid://17703296049",
    walkLeft = "rbxassetid://17703296049",
    walkLeft2 = "rbxassetid://17703296049",
    runForwardRight = "rbxassetid://17703652486",
    walkForwardRight = "rbxassetid://17703652486",
    runBackwardRight = "rbxassetid://17703646109",
    walkBackwardRight = "rbxassetid://17703646109",
    runRight = "rbxassetid://17703299653",
    runRight2 = "rbxassetid://17703299653",
    walkRight = "rbxassetid://17703299653",
    walkRight2 = "rbxassetid://17703299653"
};
local u2 = {
    Start = { { "SlidingStartForward", "LookVector", 1 }, { "SlidingStartRightward", "RightVector", 1 }, { "SlidingStartBackward", "LookVector", -1 }, { "SlidingStartLeftward", "RightVector", -1 } },
    Loop = { { "SlidingLoopForward", "LookVector", 1 }, { "SlidingLoopRightward", "RightVector", 1 }, { "SlidingLoopBackward", "LookVector", -1 }, { "SlidingLoopLeftward", "RightVector", -1 } }
};
local u3 = {};
u3.__index = u3;

function u3.new(p4) -- Line: 66
    -- upvalues: u3 (copy)
    local v5 = setmetatable({}, u3);
    v5.ClientFighterCharacter = p4;
    v5._original_humanoid_animations = {};
    v5._sliding_animation_hash = 0;
    v5._sliding_animation_track = nil;
    v5:_Init();

    return v5;
end;

function u3.PlaySlidingAnimationAsync(p6, p7) -- Line: 84
    -- upvalues: PreloadController (copy), RunService (copy)
    p6:StopSlidingAnimation();

    if not p6.ClientFighterCharacter.ClientFighter.IsLocalPlayer then
        return;
    end;

    p6._sliding_animation_hash = p6._sliding_animation_hash + 1;
    local _sliding_animation_hash = p6._sliding_animation_hash;
    local v8 = p6:_GetSlidingAnimation("Start", p7);

    if v8 then
        v8 = v8[1];
    end;

    local success, result = pcall(p6.ClientFighterCharacter.Humanoid.LoadAnimation, p6.ClientFighterCharacter.Humanoid, PreloadController:GetPreloadedAnimation(v8));

    if success then
        p6._sliding_animation_track = result;
        p6._sliding_animation_track:Play();
        wait(0.4);
    end;

    if _sliding_animation_hash ~= p6._sliding_animation_hash then
        return;
    end;

    local v9 = nil;

    while _sliding_animation_hash == p6._sliding_animation_hash do
        local v10 = p6:_GetSlidingAnimation("Loop", p7);

        if v10 and v10[1] ~= v9 then
            v9 = v10[1];

            if p6._sliding_animation_track then
                p6._sliding_animation_track:Stop(0);
                p6._sliding_animation_track:Destroy();
                p6._sliding_animation_track = nil;
            end;

            local success2, result2 = pcall(p6.ClientFighterCharacter.Humanoid.LoadAnimation, p6.ClientFighterCharacter.Humanoid, PreloadController:GetPreloadedAnimation(v9));

            if success2 then
                p6._sliding_animation_track = result2;
                p6._sliding_animation_track:Play(0);
            end;
        end;

        RunService.RenderStepped:Wait();
    end;
end;

function u3.StopSlidingAnimation(p11) -- Line: 134
    p11._sliding_animation_hash = p11._sliding_animation_hash + 1;

    if p11._sliding_animation_track then
        p11._sliding_animation_track:Stop(0);
        p11._sliding_animation_track = nil;
    end;
end;

function u3.Update(p12, p13, p14) -- Line: 143
end;

function u3.Destroy(p15) -- Line: 147
    p15:StopSlidingAnimation();
end;

function u3._GetSlidingAnimation(p16, p17, p18) -- Line: 155
    -- upvalues: u2 (copy), Utility (copy)
    local v19 = p18 * Vector3.new(1, 0, 1);
    p16.ClientFighterCharacter.ClientFighter:GetRotationCFrame();
    local v20 = (1 / 0);
    local v21 = nil;

    for _, v in pairs(u2[p17]) do
        local v22 = Utility:AngleBetweenVectors(v19, p16.ClientFighterCharacter.ClientFighter:GetRotationCFrame()[v[2]] * v[3] * Vector3.new(1, 0, 1));

        if v22 < v20 then
            v21 = v;
            v20 = v22;
        end;
    end;

    return v21;
end;

function u3._UpdateHumanoidAnimations(p23) -- Line: 174
    -- upvalues: u1 (copy)
    if not (p23.ClientFighterCharacter.ClientFighter.IsLocalPlayer and p23.ClientFighterCharacter:IsInWorld()) then
        return;
    end;

    local Animate = p23.ClientFighterCharacter.Model:FindFirstChild("Animate");

    if not Animate then
        return;
    end;

    local v24 = p23.ClientFighterCharacter.ClientFighter:Get("IsCrouching");

    for i, v in pairs(u1) do
        local v25 = Animate:FindFirstChild(i);

        if v25 then
            local v26 = v24 and AnimationOverrides.Get("Crouch_" .. i, v) or nil;

            for _, child in pairs(v25:GetChildren()) do
                p23._original_humanoid_animations[child] = p23._original_humanoid_animations[child] or child.AnimationId;
                child.AnimationId = v26 or p23._original_humanoid_animations[child];
            end;
        end;
    end;

    if Animate:FindFirstChild("Refresh") then
        Animate.Refresh:Fire();
    end;
end;

function u3._Init(u27) -- Line: 207
    u27.ClientFighterCharacter.EnteredWorld:Connect(function() -- Line: 208
        -- upvalues: u27 (copy)
        u27:_UpdateHumanoidAnimations();
    end);
    u27.ClientFighterCharacter.Died:Connect(function() -- Line: 212
        -- upvalues: u27 (copy)
        u27:StopSlidingAnimation();
    end);
    u27.ClientFighterCharacter:AddConnection(u27.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsCrouching"):Connect(function() -- Line: 216
        -- upvalues: u27 (copy)
        u27:_UpdateHumanoidAnimations();
    end));
    u27:_UpdateHumanoidAnimations();
end;

return u3;