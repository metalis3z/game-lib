-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TableUtil = require(script.Parent.TableUtil)
local v1 = {}

function v1.DeserializeTree(v2) -- line 10 | captures: TableUtil, v1
    local v3 = TableUtil.Copy(v2, true)
    for v4, v5 in pairs(v2) do
        if typeof(v5) == "table" then
            local EnumType = v5.EnumType
            if typeof(EnumType) == "string" then
                local Value = v5.Value
                if typeof(Value) == "number" then
                    local v6 = v1.Deserialize(v5)
                    if v6 ~= nil then
                        v3[v4] = v6
                    end
                else
                    v3[v4] = v1.DeserializeTree(v5)
                end
            else
                v3[v4] = v1.DeserializeTree(v5)
            end
        end
    end
    return v3
end

local function Deserialize(v7) -- line 29
    local v8 = Enum[v7.EnumType]
    if v8 then
        local v9 = v8:GetEnumItems()
        for v10, v11 in pairs(v9) do
            if v11.Value == v7.Value then
                return v11
            end
        end
    end
    return nil
end

v1.Deserialize = Deserialize

function v1.SerializeTree(v12) -- line 45 | captures: TableUtil, v1
    local v13 = TableUtil.Copy(v12, true)
    for v14, v15 in pairs(v12) do
        if typeof(v15) == "EnumItem" then
            v13[v14] = v1.Serialize(v15)
        elseif typeof(v15) == "table" then
            v13[v14] = v1.SerializeTree(v15)
        end
    end
    return v13
end

local function Serialize(v16) -- line 59
    local v17 = {}
    local EnumType = v16.EnumType
    v17.EnumType = tostring(EnumType)
    v17.Value = v16.Value
    return v17
end

v1.Serialize = Serialize
return v1
