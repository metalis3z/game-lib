-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
game:GetService("ReplicatedStorage")
local m_EmoteClass = require(script.Parent.EmoteClass)
function v1.new(p3)
    local v_u_4 = m_EmoteClass.new(p3)
    function v_u_4.EmoteFunc()
        v_u_4.Name = script.Name
        v_u_4:Stop()
    end
    return v_u_4
end
return v1
