-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = game.ReplicatedStorage.Replicated;
local v2 = {};
v2.__index = v2;
v2.new = function(v3) --[[ Line: 14 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy)
    local v4 = setmetatable({}, v2);
    v4.Randomizer = Random.new(v3 or tick() % 1 * 10000000000);
    v4.Loot = {};
    v4.LootList = {};
    v4.LootCount = 0;
    v4.TotalChance = 0;
    return v4;
end;
v2.changeRandomizerRandom = function(v5, v6) --[[ Line: 24 ]] --[[ Name: changeRandomizerRandom ]]
    v5.Randomizer = Random.new(math.randomseed(v6));
end;
v2.changeRandomizer = function(v7, v8) --[[ Line: 28 ]] --[[ Name: changeRandomizer ]]
    v7.Randomizer = Random.new(v8);
end;
v2._updateLootList = function(v9) --[[ Line: 32 ]] --[[ Name: _updateLootList ]]
    local v10 = {};
    for _, v12 in v9.Loot do
        table.insert(v10, v12);
    end;
    table.sort(v10, function(v13, v14) --[[ Line: 39 ]]
        return v13.chance < v14.chance;
    end);
    v9.LootList = v10;
end;
v2.AddLoot = function(v15, v16, v17) --[[ Line: 46 ]] --[[ Name: AddLoot ]]
    local v18 = {
        name = v16, 
        chance = v17
    };
    v15.Loot[v16] = v18;
    v15.LootCount = v15.LootCount + 1;
    v15.TotalChance = v15.TotalChance + v17;
    v15:_updateLootList();
    return v18;
end;
v2.AddLootFromTable = function(v19, v20) --[[ Line: 58 ]] --[[ Name: AddLootFromTable ]]
    for v21, v22 in v20 do
        v19:AddLoot(v21, v22);
    end;
    return v19;
end;
v2.GetLootChance = function(v23, v24) --[[ Line: 65 ]] --[[ Name: GetLootChance ]]
    local v25 = v23.Loot[v24];
    if v25 then
        return v25.chance;
    else
        error("Loot with name '" .. tostring(v24) .. "' does not exist");
        return;
    end;
end;
v2.GetTrueLootChance = function(v26, v27) --[[ Line: 74 ]] --[[ Name: GetTrueLootChance ]]
    local v28 = v26.Loot[v27];
    if v28 then
        return v28.chance / v26.TotalChance * 100;
    else
        error("Loot with name '" .. tostring(v27) .. "' does not exist");
        return;
    end;
end;
v2.GetLuckBasedLootChance = function(v29, v30, v31) --[[ Line: 83 ]] --[[ Name: GetLuckBasedLootChance ]]
    local v32 = v29.Loot[v30];
    if v32 then
        local v33 = 0;
        local v34 = nil;
        v34 = v32.chance < 1 and v32.chance * v31 or v32.chance;
        for _, _ in next, v29.LootList do
            v33 = v33 + (v32.chance < 1 and v32.chance * v31 or v32.chance);
        end;
        return v34 / v33 * 100;
    else
        error("Loot with name '" .. tostring(v30) .. "' does not exist");
        return;
    end;
end;
v2.RemoveLoot = function(v37, v38) --[[ Line: 103 ]] --[[ Name: RemoveLoot ]]
    local v39 = v37.Loot[v38];
    if v39 then
        v37.TotalChance = v37.TotalChance - v39.chance;
        v37.LootCount = v37.LootCount - 1;
        v37.Loot[v38] = nil;
        v37:_updateLootList();
    end;
end;
v2.ClearLootTable = function(v40) --[[ Line: 113 ]] --[[ Name: ClearLootTable ]]
    for v41, _ in next, v40.Loot do
        v40.Loot[v41] = nil;
    end;
    v40:_updateLootList();
end;
v2.ChangeLootChance = function(v43, v44, v45) --[[ Line: 121 ]] --[[ Name: ChangeLootChance ]]
    local v46 = v43.Loot[v44];
    if v46 then
        v43.TotalChance = v43.TotalChance + (v45 - v46.chance);
        v46.chance = v45;
        v43:_updateLootList();
        return v46;
    else
        error("Loot with name '" .. tostring(v44) .. "' does not exist");
        return;
    end;
end;
v2.GetRandomLoot = function(v47, v48) --[[ Line: 133 ]] --[[ Name: GetRandomLoot ]]
    local v49 = v48 or 1;
    local v50 = nil;
    if v49 >= 1 then
        local v51 = v47.Randomizer:NextNumber();
        local v52 = 0;
        for _, v54 in v47.LootList do
            local v55 = v54.chance * v49;
            if v51 < (v55 + v52) / v47.TotalChance then
                return v54.name;
            else
                v52 = v52 + v55;
            end;
        end;
        return v50;
    else
        local v56 = 1 / v49;
        local v57 = v47.Randomizer:NextNumber();
        local v58 = 0;
        for v59 = v47.LootCount, 1, -1 do
            local v60 = v47.LootList[v59];
            local v61 = v60.chance * v56;
            if v57 < (v61 + v58) / v47.TotalChance then
                return v60.name;
            else
                v58 = v58 + v61;
            end;
        end;
        return v50;
    end;
end;
local v62 = {};
v62.__index = v62;
v62.new = function(v63) --[[ Line: 169 ]] --[[ Name: new ]]
    -- upvalues: v62 (copy)
    local v64 = setmetatable({}, v62);
    v64.Randomizer = Random.new(v63 or tick() % 1 * 10000000000);
    v64.Loot = {};
    return v64;
end;
v62.changeRandomizer = function(v65, v66) --[[ Line: 176 ]] --[[ Name: changeRandomizer ]]
    v65.Randomizer = Random.new(v66);
end;
v62.AddLoot = function(v67, v68, v69) --[[ Line: 180 ]] --[[ Name: AddLoot ]]
    local v70 = {
        name = v68, 
        chance = v69
    };
    v67.Loot[v68] = v70;
    return v70;
end;
v62.AddLootFromTable = function(v71, v72) --[[ Line: 189 ]] --[[ Name: AddLootFromTable ]]
    for v73, v74 in v72 do
        v71:AddLoot(v73, v74);
    end;
end;
v62.GetLootChance = function(v75, v76) --[[ Line: 195 ]] --[[ Name: GetLootChance ]]
    local v77 = v75.Loot[v76];
    if v77 then
        return v77.chance;
    else
        error("Loot with name '" .. tostring(v76) .. "' does not exist");
        return;
    end;
end;
v62.RemoveLoot = function(v78, v79) --[[ Line: 204 ]] --[[ Name: RemoveLoot ]]
    v78.Loot[v79] = nil;
end;
v62.ChangeLootChance = function(v80, v81, v82) --[[ Line: 208 ]] --[[ Name: ChangeLootChance ]]
    local v83 = v80.Loot[v81];
    if v83 then
        v83.chance = v82;
        return;
    else
        error("Loot with name '" .. tostring(v81) .. "' does not exist");
        return;
    end;
end;
v62.GetRandomLoot = function(v84, v85, v86) --[[ Line: 217 ]] --[[ Name: GetRandomLoot ]]
    local v87 = {};
    for _ = 1, v85 or 1 do
        for v89, v90 in v84.Loot do
            if v84.Randomizer:NextNumber() < v90.chance / 100 * (v86 or 1) then
                v87[v89] = v87[v89] and v87[v89] + 1 or 1;
            end;
        end;
    end;
    return v87;
end;
v0.new = function(v91, v92) --[[ Line: 233 ]] --[[ Name: new ]]
    -- upvalues: v62 (copy), v2 (copy)
    if v91 == "multi" then
        return v62.new(v92);
    else
        return v2.new(v92);
    end;
end;
return v0;