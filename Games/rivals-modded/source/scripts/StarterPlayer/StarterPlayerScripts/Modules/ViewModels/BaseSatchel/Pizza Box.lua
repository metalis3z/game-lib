-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local BaseSatchel = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseSatchel);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("PizzaExplosionEffect"):WaitForChild("Attachment");
local u1 = setmetatable({}, BaseSatchel);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: BaseSatchel (copy), u1 (copy)
    local v2 = BaseSatchel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._registered_ammo_visuals = {};
    v3._charm_attachment_parent = v3._charm_pivot_attachment and v3._charm_pivot_attachment.Parent;
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 28
    -- upvalues: BetterDebris (copy), Utility (copy), Attachment (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p5);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 0.4, 0.9 + 0.2 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://74472565321499", 1.2, 1 + 0.2 * math.random(), Part, true, 10);
    local v7 = Attachment:Clone();

    for _, child in pairs(v7:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p6 / 8);
        end;
    end;

    v7.PointLight.Range = p6 * 2;
    v7.Parent = Part;
    Utility:PlayParticles(v7);
end;

function u1._UpdateAmmoVisual(p8) -- Line: 59
    if p8._destroyed then
        return;
    end;

    for i, v in pairs(p8._registered_ammo_visuals) do
        local v9 = v <= p8.ClientItem:Get("Ammo");
        p8:_LocalTransparencyModifier(i, "AmmoVisual", v9 and 0 or 1);

        if v == 1 and p8._charm_pivot_attachment then
            local v10;

            if v9 then
                v10 = p8._charm_attachment_parent or nil;
            else
                v10 = nil;
            end;

            p8._charm_pivot_attachment.Parent = v10;
        end;
    end;
end;

function u1._RegisterAmmoVisual(p11, p12, p13) -- Line: 75
    p11._registered_ammo_visuals[p12] = p13;
end;

function u1._Init(u14) -- Line: 79
    u14.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 80
        -- upvalues: u14 (copy)
        u14:_UpdateAmmoVisual();
    end);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 1"):WaitForChild("MeshPart1"), 1);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 1"):WaitForChild("MeshPart2"), 1);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 1"):WaitForChild("MeshPart3"), 1);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 1"):WaitForChild("MeshPart4"), 1);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 2"):WaitForChild("MeshPart1"), 2);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 2"):WaitForChild("MeshPart2"), 2);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 2"):WaitForChild("MeshPart3"), 2);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 2"):WaitForChild("MeshPart4"), 2);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 3"):WaitForChild("MeshPart1"), 3);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 3"):WaitForChild("MeshPart2"), 3);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 3"):WaitForChild("MeshPart3"), 3);
    u14:_RegisterAmmoVisual(u14.ItemModel:WaitForChild("Slice 3"):WaitForChild("MeshPart4"), 3);
end;

return u1;