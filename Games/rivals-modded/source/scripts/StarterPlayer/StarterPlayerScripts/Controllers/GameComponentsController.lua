-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local GameComponents = game:GetService("Players").LocalPlayer.PlayerScripts.Modules:WaitForChild("GameComponents");
local u1 = { "FlickeringLights", "SmokeClouds", "FireHitboxes", "CustomKnockbackParts", "UISparkleEffects", "UILoadingDots", "UIBackgrounds", "UIInputFrames", "UIKeybinds", "OpenPagePrompts", "SnowballPrompts", "OutOfBoundsParts", "UserIDsFilter", "JumpPads", "SubspaceTripmines", "UIShinyTexts", "UIGlitchEffects", "PortalModels", "Vortexes", "OneWayFloors", "SoundTriggers" };
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 18
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3.Components = {};
    v3:_Init();

    return v3;
end;

function u2._Setup(u4) -- Line: 38
    -- upvalues: u1 (copy), GameComponents (copy)
    for _, v in pairs(u1) do
        task.spawn(function() -- Line: 40
            -- upvalues: u4 (copy), v (copy), GameComponents (ref)
            u4.Components[v] = require(GameComponents:WaitForChild(v));
        end);
    end;
end;

function u2._Init(u5) -- Line: 46
    -- upvalues: RunService (copy)
    RunService.Heartbeat:Connect(function(p6) -- Line: 47
        -- upvalues: u5 (copy)
        for _, v in pairs(u5.Components) do
            if v.Update then
                v:Update(p6);
            end;
        end;
    end);
    u5:_Setup();
end;

return u2._new();