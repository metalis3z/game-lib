-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Name = "history",
    Description = "Displays previous commands from history.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = { "alias \"!|Displays previous command from history.\" run ${history $1{number|Line Number}}", "alias \"^|Runs the previous command, replacing all occurrences of A with B.\" run ${run replace ${history -1} $1{string|A} $2{string|B}}", "alias \"!!|Reruns the last command.\" ! -1" }
}

v1.Args = {
    {
        Type = "integer",
        Name = "Line Number",
        Description = "Command line number (can be negative to go from end)"
    }
}

function v1.ClientRun(v2, v3) -- line 17
    local v4 = v2.Dispatcher:GetHistory()
    local v5 = if v3 > 0 then v3 else #v4 + v3
    return v4[v5] or ""
end

return v1
