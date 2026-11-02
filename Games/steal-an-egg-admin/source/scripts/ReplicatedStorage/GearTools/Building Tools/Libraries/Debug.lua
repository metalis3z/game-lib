-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    DirectoryToString = function(v2) -- DirectoryToString | line 8
        return (v2:GetFullName():gsub("%.(%w*%s%w*)", "%[\"%1\"%]"):gsub("%.(%d+[%w%s]+)", "%[\"%1\"%]"):gsub("%.(%d+)", "%[%1%]"))
    end
}

function v1.Stringify(v3) -- line 23 | captures: v1
    local v4 = typeof(v3)
    local v5
    if v4 == "Instance" then
        v4, v5 = v3.ClassName, v1.DirectoryToString(v3)
    else
        v5 = tostring(v3)
    end
    if v4 ~= v5 or not v5 then
        v5 = v4 .. " " .. v5
    end
    return v5
end

local v6 = {
    ["Index ?"] = "__index",
    ["Newindex ?"] = "__newindex"
}

local function Format(v7, ...) -- line 53
    return v7:format(...)
end

local v8 = { Name = "Command bar" }
local v9

function v9(v10, ...) -- line 59 | captures: v9, v1, v6, Format, v8
    local v11 = { ... }
    local v12 = debug.traceback()
    local v13 = select(2, v12:gsub("\n", "")) - 2
    local v14, v15 = v10:gsub("^!", "", 1)
    local script, v16, v17
    if v15 == 1 then
        local v18 = table.remove(v11, 1)
        if v18 then
            v16 = v18
            v17 = true
        else
            script = getfenv(v13).script or v8
            v17 = false
        end
    else
        script = getfenv(v13).script or v8
        v17 = false
    end
    if not v17 then
        v16 = script.Name
    end
    local v19 = select("#", ...)
    for v20 = 1, v19 do
        v11[v20] = v1.Stringify(v11[v20])
    end
    local v21
    for v22 in v12:sub(1, -11):gmatch("%- [^\r\n]+[\r\n]") do
        v21 = v22
    end
    local v23 = v21:sub(3, -2):gsub("%l+ (%S+)$", "%1"):gsub("^%l", string.upper, 1):gsub(" ([^\n\r]+)", " %1", 1)
    local v24 = 0
    for v25 in v14:gmatch("%%%l") do
        v24 += 1
        if v25 == "%q" then
            v11[v24] = v11[v24]:gsub(" (%S+)$", " \"%1\"", 1)
        end
    end
    local v26, v27 = pcall(Format, "[%s] {%s} " .. v14:gsub("%%q", "%%s"), v16, v6[v23] or v23, unpack(v11))
    if v26 then
        return v27, v13
    end
    error(v9("!Error formatting failed, perhaps try escaping non-formattable tags like so: %%%%f\n(Error Message): " .. v27, "Debug"))
end

function v1.Warn(...) -- line 97 | captures: v9
    warn((v9(...)))
end

function v1.Error(...) -- line 101 | captures: v9
    error(v9(...))
end

function v1.Assert(v28, ...) -- line 105 | captures: v9
    return v28 or error(v9(...))
end

local function Alphabetically(v29, v30) -- line 111
    local v31 = type(v29)
    local v32 = type(v30)
    if v31 == v32 then
        if v31 == "number" then
            return v29 < v30
        end
        return tostring(v29):lower() < tostring(v30):lower()
    end
    return v31 < v32
end

function v1.AlphabeticalOrder(v33) -- line 126 | captures: Alphabetically
    local v34 = {}
    local v35 = 0
    for v36 in next, v33 do
        v35 += 1
        v34[v35] = v36
    end
    require(script.SortedArray).new(v34, Alphabetically)
    return function(v37, v38) -- line 144 | captures: v34
            local v39 = if v38 == nil then 1 else (v34:Find(v38) or error("invalid key to 'AlphabeticalOrder' " .. tostring(v38))) + 1
            local v40 = v34[v39]
            return v40, v37[v40]
        end,
        v33,
        nil
end

