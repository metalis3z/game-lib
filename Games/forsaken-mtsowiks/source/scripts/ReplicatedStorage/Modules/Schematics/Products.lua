-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("AnalyticsService");
local _ = game:GetService("RunService");
local v2 = require(game.ReplicatedStorage.Modules.Util);
return {
    {
        Title = "Masquerade", 
        TitleProperties = {
            TextColor3 = Color3.fromRGB(255, 149, 96)
        }, 
        Contents = {
            [3442289626] = {
                DisplayName = "50% Sukkar Boost [1 HR]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 50% Sukkar boost.", 
                GiftNotificationText = "USERNAME now has an hour of boosted Sukkars.", 
                Icon = "rbxassetid://95412814563183", 
                ProductType = "DevProduct", 
                LayoutOrder = 1, 
                Callback = function(_, v4) --[[ Line: 24 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v4, "CandyBoostTime", 3600, true);
                end
            }, 
            [3442291361] = {
                DisplayName = "50% Sukkar Boost [3 HRS]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 50% Sukkar boost.", 
                GiftNotificationText = "USERNAME now has three hours of boosted Sukkars.", 
                Icon = "rbxassetid://95412814563183", 
                ProductType = "DevProduct", 
                LayoutOrder = 2, 
                Callback = function(_, v6) --[[ Line: 36 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v6, "CandyBoostTime", 10800, true);
                end
            }, 
            [3442291574] = {
                DisplayName = "50% Sukkar Boost [6 HRS]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 50% Sukkar boost.", 
                GiftNotificationText = "USERNAME now has six hours of boosted Sukkars.", 
                Icon = "rbxassetid://95412814563183", 
                ProductType = "DevProduct", 
                LayoutOrder = 3, 
                Callback = function(_, v8) --[[ Line: 48 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v8, "CandyBoostTime", 21600, true);
                end
            }, 
            [3442291815] = {
                DisplayName = "50% Sukkar Boost [12 HRS]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 50% Sukkar boost.", 
                GiftNotificationText = "USERNAME now has twelve hours of boosted Sukkars.", 
                Icon = "rbxassetid://95412814563183", 
                ProductType = "DevProduct", 
                LayoutOrder = 4, 
                Callback = function(_, v10) --[[ Line: 60 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v10, "CandyBoostTime", 43200, true);
                end
            }, 
            [3444270010] = {
                DisplayName = "+125 Sukkars", 
                NotificationText = "125 Sukkars have been awarded to your account.", 
                GiftNotificationText = "125 Sukkars have been awarded to USERNAME.", 
                Icon = "rbxassetid://95412814563183", 
                ProductType = "DevProduct", 
                LayoutOrder = 5, 
                Callback = function(_, v12) --[[ Line: 72 ]] --[[ Name: Callback ]]
                    local l_PlayerData_0 = v12:FindFirstChild("PlayerData");
                    if not l_PlayerData_0 then
                        return;
                    else
                        local l_2025_MASQUERADE_0 = l_PlayerData_0.EventCurrency["2025_MASQUERADE"];
                        l_2025_MASQUERADE_0.Value = l_2025_MASQUERADE_0.Value + 125;
                        return;
                    end;
                end
            }, 
            [3444270400] = {
                DisplayName = "+250 Sukkars", 
                NotificationText = "250 Sukkars have been awarded to your account.", 
                GiftNotificationText = "250 Sukkars have been awarded to USERNAME.", 
                Icon = "rbxassetid://139087228129328", 
                ProductType = "DevProduct", 
                LayoutOrder = 6, 
                Callback = function(_, v16) --[[ Line: 86 ]] --[[ Name: Callback ]]
                    local l_PlayerData_1 = v16:FindFirstChild("PlayerData");
                    if not l_PlayerData_1 then
                        return;
                    else
                        local l_2025_MASQUERADE_1 = l_PlayerData_1.EventCurrency["2025_MASQUERADE"];
                        l_2025_MASQUERADE_1.Value = l_2025_MASQUERADE_1.Value + 250;
                        return;
                    end;
                end
            }, 
            [3444270752] = {
                DisplayName = "+500 Sukkars", 
                NotificationText = "500 Sukkars have been awarded to your account.", 
                GiftNotificationText = "500 Sukkars have been awarded to USERNAME.", 
                Icon = "rbxassetid://124549599195545", 
                ProductType = "DevProduct", 
                LayoutOrder = 7, 
                Callback = function(_, v20) --[[ Line: 100 ]] --[[ Name: Callback ]]
                    local l_PlayerData_2 = v20:FindFirstChild("PlayerData");
                    if not l_PlayerData_2 then
                        return;
                    else
                        local l_2025_MASQUERADE_2 = l_PlayerData_2.EventCurrency["2025_MASQUERADE"];
                        l_2025_MASQUERADE_2.Value = l_2025_MASQUERADE_2.Value + 500;
                        return;
                    end;
                end
            }, 
            [3444269368] = {
                DisplayName = "+1,000 Sukkars", 
                NotificationText = "1,000 Sukkars have been awarded to your account.", 
                GiftNotificationText = "1,000 Sukkars have been awarded to USERNAME.", 
                Icon = "rbxassetid://123356521593504", 
                ProductType = "DevProduct", 
                LayoutOrder = 8, 
                Callback = function(_, v24) --[[ Line: 114 ]] --[[ Name: Callback ]]
                    local l_PlayerData_3 = v24:FindFirstChild("PlayerData");
                    if not l_PlayerData_3 then
                        return;
                    else
                        local l_2025_MASQUERADE_3 = l_PlayerData_3.EventCurrency["2025_MASQUERADE"];
                        l_2025_MASQUERADE_3.Value = l_2025_MASQUERADE_3.Value + 1000;
                        return;
                    end;
                end
            }
        }
    }, 
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
                Callback = function(_, v28) --[[ Line: 134 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v28, "Money", 100, true);
                end
            }, 
            [1912343043] = {
                DisplayName = "+250$", 
                NotificationText = "250$ has been awarded to your account.", 
                GiftNotificationText = "250$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 2, 
                Callback = function(_, v30) --[[ Line: 147 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v30, "Money", 250, true);
                end
            }, 
            [1912343046] = {
                DisplayName = "+500$", 
                NotificationText = "500$ has been awarded to your account.", 
                GiftNotificationText = "500$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 3, 
                Callback = function(_, v32) --[[ Line: 160 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v32, "Money", 500, true);
                end
            }, 
            [1912343591] = {
                DisplayName = "+1,000$", 
                NotificationText = "1,000$ has been awarded to your account.", 
                GiftNotificationText = "1,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 4, 
                Callback = function(_, v34) --[[ Line: 173 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v34, "Money", 1000, true);
                end
            }, 
            [2676900964] = {
                DisplayName = "+2,000$", 
                NotificationText = "2,000$ has been awarded to your account.", 
                GiftNotificationText = "2,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 5, 
                Callback = function(_, v36) --[[ Line: 186 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v36, "Money", 2000, true);
                end
            }, 
            [2676901990] = {
                DisplayName = "+5,000$", 
                NotificationText = "5,000$ has been awarded to your account.", 
                GiftNotificationText = "5,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 6, 
                Callback = function(_, v38) --[[ Line: 199 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v38, "Money", 5000, true);
                end
            }, 
            [2676902857] = {
                DisplayName = "+10,000$", 
                NotificationText = "10,000$ has been awarded to your account.", 
                GiftNotificationText = "10,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 7, 
                Callback = function(_, v40) --[[ Line: 212 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v40, "Money", 10000, true);
                end
            }, 
            [2677133608] = {
                DisplayName = "+20,000$", 
                NotificationText = "20,000$ has been awarded to your account.", 
                GiftNotificationText = "20,000$ has been awarded to USERNAME.", 
                Icon = "rbxassetid://94042522696619", 
                ProductType = "DevProduct", 
                LayoutOrder = 8, 
                Callback = function(_, v42) --[[ Line: 225 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v42, "Money", 20000, true);
                end
            }
        }
    }, 
    {
        Title = "Boosts", 
        Contents = {
            [2677209533] = {
                DisplayName = "25% EXP Boost [1 HR]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 25% EXP boost.", 
                GiftNotificationText = "USERNAME now has an hour of boosted EXP.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 1, 
                Callback = function(_, v44) --[[ Line: 244 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v44, "EXPBoostTime", 3600, true);
                end
            }, 
            [3414019025] = {
                DisplayName = "25% EXP Boost [3 HRS]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 25% EXP boost.", 
                GiftNotificationText = "USERNAME now has three hours of boosted EXP.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 2, 
                Callback = function(_, v46) --[[ Line: 257 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v46, "EXPBoostTime", 10800, true);
                end
            }, 
            [2677213976] = {
                DisplayName = "25% EXP Boost [6 HRS]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 25% EXP boost.", 
                GiftNotificationText = "USERNAME now has six hours of boosted EXP.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 3, 
                Callback = function(_, v48) --[[ Line: 271 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v48, "EXPBoostTime", 21600, true);
                end
            }, 
            [2677213975] = {
                DisplayName = "25% EXP Boost [12 HRS]", 
                NotificationText = "Click the Stats tab on the left side of your screen to check how much time is left on your 25% EXP boost.", 
                GiftNotificationText = "USERNAME now has twelve hours of boosted EXP.", 
                Icon = "rbxassetid://94061207471057", 
                ProductType = "DevProduct", 
                LayoutOrder = 4, 
                Callback = function(_, v50) --[[ Line: 285 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v50, "EXPBoostTime", 43200, true);
                end
            }, 
            [2677148002] = {
                DisplayName = "+15 Killer Chance", 
                NotificationText = "Your Killer Chance has went up by 15.", 
                GiftNotificationText = "USERNAME's Killer Chance has went up by 15.", 
                Icon = "rbxassetid://123727335119840", 
                ProductType = "DevProduct", 
                LayoutOrder = 5, 
                HiddenInVIP = true, 
                Callback = function(_, v52) --[[ Line: 299 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    v2:AddToPlayerStat(v52, "KillerChance", 15, true);
                end
            }
        }
    }, 
    {
        Title = "Gamepasses", 
        Contents = {
            [1009460688] = {
                DisplayName = "VIP", 
                NotificationText = "You now have a permanent 25% EXP boost, a VIP title (toggleable in the Settings menu), the Hakari Dance emote, and an exclusive Noob skin.", 
                GiftNotificationText = "USERNAME now has a permanent 25% EXP boost, a VIP title (toggleable in the Settings menu), the Hakari Dance emote, and an exclusive Noob skin.", 
                Icon = "rbxassetid://80350430833968", 
                ProductType = "Gamepass", 
                GiftingID = 3381534947, 
                LayoutOrder = 1, 
                Callback = function(_, v54) --[[ Line: 318 ]] --[[ Name: Callback ]]
                    v54:SetAttribute("VIP", true);
                    v54:SetAttribute("EXPMultiplier", (v54:GetAttribute("EXPMultiplier") or 1) + 0.25);
                    local v55 = v54:WaitForChild("PlayerData", 30);
                    if not v55 then
                        return;
                    else
                        if not v55.Purchased.Skins:FindFirstChild("VIPNoob") then
                            local l_NumberValue_0 = Instance.new("NumberValue");
                            l_NumberValue_0.Name = "VIPNoob";
                            l_NumberValue_0.Parent = v55.Purchased.Skins;
                        end;
                        if not v55.Purchased.Skins:FindFirstChild("VIPSlasher") then
                            local l_NumberValue_1 = Instance.new("NumberValue");
                            l_NumberValue_1.Name = "VIPSlasher";
                            l_NumberValue_1.Parent = v55.Purchased.Skins;
                        end;
                        if not v55.Purchased.Emotes:FindFirstChild("HakariDance") then
                            local l_NumberValue_2 = Instance.new("NumberValue");
                            l_NumberValue_2.Name = "HakariDance";
                            l_NumberValue_2.Parent = v55.Purchased.Emotes;
                        end;
                        if not v55.Purchased.Emotes:FindFirstChild("TUFF") then
                            local l_NumberValue_3 = Instance.new("NumberValue");
                            l_NumberValue_3.Name = "TUFF";
                            l_NumberValue_3.Parent = v55.Purchased.Emotes;
                        end;
                        return;
                    end;
                end
            }, 
            [1175324261] = {
                DisplayName = "Earth Day", 
                NotificationText = "You now have access to 6 new skins for Earth day.", 
                Icon = "rbxassetid://76629366019649", 
                ProductType = "Gamepass", 
                isOffsale = true, 
                LayoutOrder = 2, 
                Callback = function(_, v61) --[[ Line: 407 ]] --[[ Name: Callback ]]
                    local v62 = v61:WaitForChild("PlayerData", 30);
                    if not v62 then
                        return;
                    else
                        if not v62.Purchased.Skins:FindFirstChild("EarthDayShedletsky") then
                            local l_NumberValue_4 = Instance.new("NumberValue");
                            l_NumberValue_4.Name = "EarthDayShedletsky";
                            l_NumberValue_4.Parent = v62.Purchased.Skins;
                        end;
                        if not v62.Purchased.Skins:FindFirstChild("TreehuggerElliot") then
                            local l_NumberValue_5 = Instance.new("NumberValue");
                            l_NumberValue_5.Name = "TreehuggerElliot";
                            l_NumberValue_5.Parent = v62.Purchased.Skins;
                        end;
                        if not v62.Purchased.Skins:FindFirstChild("GreenbeltGuest") then
                            local l_NumberValue_6 = Instance.new("NumberValue");
                            l_NumberValue_6.Name = "GreenbeltGuest";
                            l_NumberValue_6.Parent = v62.Purchased.Skins;
                        end;
                        if not v62.Purchased.Skins:FindFirstChild("CleanGent007n7") then
                            local l_NumberValue_7 = Instance.new("NumberValue");
                            l_NumberValue_7.Name = "CleanGent007n7";
                            l_NumberValue_7.Parent = v62.Purchased.Skins;
                        end;
                        if not v62.Purchased.Skins:FindFirstChild("GreenDayBuilderman") then
                            local l_NumberValue_8 = Instance.new("NumberValue");
                            l_NumberValue_8.Name = "GreenDayBuilderman";
                            l_NumberValue_8.Parent = v62.Purchased.Skins;
                        end;
                        if not v62.Purchased.Skins:FindFirstChild("Guardian1x1x1x1") then
                            local l_NumberValue_9 = Instance.new("NumberValue");
                            l_NumberValue_9.Name = "Guardian1x1x1x1";
                            l_NumberValue_9.Parent = v62.Purchased.Skins;
                        end;
                        return;
                    end;
                end
            }, 
            [1167749181] = {
                DisplayName = "Additional Emote Wheel", 
                NotificationText = "You now have access to eight additional emote slots.", 
                GiftNotificationText = "USERNAME now has access to eight additional emote slots.", 
                Icon = "rbxassetid://80350430833968", 
                ProductType = "Gamepass", 
                GiftingID = 3381636030, 
                LayoutOrder = 3, 
                Callback = function(_, v70) --[[ Line: 466 ]] --[[ Name: Callback ]]
                    v70:SetAttribute("ExtraEmotes", true);
                end
            }
        }
    }
};