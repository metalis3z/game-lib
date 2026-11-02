
local function observeProperty(p1, s1: string, p2: ((...any) -> ...any))
	local u5 = nil
	local connection = nil
	local n1 = 0

	local function OnPropertyChanged()
		if u5 ~= nil then
			task.spawn(u5)
			u5 = nil
		end

		n1 += 1

		local v9 = n1
		local v10 = p1[s1]

		task.spawn(function()
			local v13 = p2(v10)

			if v9 == n1 and connection.Connected then
				u5 = v13

				return
			end

			if v13 then
				task.spawn(v13)
			end
		end)
	end

	connection = p1:GetPropertyChangedSignal(s1):Connect(OnPropertyChanged)
	task.defer(function()
		if not connection.Connected then
			return
		end

		if u5 ~= nil then
			task.spawn(u5)
			u5 = nil
		end

		n1 += 1

		local v11 = n1
		local v12 = p1[s1]

		task.spawn(function()
			local v14 = p2(v12)

			if v11 == n1 and connection.Connected then
				u5 = v14

				return
			end

			if v14 then
				task.spawn(v14)
			end
		end)
	end)

	return function()
		connection:Disconnect()

		if u5 ~= nil then
			task.spawn(u5)
			u5 = nil
		end
	end
end

return observeProperty
