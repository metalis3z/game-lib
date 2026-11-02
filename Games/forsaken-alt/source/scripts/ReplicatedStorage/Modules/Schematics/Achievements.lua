-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    General = {
        Title = "General", 
        LayoutOrder = 1, 
        Achievements = {
            Welcome = {
                Title = "Welcome To Hell", 
                Description = "Play Forsaken for the first time", 
                Icon = "rbxassetid://82727378637353", 
                BadgeID = 411480180016665, 
                RewardType = "Currency", 
                Amount = 300, 
                LayoutOrder = 1
            }, 
            SurvivorWins1 = {
                Title = "Survivalist I", 
                Description = "Win 10 rounds as a Survivor", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 2, 
                Requirement = 10
            }, 
            SurvivorWins2 = {
                Title = "Survivalist II", 
                Description = "Win 100 rounds as a Survivor", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 3, 
                Requirement = 100
            }, 
            SurvivorWins3 = {
                Title = "Survivalist III", 
                Description = "Win 250 rounds as a Survivor", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 4, 
                Requirement = 250
            }, 
            SurvivorWins4 = {
                Title = "Survivalist IV", 
                Description = "Win 500 rounds as a Survivor", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 5, 
                Requirement = 500
            }, 
            SurvivorWins5 = {
                Title = "Survivalist V", 
                Description = "Win 1000 rounds as a Survivor", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 6, 
                Requirement = 1000
            }, 
            KillerWins1 = {
                Title = "Coldhearted I", 
                Description = "Win 5 rounds as a Killer", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 7, 
                Requirement = 5
            }, 
            KillerWins2 = {
                Title = "Coldhearted II", 
                Description = "Win 50 rounds as a Killer", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 8, 
                Requirement = 50
            }, 
            KillerWins3 = {
                Title = "Coldhearted III", 
                Description = "Win 125 rounds as a Killer", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 9, 
                Requirement = 125
            }, 
            KillerWins4 = {
                Title = "Coldhearted IV", 
                Description = "Win 250 rounds as a Killer", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 10, 
                Requirement = 250
            }, 
            KillerWins5 = {
                Title = "Coldhearted V", 
                Description = "Win 500 rounds as a Killer", 
                Icon = "rbxassetid://13321838559", 
                LayoutOrder = 11, 
                Requirement = 500
            }
        }
    }, 
    Challenges = {
        Title = "Challenges", 
        LayoutOrder = 2, 
        Achievements = {
            LastSurvivorWin = {
                Title = "At What Cost", 
                Description = "Win as the last survivor for the first time", 
                Icon = "rbxassetid://18803613344", 
                LayoutOrder = 1
            }, 
            LastSurvivorDied = {
                Title = "Better Luck Next Time", 
                Description = "Die as the last survivor for the first time", 
                Icon = "rbxassetid://18101739041", 
                LayoutOrder = 2
            }, 
            TeamEffort = {
                Title = "Team Effort", 
                Description = "In a full lobby, win as a survivor without any deaths from your team", 
                Icon = "rbxassetid://18929268078", 
                LayoutOrder = 3
            }, 
            BarelyAlive = {
                Title = "Knockin' on Death's Door", 
                Description = "Survive a round with less than 10% health", 
                Icon = "rbxassetid://97932175175864", 
                LayoutOrder = 4
            }, 
            BadAtTheGame = {
                Title = "Esc + R", 
                Description = "Die within the first 20 seconds of a round", 
                Icon = "rbxassetid://114924685", 
                LayoutOrder = 6
            }, 
            Lifeline = {
                Title = "Lifeline", 
                Description = "Heal yourself back to full health while having less than 50% health during a round", 
                Icon = "rbxassetid://84270406627969", 
                LayoutOrder = 8
            }, 
            ServerWiped = {
                Title = "Aortic Work Of Art", 
                Description = "Wipe a full lobby as the killer", 
                Icon = "rbxassetid://11069277722", 
                LayoutOrder = 9
            }, 
            NoAbilities = {
                Title = "Unlikely Winner", 
                Description = "As a Survivor, win a round without the use of any of your abilities", 
                Icon = "rbxassetid://16395674632", 
                LayoutOrder = 10
            }, 
            NoAbilitiesHardMode = {
                Title = "Unlikely Winner 2: Electric Boogaloo", 
                Description = "As the Killer, win a round without the use of any of your abilities excluding your main ability", 
                Icon = "rbxassetid://120241137087202", 
                LayoutOrder = 11
            }, 
            NoHit = {
                Title = "Sparkly Clean", 
                Description = "As a Survivor, win a round without getting injured once", 
                Icon = "rbxassetid://6141183836", 
                LayoutOrder = 12
            }, 
            LotsaStatuses = {
                Title = "Everything's Spinning...", 
                Description = "Have 4 or more status effects applied to you at once", 
                Icon = "rbxassetid://11915686706", 
                LayoutOrder = 13
            }, 
            Yoink = {
                Title = "Yoink!", 
                Description = "Pick up an item that was dropped by a dead survivor", 
                Icon = "rbxassetid://10651606851", 
                LayoutOrder = 14
            }
        }
    }, 
    SurvivorSpecific = {
        Title = "Survivor Specific", 
        LayoutOrder = 3, 
        Achievements = {
            NoobCola = {
                Title = "Cola Addiction", 
                Description = "As Noob, drink all of your Bloxy Colas within 20 seconds", 
                Icon = "rbxassetid://9841584178", 
                LayoutOrder = 10
            }, 
            NoobDumb = {
                Title = "Actual Noob", 
                Description = "As Noob, attempt to use Bloxy Cola while under the effects of Slateskin", 
                Icon = "rbxassetid://16227840481", 
                LayoutOrder = 11
            }, 
            BuildermanDispenser = {
                Title = "Put Dispenser Here!", 
                Description = "As Builderman, keep a Dispenser alive for more than 120 seconds", 
                Icon = "rbxassetid://5188549859", 
                LayoutOrder = 20, 
                RewardType = "Skin", 
                Skin = "EngineerBuilderman"
            }, 
            ShedletskyStunner = {
                Title = "Blame John!", 
                Description = "As Shedletsky, stun the killer at least 3 times in one round", 
                Icon = "rbxassetid://285731220", 
                LayoutOrder = 30
            }, 
            GuestBlock = {
                Title = "Quickest Thinker", 
                Description = "As Guest 1337, successfully block a killer's attack 3 times in a row", 
                Icon = "rbxassetid://15288119660", 
                LayoutOrder = 40
            }, 
            GuestParry = {
                Title = "[+PARRY]", 
                Description = "As Guest 1337, successfully block a killer's attack and then land a punch on them right after.", 
                Icon = "rbxassetid://134082269213307", 
                LayoutOrder = 41, 
                RewardType = "Skin", 
                Skin = "UltrakillGuest"
            }, 
            ["007n7Clone"] = {
                Title = "Tricked Ya!", 
                Description = "As 007n7, get your clone killed through unnatural means", 
                Icon = "rbxassetid://16541142603", 
                LayoutOrder = 50
            }, 
            ElliotHatesThisGuy = {
                Title = "Blacklisted Customer", 
                Description = "As Elliot, give a Pizza to 007n7", 
                Icon = "rbxassetid://12527605634", 
                LayoutOrder = 60
            }, 
            TwoTimeDeath = {
                Title = "Wasted Potential", 
                Description = "As Two Time, die within the first 10 seconds of gaining your second chance", 
                Icon = "rbxassetid://15430324561", 
                LayoutOrder = 70
            }, 
            ChanceTime = {
                Title = "Chance Time", 
                Description = "As Chance, have your coin land on heads 5 times in a row", 
                Icon = "rbxassetid://10227542495", 
                LayoutOrder = 80
            }, 
            ChanceDead = {
                Title = "Murphy's Law", 
                Description = "As Chance, die from your flintlock blowing up on you", 
                Icon = "rbxassetid://128271936901307", 
                LayoutOrder = 81
            }, 
            ChanceWeakness = {
                Title = "0.1% Of Gamblers", 
                Description = "As Chance, keep using your coin flip ability until you gain 50 stacks of Weakness", 
                Icon = "rbxassetid://106360715419152", 
                LayoutOrder = 82, 
                RewardType = "Skin", 
                Skin = "MirrorChance"
            }, 
            ChanceReference = {
                Title = "Close Enough To Be A Reference I Guess", 
                Description = "As Chance, make a successful coin flip & then shoot at a killer within 10 seconds", 
                Icon = "rbxassetid://76154720390907", 
                LayoutOrder = 83, 
                RewardType = "Skin", 
                Skin = "UltrakillChance"
            }
        }
    }, 
    KillerSpecific = {
        Title = "Killer Specific", 
        LayoutOrder = 4, 
        Achievements = {
            JasonBrutality = {
                Title = "Brutality", 
                Description = "As Jason, kill a Survivor with Behead", 
                Icon = "rbxassetid://86558690143784", 
                LayoutOrder = 10
            }, 
            JasonSpecialDay = {
                Title = "Mother's Calling", 
                Description = "Play as Jason on Friday the 13th", 
                Icon = "rbxassetid://101574368982206", 
                LayoutOrder = 11
            }, 
            c00lkiddProjectile = {
                Title = "One Stone", 
                Description = "As c00lkidd, hit two or more survivors with one projectile", 
                Icon = "rbxassetid://605704586", 
                LayoutOrder = 20
            }, 
            JohnDoeSpikes = {
                Title = "Vlad The Impaler", 
                Description = "As John Doe, kill a Survivor with one of your spikes", 
                Icon = "rbxassetid://697378648", 
                LayoutOrder = 30
            }, 
            JohnDoeSpecialDay = {
                Title = "It's Just A Rumor", 
                Description = "Play as John Doe on March 18th", 
                Icon = "rbxassetid://700144063", 
                LayoutOrder = 31
            }
        }
    }, 
    Fun = {
        Title = "Fun", 
        LayoutOrder = 10, 
        Achievements = {
            MeetBrandon = {
                Title = ".", 
                Description = "Meet ozolog1\226\128\153s best friend for the first time", 
                Icon = "rbxassetid://100643816408684", 
                LayoutOrder = 3, 
                Clientsided = true
            }, 
            ILoveCats = {
                Title = "Meow meow meow", 
                Description = "Interact with the cat in the lobby more than 15 times", 
                Icon = "rbxassetid://13333189485", 
                LayoutOrder = 4, 
                Clientsided = true
            }
        }
    }, 
    Completionist = {
        Title = "Completionist", 
        LayoutOrder = 18, 
        Achievements = {
            FullRoster = {
                Title = "Full Roster", 
                Description = "Unlock every purchasable character", 
                Icon = "rbxassetid://561066534", 
                LayoutOrder = 1, 
                Requirement = function() --[[ Line: 358 ]] --[[ Name: Requirement ]]
                    local v0 = 0;
                    for _, v2 in pairs({
                        game.ReplicatedStorage.Assets.Survivors, 
                        game.ReplicatedStorage.Assets.Killers
                    }) do
                        for _, v4 in pairs(v2:GetChildren()) do
                            local l_Config_0 = v4:FindFirstChild("Config");
                            if not (l_Config_0 and require(l_Config_0) or {
                                Exclusive = true
                            }).Exclusive then
                                v0 = v0 + 1;
                            end;
                        end;
                    end;
                    return v0;
                end
            }, 
            TrueSurvivalist = {
                Title = "True Survivalist", 
                Description = "Survive at least once on each map", 
                Icon = "rbxassetid://16720206732", 
                LayoutOrder = 3, 
                Requirement = function() --[[ Line: 405 ]] --[[ Name: Requirement ]]
                    if game["Run Service"]:IsServer() then
                        local v6 = 0;
                        for _, v8 in pairs(game.ServerStorage.Assets.Maps:GetChildren()) do
                            local l_Config_1 = v8:FindFirstChild("Config");
                            local v10 = l_Config_1 and require(l_Config_1) or {
                                Disabled = true
                            };
                            if not v10.Disabled and not v10.Exclusive then
                                v6 = v6 + 1;
                            end;
                        end;
                        workspace:SetAttribute("TotalPlayableMaps", v6);
                        return v6;
                    elseif game["Run Service"]:IsClient() then
                        if not workspace:GetAttribute("TotalPlayableMaps") then
                            repeat
                                task.wait();
                            until workspace:GetAttribute("TotalPlayableMaps");
                        end;
                        return workspace:GetAttribute("TotalPlayableMaps");
                    else
                        return;
                    end;
                end
            }, 
            RespawningElsewhere = {
                Title = "Respawning Elsewhere", 
                Description = "Die at least once on each map", 
                Icon = "rbxassetid://94075323758299", 
                LayoutOrder = 4, 
                Requirement = function() --[[ Line: 433 ]] --[[ Name: Requirement ]]
                    if game["Run Service"]:IsServer() then
                        local v11 = 0;
                        for _, v13 in pairs(game.ServerStorage.Assets.Maps:GetChildren()) do
                            local l_Config_2 = v13:FindFirstChild("Config");
                            local v15 = l_Config_2 and require(l_Config_2) or {
                                Disabled = true
                            };
                            if not v15.Disabled and not v15.Exclusive then
                                v11 = v11 + 1;
                            end;
                        end;
                        workspace:SetAttribute("TotalPlayableMaps", v11);
                        return v11;
                    elseif game["Run Service"]:IsClient() then
                        if not workspace:GetAttribute("TotalPlayableMaps") then
                            repeat
                                task.wait();
                            until workspace:GetAttribute("TotalPlayableMaps");
                        end;
                        return workspace:GetAttribute("TotalPlayableMaps");
                    else
                        return;
                    end;
                end
            }
        }
    }, 
    SurvivorsMilestones = {
        Title = "Survivor Milestones", 
        LayoutOrder = 19, 
        Achievements = {
            NoobMilestone = {
                Title = "From Rags To Riches", 
                Description = "Reach Lvl 100 on Noob", 
                Icon = "rbxassetid://16152678641", 
                LayoutOrder = 1, 
                Requirement = 100
            }, 
            BuildermanMilestone = {
                Title = "Premium Builder's Club", 
                Description = "Reach Lvl 100 on Builderman", 
                Icon = "rbxassetid://13999206023", 
                LayoutOrder = 2, 
                Requirement = 100
            }, 
            ShedletskyMilestone = {
                Title = "S.F.O.T.H.", 
                Description = "Reach Lvl 100 on Shedletsky", 
                Icon = "rbxassetid://157061944", 
                LayoutOrder = 3, 
                Requirement = 100
            }, 
            ["007n7Milestone"] = {
                Title = "All Ur Base Are Belong 2 Me", 
                Description = "Reach Lvl 100 on 007n7", 
                Icon = "rbxassetid://9265687294", 
                LayoutOrder = 4, 
                Requirement = 100
            }, 
            Guest1337Milestone = {
                Title = "Robloxia's Strongest Soldier", 
                Description = "Reach Lvl 100 on Guest 1337", 
                Icon = "rbxassetid://14555123937", 
                LayoutOrder = 5, 
                Requirement = 100
            }, 
            ElliotMilestone = {
                Title = "Employee Of The Century", 
                Description = "Reach Lvl 100 on Elliot", 
                Icon = "rbxassetid://6003896049", 
                LayoutOrder = 6, 
                Requirement = 100
            }, 
            TwoTimeMilestone = {
                Title = "Not My First Time", 
                Description = "Reach Lvl 100 on Two Time", 
                Icon = "rbxassetid://18720028391", 
                LayoutOrder = 7, 
                Requirement = 100
            }, 
            ChanceMilestone = {
                Title = "Luckiest Man Alive", 
                Description = "Reach Lvl 100 on Chance", 
                Icon = "rbxassetid://112806027715945", 
                LayoutOrder = 8, 
                Requirement = 100
            }, 
            DusekkarMilestone = {
                Title = "I Cast Upon Thee", 
                Description = "Reach Lvl 100 on Dusekkar", 
                Icon = "rbxassetid://18913264732", 
                LayoutOrder = 9, 
                Requirement = 100
            }
        }
    }, 
    KillersMilestones = {
        Title = "Killer Milestones", 
        LayoutOrder = 20, 
        Achievements = {
            c00lkiddMilestone = {
                Title = "Coolest Kid In Town", 
                Description = "Reach Lvl 100 on c00lkidd", 
                Icon = "rbxassetid://10560525674", 
                LayoutOrder = 1, 
                Requirement = 100
            }, 
            JasonMilestone = {
                Title = "The Masked Brute", 
                Description = "Reach Lvl 100 on Jason", 
                Icon = "rbxassetid://1186751979", 
                LayoutOrder = 2, 
                Requirement = 100
            }, 
            ["1x1x1x1Milestone"] = {
                Title = "Death Of Roblox (Real)", 
                Description = "Reach Lvl 100 on 1x1x1x1", 
                Icon = "rbxassetid://18470992599", 
                LayoutOrder = 3, 
                Requirement = 100
            }, 
            JohnDoeMilestone = {
                Title = "Unidentified Foe", 
                Description = "Reach Lvl 100 on John Doe", 
                Icon = "rbxassetid://811793373", 
                LayoutOrder = 4, 
                Requirement = 100
            }
        }
    }
};