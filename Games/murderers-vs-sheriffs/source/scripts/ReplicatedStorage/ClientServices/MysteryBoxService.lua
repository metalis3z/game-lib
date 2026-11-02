-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {
    Min = 20, 
    Max = 25
};
local v1 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Sync_0 = require(l_ReplicatedStorage_0:WaitForChild("Database"):WaitForChild("Sync"));
local l_ItemModule_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("ItemModule"));
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_MysteryBoxOpen_0 = script:WaitForChild("MysteryBoxOpen");
local l_Main_0 = l_MysteryBoxOpen_0:WaitForChild("Container"):WaitForChild("Main");
l_Main_0.Parent = script;
local l_NewItem_0 = l_Main_0:WaitForChild("Container"):WaitForChild("Background"):WaitForChild("ItemContainer"):WaitForChild("OffsetContainer"):WaitForChild("MainContainer"):WaitForChild("NewItem");
l_NewItem_0.Parent = script;
local l_Offset_0 = l_Main_0:WaitForChild("Container"):WaitForChild("Background"):WaitForChild("ItemContainer"):WaitForChild("OffsetContainer"):WaitForChild("MainContainer"):WaitForChild("UIGridLayout").CellSize.X.Offset;
local v11 = Random.new();
local function v21(v12) --[[ Line: 29 ]] --[[ Name: GetRarityFromRoll ]]
    local l_RarityChances_0 = v12.RarityChances;
    local v14 = 0;
    for _, v16 in l_RarityChances_0 do
        v14 = v14 + v16.Chance;
    end;
    assert(v14 == 100);
    assert(l_RarityChances_0[1].Rarity == "Common");
    assert(l_RarityChances_0[2].Rarity == "Uncommon");
    assert(l_RarityChances_0[3].Rarity == "Rare");
    assert(l_RarityChances_0[4].Rarity == "Legendary");
    assert(#l_RarityChances_0 == 4);
    local v17 = Random.new():NextNumber(1, 100);
    local v18 = 0;
    for _, v20 in l_RarityChances_0 do
        v18 = v18 + v20.Chance;
        if v17 <= v18 then
            return v20.Rarity;
        end;
    end;
end;
local function v26(v22) --[[ Line: 52 ]] --[[ Name: GetPossibleRewards ]]
    -- upvalues: l_Sync_0 (copy)
    local v23 = {
        Common = {}, 
        Uncommon = {}, 
        Rare = {}, 
        Legendary = {}
    };
    for _, v25 in v22.Contents do
        table.insert(v23[l_Sync_0.Weapons[v25].Rarity], v25);
    end;
    return v23;
end;
local function v33(v27, v28) --[[ Line: 68 ]] --[[ Name: GetRandomItemFromBox ]]
    -- upvalues: v11 (copy), l_Sync_0 (copy), v21 (copy)
    local v29 = nil;
    local v30 = nil;
    if v11:NextInteger(1, 500) == 500 then
        v29 = "Godly";
        local v31 = nil;
        if v27.GodlyCover then
            v31 = v27.GodlyCover;
        elseif v27.Godly then
            v31 = v27.Godly;
        end;
        if v31 and v11:NextInteger(1, 50) == 50 then
            local v32 = v31 .. "Chroma";
            if l_Sync_0.Weapons[v32] then
                v31 = v32;
            end;
        end;
        v30 = v31;
    end;
    if not v30 then
        v29 = v21(v27);
        v30 = v28[v29][v11:NextInteger(1, #v28[v29])];
    end;
    return v30, l_Sync_0.Weapons[v30], v29;
end;
v1.PlayOpeningAnimation = function(_, v35) --[[ Line: 108 ]] --[[ Name: PlayOpeningAnimation ]]
    -- upvalues: l_MysteryBoxOpen_0 (copy), l_LocalPlayer_0 (copy), v11 (copy), l_Main_0 (copy), l_Sync_0 (copy), v26 (copy), v0 (copy), l_Offset_0 (copy), v33 (copy), l_NewItem_0 (copy), l_ItemModule_0 (copy), l_TweenService_0 (copy)
	local v36 = l_MysteryBoxOpen_0:Clone();
    v36.Parent = l_LocalPlayer_0.PlayerGui;
    local v37 = 3 + v11:NextNumber();
    for v38, v39 in v35 do
        local v40 = l_Main_0:Clone();
        local l_OffsetContainer_0 = v40:WaitForChild("Container"):WaitForChild("Background"):WaitForChild("ItemContainer"):WaitForChild("OffsetContainer");
        local l_MainContainer_0 = l_OffsetContainer_0:WaitForChild("MainContainer");
        local v43 = l_Sync_0.MysteryBox[v39.MysteryBoxId];
        local v44 = v26(v43);
        local v45 = v11:NextInteger(v0.Min, v0.Max);
        l_OffsetContainer_0.Size = UDim2.new(0, l_Offset_0 * (v45 + 5), 1, 0);
        l_OffsetContainer_0.Position = UDim2.new(0.5, l_Offset_0 / 2, 0, 0);
        local l_RewardedItemId_0 = v39.RewardedItemId;
        for v47 = 1, v45 + 5 do
            local v48 = nil;
            local v49 = nil;
            local v50 = nil;
            if v47 == v45 then
                if l_Sync_0.Weapons[l_RewardedItemId_0].Rarity == "Godly" and v43.GodlyCover then
                    if l_Sync_0.Weapons[l_RewardedItemId_0].Chroma == true and v43.GodlyCover then
                        v48 = v43.GodlyCover .. "Chroma";
                        v49 = l_Sync_0.Weapons[v48];
                        v50 = v49.Rarity;
                    else
                        v48 = v43.GodlyCover;
                        v49 = l_Sync_0.Weapons[v43.GodlyCover];
                        v50 = v49.Rarity;
                    end;
                else
                    v48 = l_RewardedItemId_0;
                    v49 = l_Sync_0.Weapons[l_RewardedItemId_0];
                    v50 = v49.Rarity;
                end;
            else
                local v51, v52, v53 = v33(v43, v44);
                v48 = v51;
                v49 = v52;
                v50 = v53;
            end;
            local v54 = l_NewItem_0:Clone();
            l_ItemModule_0.DisplayItem(v54, v49);
            v54.LayoutOrder = v47;
            v54.Parent = l_MainContainer_0;
        end;
        local v55, v56, v57 = v33(v43, v44);
        l_ItemModule_0.DisplayItem(l_OffsetContainer_0["PreItem" .. 1], v56);
        v55, v56, v57 = v33(v43, v44);
        l_ItemModule_0.DisplayItem(l_OffsetContainer_0["PreItem" .. 2], v56);
        v40.Parent = v36:WaitForChild("Container");
        v55 = -(l_Offset_0 * v45) + v11:NextInteger(-(l_Offset_0 / 2 - 5), l_Offset_0 / 2 - 5) + l_Offset_0 - l_Offset_0 / 2;
        v56 = TweenInfo.new(v37, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, v38 * 0.5);
        l_TweenService_0:Create(l_OffsetContainer_0, v56, {
            Position = UDim2.new(0.5, v55, 0, 0)
        }):Play();
    end;
    task.wait(v37 + #v35 * 0.5);
    v36:Destroy();
end;
return v1;