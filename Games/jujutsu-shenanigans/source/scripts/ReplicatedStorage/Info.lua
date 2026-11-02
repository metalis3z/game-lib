-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local _ = nil;
local v1 = nil;
local v2 = {};
if not game.Players.LocalPlayer then
    v1 = game:GetService("DataStoreService"):GetDataStore("build_savesA");
end;
local skills = nil
local v3 = {
    [1] = Vector3.new(32.069000244140625, 20, 2.7269999980926514, 0), 
    [2] = Vector3.new(32.069000244140625, 5, 2.7269999980926514, 0), 
    [3] = Vector3.new(5, 5, 5, 0)
};
local function _(v4)
    local v5 = nil;
    if v4.CFrame then
        v5 = Instance.new("Attachment");
        v5.Parent = workspace.Terrain;
        v5.WorldCFrame = v4.CFrame;
        v4.CFrame = nil;
    end;
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.SoundGroup = game:GetService("SoundService").Sounds;
    l_Sound_0.Played:connect(function()
        l_Sound_0.Ended:connect(function()
            game:GetService("Debris"):AddItem(l_Sound_0, 0);
            game:GetService("Debris"):AddItem(v5, 0);
        end);
    end);
    if not v4.RollOffMaxDistance then
        v4.RollOffMaxDistance = 100;
    end;
    for v7, v8 in pairs(v4) do
        l_Sound_0[v7] = v8;
    end;
    if v5 then
        l_Sound_0.Parent = v5;
    end;
    return l_Sound_0;
