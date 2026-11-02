-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._ammo_visuals = {};
    v3:_Init();

    return v3;
end;

function u1._UpdateAmmoVisual(p4) -- Line: 30
    local v5 = p4.ClientItem:Get("Ammo") > 0 and 0 or 1;

    for i in pairs(p4._ammo_visuals) do
        p4:_LocalTransparencyModifier(i, "AmmoVisual", v5);
    end;
end;

function u1._RegisterAmmoVisual(p6, p7) -- Line: 38
    p6._ammo_visuals[p7] = true;
end;

function u1._RegisterDefaultAmmoVisuals(p8) -- Line: 42
    for _, child in pairs(p8.ItemModel:WaitForChild("Shell"):GetChildren()) do
        if child:IsA("BasePart") then
            p8:_RegisterAmmoVisual(child);
        end;
    end;
end;

function u1._Init(u9) -- Line: 50
    -- upvalues: Players (copy), Utility (copy)
    u9.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 51
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisual();
    end);
    task.defer(function() -- Line: 55
        -- upvalues: u9 (copy), Players (ref), Utility (ref)
        u9.ClientItem.ProjectileShot:Connect(function(p10, p11) -- Line: 56
            -- upvalues: u9 (ref), Players (ref), Utility (ref)
            local Attribute = u9.ClientItem.ClientFighter.Player:GetAttribute("TeamID");
            local v12 = not u9.ClientItem.ClientFighter.IsLocalPlayer and (not Attribute or Attribute ~= Players.LocalPlayer:GetAttribute("TeamID"));
            local v13 = v12 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(47, 255, 0);
            local v14, v15, v16 = v13:ToHSV();
            local Color3_fromHSV_ret = Color3.fromHSV(v14, v15 * 0.875, v16);

            for _, descendant in pairs(p11:GetDescendants()) do
                if not descendant:GetAttribute("IgnoreRecolor") then
                    local v17 = descendant:GetAttribute("IsDangerParticle") and v13 and v13 or Color3_fromHSV_ret;

                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Color = ColorSequence.new(v17);
                    elseif descendant:IsA("Light") then
                        descendant.Color = v17;
                    end;
                end;
            end;

            Utility:CreateSound("rbxassetid://17331783148", 1.25, 1, p11.Primary, true).Looped = true;
        end);
    end);
    u9:_UpdateAmmoVisual();
end;

return u1;