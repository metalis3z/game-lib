-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 7
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.WarningVignette = v3.FighterInterface.Frame:WaitForChild("WarningVignette");
    v3.WarningVignetteTexture = v3.WarningVignette:WaitForChild("Texture");
    v3.WarningVignetteContainer = v3.WarningVignette:WaitForChild("Container");
    v3.WarningVignetteContainerBackground = v3.WarningVignetteContainer:WaitForChild("Frame"):WaitForChild("Container"):WaitForChild("Background");
    v3._connections = {};
    v3._warning_effect_tweens = {};
    v3:_Init();

    return v3;
end;

function u1.SetEnabled(u4, p5, p6) -- Line: 28
    -- upvalues: TweenService (copy)
    u4:_Cleanup();
    u4.WarningVignette.ImageTransparency = 1;
    u4.WarningVignette.ImageColor3 = Color3.fromRGB(255, 215, 0);
    u4.WarningVignetteTexture.ImageTransparency = 1;
    u4.WarningVignetteContainer.Visible = false;
    u4.WarningVignetteContainerBackground.ImageColor3 = Color3.fromRGB(255, 215, 0);

    if not p5 or p6 >= (1 / 0) then
        return;
    end;

    local TweenInfo_new_ret = TweenInfo.new(p6 / 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
    local TweenInfo_new_ret2 = TweenInfo.new(p6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    local v7 = TweenService:Create(u4.WarningVignette, TweenInfo_new_ret, {
        ImageTransparency = 0
    });
    v7:Play();
    table.insert(u4._warning_effect_tweens, v7);
    local v8 = TweenService:Create(u4.WarningVignette, TweenInfo_new_ret2, {
        ImageColor3 = Color3.fromRGB(255, 50, 50)
    });
    v8:Play();
    table.insert(u4._warning_effect_tweens, v8);
    local v9 = TweenService:Create(u4.WarningVignetteTexture, TweenInfo_new_ret, {
        ImageTransparency = 0
    });
    v9:Play();
    table.insert(u4._warning_effect_tweens, v9);
    local v10 = TweenService:Create(u4.WarningVignetteContainerBackground, TweenInfo_new_ret2, {
        ImageColor3 = Color3.fromRGB(255, 50, 50)
    });
    v10:Play();
    table.insert(u4._warning_effect_tweens, v10);
    local task_spawn_ret = task.spawn(function() -- Line: 60
        -- upvalues: u4 (copy)
        tick();

        while true do
            u4.FighterInterface:CreateSound("rbxassetid://114467311328776", 0.5, 1, script, true, 10);
            u4.WarningVignette.Container.Visible = true;
            wait(0.4);
            u4.WarningVignette.Container.Visible = false;
            wait(0.15);
        end;
    end);
    table.insert(u4._warning_effect_tweens, {
        Cancel = function() -- Line: 72, Name: Cancel
            -- upvalues: task_spawn_ret (copy)
            task.cancel(task_spawn_ret);
        end
    });
end;

function u1.Destroy(p11) -- Line: 75
    for _, v in pairs(p11._connections) do
        v:Disconnect();
    end;

    p11._connections = {};
    p11:_Cleanup();
end;

function u1._Cleanup(p12) -- Line: 89
    for _, v in pairs(p12._warning_effect_tweens) do
        v:Cancel();
    end;

    p12._warning_effect_tweens = {};
end;

function u1._Init(p13) -- Line: 97
end;

return u1;