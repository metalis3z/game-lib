-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function mult(v1, v2) -- line 6
    local v3 = bit32.band(v1, 65535) * v2
    local v4 = bit32.rshift(v1, 16) * v2
    local v5 = bit32.band(v4, 65535)
    return v3 + bit32.lshift(v5, 16)
end

return function(v6, v7) -- line 12
    local v8
    if v7 == nil then
        v8 = 0
    else
        v8 = bit32.bor(v7, 0)
    end
    local v9 = #v6
    local v10, v11, v12
    if v9 < 16 then
        local v13 = v8 + 374761393
        v12 = bit32.bor(v13, 0)
        v11 = 1
        v10 = 1
    else
        local v14 = v8 + 2654435761 + 2246822519
        local v15 = v8 + 2246822519
        local v16 = v8 - 2654435761
        local v17 = v9 - 16
        v11 = 1
        v10 = 1
        for v18 = 0, v17, 16 do
            local v19 = v10 + 15
            local v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35 = string.byte(v6, v10, v19)
            local v36 = bit32.lshift(v23, 24)
            local v37 = bit32.lshift(v22, 16)
            local v38 = bit32.lshift(v21, 8)
            local v39 = bit32.bor(v36, v37, v38, v20)
            local v40 = bit32.band(v39, 65535) * 2246822519
            local v41 = bit32.rshift(v39, 16) * 2246822519
            local v42 = bit32.band(v41, 65535)
            local v43 = v14 + (v40 + bit32.lshift(v42, 16))
            local v44 = bit32.lrotate(v43, 13)
            local v45 = bit32.band(v44, 65535) * 2654435761
            local v46 = bit32.rshift(v44, 16) * 2654435761
            local v47 = bit32.band(v46, 65535)
            v14 = v45 + bit32.lshift(v47, 16)
            local v48 = bit32.lshift(v27, 24)
            local v49 = bit32.lshift(v26, 16)
            local v50 = bit32.lshift(v25, 8)
            local v51 = bit32.bor(v48, v49, v50, v24)
            local v52 = bit32.band(v51, 65535) * 2246822519
            local v53 = bit32.rshift(v51, 16) * 2246822519
            local v54 = bit32.band(v53, 65535)
            local v55 = v15 + (v52 + bit32.lshift(v54, 16))
            local v56 = bit32.lrotate(v55, 13)
            local v57 = bit32.band(v56, 65535) * 2654435761
            local v58 = bit32.rshift(v56, 16) * 2654435761
            local v59 = bit32.band(v58, 65535)
            v15 = v57 + bit32.lshift(v59, 16)
            local v60 = bit32.lshift(v31, 24)
            local v61 = bit32.lshift(v30, 16)
            local v62 = bit32.lshift(v29, 8)
            local v63 = bit32.bor(v60, v61, v62, v28)
            local v64 = bit32.band(v63, 65535) * 2246822519
            local v65 = bit32.rshift(v63, 16) * 2246822519
            local v66 = bit32.band(v65, 65535)
            local v67 = v8 + (v64 + bit32.lshift(v66, 16))
            local v68 = bit32.lrotate(v67, 13)
            local v69 = bit32.band(v68, 65535) * 2654435761
            local v70 = bit32.rshift(v68, 16) * 2654435761
            local v71 = bit32.band(v70, 65535)
            v8 = v69 + bit32.lshift(v71, 16)
            local v72 = bit32.lshift(v35, 24)
            local v73 = bit32.lshift(v34, 16)
            local v74 = bit32.lshift(v33, 8)
            local v75 = bit32.bor(v72, v73, v74, v32)
            local v76 = bit32.band(v75, 65535) * 2246822519
            local v77 = bit32.rshift(v75, 16) * 2246822519
            local v78 = bit32.band(v77, 65535)
            local v79 = v16 + (v76 + bit32.lshift(v78, 16))
            local v80 = bit32.lrotate(v79, 13)
            local v81 = bit32.band(v80, 65535) * 2654435761
            local v82 = bit32.rshift(v80, 16) * 2654435761
            local v83 = bit32.band(v82, 65535)
            v16, v11, v10 = v81 + bit32.lshift(v83, 16), v11 + 4, v10 + 16
        end
        v12 = bit32.lrotate(v14, 1) + bit32.lrotate(v15, 7) + bit32.lrotate(v8, 12) + bit32.lrotate(v16, 18)
    end
    local v84 = v12 + v9
    local v85 = bit32.bor(v84, 0)
    local v86 = v9 // 4
    for v87 = v11, v86 do
        local v88 = v10 + 3
        local v89, v90, v91, v92 = string.byte(v6, v10, v88)
        local v93 = bit32.lshift(v92, 24)
        local v94 = bit32.lshift(v91, 16)
        local v95 = bit32.lshift(v90, 8)
        local v96 = bit32.bor(v93, v94, v95, v89)
        local v97 = bit32.band(v96, 65535) * 3266489917
        local v98 = bit32.rshift(v96, 16) * 3266489917
        local v99 = bit32.band(v98, 65535)
        local v100 = v85 + (v97 + bit32.lshift(v99, 16))
        local v101 = bit32.lrotate(v100, 17)
        local v102 = bit32.band(v101, 65535) * 668265263
        local v103 = bit32.rshift(v101, 16) * 668265263
        local v104 = bit32.band(v103, 65535)
        v85, v11, v10 = v102 + bit32.lshift(v104, 16), v11 + 1, v10 + 4
    end
    local v105 = -(v9 % 4)
    for v106 = v105, -1 do
        local v107 = string.byte(v6, v106)
        local v108 = bit32.band(v107, 65535) * 374761393
        local v109 = bit32.rshift(v107, 16) * 374761393
        local v110 = bit32.band(v109, 65535)
        local v111 = v85 + (v108 + bit32.lshift(v110, 16))
        local v112 = bit32.lrotate(v111, 11)
        local v113 = bit32.band(v112, 65535) * 2654435761
        local v114 = bit32.rshift(v112, 16) * 2654435761
        local v115 = bit32.band(v114, 65535)
        v85 = v113 + bit32.lshift(v115, 16)
    end
    local v116 = bit32.rshift(v85, 15)
    local v117 = bit32.bxor(v85, v116)
    local v118 = bit32.band(v117, 65535) * 2246822519
    local v119 = bit32.rshift(v117, 16) * 2246822519
    local v120 = bit32.band(v119, 65535)
    local v121 = v118 + bit32.lshift(v120, 16)
    local v122 = bit32.rshift(v121, 13)
    local v123 = bit32.bxor(v121, v122)
    local v124 = bit32.band(v123, 65535) * 3266489917
    local v125 = bit32.rshift(v123, 16) * 3266489917
    local v126 = bit32.band(v125, 65535)
    local v127 = v124 + bit32.lshift(v126, 16)
    local v128 = bit32.rshift(v127, 16)
    return (bit32.bxor(v127, v128))
end
