
function observeChildren(p1, p2: ((...any) -> ...any))
	local t1 = {}
	local connection = nil

	local function OnInstanceRemoved(p3)
		local v9 = t1[p3]

		t1[p3] = nil

		if typeof(v9) == "function" then
			task.spawn(v9)
		end
	end
	local function OnInstanceAdded(p4)
		if not connection.Connected then
			return
		end

		t1[p4] = p2(p4)
	end

	connection = p1.DescendantAdded:Connect(OnInstanceAdded)

	local connection2 = p1.DescendantRemoving:Connect(OnInstanceRemoved)

	task.defer(function()
		if not connection.Connected then
			return
		end

		for _, descendant in p1:GetDescendants() do
			task.spawn(OnInstanceAdded, descendant)
		end
	end)

	return function()
		connection:Disconnect()
		connection2:Disconnect()

		local v13 = next(t1)

		while v13 do
			local v14 = t1[v13]

			t1[v13] = nil

			if typeof(v14) == "function" then
				task.spawn(v14)
			end

			v13 = next(t1)
		end
	end
end

return observeChildren
