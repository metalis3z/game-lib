-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Tazuna",
	["Description"] = "Believe in yourself. I\'ll always follow ya.",
	["RenderImage"] = "rbxassetid://131727846863434",
	["Price"] = 1000,
	["LifeAppearances"] = { script.Life1, script.Life2 }
}
local v2 = {
	[2] = {
		["Happy"] = "rbxassetid://78810407123215",
		["Default"] = "rbxassetid://78810407123215",
		["Hurt"] = "rbxassetid://78810407123215",
		["Injured"] = "rbxassetid://78810407123215",
		["Dead"] = "rbxassetid://78810407123215",
		["Drinking"] = "rbxassetid://78810407123215"
	}
}
v1.ExpressionsTable = v2
local v3 = {
	["Requests"] = {
		["ElliotPizza"] = {
			"Hey - you\'re doing good work out here! Spare me a slice?",
			"Pizza is so delicious. I want some right now. Got anything?",
			"We finally have some pizza - any left for me?",
			"Is that the ROBLOX visor? It looks good on you! Could I get some stuff?",
			"Nice - a pizza would go great with your outfit!"
		},
		["BuildermanSentry"] = {
			"You know the drill by now. Put a sentry here?",
			"We should get a sentry out for these guys. Dangerous out here.",
			"A sentry here would be good right now. What do you think?",
			"I would love a sentry right here.",
			"A sentry here is obviously a great idea! I\'m surprised you haven\'t built it yet\226\128\166"
		},
		["BuildermanDispenser"] = {
			"I think everyone would enjoy a dispenser right here. What do you think?",
			"Lots of potential in a dispenser here. What do you guys think?",
			"Hey there- would you put a dispenser here?",
			"I\'d like a dispenser right now!",
			"I totally want a dispenser here."
		},
		["DusekkarProtection"] = {
			"Your forcefield - it\'s like magic! Cast one on me?",
			"Your magic - it\'s like Invisible Woman! You\'d be a real hero if you could give me a forcefield!",
			"Hey there - can I trouble you for a forcefield?",
			"I love the staff! A forcefield would look great with it.",
			"A forcefield would be good right now. What do you think?"
		}
	},
	["Thanks"] = {
		["Regular"] = {
			"I love it, thanks!",
			"Good stuff.",
			"w00t - you\'re the best!",
			"Nice work! I think I\'ve got what I need now.",
			"Thanks! :)"
		}
	}
}
v1.TextInteractions = v3
return v1