function v1.UnionIteratorFunctions(...) -- line 151 | captures: v9
    local v41 = { ... }
    local v42 = #v41
    for v43 = 1, v42 do
        local v44 = v41[v43]
        if type(v44) ~= "function" then
            error(v9("Cannot union Iterator functions which aren't functions"))
        end
    end
    return function(v45) -- line 165 | captures: v41, v9
        local v46 = 0
        local v47 = {}
        v47[0] = {}
        local v48 = {}
        local v49 = #v41
        local v50 = 0
        for v51 = 1, v49 do
            local v52, v53, v54 = v41[v51](v45)
            if type(v52) == "function" then
                if type(v53) ~= "table" then
                    error(v9("Iterator function " .. v51 .. " must return a stack of types as follows: Function, Table, Variant"))
                end
            else
                error(v9("Iterator function " .. v51 .. " must return a stack of types as follows: Function, Table, Variant"))
            end
            while true do
                local v55 = { v52(v53, v54) }
                v54 = v55[1]
                if v54 == nil then
                    break
                end
                if not v48[v54] then
                    v48[v54] = true
                    local v56 = v50 + 1
                    v46 = v56
                    v55[#v55 + 1] = v51
                    v47[v56] = v55
                    v50 = v56
                end
            end
        end
        return function(v57, v58) -- line 190 | captures: v46, v47, v9
                local v59 = v46
                for v60 = 0, v59 do
                    if v47[v60][1] == v58 then
                        local v61 = v47[v60 + 1]
                        if v61 then
                            return unpack(v61)
                        end
                        return nil
                    end
                end
                error(v9("invalid key to unioned iterator function: " .. v58))
            end,
            v45,
            nil
    end
end

local function Get0(v62) -- line 213
    return function(v63, v64) -- line 214
            if v64 ~= nil or v63[0] == nil then
                return
            end
            return 0, v63[0]
        end,
        v62,
        nil
end

local v65 = typeof or type
local v66 = v1.UnionIteratorFunctions(Get0, ipairs, v1.AlphabeticalOrder)
local v67

local function Parse(v68, v69, v70, v71) -- line 225 | captures: v67, v1, v65
    local function v72(v73, ...)
        table.insert(v73, ...)
    end

    local v74 = v65(v68)
    if v74 == "table" then
        for v75, v76 in next, v71 do
            if v76 == v68 then
                if v75 == 1 then
                    return "[self]"
                end
                return "[table " .. v75 .. "]"
            end
        end
        return v67(v68, nil, v69, (v70 or 1) + 1, v71)
    end
    if v74 == "string" then
        local v77 = {}
        local v78 = #v68 / 60
        local v79 = math.ceil(v78)
        for v80 = 1, v79 do
            v72(v77, v68:sub((v80 - 1) * 60 + 1, v80 * 60))
        end
        return "\"" .. table.concat(v77, "\n" .. ("   "):rep(v70 + 1)) .. "\""
    end
    local v81, v82
    if v74 == "Instance" then
        local v83 = "<" .. v1.DirectoryToString(v68) .. ">"
        if v83 then
            v81 = v83
            v82 = true
        elseif v74 == "function" then
            if v74 then
                v81 = v74
                v82 = true
            else
                v82 = false
            end
        elseif v74 == "userdata" and v74 then
            v81 = v74
            v82 = true
        else
            v82 = false
        end
    elseif v74 == "function" then
        if v74 then
            v81 = v74
            v82 = true
        else
            v82 = false
        end
    elseif v74 == "userdata" and v74 then
        v81 = v74
        v82 = true
    else
        v82 = false
    end
    if not v82 then
        v81 = tostring(v68)
    end
    return v81
end

function v67(v84, v85, v86, v87, v88) -- line 256 | captures: v9, v67, v66, Parse, v65
    if type(v84) == "table" then
        v88[#v88 + 1] = v84
        local v89 = {}
        local v90 = 0
        for v91, v92, v93 in v66(v84) do
            if v93 < 1 then
                if v90 == 0 and v86 then
                    v89[v90 + 1] = "\n"
                    v89[v90 + 2] = ("   "):rep(v87)
                    v90 += 2
                end
                local v94 = v90 + 1
                local v95 = if v93 == 1 then "[0] = " else ""
                v89[v94] = v95 .. Parse(v92, v86, v87, v88)
                v89[v90 + 2] = ", "
                v90 += 2
            else
                local v96
                if v86 then
                    v96 = v90 + 1
                    v89[v96] = "\n"
                    v89[v96 + 1] = ("   "):rep(v87)
                else
                    v96 = v90 - 1
                end
                if type(v91) == "string" then
                    if v91:find("^%d") or v91:find("%s") then
                        v89[v96 + 2] = "["
                        v89[v96 + 3] = Parse(v91, v86, v87, v88)
                        v89[v96 + 4] = "]"
                    else
                        v89[v96 + 2] = v91
                        v96 -= 2
                    end
                else
                    v89[v96 + 2] = "["
                    v89[v96 + 3] = Parse(v91, v86, v87, v88)
                    v89[v96 + 4] = "]"
                end
                v89[v96 + 5] = " = "
                v89[v96 + 6] = Parse(v92, v86, v87, v88)
                local v97 = v96 + 7
                if v86 then
                    v89[v97] = ";"
                else
                    v89[v97] = ", "
                end
                v90 = v96 + 7
            end
        end
        local v98
        if v89[v90] == ", " then
            if v86 then
                v98 = 1 + 2
            else
                v98 = 1
            end
            v90 -= 1
        elseif v86 then
            if v90 == 0 then
                v98 = 1
            else
                v89[v90 + 1] = "\n"
                v89[v90 + 2] = ("   "):rep(v87)
                v90 += 2
                v98 = 1
            end
        else
            v98 = 1
        end
        local v99 = getmetatable(v84)
        local v100 = v98 - 1
        if not (v86 and v89[v90 - 1] == "\n") then
            v90 += 1
        end
        v89[v100] = "{"
        v89[v90] = v90 > 1 and ("   "):rep(v87 - 1) .. "}" or "}"
        if v99 then
            if type(v99) == "table" then
                v89[v90 + 1] = " <- "
                v89[v90 + 2] = v67(v99, nil, v86, v87, v88)
                v90 += 2
            else
                warn((v9((v85 or "Table") .. "'s metatable cannot be accessed. Got:\n" .. tostring(v99))))
            end
        end
        if v85 then
            v89[v100 - 1] = " = "
            v89[v100 - 2] = v85
            v100 -= 2
        end
        return table.concat(v89, "", v100, v90)
    end
    error(v9("[Debug] TableToString needs a table to convert to a string! Got type " .. v65(v84)))
end

function v1.TableToString(v101, v102, v103) -- line 346 | captures: v67
    return v67(v101, v102, v103, 1, {})
end

local v104 = {
    "%",
    "^",
    "$",
    "(",
    ")",
    ".",
    "[",
    "]",
    "*",
    "+",
    "-",
    "?"
}
local v105 = "([%" .. table.concat(v104, "%") .. "])"

function v1.EscapeString(v106) -- line 361 | captures: v105
    return (v106:gsub(v105, "%%%1"):gsub("([\"'\\])", "\\%1"))
end

function v1.Inspect(v107) -- line 381 | captures: v1
    if type(v107) == "table" then
        return "table " .. v1.TableToString(v107)
    end
    return v1.Stringify(v107)
end

return v1
