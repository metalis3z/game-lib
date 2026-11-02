-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.MonetizationLibrary);
local Spring = require(ReplicatedStorage.Modules.Spring);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("StaticModel"):WaitForChild("StaticViewModel"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local LooseWeaponDisplayParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("LooseWeaponDisplayParticles");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.Model = p2;
    v3.CurrentWeapon = nil;
    v3._primary = v3.Model:WaitForChild("Primary");
    v3._owned_model = v3.Model:WaitForChild("Owned");
    v3._origin = v3._primary.CFrame;
    v3._static_viewmodel = nil;
    v3._proximity_prompt = Instance.new("ProximityPrompt");
    v3._is_animating = nil;
    v3._animation_tick = 0;
    v3._spin_spring = Spring.new(1, 1, 5);
    v3._return_to_normal_progress = 1;
    v3._return_to_normal_start = v3._origin;
    v3._scale = 1;
    v3._proximity_prompt_object_text = nil;
    v3._proximity_prompt_action_text = nil;
    v3._proximity_prompt_next_update = 0;
    v3._is_locked = false;
    v3:_Init();

    return v3;
end;

function u1.SetScale(p4, p5) -- Line: 47
    p4._scale = p5;

    if p4._static_viewmodel then
        p4._static_viewmodel:ScaleTo(3 * p4._scale);
    end;
end;

function u1.SetProximityPromptData(p6, p7, p8) -- Line: 55
    p6._proximity_prompt_object_text = p7;
    p6._proximity_prompt_action_text = p8;
    p6:_UpdateProximityPrompt();
end;

function u1.SetLocked(p9, p10) -- Line: 61
    if p10 == p9._is_locked then
        return;
    end;

    p9._is_locked = p10;

    if p9._static_viewmodel then
        p9._static_viewmodel:SetLocked(p9._is_locked);
    end;
end;

function u1.ChangeWeapon(p11, p12) -- Line: 73
    -- upvalues: StaticViewModel (copy)
    p11.CurrentWeapon = p11.Model:GetAttribute("PriorityWeapon") or (p12 or nil);

    if p11._static_viewmodel then
        p11._static_viewmodel:Destroy();
        p11._static_viewmodel = nil;
    end;

    p11._owned_model.Parent = p11.Model;
    p11._proximity_prompt.Parent = nil;
    p11._proximity_prompt:RemoveTag("LobbyOpenPagePrompt");
    p11._proximity_prompt:SetAttribute("PageName", nil);
    p11._proximity_prompt:SetAttribute("ShopViewBundleName", nil);

    if not p11.CurrentWeapon then
        p11:_SetAnimating(false);

        return;
    end;

    p11._owned_model.Parent = nil;
    p11._static_viewmodel = StaticViewModel.new(p11.CurrentWeapon);
    p11._static_viewmodel:DeleteAnimationContextSubModels("ShowInEquipment");
    p11._static_viewmodel:ScaleTo(3 * p11._scale);
    p11._static_viewmodel:SetLocked(p11._is_locked);
    p11._static_viewmodel:PivotTo(p11._origin);
    p11._static_viewmodel:SetParent(p11.Model);
    p11:_SetAnimating(false);
    p11._proximity_prompt.Parent = p11._primary;
    p11:_UpdateProximityPrompt();
end;

function u1.Update(p13, p14) -- Line: 107
    -- upvalues: TweenService (copy)
    if not p13._is_animating then
        if p13._static_viewmodel and p13._return_to_normal_progress < 1 then
            p13._return_to_normal_progress = math.min(1, p13._return_to_normal_progress + p14 * 0.25);
            p13._static_viewmodel:PivotTo(p13._return_to_normal_start:Lerp(p13._origin, TweenService:GetValue(p13._return_to_normal_progress, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)));
        end;

        return;
    end;

    p13._animation_tick = p13._animation_tick + p14 * 0.5;
    local CFrame_Angles_ret = CFrame.Angles(0, p13._spin_spring.Value * 3.141592653589793 * 2 + p13._animation_tick % 6.283185307179586, 0);
    local Vector3_new_ret = Vector3.new(0, p13._spin_spring.Value, 0);
    p13._static_viewmodel:PivotTo(p13._origin * p13._primary.CFrame.Rotation:Inverse() * CFrame_Angles_ret * p13._primary.CFrame.Rotation + Vector3_new_ret);

    if p13._static_viewmodel then
        p13._static_viewmodel:Update(p14);
    end;

    if tick() > p13._proximity_prompt_next_update then
        p13._proximity_prompt_next_update = tick() + 1;
        p13:_UpdateProximityPrompt();
    end;
end;

function u1._UpdateProximityPrompt(p15) -- Line: 138
    p15._proximity_prompt.ObjectText = typeof(p15._proximity_prompt_object_text) == "function" and p15._proximity_prompt_object_text() or p15._proximity_prompt_object_text or (p15.CurrentWeapon or "");
    p15._proximity_prompt.ActionText = typeof(p15._proximity_prompt_action_text) == "function" and p15._proximity_prompt_action_text() or (p15._proximity_prompt_action_text or "View");
end;

function u1._SetAnimating(p16, p17) -- Line: 143
    p16._is_animating = p17;

    if p17 then
        p16._spin_spring.Value = 0;
        p16._animation_tick = 0;
    else
        p16._return_to_normal_progress = 0;
        p16._return_to_normal_start = p16._static_viewmodel and p16._static_viewmodel:GetPivot() or CFrame.identity;
    end;

    for _, descendant in pairs(p16._primary:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p17;
        end;
    end;

    p16:_UpdateProximityPrompt();
end;

function u1._Setup(p18) -- Line: 163
    -- upvalues: LooseWeaponDisplayParticles (copy)
    p18._proximity_prompt.ClickablePrompt = true;
    p18._proximity_prompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton;
    p18._proximity_prompt.GamepadKeyCode = Enum.KeyCode.ButtonX;
    p18._proximity_prompt.HoldDuration = 0;
    p18._proximity_prompt.MaxActivationDistance = 10;
    p18._proximity_prompt.KeyboardKeyCode = Enum.KeyCode.Q;
    p18._proximity_prompt.RequiresLineOfSight = false;
    p18._proximity_prompt.Style = Enum.ProximityPromptStyle.Custom;
    local _primary = p18._primary;
    _primary.CFrame = _primary.CFrame + Vector3.new(0, 2.5, 0);

    for _, child in pairs(LooseWeaponDisplayParticles:GetChildren()) do
        child:Clone().Parent = p18._primary;
    end;
end;

function u1._Init(u19) -- Line: 180
    -- upvalues: Equipment (copy)
    u19._proximity_prompt.Triggered:Connect(function() -- Line: 181
        -- upvalues: Equipment (ref), u19 (copy)
        Equipment:Open();
        Equipment:SelectWeapon(u19.CurrentWeapon);
    end);
    u19._proximity_prompt.PromptShown:Connect(function() -- Line: 186
        -- upvalues: u19 (copy)
        u19:_SetAnimating(true);
    end);
    u19._proximity_prompt.PromptHidden:Connect(function() -- Line: 190
        -- upvalues: u19 (copy)
        u19:_SetAnimating(false);
    end);
    u19:_Setup();
    u19:_UpdateProximityPrompt();
    u19:ChangeWeapon(nil);
end;

return u1;