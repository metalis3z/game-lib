-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	BATCH_DELAY = 0.3,
	RETRY_DELAY = 0.5,
	RETRY_THRESHOLD = 3,
	PRELOAD_TIMEOUT = 150,
	INNER_SMEAR_THRESHOLD = 15,
	GLOBAL_COUNTER_THRESHOLD = 50,
	AVERAGE_TIME_PER_ITEM = 60
}

t.BATCH_THRESHOLD = if require(game:GetService("ReplicatedStorage").Library.Globals.Constants).IS_MOBILE then 25 else 35

return t