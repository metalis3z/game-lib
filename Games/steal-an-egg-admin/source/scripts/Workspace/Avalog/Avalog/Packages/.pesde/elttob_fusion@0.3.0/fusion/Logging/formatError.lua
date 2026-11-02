-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local messages = require(Parent.Logging.messages)

local function formatError(v1, v2, v3, ...) -- line 16 | captures: messages
    local v4 = if typeof(v3) == "table" then v3 else nil
    local v5 = if typeof(v3) == "table" then v3.trace else v3
    local v6 = messages[v2]
    local v7
    if v6 == nil then
        v7, v6 = "unknownMessage", messages.unknownMessage
    else
        v7 = v2
    end
    local v8 = v6:format(...)
    local v9
    if v4 == nil then
        v9 = v8:gsub("ERROR_MESSAGE", v2)
    else
        v9 = v8:gsub("ERROR_MESSAGE", v4.message)
        if v4.context ~= nil then
            v9 ..= (" (%*)"):format(v4.context)
        end
    end
    local v10 = ("[Fusion] %* \nID: %*"):format(v9, v7)
    if v1 ~= nil and v1.policies.allowWebLinks then
        v10 ..= ("\nLearn more: https://elttob.uk/Fusion/0.3/api-reference/general/errors/#%*"):format((v7:lower()))
    end
    if v5 ~= nil then
        v10 ..= (" \n---- Stack trace ----\n%*"):format(v5)
    end
    return v10:gsub("\n", "\n    ")
end

return formatError
