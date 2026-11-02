-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local m_Parent = require(script:FindFirstChild("EffectModule")).Effects(script.Parent)
script.Server.OnClientEvent:Connect(function(p2)
    if p2 == 1 then
        m_Parent.Effect1()
    elseif p2 == 2 then
        m_Parent.Effect2()
    end
end)
