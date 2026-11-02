-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 26
    function u4._on_reload_callback() -- Line: 27
        -- upvalues: u4 (copy)
        local _reload_hash = u4._reload_hash;
        task.delay(0.5, function() -- Line: 30
            -- upvalues: _reload_hash (copy), u4 (ref)
            if _reload_hash ~= u4._reload_hash then
                return;
            end;

            u4.ViewModel:PlayReloadParticles();
        end);
    end;
end;

return u1;