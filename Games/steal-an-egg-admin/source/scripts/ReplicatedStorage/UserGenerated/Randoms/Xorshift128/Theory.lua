-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function MatClone(v1) -- line 6
    local v2 = table.clone(v1)
    local v3 = #v2
    for v4 = 1, v3 do
        v2[v4] = table.clone(v2[v4])
    end
    return v2
end

local function MatZero(v5) -- line 15
    local v6 = table.create(v5)
    for v7 = 1, v5 do
        v6[v7] = table.create(v5, 0)
    end
    return v6
end

local function MatIdent(v8) -- line 24 | captures: MatZero
    local v9 = MatZero(v8)
    for v10 = 1, v8 do
        v9[v10][v10] = 1
    end
    return v9
end

local function MatMul(v11, v12) -- line 33
    local v13 = {}
    local v14 = #v11[1]
    local v15 = #v12[1]
    local v16 = #v11
    for v17 = 1, v16 do
        local v18 = table.create(v15, 0)
        for v19 = 1, v15 do
            local v20 = 0
            for v21 = 1, v14 do
                local v22 = v11[v17][v21]
                local v23 = v12[v21][v19]
                local v24 = bit32.band(v22, v23)
                v20 = bit32.bxor(v20, v24)
            end
            v18[v19] = v20
        end
        v13[v17] = v18
    end
    return v13
end

local function MatMulVec(v25, v26) -- line 59
    local v27 = #v25
    local v28 = #v25[1]
    local v29 = table.create(v27, 0)
    for v30 = 1, v27 do
        local v31 = 0
        for v32 = 1, v28 do
            local v33 = v25[v30][v32]
            local v34 = v26[v32]
            local v35 = bit32.band(v33, v34)
            v31 = bit32.bxor(v31, v35)
        end
        v29[v30] = v31
    end
    return v29
end

local function MatSum(v36, v37) -- line 79 | captures: MatZero
    local v38 = #v36
    local v39 = #v36[1]
    local v40 = MatZero(v38)
    for v41 = 1, v38 do
        for v42 = 1, v39 do
            local v43 = v40[v41]
            local v44 = v36[v41][v42]
            local v45 = v37[v41][v42]
            v43[v42] = bit32.bxor(v44, v45)
        end
    end
    return v40
end

local function MatInverse(v46) -- line 96 | captures: MatClone, MatZero
    local v47 = #v46
    local v48 = MatClone(v46)
    local v49 = MatZero(v47)
    for v50 = 1, v47 do
        v49[v50][v50] = 1
    end
    for v51 = 1, v47 do
        local v52
        for v53 = v51, v47 do
            if v48[v53][v51] == 1 then
                v52 = v53
                break
            end
            v52 = nil
        end
        assert(v52, "not invertible")
        local v54 = v48[v51]
        v48[v51] = v48[v52]
        v48[v52] = v54
        local v55 = v49[v51]
        v49[v51] = v49[v52]
        v49[v52] = v55
        for v56 = 1, v47 do
            if v56 ~= v51 and v48[v56][v51] == 1 then
                for v57 = 1, v47 do
                    local v58 = v48[v56]
                    local v59 = v48[v56][v57]
                    local v60 = v48[v51][v57]
                    v58[v57] = bit32.bxor(v59, v60)
                    local v61 = v49[v56]
                    local v62 = v49[v56][v57]
                    local v63 = v49[v51][v57]
                    v61[v57] = bit32.bxor(v62, v63)
                end
            end
        end
    end
    return v49
end

local function MatPow(v64, v65) -- line 141 | captures: MatClone, MatZero, MatMul, MatInverse
    local v66 = #v64
    local v67 = MatZero(v66)
    for v68 = 1, v66 do
        v67[v68][v68] = 1
    end
    local v69
    if v65 >= 0 then
        v69 = MatClone(v64)
    else
        v69 = MatInverse(v64)
    end
    local v70 = math.abs(v65)
    while true do
        local v71
        if v70 > 0 then
            if math.fmod(v70, 2) >= 0.5 then
                v71 = MatMul(v67, v69)
            else
                v71 = v67
            end
        else
            break
        end
        v69 = MatMul(v69, v69)
        local v72 = v70 / 2
        v67, v70 = v71, math.floor(v72)
    end
    return v67
