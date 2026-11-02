-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local v2 = require(l_ReplicatedStorage_0.Modules.Util);
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
                Amount = 50000000, 
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
                Description = "Win as the last Survivor for the first time", 
                Icon = "rbxassetid://18803613344", 
                LayoutOrder = 1
            }, 
            LastSurvivorDied = {
                Title = "Better Luck Next Time", 
                Description = "Die as the last Survivor for the first time", 
                Icon = "rbxassetid://18101739041", 
                LayoutOrder = 2
            }, 
            TeamEffort = {
                Title = "Team Effort", 
                Description = "In a full lobby, win as a Survivor without any deaths from your team", 
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
                Description = "Wipe a full lobby as the Killer", 
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
                Icon = "rbxassetid://75754984927301", 
                LayoutOrder = 12
            }, 
            LotsaStatuses = {
                Title = "Everything's Spinning...", 
                Description = "Have 4 or more status effects applied to you at once", 
                Icon = "rbxassetid://117008832979299", 
                LayoutOrder = 13
            }, 
            Yoink = {
                Title = "Yoink!", 
                Description = "Pick up an item that was dropped by a dead Survivor", 
                Icon = "rbxassetid://10651606851", 
                LayoutOrder = 14
            }, 
            MakePlayerRagequit = {
                Title = "Too Good", 
                Description = "Make a Survivor leave the game within 15 seconds of attacking them (aka ragequit)", 
                Icon = "rbxassetid://300673655", 
                LayoutOrder = 15
            }, 
            PizzaSteal = {
                Title = "Gluttonous Beast", 
                Description = "At 70% health or above, steal a pizza from someone below 25% health, or under the same conditions have it stolen from you.", 
                Icon = "rbxassetid://98210621076463", 
                LayoutOrder = 16
            }
        }
    }, 
    SurvivorSpecific = {
        Title = "Survivor Specific", 
        LayoutOrder = 3, 
        Achievements = {
            NoobCola = {
                Title = "Cola Addiction", 
                Description = ("As Noob, drink 2 Bloxy Colas within the same %* seconds."):format((tostring(require(game.ReplicatedStorage.Assets.Items.BloxyCola.Config).StackingThreshold or 60))), 
                Icon = "rbxassetid://9841584178", 
                LayoutOrder = 10
            }, 
            NoobQuick = {
                Title = "You're Quick as Hell!", 
                Description = "As Noob, run as far as possible with one Bloxy Cola", 
                Icon = "rbxassetid://9098242386", 
                LayoutOrder = 11, 
                Clientsided = true
            }, 
            NoobDumb = {
                Title = "Actual Noob", 
                Description = "As Noob, attempt to use Bloxy Cola while under the effects of Slateskin", 
                Icon = "rbxassetid://16227840481", 
                LayoutOrder = 12
            }, 
            NoobGenius = {
                Title = "Deodorant", 
                Description = "As Noob, use the Ghostburger to hide from the Killer or their minions", 
                Icon = "rbxassetid://32951087", 
                LayoutOrder = 13
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
                Description = "As Shedletsky, stun the Killer at least 3 times in one round", 
                Icon = "rbxassetid://285731220", 
                LayoutOrder = 30
            }, 
            ShedletskyYesPapa = {
                Title = "Johnny, Johnny...", 
                Description = "As Shedletsky, get caught eating your fried chicken by the Killer", 
                Icon = "rbxassetid://8751115252", 
                LayoutOrder = 31
            }, 
            GuestBlock = {
                Title = "Quickest Thinker", 
                Description = "As Guest 1337, successfully block a Killer's attack 3 times in a row", 
                Icon = "rbxassetid://15288119660", 
                LayoutOrder = 40
            }, 
            GuestParry = {
                Title = "[+PARRY]", 
                Description = "As Guest 1337, successfully block a Killer's attack and then land a punch on them right after", 
                Icon = "rbxassetid://134082269213307", 
                LayoutOrder = 41, 
                RewardType = "Skin", 
                Skin = "UltrakillGuest"
            }, 
            GuestAlpha = {
                Title = "Forward Aerial", 
                Description = "As Guest 1337, successfully punch a Killer while falling", 
                Icon = "rbxassetid://79360383913522", 
                LayoutOrder = 42
            }, 
            GuestDaigo = {
                Title = "37", 
                Description = "As Guest 1337, block an otherwise lethal attack as the Last Survivor Standing, and win", 
                Icon = "rbxassetid://14955957476", 
                LayoutOrder = 43
            }, 
            ["007n7Clone"] = {
                Title = "Tricked Ya!", 
                Description = "As 007n7, trick the Killer into killing your clone", 
                Icon = "rbxassetid://16541142603", 
                LayoutOrder = 50
            }, 
            ["007n7Close"] = {
                Title = "Alt + Tab", 
                Description = "As 007n7, successfully teleport with c00lgui while the Killer is less than 12 studs away from you", 
                Icon = "rbxassetid://5140208552", 
                LayoutOrder = 51
            }, 
            ["007n7Oops"] = {
                Title = "Severe And Continuous", 
                Description = "As 007n7, use c00lgui to teleport directly to the Killer", 
                Icon = "rbxassetid://110453155959267", 
                LayoutOrder = 52
            }, 
            ElliotHatesThisGuy = {
                Title = "Blacklisted Customer", 
                Description = "As Elliot, give a Pizza to 007n7", 
                Icon = "rbxassetid://12527605634", 
                LayoutOrder = 60
            }, 
            ElliotStupid = {
                Title = "Wrong Address", 
                Description = "As Elliot, throw your pizza at the Killer", 
                Icon = "rbxassetid://113778170699151", 
                LayoutOrder = 61
            }, 
            TwoTimeDeath = {
                Title = "Wasted Potential", 
                Description = "As Two Time, die within the first 10 seconds of gaining your second chance", 
                Icon = "rbxassetid://15430324561", 
                LayoutOrder = 70
            }, 
            TwoTimeDeadRinger = {
                Title = "Dead Ringer", 
                Description = "As Two Time, respawn less than 16 studs away from where you initially died", 
                Icon = "rbxassetid://133791422691032", 
                LayoutOrder = 71
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
                Description = "As Chance, make a successful coin flip & then shoot at a Killer within 10 seconds", 
                Icon = "rbxassetid://76154720390907", 
                LayoutOrder = 83, 
                RewardType = "Skin", 
                Skin = "UltrakillChance"
            }, 
            ChanceMomGetTheCamera = {
                Title = "OHH, BABY A TRIPLE!", 
                Description = "As Chance, hit the Killer and 2 of their Minions in the same shot", 
                Icon = "rbxassetid://433960422", 
                LayoutOrder = 84, 
                RewardType = "Skin", 
                Skin = "MLGChance"
            }, 
            TaphGetLastManStanding = {
                Title = "Years in the future, but not many...", 
                Description = "As Taph, be the last survivor standing", 
                Icon = "rbxassetid://139215422392850", 
                LayoutOrder = 90, 
                RewardType = "Skin", 
                Skin = "WaywardTaph"
            }, 
            DusekkarUbercharge = {
                Title = "\195\156berCharge", 
                Description = "As Dusekkar, shield a Survivor from lethal damage.", 
                Icon = "rbxassetid://11842845636", 
                LayoutOrder = 100, 
                RewardType = "Skin", 
                Skin = "MedicDusekkar", 
                Callback = function(v3) --[[ Line: 365 ]] --[[ Name: Callback ]]
                    -- upvalues: v2 (copy)
                    if not v2:IsAlive(v3.VictimCharacter) then
                        warn("NOT ALIVE");
                        return;
                    else
                        local l_Humanoid_0 = v3.VictimCharacter.Humanoid;
                        local l_Attribute_0 = v3.VictimCharacter:GetAttribute("DusekkarProtected");
                        local v6 = l_Attribute_0 and game.Players:FindFirstChild(l_Attribute_0);
                        if v6 and l_Humanoid_0.Health > v3.RealDamage and l_Humanoid_0.Health <= v3.RawDamage then
                            return {
                                v6
                            };
                        else
                            return false;
                        end;
                    end;
                end
            }
        }
    }, 
    KillerSpecific = {
        Title = "Killer Specific", 
        LayoutOrder = 4, 
        Achievements = {
            JasonBrutality = {
                Title = "Brutality", 
                Description = "As Slasher, kill a Survivor with Behead", 
                Icon = "rbxassetid://86558690143784", 
                LayoutOrder = 10
            }, 
            JasonSpecialDay = {
                Title = "Mother's Calling", 
                Description = "Play as Slasher on Friday the 13th", 
                Icon = "rbxassetid://101574368982206", 
                LayoutOrder = 11
            }, 
            JasonFool = {
                Title = "What a Shame.", 
                Description = "As Slasher, Kill a Survivor with the First Hit of Gashing Wound near a Taph Trap", 
                Icon = "rbxassetid://3491384161", 
                LayoutOrder = 12, 
                RewardType = "Skin", 
                Skin = "WhitePumpkinSlasher"
            }, 
            c00lkiddProjectile = {
                Title = "One Stone", 
                Description = "As c00lkidd, hit two or more Survivors with one projectile", 
                Icon = "rbxassetid://605704586", 
                LayoutOrder = 20
            }, 
            c00lkiddPizzaMinion = {
                Title = "You're Fired", 
                Description = "As c00lkidd, kill an Elliot with a Pizza Delivery minion", 
                Icon = "rbxassetid://12309378647", 
                LayoutOrder = 21
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
                Icon = "rbxassetid://139416176800383", 
                LayoutOrder = 31
            }, 
            ["1x1x1x1Hunt"] = {
                Title = "For the outcome is already decided.", 
                Description = "As 1x1x1x1, kill 50 Shedletskys", 
                Icon = "rbxassetid://102938044503624", 
                LayoutOrder = 41, 
                Requirement = 50, 
                RewardType = "Skin", 
                Skin = "Hacklord1x1x1x1"
            }, 
            NoliPranked = {
                Title = "I KNEW THAT DOOR HAD A LOCK ON IT!", 
                Description = "As Noli, trick a Sentinel into stunning your Mirage", 
                Icon = "rbxassetid://99887987886138", 
                LayoutOrder = 50
            }, 
            NoliCombo = {
                Title = "Happy Feet", 
                Description = "As Noli, hit 5 Survivors in a single Void Rush", 
                Icon = "rbxassetid://13265680111", 
                LayoutOrder = 51
            }, 
            NoliCar = {
                Title = "Tragic Accident", 
                Description = "As Noli, Void Rush into a charging Guest 1337 (or vice versa)", 
                Icon = "rbxassetid://8678130322", 
				LayoutOrder = 52
			},
			["NoliAdmin"] = {
				Title = "YOU DON'T GET TO JUDGE ME!",
				Description = "As Noli, Kill 33 Admins",
				Icon = "rbxassetid://95648741553709",
				LayoutOrder = 53,
				Requirement = 33,
				RewardType = "Skin",
				Skin = "AdminNoli"
	
		    },
			
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
            }, 
            TVTIME = {
                Title = "Coming straight from YOUR house.", 
                Description = "??? - I Love TV", 
                Icon = "rbxassetid://92069809063350", 
                LayoutOrder = 5, 
                Clientsided = true, 
                RewardType = "Emote", 
                Emote = "TVTime"
            }, 
            MeetDemophon = {
                Title = "A Captain and his Ship", 
                Description = "Hear his tale", 
                Icon = "rbxassetid://85427596392147", 
                LayoutOrder = 6, 
                Clientsided = true
            }, 
            Morality = {
                Title = "Black, White, and Gray.", 
                Description = "There is nothing either good or bad, but thinking makes it so...", 
                Icon = "rbxassetid://112592392235392", 
                LayoutOrder = 7, 
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
                Requirement = function() --[[ Line: 535 ]] --[[ Name: Requirement ]]
                    local v7 = 0;
                    for _, v9 in pairs({
                        game.ReplicatedStorage.Assets.Survivors, 
                        game.ReplicatedStorage.Assets.Killers
                    }) do
                        for _, v11 in pairs(v9:GetChildren()) do
                            local l_Config_0 = v11:FindFirstChild("Config");
                            if not (l_Config_0 and require(l_Config_0) or {
                                Exclusive = true
                            }).Exclusive then
                                v7 = v7 + 1;
                            end;
                        end;
                    end;
                    return v7;
                end, 
                RewardType = "Currency", 
                Amount = 1000
            }, 
            TrueSurvivalist = {
                Title = "True Survivalist", 
                Description = "Survive at least once on each map", 
                Icon = "rbxassetid://16720206732", 
                LayoutOrder = 3, 
                Requirement = function() --[[ Line: 584 ]] --[[ Name: Requirement ]]
                    if game["Run Service"]:IsServer() then
                        local v13 = 0;
                        for _, v15 in pairs(game.ServerStorage.Assets.Maps:GetChildren()) do
                            local l_Config_1 = v15:FindFirstChild("Config");
                            local v17 = l_Config_1 and require(l_Config_1) or {
                                Disabled = true
                            };
                            if not v17.Disabled and not v17.Exclusive then
                                v13 = v13 + 1;
                            end;
                        end;
                        workspace:SetAttribute("TotalPlayableMaps", v13);
                        return v13;
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
                Requirement = function() --[[ Line: 612 ]] --[[ Name: Requirement ]]
                    if game["Run Service"]:IsServer() then
                        local v18 = 0;
                        for _, v20 in pairs(game.ServerStorage.Assets.Maps:GetChildren()) do
                            local l_Config_2 = v20:FindFirstChild("Config");
                            local v22 = l_Config_2 and require(l_Config_2) or {
                                Disabled = true
                            };
                            if not v22.Disabled and not v22.Exclusive then
                                v18 = v18 + 1;
                            end;
                        end;
                        workspace:SetAttribute("TotalPlayableMaps", v18);
                        return v18;
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
                Requirement = 100, 
                RewardType = "Currency"
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
            }, 
            TaphMilestone = {
                Title = "WHAT THE- BOOOM!!", 
                Description = "Reach Lvl 100 on Taph", 
                Icon = "rbxassetid://122474630103474", 
                LayoutOrder = 10, 
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
            SlasherMilestone = {
                Title = "The Masked Brute", 
                Description = "Reach Lvl 100 on Slasher", 
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
            }, 
            NoliMilestone = {
                Title = "Time for some murder >:D", 
                Description = "Reach Lvl 100 on Noli", 
                Icon = "rbxassetid://92710828534583", 
                LayoutOrder = 5, 
                Requirement = 100
            }
        }
    }
};