-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["FORCE_NEXT_MAP"] = function()
		return workspace:GetAttribute("MapNames") or "ClickThe|DropdownAgain|Please"
	end,
	["SET_CHARACTER_LEVEL"] = function()
		local v1 = {}
		for _, v2 in pairs({ game.ReplicatedStorage.Assets.Killers, game.ReplicatedStorage.Assets.Survivors }) do
			for _, v3 in pairs(v2:GetChildren()) do
				local v4 = ("%*/%*"):format(v2.Name, v3.Name)
				table.insert(v1, v4)
			end
		end
		return table.concat(v1, "|")
	end,
	["GIVE_STATUS"] = function()
		local v_u_5 = {}
		local function v_u_10(p6)
			-- upvalues: (copy) v_u_10, (copy) v_u_5
			if p6:IsA("Folder") then
				for _, v7 in pairs(p6:GetChildren()) do
					v_u_10(v7)
				end
			else
				local v8 = v_u_5
				local v9 = p6.Name
				table.insert(v8, v9)
			end
		end
		v_u_10(game.ReplicatedStorage.Modules.StatusEffects)
		return table.concat(v_u_5, "|")
	end,
	["GIVE_ITEM"] = function()
		local v11 = {}
		for _, v12 in pairs(game.ReplicatedStorage.Assets.Items:GetChildren()) do
			local v13 = v12.Name
			table.insert(v11, v13)
		end
		return table.concat(v11, "|")
	end,
	["FORCE_NEXT_GAMEMODE"] = function()
		local v14 = {}
		for _, v15 in pairs(game.ReplicatedStorage.Modules.Gamemodes:GetChildren()) do
			local v16 = v15.Name
			table.insert(v14, v16)
		end
		return table.concat(v14, "|")
	end
}
