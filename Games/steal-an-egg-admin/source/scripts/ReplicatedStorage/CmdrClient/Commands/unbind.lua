-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "unbind",
    Description = "Unbinds an input previously bound with Bind",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "userInput ! bindableResource @ player",
            Name = "Input/Key",
            Description = "The key or input type you'd like to unbind."
        }
    },
    ClientRun = function(v1, v2) -- ClientRun | line 14
        local CMDR_Binds = v1:GetStore("CMDR_Binds")
        if CMDR_Binds[v2] then
            CMDR_Binds[v2]:Disconnect()
            CMDR_Binds[v2] = nil
            return "Unbound command from input."
        end
        return "That input wasn't bound."
    end
}
