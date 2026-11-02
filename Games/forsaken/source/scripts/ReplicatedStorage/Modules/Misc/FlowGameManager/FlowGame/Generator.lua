-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = 0;
local v1 = 0;
local function v6(v2) --[[ Line: 4 ]] --[[ Name: GetEmptyBoard ]]
    local v3 = {};
    for v4 = 1, v2 do
        v3[v4] = {};
        for v5 = 1, v2 do
            v3[v4][v5] = 0;
        end;
    end;
    return v3;
end;
local function v12(v7, v8, v9) --[[ Line: 15 ]] --[[ Name: NumAddedNeighbours ]]
    local v10 = #v7;
    local v11 = 0;
    if v8 == 1 or v7[v8 - 1][v9] ~= 0 then
        v11 = v11 + 1;
    end;
    if v8 == v10 or v7[v8 + 1][v9] ~= 0 then
        v11 = v11 + 1;
    end;
    if v9 == 1 or v7[v8][v9 - 1] ~= 0 then
        v11 = v11 + 1;
    end;
    if v9 == v10 or v7[v8][v9 + 1] ~= 0 then
        v11 = v11 + 1;
    end;
    return v11;
end;
local function v19(v13, v14, v15, v16) --[[ Line: 25 ]] --[[ Name: NumSameColoredNeighbours ]]
    local v17 = #v13;
    local v18 = 0;
    if v14 > 1 and v13[v14 - 1][v15] == v16 then
        v18 = v18 + 1;
    end;
    if v14 < v17 and v13[v14 + 1][v15] == v16 then
        v18 = v18 + 1;
    end;
    if v15 > 1 and v13[v14][v15 - 1] == v16 then
        v18 = v18 + 1;
    end;
    if v15 < v17 and v13[v14][v15 + 1] == v16 then
        v18 = v18 + 1;
    end;
    return v18;
end;
local function v38(v20, v21, v22, v23, v24) --[[ Line: 35 ]] --[[ Name: HasIsolatedSquares ]]
    -- upvalues: v12 (copy), v19 (copy)
    local v25 = #v20;
    local function _(v26, v27) --[[ Line: 37 ]] --[[ Name: checkCell ]]
        -- upvalues: v20 (copy), v12 (ref), v24 (copy), v19 (ref), v23 (copy)
        local v28 = false;
        if v20[v26][v27] == 0 then
            v28 = false;
            if v12(v20, v26, v27) == 4 then
                v28 = not v24 or v19(v20, v26, v27, v23) > 1;
            end;
        end;
        return v28;
    end;
    if v21 > 1 then
        local v30 = v21 - 1;
        local v31 = false;
        if v20[v30][v22] == 0 then
            v31 = false;
            if v12(v20, v30, v22) == 4 then
                v31 = not v24 or v19(v20, v30, v22, v23) > 1;
            end;
        end;
        if v31 then
            return true;
        end;
    end;
    if v21 < v25 then
        local v32 = v21 + 1;
        local v33 = false;
        if v20[v32][v22] == 0 then
            v33 = false;
            if v12(v20, v32, v22) == 4 then
                v33 = not v24 or v19(v20, v32, v22, v23) > 1;
            end;
        end;
        if v33 then
            return true;
        end;
    end;
    if v22 > 1 then
        local v34 = v22 - 1;
        local v35 = false;
        if v20[v21][v34] == 0 then
            v35 = false;
            if v12(v20, v21, v34) == 4 then
                v35 = not v24 or v19(v20, v21, v34, v23) > 1;
            end;
        end;
        if v35 then
            return true;
        end;
    end;
    if v22 < v25 then
        local v36 = v22 + 1;
        local v37 = false;
        if v20[v21][v36] == 0 then
            v37 = false;
            if v12(v20, v21, v36) == 4 then
                v37 = not v24 or v19(v20, v21, v36, v23) > 1;
            end;
        end;
        if v37 then
            return true;
        end;
    end;
    return false;
end;
local function v50(v39, v40, v41, v42) --[[ Line: 48 ]] --[[ Name: GetPathExtensionNeighbour ]]
    -- upvalues: v19 (copy), v38 (copy)
    local v43 = #v39;
    local v44 = {
        {
            -1, 
            0
        }, 
        {
            0, 
            1
        }, 
        {
            0, 
            -1
        }, 
        {
            1, 
            0
        }
    };
    local v45 = math.random(4);
    for v46 = 0, 3 do
        local v47 = v44[(v45 + v46 - 1) % 4 + 1];
        local v48 = v40 + v47[1];
        local v49 = v41 + v47[2];
        if v48 > 0 and v48 <= v43 and v49 > 0 and v49 <= v43 and v39[v48][v49] == 0 and (v42 <= 0 or v19(v39, v48, v49, v42) <= 1) then
            v39[v48][v49] = v42;
            if v38(v39, v40, v41, v42, false) or v38(v39, v48, v49, v42, true) then
                v39[v48][v49] = 0;
            else
                return {
                    v48, 
                    v49
                };
            end;
        end;
    end;
    return {
        0, 
        0
    };
