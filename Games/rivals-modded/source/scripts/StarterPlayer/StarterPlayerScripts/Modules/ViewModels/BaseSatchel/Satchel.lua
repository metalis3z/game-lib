-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseSatchel = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseSatchel);
local u1 = setmetatable({}, BaseSatchel);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseSatchel (copy), u1 (copy)
    local v2 = BaseSatchel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 26
    task.defer(function() -- Line: 27
        -- upvalues: u4 (copy)
        u4.ClientItem.ProjectileThrown:Connect(function(p5, p6) -- Line: 28
            -- upvalues: u4 (ref)
            u4:_PlayBeepAnimation(p6:WaitForChild("Beep"));
        end);
    end);
    u4:_RegisterBeepPart(u4.ItemModel:WaitForChild("Body"):WaitForChild("Beep"));
end;

return u1;