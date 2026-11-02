-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	TARGET_RADIUS = 300,
	DELETE_COUNT_BUFFER = 50,
	DELETE_COUNT_BUFFER_FAST = 75,
	INSERT_DELETE_COUNT_BUFFER = 550,
	CREATE_INSTANCE_COUNT_BUFFER = 550,
	STREAM_DIR_STACKING_WEIGHT_BUFFER = 950,
	STREAM_DIR_REPLICATION_WEIGHT_BUFFER = 950
}
local v1 = t.TARGET_RADIUS * 2.4
local t2 = {
	Star = {
		NormalMode = v1 * 2
	},
	Default = {
		NormalMode = v1
	}
}

t2.Star.PerfMode = t2.Star.NormalMode
t2.Default.PerfMode = v1 * 0.85
t.COLLECTABLES_RANGE_BY_TYPE = t2

return t