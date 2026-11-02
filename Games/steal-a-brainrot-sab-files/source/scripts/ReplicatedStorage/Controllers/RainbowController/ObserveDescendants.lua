

function observeDescendants(p1, p2: ((...any) -> ...any))
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
		if not connection or not connection.Connected then
			return
		end

		t1[p4] = p2(p4)
	end

	connection = p1.DescendantAdded:Connect(OnInstanceAdded)

	local connection2 = p1.DescendantRemoving:Connect(OnInstanceRemoved)

	task.defer(function()
		if not connection or not connection.Connected then
			return
		end

		for _, descendant in p1:GetDescendants() do
			task.spawn(OnInstanceAdded, descendant)
		end

		local v13 = p1

		if connection then
			if not connection.Connected then
				return
			end

			t1[v13] = p2(v13)
		end
	end)

	return function(p5)
		if p5 == nil then
			if connection then
				connection:Disconnect()
			end

			if connection2 then
				connection2:Disconnect()
			end

			local v15 = next(t1)

			while v15 do
				local v16 = t1[v15]

				t1[v15] = nil

				if typeof(v16) == "function" then
					task.spawn(v16)
				end

				v15 = next(t1)
			end
		else
			if p5 == true then
				if connection or connection2 then
					return
				end

				connection = p1.DescendantAdded:Connect(OnInstanceAdded)
				connection2 = p1.DescendantRemoving:Connect(OnInstanceRemoved)

				return
			end

			if p5 == false then
				if connection then
					connection:Disconnect()
					connection = nil
				end

				if connection2 then
					connection2:Disconnect()
					connection2 = nil
				end
			end
		end
	end
end

return observeDescendants
