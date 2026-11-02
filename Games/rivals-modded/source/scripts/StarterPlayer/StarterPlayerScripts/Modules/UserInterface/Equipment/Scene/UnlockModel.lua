-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local UnlockParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.UnlockParticles;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.UnlockingChanged = Signal.new();
    v3.Scene = p2;
    v3.Model = v3.Scene.Model:WaitForChild("UnlockEffect");
    v3.IsUnlocking = false;
    v3._animation_controller = v3.Model:WaitForChild("AnimationController");
    v3._original_cframe = v3.Model:GetPivot();
    v3._idle_animation_loaded = false;
    v3._animation_track = nil;
    v3._animation_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.StopAnimation(p4, p5) -- Line: 40
    p4:_SetIsUnlocking(false);
    p4._animation_hash = p4._animation_hash + 1;

    if p4._animation_track then
        p4._animation_track:Stop(0);
    end;
end;

function u1.PlayAnimation(p6) -- Line: 49
    p6:StopAnimation(true);
    p6:_SetIsUnlocking(true);
    local success, result = pcall(p6._PlayAnimationAsync, p6);

    if not success then
        warn("Unlock animation failed, error:", result);
    end;

    p6:_SetIsUnlocking(false);
end;

function u1.OnStateChanged(p7) -- Line: 62
    p7:_PlayIdleAnimation();
    p7:_UpdateCFrame();
    p7:StopAnimation();
end;

function u1.OnOpen(p8) -- Line: 68
    p8:_PlayIdleAnimation();
end;

function u1._PlayAnimationAsync(p9) -- Line: 76
    -- upvalues: Utility (copy), PreloadController (copy), BetterDebris (copy), UnlockParticles (copy)
    p9._animation_hash = p9._animation_hash + 1;
    local _animation_hash = p9._animation_hash;
    p9.Model.Key.a1.Trail.Enabled = true;
    Utility:CreateSound("rbxassetid://17662575024", 1.5, 1, script, true, 5);

    if not p9._animation_track then
        p9._animation_track = p9._animation_controller:LoadAnimation(PreloadController:GetPreloadedAnimation("WeaponUnlockPlay"));
    end;

    p9._animation_track:Play(0);
    wait(2.25);

    if _animation_hash ~= p9._animation_hash then
        return;
    end;

    Utility:CreateSound("rbxassetid://17662574898", 1.5, 1, script, true, 5);
    wait(0.25);

    if _animation_hash ~= p9._animation_hash then
        return;
    end;

    p9.Model.Key.a1.Trail.Enabled = false;
    Utility:CreateSound("rbxassetid://17662575175", 1, 1, script, true, 5);
    Utility:PlayParticles(p9.Model.ChainsHolder.Attachment);
    wait(1);

    if _animation_hash ~= p9._animation_hash then
        return;
    end;

    Utility:CreateSound("rbxassetid://17662623697", 1.5, 1, script, true, 5);
    local BoundingBox, v10 = p9.Scene.Equipment.FloatingModel:GetBoundingBox();
    local Part = Instance.new("Part");
    Part.CFrame = BoundingBox;
    Part.Size = v10;
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 10);

    for _, child in pairs(UnlockParticles:GetChildren()) do
        local v11 = child:Clone();
        v11.Parent = Part;
        task.delay(child:GetAttribute("EmitDelay") or 0, v11.Emit, v11, child:GetAttribute("EmitCount"));
    end;
end;

function u1._PlayIdleAnimation(u12) -- Line: 135
    -- upvalues: PreloadController (copy)
    u12._idle_animation_loaded = false;

    for i = 1, 3 do
        local success, result = pcall(function() -- Line: 139
            -- upvalues: u12 (copy), PreloadController (ref)
            u12._animation_controller:LoadAnimation(PreloadController:GetPreloadedAnimation("WeaponUnlockIdle")):Play(0);
        end);

        if success then
            u12._idle_animation_loaded = true;

            return;
        end;

        warn("Failed to load unlock model idle, error", result);
        local _ = i;
    end;
end;

function u1._UpdateCFrame(p13) -- Line: 152
    -- upvalues: PlayerDataController (copy), Pages (copy)
    local SelectedWeapon = p13.Scene.Equipment:GetSelectedWeapon();

    if SelectedWeapon then
        SelectedWeapon = not PlayerDataController:GetWeaponData(SelectedWeapon);
    end;

    p13.Model:PivotTo(SelectedWeapon and (not Pages.PageSystem.CurrentPage and p13._idle_animation_loaded) and p13._original_cframe or CFrame.identity);
end;

function u1._UpdateKey(p14) -- Line: 160
    local v15 = p14.IsUnlocking and 0 or 1;
    p14.Model.Key.LocalTransparencyModifier = v15;
    p14.Model.Key.a1.Trail.LocalTransparencyModifier = v15;
    p14.Model.Key.sparkle.LocalTransparencyModifier = v15;
end;

function u1._SetIsUnlocking(p16, p17) -- Line: 168
    if p16.IsUnlocking == p17 then
        return;
    end;

    p16.IsUnlocking = p17;
    p16.UnlockingChanged:Fire();
end;

function u1._Init(u18) -- Line: 177
    -- upvalues: PlayerDataController (copy), Pages (copy)
    u18.UnlockingChanged:Connect(function() -- Line: 178
        -- upvalues: u18 (copy)
        u18:_UpdateKey();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 182
        -- upvalues: u18 (copy)
        u18:_UpdateCFrame();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 186
        -- upvalues: u18 (copy)
        u18:_UpdateCFrame();
    end);
    u18:_UpdateKey();
end;

return u1;