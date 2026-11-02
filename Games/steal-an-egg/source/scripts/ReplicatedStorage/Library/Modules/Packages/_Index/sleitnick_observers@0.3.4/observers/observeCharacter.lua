-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local observePlayer = require(script.Parent.observePlayer)

return function(p1) --[[ observeCharacter | Line: 21 | Upvalues: observePlayer (copy) ]]
	return observePlayer(function(p12) --[[ Line: 22 | Upvalues: p1 (copy) ]]
		local v1 = nil
		local v2 = nil

		local function OnCharacterAdded(p13) --[[ OnCharacterAdded | Line: 27 | Upvalues: p1 (ref), p12 (copy), v2 (ref), v1 (ref) ]]
			local v12 = nil

			task.defer(function() --[[ Line: 31 | Upvalues: p1 (ref), p12 (ref), p13 (copy), v2 (ref), v12 (ref), v1 (ref) ]]
				local v13 = p1(p12, p13)

				if typeof(v13) ~= "function" then
					return
				end

				if v2.Connected and p13.Parent then
					v12 = v13
					v1 = v13

					return
				end

				task.spawn(v13)
			end)

			local v22 = nil

			v22 = p13.AncestryChanged:Connect(function(p1, p2) --[[ Line: 47 | Upvalues: v22 (ref), v12 (ref), v1 (ref) ]]
				if p2 ~= nil or not v22.Connected then
					return
				end

				v22:Disconnect()

				if v12 == nil then
					return
				end

				task.spawn(v12)

				if v1 == v12 then
					v1 = nil
				end

				v12 = nil
			end)
		end

		v2 = p12.CharacterAdded:Connect(OnCharacterAdded)
		task.defer(function() --[[ Line: 65 | Upvalues: p12 (copy), v2 (ref), OnCharacterAdded (copy) ]]
			if not (p12.Character and v2.Connected) then
				return
			end

			task.spawn(OnCharacterAdded, p12.Character)
		end)

		return function() --[[ Line: 72 | Upvalues: v2 (ref), v1 (ref) ]]
			v2:Disconnect()

			if v1 == nil then
				return
			end

			task.spawn(v1)
			v1 = nil
		end
	end)
end