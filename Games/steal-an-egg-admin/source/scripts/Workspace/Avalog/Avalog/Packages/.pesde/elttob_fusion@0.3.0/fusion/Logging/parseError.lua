-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)

local function parseError(v1) -- line 14
    return {
        type = "Error",
        raw = v1,
        message = v1:gsub("^.+:%d+:%s*", ""),
        trace = debug.traceback(nil, 2)
    }
end

return parseError
