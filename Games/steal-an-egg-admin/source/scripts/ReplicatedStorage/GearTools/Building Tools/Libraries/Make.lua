-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 5
    return function(v2, ...) -- line 6 | captures: v1
        local v3 = Instance.new(v1)
        local Parent = v2.Parent
        if Parent then
            v2.Parent = nil
        end
        for v4, v5 in next, v2 do
            if type(v4) == "number" then
                v5.Parent = v3
            else
                v3[v4] = v5
            end
        end
        if Parent then
            v3.Parent = Parent
        end
        if ... then
            local v6 = { ... }
            local v7 = #v6
            for v8 = 1, v7 do
                local v9 = v3:Clone()
                for v10, v11 in next, v6[v8] do
                    if type(v10) == "number" then
                        v11.Parent = v9
                    else
                        v9[v10] = v11
                    end
                end
                v9.Parent = not v9.Parent and Parent
                v6[v8] = v9
            end
            return v3, unpack(v6)
        end
        return v3
    end
end
