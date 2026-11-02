-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 12
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.DamageVignette = v3.FighterInterface.Frame:WaitForChild("DamageVignette");
    v3.DamageVignettePermanent = v3.DamageVignette:WaitForChild("Permanent");
    v3.HealVignette = v3.FighterInterface.Frame:WaitForChild("HealVignette");
    v3.Frame = v3.FighterInterface.BottomRight.Container:WaitForChild("Health");
    v3.ContainerFrame = v3.Frame:WaitForChild("Container");
    v3.ContainerBackground = v3.ContainerFrame:WaitForChild("Background");
    v3.ContainerBar = v3.ContainerFrame:WaitForChild("Bar");
    v3.ContainerBarText = v3.ContainerBar:WaitForChild("Value"):WaitForChild("Title");
    v3._last_health_tween = nil;
    v3._last_health_alpha = nil;
    v3._hurt_effect_hash = 0;
    v3._heal_effect_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.HurtEffect(u4, u5) -- Line: 40
    -- upvalues: Utility (copy)
    if not u4.FighterInterface:IsActive() then
        return;
    end;

    local v6 = u5[utf8.char(0)] / u4.FighterInterface.ClientFighter.Entity.Humanoid.Health;

    if v6 == 0 then
        return;
    end;

    task.spawn(function() -- Line: 51
        -- upvalues: u4 (copy), u5 (copy)
        u4.FighterInterface.DamageIndicators:Create(u5);
    end);
    u4._hurt_effect_hash = u4._hurt_effect_hash + 1;
    local _hurt_effect_hash = u4._hurt_effect_hash;
    local u7 = 0.5 - 0.5 * v6;
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 4, function(p8) -- Line: 61
        -- upvalues: _hurt_effect_hash (copy), u4 (copy), u7 (copy)
        if _hurt_effect_hash ~= u4._hurt_effect_hash then
            return true;
        end;

        u4.DamageVignette.ImageTransparency = u7 + (1 - u7) * (p8 / 100);
    end);
end;

function u1.HealEffect(u9, p10) -- Line: 72
    -- upvalues: Utility (copy)
    if not u9.FighterInterface:IsActive() then
        return;
    end;

    u9._heal_effect_hash = u9._heal_effect_hash + 1;
    local _heal_effect_hash = u9._heal_effect_hash;
    local math_clamp_ret = math.clamp(p10 / 10, 0, 1);
    u9.FighterInterface:CreateSound("rbxassetid://17138490999", math_clamp_ret * 0.5, 1, script, true, 10);
    local u11 = 1 - math_clamp_ret * 1;
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 4, function(p12) -- Line: 86
        -- upvalues: _heal_effect_hash (copy), u9 (copy), u11 (copy)
        if _heal_effect_hash ~= u9._heal_effect_hash then
            return true;
        end;

        u9.HealVignette.ImageTransparency = u11 + (1 - u11) * (p12 / 100);
    end);
end;

function u1.UpdateParent(u13) -- Line: 97
    -- upvalues: PlayerDataController (copy)
    task.defer(pcall, function() -- Line: 98
        -- upvalues: u13 (copy), PlayerDataController (ref)
        u13.Frame.Visible = PlayerDataController:GetSetting("Health Bar Display") ~= "Disabled";
        u13.Frame.Parent = PlayerDataController:GetSetting("Health Bar Display") == "Bottom Center" and u13.FighterInterface.BottomCenter.Container or (PlayerDataController:GetSetting("Health Bar Display") == "Bottom Left" and u13.FighterInterface.BottomLeft.Container or u13.FighterInterface.BottomRight.Container);
    end);
end;

function u1.Refresh(p14) -- Line: 106
    if p14.FighterInterface.BottomLeft.Frame.Visible then
        p14:_Update();

        return;
    end;

    p14.DamageVignettePermanent.ImageTransparency = 1;
end;

function u1.Destroy(p15) -- Line: 115
    p15._hurt_effect_hash = p15._hurt_effect_hash + 1;
    p15._heal_effect_hash = p15._heal_effect_hash + 1;
end;

function u1._Update(p16, p17) -- Line: 124
    -- upvalues: Utility (copy), TweenService (copy)
    if p16._last_health_tween then
        p16._last_health_tween:Pause();
        p16._last_health_tween = nil;
    end;

    local v18 = p16.FighterInterface.ClientFighter:Get("IsAprilFools");
    local MaxHealth = p16.FighterInterface.ClientFighter:GetMaxHealth();
    local v19;

    if v18 then
        local math_min_ret = math.min(1, MaxHealth);
        local v20 = MaxHealth * math.random();
        v19 = math.max(math_min_ret, v20);
    else
        v19 = p16.FighterInterface.ClientFighter:GetHealth();
    end;

    local math_clamp_ret = math.clamp(v19 / MaxHealth, 0, 1);
    local v21 = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(255, 215, 0):Lerp(Color3.fromRGB(100, 255, 50), math_clamp_ret), math_clamp_ret);
    local Color3_new_ret = Color3.new(v21.R / 2, v21.G / 2, v21.B / 2);
    local Color3_new_ret2 = Color3.new(v21.R / 3, v21.G / 3, v21.B / 3);
    p16.DamageVignettePermanent.ImageTransparency = math_clamp_ret > 0.5 and 1 or math_clamp_ret * 2;
    p16.ContainerFrame.BackgroundColor3 = Color3_new_ret;
    p16.ContainerBackground.BackgroundColor3 = Color3_new_ret2;
    p16.ContainerBar.BackgroundColor3 = v21;
    p16.ContainerBar.Visible = math_clamp_ret > 0;
    p16.ContainerBarText.Text = v19 >= 1 and Utility:PrettyNumber((math.ceil(v19))) or "";
    local UDim2_new_ret = UDim2.new(math.max(0.073, math_clamp_ret), 0, 1, 0);

    if p17 then
        p16.ContainerBar.Size = UDim2_new_ret;
    else
        p16._last_health_tween = TweenService:Create(p16.ContainerBar, TweenInfo.new(0.5 / (p16._last_health_alpha and math_clamp_ret >= p16._last_health_alpha and 0.5 or 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2_new_ret
        });
        p16._last_health_tween:Play();
    end;

    p16._last_health_alpha = math_clamp_ret;
end;

function u1._Setup(p22) -- Line: 159
    -- upvalues: GuiService (copy)
    local UDim2_new_ret = UDim2.new(1, 0, 1, GuiService:GetGuiInset().Y);
    p22.HealVignette.Size = UDim2_new_ret;
    p22.DamageVignette.Size = UDim2_new_ret;
end;

function u1._Init(u23) -- Line: 166
    u23.FighterInterface.BottomLeft.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 167
        -- upvalues: u23 (copy)
        u23:Refresh();
    end);
    u23:_Setup();
    u23:_Update(true);
    u23:UpdateParent();
end;

return u1;