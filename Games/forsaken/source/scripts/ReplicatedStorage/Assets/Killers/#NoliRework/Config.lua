-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	DisplayName = "Noli (Rework)";
	Quote = "\"This thing of darkness I acknowledge mine.\"";
	Credits = "By: c2o";
	RenderImage = "rbxassetid://83819111053954";
	Exclusive = true;
	Price = 1100;
	Health = 1111;
	Speed = 7.5;
	SprintSpeed = 27.5;
	StaminaLoss = 9.5;
	StaminaGain = 21;
	MaxStamina = 110;
	MovementAnimSpeed = 1.5;
	StabDamage = 25;
	StabCooldown = 1.8;
	StabWindup = 0.4;
	StabEndlag = 1.5;
	VoidRushBaseDamage = 10;
	VoidRushSlamDamage = 30;
	VoidRushC00ldown = 20;
	VoidRushHallucinationLevel = 2;
	VoidRushHallucinationDuration = 20;
	VoidRushSensitiveButton = true;
	VoidRushChargeLength = 1;
	VoidRushDashLength = 3.5;
	VoidRushDashSpeed = 60;
	VoidRushTurnSpeed = 1;
	VoidRushInitialTurnDuration = 0.8;
	VoidRushInitialTurnMult = 6;
	VoidRushHitEndlag = 0.85;
	VoidRushComboWindow = 1.5;
	VoidRushMissEndlag = 2.5;
	VoidRushChargingSpeed = 0.4;
	VoidRushCutsceneLength = 1.25;
	VoidRushStopMessages = {
		Hit = "Hit the Void Rush key again to charge again!";
		HitLarge = "hell yeah >:)";
		Crashed = "owwwww ;(";
		Cancelled = "Awww :(";
		Stunned = "AUGHHHHHHH";
		Timeout = "too slow";
		FailedToCharge = "you didn't charge it long enough >:((";
		WindowMissed = "ok... ;(";
		NonChar = "PROPERTY DAMAGE";
	};
	NovaCooldown = 12;
	NovaProjectile = script.Voidstar;
	NovaWindup = 0.78;
	NovaWindupSpeed = 0.5;
	NovaProjectileSpeed = 80;
	NovaFuseTime = 10;
	NovaMaxRange = 115;
	NovaExplosionRadius = 20;
	NovaExplosionDamage = 15;
	NovaExplosionKnockback = 420;
	NovaTeleportDisableLength = 0.5;
	NovaFloorAngle = 10;
	ObservantC00ldown = 30;
	ObservantSpeed = 0.2;
	ObservantTeleportWindup = 1.5;
	ObservantTeleportEndlag = 1.3;
	["ObservantHighlight"] = script.Highlight,
	ObservantHighlightTemplate = script.ScaryGenAura,
	["ObservantStatusThresholds"] = {
		20,
		60,
		100,
		(1 / 0)
	},
	["ObservantStatusDuration"] = game["Run Service"]:IsStudio() and 45 or 15,
	["ObservantWarningTemplate"] = script.GeneratorWarning,
	["ObservantIncomingTemplate"] = script.GeneratorIncoming,
	["ObservantStartVFX"] = script.TeleportStartVFX,
	["ObservantEndVFX"] = script.TeleportEndVFX,
	["ObservantTeleportButton"] = script.GeneratorTeleportButton,
	["ObservantMinDistance"] = 50,
	["HallucinationScreamer"] = script.noliLaugh,
	["HallucinationCloneDamage"] = 0,
	["HallucinationCloneFakeDamage"] = 25,
	["IntroLighting"] = script.IntroLighting,
	["ImpactCC"] = script.Impact,
	["OutroLighting"] = script.OutroLighting,
	["OutroFrameData"] = require(script.BakedOutroData),
	["Emotes"] = {
		["Voicelines"] = {
			["Yes"] = {
				["DisplayName"] = "Yes",
				["Description"] = "Yayayaya",
				["Voiceline"] = "Wheel_Yes"
			},
			["No"] = {
				["DisplayName"] = "No",
				["Description"] = "no",
				["Voiceline"] = "Wheel_No"
			},
			["Taunt"] = {
				["DisplayName"] = "Taunt",
				["Description"] = "nananana boo boo",
				["Voiceline"] = "Wheel_Taunt"
			},
			["Rage"] = {
				["DisplayName"] = "Rage",
				["Description"] = "GRRRRRRRRRR",
				["Voiceline"] = "Wheel_Rage"
			},
			["Laugh"] = {
				["DisplayName"] = "Laugh",
				["Description"] = "HAHAHAHAHAHAHAHA",
				["Voiceline"] = "Wheel_Laugh"
			}
		}
	},
	["Animations"] = {
		["Idle"] = "rbxassetid://139885900288814",
		["Walk"] = "rbxassetid://139051569360644",
		["Run"] = "rbxassetid://138722701242507",
		["Stab"] = "rbxassetid://78128091009616",
		["Victory"] = {
			["KillerRig"] = "rbxassetid://110215465062337",
			["CameraRig"] = "rbxassetid://110446829529954"
		},
		["VoidRush"] = {
			["StartCharge"] = "rbxassetid://80967604586681",
			["LoopCharge"] = "rbxassetid://136801896501749",
			["CancelCharge"] = "rbxassetid://80967604586681",
			["StartDashInit"] = "rbxassetid://107868709198225",
			["LoopDashInit"] = "rbxassetid://118409071182553",
			["StartDashCombo"] = "rbxassetid://130186029443032",
			["LoopDashCombo"] = "rbxassetid://135961639726714",
			["EndDash"] = "rbxassetid://140277955065585",
			["WeakHit"] = "rbxassetid://94008599583839",
			["CutsceneKillerRig"] = "rbxassetid://109019599283207"
		},
		["VoidRushVictimRig"] = "rbxassetid://132376299367034",
		["NovaThrow"] = "rbxassetid://95639214023423",
		["NovaDet"] = "rbxassetid://72452888871062",
		["ObservantTeleport"] = "rbxassetid://119918239208936",
		["Hallucination"] = "rbxassetid://96727234784061",
		["Introduction"] = {
			["KillerRig"] = "rbxassetid://81691996866992",
			["CameraRig"] = "rbxassetid://71287842503152"
		},
		["Execution"] = {
			["KillerRig"] = "rbxassetid://132928682193511",
			["PlayerRig"] = "rbxassetid://102612083731342",
			["PlayerCFrameOffset"] = CFrame.new(0, 0, -6)
		},
		["Stunned"] = {
			["Start"] = "rbxassetid://139031202195703",
			["Loop"] = "rbxassetid://97621473059173",
			["End"] = "rbxassetid://107904486600302"
		}
	},
	["Sounds"] = {
		--["Ambience"] = "rbxassetid://130462473227168",
		["Footsteps"] = { "rbxassetid://96202984602815", "rbxassetid://72025196832424" },
		["Execution"] = "rbxassetid://94568014655919",
		["Swing"] = "rbxassetid://90313898226537",
		["Hit"] = "rbxassetid://92292908269897",
		["Nova"] = "rbxassetid://108015259723177",
		["NovaInject"] = "rbxassetid://114767134633867",
		["NovaDefused"] = "rbxassetid://9117341652",
		["NovaShatter"] = "rbxassetid://135436309",
		["Explosion"] = "rbxassetid://88340623380388",
		["VoidRushStart"] = "rbxassetid://116896109516598",
		["VoidRushLoop"] = "rbxassetid://136665840428895",
		["VoidRushCancel"] = "rbxassetid://103080576212424",
		["VoidRushMissTimeout"] = "rbxassetid://77652597584455",
		["VoidRushMissCancelled"] = "rbxassetid://1141391905",
		["VoidRushMissCrashed"] = "rbxassetid://103863018903029",
		["VoidRushMissStunned"] = "rbxassetid://77652597584455",
		["VoidRushMissNonChar"] = "rbxassetid://118225412143120",
		["VoidRushDash1"] = "rbxassetid://117009919779185",
		["VoidRushDash2"] = "rbxassetid://98635921674453",
		["VoidRushDashLoop"] = "rbxassetid://128650096477560",
		["VoidRushWeakHit1"] = "rbxassetid://9113225979",
		["VoidRushWeakHit2"] = "rbxassetid://9113225979",
		["VoidRushWeakHit3"] = "rbxassetid://9113225979",
		["VoidRushWeakHit4"] = "rbxassetid://9113225979",
		["VoidRushWeakHit5"] = "rbxassetid://9113225979",
		["VoidRushWeakHit6"] = "rbxassetid://9113225979",
		["VoidRushCutscene"] = "rbxassetid://102496816850608",
		["Teleport"] = "rbxassetid://5066021887",
		["ObservantTeleportChannel"] = "rbxassetid://96248028905701",
		["ObservantOn"] = "rbxassetid://2609981431",
		["ObservantOff"] = "rbxassetid://9125639499",
		["ObservantGeneratorStart"] = "rbxassetid://7112391013",
		["ObservantGeneratorEnd"] = "rbxassetid://88118978462942",
		["ObservantGeneratorLoop"] = "rbxassetid://118260781693200",
		["ObservantGeneratorWarning"] = "rbxassetid://111193862705677",
		["HallucinationScreamer"] = "rbxassetid://7082168659",
		["HallucinationCloneDeath"] = "rbxassetid://8699486998",
		["HallucinationDispenserDeath"] = "rbxassetid://7010990122",
		["Stunned"] = {
			["Start"] = "rbxassetid://102444677707392",
			["End"] = "rbxassetid://138370772570360"
		},
		["VoidstarEnable"] = "rbxassetid://106727013904874",
		["TerrorRadiusThemes"] = {
			[60] = {
				["ID"] = "rbxassetid://139480190809847",
				["BPM"] = 81
			},
			[40] = {
				["ID"] = "rbxassetid://128001889491120",
				["BPM"] = 81
			},
			[20] = {
				["ID"] = "rbxassetid://84242347109316",
				["BPM"] = 81
			},
			[6] = {
				["ID"] = "rbxassetid://73747924443464",
				["BPM"] = 81,
				["Chase"] = true
			}
		},
		["Introduction"] = "rbxassetid://118809037000741",
		["Victory"] = "rbxassetid://89790651071993"
	},
	["Voicelines"] = {
		["KillTwoTime"] = { "rbxassetid://86088115199294" },
		["KillElliot"] = { "rbxassetid://138477858897563" },
		["KillChance"] = { "rbxassetid://125919610004432" },
		["KillTaph"] = { "rbxassetid://134397134878915" },
		["Kill"] = { "rbxassetid://121974078903295", "rbxassetid://94853226935319", "rbxassetid://121592097672073" },
		["Slam"] = { "rbxassetid://82922314936326" },
		["Stunned"] = { "rbxassetid://117937271687762", "rbxassetid://132412345542058" },
		["Wheel_Yes"] = { "rbxassetid://123198966498440" },
		["Wheel_No"] = { "rbxassetid://121974078903295" },
		["Wheel_Taunt"] = {
			"rbxassetid://117937271687762",
			"rbxassetid://113546225855420",
			"rbxassetid://86088115199294",
			"rbxassetid://89165154956281"
		},
		["Wheel_Rage"] = {
			"rbxassetid://121974078903295",
			"rbxassetid://138477858897563",
			"rbxassetid://117937271687762",
			"rbxassetid://134397134878915"
		},
		["Wheel_Laugh"] = { "rbxassetid://121592097672073", "rbxassetid://94853226935319" }
	}
}
local v_u_2 = require(game.ReplicatedStorage.Modules.StatusEffects.KillerExclusive.Hallucination).AuraColors
local function v14(p3, p4)
	-- upvalues: (copy) v_u_2
	if not p3 then
		return "<b>Hallucination</b>"
	end
	local v5 = v_u_2
	local v6 = #v_u_2
	local v7 = v5[math.clamp(p3, 1, v6)]
	local v8 = v7.R * 255
	local v9 = math.floor(v8)
	local v10 = v7.G * 255
	local v11 = math.floor(v10)
	local v12 = v7.B * 255
	local v13 = math.floor(v12)
	return ("<b><font color=\"rgb(%%d, %%d, %%d)\">%*%*</font></b>"):format(p4 and "" or "Hallucination ", (string.rep("I", p3))):format(v9, v11, v13)
