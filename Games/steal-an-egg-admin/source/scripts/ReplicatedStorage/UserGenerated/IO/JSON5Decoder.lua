-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    "\225\154\128",
    "\226\128\128",
    "\226\128\129",
    "\226\128\130",
    "\226\128\131",
    "\226\128\132",
    "\226\128\133",
    "\226\128\134",
    "\226\128\135",
    "\226\128\136",
    "\226\128\137",
    "\226\128\138",
    "\226\128\168",
    "\226\128\169",
    "\226\128\175",
    "\226\129\159",
    "\227\128\128",
    "\194\160",
    "\r\n",
    "\t",
    "\n",
    "\011",
    "\012",
    "\r",
    " "
}
local v2 = { "\226\128\168", "\226\128\169", "\r\n", "\r", "\n" }

local function MAKE_LOOKUP(v3) -- line 40
    local v4 = {}
    for v5, v6 in ipairs(v3) do
        v4[v6] = true
    end
    return v4
end

local v7 = {}
for v8, v9 in ipairs(v1) do
    v7[v9] = true
end
local v11 = {}
for v12, v13 in ipairs(v2) do
    v11[v13] = true
end
local v14 = {
    ["0"] = "\000",
    ["'"] = "'",
    ["\""] = "\"",
    ["\\"] = "\\",
    b = "\008",
    f = "\012",
    n = "\n",
    r = "\r"
}

v14.t = "\t"
v14.v = "\011"

local function Q(v15) -- line 67
    return (string.format("%q", v15):gsub("\r", "\\r"):gsub("\n", "\\n"))
end

local function formatError(v16, v17) -- line 72
    return string.format("%s at line %d col %d", v16, v17[1], v17[2])
end

local function advanceNewline(v18, v19) -- line 75 | captures: v11
    if v11[v18] then
        v19[1] += 1
        v19[2] = 1
        return true
    end
    return false
end

