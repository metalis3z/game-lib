-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._charm_attachment_parent = v3._charm_pivot_attachment and v3._charm_pivot_attachment.Parent;
    v3:_Init();

    return v3;
end;

function u1.AbsorbedHit(p4) -- Line: 22
    p4:CreateSound("rbxassetid://131693414206770", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.ShieldBroken(p5) -- Line: 26
    p5:CreateSound("rbxassetid://113753363821942", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1._UpdateAmmoVisual(p6) -- Line: 34
    if p6._destroyed then
        return;
    end;

    -- Ammo (the shield's health) can be missing before the server's first replication.
    local v7 = (p6.ClientItem:Get("Ammo") or 1) > 0;
    p6:HideSubModel("Body", v7 and 0 or (1 / 0));
    p6._charm_pivot_attachment.Parent = v7 and p6._charm_attachment_parent or nil;
end;

function u1._Init(u8) -- Line: 45
    u8.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 46
        -- upvalues: u8 (copy)
        u8:_UpdateAmmoVisual();
    end);
    u8.AnimationPlayed:Connect(function() -- Line: 50
        -- upvalues: u8 (copy)
        u8:_UpdateAmmoVisual();
    end);
    u8.AnimationStopped:Connect(function() -- Line: 54
        -- upvalues: u8 (copy)
        u8:_UpdateAmmoVisual();
    end);
    task.spawn(u8._UpdateAmmoVisual, u8);
end;

return u1;