end
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "Noli",
		["Text"] = "Melting the darkness, so their rising senses."
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain)
	},
	{
		["Separator"] = "PASSIVES"
	},
	{
		["Header"] = "HALLUCINATIONS",
		["Quote"] = "O, that way madness lies.",
		["Text"] = ("Many of %*\'s abilities will inflict %*.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", (v14())) .. ("Having any level of %* will reveal your aura to the killer for it\'s duration.\n"):format((v14())) .. ("%* will also cause you to hallucinate. Effects will grow stronger as %* increases in level.\n"):format(v14(), (v14())) .. ("Being hit by %* will remove all stacks of %*\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", (v14())) .. ("%* maxes at %*.\n"):format(v14(), (v14(3))) .. ("At %*, a mirage of %* will manifest and start to attack you. <b>Do not look at it.</b>"):format(v14(3), "<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
	},
	{
		["Header"] = "PRANKSTER",
		["Quote"] = "Art ignorant of what thou art.",
		["Text"] = ("At the beginning of the round, %* will spawn Fake Generators in places where the real generators did not.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("If a survivor completes a Fake Generator puzzle, they will gain a stack of %*.\n"):format((v14())) .. ("Fully completing a Fake Generator will <b>instantly grant</b> %*.\n"):format((v14(3))) .. "Fake Generators have many tells to differentiate them from real generators. <b>Pay attention to sound and visuals.</b>"
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Image"] = "rbxassetid://93874368032471",
		["Header"] = "STAB",
		["Quote"] = "Our revels now are ended.",
		["Text"] = ("Cooldown: %*s\n"):format(v1.StabCooldown) .. ("Damage: %*\n"):format(v1.StabDamage) .. ("%* uses his Shadow Tendril to stab forwards after a %* second windup.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v1.StabWindup)
	},
	{
		["Image"] = "rbxassetid://81200466982776",
		["Header"] = "VOID RUSH",
		["Quote"] = "Which pierces so that it assaults.",
		["Text"] = ("Cooldown: %*s\n"):format(v1.VoidRushC00ldown) .. ("Damage: %*\n"):format(v1.VoidRushBaseDamage) .. ("%* will prepare a rush for %* seconds. This preperation can be cancelled.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v1.VoidRushChargeLength) .. ("If a survivor is hit with the rush, they will gain <b>%*</b> for %* seconds. After %* seconds, %* can perform a re-rush.\n"):format(v14(2), v1.VoidRushHallucinationDuration, v1.VoidRushHitEndlag, "<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("If a survivor with %* or above is hit with the rush, %* will slam them into the ground, dealing %* damage and ending the move.\n"):format(v14(2), "<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v1.VoidRushSlamDamage) .. ("The rush will prematurely end if %* is stunned, crashes into a wall, doesn\'t hit a survivor in time, or lets go of the VoidRush key.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("Turn rate during the rush is heavily increased during the first %* seconds. \n"):format(v1.VoidRushInitialTurnDuration) .. ("%* can sprint during a re-rush to temporarily boost speed. \n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("%* is <b>unable to regenerate stamina</b> for the duration of the rush."):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
	},
	{
		["Image"] = "rbxassetid://101955457812737",
		["Header"] = "NOVA",
		["Quote"] = "Thou art inclined to sleep; \226\128\153tis a good dullness.",
		["Text"] = ("Cooldown: %*s\n"):format(v1.NovaCooldown) .. ("Damage: %*\n"):format(v1.NovaExplosionDamage) .. ("%* will throw his Voidstar forward after a %* second windup.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v1.NovaWindup) .. "If the Voidstar hits a survivor or a wall, it will implode and pull survivors inward.\n" .. "If the Voidstar hits the floor, it will shatter.\n" .. ("%* can manually detonate the Voidstar by pressing the Nova button again, but this will significantly reduce the implosion\'s radius."):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
	},
	{
		["Image"] = "rbxassetid://101955457812737",
		["Header"] = "OBSERVANT",
		["Quote"] = "Mine enemies are all knit up In their distractions.",
		["Text"] = ("Cooldown: %*s\n"):format(v1.ObservantC00ldown) .. ("%* enter a stance. All generators will be highlighted to him, and a mirage of him will display over the generators as a warning.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>") .. ("%* can select a generator to teleport it after a %* windup.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v1.ObservantTeleportWindup) .. ("After teleporting, %* will inflict %* %*/%*/%* to all survivors more than %*/%*/%* studs away from the generator.\n"):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>", v14(), v14(1, true), v14(2, true), v14(3, true), v1.ObservantStatusThresholds[1], v1.ObservantStatusThresholds[2], v1.ObservantStatusThresholds[3]) .. ("Stunning %* during this windup or stance will cancel the move."):format("<b><font color=\"rgb(56, 35, 158)\">Noli</font></b>")
	}
}
return v1
