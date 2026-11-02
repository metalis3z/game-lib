

local u1 = {
	["SECURITY"] = {
		["MAX_SPEED_ALLOWED"] = 150,
		["DISTANCE_MARGIN"] = 2,
		["TELEPORT_COOLDOWN"] = 0.5,
		["STATION_MARGIN"] = 20
	},
	["STEP_AWARDS"] = {
		["Award1"] = {
			["Bonus"] = 1,
			["ReqWins"] = 0
		},
		["Award2"] = {
			["Bonus"] = 2,
			["ReqWins"] = 3
		},
		["Award3"] = {
			["Bonus"] = 5,
			["ReqWins"] = 15
		},
		["Award4"] = {
			["Bonus"] = 25,
			["ReqWins"] = 100
		},
		["Award5"] = {
			["Bonus"] = 50,
			["ReqWins"] = 500
		},
		["Award6"] = {
			["Bonus"] = 100,
			["ReqWins"] = 2500
		},
		["Award7"] = {
			["Bonus"] = 250,
			["ReqWins"] = 15000
		},
		["Award8"] = {
			["Bonus"] = 500,
			["ReqWins"] = 50000
		},
		["Award9"] = {
			["Bonus"] = 1000,
			["ReqWins"] = 100000
		}
	}
}
local v2 = {
	["GreenTrail"] = {
		["Multiplier"] = 1.5,
		["Price"] = 500,
		["Gamepass"] = 1712973165,
		["Color"] = ColorSequence.new(Color3.fromRGB(4, 182, 10))
	},
	["BlueTrail"] = {
		["Multiplier"] = 2,
		["Price"] = 1500,
		["Gamepass"] = 1713057055,
		["Color"] = ColorSequence.new(Color3.fromRGB(0, 73, 190))
	},
	["PurpleTrail"] = {
		["Multiplier"] = 3,
		["Price"] = 5000,
		["Gamepass"] = 1713073066,
		["Color"] = ColorSequence.new(Color3.fromRGB(136, 0, 190))
	},
	["RedTrail"] = {
		["Multiplier"] = 4,
		["Price"] = 25000,
		["Gamepass"] = 1708943651,
		["Color"] = ColorSequence.new(Color3.fromRGB(186, 0, 3))
	},
	["RainbowTrail"] = {
		["Multiplier"] = 5,
		["Price"] = 100000,
		["Gamepass"] = 1713953417,
		["Color"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
		})
	},
	["GalaxyTrail"] = {
		["Multiplier"] = 10,
		["Price"] = 2500000,
		["Gamepass"] = 1906620818,
		["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 50)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 150)) })
	},
	["CosmicTrail"] = {
		["Multiplier"] = 100,
		["Price"] = 5000000,
		["Gamepass"] = 1903801235,
		["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 100, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255)) })
	},
	["VoidTrail"] = {
		["Multiplier"] = 1000,
		["Price"] = 50000000,
		["Gamepass"] = 1710023493,
		["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 0, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255)) })
	},
	["SupernovaTrail"] = {
		["Multiplier"] = 10000,
		["Price"] = 500000000,
		["Gamepass"] = 1907010817,
		["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 200)) })
	},
	["GodlikeTrail"] = {
		["Multiplier"] = 100000,
		["Price"] = 5000000000,
		["Gamepass"] = 1906944802,
		["Color"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
			ColorSequenceKeypoint.new(0.25, Color3.fromRGB(200, 0, 30)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 215, 0)),
			ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 200))
		})
	},
	["InfinityTrail"] = {
		["Multiplier"] = 5000000,
		["Price"] = 0,
		["Gamepass"] = 1906002783,
		["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 220, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 180, 255)) })
	}
}
u1.TRAILS = v2
u1.DEFAULT_TRAIL = "None"
u1.GROUP_ID = 898716319
u1.GIFT_REWARD = 15000
u1.BADGE_IDS = {
	["WELCOME"] = 1420201693079850,
	["REBIRTH"] = 2153967300203954
}
u1.SPEED_UPGRADES = {
	{
		["Tier"] = 1,
		["Multiplier"] = 2,
		["ID"] = 1908001145,
		["Price"] = 19
	},
	{
		["Tier"] = 2,
		["Multiplier"] = 4,
		["ID"] = 19006315756,
		["Price"] = 39
	},
	{
		["Tier"] = 3,
		["Multiplier"] = 8,
		["ID"] = 1907719718,
		["Price"] = 79
	},
	{
		["Tier"] = 4,
		["Multiplier"] = 16,
		["ID"] = 1905937649,
		["Price"] = 99
	},
	{
		["Tier"] = 5,
		["Multiplier"] = 32,
		["ID"] = 1906873700,
		["Price"] = 129
	},
	{
		["Tier"] = 6,
		["Multiplier"] = 64,
		["ID"] = 1907977661,
		["Price"] = 149
	},
	{
		["Tier"] = 7,
		["Multiplier"] = 128,
		["ID"] = 1906225731,
		["Price"] = 199
	},
	{
		["Tier"] = 8,
		["Multiplier"] = 256,
		["ID"] = 1907143682,
		["Price"] = 279
	}
}
u1.GAMEPASS_IDS = {
	["TROPHY_X2"] = 1918893234,
	["WINS_X2"] = 1918893234,
	["GOLD_ACCESS"] = 1918137243,
	["DIAMOND_ACCESS"] = 1918137243,
	["CANDY_ACCESS"] = 1919277271,
	["ADMIN_ACCESS"] = 1919073256,
}
u1.LEGACY_GAMEPASS_IDS = {
	["TROPHY_X2"] = 1918893234,
	["WINS_X2"] = 1918893234,
	["GOLD_ACCESS"] = 1918137243,
	["DIAMOND_ACCESS"] = 1918137243,
	["CANDY_ACCESS"] = 1919277271,
	["ADMIN_ACCESS"] = 1919073256
}
u1.DEV_PRODUCTS = {
	["SPEED_150K"] = 3609177221,
	["SPEED_1M"] = 3609177345,
	["SPEED_10M"] = 3609177440,
	["SPEED_50M"] = 3609177514,
	["SPEED_500M"] = 3609177597,
	["SPEED_1B"] = 3609177622,
	["INSTANT_REBIRTH_T1"] = 3610630851,
	["INSTANT_REBIRTH_T2"] = 3610630899,
	["INSTANT_REBIRTH_T3"] = 3610630921,
	["REVIVE"] = 3609177159
}
u1.STEP_DISTANCE = 3
u1.DEFAULT_WALKSPEED = 10
u1.MAX_LEVEL_SPEED_CAP = 100
u1.SPAWN_OFFSET = Vector3.new(0, 5, 0)
u1.SPEED_GAIN_PER_LEVEL = 1
u1.TREADMILL_CHECK_INTERVAL = 0.15
u1.TREADMILL_CHECK_RANGE = 2
u1.TREADMILL_HEIGHT_RANGE = 5
u1.BASE_XP = 100
u1.XP_GROWTH = 1.15
u1.XP_EXPONENT = 1.15
function u1.GetXPRequired(p3) 

	if p3 <= 0 then
		return 0
	end
	local v4 = u1.BASE_XP * u1.XP_GROWTH ^ (p3 - 1)
	return math.round(v4)
