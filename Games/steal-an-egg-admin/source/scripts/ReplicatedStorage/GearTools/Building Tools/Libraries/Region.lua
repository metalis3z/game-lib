-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local pointToObjectSpace = CFrame.new().pointToObjectSpace

local function v2(v3, v4, v5) -- line 71 | captures: pointToObjectSpace
    local v6 = pointToObjectSpace(v3, v5)
    local v7 = v4.x / 2
    local v8 = v4.y / 2
    local v9 = v4.z / 2
    local x = v6.x
    local y = v6.y
    local z = v6.z
    if x * x < v7 * v7 and y * y < v8 * v8 then
        return z * z < v9 * v9
    end
    return false
end

local pointToObjectSpace_2 = CFrame.new().pointToObjectSpace

local function v10(v11, v12, v13, v14) -- line 83 | captures: pointToObjectSpace_2
    local v15 = pointToObjectSpace_2(v11, v13)
    local v16 = v12.x / 2
    local v17 = v12.y / 2
    local v18 = v12.z / 2
    local x = v15.x
    local y = v15.y
    local z = v15.z
    local v19, v20
    if v16 < x then
        local v21 = x - v16
        if v21 then
            v19 = v21
            v20 = true
        elseif x < -v16 then
            local v22 = x + v16
            if v22 then
                v19 = v22
                v20 = true
            else
                v20 = false
            end
        else
            v20 = false
        end
    elseif x < -v16 then
        local v23 = x + v16
        if v23 then
            v19 = v23
            v20 = true
        else
            v20 = false
        end
    else
        v20 = false
    end
    if not v20 then
        v19 = 0
    end
    local v24, v25
    if v17 < y then
        local v26 = y - v17
        if v26 then
            v24 = v26
            v25 = true
        elseif y < -v17 then
            local v27 = y + v17
            if v27 then
                v24 = v27
                v25 = true
            else
                v25 = false
            end
        else
            v25 = false
        end
    elseif y < -v17 then
        local v28 = y + v17
        if v28 then
            v24 = v28
            v25 = true
        else
            v25 = false
        end
    else
        v25 = false
    end
    if not v25 then
        v24 = 0
    end
    local v29, v30
    if v18 < z then
        local v31 = z - v18
        if v31 then
            v29 = v31
            v30 = true
        elseif z < -v18 then
            local v32 = z + v18
            if v32 then
                v29 = v32
                v30 = true
            else
                v30 = false
            end
        else
            v30 = false
        end
    elseif z < -v18 then
        local v33 = z + v18
        if v33 then
            v29 = v33
            v30 = true
        else
            v30 = false
        end
    else
        v30 = false
    end
    if not v30 then
        v29 = 0
    end
    return v19 * v19 + v24 * v24 + v29 * v29 < v14 * v14
end

local components = CFrame.new().components

