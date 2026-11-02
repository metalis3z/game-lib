-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Speed"] = 12,
	["RunSpeed"] = 24,
	["Stamina"] = 100,
	["Regen"] = 20,
	["Health"] = 90,
	["Dodges"] = 0,
	["SlowStop"] = true,
	["Heal"] = 5,
	["Rate"] = 2,
	["SelfHeal"] = 5,
	["SelfHealRate"] = 1
}
local v2 = {
	["Stab"] = {
		["Size"] = Vector3.new(4, 6, 4),
		["CFrame"] = CFrame.new(0, 0, -2)
	},
	["Swing"] = {
		["Size"] = Vector3.new(3, 3, 4),
		["CFrame"] = CFrame.new(0, 0, -2)
	}
}
v1.Hitbox = v2
return v1