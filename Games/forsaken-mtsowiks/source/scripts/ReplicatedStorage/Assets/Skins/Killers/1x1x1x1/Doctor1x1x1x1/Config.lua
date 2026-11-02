-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "The Pestilence",
	["Description"] = "Let me Cure you.",
	["RenderImage"] = "rbxassetid://84745320196453",
	["Exclusive"] = false,
	["Price"] = 2049,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(37, 42, 32),
		["OutlineColor"] = Color3.fromRGB(0, 0, 81),
		["FillTransparency"] = 2,
		["OutlineTransparency"] = 0.95
	},
	["ZombieTemplate"] = script.Zombie,
	["PopupsFolder"] = script.Popups
}
local v2 = {
	["Idle"] = "rbxassetid://135691386274939",
	["Walk"] = "rbxassetid://135903744017827",
	["Run"] = "rbxassetid://95904030109332",
	["InjuredIdle"] = "rbxassetid://135691386274939",
	["InjuredWalk"] = "rbxassetid://135903744017827",
	["InjuredRun"] = "rbxassetid://95904030109332",
	["Slash"] = "rbxassetid://125407665406281",
	["Execution"] = {
		["KillerRig"] = "rbxassetid://133550613756416",
		["PlayerRig"] = "rbxassetid://125077799075888"
	},
	["ExecutionShedletsky"] = {
		["KillerRig"] = "rbxassetid://103205081056926",
		["PlayerRig"] = "rbxassetid://118963273077141"
	},
	["BetterIdle"] = "rbxassetid://135691386274939",
	["BetterWalk"] = "rbxassetid://135903744017827",
	["BetterRun"] = "rbxassetid://95904030109332",
	["MassInfection"] = "rbxassetid://126145540408456"
}
v1.Animations = v2
v1.Sounds = {
	["Footsteps"] = { "rbxassetid://126664543754431", "rbxassetid://120096073664707", "rbxassetid://111070801552288" },
	["Ambience"] = "rbxassetid://133863234201513",
	["ExecutionShedletsky"] = "rbxassetid://85719846794088",
	["Execution"] = "rbxassetid://87208005784398",
	["EntanglementActivate"] = "rbxassetid://107039569833867",
	["RejuvenateTheRottenActivate"] = "rbxassetid://99174224422295",
	["MassInfectionActivate"] = "rbxassetid://124861748759430",
	["UnstableEyeActivate"] = "rbxassetid://89145114791864",
	["Introduction"] = "rbxassetid://72479303957625",
	["VictoryTheme"] = "rbxassetid://99627234761732"
}
v1.Voicelines = {
	["Entanglement"] = {
		"rbxassetid://101866556634532",
		"rbxassetid://104812969243720",
		"rbxassetid://103471936752956",
		"rbxassetid://113964393665069"
	},
	["UnstableEye"] = { "rbxassetid://123807068175918", "rbxassetid://116413451035731", "rbxassetid://91710834670564" },
	["RejuvenateTheRotten"] = { "rbxassetid://111920534830836", "rbxassetid://77612306050376", "rbxassetid://91576155439868" },
	["MassInfection"] = {
		"rbxassetid://136338043518903",
		"rbxassetid://75966275078475",
		"rbxassetid://131141749047527",
		"rbxassetid://119589922310522"
	},
	["Idle"] = {
		"rbxassetid://114157155101188",
		"rbxassetid://81404919531488",
		"rbxassetid://98390261959908",
		"rbxassetid://131019032504969",
		"rbxassetid://121258861297467",
		"rbxassetid://104548433448740"
	},
	["Kill"] = {
		"rbxassetid://134245838133842",
		"rbxassetid://82294459259881",
		"rbxassetid://122711807214040",
		"rbxassetid://97149258646617",
		"rbxassetid://85273630189734"
	},
	["Introduction"] = { "rbxassetid://121140810993331", "rbxassetid://140283865569652", "rbxassetid://77544709323127" },
	["LastSurvivor"] = { "rbxassetid://135171335926218", "rbxassetid://78300439691361" }
}
return v1