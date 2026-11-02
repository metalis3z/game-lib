--!strict
-- The booster command pack registers each command's asset here as it builds them
-- The /commands popup reads it to build thumbnails
local BoosterDisplay = {}
local items: {[string]: {kind: string, id: number}} = {}

function BoosterDisplay.register(commandKey: string, kind: string, id: number)
	items[commandKey] = {kind = kind, id = id}
end

function BoosterDisplay.getAll(): {[string]: {kind: string, id: number}}
	return items
end

return BoosterDisplay
