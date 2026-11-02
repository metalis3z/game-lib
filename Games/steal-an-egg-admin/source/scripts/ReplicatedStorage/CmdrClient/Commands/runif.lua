-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    startsWith = function(v2, v3) -- startsWith | line 7
        if v2:sub(1, #v3) == v3 then
            return v2:sub(#v3 + 1)
        end
    end
}
local v4 = {
    Name = "runif",
    Description = "Runs a given command string if a certain condition is met.",
    Group = "DefaultUtil",
    Aliases = {}
}
local v5 = {}
local v6 = {
    Type = "string",
    Name = "Test against",
    Description = "The text to test against."
}
local v7 = {
    Type = "string",
    Name = "Command",
    Description = "The command string to run if requirements are met. If omitted, return value from condition function is used.",
    Optional = true
}

v5[1] = {
    Type = "conditionFunction",
    Name = "Condition",
    Description = "The condition function"
}
v5[2] = {
    Type = "string",
    Name = "Argument",
    Description = "The argument to the condition function"
}
v5[3] = v6
v5[4] = v7
v4.Args = v5

function v4.Run(v8, v9, v10, v11, v12) -- line 22 | captures: v1
    local v13 = v1[v9]
    if v13 then
        local v14 = v13(v11, v10)
        if v14 then
            return v8.Dispatcher:EvaluateAndRun(v8.Cmdr.Util.RunEmbeddedCommands(v8.Dispatcher, v12 or v14))
        end
        return ""
    end
    return ("Condition %q is not valid."):format(v9)
end

return v4
