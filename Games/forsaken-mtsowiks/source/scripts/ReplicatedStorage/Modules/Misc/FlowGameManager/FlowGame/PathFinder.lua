-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function _(v0, v1) --[[ Line: 1 ]] --[[ Name: createNode ]]
    return {
        cell = v0, 
        stack = v1 or {}
    };
end;
local function _(v3, v4) --[[ Line: 8 ]] --[[ Name: sameLocation ]]
    local l_row_0 = v3.row;
    local l_col_0 = v3.col;
    local l_row_1 = v4.row;
    local l_col_1 = v4.col;
    local v9 = false;
    if l_row_0 == l_row_1 then
        v9 = l_col_0 == l_col_1;
    end;
    return v9;
end;
local function v15(v11, v12) --[[ Line: 14 ]] --[[ Name: isCellInStack ]]
    for _, v14 in ipairs(v11) do
        if v14.row == v12.row and v14.col == v12.col then
            return true;
        end;
    end;
    return false;
end;
local function _(v16, v17) --[[ Line: 23 ]] --[[ Name: cloneAndAdd ]]
    local v18 = table.clone(v16);
    table.insert(v18, v17);
    return v18;
end;
local v20 = {};
v20.__index = v20;
v20.new = function(v21, v22, v23, v24) --[[ Line: 33 ]] --[[ Name: new ]]
    -- upvalues: v20 (copy)
    local v25 = setmetatable({}, v20);
    v25.candidates = {};
    v25.from = v22;
    v25.grid = v21;
    v25.gridSize = #v21;
    v25.to = v23;
    v25.neighbourCache = {};
    v25.seen = {};
    v25.stack = {
        {
            cell = v22, 
            stack = {}
        }
    };
    v25.maxLength = v24 or 1;
    return v25;
end;
v20.generate = function(v26) --[[ Line: 47 ]] --[[ Name: generate ]]
    -- upvalues: v15 (copy)
    while #v26.stack > 0 do
        local v27 = table.remove(v26.stack, 1);
        local l_cell_0 = v27.cell;
        if not v15(v26.seen, l_cell_0) then
            for _, v30 in ipairs(v26:neighboursOf(l_cell_0)) do
                local v31 = v26.grid[v30.row][v30.col];
                local _ = v26.grid[v26.from.row][v26.from.col];
                if v31.status == "empty" and not v15(v27.stack, v30) and #v27.stack < v26.maxLength then
                    local l_stack_0 = v27.stack;
                    local v34 = table.clone(l_stack_0);
                    table.insert(v34, l_cell_0);
                    local v35 = {
                        cell = v30, 
                        stack = v34 or {}
                    };
                    l_stack_0 = v26.to;
                    v34 = v30.row;
                    local l_col_2 = v30.col;
                    local l_row_2 = l_stack_0.row;
                    local l_col_3 = l_stack_0.col;
                    local v39 = false;
                    if v34 == l_row_2 then
                        v39 = l_col_2 == l_col_3;
                    end;
                    if v39 then
                        l_stack_0 = v35.stack;
                        v34 = table.clone(l_stack_0);
                        table.insert(v34, v30);
                        v39 = v34;
                        table.remove(v39, 1);
                        table.insert(v26.candidates, v39);
                    else
                        table.insert(v26.stack, v35);
                    end;
                end;
            end;
            table.insert(v26.seen, l_cell_0);
        end;
    end;
end;
v20.isPathAvailable = function(v40) --[[ Line: 75 ]] --[[ Name: isPathAvailable ]]
    if #v40.candidates == 0 then
        v40:generate();
    end;
    return #v40.candidates > 0;
end;
v20.neighboursOf = function(v41, v42) --[[ Line: 83 ]] --[[ Name: neighboursOf ]]
    local v43 = ("%*-%*"):format(v42.row, v42.col);
    if not v41.neighbourCache[v43] then
        v41.neighbourCache[v43] = {};
        for v44 = -1, 1, 2 do
            for v45 = 1, 2 do
                local v46 = {
                    row = v42.row, 
                    col = v42.col
                };
                if v45 == 1 then
                    v46.row = v46.row + v44;
                else
                    v46.col = v46.col + v44;
                end;
                local v47 = true;
                if v46.row >= 1 then
                    v47 = true;
                    if v46.row <= v41.gridSize then
                        v47 = true;
                        if v46.col >= 1 then
                            v47 = v46.col > v41.gridSize;
                        end;
                    end;
                end;
                if not v47 then
                    table.insert(v41.neighbourCache[v43], v46);
                end;
            end;
        end;
    end;
    return v41.neighbourCache[v43];
end;
v20.shortestPath = function(v48) --[[ Line: 115 ]] --[[ Name: shortestPath ]]
    if #v48.candidates == 0 then
        v48:generate();
    end;
    table.sort(v48.candidates, function(v49, v50) --[[ Line: 119 ]]
        return #v49 < #v50;
    end);
    return v48.candidates[1];
end;
return v20;