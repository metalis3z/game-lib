-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local l_RareEggs_0 = script:WaitForChild("RareEggs");
return {
    Name = "Easter", 
    Year = "2025", 
    Title = "Easter2025", 
    Currency = "Eggs2025", 
    RareCurrency = "RareEggs2025", 
    ShopCover = "rbxassetid://111778291609370", 
    ShopButton = "rbxassetid://93997606516273", 
    PrimaryColor = Color3.fromRGB(120, 220, 120), 
    CoinBagIcons = {
        EmptyBag = "rbxassetid://124750169912761", 
        FullBag = "rbxassetid://118335122838129"
    }, 
    ItemPackItems = {
        Knife = {
            ItemID = "Bloom", 
            GamePassID = 1165838634, 
            DevProductID = 3268213875
        }, 
        Gun = {
            ItemID = "Flora", 
            GamePassID = 1167438350, 
            DevProductID = 3268214475
        }, 
        Bundle = {
            KnifeItemID = "Bloom", 
            GunItemID = "Flora", 
            EffectItemID = "Bloom2025", 
            GamePassID = 1166580569, 
            DevProductID = 3268216220
        }
    }, 
    RewardTracks = {
        CommonEggs = {
            RequiredMaterial = "Eggs2025", 
            Rewards = {
                [1] = {
                    ItemName = "Carrots_K_2025", 
                    Cost = 200, 
                    Type = "Weapons"
                }, 
                [2] = {
                    ItemName = "CommonEgg2025", 
                    Cost = 400, 
                    Type = "Toys"
                }, 
                [3] = {
                    ItemName = "Decorated_K_2025", 
                    Cost = 800, 
                    Type = "Weapons"
                }, 
                [4] = {
                    ItemName = "Sunny_G_2025", 
                    Cost = 2000, 
                    Type = "Weapons"
                }, 
                [5] = {
                    ItemName = "Carrots2025", 
                    Cost = 3000, 
                    Type = "Effects"
                }, 
                [6] = {
                    ItemName = "Bunnies_K_2025", 
                    Cost = 4000, 
                    Type = "Weapons"
                }
            }
        }, 
        RareEggs = {
            RequiredMaterial = "RareEggs2025", 
            Rewards = {
                [1] = {
                    ItemName = "RareEgg2025", 
                    Cost = 2, 
                    Type = "Toys"
                }, 
                [2] = {
                    ItemName = "Chick_K_2025", 
                    Cost = 4, 
                    Type = "Weapons"
                }, 
                [3] = {
                    ItemName = "Meadow_G_2025", 
                    Cost = 6, 
                    Type = "Weapons"
                }, 
                [4] = {
                    ItemName = "Butterflies_G_2025", 
                    Cost = 8, 
                    Type = "Weapons"
                }, 
                [5] = {
                    ItemName = "Rainbows2025", 
                    Cost = 10, 
                    Type = "Effects"
                }
            }
        }
    }, 
    Remotes = script:WaitForChild("Remotes"), 
    CommonEggParts = script:WaitForChild("CommonEggs"), 
    RareEggParts = l_RareEggs_0, 
    RareEggNames = {
        SpeedyEgg2025 = true, 
        PoliceEgg2025 = true, 
        DiamondEgg2025 = true, 
        ConstructionEgg2025 = true, 
        RobotEgg2025 = true, 
        DoctorEgg2025 = true, 
        ScientistEgg2025 = true, 
        MilitaryEgg2025 = true, 
        ExperimentEgg2025 = true, 
        OfficeEgg2025 = true
    }, 
    RareEggsList = {
        House2 = {
            l_RareEggs_0:WaitForChild("SpeedyEgg2025"), 
            l_RareEggs_0:WaitForChild("PoliceEgg2025")
        }, 
        Bank2 = {
            l_RareEggs_0:WaitForChild("DiamondEgg2025"), 
            l_RareEggs_0:WaitForChild("PoliceEgg2025")
        }, 
        Factory = {
            l_RareEggs_0:WaitForChild("ConstructionEgg2025"), 
            l_RareEggs_0:WaitForChild("RobotEgg2025")
        }, 
        ResearchFacility = {
            l_RareEggs_0:WaitForChild("DoctorEgg2025"), 
            l_RareEggs_0:WaitForChild("ScientistEgg2025")
        }, 
        MilBase = {
            l_RareEggs_0:WaitForChild("MilitaryEgg2025"), 
            l_RareEggs_0:WaitForChild("ExperimentEgg2025")
        }, 
        Office3 = {
            l_RareEggs_0:WaitForChild("OfficeEgg2025"), 
            l_RareEggs_0:WaitForChild("SpeedyEgg2025")
        }, 
        Workplace = {
            l_RareEggs_0:WaitForChild("OfficeEgg2025"), 
            l_RareEggs_0:WaitForChild("ConstructionEgg2025")
        }, 
        Hotel = {
            l_RareEggs_0:WaitForChild("OfficeEgg2025"), 
            l_RareEggs_0:WaitForChild("DiamondEgg2025")
        }, 
        BioLab = {
            l_RareEggs_0:WaitForChild("ExperimentEgg2025"), 
            l_RareEggs_0:WaitForChild("ScientistEgg2025")
        }, 
        Mansion2 = {
            l_RareEggs_0:WaitForChild("SpeedyEgg2025"), 
            l_RareEggs_0:WaitForChild("DiamondEgg2025")
        }, 
        Hospital3 = {
            l_RareEggs_0:WaitForChild("DoctorEgg2025"), 
            l_RareEggs_0:WaitForChild("RobotEgg2025")
        }, 
        PoliceStation = {
            l_RareEggs_0:WaitForChild("MilitaryEgg2025"), 
            l_RareEggs_0:WaitForChild("PoliceEgg2025")
        }
    }, 
    ProfileData = {
        Claimed = {}, 
        RareEggs = {}
    }
};