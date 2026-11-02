--!strict

-- An internal role is one that is hidden from in-game lists, locked against
-- in-game edits, never inherited by senior roles, and pinned to the lowest rank
local function isInternalRole(role: any): boolean
	return typeof(role) == "table" and (role :: any).internal == true
end

return isInternalRole