end

local function L(v73, v74) -- line 166 | captures: MatZero
    local v75 = MatZero(v74)
    local v76 = v74 - v73
    for v77 = 1, v76 do
        v75[v77][v77 + v73] = 1
    end
    return v75
end

local function R(v78, v79) -- line 175 | captures: MatZero
    local v80 = MatZero(v79)
    local v81 = v78 + 1
    for v82 = v81, v79 do
        v80[v82][v82 - v78] = 1
    end
    return v80
end

local function Embed(v83, v84, v85, v86) -- line 184 | captures: MatZero
    local v87 = MatZero(v84)
    local v88 = #v83
    for v89 = 1, v88 do
        local v90 = #v83[1]
        for v91 = 1, v90 do
            v87[v85 + v89][v86 + v91] = v83[v89][v91]
        end
    end
    return v87
end

local function ToColumnVector128(v92, v93, v94, v95) -- line 200
    local v96 = table.create(128, 0)
    for v97 = 0, 31 do
        local v98 = bit32.rshift(v92, v97)
        v96[32 - v97] = bit32.band(v98, 1)
        local v99 = bit32.rshift(v93, v97)
        v96[64 - v97] = bit32.band(v99, 1)
        local v100 = bit32.rshift(v94, v97)
        v96[96 - v97] = bit32.band(v100, 1)
        local v101 = bit32.rshift(v95, v97)
        v96[128 - v97] = bit32.band(v101, 1)
    end
    return v96
end

local function FromColumnVector128(v102) -- line 217
    local v103 = 0
    local v104 = 0
    local v105 = 0
    local v106 = 0
    for v107 = 0, 31 do
        local v108 = v102[32 - v107]
        local v109 = bit32.lshift(v108, v107)
        v103 = bit32.bor(v103, v109)
        local v110 = v102[64 - v107]
        local v111 = bit32.lshift(v110, v107)
        v104 = bit32.bor(v104, v111)
        local v112 = v102[96 - v107]
        local v113 = bit32.lshift(v112, v107)
        v105 = bit32.bor(v105, v113)
        local v114 = v102[128 - v107]
        local v115 = bit32.lshift(v114, v107)
        v106 = bit32.bor(v106, v115)
    end
    return v103, v104, v105, v106
end

local v116 = MatIdent(32)
local v117 = MatIdent(128)
local v118 = MatMul(MatSum(v117, (Embed(L(11, 32), 128, 0, 0))), v117)
local v119 = MatMul(MatSum(v117, (Embed(R(8, 32), 128, 0, 0))), v118)
local v120 = MatMul(MatSum(v117, (Embed(v116, 128, 0, 96))), v119)
local v121 = MatMul(MatSum(v117, (Embed(R(19, 32), 128, 0, 96))), v120)
local v122 = MatMul(MatSum(L(32, 128), (R(96, 128))), v121)
local freeze = table.freeze
local v123 = {
    ToColumnVector128 = ToColumnVector128,
    FromColumnVector128 = FromColumnVector128
}

function v123.MatTransform() -- line 258 | captures: MatClone, v122
    return (MatClone(v122))
end

function v123.Transform(v124, v125, v126, v127, v128) -- line 261 | captures: MatClone, MatMulVec, MatPow, ToColumnVector128, FromColumnVector128, v122
    local v129 = ToColumnVector128(v124, v125, v126, v127)
    local v130 = MatClone(v122)
    local v131 = MatPow(v130, v128)
    local v132 = MatMulVec(v131, v129)
    return FromColumnVector128(v132)
end

return freeze(v123)
