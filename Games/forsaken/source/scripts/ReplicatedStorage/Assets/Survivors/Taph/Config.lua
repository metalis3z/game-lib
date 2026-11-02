-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Taph",
	["Quote"] = "\"BOOM BOOM BOOM!\"",
	["Credits"] = "",
	["Class"] = "Support",
	["RenderImage"] = "rbxassetid://91979599169148",
	["Price"] = 600,
	["Exclusive"] = false,
	["Health"] = 100,
	["Speed"] = 12,
	["TripwireCooldown"] = 25,
	["TripwireLifetime"] = 150,
	["TripwireMaxAmount"] = 3,
	["TripwireHealth"] = 20,
	["TripwireLifetimeDecreasePerTaph"] = 20,
	["TripwireDistanceBetweenTripwires"] = 8,
	["TripwireTriggerSlownessData"] = {
		["Level"] = 2,
		["Duration"] = 4
	},
	["TripwireTriggerAuraRevealInvincibleDuration"] = 4,
	["TripwireTriggerAuraRevealDuration"] = 8,
	["TripwireTriggerAuraRevealDistance"] = 100,
	["TripwireDestroyedAuraDuration"] = 2,
	["TripwireDurationBetweenRewards"] = 4,
	["TripwireCooldownWhilePlacing"] = 2.5,
	["TripwireSpeedWhilePlacing"] = 8.5,
	["TripwireTemplate"] = script.TripwireHook,
	["TripwireCFrameOffset"] = CFrame.Angles(0, 0, 1.5707963267948966),
	["SubspaceTripmineCooldown"] = 40,
	["SubspaceCooldownReductionOnSuccess"] = 10,
	["SubspaceDamage"] = 55,
	["SubspaceLifetime"] = 50,
	["SubspaceThrowForce"] = 50,
	["SubspaceRange"] = 16,
	["SubspaceEffectHitLevel"] = 1,
	["SubspaceEffectLevel"] = 3,
	["SubspaceEffectDuration"] = 5,
	["SubspaceHelplessDuration"] = 5,
	["SubspaceExplosionDelay"] = 0.4,
	["SubspaceHiddenTransparency"] = 0.85,
	["SubspaceHintCount"] = 3,
	["SubspaceHintTransparency"] = 0.6,
	["SubspaceExplosionVFX"] = script.ExplosionVFX,
	["Animations"] = {
		["TripwireIdle"] = "rbxassetid://127583181251887",
		["TripwireWalk"] = "rbxassetid://70747544752516",
		["TripwireRun"] = "rbxassetid://70747544752516",
		["TripwirePlaceStart"] = "rbxassetid://125408594567599",
		["TripwirePlaceEnd"] = "rbxassetid://85682915117104",
		["ThrowSubspace"] = "rbxassetid://70574922856390"
	},
	["Sounds"] = {
		["BeartrapToss"] = "rbxassetid://2769387310",
		["BeartrapLatch"] = "rbxassetid://2769387865",
		["SubspaceToss"] = "rbxassetid://11956590",
		["SubspaceHint"] = "rbxassetid://11984254",
		["SubspaceDetonate"] = "rbxassetid://11984351"
	}
}
local v2 = {
	["Requests"] = {
		["ElliotPizza"] = {
			"\240\159\141\149\226\157\147 (Have pizza?)",
			"\240\159\141\149\226\157\151 (Need pizza!)",
			"\240\159\141\149\226\157\151\226\157\151 (Need pizza, now!!)",
			"\240\159\141\149\240\159\152\139 (Pizza is yummy. Need some.)",
			"\240\159\141\149\240\159\141\189\239\184\143\226\157\147 (Have pizza to eat?)"
		},
		["BuildermanSentry"] = {
			"\240\159\148\171\226\157\147 (Sentry here?)",
			"\240\159\148\171\226\157\151 (Sentry here!)",
			"\240\159\148\171\240\159\146\165\226\157\147 (Sentry goes off here?)",
			"\240\159\148\171\226\128\188\239\184\143\226\172\135\239\184\143 (Sentry over here!!)",
			"\240\159\148\171\226\158\161\239\184\143\240\159\148\170\240\159\146\171 (Sentry handles the killer here.)"
		},
		["BuildermanDispenser"] = {
			"\226\157\164\239\184\143\226\128\141\240\159\169\185\226\157\147 (Dispenser please?)",
			"\226\157\164\239\184\143\226\128\141\240\159\169\185\226\157\151 (Dispenser, hurry!)",
			"\226\157\164\239\184\143\226\128\141\240\159\169\185\240\159\141\142\226\157\147 (Dispenser heal, please?)",
			"\240\159\141\142\226\172\135\239\184\143\226\157\151 (Dispenser here, now!)",
			"\226\157\164\239\184\143\226\128\141\240\159\169\185\226\128\188\239\184\143 (Dispenser over here, now!!)"
		},
		["DusekkarProtection"] = {
			"\240\159\142\131\226\156\168\240\159\145\135 (Pumpkin magic here, please!)",
			"\240\159\142\131\226\156\168\226\157\147 (Pumpkin, can you use magic here?)",
			"\240\159\142\131\226\156\168 \226\157\151 (Pumpkin, use magic here!)",
			"\240\159\142\131\226\156\168\240\159\153\143 (Pumpkin, use your magic here, please.)",
			"\240\159\142\131\226\156\168\240\159\164\178\226\157\147 (Pumpkin, may you cast magic on me?)"
		}
	},
	["Thanks"] = {
		["Regular"] = {
			"\240\159\145\141\226\156\168 (Thank you, you\226\128\153re the best.)",
			"\240\159\146\170\226\157\151 (Thank you, you\226\128\153ve empowered me!)",
			"\240\159\153\143\240\159\145\143 (Much appreciated.)",
			"\240\159\153\135\226\157\163\239\184\143 (Thank you so very much!)",
			"\240\159\152\132\240\159\145\141 (Thank you, I appreciate it!)",
			"\240\159\152\129\240\159\145\141 (Many thanks, I appreciate the gesture!)"
		}
	}
}
v1.TextInteractions = v2
local v4 = {
	["Header"] = "STATS",
	["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\134\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v1.Health or 100) .. ("Regular Speed: %*\n"):format(v1.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v1.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain or 20)
}
local v5 = {
	["Image"] = "rbxassetid://135707604176757",
	["Header"] = "TRIPWIRE",
	["Quote"] = "\"\240\159\148\151\240\159\154\182\226\128\141\226\153\130\239\184\143\240\159\144\140\226\154\160\239\184\143\240\159\145\165\"",
	["Text"] = ("Cooldown: %*s\n"):format(v1.TripwireCooldown) .. "Taph places a tripwire on the ground in order to weaken the Killer and alert other Survivors about their presence.\n" .. ("When the killer walks over a tripwire, all survivors within %* studs of Taph have the killer\226\128\153s aura revealed for %* seconds and the killer gains slowness %* for %* seconds.\n"):format(v1.TripwireTriggerAuraRevealDistance, v1.TripwireTriggerAuraRevealDuration, v1.TripwireTriggerSlownessData.Level, v1.TripwireTriggerSlownessData.Duration) .. ("The tripwire has a total of %* health, and if the killer hits the tripwire, it will completely destroy it.\n"):format(v1.TripwireHealth) .. ("The tripwire slowly becomes less visible over the course of %* seconds after being placed.\n"):format(v1.TripwireLifetime) .. ("Tripwires cannot be placed within %* studs of each other.\n"):format(v1.TripwireDistanceBetweenTripwires) .. ("Taph can only have %* tripwires placed at once.\n"):format(v1.TripwireMaxAmount)
}
local v6 = {
	["Image"] = "rbxassetid://89334370123950",
	["Header"] = "SUBSPACE TRIPMINE",
	["Quote"] = "\"\240\159\145\129\226\128\141\240\159\151\168  \240\159\146\163\240\159\146\165\226\157\147\240\159\146\171"
}
local v7 = ("Cooldown: %*s\n"):format(v1.SubspaceTripmineCooldown)
local v8 = ("Taph throws a Subspace Tripmine infront of him, which detonates when the killer\226\128\153s within %* studs of it. It automatically detonates after %* seconds and slightly\n"):format(v1.SubspaceRange, v1.SubspaceExplosionDelay)
local v9 = v1.SubspaceLifetime / v1.SubspaceHintCount
v6.Text = v7 .. v8 .. ("Thrown mines reveal themselves every %* seconds.\n"):format((math.floor(v9))) .. ("When triggered, the Killer (and Taph if theyre close to the mine) is inflicted with Subspaced %* For %* seconds.\n"):format(v1.SubspaceEffectLevel, v1.SubspaceEffectDuration) .. "If the killer hits the mine prior to it detonating, the mine inflicts a lesser punishment.\n"
local v3 = {{
	["Separator"] = "GENERAL INFO"
}, {
	["Header"] = "TAPH",
	["Text"] = "A mute demolitionist who used to blow up & destroy the houses of terminated users at the will of Builderman.\nUses Tripwires and Subspace Tripmines to reveal the position of and disorientate the Killer.\n"
}, v4, {
	["Separator"] = "ABILITIES"
}, v5, v6}
v1.Information = v3
return v1
