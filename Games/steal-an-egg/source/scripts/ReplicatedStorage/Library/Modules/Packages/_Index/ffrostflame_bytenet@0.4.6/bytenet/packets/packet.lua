-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

require(script.Parent.Parent.types)

local client = require(script.Parent.Parent.process.client)
local server = require(script.Parent.Parent.process.server)
local v1 = if RunService:IsServer() then "server" else "client"

return function(p1, p2) --[[ Line: 16 | Upvalues: server (copy), client (copy), v1 (copy), Players (copy) ]]
	local v12 = p1.reliabilityType or "reliable"
	local t = {}
	local v2 = if v12 == "reliable" then server.sendPlayerReliable else server.sendPlayerUnreliable
	local v3 = if v12 == "reliable" then server.sendAllReliable else server.sendAllUnreliable
	local v4 = if v12 == "reliable" then client.sendReliable else client.sendUnreliable
	local write = p1.value.write
	local t2 = {}
	local t3 = {
		__index = function(p1) --[[ __index | Line: 43 | Upvalues: v1 (ref) ]]
			if (p1 == "sendTo" or (p1 == "sendToAllExcept" or p1 == "sendToAll")) and v1 == "client" then
				error("You cannot use sendTo, sendToAllExcept, or sendToAll on the client")
			end

			if p1 ~= "send" or v1 ~= "server" then
				return
			end

			error("You cannot use send on the server")
		end
	}

	setmetatable(t2, t3)
	t2.reader = p1.value.read

	if v1 == "server" then
		function t2.sendToList(p1, p22) --[[ sendToList | Line: 59 | Upvalues: v2 (copy), p2 (copy), write (copy) ]]
			for v1, v22 in p22 do
				v2(v22, p2, write, p1)
			end
		end
		function t2.sendTo(p1, p22) --[[ sendTo | Line: 65 | Upvalues: v2 (copy), p2 (copy), write (copy) ]]
			v2(p22, p2, write, p1)
		end
		function t2.sendToAllExcept(p1, p22) --[[ sendToAllExcept | Line: 69 | Upvalues: Players (ref), v2 (copy), p2 (copy), write (copy) ]]
			for v1, v22 in Players:GetPlayers() do
				if v22 ~= p22 then
					v2(v22, p2, write, p1)
				end
			end
		end
		function t2.sendToAll(p1) --[[ sendToAll | Line: 77 | Upvalues: v3 (copy), p2 (copy), write (copy) ]]
			v3(p2, write, p1)
		end
	elseif v1 == "client" then
		function t2.send(p1) --[[ send | Line: 81 | Upvalues: v4 (copy), p2 (copy), write (copy) ]]
			v4(p2, write, p1)
		end
	end

	function t2.wait() --[[ wait | Line: 86 | Upvalues: t (copy) ]]
		local v1 = nil
		local v2 = coroutine.running()
		local v3 = t

		local function f4(p1, p2) --[[ Line: 91 | Upvalues: v2 (copy), t (ref), v1 (ref) ]]
			task.spawn(v2, p1, p2)
			table.remove(t, v1)
		end

		table.insert(v3, f4)
		v1 = #t

		return coroutine.yield()
	end
	function t2.listen(p1) --[[ listen | Line: 105 | Upvalues: t (copy) ]]
		table.insert(t, p1)
	end
	function t2.getListeners() --[[ getListeners | Line: 109 | Upvalues: t (copy) ]]
		return t
	end

	return t2
end