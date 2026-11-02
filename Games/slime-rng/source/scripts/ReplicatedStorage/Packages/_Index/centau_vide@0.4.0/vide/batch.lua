-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: batch, time of decompilation: Sun May  3 10:09:37 2026 ]]
local flags = require("./flags")
local graph = require("./graph")

return function(p1: ((...any) -> ...any)) --[[ batch ]] -- line: 4
	-- upvalues: flags (copy), graph (copy)
	local batch = flags.batch
	local v5 = nil

	if not batch then
		flags.batch = true
		v5 = graph.get_update_queue_length()
	end

	local ok, result = xpcall(p1, debug.traceback)

	if not batch then
		flags.batch = false
		graph.flush_update_queue(v5)
	end

	if not ok then
		error(`error occured while batching updates: { result }`, 0)
	end
end
