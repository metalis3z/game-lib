-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {}

v2.__index = v2

local function packCell(v3) -- line 9
    return (v3.X * 262144 + v3.Z) * 131072 + v3.Y
end

local function quantise(v4, v5) -- line 12
    local cellStuds = v4.cellStuds
    local v6 = v5.X // cellStuds
    local v7 = v5.Y // cellStuds
    local v8 = v5.Z // cellStuds
    return (Vector3.new(v6, v7, v8))
end

local function sweep(v9, v10, v11) -- line 18
    local v12 = v11 or 1
    local v13 = v12 <= (v9.reachLimit or 5)
    assert(v13, "requested cell reach exceeds the limit")
    local cellStuds = v9.cellStuds
    local v14 = v10.X // cellStuds
    local v15 = v10.Y // cellStuds
    local v16 = v10.Z // cellStuds
    local v17 = Vector3.new(v14, v15, v16) - Vector3.new(v12, v12, v12)
    local cells = v9.cells
    local v18 = v12 * 2 + 1
    local v19 = {}
    local v20 = v18 * v18 * v18 - 1
    for v21 = 0, v20 do
        local v22 = v21 // (v18 * v18)
        local v23 = v21 // v18 % v18
        local v24 = v21 % v18
        local v25 = v17 + Vector3.new(v22, v23, v24)
        local v26 = cells[(v25.X * 262144 + v25.Z) * 131072 + v25.Y]
        if v26 then
            table.move(v26, 1, #v26, #v19 + 1, v19)
        end
    end
    return v19
end

local function CellOf(v27, v28) -- line 44
    local cellStuds = v27.cellStuds
    local v29 = v28.X // cellStuds
    local v30 = v28.Y // cellStuds
    local v31 = v28.Z // cellStuds
    return (Vector3.new(v29, v30, v31))
end

v2.CellOf = CellOf

local function Place(v32, v33, v34) -- line 50
    local cellStuds = v32.cellStuds
    local v35 = v33.X // cellStuds
    local v36 = v33.Y // cellStuds
    local v37 = v33.Z // cellStuds
    local v38 = Vector3.new(v35, v36, v37)
    local v39 = (v38.X * 262144 + v38.Z) * 131072 + v38.Y
    local v40 = v32.cells[v39] or {}
    v32.cells[v39] = v40
    local v41 = {
        pos = v33,
        val = v34
    }
    table.insert(v40, v41)
end

v2.Place = Place

local function Drop(v42, v43, v44) -- line 61
    local cellStuds = v42.cellStuds
    local v45 = v43.X // cellStuds
    local v46 = v43.Y // cellStuds
    local v47 = v43.Z // cellStuds
    local v48 = Vector3.new(v45, v46, v47)
    local v49 = (v48.X * 262144 + v48.Z) * 131072 + v48.Y
    local v50 = v42.cells[v49]
    local v51 = if v50 then #v50 else 0
    while true do
        if v51 >= 1 then
            if v50[v51].val == v44 then
                table.remove(v50, v51)
            end
        else
            break
        end
        v51 -= 1
    end
    if v50 ~= nil and #v50 == 0 then
        v42.cells[v49] = nil
    end
end

v2.Drop = Drop

function v2.Gather(v52, v53, v54) -- line 85 | captures: sweep
    local v55 = {}
    for v56, v57 in sweep(v52, v53, v54) do
        v55[v56] = v57.val
    end
    return v55
end

function v2.Nearest(v58, v59, v60) -- line 92 | captures: sweep
    local val, Magnitude
    for v61, v62 in sweep(v58, v59, v60) do
        local Magnitude_2 = (v62.pos - v59).Magnitude
        if Magnitude == nil or Magnitude_2 < Magnitude then
            val = v62.val
            Magnitude = Magnitude_2
        end
    end
    return val
end

function v1.new(v63, v64) -- line 109 | captures: v2
    local v65 = {
        cells = {},
        cellStuds = v63 or 10,
        reachLimit = v64
    }
    return (setmetatable(v65, v2))
end

return v1
