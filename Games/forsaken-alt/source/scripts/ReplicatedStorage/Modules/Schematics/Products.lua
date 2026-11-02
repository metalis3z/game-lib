-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.Modules.Util);
return {
    {
        Title = "Player Points", 
        Contents = {
            [1912342578] = {
                DisplayName = "+100$", 
                NotificationText = "100$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 1, 
                Callback = function(_, v2) --[[ Line: 16 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v2, "Money", 100, true);
                end
            }, 
            [1912343043] = {
                DisplayName = "+250$", 
                NotificationText = "250$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 2, 
                Callback = function(_, v4) --[[ Line: 28 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v4, "Money", 250, true);
                end
            }, 
            [1912343046] = {
                DisplayName = "+500$", 
                NotificationText = "500$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 3, 
                Callback = function(_, v6) --[[ Line: 40 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v6, "Money", 500, true);
                end
            }, 
            [1912343591] = {
                DisplayName = "+1,000$", 
                NotificationText = "1,000$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 4, 
                Callback = function(_, v8) --[[ Line: 52 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v8, "Money", 1000, true);
                end
            }, 
            [2676900964] = {
                DisplayName = "+2,000$", 
                NotificationText = "2,000$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 5, 
                Callback = function(_, v10) --[[ Line: 64 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v10, "Money", 2000, true);
                end
            }, 
            [2676901990] = {
                DisplayName = "+5,000$", 
                NotificationText = "5,000$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 6, 
                Callback = function(_, v12) --[[ Line: 76 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v12, "Money", 5000, true);
                end
            }, 
            [2676902857] = {
                DisplayName = "+10,000$", 
                NotificationText = "10,000$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 7, 
                Callback = function(_, v14) --[[ Line: 88 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v14, "Money", 10000, true);
                end
            }, 
            [2677133608] = {
                DisplayName = "+20,000$", 
                NotificationText = "20,000$ has been awarded to your account.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 8, 
                Callback = function(_, v16) --[[ Line: 100 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v16, "Money", 20000, true);
                end
            }
        }
    }, 
    {
        Title = "Boosts", 
        Contents = {
            [2677148002] = {
                DisplayName = "+15 Killer Chance", 
                NotificationText = "Your Killer Chance has went up by 15.", 
                Icon = "rbxassetid://123727335119840", 
                ProductType = "DevProduct", 
                LayoutOrder = 1, 
                HiddenInVIP = true, 
                Callback = function(_, v18) --[[ Line: 118 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v18, "KillerChance", 15, true);
                end
            }, 
            [2677209533] = {
                DisplayName = "1 Hour EXP Boost", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 1.25x EXP boost.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 2, 
                Callback = function(_, v20) --[[ Line: 130 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v20, "EXPBoostTime", 3600, true);
                end
            }, 
            [2677213976] = {
                DisplayName = "6 Hour EXP Boost", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 1.25x EXP boost.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 3, 
                Callback = function(_, v22) --[[ Line: 142 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v22, "EXPBoostTime", 21600, true);
                end
            }, 
            [2677213975] = {
                DisplayName = "12 Hour EXP Boost", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 1.25x EXP boost.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 4, 
                Callback = function(_, v24) --[[ Line: 154 ]] --[[ Name: Callback ]]
                    -- upvalues: v0 (copy)
                    v0:AddToPlayerStat(v24, "EXPBoostTime", 43200, true);
                end
            }
        }
    }, 
    {
        Title = "Gamepasses", 
        Contents = {
            [1009460688] = {
                DisplayName = "VIP", 
                NotificationText = "You now have a permanent 1.25x EXP boost, a VIP title (toggleable in the Settings menu), the Hakari Dance emote, and an exclusive Noob skin.", 
                Icon = "rbxassetid://80350430833968", 
                ProductType = "Gamepass", 
                LayoutOrder = 1, 
                Callback = function(_, v26) --[[ Line: 171 ]] --[[ Name: Callback ]]
                    v26:SetAttribute("VIP", true);
                    v26:SetAttribute("EXPMultiplier", (v26:GetAttribute("EXPMultiplier") or 1) + 0.25);
                    local v27 = v26:WaitForChild("PlayerData", 30);
                    if not v27 then
                        return;
                    else
                        if not v27.Purchased.Skins:FindFirstChild("VIPNoob") then
                            local l_NumberValue_0 = Instance.new("NumberValue");
                            l_NumberValue_0.Name = "VIPNoob";
                            l_NumberValue_0.Parent = v27.Purchased.Skins;
                        end;
                        if not v27.Purchased.Skins:FindFirstChild("VIPJason") then
                            local l_NumberValue_1 = Instance.new("NumberValue");
                            l_NumberValue_1.Name = "VIPJason";
                            l_NumberValue_1.Parent = v27.Purchased.Skins;
                        end;
                        if not v27.Purchased.Emotes:FindFirstChild("HakariDance") then
                            local l_NumberValue_2 = Instance.new("NumberValue");
                            l_NumberValue_2.Name = "HakariDance";
                            l_NumberValue_2.Parent = v27.Purchased.Emotes;
                        end;
                        return;
                    end;
                end
            }
        }
    }
};