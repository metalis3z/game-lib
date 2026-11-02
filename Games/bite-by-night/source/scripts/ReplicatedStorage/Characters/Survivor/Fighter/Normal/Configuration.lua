-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Speed"] = 12,
	["RunSpeed"] = 24,
	["Stamina"] = 100,
	["Regen"] = 20,
	["Health"] = 100,
	["Dodges"] = 0,
	["SlowStop"] = true,
	["SwingStun"] = 3,
	["ParryStun"] = 2,
	["SwingSpeed"] = 16,
	["Damage"] = {
		["Swing"] = 75
	}
}
local v2 = {
	["Swing"] = {
		["Size"] = Vector3.new(8, 8, 8),
		["CFrame"] = CFrame.new(0, 0, -4)
	}
}
v1.Hitbox = v2
return v1