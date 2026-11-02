-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
v0.IsItemSalvageable = function(_, v3) --[[ Line: 13 ]] --[[ Name: IsItemSalvageable ]]
    -- upvalues: l_Sync_0 (copy)
    if v3 == nil then
        return false;
    else
        local v4 = l_Sync_0.Weapons[v3];
        if not v4 then
            return false;
        elseif l_Sync_0.Codes[v3] then
            return false;
        else
            local l_Rarity_0 = v4.Rarity;
            local v6 = l_Sync_0.SalvageRewards[v3] and l_Sync_0.SalvageRewards[v3].Rewards;
            local v7 = l_Sync_0.SalvageRewards[l_Rarity_0] and l_Sync_0.SalvageRewards[l_Rarity_0].Rewards;
            if v4.Event ~= nil and not v6 then
                return false;
            elseif v4.Season ~= nil then
                return false;
            elseif v4.ItemType == "Misc" then
                return false;
            elseif not v7 and not v6 then
                return false;
            else
                return true;
            end;
        end;
    end;
end;
v0.GetCraftingResult = function(_, v9) --[[ Line: 53 ]] --[[ Name: GetCraftingResult ]]
    -- upvalues: l_Sync_0 (copy)
    for v10, v11 in l_Sync_0.Recipes do
        local _ = v11.Materials;
        local v13 = 0;
        local v14 = 0;
        for v15, v16 in v11.Materials do
            v14 = v14 + 1;
            for _, v18 in v9 do
                if v18.itemID == v15 and v18.amount == v16 then
                    v13 = v13 + 1;
                end;
            end;
        end;
        if v13 == v14 and #v9 == v13 then
            return v10;
        end;
    end;
    return nil;
end;
return v0;