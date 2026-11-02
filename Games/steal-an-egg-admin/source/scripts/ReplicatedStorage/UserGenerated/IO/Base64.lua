-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = buffer.create(64)
local v2 = buffer.create(256)
for v3 = 1, 64 do
    local v4 = v3 - 1
    local v5 = string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", v3)
    buffer.writeu8(v1, v4, v5)
    buffer.writeu8(v2, v5, v4)
end

function encode(v6, v7) -- line 17 | captures: v1
    local v8 = v7 or buffer.len(v6)
    local v9 = v8 / 3
    local v10 = math.ceil(v9)
    local v11 = v10 * 4
    local v12 = buffer.create(v11)
    local v13 = v10 - 1
    for v14 = 1, v13 do
        local v15 = (v14 - 1) * 3
        local v16 = (v14 - 1) * 4
        local v17 = buffer.readu32(v6, v15)
        local v18 = bit32.byteswap(v17)
        local v19 = bit32.rshift(v18, 26)
        local v20 = bit32.rshift(v18, 20)
        local v21 = bit32.band(v20, 63)
        local v22 = bit32.rshift(v18, 14)
        local v23 = bit32.band(v22, 63)
        local v24 = bit32.rshift(v18, 8)
        local v25 = bit32.band(v24, 63)
        local v26 = buffer.readu8(v1, v19)
        buffer.writeu8(v12, v16, v26)
        local v27 = v16 + 1
        local v28 = buffer.readu8(v1, v21)
        buffer.writeu8(v12, v27, v28)
        local v29 = v16 + 2
        local v30 = buffer.readu8(v1, v23)
        buffer.writeu8(v12, v29, v30)
        local v31 = v16 + 3
        local v32 = buffer.readu8(v1, v25)
        buffer.writeu8(v12, v31, v32)
    end
    local v33 = v8 % 3
    if v33 == 1 then
        local v34 = v8 - 1
        local v35 = buffer.readu8(v6, v34)
        local v36 = bit32.rshift(v35, 2)
        local v37 = bit32.lshift(v35, 4)
        local v38 = bit32.band(v37, 63)
        local v39 = v11 - 4
        local v40 = buffer.readu8(v1, v36)
        buffer.writeu8(v12, v39, v40)
        local v41 = v11 - 3
        local v42 = buffer.readu8(v1, v38)
        buffer.writeu8(v12, v41, v42)
        local v43 = v11 - 2
        buffer.writeu8(v12, v43, 61)
        local v44 = v11 - 1
        buffer.writeu8(v12, v44, 61)
    elseif v33 == 2 then
        local v45 = v8 - 2
        local v46 = buffer.readu8(v6, v45)
        local v47 = bit32.lshift(v46, 8)
        local v48 = v8 - 1
        local v49 = buffer.readu8(v6, v48)
        local v50 = bit32.bor(v47, v49)
        local v51 = bit32.rshift(v50, 10)
        local v52 = bit32.rshift(v50, 4)
        local v53 = bit32.band(v52, 63)
        local v54 = bit32.lshift(v50, 2)
        local v55 = bit32.band(v54, 63)
        local v56 = v11 - 4
        local v57 = buffer.readu8(v1, v51)
        buffer.writeu8(v12, v56, v57)
        local v58 = v11 - 3
        local v59 = buffer.readu8(v1, v53)
        buffer.writeu8(v12, v58, v59)
        local v60 = v11 - 2
        local v61 = buffer.readu8(v1, v55)
        buffer.writeu8(v12, v60, v61)
        local v62 = v11 - 1
        buffer.writeu8(v12, v62, 61)
    elseif v33 == 0 and v8 ~= 0 then
        local v63 = v8 - 3
        local v64 = buffer.readu8(v6, v63)
        local v65 = bit32.lshift(v64, 16)
        local v66 = v8 - 2
        local v67 = buffer.readu8(v6, v66)
        local v68 = bit32.lshift(v67, 8)
        local v69 = v8 - 1
        local v70 = buffer.readu8(v6, v69)
        local v71 = bit32.bor(v65, v68, v70)
        local v72 = bit32.rshift(v71, 18)
        local v73 = bit32.rshift(v71, 12)
        local v74 = bit32.band(v73, 63)
        local v75 = bit32.rshift(v71, 6)
        local v76 = bit32.band(v75, 63)
        local v77 = bit32.band(v71, 63)
        local v78 = v11 - 4
        local v79 = buffer.readu8(v1, v72)
        buffer.writeu8(v12, v78, v79)
        local v80 = v11 - 3
        local v81 = buffer.readu8(v1, v74)
        buffer.writeu8(v12, v80, v81)
        local v82 = v11 - 2
        local v83 = buffer.readu8(v1, v76)
        buffer.writeu8(v12, v82, v83)
        local v84 = v11 - 1
        local v85 = buffer.readu8(v1, v77)
        buffer.writeu8(v12, v84, v85)
    end
    return v12
