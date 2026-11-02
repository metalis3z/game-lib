-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Battle Axe"]);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 8
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2._Setup(p5) -- Line: 26
    local math_random_ret = math.random(1, 3);

    for i = 1, 3 do
        local v6;

        if i == math_random_ret then
            v6 = i;
        else
            local v7 = p5.ItemModel.Body["Sign" .. i];
            task.defer(v7.Destroy, v7);
            v6 = i;
        end;
    end;
end;

function u2._Init(p8) -- Line: 37
    p8:_Setup();
end;

return u2;