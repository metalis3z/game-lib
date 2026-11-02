-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local sort = table.sort
local insert = table.insert
local v1 = {}
local v2 = {}
local v3 = { __mode = "k" }
local v4 = setmetatable(v2, v3)

v1.__index = {
    Unpack = unpack,
    Concat = table.concat,
    RemoveIndex = table.remove
}

function v1.new(v5, v6) -- line 16 | captures: sort, v1, v4
    local v7
    if v5 then
        sort(v5, v6)
        v7 = v5
    else
        v7 = {}
    end
    v4[v7] = v6
    return (setmetatable(v7, v1))
end

local function FindClosest(v8, v9, v10, v11, v12, v13) -- line 27 | captures: v4
    local v14 = v10 + v11
    local v15 = (v14 - v14 % 2) / 2
    if v15 == 0 then
        return nil
    end
    local v16 = v13 or v4[v8]
    local v17, v18, v19 = v10, v11, v8[v15]
    while true do
        if v15 == v18 then
            return v15
        end
        if v12 then
            if v12(v9, v19) then
                break
            end
        elseif v9 == v19 then
            return v15
        end
        local v20
        if v16 then
            v20 = v16(v9, v19)
        else
            v20 = not not (v9 < v19)
        end
        if v20 then
            v18 = v15 - 1
        else
            v17 = v15 + 1
        end
        local v21 = v17 + v18
        v15 = (v21 - v21 % 2) / 2
        v19 = v8[v15]
    end
    return v15
end

local function Insert(v22, v23) -- line 71 | captures: insert, v4, FindClosest
    local v24 = FindClosest(v22, v23, 1, #v22)
    local v25 = v22[v24]
    if v25 then
        local v26 = v4[v22]
        local v27
        if v26 then
            v27 = v26(v23, v25)
        else
            v27 = v23 < v25
        end
        if not v27 or not v24 then
            v24 += 1
        end
    else
        v24 = 1
    end
    insert(v22, v24, v23)
    return v24
end

v1.__index.Insert = Insert

local function Find(v28, v29, v30, v31, v32, v33) -- line 97 | captures: FindClosest
    local v34 = FindClosest(v28, v29, v32 or 1, v33 or #v28, v30, v31)
    local v35
    if v34 then
        if v30 then
            v35 = v30(v29, v28[v34])
        else
            v35 = v29 == v28[v34]
        end
    end
    if not v35 or not v34 then
        v34 = nil
    end
    return v34
end

v1.__index.Find = Find

local function Copy(v36) -- line 115
    local v37 = {}
    local v38 = #v36
    for v39 = 1, v38 do
        v37[v39] = v36[v39]
    end
    return v37
end

v1.__index.Copy = Copy

local function Clone(v40) -- line 125 | captures: v1, v4
    local v41 = {}
    local v42 = #v40
    for v43 = 1, v42 do
        v41[v43] = v40[v43]
    end
    v4[v41] = v4[v40]
    return (setmetatable(v41, v1))
end

v1.__index.Clone = Clone

local function RemoveElement(v44, v45, v46, v47) -- line 136
    local v48 = v44:Find(v45, v46, v47)
    if v48 then
        return v44:RemoveIndex(v48)
    end
end

v1.__index.RemoveElement = RemoveElement

local function Sort(v49) -- line 144 | captures: sort, v4
    sort(v49, v4[v49])
end

v1.__index.Sort = Sort

local function SortIndex(v50, v51) -- line 148
    return v50:Insert(v50:RemoveIndex(v51))
end

v1.__index.SortIndex = SortIndex

local function SortElement(v52, v53, v54, v55) -- line 155
    return v52:Insert(v52:RemoveElement(v53, v54, v55))
end

v1.__index.SortElement = SortElement

local function GetIntersection(v56, v57, v58, v59) -- line 162 | captures: v1, v4
    if v1 ~= getmetatable(v57) then
        error("bad argument #2 to GetIntersection: expected SortedArray, got " .. typeof(v57) .. " " .. tostring(v57))
    end
    local v60 = v1.new(nil, v4[v56])
    local v61 = #v56
    local v62 = #v57
    local v63, v64
    if v62 < v61 then
        v63 = v57
        v64 = v56
    else
        v63, v64, v62, v61 = v56, v57, v61, v62
    end
    local v65 = 0
    local v66 = 1
    for v67 = 1, v62 do
        local v68 = v63[v67]
        local v69 = v64:Find(v68, v58, v59, v66, v61)
        if v69 then
            v65 += 1
            v60[v65] = v68
            v66 = v69
        end
    end
    return v60
end

v1.__index.GetIntersection = GetIntersection
return v1