end

function decode(v86) -- line 90 | captures: v2
    local v87 = buffer.len(v86)
    local v88 = v87 / 4
    local v89 = math.ceil(v88)
    local v90
    if v87 == 0 then
        v90 = 0
    else
        local v91 = v87 - 1
        local v92 = if buffer.readu8(v86, v91) == 61 then 0 + 1 else 0
        local v93 = v87 - 2
        if buffer.readu8(v86, v93) == 61 then
            v90 = v92 + 1
        else
            v90 = v92
        end
    end
    local v94 = buffer.create(v89 * 3 - v90)
    local v95 = v89 - 1
    for v96 = 1, v95 do
        local v97 = (v96 - 1) * 4
        local v98 = (v96 - 1) * 3
        local v99 = buffer.readu8(v86, v97)
        local v100 = buffer.readu8(v2, v99)
        local v101 = v97 + 1
        local v102 = buffer.readu8(v86, v101)
        local v103 = buffer.readu8(v2, v102)
        local v104 = v97 + 2
        local v105 = buffer.readu8(v86, v104)
        local v106 = buffer.readu8(v2, v105)
        local v107 = v97 + 3
        local v108 = buffer.readu8(v86, v107)
        local v109 = buffer.readu8(v2, v108)
        local v110 = bit32.lshift(v100, 18)
        local v111 = bit32.lshift(v103, 12)
        local v112 = bit32.lshift(v106, 6)
        local v113 = bit32.bor(v110, v111, v112, v109)
        local v114 = bit32.rshift(v113, 16)
        local v115 = bit32.rshift(v113, 8)
        local v116 = bit32.band(v115, 255)
        local v117 = bit32.band(v113, 255)
        buffer.writeu8(v94, v98, v114)
        local v118 = v98 + 1
        buffer.writeu8(v94, v118, v116)
        local v119 = v98 + 2
        buffer.writeu8(v94, v119, v117)
    end
    if v87 ~= 0 then
        local v120 = (v89 - 1) * 4
        local v121 = (v89 - 1) * 3
        local v122 = buffer.readu8(v86, v120)
        local v123 = buffer.readu8(v2, v122)
        local v124 = v120 + 1
        local v125 = buffer.readu8(v86, v124)
        local v126 = buffer.readu8(v2, v125)
        local v127 = v120 + 2
        local v128 = buffer.readu8(v86, v127)
        local v129 = buffer.readu8(v2, v128)
        local v130 = v120 + 3
        local v131 = buffer.readu8(v86, v130)
        local v132 = buffer.readu8(v2, v131)
        local v133 = bit32.lshift(v123, 18)
        local v134 = bit32.lshift(v126, 12)
        local v135 = bit32.lshift(v129, 6)
        local v136 = bit32.bor(v133, v134, v135, v132)
        if v90 <= 2 then
            local v137 = bit32.rshift(v136, 16)
            buffer.writeu8(v94, v121, v137)
            if v90 <= 1 then
                local v138 = bit32.rshift(v136, 8)
                local v139 = bit32.band(v138, 255)
                local v140 = v121 + 1
                buffer.writeu8(v94, v140, v139)
                if v90 == 0 then
                    local v141 = bit32.band(v136, 255)
                    local v142 = v121 + 2
                    buffer.writeu8(v94, v142, v141)
                end
            end
        end
    end
    return v94
end

function Encode(v143) -- line 152
    return buffer.tostring(encode(buffer.fromstring(v143)))
end

function Decode(v144) -- line 155
    return buffer.tostring(decode(buffer.fromstring(v144)))
end

return table.freeze({
    Encode = Encode,
    Decode = Decode,
    EncodeBuffer = encode,
    DecodeBuffer = decode
})
