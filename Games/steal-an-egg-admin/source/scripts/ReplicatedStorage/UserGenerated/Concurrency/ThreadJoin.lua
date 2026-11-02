-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2) -- line 6
    local v3 = os.clock()
    while true do
        if coroutine.status(v1) == "dead" then
            return true
        end
        if not (v2 ~= nil and v2 <= os.clock() - v3) then
            task.wait()
            continue
        end
        break
    end
    return false
end
