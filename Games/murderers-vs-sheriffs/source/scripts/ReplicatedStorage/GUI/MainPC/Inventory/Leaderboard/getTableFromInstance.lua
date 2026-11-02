return function(v0) --[[ Line: 1 ]]
    local v1 = {};
    local function v7(v2, v3) --[[ Line: 5 ]] --[[ Name: attachInstances ]]
        -- upvalues: v0 (copy)
        if v2[v3.Name] == nil then
            v2[v3.Name] = {};
        else
            error("Instances cannot have duplicate names: " .. v3.Name .. " in " .. v0.Name);
        end;
        local l_v3_Attributes_0 = v3:GetAttributes();
        for v5, v6 in pairs(l_v3_Attributes_0) do
            v2[v3.Name][v5] = v6;
        end;
    end;
    v7(v1, v0);
    for _, v9 in pairs(v0:GetChildren()) do
        v7(v1[v0.Name], v9);
    end;
    return v1;
end;