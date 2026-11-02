--!strict

--[[
 
	This is a helper for the cmdbar history. The server records each accepted
	bar command into perm.RecentCommands where we bring that stored value back
	into an ordered list and into recall rows

]]


-- CONFIG 
local MAX_SHOWN = 8


-- LOCAL
local Recents = {}


-- TYPES
export type RecentRow = {
	keys: { string },
	text: string,
	display: string,
	kind: string,
	recency: number,
}


-- FUNCTIONS
function Recents.toList(raw: any): { string }
	if typeof(raw) ~= "table" then
		return {}
	end
	local indexed: { { order: number, message: string } } = {}
	for key, value in raw :: { [any]: any } do
		if typeof(value) == "string" then
			local order = if typeof(key) == "number" then key else tonumber(key) or math.huge
			table.insert(indexed, { order = order, message = value })
		end
	end
	table.sort(indexed, function(left, right)
		return left.order < right.order
	end)
	local out = {}
	for _, entry in indexed do
		table.insert(out, entry.message)
	end
	return out
end

function Recents.rows(raw: any): { RecentRow }
	local list = Recents.toList(raw)
	local rows: { RecentRow } = {}
	for index, message in list do
		if index > MAX_SHOWN then
			break
		end
		table.insert(rows, {
			keys = { message },
			text = message,
			display = message,
			kind = "recent",
			recency = #list - index,
		})
	end
	return rows
end


return Recents
