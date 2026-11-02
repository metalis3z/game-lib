-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = workspace:GetAttribute("JohnDoeSpecialDay")
local v2 = {
	["DisplayName"] = "John Doe",
	["Quote"] = v1 and "dude i told you not to play on march 18th" or "DON\'T PLAY ROBLOX ON MARCH 18TH?!?!",
	["Credits"] = "Made by: c2o",
	["RenderImage"] = v1 and "rbxassetid://131855624243843" or "rbxassetid://109027143315601",
	["Price"] = v1 and 318 or 1000,
	["Health"] = v1 and 3182026 or 1500,
	["Speed"] = v1 and 11.3182026 or 9,
	["IntroText"] = "They\'re all yours, Mr. Doe",
	["SprintSpeed"] = v1 and 27.53182026 or 27.25,
	["StaminaLoss"] = 9.5,
	["StaminaGain"] = 21,
	["MaxStamina"] = v1 and 115.3182026 or 110,
	["SlashDamage"] = v1 and 45.3182026 or 28,
	["SlashCooldown"] = v1 and 2.3182026 or 1.75,
	["SlashWindup"] = 0.4,
	["SlashLinger"] = 0.25,
	["CorruptEnergyDamage"] = v1 and 16.3182026 or 12,
	["CorruptEnergyCooldown"] = v1 and 40.3182026 or 18,
	["SpikeAmount"] = v1 and 256 or 27,
	["SpikeHitboxSize"] = Vector3.new(5, 11, 5),
	["SpikeLifetime"] = v1 and 18.3182026 or 14,
	["SpikeHitCap"] = v1 and 3182026 or 4,
	["SpikeProperties"] = PhysicalProperties.new(0.2, 2, 0, 100, 100),
	["DelayBetweenSpikeSummons"] = v1 and 0.02 or 0.054,
	["DistanceBetweenSpikes"] = 4,
	["DigitalFootprintLifetime"] = 165,
	["DigitalFootprintCooldown"] = 8,
	["DigitalFootprintLimit"] = v1 and 4 or 3,
	["404ErrorAuraRevealTime"] = v1 and 10.3182026 or 4,
	["404ErrorCooldown"] = 20,
	["Spike"] = script.Spike,
	["Shadow"] = script.Shadow,
	["Trail"] = script.Trail,
	["SpikeNumbersColor"] = Color3.fromRGB(255, 0, 0),
	["TrailLength"] = v1 and 356 or 48,
	["UnstoppableDuration"] = 2,
	["SilencedTemplate"] = script.NAN,
	["Silenced"] = true,
	["OutroDummy"] = script.OutroVictim,
	["useClouds"] = true,
	["Animations"] = {
		["Idle"] = "rbxassetid://85683782644552",
		["Walk"] = "rbxassetid://108707061400425",
		["Run"] = "rbxassetid://119944123572175",
		["InjuredIdle"] = "rbxassetid://85683782644552",
		["InjuredWalk"] = "rbxassetid://108707061400425",
		["InjuredRun"] = "rbxassetid://119944123572175",
		["Stunned"] = {
			["Start"] = "rbxassetid://136972663358844",
			["Loop"] = "rbxassetid://116470066231067",
			["End"] = "rbxassetid://87300015108115",
			["Cancel"] = "rbxassetid://106383789296420"
		},
		["Execution"] = {
			["KillerRig"] = "rbxassetid://80914749592402", 
			["PlayerRig"] = "rbxassetid://122650366709320", 
			["PlayerCFrameOffset"] = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 3)
		}, 
		["Slash"] = "rbxassetid://87156844332510",
		["CorruptEnergy"] = "rbxassetid://78810338280772",
		["DigitalFootprint"] = "rbxassetid://125589952275520",
		["Introduction"] = {
			["KillerRig"] = "rbxassetid://133057847146430",
			["CameraRig"] = "rbxassetid://91001284734644"
		},
		["Victory"] = {
			["KillerRig"] = "rbxassetid://130959071978716",
			["CameraRig"] = "rbxassetid://134540761947579"
		}
	},
	Sounds = {
		Ambience = "rbxassetid://137644612515529", 
		Footsteps = {
			"rbxassetid://126872882914955", 
			"rbxassetid://81544212102472"
		}, 
		TerrorRadiusThemes = {
			[60] = {
				ID = "rbxassetid://87108568049500", 
				BPM = 100
			}, 
			[40] = {
				ID = "rbxassetid://112183456126257", 
				BPM = 100
			}, 
			[20] = {
				ID = "rbxassetid://110315081858949", 
				BPM = 100
			}, 
			[6] = {
				ID = "rbxassetid://136971917110273", 
				BPM = 100, 
				Chase = true
			}
		}, 
		Execution = "rbxassetid://111428165781349", 
		StunEnded = "rbxassetid://135014543827300", 
		Swing = "rbxassetid://92617976891975", 
		Hit = "rbxassetid://135021872598711", 
		CorruptEnergy = "rbxassetid://136515765909326", 
		CorruptEnergySummon = "rbxassetid://75056952540803", 
		CorruptEnergyDesummon = "rbxassetid://112806895489970", 
		DigitalFootprint = "rbxassetid://117203041616659", 
		DigitalFootprintAmbience = "rbxassetid://73646387012084", 
		["404Error"] = "rbxassetid://123647585037632", 
		["404ErrorError"] = "rbxassetid://90307135163105", 
		Introduction = "rbxassetid://131488814473460"
	}
}
v2.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "JOHN DOE",
		["Text"] = "The defunct code of the early days of Roblox courses through their body, consuming his mind as he now only focuses on one thing: to kill everyone in his path. An unstoppable force entering the round with a strategical mindset, he\'s able to set traps, summon walls to back survivors into a corner, and leave behind a faint trail that damages those who step on it.\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\133\n" .. ("Health: %*\n"):format(v2.Health) .. ("Regular Speed: %*\n"):format(v2.Speed) .. ("Sprinting Speed: %*\n"):format(v2.SprintSpeed) .. ("Max Stamina: %*\n"):format(v2.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v2.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v2.StaminaGain) .. "Terror Radius: 60 studs\n"
	},
	{
		["Separator"] = "PASSIVES"
	},
	{
		["Header"] = "NATURAL MALEVOLENCE",
		["Quote"] = "\"We\226\128\153re dedicated to building a fun, safe environment where kids of all ages can power their imagination on Roblox.\" - Roblox",
		["Text"] = ("For every step that %* takes, a trail of corruption follows behind him.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. "Any survivor that\'s unfortunate enough to step within the corruption is given <b>Corrupted II</b> for 3 seconds.\n"
	},
	{
		["Header"] = "UNSTOPPABLE",
		["Quote"] = "\"Consider this myth busted.\" - Roblox",
		["Text"] = ("%* can only be stunned for %*s while preparing Corrupt Energy and 404 Error.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>", v2.UnstoppableDuration)
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Header"] = "SLASH",
		["Image"] = "rbxassetid://92362553672440",
		["Quote"] = "\"For many years, there has been lore circulating around John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe within the community.\" - Roblox",
		["Text"] = ("Cooldown: %*s\n"):format(v2.SlashCooldown) .. ("Damage: %*\n"):format(v2.SlashDamage) .. ("Windup: %*s\n"):format(v2.SlashWindup) .. ("Linger: %*s\n"):format(v2.SlashLinger) .. "Length: 7.5 studs\n" .. ("%* slashes infront of him using his claws.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>")
	},
	{
		["Header"] = "CORRUPT ENERGY",
		["Icon"] = "rbxassetid://83849304758564",
		["Quote"] = "\"This year, we\226\128\153ve decided that it\226\128\153s time to shed some light about these accounts.\" - Roblox",
		["Text"] = ("Cooldown: %*s\n"):format(v2.CorruptEnergyCooldown) .. ("Damage: %*\n"):format(v2.CorruptEnergyDamage) .. ("%* punches his corrupted arm into the ground and, when he pulls it out, %* giant spikes (that last for %*s) emerge infront of him, piercing through any survivor unfortunate enough to be caught within them.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>", v2.SpikeAmount, v2.SpikeLifetime) .. ("Hitting a player with a spike gives %* Speed I for 7 seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("Summoned spikes cannot damage the same target more than %* times.\n"):format(v2.SpikeHitCap) .. "These spikes can be used as blockades to prevent survivors from accessing certain areas.\n"
	},
	{
		["Header"] = "DIGITAL FOOTPRINT",
		["Image"] = "rbxassetid://83206360003394",
		["Quote"] = "\"John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe are two of Roblox\226\128\153s earliest accounts, as seen by their low user IDs here.\" - Roblox",
		["Text"] = ("Cooldown: %*s\n"):format(v2.DigitalFootprintCooldown) .. ("%* stomps on the ground three times, commanding a shadow to emerge underneath his footsteps as a trap for survivors to walk over.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("If a survivor steps over the false shadow, then %* gets a <b>Speed I</b> buff for 10 seconds and the survivor gets a <b>Corrupted I</b> & <b>Slowness II</b> debuff for 10 seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("Upon the trap being triggered, %* and the survivor who activated it have their auras revealed to each other for 10 seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("The shadow despawns after %* seconds or after contact is made with it.\n"):format(v2.DigitalFootprintLifetime) .. ("There can only be <b>%*</b> shadows present at once.\n"):format(v2.DigitalFootprintLimit)
	},
	{
		["Header"] = "404 ERROR",
		["Icon"] = "rbxassetid://131116145215571",
		["Quote"] = "\"Authentic John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe accounts pose no danger to your Roblox account.\" - Roblox",
		["Text"] = ("Cooldown: %*s\n"):format(v2["404ErrorCooldown"]) .. ("%*\'s corrupted arm pulsates twice, revealing the auras of all living survivors to him for %* seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>", v2["404ErrorAuraRevealTime"])
	}
}
return v2