end
u1.DEFAULT_DATA = {
	["TotalXP"] = 0,
	["Level"] = 1,
	["XP"] = 0,
	["Wins"] = 0,
	["Rebirths"] = 0,
	["Multiplier"] = 1,
	["StepBonus"] = 1,
	["WinsMultiplier"] = 1,
	["SpeedBoostMultiplier"] = 1,
	["CustomWalkSpeed"] = 0,
	["GiftClaimed"] = false,
	["ManualGoldAccess"] = false,
	["EquippedTrail"] = "None",
	["firstJoin"] = 0,
	["timePlayed"] = 0,
	["Checkpoint"] = 0,
	["SpeedBoostTier"] = 0,
	["CurrentSpeedTier"] = 0,
	["SpecialSpeedBoost"] = false,
	["SocialCodeClaimed"] = false,
	["OwnedTrails"] = {},
	["PurchaseHistory"] = {},
	["TikfinityBinds"] = {},
	["EventRsvpClaimed"] = {},
	["CheatHistory"] = {},
	["CheatHistory2"] = {}
}
u1.REBIRTH_TIERS = {
	{
		["level"] = 15,
		["multiplier"] = 2
	},
	{
		["level"] = 25,
		["multiplier"] = 3
	},
	{
		["level"] = 40,
		["multiplier"] = 4
	},
	{
		["level"] = 60,
		["multiplier"] = 5
	},
	{
		["level"] = 75,
		["multiplier"] = 6
	},
	{
		["level"] = 100,
		["multiplier"] = 7
	},
	{
		["level"] = 125,
		["multiplier"] = 8
	},
	{
		["level"] = 150,
		["multiplier"] = 9
	},
	{
		["level"] = 175,
		["multiplier"] = 10
	},
	{
		["level"] = 200,
		["multiplier"] = 10
	},
	{
		["level"] = 225,
		["multiplier"] = 100
	},
	{
		["level"] = 260,
		["multiplier"] = 1000
	},
	{
		["level"] = 300,
		["multiplier"] = 10000
	},
	{
		["level"] = 340,
		["multiplier"] = 100000
	},
	{
		["level"] = 380,
		["multiplier"] = 1000000
	},
	{
		["level"] = 420,
		["multiplier"] = 10000000
	},
	{
		["level"] = 465,
		["multiplier"] = 100000000
	},
	{
		["level"] = 510,
		["multiplier"] = 1000000000
	},
	{
		["level"] = 560,
		["multiplier"] = 10000000000
	},
	{
		["level"] = 600,
		["multiplier"] = 100000000000
	},
	{
		["level"] = 700,
		["multiplier"] = 1000000000000
	},
	{
		["level"] = 800,
		["multiplier"] = 10000000000000
	},
	{
		["level"] = 900,
		["multiplier"] = 100000000000000
	},
	{
		["level"] = 1000,
		["multiplier"] = 1000000000000000
	},
	{
		["level"] = 1200,
		["multiplier"] = 10000000000000000
	},
	{
		["level"] = 2000,
		["multiplier"] = 100000000000000000
	}
}
u1.WIN_AMOUNTS = {
	["WinBlock"] = 1,
	["WinBlock1"] = 1,
	["WinBlock2"] = 10,
	["WinBlock3"] = 50,
	["WinBlock4"] = 100,
	["WinBlock5"] = 500,
	["WinBlock6"] = 1000,
	["WinBlock7"] = 15000,
	["WinBlock8"] = 18000,
	["WinBlock9"] = 150000,
	["WinBlock10"] = 150000,
	["WinBlock11"] = 150000,
	["WinBlock12"] = 150000,
	["WinBlock13"] = 150000,
	["WinBlock14"] = 150000,
	["WinBlock15"] = 150000
}
u1.WIN_MIN_TIMES = {
	["WinBlock2"] = 0,
	["WinBlock3"] = 0,
	["WinBlock4"] = 0,
	["WinBlock5"] = 10,
	["WinBlock6"] = 10,
	["WinBlock7"] = 10,
	["WinBlock8"] = 12,
	["WinBlock9"] = 25,
	["WinBlock10"] = 30,
	["WinBlock11"] = 45,
	["WinBlock12"] = 55,
	["WinBlock13"] = 60,
	["WinBlock14"] = 65,
	["WinBlock15"] = 70
}
u1.BOSS_WIN_TIERS = {
	{
		["maxLevel"] = 10,
		["wins"] = 1
	},
	{
		["maxLevel"] = 20,
		["wins"] = 10
	},
	{
		["maxLevel"] = 35,
		["wins"] = 50
	},
	{
		["maxLevel"] = 55,
		["wins"] = 150
	},
	{
		["maxLevel"] = 80,
		["wins"] = 500
	},
	{
		["maxLevel"] = (1 / 0),
		["wins"] = 2500
	}
}
function u1.GetBestStepBonus(wins)
	local bestBonus = 1
	for _, award in pairs(u1.STEP_AWARDS) do
		if wins >= award.ReqWins and award.Bonus > bestBonus then
			bestBonus = award.Bonus
		end
	end
	return bestBonus
