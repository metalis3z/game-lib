-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)

local function castToGraph(v1) -- line 13
    if typeof(v1) == "table" then
        local validity = v1.validity
        if typeof(validity) == "string" then
            local timeliness = v1.timeliness
            if typeof(timeliness) == "string" then
                local dependencySet = v1.dependencySet
                if typeof(dependencySet) == "table" then
                    local dependentSet = v1.dependentSet
                    if typeof(dependentSet) == "table" then
                        return v1
                    end
                end
            end
        end
    end
    return nil
end

return castToGraph
