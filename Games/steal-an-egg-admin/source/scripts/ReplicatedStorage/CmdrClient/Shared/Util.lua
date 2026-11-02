-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TextService = game:GetService("TextService")
local v1 = {
    MakeDictionary = function(v2) -- MakeDictionary | line 8
        local v3 = {}
        local v4 = #v2
        for v6 = 1, v4 do
            v3[v2[v6]] = true
        end
        return v3
    end,
    DictionaryKeys = function(v7) -- DictionaryKeys | line 17
        local v8 = {}
        for v9 in pairs(v7) do
            table.insert(v8, v9)
        end
        return v8
    end
}

local function transformInstanceSet(v10) -- line 25
    local v11 = {}
    local v12 = #v10
    for v13 = 1, v12 do
        v11[v13] = v10[v13].Name
    end
    return v11, v10
end

local function MakeFuzzyFinder(v14) -- line 34
    local v15
    local v16 = {}
    local v17
    if typeof(v14) == "Enum" then
        v17 = v14:GetEnumItems()
    else
        v17 = v14
    end
    if typeof(v17) == "Instance" then
        local v18 = v17:GetChildren()
        local v19 = {}
        local v20 = #v18
        for v21 = 1, v20 do
            v19[v21] = v18[v21].Name
        end
        v15 = v19
        v16 = v18
    elseif typeof(v17) == "table" then
        local v22 = v17[1]
        if typeof(v22) == "Instance" then
            local v23 = {}
            local v24 = #v17
            for v25 = 1, v24 do
                v23[v25] = v17[v25].Name
            end
            v15 = v23
            v16 = v17
        else
            local v26 = v17[1]
            if typeof(v26) ~= "EnumItem" then
                local v27 = v17[1]
                if typeof(v27) == "table" then
                    local Name = v17[1].Name
                    if typeof(Name) ~= "string" then
                        local v28 = v17[1]
                        if type(v28) == "string" then
                            v15 = v17
                        elseif v17[1] == nil then
                            v15 = {}
                        else
                            error("MakeFuzzyFinder only accepts tables of instances or strings.")
                        end
                    end
                else
                    local v29 = v17[1]
                    if type(v29) == "string" then
                        v15 = v17
                    elseif v17[1] == nil then
                        v15 = {}
                    else
                        error("MakeFuzzyFinder only accepts tables of instances or strings.")
                    end
                end
            end
        end
    else
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
    end
    return function(v30, v31) -- line 84 | captures: v15, v16
        local v32 = {}
        for v33, v34 in pairs(v15) do
            local v35 = if v16 then v16[v33] else v34
            if v34:lower() == v30:lower() then
                if v31 then
                    return v35
                end
                table.insert(v32, 1, v35)
            else
                local v36 = v30:lower()
                if v34:lower():find(v36, 1, true) then
                    v32[#v32 + 1] = v35
                end
            end
        end
        if v31 then
            return v32[1]
        end
        return v32
    end
end

v1.MakeFuzzyFinder = MakeFuzzyFinder

local function GetNames(v37) -- line 113
    local v38 = {}
    local v39 = #v37
    for v40 = 1, v39 do
        local Name = v37[v40].Name
        if not Name then
            local v41 = v37[v40]
            Name = tostring(v41)
        end
        v38[v40] = Name
    end
    return v38
end

v1.GetNames = GetNames

local function SplitStringSimple(v42, v43) -- line 128
    local v44 = if v43 == nil then "%s" else v43
    local v45 = {}
    local v46 = 1
    for v47 in string.gmatch(v42, "([^" .. v44 .. "]+)") do
        v45[v46] = v47
        v46 += 1
    end
    return v45
end

v1.SplitStringSimple = SplitStringSimple

local function charCode(v48) -- line 143
    return utf8.char((tonumber(v48, 16)))
end

function v1.ParseEscapeSequences(v49) -- line 146 | captures: charCode
    return v49:gsub("\\(.)", {
        t = "\t",
        n = "\n"
    }):gsub("\\u(%x%x%x%x)", charCode):gsub("\\x(%x%x)", charCode)
end

local function EncodeEscapedOperator(v50, v51) -- line 151
    local v52 = v51:sub(1, 1)
    local v53 = v51:gsub(".", "%%%1")
    return v50:gsub("(" .. ("%" .. v52) .. "+)(" .. v53 .. ")", function(v54, v55) -- line 154
        return (v54:sub(1, #v54 - 1) .. v55):gsub(".", function(v56) -- line 156
            local v57 = string.byte(v56)
            return "\\u" .. string.format("%04x", v57, 16)
        end)
    end)
end

v1.EncodeEscapedOperator = EncodeEscapedOperator

local v58 = { "&&", "||", ";" }

function v1.EncodeEscapedOperators(v59) -- line 163 | captures: v1, v58
    local v60 = v59
    for v61, v62 in ipairs(v58) do
        v60 = v1.EncodeEscapedOperator(v60, v62)
    end
    return v60
end

local function encodeControlChars(v63) -- line 170
    return (v63:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"))
end

local function decodeControlChars(v64) -- line 176
    return (v64:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n"))
end

function v1.SplitString(v65, v66) -- line 181 | captures: v1
    local v67 = v65:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___")
    local v68 = v66 or (1/0)
    local v69 = {}
    local v70, v71
    for v72 in v67:gmatch("[^ ]+") do
        local v73 = v1.ParseEscapeSequences(v72)
        local v74 = v73:match("^(['\"])")
        local v75 = v73:match("(['\"])$")
        local v76 = v73:match("(\\*)['\"]$")
        if v74 then
            if not v71 and not v75 then
                v70 = v73
                v71 = v74
            end
        elseif v70 and v75 == v71 and #v76 % 2 == 0 then
            v73 = v70 .. " " .. v73
            v70 = nil
            v71 = nil
        end
        if not v70 then
            local v77 = if #v69 <= v68 then 1 else 0
            v69[#v69 + v77] = v73:gsub("^(['\"])", ""):gsub("(['\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
        end
    end
    if v70 then
        local v78 = if #v69 <= v68 then 1 else 0
        v69[#v69 + v78] = v70:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
    end
    return v69
end

local function MashExcessArguments(v79, v80) -- line 238
    local v81 = {}
    local v82 = #v79
    for v83 = 1, v82 do
        if v83 <= v80 then
            v81[v83] = v79[v83]
        else
            v81[v80] = ("%s %s"):format(v81[v80] or "", v79[v83])
        end
    end
    return v81
end

v1.MashExcessArguments = MashExcessArguments

local function TrimString(v84) -- line 253
    local v85, v86 = string.find(v84, "^%s*")
    _ = v85
    if v86 == #v84 then
        return ""
    end
    return (string.match(v84, ".*%S", v86 + 1))
end

v1.TrimString = TrimString

function v1.GetTextSize(v87, v88, v89) -- line 261 | captures: TextService
    local v90 = v89 or Vector2.new(v88.AbsoluteSize.X, 0)
    return TextService:GetTextSize(v87, v88.TextSize, v88.Font, v90)
end

local function MakeEnumType(v91, v92) -- line 268
    local v93 = (nil).MakeFuzzyFinder(v92)
    local v94 = {}

    function v94.Validate(v95) -- line 272 | captures: v93, v91
        return v93(v95, true) ~= nil, ("Value %q is not a valid %s."):format(v95, v91)
    end

    function v94.Autocomplete(v96) -- line 276 | captures: v93
        local v97 = v93(v96)
        local v98 = v97[1]
        return type(v98) ~= "string" and v93.GetNames(v97) or v97
    end

    function v94.Parse(v99) -- line 289 | captures: v93
        return v93(v99, true)
    end

    return v94
end

v1.MakeEnumType = MakeEnumType

function v1.ParsePrefixedUnionType(v100, v101) -- line 294 | captures: v1
    local v102 = v1.SplitStringSimple(v100)
    local v103 = {}
    local v104 = #v102
    for v105 = 1, v104, 2 do
        v103[#v103 + 1] = {
            prefix = v102[v105 - 1] or "",
            type = v102[v105]
        }
    end
    table.sort(v103, function(v106, v107) -- line 303
        local v108 = #v106.prefix
        return #v107.prefix < v108
    end)
    local v109 = #v103
    for v110 = 1, v109 do
        local v111 = v103[v110]
        if v101:sub(1, #v111.prefix) == v111.prefix then
            local v112 = v101:sub(#v111.prefix + 1)
            return v111.type, v112, v111.prefix
        end
    end
end

local function MakeListableType(v113, v114) -- line 319
    local v115 = {
        Listable = true,
        Transform = v113.Transform,
        Validate = v113.Validate,
        ValidateOnce = v113.ValidateOnce,
        Autocomplete = v113.Autocomplete,
        Default = v113.Default,
        ArgumentOperatorAliases = v113.ArgumentOperatorAliases
    }

    function v115.Parse(...) -- line 328 | captures: v113
        return { v113.Parse(...) }
    end

    if v114 then
        for v116, v117 in pairs(v114) do
            v115[v116] = v117
        end
    end
    return v115
end

v1.MakeListableType = MakeListableType

local function encodeCommandEscape(v118) -- line 339
    return (v118:gsub("\\%$", "___!CMDR_DOLLAR!___"))
end

local function decodeCommandEscape(v119) -- line 342
    return (v119:gsub("___!CMDR_DOLLAR!___", "$"))
end

function v1.RunCommandString(v120, v121) -- line 345 | captures: v1
    local function v122(...)
        return (tostring(...))
    end

    local v123 = v1.ParseEscapeSequences(v121)
    local v124 = v1.EncodeEscapedOperators(v123):split("&&")
    local v125 = ""
    for v126, v127 in ipairs(v124) do
        local v128 = v125:gsub("%$", "\\x24"):gsub("%%", "%%%%")
        if v125:find("%s") then
            v128 = ("%q"):format(v128)
        end
        v125 = v122(v120:EvaluateAndRun((v1.RunEmbeddedCommands(v120, (v127:gsub("||", v128))))))
        if v126 == #v124 then
            return v125
        end
    end
end

function v1.RunEmbeddedCommands(v129, v130) -- line 366 | captures: v1
    local v131 = v130:gsub("\\%$", "___!CMDR_DOLLAR!___")
    local v132 = {}
    for v133 in v131:gmatch("$(%b{})") do
        local v134 = v133:sub(2, #v133 - 1)
        local v135
        if v134:match("^{.+}$") then
            v135, v134 = false, v134:sub(2, #v134 - 1)
        else
            v135 = true
        end
        v132[v133] = v1.RunCommandString(v5, v134)
        if v135 then
            if v132[v133]:find("%s") then
                v132[v133] = string.format("%q", v132[v133])
            elseif v132[v133] == "" then
            end
        end
    end
    return (v131:gsub("$(%b{})", v132):gsub("___!CMDR_DOLLAR!___", "$"))
end

local function SubstituteArgs(v136, v137) -- line 388
    local v138 = v136:gsub("\\%$", "___!CMDR_DOLLAR!___")
    if type(v137) == "table" then
        local v139 = #v137
        for v140 = 1, v139 do
            local v141 = tostring(v140)
            v137[v141] = v137[v140]
            if v137[v141]:find("%s") then
                v137[v141] = string.format("%q", v137[v141])
            end
        end
    end
    return (v138:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", v137):gsub("___!CMDR_DOLLAR!___", "$"))
end

v1.SubstituteArgs = SubstituteArgs

function v1.MakeAliasCommand(v142, v143) -- line 410 | captures: v1
    local function v144(...)
        local v145, v146 = unpack(...)
        return v145, v146
    end

    local function v147(...)
        local v148, v149, v150 = unpack(...)
        return v148, v149, v150
    end

    local v151, v152 = v144(v142:split("|"))
    local v153 = {}
    local v154 = v1.EncodeEscapedOperators(v143)
    local v155 = {}
    for v156 in v154:gmatch("$(%d+)") do
        if v155[v156] == nil then
            v155[v156] = true
            local v157 = v154:match((("$%*(%%b{})"):format(v156)))
            local v158, v159, v160
            if v157 then
                v158, v159, v160 = v147(v157:sub(2, #v157 - 1):split("|"))
            end
            local v161
            if v158 then
                local v162 = not not v158:match("%?$")
                v161 = v158:match("^%w+")
            else
                v161 = "string"
            end
            local v163 = v159 or ("Argument %*"):format(v156)
            local v164 = {
                Type = v161,
                Name = v163,
                Description = v160 or "",
                Optional = v163
            }
            table.insert(v153, v164)
        end
    end
    local v165 = {
        Group = "UserAlias",
        Name = v151,
        Aliases = {},
        Description = ("<Alias> %*"):format(v152 or v154),
        Args = v153
    }

    function v165.Run(v166) -- line 451 | captures: v154, v1
        return v1.RunCommandString(v166.Dispatcher, v1.SubstituteArgs(v154, v166.RawArguments))
    end

    return v165
end

function v1.MakeSequenceType(v167) -- line 456 | captures: v1
    local v168 = v167 or {}
    local v169 = if v168.Parse == nil then v168.Constructor ~= nil else true
    assert(v169, "MakeSequenceType: Must provide one of: Constructor, Parse")
    local TransformEach = v168.TransformEach or function(...) -- TransformEach | line 467
        return ...
    end
    v168.TransformEach = TransformEach
    local ValidateEach = v168.ValidateEach or function() -- ValidateEach | line 474
        return true
    end
    v168.ValidateEach = ValidateEach
    local v170 = { Prefixes = v168.Prefixes }

    function v170.Transform(v171) -- line 481 | captures: v168, v1
        local v172 = v1.SplitPrioritizedDelimeter(v171, { ",", "%s" })
        return v1.Map(v172, function(v173) -- line 483 | captures: v168
            return v168.TransformEach(v173)
        end)
    end

    function v170.Validate(v174) -- line 487 | captures: v168
        if v168.Length then
            if v168.Length < #v174 then
                return false, ("Maximum of %d values allowed in sequence"):format(v168.Length)
            end
        else
            local v175 = v168.Length or #v174
            for v176 = 1, v175 do
                local v177, v178 = v168.ValidateEach(v174[v176], v176)
                if not v177 then
                    return false, v178
                end
            end
            return true
        end
    end

    v170.Parse = v168.Parse or function(v179) -- Parse | line 510 | captures: v168
        return v168.Constructor(unpack(v179))
    end
    return v170
end

function v1.SplitPrioritizedDelimeter(v180, v181) -- line 517 | captures: v1
    for v182, v183 in ipairs(v181) do
        if v180:find(v183) or v182 == #v181 then
            return v1.SplitStringSimple(v180, v183)
        end
    end
end

local function Map(v184, v185) -- line 525
    local v186 = {}
    for v187, v188 in ipairs(v184) do
        v186[v187] = v185(v188, v187)
    end
    return v186
end

v1.Map = Map

local function Each(v189, ...) -- line 532
    local v190 = {}
    local v191 = { ... }
    for v192, v193 in ipairs(v191) do
        v190[v192] = v189(v193)
    end
    return unpack(v190)
end

v1.Each = Each

local function EmulateTabstops(v194, v195) -- line 540
    local function v196(v197, ...)
        table.insert(v197, ...)
    end

    local v198 = #v194
    local v199 = table.create(v198)
    local v200 = 0
    for v201 = 1, v198 do
        local v202 = string.sub(v194, v201, v201)
        if v202 == "\t" then
            local v203 = v195 - v200 % v195
            v196(v199, string.rep(" ", v203))
            v200 += v203
        else
            table.insert(v199, v202)
            if v202 == "\n" then
                v200 = 0
            elseif v202 ~= "\r" then
                v200 += 1
            end
        end
    end
    return table.concat(v199)
end

v1.EmulateTabstops = EmulateTabstops

local function Mutex() -- line 565
    local v204 = {}
    local v205 = false
    return function() -- line 568 | captures: v205, v204
        local function v206(v207, ...)
            table.insert(v207, ...)
        end

        if v205 then
            v206(v204, coroutine.running())
            coroutine.yield()
        else
            v205 = true
        end
        return function() -- line 575 | captures: v205, v204
            if #v204 > 0 then
                coroutine.resume(table.remove(v204, 1))
            else
                v205 = false
            end
        end
    end
end

v1.Mutex = Mutex
return v1
