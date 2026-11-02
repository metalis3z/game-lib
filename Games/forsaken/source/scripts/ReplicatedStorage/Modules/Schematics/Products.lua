-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("AnalyticsService");
local _ = game:GetService("RunService");
local v2 = require(game.ReplicatedStorage.Modules.Util);
return {
    {
        Title = "Player Points", 
        Contents = {
            [1912342578] = {
                DisplayName = "+100$", 
                NotificationText = "100$ has been awarded to your account.", 
                GiftNotificationText = "100$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 1, 
                Callback = function(_, v4) --[[ Line: 20 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v4, "Money", 100, true);
                end
            }, 
            [1912343043] = {
                DisplayName = "+250$", 
                NotificationText = "250$ has been awarded to your account.", 
                GiftNotificationText = "250$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 2, 
                Callback = function(_, v6) --[[ Line: 33 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v6, "Money", 250, true);
                end
            }, 
            [1912343046] = {
                DisplayName = "+500$", 
                NotificationText = "500$ has been awarded to your account.", 
                GiftNotificationText = "500$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 3, 
                Callback = function(_, v8) --[[ Line: 46 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v8, "Money", 500, true);
                end
            }, 
            [1912343591] = {
                DisplayName = "+1,000$", 
                NotificationText = "1,000$ has been awarded to your account.", 
                GiftNotificationText = "1,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 4, 
                Callback = function(_, v10) --[[ Line: 59 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v10, "Money", 1000, true);
                end
            }, 
            [2676900964] = {
                DisplayName = "+2,000$", 
                NotificationText = "2,000$ has been awarded to your account.", 
                GiftNotificationText = "2,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 5, 
                Callback = function(_, v12) --[[ Line: 72 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v12, "Money", 2000, true);
                end
            }, 
            [2676901990] = {
                DisplayName = "+5,000$", 
                NotificationText = "5,000$ has been awarded to your account.", 
                GiftNotificationText = "5,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 6, 
                Callback = function(_, v14) --[[ Line: 85 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v14, "Money", 5000, true);
                end
            }, 
            [2676902857] = {
                DisplayName = "+10,000$", 
                NotificationText = "10,000$ has been awarded to your account.", 
                GiftNotificationText = "10,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 7, 
                Callback = function(_, v16) --[[ Line: 98 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v16, "Money", 10000, true);
                end
            }, 
            [2677133608] = {
                DisplayName = "+20,000$", 
                NotificationText = "20,000$ has been awarded to your account.", 
                GiftNotificationText = "20,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 8, 
                Callback = function(_, v18) --[[ Line: 111 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v18, "Money", 20000, true);
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
                GiftNotificationText = "USERNAME's Killer Chance has went up by 15.", 
                Icon = "rbxassetid://123727335119840", 
                ProductType = "DevProduct", 
                LayoutOrder = 1, 
                HiddenInVIP = true, 
                Callback = function(_, v20) --[[ Line: 130 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v20, "KillerChance", 15, true);
                end
            }, 
            [2677209533] = {
                DisplayName = "1 Hour EXP Boost", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 1.25x EXP boost.", 
                GiftNotificationText = "USERNAME now has an hour of boosted EXP.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 2, 
                Callback = function(_, v22) --[[ Line: 143 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v22, "EXPBoostTime", 3600, true);
                end
            }, 
            [2677213976] = {
                DisplayName = "6 Hour EXP Boost", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 1.25x EXP boost.", 
                GiftNotificationText = "USERNAME now has six hours of boosted EXP.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 3, 
                Callback = function(_, v24) --[[ Line: 156 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v24, "EXPBoostTime", 21600, true);
                end
            }, 
            [2677213975] = {
                DisplayName = "12 Hour EXP Boost", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 1.25x EXP boost.", 
                GiftNotificationText = "USERNAME now has twelve hours of boosted EXP.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 4, 
                Callback = function(_, v26) --[[ Line: 170 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v26, "EXPBoostTime", 43200, true);
                end
            }
        }
    }, 
    {
        Title = "Gamepasses", 
        Contents = {
			[1468409057] = {
                DisplayName = "VIP", 
                NotificationText = "You now have a permanent 1.25x EXP boost, a VIP title (toggleable in the Settings menu), the Hakari Dance emote, and an exclusive Noob skin.", 
                GiftNotificationText = "USERNAME now has a permanent 1.25x EXP boost, a VIP title (toggleable in the Settings menu), the Hakari Dance emote, and an exclusive Noob skin.", 
                Icon = "rbxassetid://80350430833968", 
                ProductType = "Gamepass", 
				GiftingID = 3405645521, 
                LayoutOrder = 1, 
                Callback = function(_, v28) --[[ Line: 189 ]] --[[ Name: Callback ]]
                    v28:SetAttribute("VIP", true);
                    v28:SetAttribute("EXPMultiplier", (v28:GetAttribute("EXPMultiplier") or 1) + 0.25);
                    local v29 = v28:WaitForChild("PlayerData", 30);
                    if not v29 then
                        return;
                    else
                        if not v29.Purchased.Skins:FindFirstChild("VIPNoob") then
                            local l_NumberValue_0 = Instance.new("NumberValue");
                            l_NumberValue_0.Name = "VIPNoob";
                            l_NumberValue_0.Parent = v29.Purchased.Skins;
                        end;
                        if not v29.Purchased.Skins:FindFirstChild("VIPSlasher") then
                            local l_NumberValue_1 = Instance.new("NumberValue");
                            l_NumberValue_1.Name = "VIPSlasher";
                            l_NumberValue_1.Parent = v29.Purchased.Skins;
                        end;
                        if not v29.Purchased.Emotes:FindFirstChild("HakariDance") then
                            local l_NumberValue_2 = Instance.new("NumberValue");
                            l_NumberValue_2.Name = "HakariDance";
                            l_NumberValue_2.Parent = v29.Purchased.Emotes;
                        end;
                        if not v29.Purchased.Emotes:FindFirstChild("TUFF") then
                            local l_NumberValue_3 = Instance.new("NumberValue");
                            l_NumberValue_3.Name = "TUFF";
                            l_NumberValue_3.Parent = v29.Purchased.Emotes;
                        end;
                        return;
                    end;
                end
            }, 
        }
    }
};