local function v34(v35, v36, v37, v38, v39) -- line 109 | captures: components
    local v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51 = components(v35)
    local v52, v53, v54, v55, v56, v57, v58, v59, v60, v61, v62, v63 = components(v37)
    local v64 = v36.x / 2
    local v65 = v36.y / 2
    local v66 = v36.z / 2
    local v67 = v38.x / 2
    local v68 = v38.y / 2
    local v69 = v38.z / 2
    local v70 = v52 - v40
    local v71 = v53 - v41
    local v72 = v54 - v42
    local v73 = v43 * v70 + v46 * v71 + v49 * v72
    local v74 = v44 * v70 + v47 * v71 + v50 * v72
    local v75 = v45 * v70 + v48 * v71 + v51 * v72
    local v76 = v55 * v70 + v58 * v71 + v61 * v72
    local v77 = v56 * v70 + v59 * v71 + v62 * v72
    local v78 = v57 * v70 + v60 * v71 + v63 * v72
    local v79, v80
    if v67 < v76 then
        local v81 = v76 - v67
        if v81 then
            v79 = v81
            v80 = true
        elseif v76 < -v67 then
            v81 = v76 + v67
            if v81 then
                v79 = v81
                v80 = true
            else
                v80 = false
            end
        else
            v80 = false
        end
    elseif v76 < -v67 then
        local v82 = v76 + v67
        if v82 then
            v79 = v82
            v80 = true
        else
            v80 = false
        end
    else
        v80 = false
    end
    if not v80 then
        v79 = 0
    end
    local v83, v84
    if v68 < v77 then
        local v85 = v77 - v68
        if v85 then
            v83 = v85
            v84 = true
        elseif v77 < -v68 then
            v85 = v77 + v68
            if v85 then
                v83 = v85
                v84 = true
            else
                v84 = false
            end
        else
            v84 = false
        end
    elseif v77 < -v68 then
        local v86 = v77 + v68
        if v86 then
            v83 = v86
            v84 = true
        else
            v84 = false
        end
    else
        v84 = false
    end
    if not v84 then
        v83 = 0
    end
    local v87, v88
    if v69 < v78 then
        local v89 = v78 - v69
        if v89 then
            v87 = v89
            v88 = true
        elseif v78 < -v69 then
            v89 = v78 + v69
            if v89 then
                v87 = v89
                v88 = true
            else
                v88 = false
            end
        else
            v88 = false
        end
    elseif v78 < -v69 then
        local v90 = v78 + v69
        if v90 then
            v87 = v90
            v88 = true
        else
            v88 = false
        end
    else
        v88 = false
    end
    if not v88 then
        v87 = 0
    end
    local v91, v92
    if v64 < v73 then
        local v93 = v73 - v64
        if v93 then
            v91 = v93
            v92 = true
        elseif v73 < -v64 then
            v93 = v73 + v64
            if v93 then
                v91 = v93
                v92 = true
            else
                v92 = false
            end
        else
            v92 = false
        end
    elseif v73 < -v64 then
        local v94 = v73 + v64
        if v94 then
            v91 = v94
            v92 = true
        else
            v92 = false
        end
    else
        v92 = false
    end
    if not v92 then
        v91 = 0
    end
    local v95, v96
    if v65 < v74 then
        local v97 = v74 - v65
        if v97 then
            v95 = v97
            v96 = true
        elseif v74 < -v65 then
            v97 = v74 + v65
            if v97 then
                v95 = v97
                v96 = true
            else
                v96 = false
            end
        else
            v96 = false
        end
    elseif v74 < -v65 then
        local v98 = v74 + v65
        if v98 then
            v95 = v98
            v96 = true
        else
            v96 = false
        end
    else
        v96 = false
    end
    if not v96 then
        v95 = 0
    end
    local v99, v100
    if v66 < v75 then
        local v101 = v75 - v66
        if v101 then
            v99 = v101
            v100 = true
        elseif v75 < -v66 then
            v101 = v75 + v66
            if v101 then
                v99 = v101
                v100 = true
            else
                v100 = false
            end
        else
            v100 = false
        end
    elseif v75 < -v66 then
        local v102 = v75 + v66
        if v102 then
            v99 = v102
            v100 = true
        else
            v100 = false
        end
    else
        v100 = false
    end
    if not v100 then
        v99 = 0
    end
    local v103 = v79 * v79 + v83 * v83 + v87 * v87
    local v104 = v91 * v91 + v95 * v95 + v99 * v99
    local v105, v106
    if v64 < v65 then
        if v64 < v66 and v64 then
            v105 = v64
            v106 = true
        elseif v66 then
            v105 = v66
            v106 = true
        else
            v106 = false
        end
    else
        v106 = false
    end
    if not v106 then
        if not (v65 < v66) or not v65 then
            v105 = v66
        else
            v105 = v65
        end
    end
    local v107, v108
    if v67 < v68 then
        if v67 < v69 and v67 then
            v107 = v67
            v108 = true
        elseif v69 then
            v107 = v69
            v108 = true
        else
            v108 = false
        end
    else
        v108 = false
    end
    if not v108 then
        if not (v68 < v69) or not v68 then
            v107 = v69
        else
            v107 = v68
        end
    end
    if not (v103 < v105 * v105) and not (v104 < v107 * v107) then
        if v64 * v64 + v65 * v65 + v66 * v66 < v103 or v67 * v67 + v68 * v68 + v69 * v69 < v104 then
            return false
        end
        if v39 == nil then
            local v109 = v43 * v55 + v46 * v58 + v49 * v61
            local v110 = v43 * v56 + v46 * v59 + v49 * v62
            local v111 = v43 * v57 + v46 * v60 + v49 * v63
            local v112 = v44 * v55 + v47 * v58 + v50 * v61
            local v113 = v44 * v56 + v47 * v59 + v50 * v62
            local v114 = v44 * v57 + v47 * v60 + v50 * v63
            local v115 = v45 * v55 + v48 * v58 + v51 * v61
            local v116 = v45 * v56 + v48 * v59 + v51 * v62
            local v117 = v45 * v57 + v48 * v60 + v51 * v63
            local v118 = v69 * v69
            local v119 = v67 * v67
            local v120 = v68 * v68
            local v121 = v64 * v109
            local v122 = v65 * v112
            local v123 = v66 * v115
            local v124 = v64 * v110
            local v125 = v65 * v113
            local v126 = v66 * v116
            local v127 = v64 * v111
            local v128 = v65 * v114
            local v129 = v66 * v117
            local v130 = v121 + v122 + v123 - v76
            local v131, v132
            if v130 * v130 < v119 then
                v131 = v124 + v125 + v126 - v77
                if v131 * v131 < v120 then
                    v132 = v127 + v128 + v129 - v78
                    if v132 * v132 < v118 then
                        return true
                    end
                end
            end
            v131 = -v121 + v122 + v123 - v76
            local v133
            if v131 * v131 < v119 then
                v132 = -v124 + v125 + v126 - v77
                if v132 * v132 < v120 then
                    v133 = -v127 + v128 + v129 - v78
                    if v133 * v133 < v118 then
                        return true
                    end
                end
            end
            v132 = v121 - v122 + v123 - v76
            local v134
            if v132 * v132 < v119 then
                v133 = v124 - v125 + v126 - v77
                if v133 * v133 < v120 then
                    v134 = v127 - v128 + v129 - v78
                    if v134 * v134 < v118 then
                        return true
                    end
                end
            end
            v133 = -v121 - v122 + v123 - v76
            local v135
            if v133 * v133 < v119 then
                v134 = -v124 - v125 + v126 - v77
                if v134 * v134 < v120 then
                    v135 = -v127 - v128 + v129 - v78
                    if v135 * v135 < v118 then
                        return true
                    end
                end
            end
            v134 = v121 + v122 - v123 - v76
            local v136
            if v134 * v134 < v119 then
                v135 = v124 + v125 - v126 - v77
                if v135 * v135 < v120 then
                    v136 = v127 + v128 - v129 - v78
                    if v136 * v136 < v118 then
                        return true
                    end
                end
            end
            v135 = -v121 + v122 - v123 - v76
            local v137
            if v135 * v135 < v119 then
                v136 = -v124 + v125 - v126 - v77
                if v136 * v136 < v120 then
                    v137 = -v127 + v128 - v129 - v78
                    if v137 * v137 < v118 then
                        return true
                    end
                end
            end
            v136 = v121 - v122 - v123 - v76
            local v138
            if v136 * v136 < v119 then
                v137 = v124 - v125 - v126 - v77
                if v137 * v137 < v120 then
                    v138 = v127 - v128 - v129 - v78
                    if v138 * v138 < v118 then
                        return true
                    end
                end
            end
            v137 = -v121 - v122 - v123 - v76
            local v139
            if v137 * v137 < v119 then
                v138 = -v124 - v125 - v126 - v77
                if v138 * v138 < v120 then
                    v139 = -v127 - v128 - v129 - v78
                    if v139 * v139 < v118 then
                        return true
                    end
                end
            end
            v138 = v64 * v64
            v139 = v65 * v65
            local v140 = v66 * v66
            local v141 = v67 * v115
            local v142 = v68 * v116
            local v143 = v67 * v109
            local v144 = v68 * v110
            local v145 = v67 * v112
            local v146 = v68 * v113
            local v147 = v69 * v117
            local v148 = v69 * v111
            local v149 = v69 * v114
            local v150 = (v75 - v66 + v141 + v142) / v117
            local v151, v152
            if v150 * v150 < v118 then
                v151 = v73 + v143 + v144 - v150 * v111
                if v151 * v151 < v138 then
                    v152 = v74 + v145 + v146 - v150 * v114
                    if v152 * v152 < v139 then
                        return true
                    end
                end
            end
            v151 = (v75 + v66 + v141 + v142) / v117
            local v153
            if v151 * v151 < v118 then
                v152 = v73 + v143 + v144 - v151 * v111
                if v152 * v152 < v138 then
                    v153 = v74 + v145 + v146 - v151 * v114
                    if v153 * v153 < v139 then
                        return true
                    end
                end
            end
            v152 = (v75 - v66 - v141 + v142) / v117
            local v154
            if v152 * v152 < v118 then
                v153 = v73 - v143 + v144 - v152 * v111
                if v153 * v153 < v138 then
                    v154 = v74 - v145 + v146 - v152 * v114
                    if v154 * v154 < v139 then
                        return true
                    end
                end
            end
            v153 = (v75 + v66 - v141 + v142) / v117
            local v155
            if v153 * v153 < v118 then
                v154 = v73 - v143 + v144 - v153 * v111
                if v154 * v154 < v138 then
                    v155 = v74 - v145 + v146 - v153 * v114
                    if v155 * v155 < v139 then
                        return true
                    end
                end
            end
            v154 = (v75 - v66 + v141 - v142) / v117
            local v156
            if v154 * v154 < v118 then
                v155 = v73 + v143 - v144 - v154 * v111
                if v155 * v155 < v138 then
                    v156 = v74 + v145 - v146 - v154 * v114
                    if v156 * v156 < v139 then
                        return true
                    end
                end
            end
            v155 = (v75 + v66 + v141 - v142) / v117
            local v157
            if v155 * v155 < v118 then
                v156 = v73 + v143 - v144 - v155 * v111
                if v156 * v156 < v138 then
                    v157 = v74 + v145 - v146 - v155 * v114
                    if v157 * v157 < v139 then
                        return true
                    end
                end
            end
            v156 = (v75 - v66 - v141 - v142) / v117
            local v158
            if v156 * v156 < v118 then
                v157 = v73 - v143 - v144 - v156 * v111
                if v157 * v157 < v138 then
                    v158 = v74 - v145 - v146 - v156 * v114
                    if v158 * v158 < v139 then
                        return true
                    end
                end
            end
            v157 = (v75 + v66 - v141 - v142) / v117
            local v159
            if v157 * v157 < v118 then
                v158 = v73 - v143 - v144 - v157 * v111
                if v158 * v158 < v138 then
                    v159 = v74 - v145 - v146 - v157 * v114
                    if v159 * v159 < v139 then
                        return true
                    end
                end
            end
            v158 = (v73 - v64 + v143 + v144) / v111
            local v160
            if v158 * v158 < v118 then
                v159 = v74 + v145 + v146 - v158 * v114
                if v159 * v159 < v139 then
                    v160 = v75 + v141 + v142 - v158 * v117
                    if v160 * v160 < v140 then
                        return true
                    end
                end
            end
            v159 = (v73 + v64 + v143 + v144) / v111
            local v161
            if v159 * v159 < v118 then
                v160 = v74 + v145 + v146 - v159 * v114
                if v160 * v160 < v139 then
                    v161 = v75 + v141 + v142 - v159 * v117
                    if v161 * v161 < v140 then
                        return true
                    end
                end
            end
            v160 = (v73 - v64 - v143 + v144) / v111
            local v162
            if v160 * v160 < v118 then
                v161 = v74 - v145 + v146 - v160 * v114
                if v161 * v161 < v139 then
                    v162 = v75 - v141 + v142 - v160 * v117
                    if v162 * v162 < v140 then
                        return true
                    end
                end
            end
            v161 = (v73 + v64 - v143 + v144) / v111
            local v163
            if v161 * v161 < v118 then
                v162 = v74 - v145 + v146 - v161 * v114
                if v162 * v162 < v139 then
                    v163 = v75 - v141 + v142 - v161 * v117
                    if v163 * v163 < v140 then
                        return true
                    end
                end
            end
            v162 = (v73 - v64 + v143 - v144) / v111
            local v164
            if v162 * v162 < v118 then
                v163 = v74 + v145 - v146 - v162 * v114
                if v163 * v163 < v139 then
                    v164 = v75 + v141 - v142 - v162 * v117
                    if v164 * v164 < v140 then
                        return true
                    end
                end
            end
            v163 = (v73 + v64 + v143 - v144) / v111
            local v165
            if v163 * v163 < v118 then
                v164 = v74 + v145 - v146 - v163 * v114
                if v164 * v164 < v139 then
                    v165 = v75 + v141 - v142 - v163 * v117
                    if v165 * v165 < v140 then
                        return true
                    end
                end
            end
            v164 = (v73 - v64 - v143 - v144) / v111
            local v166
            if v164 * v164 < v118 then
                v165 = v74 - v145 - v146 - v164 * v114
                if v165 * v165 < v139 then
                    v166 = v75 - v141 - v142 - v164 * v117
                    if v166 * v166 < v140 then
                        return true
                    end
                end
            end
            v165 = (v73 + v64 - v143 - v144) / v111
            local v167
            if v165 * v165 < v118 then
                v166 = v74 - v145 - v146 - v165 * v114
                if v166 * v166 < v139 then
                    v167 = v75 - v141 - v142 - v165 * v117
                    if v167 * v167 < v140 then
                        return true
                    end
                end
            end
            v166 = (v74 - v65 + v145 + v146) / v114
            local v168
            if v166 * v166 < v118 then
                v167 = v75 + v141 + v142 - v166 * v117
                if v167 * v167 < v140 then
                    v168 = v73 + v143 + v144 - v166 * v111
                    if v168 * v168 < v138 then
                        return true
                    end
                end
            end
            v167 = (v74 + v65 + v145 + v146) / v114
            local v169
            if v167 * v167 < v118 then
                v168 = v75 + v141 + v142 - v167 * v117
                if v168 * v168 < v140 then
                    v169 = v73 + v143 + v144 - v167 * v111
                    if v169 * v169 < v138 then
                        return true
                    end
                end
            end
            v168 = (v74 - v65 - v145 + v146) / v114
            local v170
            if v168 * v168 < v118 then
                v169 = v75 - v141 + v142 - v168 * v117
                if v169 * v169 < v140 then
                    v170 = v73 - v143 + v144 - v168 * v111
                    if v170 * v170 < v138 then
                        return true
                    end
                end
            end
            v169 = (v74 + v65 - v145 + v146) / v114
            local v171
            if v169 * v169 < v118 then
                v170 = v75 - v141 + v142 - v169 * v117
                if v170 * v170 < v140 then
                    v171 = v73 - v143 + v144 - v169 * v111
                    if v171 * v171 < v138 then
                        return true
                    end
                end
            end
            v170 = (v74 - v65 + v145 - v146) / v114
            local v172
            if v170 * v170 < v118 then
                v171 = v75 + v141 - v142 - v170 * v117
                if v171 * v171 < v140 then
                    v172 = v73 + v143 - v144 - v170 * v111
                    if v172 * v172 < v138 then
                        return true
                    end
                end
            end
            v171 = (v74 + v65 + v145 - v146) / v114
            local v173
            if v171 * v171 < v118 then
                v172 = v75 + v141 - v142 - v171 * v117
                if v172 * v172 < v140 then
                    v173 = v73 + v143 - v144 - v171 * v111
                    if v173 * v173 < v138 then
                        return true
                    end
                end
            end
            v172 = (v74 - v65 - v145 - v146) / v114
            local v174
            if v172 * v172 < v118 then
                v173 = v75 - v141 - v142 - v172 * v117
                if v173 * v173 < v140 then
                    v174 = v73 - v143 - v144 - v172 * v111
                    if v174 * v174 < v138 then
                        return true
                    end
                end
            end
            v173 = (v74 + v65 - v145 - v146) / v114
            local v175
            if v173 * v173 < v118 then
                v174 = v75 - v141 - v142 - v173 * v117
                if v174 * v174 < v140 then
                    v175 = v73 - v143 - v144 - v173 * v111
                    if v175 * v175 < v138 then
                        return true
                    end
                end
            end
            v174 = (v75 - v66 + v142 + v147) / v115
            local v176
            if v174 * v174 < v119 then
                v175 = v73 + v144 + v148 - v174 * v109
                if v175 * v175 < v138 then
                    v176 = v74 + v146 + v149 - v174 * v112
                    if v176 * v176 < v139 then
                        return true
                    end
                end
            end
            v175 = (v75 + v66 + v142 + v147) / v115
            local v177
            if v175 * v175 < v119 then
                v176 = v73 + v144 + v148 - v175 * v109
                if v176 * v176 < v138 then
                    v177 = v74 + v146 + v149 - v175 * v112
                    if v177 * v177 < v139 then
                        return true
                    end
                end
            end
            v176 = (v75 - v66 - v142 + v147) / v115
            local v178
            if v176 * v176 < v119 then
                v177 = v73 - v144 + v148 - v176 * v109
                if v177 * v177 < v138 then
                    v178 = v74 - v146 + v149 - v176 * v112
                    if v178 * v178 < v139 then
                        return true
                    end
                end
            end
            v177 = (v75 + v66 - v142 + v147) / v115
            local v179
            if v177 * v177 < v119 then
                v178 = v73 - v144 + v148 - v177 * v109
                if v178 * v178 < v138 then
                    v179 = v74 - v146 + v149 - v177 * v112
                    if v179 * v179 < v139 then
                        return true
                    end
                end
            end
            v178 = (v75 - v66 + v142 - v147) / v115
            local v180
            if v178 * v178 < v119 then
                v179 = v73 + v144 - v148 - v178 * v109
                if v179 * v179 < v138 then
                    v180 = v74 + v146 - v149 - v178 * v112
                    if v180 * v180 < v139 then
                        return true
                    end
                end
            end
            v179 = (v75 + v66 + v142 - v147) / v115
            local v181
            if v179 * v179 < v119 then
                v180 = v73 + v144 - v148 - v179 * v109
                if v180 * v180 < v138 then
                    v181 = v74 + v146 - v149 - v179 * v112
                    if v181 * v181 < v139 then
                        return true
                    end
                end
            end
            v180 = (v75 - v66 - v142 - v147) / v115
            local v182
            if v180 * v180 < v119 then
                v181 = v73 - v144 - v148 - v180 * v109
                if v181 * v181 < v138 then
                    v182 = v74 - v146 - v149 - v180 * v112
                    if v182 * v182 < v139 then
                        return true
                    end
                end
            end
            v181 = (v75 + v66 - v142 - v147) / v115
            local v183
            if v181 * v181 < v119 then
                v182 = v73 - v144 - v148 - v181 * v109
                if v182 * v182 < v138 then
                    v183 = v74 - v146 - v149 - v181 * v112
                    if v183 * v183 < v139 then
                        return true
                    end
                end
            end
            v182 = (v73 - v64 + v144 + v148) / v109
            local v184
            if v182 * v182 < v119 then
                v183 = v74 + v146 + v149 - v182 * v112
                if v183 * v183 < v139 then
                    v184 = v75 + v142 + v147 - v182 * v115
                    if v184 * v184 < v140 then
                        return true
                    end
                end
            end
            v183 = (v73 + v64 + v144 + v148) / v109
            local v185
            if v183 * v183 < v119 then
                v184 = v74 + v146 + v149 - v183 * v112
                if v184 * v184 < v139 then
                    v185 = v75 + v142 + v147 - v183 * v115
                    if v185 * v185 < v140 then
                        return true
                    end
                end
            end
            v184 = (v73 - v64 - v144 + v148) / v109
            local v186
            if v184 * v184 < v119 then
                v185 = v74 - v146 + v149 - v184 * v112
                if v185 * v185 < v139 then
                    v186 = v75 - v142 + v147 - v184 * v115
                    if v186 * v186 < v140 then
                        return true
                    end
                end
            end
            v185 = (v73 + v64 - v144 + v148) / v109
            local v187
            if v185 * v185 < v119 then
                v186 = v74 - v146 + v149 - v185 * v112
                if v186 * v186 < v139 then
                    v187 = v75 - v142 + v147 - v185 * v115
                    if v187 * v187 < v140 then
                        return true
                    end
                end
            end
            v186 = (v73 - v64 + v144 - v148) / v109
            local v188
            if v186 * v186 < v119 then
                v187 = v74 + v146 - v149 - v186 * v112
                if v187 * v187 < v139 then
                    v188 = v75 + v142 - v147 - v186 * v115
                    if v188 * v188 < v140 then
                        return true
                    end
                end
            end
            v187 = (v73 + v64 + v144 - v148) / v109
            local v189
            if v187 * v187 < v119 then
                v188 = v74 + v146 - v149 - v187 * v112
                if v188 * v188 < v139 then
                    v189 = v75 + v142 - v147 - v187 * v115
                    if v189 * v189 < v140 then
                        return true
                    end
                end
            end
            v188 = (v73 - v64 - v144 - v148) / v109
            local v190
            if v188 * v188 < v119 then
                v189 = v74 - v146 - v149 - v188 * v112
                if v189 * v189 < v139 then
                    v190 = v75 - v142 - v147 - v188 * v115
                    if v190 * v190 < v140 then
                        return true
                    end
                end
            end
            v189 = (v73 + v64 - v144 - v148) / v109
            local v191
            if v189 * v189 < v119 then
                v190 = v74 - v146 - v149 - v189 * v112
                if v190 * v190 < v139 then
                    v191 = v75 - v142 - v147 - v189 * v115
                    if v191 * v191 < v140 then
                        return true
                    end
                end
            end
            v190 = (v74 - v65 + v146 + v149) / v112
            local v192
            if v190 * v190 < v119 then
                v191 = v75 + v142 + v147 - v190 * v115
                if v191 * v191 < v140 then
                    v192 = v73 + v144 + v148 - v190 * v109
                    if v192 * v192 < v138 then
                        return true
                    end
                end
            end
            v191 = (v74 + v65 + v146 + v149) / v112
            local v193
            if v191 * v191 < v119 then
                v192 = v75 + v142 + v147 - v191 * v115
                if v192 * v192 < v140 then
                    v193 = v73 + v144 + v148 - v191 * v109
                    if v193 * v193 < v138 then
                        return true
                    end
                end
            end
            v192 = (v74 - v65 - v146 + v149) / v112
            local v194
            if v192 * v192 < v119 then
                v193 = v75 - v142 + v147 - v192 * v115
                if v193 * v193 < v140 then
                    v194 = v73 - v144 + v148 - v192 * v109
                    if v194 * v194 < v138 then
                        return true
                    end
                end
            end
            v193 = (v74 + v65 - v146 + v149) / v112
            local v195
            if v193 * v193 < v119 then
                v194 = v75 - v142 + v147 - v193 * v115
                if v194 * v194 < v140 then
                    v195 = v73 - v144 + v148 - v193 * v109
                    if v195 * v195 < v138 then
                        return true
                    end
                end
            end
            v194 = (v74 - v65 + v146 - v149) / v112
            local v196
            if v194 * v194 < v119 then
                v195 = v75 + v142 - v147 - v194 * v115
                if v195 * v195 < v140 then
                    v196 = v73 + v144 - v148 - v194 * v109
                    if v196 * v196 < v138 then
                        return true
                    end
                end
            end
            v195 = (v74 + v65 + v146 - v149) / v112
            local v197
            if v195 * v195 < v119 then
                v196 = v75 + v142 - v147 - v195 * v115
                if v196 * v196 < v140 then
                    v197 = v73 + v144 - v148 - v195 * v109
                    if v197 * v197 < v138 then
                        return true
                    end
                end
            end
            v196 = (v74 - v65 - v146 - v149) / v112
            local v198
            if v196 * v196 < v119 then
                v197 = v75 - v142 - v147 - v196 * v115
                if v197 * v197 < v140 then
                    v198 = v73 - v144 - v148 - v196 * v109
                    if v198 * v198 < v138 then
                        return true
                    end
                end
            end
            v197 = (v74 + v65 - v146 - v149) / v112
            local v199
            if v197 * v197 < v119 then
                v198 = v75 - v142 - v147 - v197 * v115
                if v198 * v198 < v140 then
                    v199 = v73 - v144 - v148 - v197 * v109
                    if v199 * v199 < v138 then
                        return true
                    end
                end
            end
            v198 = (v75 - v66 + v147 + v141) / v116
            local v200
            if v198 * v198 < v120 then
                v199 = v73 + v148 + v143 - v198 * v110
                if v199 * v199 < v138 then
                    v200 = v74 + v149 + v145 - v198 * v113
                    if v200 * v200 < v139 then
                        return true
                    end
                end
            end
            v199 = (v75 + v66 + v147 + v141) / v116
            local v201
            if v199 * v199 < v120 then
                v200 = v73 + v148 + v143 - v199 * v110
                if v200 * v200 < v138 then
                    v201 = v74 + v149 + v145 - v199 * v113
                    if v201 * v201 < v139 then
                        return true
                    end
                end
            end
            v200 = (v75 - v66 - v147 + v141) / v116
            local v202
            if v200 * v200 < v120 then
                v201 = v73 - v148 + v143 - v200 * v110
                if v201 * v201 < v138 then
                    v202 = v74 - v149 + v145 - v200 * v113
                    if v202 * v202 < v139 then
                        return true
                    end
                end
            end
            v201 = (v75 + v66 - v147 + v141) / v116
            local v203
            if v201 * v201 < v120 then
                v202 = v73 - v148 + v143 - v201 * v110
                if v202 * v202 < v138 then
                    v203 = v74 - v149 + v145 - v201 * v113
                    if v203 * v203 < v139 then
                        return true
                    end
                end
            end
            v202 = (v75 - v66 + v147 - v141) / v116
            local v204
            if v202 * v202 < v120 then
                v203 = v73 + v148 - v143 - v202 * v110
                if v203 * v203 < v138 then
                    v204 = v74 + v149 - v145 - v202 * v113
                    if v204 * v204 < v139 then
                        return true
                    end
                end
            end
            v203 = (v75 + v66 + v147 - v141) / v116
            local v205
            if v203 * v203 < v120 then
                v204 = v73 + v148 - v143 - v203 * v110
                if v204 * v204 < v138 then
                    v205 = v74 + v149 - v145 - v203 * v113
                    if v205 * v205 < v139 then
                        return true
                    end
                end
            end
            v204 = (v75 - v66 - v147 - v141) / v116
            local v206
            if v204 * v204 < v120 then
                v205 = v73 - v148 - v143 - v204 * v110
                if v205 * v205 < v138 then
                    v206 = v74 - v149 - v145 - v204 * v113
                    if v206 * v206 < v139 then
                        return true
                    end
                end
            end
            v205 = (v75 + v66 - v147 - v141) / v116
            local v207
            if v205 * v205 < v120 then
                v206 = v73 - v148 - v143 - v205 * v110
                if v206 * v206 < v138 then
                    v207 = v74 - v149 - v145 - v205 * v113
                    if v207 * v207 < v139 then
                        return true
                    end
                end
            end
            v206 = (v73 - v64 + v148 + v143) / v110
            local v208
            if v206 * v206 < v120 then
                v207 = v74 + v149 + v145 - v206 * v113
                if v207 * v207 < v139 then
                    v208 = v75 + v147 + v141 - v206 * v116
                    if v208 * v208 < v140 then
                        return true
                    end
                end
            end
            v207 = (v73 + v64 + v148 + v143) / v110
            local v209
            if v207 * v207 < v120 then
                v208 = v74 + v149 + v145 - v207 * v113
                if v208 * v208 < v139 then
                    v209 = v75 + v147 + v141 - v207 * v116
                    if v209 * v209 < v140 then
                        return true
                    end
                end
            end
            v208 = (v73 - v64 - v148 + v143) / v110
            local v210
            if v208 * v208 < v120 then
                v209 = v74 - v149 + v145 - v208 * v113
                if v209 * v209 < v139 then
                    v210 = v75 - v147 + v141 - v208 * v116
                    if v210 * v210 < v140 then
                        return true
                    end
                end
            end
            v209 = (v73 + v64 - v148 + v143) / v110
            local v211
            if v209 * v209 < v120 then
                v210 = v74 - v149 + v145 - v209 * v113
                if v210 * v210 < v139 then
                    v211 = v75 - v147 + v141 - v209 * v116
                    if v211 * v211 < v140 then
                        return true
                    end
                end
            end
            v210 = (v73 - v64 + v148 - v143) / v110
            local v212
            if v210 * v210 < v120 then
                v211 = v74 + v149 - v145 - v210 * v113
                if v211 * v211 < v139 then
                    v212 = v75 + v147 - v141 - v210 * v116
                    if v212 * v212 < v140 then
                        return true
                    end
                end
            end
            v211 = (v73 + v64 + v148 - v143) / v110
            local v213
            if v211 * v211 < v120 then
                v212 = v74 + v149 - v145 - v211 * v113
                if v212 * v212 < v139 then
                    v213 = v75 + v147 - v141 - v211 * v116
                    if v213 * v213 < v140 then
                        return true
                    end
                end
            end
            v212 = (v73 - v64 - v148 - v143) / v110
            local v214
            if v212 * v212 < v120 then
                v213 = v74 - v149 - v145 - v212 * v113
                if v213 * v213 < v139 then
                    v214 = v75 - v147 - v141 - v212 * v116
                    if v214 * v214 < v140 then
                        return true
                    end
                end
            end
            v213 = (v73 + v64 - v148 - v143) / v110
            local v215
            if v213 * v213 < v120 then
                v214 = v74 - v149 - v145 - v213 * v113
                if v214 * v214 < v139 then
                    v215 = v75 - v147 - v141 - v213 * v116
                    if v215 * v215 < v140 then
                        return true
                    end
                end
            end
            v214 = (v74 - v65 + v149 + v145) / v113
            local v216
            if v214 * v214 < v120 then
                v215 = v75 + v147 + v141 - v214 * v116
                if v215 * v215 < v140 then
                    v216 = v73 + v148 + v143 - v214 * v110
                    if v216 * v216 < v138 then
                        return true
                    end
                end
            end
            v215 = (v74 + v65 + v149 + v145) / v113
            local v217
            if v215 * v215 < v120 then
                v216 = v75 + v147 + v141 - v215 * v116
                if v216 * v216 < v140 then
                    v217 = v73 + v148 + v143 - v215 * v110
                    if v217 * v217 < v138 then
                        return true
                    end
                end
            end
            v216 = (v74 - v65 - v149 + v145) / v113
            local v218
            if v216 * v216 < v120 then
                v217 = v75 - v147 + v141 - v216 * v116
                if v217 * v217 < v140 then
                    v218 = v73 - v148 + v143 - v216 * v110
                    if v218 * v218 < v138 then
                        return true
                    end
                end
            end
            v217 = (v74 + v65 - v149 + v145) / v113
            local v219
            if v217 * v217 < v120 then
                v218 = v75 - v147 + v141 - v217 * v116
                if v218 * v218 < v140 then
                    v219 = v73 - v148 + v143 - v217 * v110
                    if v219 * v219 < v138 then
                        return true
                    end
                end
            end
            v218 = (v74 - v65 + v149 - v145) / v113
            local v220
            if v218 * v218 < v120 then
                v219 = v75 + v147 - v141 - v218 * v116
                if v219 * v219 < v140 then
                    v220 = v73 + v148 - v143 - v218 * v110
                    if v220 * v220 < v138 then
                        return true
                    end
                end
            end
            v219 = (v74 + v65 + v149 - v145) / v113
            local v221
            if v219 * v219 < v120 then
                v220 = v75 + v147 - v141 - v219 * v116
                if v220 * v220 < v140 then
                    v221 = v73 + v148 - v143 - v219 * v110
                    if v221 * v221 < v138 then
                        return true
                    end
                end
            end
            v220 = (v74 - v65 - v149 - v145) / v113
            local v222
            if v220 * v220 < v120 then
                v221 = v75 - v147 - v141 - v220 * v116
                if v221 * v221 < v140 then
                    v222 = v73 - v148 - v143 - v220 * v110
                    if v222 * v222 < v138 then
                        return true
                    end
                end
            end
            v221 = (v74 + v65 - v149 - v145) / v113
            if v221 * v221 < v120 then
                v222 = v75 - v147 - v141 - v221 * v116
                if v222 * v222 < v140 then
                    local v223 = v73 - v148 - v143 - v221 * v110
                    if v223 * v223 < v138 then
                        return true
                    end
                end
            end
            return false
        end
        return v39
    end
    return true
