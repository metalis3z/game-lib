-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    local v2 = {}
    local v3 = {
        Name = "+",
        Perform = function(v4, v5) -- Perform | line 10
            return v4 + v5
        end
    }
    local v6 = {
        Name = "-",
        Perform = function(v7, v8) -- Perform | line 16
            return v7 - v8
        end
    }
    local v9 = {
        Name = "*",
        Perform = function(v10, v11) -- Perform | line 22
            return v10 * v11
        end
    }
    local v12 = {
        Name = "/",
        Perform = function(v13, v14) -- Perform | line 28
            return v13 / v14
        end
    }
    local v15 = {
        Name = "**",
        Perform = function(v16, v17) -- Perform | line 34
            return v16 ^ v17
        end
    }
    local v18 = {
        Name = "%",
        Perform = function(v19, v20) -- Perform | line 40
            return v19 % v20
        end
    }
    v2[1] = v3
    v2[2] = v6
    v2[3] = v9
    v2[4] = v12
    v2[5] = v15
    v2[6] = v18
    v1:RegisterType("mathOperator", v1.Cmdr.Util.MakeEnumType("Math Operator", v2))
end
