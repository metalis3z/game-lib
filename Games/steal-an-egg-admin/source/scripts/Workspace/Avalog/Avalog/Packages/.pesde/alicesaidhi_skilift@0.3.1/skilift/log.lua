-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = require("./flags")

local function LOG(...) -- line 3 | captures: v1
    if v1.print ~= false then
        print("[skilift]:", ...)
    end
end

return LOG