end

local setmetatable_2 = setmetatable
local components_2 = CFrame.new().components
local Workspace_2 = Workspace
local type_2 = type
local IsA = game.IsA
local new = Region3.new
local new_2 = Vector3.new

local function Region3BoundingBox(v224, v225) -- line 289 | captures: components_2, new, new_2
    local v226, v227, v228, v229, v230, v231, v232, v233, v234, v235, v236, v237 = components_2(v224)
    local v238 = v225.x / 2
    local v239 = v225.y / 2
    local v240 = v225.z / 2
    v229 = v229 < 0 and -v229 or v229
    local v241 = v238 * v229
    v230 = v230 < 0 and -v230 or v230
    local v242 = v241 + v239 * v230
    v231 = v231 < 0 and -v231 or v231
    local v243 = v242 + v240 * v231
    v232 = v232 < 0 and -v232 or v232
    local v244 = v238 * v232
    v233 = v233 < 0 and -v233 or v233
    local v245 = v244 + v239 * v233
    v234 = v234 < 0 and -v234 or v234
    local v246 = v245 + v240 * v234
    v235 = v235 < 0 and -v235 or v235
    local v247 = v238 * v235
    v236 = v236 < 0 and -v236 or v236
    local v248 = v247 + v239 * v236
    v237 = v237 < 0 and -v237 or v237
    local v249 = v248 + v240 * v237
    local v250 = v226 - v243
    local v251 = v227 - v246
    local v252 = v228 - v249
    local v253 = new_2(v250, v251, v252)
    local v254 = v226 + v243
    local v255 = v227 + v246
    local v256 = v228 + v249
    return new(v253, (new_2(v254, v255, v256)))
