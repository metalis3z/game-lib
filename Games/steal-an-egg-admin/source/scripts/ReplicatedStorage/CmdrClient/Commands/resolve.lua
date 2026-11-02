-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Name = "resolve",
    Description = "Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = { "alias \"me|Displays your username\" resolve players ." }
}

v1.Args = {
    {
        Type = "type",
        Name = "Type",
        Description = "The type for which to resolve"
    },
    function(v2) -- line 14
        if v2:GetArgument(1):Validate() == false then
            return
        end
        return {
            Name = "Argument Value Operator",
            Description = "The value operator to resolve. One of: * ** . ? ?N",
            Optional = true,
            Type = v2:GetArgument(1):GetValue()
        }
    end
}

function v1.Run(v3) -- line 21
    return table.concat(v3:GetArgument(2).RawSegments, ",")
end

return v1
