-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Philosopher",
	["Description"] = "There are more things in heaven and earth, Cogitatilux, than are dreamt of in your philosophy.",
	["RenderImage"] = "rbxassetid://74126031603824",
	["Price"] = 1500,
	--["Exclusive"] = true,
	["CollabInfo"] = "Postmortem",
	["VFX"] = script.TwoTimeVFX,
	["LifeAppearances"] = { script.Life1, script.Life2 },
	["Animations"] = {
		["Idle"] = "rbxassetid://109726216891911",
		["Walk"] = "rbxassetid://119512617860501",
		["Run"] = "rbxassetid://125390348864711",
		["InjuredIdle"] = "rbxassetid://119982449416734",
		["InjuredWalk"] = "rbxassetid://93664170147379",
		["InjuredRun"] = "rbxassetid://80218363745446",
		["CrouchStart"] = "rbxassetid://116645650560701",
		["CrouchIdle"] = "rbxassetid://100002065844728",
		["CrouchWalk"] = "rbxassetid://83238824639069",
		["CrouchRun"] = "rbxassetid://81891708346661",
		["Stab"] = "rbxassetid://92940400416755",
		["LungeStart"] = "rbxassetid://131518979338582",
		["LungeLoop"] = "rbxassetid://118770423129095",
		["LungeEnd"] = "rbxassetid://92197319272382",
		["Ritual"] = "rbxassetid://109329029272650"
	},
	["Sounds"] = {
		["Respawn"] = "rbxassetid://132924459951404"
	},
	["VoicelineVolume"] = 1.5,
	["Voicelines"] = {
		["Died"] = { "rbxassetid://85991151219748" }
	}
}
local v2 = {
	{
		["Happy"] = "",
		["Default"] = "",
		["Hurt"] = "",
		["Injured"] = "",
		["Dead"] = "",
		["Drinking"] = ""
	},
	{
		["Happy"] = "",
		["Default"] = "",
		["Hurt"] = "",
		["Injured"] = "",
		["Dead"] = "",
		["Drinking"] = ""
	}
}
v1.ExpressionsTable = v2
local v3 = {
	["Requests"] = {
		["ElliotPizza"] = { "My body requires sustenance before my mind can wander abroad.", "Share me your discoveries.", "Allow me to experiment your folk\'s gastronomy." },
		["BuildermanSentry"] = { "We require a method to maintain that threat at a distance.", "Weaponize your knowledge.", "Knowledge is power." },
		["BuildermanDispenser"] = { "Bless me with your fountain of health.", "Display me your benevolence.", "You shall grant us vigor." },
		["DusekkarProtection"] = {
			"I insist for thy blessing.",
			"Enlighten me.",
			"One must first commit to helping their fellow individuals before they can reach true enlightenment.",
			"Show me your thesis."
		}
	},
	["Thanks"] = {
		["Regular"] = {
			"Here\'s to knowledge!",
			"Much obliged.",
			"I stand in recognition.",
			"You are a kind soul."
		}
	}
}
v1.TextInteractions = v3
return v1
