-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local copy = buffer.copy
local create = buffer.create
local fill = buffer.fill
local len = buffer.len
local readu8 = buffer.readu8
local writeu8 = buffer.writeu8
local random = math.random
local v1 = {}

local function nonPad(v2) -- line 14
    return v2
end

local v3 = {
    Overwrite = false,
    Pad = nonPad,
    Unpad = nonPad
}

v1.None = table.freeze(v3)

local function anxPad(v4, v5, v6) -- line 19 | captures: copy, create, fill, len, writeu8
    local v7 = len(v4)
    local v8 = v7 - v7 % v6
    if v5 then
        local v9 = len(v5)
        local v10 = v7 + v6 <= v9
        assert(v10, "Output buffer out of bounds")
        local v11 = v6 - v7 % v6
        copy(v5, 0, v4, 0, v7)
        fill(v5, v7, 0, v11 - 1)
        local v12 = v8 + v6 - 1
        writeu8(v5, v12, v11)
        return v5
    end
    local v13 = v8 + v6
    local v14 = create(v13)
    copy(v14, 0, v4, 0, v7)
    local v15 = v13 - 1
    local v16 = v6 - v7 % v6
    writeu8(v14, v15, v16)
    return v14
end

local function anxUnpad(v17, v18, v19) -- line 39 | captures: copy, create, len, readu8
    local v20 = len(v17)
    local v21 = v20 - 1
    local v22 = readu8(v17, v21)
    local v23 = v20 - v22
    local v24 = if v22 > 0 then v22 <= v19 else false
    assert(v24, "Got unexpected padding")
    local v25 = v20 - 2
    for v26 = v23, v25 do
        if readu8(v17, v26) ~= 0 then
            error("Got unexpected padding")
        end
    end
    local v27 = create(v23)
    copy(v27, 0, v17, 0, v23)
    return v27
end

local function i10Pad(v28, v29, v30) -- line 63 | captures: copy, create, len, writeu8, random
    local v31 = len(v28)
    local v32 = v31 - v31 % v30
    local v33
    if v29 then
        local v34 = len(v29)
        local v35 = v31 + v30 <= v34
        assert(v35, "Output buffer out of bounds")
        v33 = v29
    else
        v33 = create(v32 + v30)
    end
    copy(v33, 0, v28, 0, v31)
    local v36 = v32 + v30 - 2
    for v37 = v31, v36 do
        local v38 = random(0, 255)
        writeu8(v33, v37, v38)
    end
    local v39 = v32 + v30 - 1
    local v40 = v30 - v31 % v30
    writeu8(v33, v39, v40)
    return v33
end

local function i10Unpad(v41, v42, v43) -- line 84 | captures: copy, create, len, readu8
    local v44 = len(v41)
    local v45 = v44 - 1
    local v46 = readu8(v41, v45)
    local v47 = v44 - v46
    local v48 = if v46 > 0 then v46 <= v43 else false
    assert(v48, "Got unexpected padding")
    local v49
    if v42 then
        local v50 = v47 <= len(v42)
        assert(v50, "Output buffer out of bounds")
        v49 = v42
    else
        v49 = create(v47)
    end
    copy(v49, 0, v41, 0, v47)
    return v49
end

local function pksPad(v51, v52, v53) -- line 101 | captures: copy, create, fill, len
    local v54 = len(v51)
    local v55 = v54 - v54 % v53
    local v56
    if v52 then
        local v57 = len(v52)
        local v58 = v54 + v53 <= v57
        assert(v58, "Output buffer out of bounds")
        v56 = v52
    else
        v56 = create(v55 + v53)
    end
    local v59 = v53 - v54 % v53
    copy(v56, 0, v51, 0, v54)
    fill(v56, v54, v59, v59)
    return v56
end

