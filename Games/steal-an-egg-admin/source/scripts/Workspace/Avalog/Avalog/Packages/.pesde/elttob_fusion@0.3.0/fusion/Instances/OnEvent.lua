-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local v1 = {}

local function getProperty_unsafe(v2, v3) -- line 17
    return v2[v3]
end

local function OnEvent(v4) -- line 24 | captures: External, v1, getProperty_unsafe
    local v5 = v1[v4]
    if v5 == nil then
        v5 = {
            type = "SpecialKey",
            kind = "OnEvent",
            stage = "observer"
        }

        function v5.apply(v6, v7, v8, v9) -- line 33 | captures: v4, External, getProperty_unsafe
            local function v10(v11, ...)
                table.insert(v11, ...)
            end

            local v12, v13 = pcall(getProperty_unsafe, v9, v4)
            if not (v12 and typeof(v13) == "RBXScriptSignal") then
                External.logError("cannotConnectEvent", nil, v9.ClassName, v4)
            elseif typeof(v8) == "function" then
                v10(v7, v13:Connect(v8))
            else
                External.logError("invalidEventHandler", nil, v4)
            end
        end

        v1[v4] = v5
    end
    return v5
end

return OnEvent