end;
local function v62(v51, v52) --[[ Line: 73 ]] --[[ Name: AddPath ]]
    -- upvalues: v0 (ref), v38 (copy), v50 (copy), v1 (ref)
    local v53 = nil;
    local v54 = nil;
    local v55 = nil;
    local v56 = nil;
    local v57 = nil;
    local v58 = #v51;
    v0 = v0 + 1;
    v55 = math.floor(math.random() * v58 * v58) + 1;
    for v59 = 1, v58 * v58 do
        v56 = v59;
        v55 = v55 + 1;
        if v58 * v58 < v55 then
            v55 = 1;
        end;
        v53 = math.floor((v55 - 1) / v58) + 1;
        v54 = (v55 - 1) % v58 + 1;
        if v52[v53][v54] == 0 then
            v51[v53][v54] = v0;
            v52[v53][v54] = v0;
            if v38(v52, v53, v54, v0, true) then
                v52[v53][v54] = 0;
                v51[v53][v54] = 0;
            else
                v57 = v50(v52, v53, v54, v0);
                if v57[1] == 0 and v57[2] == 0 then
                    v52[v53][v54] = 0;
                    v51[v53][v54] = 0;
                else
                    break;
                end;
            end;
        end;
    end;
    if v56 == v58 * v58 then
        v0 = v0 - 1;
        return false;
    else
        local v60 = 2;
        v1 = v1 + 2;
        local v61 = {};
        while true do
            v53 = v57[1];
            v54 = v57[2];
            v61 = v50(v52, v53, v54, v0);
            if (v61[1] ~= 0 or v61[2] ~= 0) and v60 < v58 * v58 then
                v57 = v61;
                v60 = v60 + 1;
                v1 = v1 + 1;
            else
                break;
            end;
        end;
        v51[v57[1]][v57[2]] = v0;
        return true;
    end;
end;
local function v68(v63) --[[ Line: 134 ]] --[[ Name: Shuffle ]]
    local v64 = #v63;
    while v64 > 0 do
        local v65 = math.random(v64);
        local v66 = v63[v65];
        local v67 = v63[v64];
        v63[v64] = v66;
        v63[v65] = v67;
        v64 = v64 - 1;
    end;
    return v63;
end;
local function v77(v69, v70, v71) --[[ Line: 144 ]] --[[ Name: ShuffleColors ]]
    -- upvalues: v68 (copy)
    local v72 = {};
    for v73 = 1, v71 do
        table.insert(v72, v73);
    end;
    v72 = v68(v72);
    local v74 = #v69;
    for v75 = 1, v74 do
        for v76 = 1, v74 do
            if v69[v75][v76] ~= 0 then
                v69[v75][v76] = v72[v69[v75][v76]];
            end;
            v70[v75][v76] = v72[v70[v75][v76]];
        end;
    end;
end;
local function v81(v78) --[[ Line: 162 ]] --[[ Name: GenerateBoard ]]
    -- upvalues: v6 (copy), v0 (ref), v1 (ref), v62 (copy), v77 (copy)
    local v79 = v6(v78);
    local v80 = v6(v78);
    repeat
        v79 = v6(v78);
        v80 = v6(v78);
        v0 = 0;
        v1 = 0;
        while v62(v79, v80) do

        end;
    until v1 >= v78 * v78;
    v77(v79, v80, v0);
    return v79, v80;
end;
function BoardToText(v82) --[[ Line: 191 ]] --[[ Name: BoardToText ]]
    local v83 = "\n";
    for v84 = 1, #v82 do
        v83 = v83 .. table.concat(v82[v84], " ") .. "\n";
    end;
    return v83;
end;
function ExportBoard(v85) --[[ Line: 198 ]] --[[ Name: ExportBoard ]]
    local v86 = {};
    for v87 = 1, #v85 do
        for v88 = 1, #v85[v87] do
            local v89 = v85[v87][v88];
            if v89 ~= 0 then
                if not v86[v89] then
                    v86[v89] = {};
                end;
                table.insert(v86[v89], {
                    row = v87, 
                    col = v88
                });
            end;
        end;
    end;
    return v86;
end;
return function(v90) --[[ Line: 214 ]]
    -- upvalues: v81 (copy)
    local v91, v92 = v81(v90);
    return ExportBoard(v91), ExportBoard(v92), BoardToText(v91), BoardToText(v92);
end;