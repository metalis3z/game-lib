-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ChainsawParticles");
local u1 = { 1, 0.1 };
local u2 = setmetatable({}, ClientViewModel);
u2.__index = u2;

function u2.new(...) -- Line: 13
    -- upvalues: ClientViewModel (copy), u2 (copy)
    local v3 = ClientViewModel.new(...);
    local v4 = setmetatable(v3, u2);
    v4._beep_parts = {};
    v4._beep_visible = false;
    v4._toggle_index = 0;
    v4._next_toggle = 0;
    v4:_Init();

    return v4;
end;

function u2.Update(p5, p6, p7, p8) -- Line: 30
    -- upvalues: ClientViewModel (copy), u1 (copy)
    ClientViewModel.Update(p5, p6, p7, p8);

    if not p8.IsActive then
        return;
    end;

    if tick() < p5._next_toggle then
        return;
    end;

    p5._toggle_index = p5._toggle_index % #u1 + 1;
    p5._next_toggle = tick() + u1[p5._toggle_index];
    p5._beep_visible = not p5._beep_visible;

    for i, _ in pairs(p5._beep_parts) do
        p5:_LocalTransparencyModifier(i, "Update", p5._beep_visible and 0 or 1);
    end;
end;

function u2._PlayBeepAnimation(p9, p10) -- Line: 54
    while p10:IsDescendantOf(workspace) do
        wait(1);
        p10.LocalTransparencyModifier = 1;
        wait(0.1);
        p10.LocalTransparencyModifier = 0;
    end;
end;

function u2._RegisterBeepPart(p11, p12) -- Line: 66
    p11._beep_parts[p12] = true;
end;

function u2._Init(u13) -- Line: 70
    -- upvalues: Utility (copy)
    task.defer(function() -- Line: 71
        -- upvalues: u13 (copy), Utility (ref)
        u13.ClientItem.ProjectileThrown:Connect(function(p14, p15) -- Line: 72
            -- upvalues: Utility (ref)
            wait(0.5);
            Utility:CreateSound("rbxassetid://104924027407060", 0.05, 1 + 0.1 * math.random(), p14, true).Looped = true;
        end);
    end);
end;

return u2;