end

local function FindAllPartsInRegion3(v257, v258) -- line 309 | captures: Workspace_2, type_2
    local v259 = if type_2(v258) ~= "table" or not v258 then { v258 } else v258
    return Workspace_2:FindPartsInRegion3WithIgnoreList(v257, v259, (1/0))
end

local function CastPoint(v260, v261) -- line 316 | captures: v2
    return v2(v260.CFrame, v260.Size, v261)
end

local function CastSphere(v262, v263, v264) -- line 322 | captures: v10
    return v10(v262.CFrame, v262.Size, v263, v264)
end

local function CastBox(v265, v266, v267) -- line 328 | captures: v34
    return v34(v265.CFrame, v265.Size, v266, v267)
end

local function CastPart(v268, v269) -- line 334 | captures: v34
    return (v34(v268.CFrame, v268.Size, v269.CFrame, v269.Size))
end

local function CastParts(v270, v271) -- line 341 | captures: v34
    local v272 = {}
    local v273 = #v271
    for v274 = 1, v273 do
        local v275 = v271[v274]
        if v34(v270.CFrame, v270.Size, v275.CFrame, v275.Size) then
            v272[#v272 + 1] = v271[v274]
        end
    end
    return v272
end

local function Cast(v276, v277) -- line 353 | captures: v34, Workspace_2, type_2
    local v278 = {}
    local Region3 = v276.Region3
    local v279 = if type_2(v277) ~= "table" or not v277 then { v277 } else v277
    local v280 = Workspace_2:FindPartsInRegion3WithIgnoreList(Region3, v279, (1/0))
    local v281 = #v280
    for v282 = 1, v281 do
        local v283 = v280[v282]
        if v34(v276.CFrame, v276.Size, v283.CFrame, v283.Size) then
            v278[#v278 + 1] = v280[v282]
        end
    end
    return v278
end

local function NewRegion(v284, v285) -- line 366 | captures: setmetatable_2, Region3BoundingBox, CastPoint, CastSphere, CastBox, CastPart, CastParts, Cast
    local v286 = {
        CFrame = v284,
        Size = v285,
        Region3 = Region3BoundingBox(v284, v285),
        Cast = Cast,
        CastPart = CastPart,
        CastParts = CastParts,
        CastPoint = CastPoint,
        CastSphere = CastSphere,
        CastBox = CastBox
    }
    local v287 = {}
    local v288 = { __index = v286 }

    function v288.__newindex(v289, v290, v291) -- line 380 | captures: v286, Region3BoundingBox
        v286[v290] = v291
        v286.Region3 = Region3BoundingBox(v286.CFrame, v286.Size)
    end

    return (setmetatable_2(v287, v288))
end

v1.Region3BoundingBox = Region3BoundingBox
v1.FindAllPartsInRegion3 = FindAllPartsInRegion3
v1.BoxPointCollision = v2
v1.BoxSphereCollision = v10
v1.BoxCollision = v34
v1.new = NewRegion

function v1.FromPart(v292) -- line 395 | captures: NewRegion
    return (NewRegion(v292.CFrame, v292.Size))
end

return v1