local function pksUnpad(v60, v61, v62) -- line 118 | captures: copy, create, len, readu8
    local v63 = len(v60)
    local v64 = v63 - 1
    local v65 = readu8(v60, v64)
    local v66 = v63 - v65
    local v67 = if v65 > 0 then v65 <= v62 else false
    assert(v67, "Got unexpected padding")
    local v68 = v63 - 2
    for v69 = v66, v68 do
        if readu8(v60, v69) ~= v65 then
            error("Got unexpected padding")
        end
    end
    local v70 = create(v66)
    copy(v70, 0, v60, 0, v66)
    return v70
end

local function ii7Pad(v71, v72, v73) -- line 142 | captures: copy, create, fill, len, writeu8
    local v74 = len(v71)
    local v75
    if v72 then
        local v76 = len(v72)
        local v77 = v74 + v73 <= v76
        assert(v77, "Output buffer out of bounds")
        fill(v72, v74 + 1, 0, v73 - v74 % v73 - 1)
        v75 = v72
    else
        v75 = create(v74 + v73 - v74 % v73)
    end
    copy(v75, 0, v71, 0, v74)
    writeu8(v75, v74, 128)
    return v75
end

local function ii7Unpad(v78, v79, v80) -- line 158 | captures: copy, create, len, readu8
    local v81 = len(v78) - 1
    local v82 = v81 - v80
    for v83 = v81, v82, -1 do
        local v84 = readu8(v78, v83)
        if v84 == 128 then
            local v85
            if v79 then
                local v86 = v83 <= len(v79)
                assert(v86, "Output buffer out of bounds")
                v85 = v79
            else
                v85 = create(v83)
            end
            copy(v85, 0, v78, 0, v83)
            return v85
        end
        local v87 = v84 == 0
        assert(v87, "Got unexpected padding")
    end
    error("Got unexpected padding")
    return create(0)
end

local function zroPad(v88, v89, v90) -- line 182 | captures: copy, create, fill, len
    local v91 = len(v88)
    local v92
    if v89 then
        local v93 = len(v89)
        local v94 = v91 + v90 <= v93
        assert(v94, "Output buffer out of bounds")
        fill(v89, v91, 0, v90 - v91 % v90)
        v92 = v89
    else
        v92 = create(v91 + v90 - v91 % v90)
    end
    copy(v92, 0, v88, 0, v91)
    return v92
end

local function zroUnpad(v95, v96, v97) -- line 197 | captures: copy, create, len, readu8
    local v98 = len(v95) - 1
    local v99 = v98 - v97
    for v100 = v98, v99, -1 do
        if readu8(v95, v100) == 0 then
            local v101 = v100 + 1
            local v102
            if v96 then
                local v103 = v101 <= len(v96)
                assert(v103, "Output buffer out of bounds")
                v102 = v96
            else
                v102 = create(v101)
            end
            copy(v102, 0, v95, 0, v101)
            return v102
        end
    end
    copy(v96, 0, v95, 0, v98 - v97 - 1)
    return v96
end

local v104 = {}

function v104.__index(v105, v106) -- line 221 | captures: anxPad, i10Pad, i10Unpad, pksPad, pksUnpad, ii7Pad, ii7Unpad, zroPad, zroUnpad
    if v106 == "AnsiX923" then
        return {
            Pad = anxPad,
            Unpad = anxPad
        }
    end
    if v106 == "Iso10126" then
        return {
            Pad = i10Pad,
            Unpad = i10Unpad
        }
    end
    if v106 == "Pkcs7" then
        return {
            Pad = pksPad,
            Unpad = pksUnpad
        }
    end
    if v106 == "Iso7816_4" then
        return {
            Pad = ii7Pad,
            Unpad = ii7Unpad
        }
    end
    if v106 == "Zero" then
        return {
            Pad = zroPad,
            Unpad = zroUnpad
        }
    end
    return nil
end

function v104.__newindex() -- line 239
end

setmetatable(v1, v104)
v1.AnsiX923 = {}
v1.Iso10126 = {}
v1.Pkcs7 = {}
v1.Iso7816_4 = {}
v1.Zero = {}
table.freeze(v1)
v104.__metatable = "This metatable is locked"
return v1
