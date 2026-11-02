-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Eye of The Abyss",
	["Description"] = "It stared into the Abyss. The Abyss stared back.",
	["RenderImage"] = "rbxassetid://137779196200505",
	["Price"] = 99999999,
	["Exclusive"] = true,
	["ShockwaveTemplate"] = script.shockwave,
	["IntroHeadTemplate"] = script.ShedletskyHead,
	["ZombieTemplate"] = script.Zombie,
	["PopupsFolder"] = script.Popups,
	["SwordsTemplate"] = script.Swords,
	["IntroLighting"] = script.Lighting,
	["OutroLighting"] = script.OutroLighting,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(74, 74, 74),
		["OutlineColor"] = Color3.fromRGB(0, 0, 81),
		["FillTransparency"] = 1.2,
		["OutlineTransparency"] = -100
	}
}
local v2 = {}
local v3 = {}
local v10 = {
	["DisplayName"] = "Minion Breakdown",
	["Description"] = "3 Million Orb",
	["AssetID"] = "rbxassetid://130524968772551",
	["SFX"] = "rbxassetid://1838457617",
	["SFXProperties"] = {
		["Looped"] = false
	},
	["CreatedServer"] = function(p4)
		local v5 = p4.Character
		if v5 then
			local v_u_6 = script.ZombieEmote:Clone()
			v_u_6.Name = "EmoteZombie"
			v_u_6.PrimaryPart.Anchored = true
			for _, v7 in v_u_6:GetDescendants() do
				if v7:IsA("BasePart") then
					v7.CanCollide = false
					v7.CanQuery = false
					v7.CanTouch = false
				end
			end
			v_u_6:SetPrimaryPartCFrame(v5.PrimaryPart.CFrame)
			v_u_6.Parent = workspace.Misc
			v_u_6.Dummy:FindFirstChildOfClass("Animator"):LoadAnimation(v_u_6.Animation):Play()
			task.delay(20.4, function()
				-- upvalues: (copy) v_u_6
				if v_u_6 ~= nil then
					v_u_6:Destroy()
				end
			end)
		end
	end,
	["DestroyedServer"] = function(p8)
		local v9 = p8.Character and workspace.Misc:FindFirstChild("EmoteZombie")
		if v9 then
			v9:Destroy()
		end
	end
}
v3.MinionBreakdown = v10
v2.Animations = v3
v1.Emotes = v2
local v11 = {
	["Idle"] = "rbxassetid://140021319939389",
	["Walk"] = "rbxassetid://77590904057558",
	["Run"] = "rbxassetid://118663593676602",
	["InjuredIdle"] = "rbxassetid://140021319939389",
	["InjuredWalk"] = "rbxassetid://77590904057558",
	["InjuredRun"] = "rbxassetid://118663593676602",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://127326717060108",
		["CameraRig"] = "rbxassetid://138290422023632"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://89660844724055",
		["PlayerRig"] = "rbxassetid://87690392983421"
	},
	["ExecutionShedletsky"] = {
		["KillerRig"] = "rbxassetid://103452575103670",
		["PlayerRig"] = "rbxassetid://134530007935136"
	},
	["Slash"] = "rbxassetid://128813487104056",
	["Entanglement"] = "rbxassetid://74357853289328",
	["MassInfection"] = "rbxassetid://84327970658708",
	["UnstableEye"] = "rbxassetid://136024807285863",
	["RejuvenateTheRotten"] = "rbxassetid://81552667666800",
	["Victory"] = {
		["KillerRig"] = "rbxassetid://131089733650866",
		["CameraRig"] = "rbxassetid://140618326923949"
	},
	["Stunned"] = {
		["Start"] = "rbxassetid://81088800154427",
		["Loop"] = "rbxassetid://92415802072323",
		["End"] = "rbxassetid://112759575101170"
	}
}
v1.Animations = v11
v1.ZombieAnimations = {
	["Idle"] = "rbxassetid://131475926396036",
	["Walk"] = "rbxassetid://131475926396036",
	["Run"] = "rbxassetid://101279881140618",
	["Attack"] = "rbxassetid://109611692538200"
}
local v12 = {
	["Execution"] = {
		{
			["SoundId"] = "rbxassetid://131305621831408",
			["Volume"] = 2.5
		}
	},
	["ExecutionShedletsky"] = {
		{
			["SoundId"] = "rbxassetid://86712408557609",
			["Volume"] = 2.5
		}
	}
}
local v13 = {
	[60] = {
		["ID"] = "rbxassetid://130947726946248",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://123517104257026",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://122355047067305",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://89031456360842",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v12.TerrorRadiusThemes = v13
v12.Footsteps = { "rbxassetid://75457135715759", "rbxassetid://95246424997069" }
v12.VictoryTheme = "rbxassetid://96865574777013"
v12.Introduction = "rbxassetid://90716754217878"
v12.RejuvenateTheRottenActivate = "rbxassetid://109351069746096"
v12.UnstableEyeActivate = "rbxassetid://95720062311206"
v12.EntanglementActivate = "rbxassetid://135854269153231"
v12.MassInfectionActivate = "rbxassetid://74627540041821"
v12.Swing = "rbxassetid://128856426573270"
v12.Hit = "rbxassetid://89621520366345"
v1.Sounds = v12
v1.ZombieSounds = {
	"rbxassetid://9126213995",
	"rbxassetid://9126213993",
	"rbxassetid://9126214611",
	"rbxassetid://9126214616",
	"rbxassetid://9126214610",
	"rbxassetid://9126213984",
	"rbxassetid://9126214600",
	"rbxassetid://9126213741",
	"rbxassetid://9126213744",
	"rbxassetid://9126214321",
	"rbxassetid://9126213743"
}
v1.Voicelines = {
	["Entanglement"] = { "rbxassetid://9126213993" },
	["UnstableEye"] = { "rbxassetid://9126214611" },
	["RejuvenateTheRotten"] = { "rbxassetid://9126213984" },
	["MassInfection"] = { "rbxassetid://9126214321" },
	["Idle"] = {
		"rbxassetid://9126213995",
		"rbxassetid://9126213993",
		"rbxassetid://9126214611",
		"rbxassetid://9126214616",
		"rbxassetid://9126214610",
		"rbxassetid://9126213984",
		"rbxassetid://9126214600",
		"rbxassetid://9126213741",
		"rbxassetid://9126213744",
		"rbxassetid://9126214321",
		"rbxassetid://9126213743"
	},
	["Kill"] = {
		"rbxassetid://9126213995",
		"rbxassetid://9126213993",
		"rbxassetid://9126214611",
		"rbxassetid://9126214616",
		"rbxassetid://9126214610",
		"rbxassetid://9126213984",
		"rbxassetid://9126214600",
		"rbxassetid://9126213741",
		"rbxassetid://9126213744",
		"rbxassetid://9126214321",
		"rbxassetid://9126213743"
	},
	["LastSurvivor"] = { "rbxassetid://9126214616" },
	["Stunned"] = {
		"rbxassetid://9126213995",
		"rbxassetid://9126213993",
		"rbxassetid://9126214611",
		"rbxassetid://9126214616",
		"rbxassetid://9126214610",
		"rbxassetid://9126213984",
		"rbxassetid://9126214600",
		"rbxassetid://9126213741",
		"rbxassetid://9126213744",
		"rbxassetid://9126214321",
		"rbxassetid://9126213743"
	}
}
return v1