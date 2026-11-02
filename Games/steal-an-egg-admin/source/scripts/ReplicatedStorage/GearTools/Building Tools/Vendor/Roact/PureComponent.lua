-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Component = require(script.Parent.Component)
local PureComponent = Component:extend("PureComponent")

PureComponent.extend = Component.extend

function PureComponent.shouldUpdate(v1, v2, v3) -- line 15
    if v3 == v1.state then
        if v2 ~= v1.props then
            for v4, v5 in pairs(v2) do
                if v1.props[v4] ~= v5 then
                    return true
                end
            end
            for v6, v7 in pairs(v1.props) do
                if v2[v6] ~= v7 then
                    return true
                end
            end
        end
        return false
    end
    return true
end

return PureComponent
