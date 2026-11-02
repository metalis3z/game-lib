-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local v3 = require(game.ReplicatedStorage.Modules.GridCreator);
local l_ChristmasEvents2018_0 = game.ReplicatedStorage.ChristmasEvents2018;
v0.GUI = nil;
v0.BattlePassFrame = nil;
v0.YourTier = nil;
v0.CurrentPassPage = 0;
v0.CurrentTierBuy = 1;
v0.BuyTiersFrame = nil;
v0.NewPassTierRewardObject = nil;
v0.NewPassPageObject = nil;
v0.PassTierRewardObjectFunction = nil;
v0.GenerateTiers = function(v5, v6, v7, v8) --[[ Line: 24 ]]
    local l_ChristmasPass2018_0 = l_Sync_0.ChristmasPass2018;
    v3.CreatePass(v7, v5, l_ChristmasPass2018_0, v0.BattlePassFrame, v6);
    v0.YourTier.Text = "Your Tier: " .. l_ProfileData_0.Christmas2018.CurrentTier;
    local l_CurrentTier_0 = l_ProfileData_0.Christmas2018.CurrentTier;
    if l_ChristmasPass2018_0.TotalTiers <= l_CurrentTier_0 then
        l_CurrentTier_0 = l_CurrentTier_0 - 1;
    end;
    local v11 = math.floor(l_CurrentTier_0 / 5);
    if not v8 then
        for _, v13 in pairs(v0.BattlePassFrame:GetChildren()) do
            v13.Visible = v13.Name == "Page" .. v11;
        end;
        v0.CurrentPassPage = v11;
    end;
    v0.CurrentTierBuy = 1;
    v0.ChangeBuyTiers(0);
    v0.NewPassTierRewardObject = v5;
    v0.NewPassPageObject = v6;
    v0.PassTierRewardObjectFunction = v7;
end;
local v14 = {};
v0.GenerateTierRewardPC = function(v15, v16, v17) --[[ Line: 56 ]]
    local v18 = tostring(v17);
    local v19 = l_ProfileData_0.Christmas2018.ClaimedRewards[v18];
    local v20 = l_Sync_0.ChristmasPass2018.Rewards[v18] ~= nil;
    if v16.ItemID then
        v3.MakeItemFrame(v15, v16, false);
        if not v14[v15] then
            v14[v15] = v15.Claim.MouseButton1Click:connect(function() --[[ Line: 67 ]]
                v15.Claim.Visible = false;
                if l_ProfileData_0.Christmas2018.ClaimedRewards[v18] ~= true then
                    v0.ClaimReward(v18);
                end;
            end);
        end;
    end;
    v15.Locked.Visible = l_ProfileData_0.Christmas2018.CurrentTier < v17;
    v15.Next.Visible = l_ProfileData_0.Christmas2018.CurrentTier + 1 == v17;
    local l_Claim_0 = v15.Claim;
    local v22 = false;
    if v17 <= l_ProfileData_0.Christmas2018.CurrentTier then
        v22 = not v19 and v20;
    end;
    l_Claim_0.Visible = v22;
    v15.Title.TierNumber.Text = v17;
end;
v0.ChangePage = function(v23) --[[ Line: 81 ]]
    v0.CurrentPassPage = v0.CurrentPassPage + v23;
    for _, v25 in pairs(v0.BattlePassFrame:GetChildren()) do
        v25.Visible = v25.Name == "Page" .. v0.CurrentPassPage;
    end;
