-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = Vector2.new(0, -1)
local v2 = Vector2.new(0, 1)
local v3 = Vector2.new(-1, 0)
local v4 = Vector2.new(1, 0)
local v5 = Enum.KeyCode
local v6 = Enum.SwipeDirection
local v7 = {
	["Keycodes"] = {
		[v5.W] = v1,
		[v5.Up] = v1,
		[v5.DPadUp] = v1,
		[v5.S] = v2,
		[v5.Down] = v2,
		[v5.DPadDown] = v2,
		[v5.A] = v3,
		[v5.Left] = v3,
		[v5.DPadLeft] = v3,
		[v5.D] = v4,
		[v5.Right] = v4,
		[v5.DPadRight] = v4
	},
	["Gestures"] = {
		[v6.Up] = v1,
		[v6.Down] = v2,
		[v6.Left] = v3,
		[v6.Right] = v4
	}
}
return v7