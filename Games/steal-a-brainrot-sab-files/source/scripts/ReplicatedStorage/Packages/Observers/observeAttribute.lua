
local function defaultGuard(_)
	return true
end
local function observeAttribute(p2, s1: string, p3: ((...any) -> ...any), p4: ((...any) -> ...any)?)
	local u8 = nil
	local connection = nil
	local n1 = 0
	local v11 = if p4 == nil then defaultGuard else p4

	local function OnAttributeChanged()
		if u8 ~= nil then
			task.spawn(u8)
			u8 = nil
		end

		n1 += 1

		local v13 = n1
		local s1_2 = p2:GetAttribute(s1)

		if s1_2 ~= nil and v11(s1_2) then
			task.spawn(function()
				local v15 = p3(s1_2)

				if typeof(v15) == "function" then
					if v13 == n1 and connection.Connected then
						u8 = v15

						return
					end

					task.spawn(v15)
				end
			end)
		end
	end

	connection = p2:GetAttributeChangedSignal(s1):Connect(OnAttributeChanged)
	task.defer(function()
		if not connection.Connected then
			return
		end

		OnAttributeChanged()
	end)

	return function()
		connection:Disconnect()

		if u8 ~= nil then
			task.spawn(u8)
			u8 = nil
		end
	end
end

return observeAttribute