local function getNewline(v20, v21) -- line 83 | captures: v2, v11
    for v22, v23 in ipairs(v2) do
        if v20:sub(1, #v23) == v23 and v11[v23] then
            v21[1] += 1
            v21[2] = 1
            return v23
        end
    end
    return nil
end

local function getWhitespace(v24, v25) -- line 102 | captures: v1, v11
    if #v24 ~= 0 then
        for v26, v27 in ipairs(v1) do
            if v24:sub(1, #v27) == v27 then
                v25[2] += #v27
                if v11[v27] then
                    v25[1] += 1
                    v25[2] = 1
                end
                return v27
            end
        end
    end
    return nil
end

local function stripWhitespace(v28, v29) -- line 119 | captures: getWhitespace
    while true do
        if getWhitespace(v28, v29) == nil then
            break
        end
    end
    return v28
end

local function stripInlineComments(v30, v31) -- line 129 | captures: getNewline
    local v32
    while true do
        if #v30 == 0 then
            return v30
        end
        v32 = getNewline(v30, v31)
        if v32 then
            break
        end
        v31[2] += 1
    end
    return (v30:sub(#v32 + 1))
end

local function stripBlockComments(v33, v34) -- line 140 | captures: formatError, getNewline
    while true do
        if #v33 > 0 then
            if v33:sub(1, 2) == "*/" then
                break
            end
            if not getNewline(v33, v34) then
                v34[2] += 1
            end
            continue
        end
        error(formatError("missing multiline comment close tag", v34))
        return ""
    end
    v34[2] += 2
    return v33:sub(3)
end

local function codepointToutf8(v35) -- line 155
    if v35 <= 127 then
        return (string.char(v35))
    end
    if v35 <= 2047 then
        local v36 = v35 / 64
        local v37 = math.floor(v36) + 192
        local v38 = v35 % 64 + 128
        return (string.char(v37, v38))
    end
    if v35 <= 65535 then
        local v39 = v35 / 4096
        local v40 = math.floor(v39) + 224
        local v41 = v35 % 4096 / 64
        local v42 = math.floor(v41) + 128
        local v43 = v35 % 64 + 128
        return (string.char(v40, v42, v43))
    end
    if v35 > 1114111 then
        return nil, string.format("invalid unicode codepoint '%x'", v35)
    end
    local v44 = v35 / 262144
    local v45 = math.floor(v44) + 240
    local v46 = v35 % 262144 / 4096
    local v47 = math.floor(v46) + 128
    local v48 = v35 % 4096 / 64
    local v49 = math.floor(v48) + 128
    local v50 = v35 % 64 + 128
    return (string.char(v45, v47, v49, v50))
end

local function parseUnicodeImpl(v51, v52) -- line 177 | captures: formatError
    local v53 = v51:match("^\\u(%x%x%x%x)")
    if not v53 then
        error(formatError("invalid unicode hex escape sequence", v52))
    end
    local v54 = tonumber(v53, 16)
    if not v54 then
        error(formatError("invalid unicode hex escape sequence", v52))
    end
    v52[2] += 6
    return v54, v51:sub(7)
end

local function getSurrogatePair(v55, v56) -- line 189
    return (v56 - 55296) * 1024 + (v55 - 56320) + 65536
end

local function parseUnicode(v57, v58) -- line 192 | captures: formatError, codepointToutf8, parseUnicodeImpl
    local v59, v60 = parseUnicodeImpl(v57, v58)
    if v59 >= 55296 and v59 < 56320 then
        local v61
        v61, v60 = parseUnicodeImpl(v60, v58)
        if v61 and v61 >= 56320 and v61 <= 57343 then
            v59 = (v59 - 55296) * 1024 + (v61 - 56320) + 65536
        end
    end
    local v62, v63 = codepointToutf8(v59)
    if not v62 then
        local v64 = assert(v63)
        error(formatError(v64, {
            v58[1],
            v58[2]
        }))
    end
    return v62, v60
end

local function parseStringImpl(v65, v66, v67, v68) -- line 213 | captures: v14, formatError, getNewline, parseUnicode
    local v69 = {}
    local v70 = v65
    while true do
        if v66(v70) then
            break
        end
        local v71 = v70:sub(1, 1)
        local v72
        if v71 == "\\" then
            local v73 = v70:sub(2, 2)
            v68[2] += 1
            if v14[v73] then
                v68[2] += 1
                if v67 then
                    error(formatError("escape sequence not allowed", v68))
                end
                v69[#v69 + 1] = v14[v73]
                v72 = v70:sub(3)
            elseif v73 == "u" then
                local v74
                v74, v72 = parseUnicode(v70, v68)
                v69[#v69 + 1] = v74
            elseif v73 == "x" then
                if v67 then
                    error(formatError("hex escape sequence not allowed", v68))
                end
                v68[2] += 2
                local v75 = v70:sub(2, 3)
                local v76 = tonumber(v75, 16)
                if not v76 then
                    error(formatError("invalid hex escape sequence", v68))
                end
                v69[#v69 + 1] = string.char(v76)
                v68[2] += 2
                v72 = v70:sub(5)
            else
                if v67 then
                    error(formatError("invalid escape sequence", v68))
                end
                local v77 = v70:sub(2)
                local v78 = getNewline(v77, v68)
                local v79 = if v78 then #v78 + 2 else 2
                v72 = v70:sub(v79)
            end
        elseif v71:byte(1, 1) >= 32 then
            v69[#v69 + 1] = v71
            v72 = v70:sub(2)
            v68[2] += 1
        else
            error(formatError("control character found", v68))
            v72 = v70
        end
        v70 = v72
    end
    return table.concat(v69), v70
end

local function parseString(v80, v81) -- line 268 | captures: parseStringImpl
    local v82 = v80:sub(1, 1)
    local v83 = v80:sub(2)
    local v84, v85 = parseStringImpl(v83, function(v86) -- line 272 | captures: v82
        return v86:sub(1, 1) == v82
    end, false, v81)
    v81[2] += 1
    return v84, v85:sub(2)
end

local function parseNumber(v87, v88) -- line 280 | captures: formatError, getWhitespace
    local v89 = v87:sub(1, 1)
    local v90 = v88[1]
    local v91 = v88[2]
    local v92, v93
    if v89 == "+" then
        v92 = v87:sub(2)
        v88[2] += 1
        v93 = 1
    elseif v89 == "-" then
        v92 = v87:sub(2)
        v88[2] += 1
        v93 = -1
    else
        v92 = v87
        v93 = 1
    end
    if v92:sub(1, 3) == "NaN" then
        v88[2] += 3
        return (0/0), v92:sub(4)
    end
    if v92:find("Infinity", 1, true) == 1 then
        v88[2] += 8
        return v93 * (1/0), v92:sub(9)
    end
    local v94 = 0
    local v95 = v92
    while true do
        if getWhitespace(v95, v88) then
            break
        end
        local v96 = v95:sub(1, 1)
        if v96 == "" then
            break
        end
        if v96 == "," then
            break
        end
        if v96 == "]" then
            break
        end
        if v96 == "}" then
            break
        end
        v94 += 1
        v95 = v95:sub(2)
        v88[2] += 1
    end
    local v97 = v92:sub(1, v94)
    local v98
    if v97:sub(1, 1) == "0" and v97:sub(2):find("^%d+$") then
    else
        v98 = tonumber(v97)
    end
    if v98 == nil then
        local v99 = "invalid number sequence " .. string.format("%q", v97):gsub("\r", "\\r"):gsub("\n", "\\n")
        error(formatError(v99, { v90, v91 }))
    end
    v88[2] += v94
    return v98 * v93, v92:sub(v94 + 1)
end

local function parseBoolean(v100, v101) -- line 336 | captures: formatError
    if v100:sub(1, 4) == "true" then
        v101[2] += 4
        return true, v100:sub(5)
    end
    if v100:sub(1, 5) == "false" then
        v101[2] += 5
        return false, v100:sub(6)
    end
    error(formatError("invalid boolean literal", v101))
end

local function stripComments(v102, v103) -- line 347 | captures: stripInlineComments, stripBlockComments
    local v104 = v102:sub(1, 2)
    if v104 == "//" then
        v103[2] += 2
        local v105 = v102:sub(3)
        return (stripInlineComments(v105, v103))
    end
    if v104 == "/*" then
        v103[2] += 2
        local v106 = v102:sub(3)
        return stripBlockComments(v106, v103)
    end
    return v102
end

local function stripWhitespaceAndComments(v107, v108) -- line 362 | captures: getWhitespace, stripComments
    while true do
        while true do
            if getWhitespace(v107, v108) == nil then
                break
            end
        end
        if stripComments(v107, v108) == v107 then
            break
        end
    end
    return v107
end

local v109

local function testIdentifier(v110) -- line 374
    local v111 = v110:byte(1, 1)
    if v111 < 48 then
        local v112 = #v110
        for v113 = 1, v112 do
            local v114 = v110:byte(v113, v113)
            if v114 < 36 then
                return false
            end
            if not (v114 >= 37 and v114 <= 47) and not (v114 >= 58 and v114 <= 64) and not (v114 >= 91 and v114 <= 94) then
                if v114 == 96 or v114 >= 123 and v114 <= 128 then
                    return false
                end
            else
                return false
            end
        end
        return true
    end
    if v111 <= 57 then
        return false
    end
end

local function stopIdentifier(v115) -- line 407 | captures: getWhitespace
    if v115:sub(1, 1) == ":" then
        return true
    end
    local v116 = { 0, 0 }
    return getWhitespace(v115, v116) ~= nil
end

local function parseIdentifier(v117, v118) -- line 415 | captures: formatError, parseStringImpl, parseString, testIdentifier, stopIdentifier
    local v119 = v117:sub(1, 1)
    local v120, v121
    if v119 == "'" or v119 == "\"" then
        v120, v121 = parseString(v117, v118)
    else
        v120, v121 = parseStringImpl(v117, stopIdentifier, true, v118)
        if not testIdentifier(v120) then
            local v122 = "invalid identifier " .. string.format("%q", v120):gsub("\r", "\\r"):gsub("\n", "\\n")
            error(formatError(v122, {
                v118[1],
                v118[2]
            }))
        end
    end
    return v120, v121
end

local v123 = {
    ["-"] = parseNumber,
    ["+"] = parseNumber,
    ["."] = parseNumber,
    ["0"] = parseNumber,
    ["1"] = parseNumber,
    ["2"] = parseNumber,
    ["3"] = parseNumber,
    ["4"] = parseNumber
}

v123["5"] = parseNumber
v123["6"] = parseNumber
v123["7"] = parseNumber
v123["8"] = parseNumber
v123["9"] = parseNumber
v123.N = parseNumber
v123.I = parseNumber

function v123.n(v124, v125, v126) -- line 456 | captures: formatError
    if v124:sub(1, 4) ~= "null" then
        error(formatError("invalid null literal", v125))
    end
    v125[2] += 1
    return v126, v124:sub(5)
end

v123.t = parseBoolean
v123.f = parseBoolean
v123["'"] = parseString
v123["\""] = parseString

v123["["] = function(v127, v128, v129) -- line 467 | captures: v109, formatError, stripWhitespaceAndComments
    local v130 = v127:sub(2)
    v128[2] += 1
    local v131 = {}
    local v132
    while true do
        local v133 = stripWhitespaceAndComments(v130, v128)
        if v133:sub(1, 1) == "]" then
            v128[2] += 1
            return v131, (v133:sub(2))
        end
        local v134, v135 = v109(v133, v128, v129)
        local v136 = stripWhitespaceAndComments(v135, v128)
        v131[#v131 + 1] = v134
        local v137 = v136:sub(1, 1)
        v132 = v136:sub(2)
        if v137 == "]" then
            break
        end
        if v137 ~= "," then
            local v138 = "expected comma got " .. string.format("%q", v137):gsub("\r", "\\r"):gsub("\n", "\\n")
            error(formatError(v138, v128))
        end
        v128[2] += 1
        v130 = v132
    end
    v128[2] += 1
    return v131, v132
end

v123["{"] = function(v139, v140, v141) -- line 501 | captures: v109, formatError, stripWhitespaceAndComments, parseIdentifier
    v140[2] += 1
    local v142 = {}
    local v143 = v139:sub(2)
    local v144
    while true do
        local v145 = stripWhitespaceAndComments(v143, v140)
        if v145:sub(1, 1) == "}" then
            v140[2] += 1
            return v142, (v145:sub(2))
        end
        local v146, v147 = parseIdentifier(v145, v140)
        local v148 = stripWhitespaceAndComments(v147, v140)
        if v148:sub(1, 1) ~= ":" then
            local v149 = v148:sub(1, 1)
            local v150 = "expected colon after identifier, got " .. string.format("%q", v149):gsub("\r", "\\r"):gsub("\n", "\\n")
            error(formatError(v150, v140))
        end
        v140[2] += 1
        local v151 = v148:sub(2)
        local v152 = stripWhitespaceAndComments(v151, v140)
        local v153, v154 = v109(v152, v140, v10)
        local v155 = stripWhitespaceAndComments(v154, v140)
        v142[v153] = v153
        local v156 = v155:sub(1, 1)
        v144 = v155:sub(2)
        if v156 == "}" then
            break
        end
        if v156 ~= "," then
            local v157 = "expected comma got " .. string.format("%q", v156):gsub("\r", "\\r"):gsub("\n", "\\n")
            error(formatError(v157, v140))
        end
        v140[2] += 1
        v143 = v144
    end
    v140[2] += 1
    return v142, v144
end

v123[""] = function(v158, v159) -- line 548 | captures: formatError
    error(formatError("unexpected eof", v159))
end

function v109(v160, v161, v162) -- line 551 | captures: formatError, stripWhitespaceAndComments, v123
    local v163 = stripWhitespaceAndComments(v160, v161)
    local v164 = v163:sub(1, 1)
    local v165 = v123[v164]
    if not v165 then
        local v166 = "invalid value literal " .. string.format("%q", v164):gsub("\r", "\\r"):gsub("\n", "\\n")
        error(formatError(v166, v161))
    end
    return v165(v163, v161, v162)
end

local freeze = table.freeze
local v167 = { Null = newproxy(false) }

function v167.Decode(v168, v169) -- line 565 | captures: v109, formatError, stripWhitespaceAndComments
    local v170 = { 1, 1 }
    local v171 = stripWhitespaceAndComments(v168, v170)
    local v172, v173 = v109(v171, v170, v169)
    if #stripWhitespaceAndComments(v173, v170) > 0 then
        error(formatError("trailing garbage", v170))
    end
    return v172
end

return freeze(v167)
