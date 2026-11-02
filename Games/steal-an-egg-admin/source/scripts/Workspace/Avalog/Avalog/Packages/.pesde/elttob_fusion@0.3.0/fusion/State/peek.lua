-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local castToState = require(Parent.State.castToState)
local evaluate = require(Parent.Graph.evaluate)

local function peek(v1) -- line 19 | captures: castToState, evaluate
    local v2 = castToState(v1)
    if v2 == nil then
        return v1
    end
    evaluate(v2, false)
    return v2._EXTREMELY_DANGEROUS_usedAsValue
end

return peek