end
u1.AUTO_SAVE_INTERVAL = 60
u1.WIN_DEBOUNCE_DELAY = 3
u1.ANIMATION_IDS = {
	["RUN"] = "rbxassetid://180426354"
}
u1.SOUNDS = {
	["WIN"] = {
		["ID"] = "rbxassetid://136993031050456",
		["Volume"] = 0.5
	},
	["REBIRTH"] = {
		["ID"] = "rbxassetid://112485797063762",
		["Volume"] = 0.6
	},
	["COLLECT"] = {
		["ID"] = "rbxassetid://1289263994",
		["Volume"] = 0.5
	},
	["LEVEL_UP"] = {
		["ID"] = "rbxassetid://3120909354",
		["Volume"] = 0.3
	},
	["HOVER"] = {
		["ID"] = "rbxassetid://73982862253547",
		["Volume"] = 0.6
	},
	["CLICK"] = {
		["ID"] = "rbxassetid://17481582653",
		["Volume"] = 1
	},
	["DEV_REBIRTH"] = {
		["ID"] = "rbxassetid://3601621507",
		["Volume"] = 0.7
	},
	["BUY"] = {
		["ID"] = "rbxassetid://133292918309565",
		["Volume"] = 0.5
	},
	["ERROR"] = {
		["ID"] = "rbxassetid://87437544236708",
		["Volume"] = 0.6
	},
	["SUCCESS"] = {
		["ID"] = "rbxassetid://136993031050456",
		["Volume"] = 0.6
	},
	["ERROR7"] = {
		["ID"] = "rbxassetid://133843340754810",
		["Volume"] = 0.6
	},
	["EFFECT1"] = {
		["ID"] = "rbxassetid://126805498637586",
		["Volume"] = 0.6
	},
	["EFFECT2"] = {
		["ID"] = "rbxassetid://112124748378177",
		["Volume"] = 0.6
	},
	["BOSS_HIT"] = {
		["ID"] = "rbxassetid://140462043853173",
		["Volume"] = 0.7
	}
}
u1.DURATIONS = {
	["LEVEL_UP"] = 1,
	["MESSAGE"] = 2,
	["WIN"] = 1,
	["MODAL_OPEN"] = 0.3,
	["MODAL_CLOSE"] = 0.2,
	["NOTIFICATION"] = 0.3,
	["FADE_OUT"] = 0.5
}
u1.COLORS = {
	["AWARD_EQUIPPED"] = BrickColor.new("New Yeller"),
	["AWARD_DEFAULT"] = BrickColor.new("Lime green"),
	["AWARD_LOCKED"] = BrickColor.new("Smoky grey")
}
u1.XP_TIME_BASED = {
	["MIN_SPEED"] = 10,
	["MAX_SPEED"] = 150,
	["MIN_COOLDOWN"] = 0.1,
	["MAX_COOLDOWN"] = 0.25
}
function u1.CalculateMaxSpeed(p5, rebirthMultiplier) 

	rebirthMultiplier = rebirthMultiplier or 1
	local v6 = u1.DEFAULT_WALKSPEED + p5 * u1.SPEED_GAIN_PER_LEVEL * rebirthMultiplier
	local v7 = u1.MAX_LEVEL_SPEED_CAP
	return math.min(v6, v7)
