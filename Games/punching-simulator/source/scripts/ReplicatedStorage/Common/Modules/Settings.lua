--> Variables
local _L = _G._L

--> Constants

---------->
return {
	data = {
		mock = true,
		key = "Player_Data_002",
		template = {
			gamepasses = {},
			
			clan = nil,
			
			used_codes = {},
			owned_powers = {},
			
			upgrades = {
				["1"] = 1,
				["2"] = 1,
				["3"] = 1,
				["4"] = 1,
			},
			
			titles = {{id = 3}},
			
			lucky_passes = {
				false,
				false,
				false,
			},
			
			auto_delete = {},
			
			stats = {
				Strength = 0,
				Gems = 0,
				Kills = 0,
				Rebirths = 0,
				Crowns = 5,
				Wheel_Spin = 2,
				Pet_Storage_Space = 35,
				Pet_Equip_Space = 3,
				Deaths = 0,
				Huge_Event_Kills = 0,
				Hacker_Event_Kills = 0,
				Event_Eggs_1_Opened = 0,
				Total_Strength = 0,
				Total_Time = 0
			},
			
			settings = {
				Music = true,
				Other_Pets = true,
				Your_Pets = true,
				SFX = true,
				Trades = true,
				Auto_Rebirth = false,
				Popups = true,
				Notifications = true
			},
			
			boosts = {
				["x2_Strength"] = {time_left = 0, quantity = 0},
				["Lucky_Potion"] = {time_left = 0, quantity = 0},
				["Protection_Potion"] = {time_left = 0, quantity = 0},
				["x2_Damage"] = {time_left = 0, quantity = 0},
			},
			
			pets = {},
			claimed_free_pet_pack = false,
			claimed_huge_event_reward = false,
			claimed_hacker_event_reward = false,

			time_reward_chests = {},
			tutorial_marker = 1,
			equipped_aura = nil,
			
			last_daily_gift = {i = nil, t = 0},
			last_daily_case = 0,
			last_premium_case = 0,
			rank_reward = 0,
			
			robux_multiplier = nil,
			
			seasons = {
				{owns_premium = false, free = {}, premium = {}, total_strength_gained = 0, skipped = {}}
			},
			
			clan_quests = {},
			quests = {
				daily = {t = nil, v = {}},
				weekly = {t = nil, v = {}},
				tutorial = {v = {}}
			},
			
			invite_rewards = {},
			friends_invited = {}
		}
	}
}