
local CollectionService = game:GetService("CollectionService")

function observeTagNoAncestry(s1: string, p1: ((...any) -> ...any))
	local t1 = {}
	local connection = nil

	local function OnInstanceAdded(p2)
		if not connection.Connected then
			return
		end

		task.defer(function()
			local ok, result = xpcall(function(p3)
				local v22 = p1(p3)

				assert(typeof(v22) == "nil" or typeof(v22) == "function", "callback must return a function")

				return v22
			end, debug.traceback, p2)

			if not ok then
				local s2 = ""
				local v19 = string.split(result, "\n")[1]
				local v20 = string.find(v19, ": ")

				if v20 then
					s2 = v19:sub(v20 + 1)
				end

				warn(`error while calling observeTag("{ s1 }") callback:{ s2 }\n{ result }`)

				return
			end

			if type(result) == "function" then
				if not p2:HasTag(s1) then
					task.spawn(result)

					return
				end

				t1[p2] = result
			end
		end)
	end
	local function OnInstanceRemoved(p4)
		local v11 = t1[p4]

		if typeof(v11) == "function" then
			task.spawn(v11)
		end
	end

	connection = CollectionService:GetInstanceAddedSignal(s1):Connect(OnInstanceAdded)

	local connection2 = CollectionService:GetInstanceRemovedSignal(s1):Connect(OnInstanceRemoved)

	task.defer(function()
		if not connection.Connected then
			return
		end

		for _, v13 in CollectionService:GetTagged(s1) do
			task.spawn(OnInstanceAdded, v13)
		end
	end)

	return function()
		connection:Disconnect()
		connection2:Disconnect()

		local v14 = next(t1)

		while v14 do
			local v15 = t1[v14]

			if typeof(v15) == "function" then
				task.spawn(v15)
			end

			v14 = next(t1)
		end
	end
end

return observeTagNoAncestry
