-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Grappler = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Grappler);
local u1 = setmetatable({}, Grappler);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Grappler (copy), u1 (copy)
    local v2 = Grappler.new(...);
    local v3 = setmetatable(v2, u1);
    v3._line_rope = v3.ItemModel:WaitForChild("Body"):WaitForChild("Grey"):WaitForChild("Attachment"):WaitForChild("RopeConstraint");
    v3:_Init();

    return v3;
end;

function u1.PlayShootSounds(p4) -- Line: 22
    p4:CreateSound("rbxassetid://71757681243259", 1.5, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.PlayPullSounds(p5) -- Line: 26
    p5:CreateSound("rbxassetid://133299501943334", 1.5, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1._UpdateLine(p6) -- Line: 34
    p6._line_rope.Enabled = not p6.ClientItem:Get("GrapplingHookPartActive");
end;

function u1._Init(u7) -- Line: 38
    u7.ClientItem:GetDataChangedSignal("GrapplingHookPartActive"):Connect(function() -- Line: 39
        -- upvalues: u7 (copy)
        u7:_UpdateLine();
    end);
    u7:_UpdateLine();
end;

return u1;