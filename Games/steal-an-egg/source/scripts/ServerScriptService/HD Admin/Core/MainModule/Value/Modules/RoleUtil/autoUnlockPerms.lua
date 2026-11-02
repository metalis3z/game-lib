--!strict

-- Holding any of these on a real role marks someone as game staff, which silently
-- unlocks the internal Booster role and every products-gated command arg
local autoUnlockPerms = {
	"mayEditAll",
	"mayEditRoles",
	"mayEditSettingsGame",
}

return autoUnlockPerms
