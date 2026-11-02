-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)

local function u9(v1) -- line 8
    if type(v1) == "table" then
        return #v1 > 0
    end
    return false
end

local v2

local function requireSpan(v3) -- line 13 | captures: t, u9
    t.strict(t.table)(v3)
    t.strict(u9)(v3)
end

local function openStream(v4) -- line 19
    if v4 == nil then
        return Random.new()
    end
    if type(v4) == "number" then
        return Random.new(v4)
    end
    if typeof(v4) == "Random" then
        return v4
    end
    error((("a random stream cannot be seeded from a %*"):format((typeof(v4)))))
end

local v5 = { __class = "RandomWrapper" }

function v5.new(v6) -- line 33 | captures: v2, openStream
    local v7 = { source = openStream(v6) }
    local v8 = v2
    return (setmetatable(v7, v8))
end

function v5.handle(v9) -- line 37
    return v9.source
end

function v5.clone(v10) -- line 40 | captures: v2
    return v2.new(v10.source:Clone())
end

function v5.seed(v11, v12) -- line 43
    v11.source = Random.new(v12)
end

function v5.number(v13, v14, v15) -- line 46
    if v14 ~= nil and v15 ~= nil then
        return (v13.source:NextNumber(v14, v15))
    end
    return (v13.source:NextNumber(0, 1))
end

function v5.jitter(v16, v17, v18) -- line 53 | captures: t
    t.strict(t.number)(v17)
    t.strict(t.number)(v18)
    local v19 = math.abs(v17) * v18
    return v16:number(v17 - v19, v17 + v19)
end

function v5.boolean(v20, v21) -- line 61
    if v20.source:NextNumber() < v21 then
    end
    return true
end

function v5.integer(v22, v23, v24) -- line 71
    return v22.source:NextInteger(v23, v24)
end

function v5.integerArray(v25, v26) -- line 74 | captures: t, u9
    t.strict(t.table)(v26)
    t.strict(u9)(v26)
    if #v26 == 1 then
        return v26[1]
    end
    return (v25.source:NextInteger(table.unpack(v26)))
end

function v5.numberArray(v27, v28) -- line 84 | captures: t, u9
    t.strict(t.table)(v28)
    t.strict(u9)(v28)
    if #v28 == 1 then
        return v28[1]
    end
    return (v27.source:NextNumber(table.unpack(v28)))
end

function v5.normal(v29, v30, v31) -- line 95
    local function v32(v33, ...)
        return (math.max(v33, ...))
    end

    local v34 = v32(0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014, v29.source:NextNumber())
    local v35 = math.log(v34) * -2
    local v36 = math.sqrt(v35) * (v31 or 1)
    local v37 = v29.source:NextNumber() * 6.283185307179586
    local v38 = v30 or 0
    return v36 * math.cos(v37) + v38, v36 * math.sin(v37) + v38
end

function v5.Vector3(v39, v40) -- line 103
    return v39.source:NextUnitVector() * (v40 or 1)
end

function v5.Vector2(v41, v42) -- line 106
    local v43 = v41.source:NextNumber() * 6.283185307179586
    local v44 = math.cos(v43)
    return Vector2.new(v44, (math.sin(v43))) * (v42 or 1)
end

function v5.positiveYVector3(v45, v46) -- line 112
    local v47 = v45:Vector3(v46)
    local Y = v47.Y
    local v48 = math.max(0, Y)
    local X = v47.X
    local Z = v47.Z
    return (Vector3.new(X, v48, Z))
end

function v5.flatVector3PositiveY(v49, v50) -- line 117
    local v51 = v50 or 1
    local v52 = math.abs(v51)
    return (Vector3.new(0, v52, 0))
end

v2 = v5
v2.__index = v2
return v2
