-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Name = "run-lines",
    Description = "Splits input by newlines and runs each line as its own command. This is used by the init-run command.",
    Group = "DefaultUtil",
    Aliases = {}
}
local v2 = {}

v2[1] = {
    Type = "string",
    Name = "Script",
    Description = "The script to parse.",
    Default = ""
}
v1.Args = v2

function v1.ClientRun(v3, v4) -- line 11
    if #v4 ~= 0 then
        local v5 = v3.Dispatcher:Run("var", "INIT_PRINT_OUTPUT") ~= ""
        local v6 = v4:gsub("\n+", "\n"):split("\n")
        for v7, v8 in ipairs(v6) do
            if v8:sub(1, 1) ~= "#" and v5 then
                v3:Reply((v3.Dispatcher:EvaluateAndRun(v8)))
            end
        end
    end
    return ""
end

return v1
