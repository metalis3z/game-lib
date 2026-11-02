-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Client = game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client")
local FFlags = require(Client.FFlags)

return {
	BottomOverlays = function(p1, p2, p3) --[[ BottomOverlays | Line: 11 | Upvalues: FFlags (copy) ]]
		local v1 = if p3 then p3 else {}
		local v2 = false

		if v1.Hot then
			if not v2 then
				table.insert(p1, { "Div" })
				v2 = true
			end

			table.insert(p1, { "Hot" })
		end

		if not v1.HideExists then
			local v3 = if v1.ForceExists == true then true elseif p2.Class.Name == "Skin" then true else false
			local v4 = if v1.ShowExists == true then true else v3

			if not v3 then
				if not FFlags.Get(FFlags.Keys.ExistCount) then
					v4 = false
				end

				if not FFlags.Get(FFlags.Keys.ExistCountOverlay) then
					v4 = false
				end
			end

			if v4 then
				local v5 = p2:GetExistCount()

				if v5 > 0 then
					if not v2 then
						table.insert(p1, { "Div" })
						v2 = true
					end

					table.insert(p1, { "Exists", v5 })
				end
			end
		end

		if not v1.HideRAP then
			local _2 = p2:IsRAPVisible()

			if not FFlags.Get(FFlags.Keys.RAP) then
				_2 = false
			end

			if not FFlags.Get(FFlags.Keys.RAPOverlay) then
				_2 = false
			end
		end

		if v1.ShowDeal then
			if not v2 then
				table.insert(p1, { "Div" })
				v2 = true
			end

			table.insert(p1, { "Deal", v1.ShowDeal })
		end

		local Mailbox = v1.Mailbox

		if not Mailbox then
			return v2
		end

		local v6, v7, v8 = unpack(Mailbox)

		table.insert(p1, { "Div" })
		table.insert(p1, { "MessageDark", v6 })
		table.insert(p1, { "Message", v7 })
		table.insert(p1, { "Nickname", v8 })

		return v2
	end
}