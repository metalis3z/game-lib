
local function observeCharacter(p1, p2: ((...any) -> ...any))
	local u4 = nil
	local connection = nil

	local function OnCharacterAdded(p3)
		local u8 = nil

		task.defer(function()
			local v10 = p2(p1, p3)

			if typeof(v10) == "function" then
				if connection.Connected and p3.Parent then
					u8 = v10
					u4 = v10

					return
				end

				task.spawn(v10)
			end
		end)

		local connection2 = nil

		connection2 = p3.AncestryChanged:Connect(function(_, parent)
			if parent == nil and connection2.Connected then
				connection2:Disconnect()

				if u8 ~= nil then
					task.spawn(u8)

					if u4 == u8 then
						u4 = nil
					end

					u8 = nil
				end
			end
		end)
	end

	connection = p1.CharacterAdded:Connect(OnCharacterAdded)
	task.defer(function()
		if p1.Character and connection.Connected then
			task.spawn(OnCharacterAdded, p1.Character)
		end
	end)

	return function()
		connection:Disconnect()

		if u4 ~= nil then
			task.spawn(u4)
			u4 = nil
		end
	end
end

return observeCharacter
