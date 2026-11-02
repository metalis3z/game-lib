--[[
    Written by: Nextix (ne_tix)
    Date: 3/29/2026
    
    Additional Information:
    Some of the values here could be wrong / not accurate to the original game. (99% of the datas bellow are 100% accurate. See Method script under this module for context)
    
    Method:
    You can add new stuff in here without being worried about breaking the game, Profilestore assure a security on that.
]]

return {
	Stats = {
		Passes = {
			VIP_OWNS = false,
			EXTRA_PAGE = false,
		},
		JoinDate = {
			hour = 14,
			min = 52,
			wday = 2, -- // Week day ?
			year = 2026,
			yday = 89, -- // Year day ?
			month = 3,
			sec = 57,
			day = 30, -- // Month day ?
			isdst = false,
		},
		KillerChance = 1,
		Wins = 0,
		Loses = 0,
		FazCoins = 500000000000000000,
	},
	OwnedChars = {
		'Survivor-Fighter',
		'Survivor-Customer',
		'Springtrap'
	},
	OwnedSkins = {
		Bear5 = {
			'bear5',
		},
		Springtrap = {
			'Normal',
		},
		Ennard = {
			'Normal',
		},
		Mimic = {
			'Normal',
		},
		SurvivorAll = {
			'Butterflies and Embers',
			'Star'
		},
		['Survivor-Lobby'] = {
			'Normal',
		},
		['Survivor-Security Guard'] = {
			'Normal',
		},
		['Survivor-Medic'] = {
			'Normal',
		},
		['Survivor-Corpse'] = {
			'Normal',
		},
		['Survivor-Fighter'] = {
			'Normal',
			'American',
		},
		['Survivor-Customer'] = {
			'Normal',
		},
	},
	OwnedEmotes = {
		'Smile'
	},
	Character = {
		Survivor = 'Survivor-Fighter',
		Killer = 'Springtrap'
	},
	Settings = {
		DevTags = true,
		VIPTag = true,
		Flashlight = false,
		ServerSide = false,
		DisableKiller = false,
		Volume = 1,
		Performance = false,
		AFK = false,
		UIVolume = 1,
		CrownEnabled = true,
		HoldToRun = true,
		ShowBarriers = false,
		CameraShake = true,
		ExtraStaminaBar = false,
		ShowHitboxes = true,
		EmoteVolume = 1,
		Potato = false,
		MusicVolume = 1,
	},
	EquippedSkins = {
		['Survivor-Customer'] = 'Normal',
		['Survivor-Fighter'] = 'Butterflies and Embers',
		['Springtrap'] = 'spingtap',
	},
	ResetSkins = {},
	CHARACTER_LEVELS = {
		-- // Level, Xp
		['Survivor-Lobby'] = {
			1,
			0,
		},
		['Bear5'] = {
			9999,
			0,
		},
		['Survivor-Customer'] = {
			1,
			0,
		},
		['Survivor-Security Guard'] = {
			1,
			0,
		},
		['Survivor-Medic'] = {
			1,
			0,
		},
		['Springtrap'] = {
			167525,
			500,
		},
		['Survivor-Corpse'] = {
			-9999,
		},
		['Ennard'] = {
			1,
			0,
		},
		['Survivor-Fighter'] = {
			1,
			0,
		},
		['Mimic'] = {
			1,
			0,
		},
	},
	Emotes = {
		Springtrap = {
			'',
			'',
			'',
			'',
			'',
			'',
			'',
			'',
		},
		Mimic = {
			'',
			'',
			'',
			'',
			'',
			'',
			'',
			'',
		},
		Bear5 = {
			'',
			'',
			'',
			'',
			'',
			'',
			'',
			'',
		},
		Ennard = {
			'',
			'',
			'',
			'',
			'',
			'',
			'',
			'',
		},
		Survivor = {
			'',
			'',
			'',
			'',
			'',
			'',
			'',
			''
		}
	}
}