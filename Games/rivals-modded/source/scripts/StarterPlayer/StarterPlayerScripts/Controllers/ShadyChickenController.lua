-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 15
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._shady_chicken_enabled = false;
    v2:_Init();

    return v2;
end;

function u1._UpdateChickenState(p3, u4) -- Line: 35
    -- upvalues: PlayerDataController (copy), CollectionService (copy), Utility (copy), PreloadController (copy)
    if p3._shady_chicken_enabled or not PlayerDataController:Get("ShadyChickenMissionStarted") then
        return;
    end;

    local u5 = CollectionService:GetTagged("LobbyShadyChicken")[1];

    if not u5 then
        return;
    end;

    p3._shady_chicken_enabled = true;
    task.defer(function() -- Line: 48
        -- upvalues: Utility (ref), u4 (copy), u5 (copy)
        Utility:RenderstepForLoop(0, 100, u4 and 100 or 1, function(p6) -- Line: 49
            -- upvalues: u5 (ref)
            local v7 = p6 / 100;

            for i = 1, 3 do
                u5:WaitForChild("Hologram"):WaitForChild("Neon"):WaitForChild(i).LocalTransparencyModifier = v7;
                local _ = i;
            end;
        end);
    end);

    if not u4 then
        Utility:CreateSound("rbxassetid://92573395473684", 1, 1, script, true, 10);

        for i = 1, 14 do
            local v8 = string.rep("•", i - 1) .. string.sub("ILOVERIVALS628", i, i);
            u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("LoginScreen"):WaitForChild("LoginWindow"):WaitForChild("Login"):WaitForChild("Title").Text = v8;
            wait(0.1847857142857143);
            local _ = i;
        end;

        u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("LoginScreen"):WaitForChild("LoginWindow").Visible = false;
        u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("LoginScreen"):WaitForChild("Dots").Visible = true;
        u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("LoginScreen"):WaitForChild("Dots"):AddTag("UILoadingDots");
        wait(4);
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
        Utility:CreateSound("rbxassetid://85855678277731", 1.5, 1, script, true, 5);
    end;

    u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("LoginScreen"):WaitForChild("Dots"):RemoveTag("UILoadingDots");
    u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("LoginScreen").Visible = false;
    u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("ErrorScreen").Visible = true;
    u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceLight").Color = Color3.fromRGB(255, 50, 50);
    u5:WaitForChild("Pad"):WaitForChild("Part"):WaitForChild("SurfaceGui"):WaitForChild("ImageLabel").ImageColor3 = Color3.fromRGB(255, 50, 50);

    if not u4 then
        task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 2, function(p9) -- Line: 86
            -- upvalues: u5 (copy)
            local v10 = 40 * (1 - (p9 / 100) ^ 2);
            local UDim2_new_ret = UDim2.new(0.5, v10 * (math.random() - 0.5), 0.5, v10 * 0.25 * (math.random() - 0.5));
            u5:WaitForChild("Screen"):WaitForChild("Board"):WaitForChild("SurfaceGui"):WaitForChild("ErrorScreen"):WaitForChild("LoginWindow").Position = UDim2_new_ret;
        end);
        wait(1.5);
    end;

    pcall(function() -- Line: 96
        -- upvalues: u5 (copy), PreloadController (ref)
        u5:WaitForChild("Rig"):WaitForChild("Humanoid"):LoadAnimation(PreloadController:GetPreloadedAnimation("ShadyChickenIdle")):Play(0);
    end);
    u5:WaitForChild("Vent"):WaitForChild("Broken").Transparency = 0;
    u5:WaitForChild("Vent"):WaitForChild("NotBroken"):Destroy();

    if not u4 then
        Utility:PlayParticles(u5:WaitForChild("Vent"):WaitForChild("VFX"));
        Utility:CreateSound("rbxassetid://73297732048740", 2, 1, script, true, 10);
        Utility:CreateSound("rbxassetid://122754850804619", 1, 1, script, true, 10);
        pcall(function() -- Line: 108
            -- upvalues: u5 (copy), PreloadController (ref)
            u5:WaitForChild("Rig"):WaitForChild("Humanoid"):LoadAnimation(PreloadController:GetPreloadedAnimation("ShadyChickenAppear")):Play(0);
        end);
        wait(2);
        wait(5);
    end;

    u5:WaitForChild("Prompt"):WaitForChild("ProximityPrompt").MaxActivationDistance = 16;
end;

function u1._ChickenAdded(p11, u12) -- Line: 122
    -- upvalues: PreloadController (copy)
    pcall(function() -- Line: 123
        -- upvalues: u12 (copy), PreloadController (ref)
        u12:WaitForChild("Rig"):WaitForChild("Humanoid"):LoadAnimation(PreloadController:GetPreloadedAnimation("ShadyChickenIdleVent")):Play(0);
    end);
end;

function u1._UpdateLoginPrompts(p13) -- Line: 128
    -- upvalues: PlayerDataController (copy), CollectionService (copy)
    local v14 = PlayerDataController:Get("ShadyChickenMissionStarted") and 0 or 16;

    for _, v in pairs(CollectionService:GetTagged("LobbyShadyChickenPrompt")) do
        v.MaxActivationDistance = v14;
    end;
end;

function u1._LoginPromptAdded(p15, p16) -- Line: 136
    -- upvalues: ReplicatedStorage (copy)
    p16.Triggered:Connect(function() -- Line: 137
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Misc.StartShadyChickenMission:FireServer();
    end);
    p15:_UpdateLoginPrompts();
end;

function u1._Init(p17) -- Line: 144
end;

return u1._new();