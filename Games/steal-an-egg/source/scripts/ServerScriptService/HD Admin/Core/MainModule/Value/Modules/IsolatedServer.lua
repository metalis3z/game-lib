--!strict

--[[

	This puts the server into an 'isolated' state. This means that everything behaves as 
	normal within the server (perm bans, role edits, global commands, settings) but nothing
	is saved or broadcast to other servers. DataStore reads still still work as normal
	however so we continue to work with the live/correct data.

	We use this for example in the HD Admin hub so that users can test HD Admin in full with
	an Owner role, without the risk of them breaking the application for future visitors:
	https://www.roblox.com/games/106966695720565/HD-Admin-Hub

--]]


-- LOCAL
local IsolatedServer = {}
local isolated = false
local callbacks: {() -> ()} = {}


-- FUNCTIONS
function IsolatedServer.isIsolated(): boolean
	return isolated
end

function IsolatedServer.onIsolate(callback: () -> ()): () -> ()
	if isolated then
		task.spawn(callback)
		return function() end
	end
	table.insert(callbacks, callback)
	return function()
		local index = table.find(callbacks, callback)
		if index then
			table.remove(callbacks, index)
		end
	end
end

function IsolatedServer.isolate()
	if isolated then
		return
	end
	isolated = true
	print("HD Admin: this server is now isolated. Changes made here behave as normal but won't save or broadcast beyond this server")
	local toRun = callbacks
	callbacks = {}
	for _, callback in toRun do
		task.spawn(callback)
	end
end

function IsolatedServer._resetForTesting()
	isolated = false
	callbacks = {}
end


return IsolatedServer