end;
local _ = nil;
local v11 = nil;
v11 = {
    Badges = {
        [1] = 3.057416426456972E15, 
        [10] = 3.114670201603542E15, 
        [100] = 3.006399776257311E15, 
        [1000] = 268490457371003, 
        [10000] = 341084106898320, 
        [100000] = 2.724124286915993E15, 
        [1000000] = 1.257999597959356E15
    }, 
    KeyOffsets = {
        [1] = CFrame.new(6.67572021484375E-5, 2.384185791015625E-7, -3.6912670135498047, -0.965471088886261, -8.742277657347586E-8, 0.26051023602485657, 0.26051023602485657, -4.371138828673793E-8, 0.965471088886261, -7.301689919358978E-8, 1, 6.497661075854921E-8), 
        [2] = CFrame.new(6.67572021484375E-5, 1.2685961723327637, -3.01324462890625, 1, 0, 0, 0, -4.371138828673793E-8, 1, 0, -1, -4.371138828673793E-8), 
        [3] = CFrame.new(0.120067596, 0.759999752, -2.7800312, 1, 0, 0, 0, -4.37113883E-8, 1, 0, -1, -4.37113883E-8), 
        [4] = CFrame.new(6.67572021484375E-5, 0, -2.071981430053711, 1, 0, 0, 0, -4.371138828673793E-8, 1, 0, -1, -4.371138828673793E-8), 
        [5] = CFrame.new(6.67572021E-5, 0.271313667, -2.80003071, 1, 0, 0, 0, -4.37113883E-8, 1, 0, -1, -4.37113883E-8), 
        [6] = CFrame.new(6.67572021E-5, 0.589999676, -2.11003113, 0.979179561, -0.150505424, 0.136218935, -0.134637803, 0.0206945483, 0.990678728, -0.151921526, -0.988392532, -4.33039418E-8), 
        [7] = CFrame.new(6.67572021484375E-5, -0.3000001907348633, -3.000030517578125, 1, 0, 0, 0, -4.371138828673793E-8, 1, 0, -1, -4.371138828673793E-8), 
        [8] = CFrame.new(6.7572022999229375E-6, -1.5006359815597534, -2.6260547637939453, 1, 0, 0, 0, -4.371138828673793E-8, 1, 0, -1, -4.371138828673793E-8), 
        [9] = CFrame.new(6.67572021484375E-5, 0.09999966621398926, -2.9592037200927734, 1, 0, 0, 0, -4.371138828673793E-8, 1, 0, -1, -4.371138828673793E-8), 
        [10] = CFrame.new(6.67572021E-5, -0.839160442, -2.38934708, -1, -8.74227766E-8, 8.74227695E-8, 8.74227766E-8, -4.37113883E-8, 1, -8.74227695E-8, 1, 4.37113954E-8)
    }, 
    DonationProducts = {
		["1"] = 1934145815, -- 
		["10"] = 1934138104, --
		["100"] = 1934143259, -- 
		["1,000"] = 1934143529, --
		["10,000"] = 1934143859, -- 
		["100,000"] = 1934143984, -- 
		["1,000,000"] = 1934144406 --
    }, 
    GetSerial = function(v12)
        local v13 = Random.new():NextInteger(-10000000000, 10000000000);
        local v14 = math.floor(v12.Position.X) + math.floor(v12.Position.Y) + math.floor(v12.Position.Z);
        local v15 = math.random(-100, 100);
        local v16 = "";
        for _ = 1, Random.new():NextNumber(1, 5) do
            local v18 = string.char(math.random(97, 122));
            if math.random(1, 2) == 1 then
                v18 = v18:upper();
            end;
            v16 = v16 .. v18;
        end;
        local _ = nil;
        if math.random(1, 2) == 1 then
            return tostring(v13 + v14 + v15) .. v16;
        else
            return v16 .. tostring(v13 + v14 + v15);
        end;
    end, 
    ValidKeys = {
        Enum.KeyCode.Q, 
        Enum.KeyCode.B, 
        Enum.KeyCode.ButtonX, 
        Enum.KeyCode.ButtonY, 
        Enum.KeyCode.ButtonB, 
        Enum.KeyCode.ButtonA, 
        Enum.KeyCode.DPadUp, 
        Enum.KeyCode.Space, 
        Enum.KeyCode.W, 
        Enum.KeyCode.A, 
        Enum.KeyCode.S, 
        Enum.KeyCode.D, 
        Enum.KeyCode.F, 
        Enum.KeyCode.G, 
        Enum.KeyCode.V
    }, 
    ValidProperties = {
        "Text", 
        "TextSize", 
        "TextFont", 
        "TextColor", 
        "TextTransparency", 
        "TextOutline", 
        "EmitLight", 
        "Range", 
        "Brightness", 
        "Anchored", 
        "Collision", 
        "Deadly", 
        "Destructible", 
        "Fragile", 
        "Transparency", 
        "CurrentMoves", 
        "CurrentGears", 
        "Bouncy", 
        "Heals", 
        "ResetsCooldowns", 
        "GivesAwakening", 
        "Checkpoint", 
        "Shadow", 
        "NoAttack"
    }, 
    ValidClasses = {
        "SpawnLocation", 
        "Part"
    }, 
    Skillsets = {
        Bald = {
            Base = {
                "Normal Punch", 
                "Consecutive Punches", 
                "Shove", 
                "Uppercut"
            }, 
            Ultimate = {
                "Death Counter", 
                "Table Flip", 
                "Serious Punch", 
                "Omni Directional Serious Punch"
            }, 
            Indicator = {
                Sound = "rbxassetid://14405177812", 
                Volume = 1
            }, 
            Order = 1, 
            ID = 15114667107, 
            UltimateTime = nil, 
            UltimateName = "SERIOUS MODE", 
            Name = "The Strongest Hero", 
            Hero = true
        }, 
        Hunter = {
            Base = {
                "Flowing Water", 
                "Lethal Whirlwind Stream", 
                "Hunter's Grasp", 
                "Prey's Peril"
            }, 
            Ultimate = {
                "Water Stream Rock Smashing Fist", 
                "The Final Hunt", 
                "Rock Splitting Fist", 
                "Crushed Rock"
            }, 
            Indicator = {
                Sound = "rbxassetid://14405177437", 
                Volume = 0.75
            }, 
            Order = 2, 
            ID = 15124465439, 
            UltimateTime = 42.5, 
            UltimateName = "RAMPAGE", 
            Name = "Hero Hunter", 
            Hero = false
        }, 
        Purple = {
            Base = {
                "Bullet Barrage", 
                "Vanishing Kick", 
                "Whirlwind Drop", 
				"Head First",
				"Earth Splitting Strike"
            }, 
            Ultimate = {
                "Rising Fist", 
                "Twin Fangs", 
                "Earth Splitting Strike"
            }, 
            Indicator = {
                Sound = "rbxassetid://18435612327", 
                Volume = 0.75
            }, 
            Order = 8, 
            ID = 18434673438, 
            UltimateTime = 42.5, 
            UltimateName = "DRAGON 'S DESCENT", 
            Name = "Martial Artist", 
            Hero = true
        }, 
        Cyborg = {
            Base = {
                "Machine Gun Blows", 
                "Ignition Burst", 
                "Blitz Shot", 
                "Jet Dive"
            }, 
            Ultimate = {
                "Thunder Kick", 
                "Speedblitz Dropkick", 
                "Flamewave Cannon", 
                "Incinerate"
            }, 
            Indicator = {
                Sound = "rbxassetid://14405177937", 
                Volume = 0.75
            }, 
            Order = 3, 
            ID = 15143528856, 
            UltimateTime = 43, 
            UltimateName = "MAXIMUM ENERGY OUTPUT", 
            Name = "Destructive Cyborg", 
            Hero = true
        }, 
        Ninja = {
            Base = {
                "Flash Strike", 
                "Whirlwind Kick", 
                "Scatter", 
                "Explosive Shuriken"
            }, 
            Ultimate = {
                "Twinblade Rush", 
                "Straight On", 
                "Carnage", 
                "Fourfold Flashstrike"
            }, 
            Indicator = {
                Sound = "rbxassetid://14405177701", 
                Volume = 0.75
            }, 
            Order = 4, 
            ID = 15114672498, 
            UltimateTime = 43, 
            UltimateName = "CAN YOU EVEN SEE ME?", 
            Name = "Deadly Ninja", 
            Hero = false
        }, 
        Batter = {
            Base = {
                "Homerun", 
                "Beatdown", 
                "Grand Slam", 
                "Foul Ball"
            }, 
            Ultimate = {
                "Savage Tornado", 
                "Brutal Beatdown", 
                "Strength Difference", 
                "Death Blow"
            }, 
            Order = 5, 
            Indicator = {
                Sound = "rbxassetid://14405177575", 
                Volume = 1
            }, 
			ID = 15143529209, 
            UltimateTime = 43, 
            UltimateName = "PUMPED UP", 
            Name = "Brutal Demon", 
            Hero = true
        }, 
        Blade = {
            Base = {
                "Quick Slice", 
                "Atmos Cleave", 
                "Pinpoint Cut", 
				"Split Second Counter",
				--"Atomic Slash"
				-- for test
            }, 
            Ultimate = {
                "Sunset", 
                "Solar Cleave", 
                "Sunrise", 
                "Atomic Slash"
            }, 
            Indicator = {
                Sound = "rbxassetid://15398355537", 
                Volume = 1
            }, 
            Order = 6, 
            ID = 15143528539, 
            UltimateTime = 43, 
            UltimateName = "SCORCHING BLADE", 
            Name = "Blade Master", 
            Hero = true
        }, 
        Esper = {
            Base = {
                "Crushing Pull", 
                "Windstorm Fury", 
                "Stone Coffin", 
                "Expulsive Push"
            }, 
            Ultimate = {
                "Cosmic Strike", 
                "Psychic Ricochet", 
                "Terrible Tornado", 
                "Sky Snatcher"
            }, 
            Indicator = {
                Sound = "rbxassetid://16136683894", 
                Volume = 1
            }, 
            Order = 7, 
            ID = 16136325038, 
            UltimateTime = 43, 
            UltimateName = "BERSERK", 
            Name = "Wild Psychic", 
            Hero = true
        }, 
        ["Crab Boss"] = {
            Base = {}, 
            Ultimate = {}, 
            Order = 11, 
            ID = 18906334004, 
            Name = "Crab Boss", 
            UltimateName = "krab", 
            Hero = true
        }, 
        Sorcerer = {
            Base = {
                "Infinity", 
                "Repulse", 
                "Erase", 
                "Attract"
            }, 
            Ultimate = {}, 
            Order = 10, 
            ID = 15143528348, 
            Name = "Sorcerer", 
			UltimateName = "SORCERER", 
            Hero = true
        }, 
        KJ = {
            Base = {
                "Ravage", 
                "Swift Sweep", 
				"Collateral Ruin",
				"20-20-20 Dropkick"
            }, 
            Ultimate = {
                "Stoic Bomb", 
                "20-20-20 Dropkick", 
                "Five Seasons"
            }, 
            Order = 9, 
            ID = 17140853847, 
            Name = "KJ", 
            UltimateName = "20 SERIES", 
            Hero = true
		},
		Shark = {
			Base = {
				"Normal Punch", 
				"Consecutive Punches", 
				"Shove", 
				"Uppercut"
			}, 
			Ultimate = {
				"Death Counter", 
				"Table Flip", 
				"Serious Punch", 
				"Omni Directional Punch"
			}, 
			Indicator = {
				Sound = "rbxassetid://14405177812", 
				Volume = 1
			}, 
			Order = 1, 
			ID = 15114667107, 
			UltimateTime = nil, 
			UltimateName = "SERIOUS MODE", 
			Name = "The Strongest Shark", 
			Hero = true
		}, 
	  Testing = {
			Base = {
				"First Key",
				"Second Key",
				"Third Key",
				"Fourth Key",
				"Fifth Key",
				"Sixth Key",
				"Seventh Key",
				"Eighth Key",
				"Ninth Key",
				"Tenth Key",
			}, 
			Ultimate = {
			
			}, 
			Indicator = {
				Sound = "rbxassetid://14405177812", 
				Volume = 1
			}, 
			Order = 9, 
			ID = 15143528348, 
			UltimateTime = nil, 
			UltimateName = "Last Key", 
			Name = "The Hunt Anim", 
			Hero = true
	  }
    }, 
    BaseM1 = {
        Fist = {
            114341809076886, 
            138549294464038, 
            85580535733827, 
            87514143815333
        }, 
        Bat = {
            127912271410001, 
            78619377222043, 
            77353416662082, 
            125994488376043
        }, 
        Ninjato = {
            78718436871684, 
            130149047318140, 
            80121592235306, 
            119105508225355
        }, 
        Katana = {
            116691587567563, 
            120993020417859, 
            138922418354696, 
            129856577557356
		}, 
		Shark = {
			116691587567563, 
			120993020417859, 
			138922418354696, 
			129856577557356
		},
        HunterFist = {
            101594216807600, 
            112316029299477, 
            99560469568617, 
            127890122041400
        }, 
        CyborgFist = {
            79174903448799, 
            88917645074594, 
            88859448393966, 
            119159813190558
        }, 
        EsperFist = {
            98605157142905, 
            71261617813331, 
            110080413529187, 
            89731489453056
        }, 
        KJFist = {
            84892226574440, 
            71242465037590, 
            131761061229988, 
            98380317321386
        }, 
        PurpleFist = {
            114697194520183, 
            97879032364522, 
            111002197380099, 
            113885807156357
        }, 
        Uppercut = {
            83659659250072, 
            82052615769423
        }, 
        Downslam = {
            100244983121580
        }
    }, 
    Admins = {
		2903824540, 
		2379446617, 
		5566701102,
		
    }, 
    Intros = {
        Ninja = {
			id = 133041292503129, 
            sound = {
                "rbxassetid://15956555583", 
                1
            }
        }, 
        Purple = {
			id = 112776403497925, 
            sound = {
                "rbxassetid://18435468901", 
                1
            }
        }, 
        KJ = {
			id = 85286806195861, 
            sound = {
                "rbxassetid://17325174223", 
                1
            }
        }, 
        Batter = {
			id = 88382060193129, 
            sound = {
                "rbxassetid://15956568211", 
                1
            }
		}, 
		Shark = {
			id = 88382060193129, 
			sound = {
				"rbxassetid://15956568211", 
				1
			}
		},
        Hunter = {
			id = 123927773338871, 
            sound = {
                "rbxassetid://15956575080", 
                0.75
            }
        }, 
        Cyborg = {
			id = 73919989601209, 
            sound = {
                "rbxassetid://15958081297", 
                2
            }
        }, 
        Bald = {
			id = 76196782701576, 
            sound = {
                "rbxassetid://15956666275", 
                3
            }
        }, 
        Blade = {
			id = 107033826762071, 
            sound = {
                "rbxassetid://15983408349", 
                1
            }
        }, 
        Esper = {
			id = 119763225223822, 
            sound = {
                "rbxassetid://16136569377", 
                2
            }
		},
		Sorcerer = {
			id = 136176730973605, 
			sound = {
				"rbxassetid://0", 
				2
			}
		},
		Testing= {
			id = 136176730973605, 
			sound = {
				"rbxassetid://0", 
				2
			}
		}
    }, 
    Special = {
        [138249029] = "CursedArmParticle", 
        [747447782] = "SpecOutline", 
        [994994173] = "CursedArmParticle", 
        [1001242712] = "SpecOutline"
    }, 
    Cosmetics = {
        {
            "Special Stuff", 
            10000000000, 
            "rbxassetid://17140774329", 
            "aura"
        }, 
        {
            "Custom Cape", 
            2000000000, 
            "rbxassetid://17140755709", 
            "cosmetic"
        }, 
        {
            "Guild Cape", 
            1000000, 
            "rbxassetid://17139038442", 
            "cosmetic"
        }, 
        {
            "Shadow Aura", 
            20000, 
            "rbxassetid://17855955602", 
            "aura"
        }, 
        {
            "Burning Aura", 
            10000, 
            "rbxassetid://17855957730", 
            "aura"
        }, 
        {
            "Graceful Aura", 
            9000, 
            "rbxassetid://17855866639", 
            "aura"
        }, 
        {
            "Stench Aura", 
            5900, 
            "rbxassetid://17855866449", 
            "aura"
        }, 
        {
            "Slinky", 
            20000, 
            "rbxassetid://18183755570", 
            "cosmetic"
        }, 
        {
            "Desert Cape", 
            10500, 
            "rbxassetid://18182263066", 
            "cosmetic"
        }, 
        {
            "Divine Wheel", 
            10000, 
            "rbxassetid://17824308335", 
            "cosmetic"
        }, 
        {
            "Spiky Cape", 
            9500, 
            "rbxassetid://18182263573", 
            "cosmetic"
        }, 
        {
            "Fur Cape", 
            9000, 
            "rbxassetid://18182263767", 
            "cosmetic"
        }, 
        {
            "Blood Scarf", 
            8500, 
            "rbxassetid://18182262939", 
            "cosmetic"
        }, 
        {
            "Torn Headband", 
            8000, 
            "rbxassetid://18182263365", 
            "cosmetic"
        }, 
        {
            "Headband", 
            7500, 
            "rbxassetid://18182263961", 
            "cosmetic"
        }, 
        {
            "Bandage Wrap", 
            7000, 
            "rbxassetid://17824222445", 
            "cosmetic"
        }, 
        {
            "Waist Sash", 
            6600, 
            "rbxassetid://17838057309", 
            "cosmetic"
        }, 
        {
            "Leg Iron", 
            6200, 
            "rbxassetid://17846070680", 
            "cosmetic"
        }, 
        {
            "White Scarf", 
            900, 
            "rbxassetid://17856005701", 
            "cosmetic"
        }, 
        {
            "Ki Aura", 
            4000, 
            "rbxassetid://17140585525", 
            "aura", 
            true
        }, 
        {
            "Dark Aura", 
            5600, 
            "rbxassetid://17140578572", 
            "aura", 
            true
        }, 
        {
            "Lightning Aura", 
            4600, 
            "rbxassetid://17140620713", 
            "aura", 
            true
        }, 
        {
            "Worn Cape", 
            5200, 
            "rbxassetid://17139121832", 
            "cosmetic", 
            true
        }, 
        {
            "Tattered Cape", 
            4300, 
            "rbxassetid://17138954104", 
            "cosmetic", 
            true
        }, 
        {
            "Torn Cape", 
            3600, 
            "rbxassetid://17138960792", 
            "cosmetic", 
            true
        }, 
        {
            "White Cape", 
            3200, 
            "rbxassetid://17138990307", 
            "cosmetic", 
            true
        }, 
        {
            "Conqueror Cape", 
            2800, 
            "rbxassetid://17138970538", 
            "cosmetic", 
            true
        }, 
        {
            "Jagged Cape", 
            2000, 
            "rbxassetid://17139003111", 
            "cosmetic", 
            true
        }, 
        {
            "Royal Cape", 
            1200, 
            "rbxassetid://17139029983", 
            "cosmetic", 
            true
        }, 
        {
            "Purple Scarf", 
            600, 
            "rbxassetid://17139021808", 
            "cosmetic", 
            true
        }, 
        {
            "Bandages", 
            300, 
            "rbxassetid://17139537917", 
            "cosmetic", 
            true
        }, 
        {
            "Long Sash", 
            150, 
            "rbxassetid://17139017721", 
            "cosmetic", 
            true
        }, 
        {
            "Short Sash", 
            75, 
            "rbxassetid://17139012868", 
            "cosmetic", 
            true
        }, 
        {
            "Red Gloves", 
            25, 
            "rbxassetid://17138543887", 
            "cosmetic", 
            true
        }, 
        {
            "Blocky Body", 
            -1, 
            "rbxassetid://17140578733", 
            "cosmetic"
        }
    }, 
    GiftableGamepasses = {
        [128278127] = {
            1615573088, 
            1
        }, 
        [229966673] = {
            1615575224, 
            2
        }, 
        [136459121] = {
            1615574560, 
            3
        }, 
        [267162259] = {
            1661543978, 
            4
        }, 
        [267169928] = {
            1661547676, 
            5
        }, 
        [793925178] = {
            1816898588, 
            6
        }, 
        [810906533] = {
            1827272891, 
            7
        }, 
        [1556594193] = {
            1669040587, 
            8, 
            true
        }
    }, 
    VIPServerButtons = {
        "Command Target", 
        "Respawn", 
        "Bring", 
        "Heal", 
        "Spawn Dummy", 
        "Spawn Attacking Dummy", 
        "Spawn Blocking Dummy", 
        "Spawn Outsider", 
        "Clear Entities", 
        "Build Mode", 
        "Start Round", 
        "End Round", 
        "Round Teams", 
        "Round Type", 
        "Give Awakening", 
        "Remove Awakening", 
        "Activate Awakening", 
        "Gravity Multiplier", 
        "Damage Multiplier", 
        "Health Multiplier", 
        "Regen Multiplier", 
        "Speed Multiplier", 
        "Storm Speed Multiplier", 
        "Storm Damage Multiplier", 
        "Reset Storm", 
        "Remove Leaderboards", 
        "Shutdown Server", 
        "Refresh Server"
    }, 
    Order = {
        "-- PRIVATE SERVER+ --", 
        "Command Targets", 
        "Effects Apply To", 
        "Menu Size", 
        "-- GENERAL --", 
        "Godmode", 
        "Heal", 
        "Respawn", 
        "Bring", 
        "-- DUMMIES --", 
        "Spawn Attacking Dummy", 
        "Spawn Blocking Dummy", 
        "Spawn Dummy", 
        "Spawn Outsider", 
        "Clear Entities", 
        "-- TOGGLES --", 
        "Teleport Dash", 
        "No Respawn", 
        "No Dash Cooldown", 
        "No Movement", 
        "No Cooldown", 
        "No Ragdoll", 
        "No Fatigue", 
        "No Attack", 
        "No Stun", 
        "No Block", 
        "No Reset", 
        "-- AWAKENING --", 
        "Give Awakening", 
        "Remove Awakening", 
        "Activate Awakening", 
        "Infinite Awakening", 
        "Instant Awakening", 
        "No Awakening", 
        "-- MULTIPLIERS --", 
        "Attack Speed Multiplier", 
        "Health Multiplier", 
        "Damage Multiplier", 
        "Regen Multiplier", 
        "Speed Multiplier", 
        "Gravity Multiplier", 
        "-- MOVESET --", 
        "Random Moveset", 
        "Dual Moveset", 
        "Finishers Only", 
        "-- MAP --", 
        "Build Mode", 
        "Hide Map", 
        "-- GAMEMODE --", 
        "Round Type", 
        "Round Teams", 
        "Start Round", 
        "End Round", 
        "-- MISC --", 
        "Storm Active", 
        "Reset Storm", 
        "Storm Speed Multiplier", 
        "Storm Damage Multiplier", 
        "-- SERVER --", 
        "Lock Server", 
        "Kick On Death", 
        "Shutdown Server", 
        "Refresh Server"
    }, 
    VIPServerPowers = {
        ["Build Mode"] = function(_, v21)
            local l_CollectionService_0 = game:GetService("CollectionService");
            local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v21);
            if not v21:FindFirstChild("buildingg") then
                local l_ForceField_0 = Instance.new("ForceField");
                l_ForceField_0.Name = "VisibleFFfluy";
                l_ForceField_0.Visible = false;
                l_CollectionService_0:AddTag(l_ForceField_0, "VisibleFF" .. l_PlayerFromCharacter_0.Name);
                l_ForceField_0.Parent = l_PlayerFromCharacter_0.Character;
                local l_Folder_0 = Instance.new("Folder");
                l_Folder_0.Name = "buildingg";
                l_Folder_0.Parent = l_PlayerFromCharacter_0.Character;
                l_CollectionService_0:AddTag(l_Folder_0, "VisibleFF" .. l_PlayerFromCharacter_0.Name);
                local l_Highlight_0 = Instance.new("Highlight");
                l_Highlight_0.Name = "flyhighlight";
                l_Highlight_0.FillColor = Color3.fromRGB(1, 175, 255);
                l_Highlight_0.FillTransparency = 0.8;
                l_Highlight_0.OutlineTransparency = 1;
                l_CollectionService_0:AddTag(l_Highlight_0, "VisibleFF" .. l_PlayerFromCharacter_0.Name);
                l_Highlight_0.Parent = l_PlayerFromCharacter_0.Character;
                l_PlayerFromCharacter_0:SetAttribute("oppedbefore", true);
                game.ReplicatedStorage.Replication:FireClient(l_PlayerFromCharacter_0, {
                    Effect = "Fly Start", 
                    build = true
                });
                return ;
            else
                for _, v28 in pairs(l_CollectionService_0:GetTagged("VisibleFF" .. l_PlayerFromCharacter_0.Name)) do
                    v28:Destroy();
                end;
                game.ReplicatedStorage.Replication:FireClient(l_PlayerFromCharacter_0, {
                    Effect = "Fly End", 
                    buildend = true
                });
                return ;
            end;
        end, 
        ["Start Round"] = function(_)
            workspace:SetAttribute("RoundOngoing", true);
        end, 
        ["End Round"] = function(_)
            workspace:SetAttribute("RoundOngoing", false);
        end, 
        ["Storm Speed Multiplier"] = function(v31)
            workspace:SetAttribute("StormSpeedMultiplier", v31);
        end, 
        ["Reset Storm"] = function(_)
            shared.stormreset();
        end, 
        ["Storm Damage Multiplier"] = function(v33)
            workspace:SetAttribute("StormDamageMultiplier", v33);
        end, 
        ["Storm Active"] = function(v34)
            workspace:SetAttribute("StormActive", v34);
        end, 
        ["Refresh Server"] = function(_, _)
            local v37 = game:GetService("TeleportService"):ReserveServer(game.PlaceId);
            game:GetService("TeleportService"):TeleportToPrivateServer(game.PlaceId, v37, game:GetService("Players"):GetPlayers(), nil, {
                "newps " .. os.time() .. " " .. workspace:GetAttribute("VIPServer")
            });
        end, 
        ["Hide Map"] = function(v38, _)
            workspace:SetAttribute("HideMap", v38);
            local l_Map_0 = workspace:FindFirstChild("Map");
            if #l_Map_0:GetChildren() == 0 then
                game:GetService("Debris"):AddItem(l_Map_0, 0);
                game.Lighting.Map.Parent = workspace;
                return ;
            else
                l_Map_0.Parent = game.Lighting;
                local l_Folder_1 = Instance.new("Folder");
                l_Folder_1.Name = "Map";
                l_Folder_1.Parent = workspace;
                return ;
            end;
        end, 
        ["Give Awakening"] = function(_, v43)
            local l_workspace_Attribute_0 = workspace:GetAttribute("CommandTarget");
            local l_Players_0 = game.Players:GetPlayers();
            if l_workspace_Attribute_0 == 2 then
                table.remove(l_Players_0, table.find(l_Players_0, game.Players:GetPlayerFromCharacter(v43)));
            elseif l_workspace_Attribute_0 == 3 then
                l_Players_0 = {
                    game.Players:GetPlayerFromCharacter(v43)
                };
            end;
            for _, v47 in pairs(l_Players_0) do
                v47:SetAttribute("Ultimate", 100);
            end;
        end, 
        Heal = function(_, v49)
            local l_workspace_Attribute_1 = workspace:GetAttribute("CommandTarget");
            local l_Children_0 = workspace.Live:GetChildren();
            if l_workspace_Attribute_1 == 2 then
                table.remove(l_Children_0, table.find(l_Children_0, v49));
            elseif l_workspace_Attribute_1 == 3 then
                l_Children_0 = {
                    v49
                };
            end;
            for _, v53 in pairs(l_Children_0) do
                local l_Humanoid_0 = v53:FindFirstChildOfClass("Humanoid");
                if l_Humanoid_0 then
                    l_Humanoid_0.Health = 2000000000;
                end;
            end;
        end, 
        ["Remove Awakening"] = function(_, v56)
            local l_workspace_Attribute_2 = workspace:GetAttribute("CommandTarget");
            local l_Players_1 = game.Players:GetPlayers();
            if l_workspace_Attribute_2 == 2 then
                table.remove(l_Players_1, table.find(l_Players_1, game.Players:GetPlayerFromCharacter(v56)));
            elseif l_workspace_Attribute_2 == 3 then
                l_Players_1 = {
                    game.Players:GetPlayerFromCharacter(v56)
                };
            end;
            for _, v60 in pairs(l_Players_1) do
                v60:SetAttribute("Ultimate", 0);
            end;
        end, 
        ["Activate Awakening"] = function(_, v62)
            local l_workspace_Attribute_3 = workspace:GetAttribute("CommandTarget");
            local l_Players_2 = game.Players:GetPlayers();
            if l_workspace_Attribute_3 == 2 then
                table.remove(l_Players_2, table.find(l_Players_2, game.Players:GetPlayerFromCharacter(v62)));
            elseif l_workspace_Attribute_3 == 3 then
                l_Players_2 = {
                    game.Players:GetPlayerFromCharacter(v62)
                };
            end;
            for _, v66 in pairs(l_Players_2) do
				if v66.Character and v66.Character:FindFirstChild('Communicate') then
					local Communicate : RemoteEvent = v66.Character:FindFirstChild('Communicate')
					Communicate:FireClient(v66,{
						Goal = 'ActivatedUltNow'
					})
                end;
            end;
        end, 
        Respawn = function(_, v68)
            if tick() - (game:GetAttribute("RACD") or 0) < 0.5 then
                return ;
            else
                game:SetAttribute("RACD", tick());
                local l_workspace_Attribute_4 = workspace:GetAttribute("CommandTarget");
                local l_Players_3 = game.Players:GetPlayers();
                if l_workspace_Attribute_4 == 2 then
                    table.remove(l_Players_3, table.find(l_Players_3, game.Players:GetPlayerFromCharacter(v68)));
                elseif l_workspace_Attribute_4 == 3 then
                    l_Players_3 = {
                        game.Players:GetPlayerFromCharacter(v68)
                    };
                end;
                for _, v72 in pairs(l_Players_3) do
                    v72:LoadCharacter();
                end;
                return ;
            end;
        end, 
        Bring = function(_, v74)
            local l_workspace_Attribute_5 = workspace:GetAttribute("CommandTarget");
            local l_Children_1 = workspace.Live:GetChildren();
            if l_workspace_Attribute_5 == 2 then
                table.remove(l_Children_1, table.find(l_Children_1, v74));
            elseif l_workspace_Attribute_5 == 3 then
                l_Children_1 = {
                    v74
                };
            end;
            for _, v78 in pairs(l_Children_1) do
                if v78.PrimaryPart and v78:FindFirstChildOfClass("Humanoid") then
                    v78:SetPrimaryPartCFrame(v74.PrimaryPart.CFrame);
                end;
            end;
        end, 
        ["Shutdown Server"] = function(_, _)
            for _, v82 in pairs(game.Players:players()) do
                v82:Kick("server shut down by the private server owner");
            end;
        end, 
        ["Teleport Dash"] = function(v83)
            workspace:SetAttribute("TeleportDash", v83);
        end, 
        ["Random Moveset"] = function(v84)
            workspace:SetAttribute("RandomMoveset", v84);
        end, 
        ["Dual Moveset"] = function(v85)
            workspace:SetAttribute("DualMoveset", v85);
        end, 
        ["Kick On Death"] = function(v86)
            workspace:SetAttribute("KickOnDeath", v86);
        end, 
        ["Attack Speed Multiplier"] = function(v87)
            workspace:SetAttribute("AttackSpeedMultiplier", v87);
        end, 
        ["Gravity Multiplier"] = function(v88)
            workspace.Gravity = 196.1999969482422 * v88;
        end, 
        ["Health Multiplier"] = function(v89)
            workspace:SetAttribute("HealthMultiplier", v89);
        end, 
        ["Damage Multiplier"] = function(v90)
            workspace:SetAttribute("DamageMultiplier", v90);
        end, 
        ["Regen Multiplier"] = function(v91)
            workspace:SetAttribute("RegenMultiplier", v91);
        end, 
        ["Speed Multiplier"] = function(v92)
            workspace:SetAttribute("SpeedMultiplier", v92);
        end, 
        ["Infinite Awakening"] = function(v93)
            workspace:SetAttribute("InfiniteAwakening", v93);
        end, 
        ["Finishers Only"] = function(v94)
            workspace:SetAttribute("FinishersOnly", v94);
            for _, v96 in pairs(workspace.Live:GetChildren()) do
                local l_Humanoid_1 = v96:FindFirstChildOfClass("Humanoid");
                if l_Humanoid_1 then
                    l_Humanoid_1.MaxHealth = v94 and 7 or 100;
                    l_Humanoid_1.Health = l_Humanoid_1.MaxHealth;
                end;
            end;
        end, 
        ["Instant Awakening"] = function(v98)
            workspace:SetAttribute("InstantAwakening", v98);
        end, 
        ["No Dash Cooldown"] = function(v99)
            workspace:SetAttribute("NoDashCooldown", v99);
        end, 
        ["No Movement"] = function(v100)
            workspace:SetAttribute("NoMovement", v100);
            for _, v102 in pairs(workspace.Live:GetChildren()) do
                if v102:FindFirstChildOfClass("Humanoid") then
                    shared.cfolder({
                        Name = "Freeze", 
                        Parent = v102
                    }, 0.5);
                end;
                v102:SetAttribute("_upd", math.random(1, 2000000000));
            end;
        end, 
        ["No Respawn"] = function(v103)
            workspace:SetAttribute("NoRespawn", v103);
            game.Players.CharacterAutoLoads = not v103;
        end, 
		["No Cooldown"] = function(v104)
            workspace:SetAttribute("NoCooldown", v104);
            for _, v106 in pairs(game.Players:GetPlayers()) do
                if not skills then
					skills = require(game.ServerScriptService.skills);
				end;
				
				skills.ResetCooldowns({char = v106.Character})
					
            end;
        end, 
        ["No Fatigue"] = function(v107)
            workspace:SetAttribute("NoFatigue", v107);
        end, 
        ["No Awakening"] = function(v108)
            workspace:SetAttribute("NoAwakening", v108);
        end, 
        ["No Ragdoll"] = function(v109)
            workspace:SetAttribute("NoRagdoll", v109);
        end, 
        ["No Attack"] = function(v110)
            workspace:SetAttribute("NoAttack", v110);
        end, 
        ["No Reset"] = function(v111)
            workspace:SetAttribute("NoReset", v111);
        end, 
        ["No Stun"] = function(v112)
            workspace:SetAttribute("NoStun", v112);
        end, 
        ["No Block"] = function(v113)
            workspace:SetAttribute("NoBlock", v113);
            if v113 then
                task.wait();
                for _, v115 in pairs(workspace.Live:GetChildren()) do
                    shared.cfolder({
                        Name = "a", 
                        Parent = v115
                    }, 0.2);
                end;
            end;
        end, 
        ["Lock Server"] = function(v116)
            workspace:SetAttribute("LockServer", v116);
        end, 
        Godmode = function(v117, v118)
            local l_CollectionService_1 = game:GetService("CollectionService");
            if v117 then
                local l_ForceField_1 = Instance.new("ForceField");
                l_ForceField_1.Visible = false;
                l_ForceField_1.Name = "AbsoluteImmortal";
                l_CollectionService_1:AddTag(l_ForceField_1, "godmodeff" .. v118.Name);
                l_ForceField_1.Parent = v118;
            else
                for _, v122 in pairs(l_CollectionService_1:GetTagged("godmodeff" .. v118.Name)) do
                    v122:Destroy();
                end;
            end;
            workspace:SetAttribute("Godmode", v117);
        end, 
        ["Spawn Attacking Dummy"] = function(_, v124)
            local v125 = shared.DummyClone()
            v125:SetAttribute("DontClone", true);
            local v126 = script.Attack:Clone();
            v126.Parent = v125;
            v125.Parent = workspace.Live;
            v125:SetPrimaryPartCFrame(v124.PrimaryPart.CFrame);
            v126.Enabled = true;
        end, 
        ["Spawn Blocking Dummy"] = function(_, v128)
            local v129 = shared.DummyClone()
            v129:SetAttribute("DontClone", true);
            local v130 = script.Blocking:Clone();
            v130.Parent = v129;
            v129.Parent = workspace.Live;
            v129:SetPrimaryPartCFrame(v128.PrimaryPart.CFrame);
            v130.Enabled = true;
        end, 
        ["Spawn Dummy"] = function(_, v132)
            local v133 = shared.DummyClone()
            v133.Parent = workspace.Live;
            v133:SetPrimaryPartCFrame(v132.PrimaryPart.CFrame);
        end, 
        ["Spawn Outsider"] = function(_, _)
            local v136 = {
                Vector3.new(156.67799377441406, 440.7560119628906, 24.687000274658203, 0), 
                Vector3.new(400.239990234375, 440.5060119628906, 155.09300231933594, 0), 
                Vector3.new(169.39700317382812, 440.5060119628906, 283.1510009765625, 0), 
                Vector3.new(-62.4739990234375, 440.5060119628906, 195.781005859375, 0), 
                Vector3.new(-107.58899688720703, 440.5060119628906, -91.59100341796875, 0), 
                (Vector3.new(181.21800231933594, 440.5060119628906, -169.90899658203125, 0))
            };
            shared.SpawnOutsider(v136[math.random(#v136)]);
        end, 
        ["Clear Entities"] = function(_, _)
            local _ = {};
            for _, v141 in pairs(workspace.Live:GetChildren()) do
                if not (v141.Name ~= "Weakest Dummy") or v141:GetAttribute("OmniImmunity") then
                    v141:Destroy();
                end;
            end;
        end
    }, 
    spawnables = {
        Trashcan = {
            function(_, v143, v144)
                local v145 = shared.trashcan:Clone();
                v145:SetAttribute("Name", "Trashcan");
                v145.PrimaryPart = v145.Trashcan;
                v145.Parent = workspace.Map.Trash;
                game:GetService("CollectionService"):AddTag(v145, "ps_spawned");
                table.insert(v2, v145);
                v145.Trashcan.CFrame = v144 or v143.PrimaryPart.CFrame * CFrame.new(0, -0.925, 0);
                game:GetService("CollectionService"):AddTag(v145.Trashcan, "Interactable");
                shared.interactables.FilterDescendantsInstances = game:GetService("CollectionService"):GetTagged("Interactable");
            end, 
            5
        }, 
        Brick = {
            function(_, v147, v148, v149)
                if not v149 then
                    v149 = v3[workspace:GetAttribute("SpawnShape") or 1];
                    v149 = {
                        v149.X, 
                        v149.Y, 
                        v149.Z
                    };
                end;
                local v150 = script.Block:Clone();
                v150:SetAttribute("Name", "Brick");
                v150.Size = Vector3.new(unpack(v149));
                v150.Parent = workspace;
                table.insert(v2, v150);
                game:GetService("CollectionService"):AddTag(v150, "ps_spawned");
                v150.CFrame = v148 or v147.PrimaryPart.CFrame * CFrame.new(0, v150.Size.Y / 2 - 3, -10);
            end, 
            1
        }, 
        ["Fragile Brick"] = {
            function(_, v152, v153, v154)
                if not v154 then
                    v154 = v3[workspace:GetAttribute("SpawnShape") or 1];
                    v154 = {
                        v154.X, 
                        v154.Y, 
                        v154.Z
                    };
                end;
                local v155 = script.Block:Clone();
                game:GetService("CollectionService"):AddTag(v155, "fragilebrick");
                game:GetService("CollectionService"):AddTag(v155, "ps_spawned");
                v155:SetAttribute("Name", "Fragile Brick");
                v155.Size = Vector3.new(unpack(v154));
                v155.Parent = workspace;
                table.insert(v2, v155);
                v155.CFrame = v153 or v152.PrimaryPart.CFrame * CFrame.new(0, v155.Size.Y / 2 - 3, -10);
            end, 
            2
        }, 
        Steel = {
            function(_, v157, v158, v159)
                if not v159 then
                    v159 = v3[workspace:GetAttribute("SpawnShape") or 1];
                    v159 = {
                        v159.X, 
                        v159.Y, 
                        v159.Z
                    };
                end;
                local v160 = script.Block:Clone();
                v160.Material = Enum.Material.DiamondPlate;
                v160:SetAttribute("Breakable", false);
                v160.Color = Color3.fromRGB(112, 107, 111);
                v160:SetAttribute("Name", "Steel");
                v160.Size = Vector3.new(unpack(v159));
                v160.Parent = workspace;
                table.insert(v2, v160);
                game:GetService("CollectionService"):AddTag(v160, "ps_spawned");
                v160.CFrame = v158 or v157.PrimaryPart.CFrame * CFrame.new(0, v160.Size.Y / 2 - 3, -10);
            end, 
            3
        }, 
        ["Kill Block"] = {
            function(_, v162, v163, v164)
                if not v164 then
                    v164 = v3[workspace:GetAttribute("SpawnShape") or 1];
                    v164 = {
                        v164.X, 
                        v164.Y, 
                        v164.Z
                    };
                end;
                local v165 = script.Block:Clone();
                v165:SetAttribute("Breakable", false);
                v165:SetAttribute("Name", "Kill Block");
                v165.Material = Enum.Material.SmoothPlastic;
                v165.Size = Vector3.new(unpack(v164));
                v165.Transparency = 0.5;
                v165.BrickColor = BrickColor.new("Really red");
                v165.CanCollide = false;
                v165.Parent = workspace;
                table.insert(v2, v165);
                game:GetService("CollectionService"):AddTag(v165, "ps_spawned");
                game:GetService("CollectionService"):AddTag(v165, "killbrick");
                v165.CFrame = v163 or v162.PrimaryPart.CFrame * CFrame.new(0, v165.Size.Y / 2 - 3, -10);
            end, 
            4
        }
    }
};
for _, v167 in pairs(v11.Order) do
    if string.sub(v167, 0, 3) == "-- " then
        v11.VIPServerPowers[v167] = function()

        end;
        table.insert(v11.VIPServerButtons, v167);
    end;
end;
table.sort(v11.Cosmetics, function(v168, v169)
    return v169[2] < v168[2];
end);
return v11;