end
u1.CHECKPOINTS = {
	{
		["Name"] = "Stage2",
		["WinPrice"] = 2,
		["RobuxPrice"] = 3,
		["RobuxProductId"] = 3548700311
	},
	{
		["Name"] = "Stage3",
		["WinPrice"] = 6,
		["RobuxPrice"] = 5,
		["RobuxProductId"] = 3548700421
	},
	{
		["Name"] = "Stage4",
		["WinPrice"] = 20,
		["RobuxPrice"] = 10,
		["RobuxProductId"] = 3548700537
	},
	{
		["Name"] = "Stage5",
		["WinPrice"] = 40,
		["RobuxPrice"] = 15,
		["RobuxProductId"] = 3548700704
	},
	{
		["Name"] = "Stage6",
		["WinPrice"] = 100,
		["RobuxPrice"] = 20,
		["RobuxProductId"] = 3548700852
	},
	{
		["Name"] = "Stage7",
		["WinPrice"] = 200,
		["RobuxPrice"] = 25,
		["RobuxProductId"] = 3548700954
	},
	{
		["Name"] = "Stage8",
		["WinPrice"] = 300,
		["RobuxPrice"] = 30,
		["RobuxProductId"] = 3548701203
	},
	{
		["Name"] = "Stage9",
		["WinPrice"] = 600,
		["RobuxPrice"] = 40,
		["RobuxProductId"] = 3548701309
	},
	{
		["Name"] = "Stage10",
		["WinPrice"] = 1000,
		["RobuxPrice"] = 50,
		["RobuxProductId"] = 3548701403
	},
	{
		["Name"] = "Stage11",
		["WinPrice"] = 2000,
		["RobuxPrice"] = 65,
		["RobuxProductId"] = 3548701601
	},
	{
		["Name"] = "Stage12",
		["WinPrice"] = 5000,
		["RobuxPrice"] = 79,
		["RobuxProductId"] = 3548701840
	},
	{
		["Name"] = "Stage13",
		["WinPrice"] = 20000,
		["RobuxPrice"] = 99,
		["RobuxProductId"] = 3548702409
	},
	{
		["Name"] = "Stage14",
		["WinPrice"] = 50000,
		["RobuxPrice"] = 119,
		["RobuxProductId"] = 3584695362
	}
}
u1.SkipCheckpoints = {
	{
		["Name"] = "Stage2",
		["RobuxPrice"] = 2,
		["RobuxProductId"] = 3549060027
	},
	{
		["Name"] = "Stage3",
		["RobuxPrice"] = 3,
		["RobuxProductId"] = 3549060116
	},
	{
		["Name"] = "Stage4",
		["RobuxPrice"] = 5,
		["RobuxProductId"] = 3549060232
	},
	{
		["Name"] = "Stage5",
		["RobuxPrice"] = 8,
		["RobuxProductId"] = 3549060326
	},
	{
		["Name"] = "Stage6",
		["RobuxPrice"] = 10,
		["RobuxProductId"] = 3549060424
	},
	{
		["Name"] = "Stage7",
		["RobuxPrice"] = 13,
		["RobuxProductId"] = 3549060516
	},
	{
		["Name"] = "Stage8",
		["RobuxPrice"] = 15,
		["RobuxProductId"] = 3549060646
	},
	{
		["Name"] = "Stage9",
		["RobuxPrice"] = 20,
		["RobuxProductId"] = 3549060740
	},
	{
		["Name"] = "Stage10",
		["RobuxPrice"] = 25,
		["RobuxProductId"] = 3549060838
	},
	{
		["Name"] = "Stage11",
		["RobuxPrice"] = 30,
		["RobuxProductId"] = 3549060917
	},
	{
		["Name"] = "Stage12",
		["RobuxPrice"] = 35,
		["RobuxProductId"] = 3549061014
	},
	{
		["Name"] = "Stage13",
		["RobuxPrice"] = 40,
		["RobuxProductId"] = 3549061168
	},
	{
		["Name"] = "Stage14",
		["RobuxPrice"] = 50,
		["RobuxProductId"] = 3584695879
	}
}
function u1.GetRebirthProductId(p8) 

	local v9 = (p8 or 0) + 1
	if v9 <= 7 then
		return u1.DEV_PRODUCTS.INSTANT_REBIRTH_T1
	elseif v9 <= 13 then
		return u1.DEV_PRODUCTS.INSTANT_REBIRTH_T2
	else
		return u1.DEV_PRODUCTS.INSTANT_REBIRTH_T3
	end
end
return u1