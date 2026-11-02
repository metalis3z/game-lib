-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function Mix(v1, v2, v3) -- line 6
    local v4 = bit32.bor(v1, 0)
    local v5 = bit32.bor(v2, 0)
    local v6 = bit32.bor(v3, 0)
    local v7 = v4 - v5 - v6
    local v8 = bit32.rshift(v6, 13)
    local v9 = bit32.bxor(v7, v8)
    local v10 = v5 - v6 - v9
    local v11 = bit32.lshift(v9, 8)
    local v12 = bit32.bxor(v10, v11)
    local v13 = v6 - v9 - v12
    local v14 = bit32.rshift(v12, 13)
    local v15 = bit32.bxor(v13, v14)
    local v16 = v9 - v12 - v15
    local v17 = bit32.rshift(v15, 12)
    local v18 = bit32.bxor(v16, v17)
    local v19 = v12 - v15 - v18
    local v20 = bit32.lshift(v18, 16)
    local v21 = bit32.bxor(v19, v20)
    local v22 = v15 - v18 - v21
    local v23 = bit32.rshift(v21, 5)
    local v24 = bit32.bxor(v22, v23)
    local v25 = v18 - v21 - v24
    local v26 = bit32.rshift(v24, 3)
    local v27 = bit32.bxor(v25, v26)
    local v28 = v21 - v24 - v27
    local v29 = bit32.lshift(v27, 10)
    local v30 = bit32.bxor(v28, v29)
    local v31 = v24 - v27 - v30
    local v32 = bit32.rshift(v30, 15)
    return (bit32.bxor(v31, v32))
end

local function Unpack64(v33) -- line 20
    if v33 >= 0 then
        local v34 = v33 // 4294967296
        return bit32.bor(v34, 0), (bit32.bor(v33, 0))
    end
    local v35 = -1 - v33
    local v36 = v35 // 4294967296
    return bit32.bnot(v36), (bit32.bnot(v35))
end

local function ParseUUID(v37) -- line 30
    local v38 = string.sub(v37, 1, 8)
    local v39 = tonumber(v38, 16)
    local v40 = string.sub(v37, 10, 13) .. string.sub(v37, 15, 18)
    local v41 = tonumber(v40, 16)
    local v42 = string.sub(v37, 20, 23) .. string.sub(v37, 25, 28)
    local v43 = tonumber(v42, 16)
    local v44 = string.sub(v37, 29, 36)
    return v39, v41, v43, (tonumber(v44, 16))
end

local v45 = { Mix = Mix }

function v45.DoubleFromInt64(v46, v47) -- line 44 | captures: Mix
    local v48, v49
    if v46 >= 0 then
        local v50 = v46 // 4294967296
        v49, v48 = bit32.bor(v50, 0), bit32.bor(v46, 0)
    else
        local v51 = -1 - v46
        local v52 = v51 // 4294967296
        v49, v48 = bit32.bnot(v52), bit32.bnot(v51)
    end
    return Mix(v48, v49, v47) / 4294967296
end

function v45.DoubleFromUUID(v53, v54) -- line 57 | captures: Mix
    local v55 = string.sub(v53, 1, 8)
    local v56 = tonumber(v55, 16)
    local v57 = string.sub(v53, 10, 13) .. string.sub(v53, 15, 18)
    local v58 = tonumber(v57, 16)
    local v59 = string.sub(v53, 20, 23) .. string.sub(v53, 25, 28)
    local v60 = tonumber(v59, 16)
    local v61 = string.sub(v53, 29, 36)
    local v62 = tonumber(v61, 16)
    local v63 = Mix(v56, v58, 2197175160)
    local v64 = Mix(v60, v62, 2821953579)
    return Mix(v63, v64, v54) / 4294967296
end

function v45.IntegerFromUUID(v65, v66, v67, v68) -- line 72 | captures: Mix
    local v69 = v68 - v67 + 1
    local v70 = string.sub(v65, 1, 8)
    local v71 = tonumber(v70, 16)
    local v72 = string.sub(v65, 10, 13) .. string.sub(v65, 15, 18)
    local v73 = tonumber(v72, 16)
    local v74 = string.sub(v65, 20, 23) .. string.sub(v65, 25, 28)
    local v75 = tonumber(v74, 16)
    local v76 = string.sub(v65, 29, 36)
    local v77 = tonumber(v76, 16)
    local v78 = Mix(v71, v73, 2197175160)
    local v79 = Mix(v75, v77, 2821953579)
    local v80 = v67 + v69 * (Mix(v78, v79, v66) / 4294967296)
    return (math.floor(v80))
end

return table.freeze(v45)
