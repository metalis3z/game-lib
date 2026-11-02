-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Ghost",
	["Description"] = "\"Target nearby!\"",
	["RenderImage"] = "rbxassetid://91329905838185",
	["Price"] = 700,
	--["Exclusive"] = true,
	["CollabInfo"] = "Isle",
	["LifeAppearances"] = { script.Life1, script.Life2 },
	["DaggerTemplate"] = script.GhostFire,
	["Sounds"] = {
		["Crouch"] = "rbxassetid://93315212708186",
		["Stand"] = "rbxassetid://112995614541035",
		["Mark"] = "rbxassetid://126819325465497",
		["Hit"] = "rbxassetid://135436314",
		["Stab"] = "rbxassetid://144352131",
		["CrouchStab"] = "rbxassetid://144352131",
		["Respawn"] = "rbxassetid://84260460113659"
	}
}
local v2 = {
	["Requests"] = {
		["ElliotPizza"] = {
			"I\226\128\153m hit!",
			"Target Elliot sp\226\128\148I mean I need a pizza!",
			"I need a.. pizza?",
			"Healing spra\226\128\148pizza needed here!"
		},
		["BuildermanSentry"] = {
			"Deploy a sentry, now!",
			"Sentry in position?",
			"Sentry in place?",
			"Sentry needed, proceed.",
			"Place a sentry!"
		},
		["BuildermanDispenser"] = {
			"Squad needs a dispenser.",
			"Dispenser here!",
			"Dispenser needed!",
			"Set up a dispenser!",
			"I\226\128\153m hit! I need a dispenser!"
		},
		["DusekkarProtection"] = {
			"A magical ball? I need that!",
			"Usually, going invisible works wonders. But that magic can help too!",
			"Does your forcefield work like a shield pack?",
			"I need a shield pa\226\128\148I mean, a forcefield! Do you copy?"
		}
	},
	["Thanks"] = {
		["Regular"] = {
			"Thank you so much!",
			"B-Corp pays well, maybe you should apply?",
			"Greatly appreciated!",
			"Another mercenary wouldn\226\128\153t hurt. If you\226\128\153re interested?",
			"Thanks!",
			"Thanks a lot!"
		}
	}
}
v1.TextInteractions = v2
local v3 = {
	{
		["Happy"] = "rbxassetid://99032539738754",
		["Default"] = "rbxassetid://123104451423331",
		["Hurt"] = "rbxassetid://80711265605264",
		["Injured"] = "rbxassetid://107209215540430",
		["Dead"] = "rbxassetid://137606928028304",
		["Drinking"] = "rbxassetid://134326058725954"
	},
	{
		["Happy"] = "rbxassetid://99032539738754",
		["Default"] = "rbxassetid://124076971348826",
		["Hurt"] = "rbxassetid://70844561476541",
		["Injured"] = "rbxassetid://134327241273091",
		["Dead"] = "rbxassetid://74762201102614",
		["Drinking"] = "rbxassetid://129623625608297"
	}
}
v1.ExpressionsTable = v3
v1.Expressions = v1.ExpressionsTable[1]
return v1
