-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    GOJOPack = {
        Id = "GOJOPack", 
        DisplayName = "Hollow Purple", 
        Order = 1, 
        Costs = {
			ProductId = 3571082661
        }, 
        Title = {
            Id = "HollowPurple", 
            DisplayName = "Hollow Purple", 
            RankTextTemplate = "Hollow Purple", 
            Type = "Pack"
        }, 
        Aura = {
            AuraKey = "Gojo"
        }, 
        Pose = {
            Id = "HonouredOne"
        }
    }, 
    SilverSurferPack = {
        Id = "SilverSurferPack", 
        DisplayName = "Silver Surfer", 
        Order = 2, 
        Costs = {
			ProductId = 3571083128
        }, 
        Title = {
            Id = "SilverSurfer", 
            DisplayName = "Silver Surfer", 
            RankTextTemplate = "SilverSurfer", 
            Type = "Pack"
        }, 
        Aura = {
            AuraKey = "Marlon"
        }, 
        Pose = {
            Id = "SilverSurfer"
        }
    }, 
    BoxingChamp = {
        Id = "BoxingChamp", 
        DisplayName = "Undisputed Champion", 
        Order = 3, 
        Costs = {
			ProductId = 3571082912
        }, 
        Title = {
            Id = "BoxingChamp", 
            DisplayName = "Undisputed Champion", 
            RankTextTemplate = "BoxingChamp", 
            Type = "Pack"
        }, 
        Aura = {
            AuraKey = "Boxing"
        }, 
        Pose = {
            Id = "BoxingChamp"
        }
    }
};
v0.GetPack = function(v1) --[[ Line: 79 ]] --[[ Name: GetPack ]]
    -- upvalues: v0 (copy)
    return v0[v1];
end;
v0.GetAllPacks = function() --[[ Line: 83 ]] --[[ Name: GetAllPacks ]]
    -- upvalues: v0 (copy)
    local v2 = {};
    for _, v4 in pairs(v0) do
        if type(v4) == "table" and v4.Id then
            table.insert(v2, v4);
        end;
    end;
    table.sort(v2, function(v5, v6) --[[ Line: 92 ]]
        return (v5.Order or 0) < (v6.Order or 0);
    end);
    return v2;
end;
v0.GetProductIdToPackMap = function() --[[ Line: 99 ]] --[[ Name: GetProductIdToPackMap ]]
    -- upvalues: v0 (copy)
    local v7 = {};
    for _, v9 in pairs(v0) do
        if type(v9) == "table" and v9.Id then
            local l_Costs_0 = v9.Costs;
            local v11 = l_Costs_0 and l_Costs_0.ProductId;
            if typeof(v11) == "number" and v11 > 0 then
                v7[v11] = v9.Id;
            end;
        end;
    end;
    return v7;
end;
v0.GetProductId = function(v12) --[[ Line: 116 ]] --[[ Name: GetProductId ]]
    -- upvalues: v0 (copy)
    local v13 = v0.GetPack(v12);
    if not v13 or not v13.Costs then
        return nil;
    else
        local l_ProductId_0 = v13.Costs.ProductId;
        if typeof(l_ProductId_0) == "number" and l_ProductId_0 > 0 then
            return l_ProductId_0;
        else
            return nil;
        end;
    end;
end;
v0.GetTitleId = function(v15) --[[ Line: 130 ]] --[[ Name: GetTitleId ]]
    -- upvalues: v0 (copy)
    local v16 = v0.GetPack(v15);
    if not v16 or not v16.Title then
        return nil;
    else
        local l_Id_0 = v16.Title.Id;
        if type(l_Id_0) == "string" and l_Id_0 ~= "" then
            return l_Id_0;
        else
            return nil;
        end;
    end;
end;
v0.GetTitleDisplayName = function(v18) --[[ Line: 144 ]] --[[ Name: GetTitleDisplayName ]]
    -- upvalues: v0 (copy)
    local v19 = v0.GetPack(v18);
    if not v19 or not v19.Title then
        return nil;
    else
        local l_DisplayName_0 = v19.Title.DisplayName;
        if type(l_DisplayName_0) == "string" and l_DisplayName_0 ~= "" then
            return l_DisplayName_0;
        else
            return nil;
        end;
    end;
end;
v0.GetTitleTemplateName = function(v21) --[[ Line: 158 ]] --[[ Name: GetTitleTemplateName ]]
    -- upvalues: v0 (copy)
    local v22 = v0.GetPack(v21);
    if not v22 or not v22.Title then
        return nil;
    else
        local l_RankTextTemplate_0 = v22.Title.RankTextTemplate;
        if type(l_RankTextTemplate_0) == "string" and l_RankTextTemplate_0 ~= "" then
            return l_RankTextTemplate_0;
        else
            return nil;
        end;
    end;
end;
v0.GetAuraKey = function(v24) --[[ Line: 172 ]] --[[ Name: GetAuraKey ]]
    -- upvalues: v0 (copy)
    local v25 = v0.GetPack(v24);
    if not v25 or not v25.Aura then
        return nil;
    else
        local l_AuraKey_0 = v25.Aura.AuraKey;
        if type(l_AuraKey_0) == "string" and l_AuraKey_0 ~= "" then
            return l_AuraKey_0;
        else
            return nil;
        end;
    end;
end;
v0.GetPoseId = function(v27) --[[ Line: 186 ]] --[[ Name: GetPoseId ]]
    -- upvalues: v0 (copy)
    local v28 = v0.GetPack(v27);
    if not v28 or not v28.Pose then
        return nil;
    else
        local l_Id_1 = v28.Pose.Id;
        if type(l_Id_1) == "string" and l_Id_1 ~= "" then
            return l_Id_1;
        else
            return nil;
        end;
    end;
end;
v0.GetPackByTitleId = function(v30) --[[ Line: 200 ]] --[[ Name: GetPackByTitleId ]]
    -- upvalues: v0 (copy)
    for _, v32 in pairs(v0) do
        if type(v32) == "table" and v32.Id and v32.Title and v32.Title.Id == v30 then
            return v32;
        end;
    end;
    return nil;
end;
v0.GetPackByPoseId = function(v33) --[[ Line: 210 ]] --[[ Name: GetPackByPoseId ]]
    -- upvalues: v0 (copy)
    for _, v35 in pairs(v0) do
        if type(v35) == "table" and v35.Id and v35.Pose and v35.Pose.Id == v33 then
            return v35;
        end;
    end;
    return nil;
end;
return v0;