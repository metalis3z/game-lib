-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    named = function(v1) -- named | line 16
        local v2 = type(v1) == "string"
        assert(v2, "Symbols must be created using a string name!")
        local v3 = newproxy(true)
        local v4 = ("Symbol(%s)"):format(v1)

        getmetatable(v3).__tostring = function() -- line 23 | captures: v4
            return v4
        end

        return v3
    end
}