end;
v0.ChangeBuyTiers = function(v26) --[[ Line: 88 ]]
    local l_CurrentTier_1 = l_ProfileData_0.Christmas2018.CurrentTier;
    local l_TotalTiers_0 = l_Sync_0.ChristmasPass2018.TotalTiers;
    local l_TierCost_0 = l_Sync_0.ChristmasPass2018.TierCost;
    v0.CurrentTierBuy = v0.CurrentTierBuy + v26;
    if v0.CurrentTierBuy < 1 then
        v0.CurrentTierBuy = 1;
    end;
    if l_TotalTiers_0 < v0.CurrentTierBuy + l_CurrentTier_1 then
        v0.CurrentTierBuy = l_TotalTiers_0 - l_CurrentTier_1;
    end;
    local v30 = tostring(v0.CurrentTierBuy > 1 and "s" or "");
    v0.BuyTiersFrame.Buy.Text = "Buy " .. v0.CurrentTierBuy .. " Tier" .. v30;
    v0.BuyTiersFrame.CandyDisplay.Amount.Text = v0.CurrentTierBuy * l_TierCost_0;
    if l_TotalTiers_0 <= l_CurrentTier_1 then
        v0.BuyTiersFrame.Parent.Visible = false;
        v0.BattlePassFrame.Parent.PassComplete.Visible = true;
    end;
end;
v0.BuyTiers = function() --[[ Line: 108 ]]
    local l_CurrentTierBuy_0 = v0.CurrentTierBuy;
    local v32 = l_ProfileData_0.Materials.Owned.Logs2018 or 0;
    local v33 = l_Sync_0.ChristmasPass2018.TierCost * l_CurrentTierBuy_0;
    local v34 = v33 <= v32;
    print("Tiers To Buy: " .. l_CurrentTierBuy_0);
    print("Current Tier: " .. l_ProfileData_0.Christmas2018.CurrentTier);
    if v34 then
        l_ChristmasEvents2018_0.BuyTiers:FireServer(l_CurrentTierBuy_0);
        l_ProfileData_0.Materials.Owned.Logs2018 = l_ProfileData_0.Materials.Owned.Logs2018 - v33;
        l_ProfileData_0.Christmas2018.CurrentTier = l_ProfileData_0.Christmas2018.CurrentTier + l_CurrentTierBuy_0;
        v0.CurrentTierBuy = 1;
        v0.ChangeBuyTiers(0);
        print(" -- ");
        print("Tiers To Buy: " .. v0.CurrentTierBuy);
        print("Current Tier: " .. l_ProfileData_0.Christmas2018.CurrentTier);
        v0.UpdateCandies();
        v0.GenerateTiers(v0.NewPassTierRewardObject, v0.NewPassPageObject, v0.PassTierRewardObjectFunction);
        return true;
    else
        return false, v33 - v32;
    end;
end;
v0.ClaimReward = function(v35) --[[ Line: 140 ]]
    local v36 = tostring(v35);
    local v37 = l_Sync_0.ChristmasPass2018.Rewards[v36];
    if v37 then
        local l_ItemID_0 = v37.ItemID;
        print(l_ItemID_0);
        if l_ProfileData_0.Christmas2018.CurrentTier >= tonumber(v36) and l_ProfileData_0.Christmas2018.ClaimedRewards[v36] ~= true then
            l_ProfileData_0.Christmas2018.ClaimedRewards[v36] = true;
            if v37.ItemType == "Weapons" or v37.ItemType == "Pets" or v37.ItemType == "Materials" then
                local v39 = l_ProfileData_0[v37.ItemType].Owned[l_ItemID_0];
                l_ProfileData_0[v37.ItemType].Owned[l_ItemID_0] = v39 and v39 + v37.Amount or v37.Amount;
            else
                table.insert(l_ProfileData_0[v37.ItemType].Owned, l_ItemID_0);
            end;
            v0.GenerateTiers(v0.NewPassTierRewardObject, v0.NewPassPageObject, v0.PassTierRewardObjectFunction, true);
            l_ChristmasEvents2018_0.ClaimReward:FireServer(v36);
            return;
        end;
    end;
end;
v0.UpdateCandies = function() --[[ Line: 165 ]]
    v0.GUI.CandyDisplay.Amount.Text = v3.Commafy(l_ProfileData_0.Materials.Owned.Logs2018 or 0);
end;
return v0;