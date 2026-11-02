-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = {};
local function _() --[[ Line: 5 ]] --[[ Name: getAurasFolder ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local l_Assets_0 = l_ReplicatedStorage_0:FindFirstChild("Assets");
    if not l_Assets_0 then
        return nil;
    else
        return l_Assets_0:FindFirstChild("Auras");
    end;
end;
v1.GetAuraKeys = function() --[[ Line: 14 ]] --[[ Name: GetAuraKeys ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local l_Assets_1 = l_ReplicatedStorage_0:FindFirstChild("Assets");
    local v5 = if not l_Assets_1 then nil else l_Assets_1:FindFirstChild("Auras");
    if not v5 then
        return {};
    else
        l_Assets_1 = {};
        local v6 = {};
        for _, v8 in ipairs(v5:GetChildren()) do
            if v8:GetAttribute("PackOnly") ~= true then
                local l_Name_0 = v8.Name;
                local v10 = tonumber(l_Name_0);
                if v10 then
                    table.insert(l_Assets_1, {
                        n = v10, 
                        key = l_Name_0
                    });
                else
                    table.insert(v6, l_Name_0);
                end;
            end;
        end;
        table.sort(l_Assets_1, function(v11, v12) --[[ Line: 38 ]]
            return v11.n < v12.n;
        end);
        table.sort(v6);
        local v13 = {};
        for _, v15 in ipairs(l_Assets_1) do
            table.insert(v13, v15.key);
        end;
        for _, v17 in ipairs(v6) do
            table.insert(v13, v17);
        end;
        return v13;
    end;
end;
v1.GetAuraKeyByProgress = function(v18) --[[ Line: 55 ]] --[[ Name: GetAuraKeyByProgress ]]
    -- upvalues: v1 (copy)
    local v19 = v1.GetAuraKeys();
    local v20 = #v19;
    if v20 <= 0 then
        return nil;
    else
        return v19[math.clamp(math.floor(math.clamp(v18 or 0, 0, 1) * (v20 - 1) + 1.5), 1, v20)];
    end;
end;
v1.GetAuraKeyForRank = function(v21, v22) --[[ Line: 71 ]] --[[ Name: GetAuraKeyForRank ]]
    -- upvalues: v1 (copy)
    if typeof(v21) ~= "number" or typeof(v22) ~= "number" or v22 <= 0 then
        return nil;
    else
        local v23 = nil;
        v23 = v22 <= 1 and 0 or (v21 - 1) / math.max(1, v22 - 1);
        return v1.GetAuraKeyByProgress(v23);
    end;
end;
return v1;