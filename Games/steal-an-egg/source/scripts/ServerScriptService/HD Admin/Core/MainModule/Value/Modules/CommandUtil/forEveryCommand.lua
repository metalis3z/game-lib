-- A command module can return a single command table, OR an array of command tables
-- Arrays can also nest other arrays (like the getInternalCommands splices
-- inside the Internal command modules) so any table without a name is walked
-- into instead of skipped
return function(moduleReference, callback)
	local function checkIfCommand(command)
		if typeof(command.name) == "string" and typeof(command.run) == "function" then
			callback(command)
		end
	end
	local function walk(reference)
		if typeof(reference) ~= "table" then
			return
		end
		if #reference > 0 then
			for _, entry in reference do
				if typeof(entry) == "table" and entry.name == nil then
					walk(entry)
				else
					checkIfCommand(entry)
				end
			end
			return
		end
		checkIfCommand(reference)
	end
	walk(moduleReference)
end
