-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local BowChargeEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc.BowChargeEffects;
local u1 = {
    Color3.fromRGB(191, 191, 191),
    Color3.fromRGB(100, 255, 50),
    Color3.fromRGB(255, 180, 0),
    Color3.fromRGB(255, 50, 50)
};
local u2 = setmetatable({}, ClientViewModel);
u2.__index = u2;

function u2.new(...) -- Line: 11
    -- upvalues: ClientViewModel (copy), u2 (copy)
    local v3 = ClientViewModel.new(...);
    local v4 = setmetatable(v3, u2);
    v4._charge_attachment = v4.Model:FindFirstChild("_bow_charge", true);
    v4._charge_particles = {};
    v4._visibility_delayed = nil;
    v4._charm_attachment_parent = v4._charm_pivot_attachment and v4._charm_pivot_attachment.Parent;
    v4._registered_ammo_visuals = {};
    v4:_Init();

    return v4;
end;

function u2.GetChargeColor(p5, p6) -- Line: 29
    -- upvalues: u1 (copy)
    return u1[p6];
end;

function u2.PlayChargeSound(p7, p8) -- Line: 33
    p7:CreateSound("rbxassetid://13744359504", 1, 0.75 + 0.25 * p8, true, 10);
end;

function u2.PlayChargeEffect(p9, p10) -- Line: 37
    p9:PlayChargeSound(p10);

    for _, v in pairs(p9._charge_particles) do
        v.Color = ColorSequence.new(p9:GetChargeColor(p10));
        v:Emit(1);
    end;
end;

function u2._UpdateArrow(p11) -- Line: 50
    if p11._destroyed then
        return;
    end;

    local v12;

    if p11.ClientItem:Get("Ammo") > 0 then
        v12 = true;
    else
        v12 = p11:IsAnimationPlaying("Reload") or p11:IsAnimationPlaying("Shoot1") or p11:IsAnimationPlaying("ChargeRelease") and p11.ClientItem:Get("AmmoReserve") > 0;
    end;

    if v12 and not p11._visibility_delayed then
        p11._visibility_delayed = true;
        wait(0.1);
        p11:_UpdateArrow();

        return;
    end;

    if p11._charm_pivot_attachment then
        local v13;

        if v12 then
            v13 = p11._charm_attachment_parent or nil;
        else
            v13 = nil;
        end;

        p11._charm_pivot_attachment.Parent = v13;
    end;

    local v14 = v12 and 0 or 1;

    for _, v in pairs(p11._registered_ammo_visuals) do
        p11:_LocalTransparencyModifier(v, "AmmoVisual", v14);
    end;

    p11._visibility_delayed = nil;
end;

function u2._RegisterAmmoVisual(p15, p16) -- Line: 80
    table.insert(p15._registered_ammo_visuals, p16);
end;

function u2._Setup(p17) -- Line: 84
    -- upvalues: BowChargeEffects (copy)
    for _, child in pairs((BowChargeEffects:FindFirstChild(p17.Name) or BowChargeEffects.Default).Attachment:GetChildren()) do
        local v18 = child:Clone();
        v18.Parent = p17._charge_attachment;
        table.insert(p17._charge_particles, v18);
    end;
end;

function u2._Init(u19) -- Line: 92
    u19.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 93
        -- upvalues: u19 (copy)
        u19:_UpdateArrow();
    end);
    u19.AnimationPlayed:Connect(function() -- Line: 97
        -- upvalues: u19 (copy)
        u19:_UpdateArrow();
    end);
    u19.AnimationStopped:Connect(function() -- Line: 101
        -- upvalues: u19 (copy)
        u19:_UpdateArrow();
    end);
    u19:_Setup();
    task.spawn(u19._UpdateArrow, u19);
end;

return u2;