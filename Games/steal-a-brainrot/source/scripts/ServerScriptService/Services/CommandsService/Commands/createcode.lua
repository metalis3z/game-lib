--[[ [ file made by Mohamed ]]
local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local CodeService = require(ServerScriptService.Services.CodeService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)

	-- ========================
	-- /createcode <CodeName> <BrainrotName> <Amount> [LimitedUses]
	-- ========================
	Conch.register("createcode", {
		permissions = { Config.RequiredRole or "super-user" },

		description = "Create a redeemable code. Usage: /createcode CODENAME BrainrotName Amount [LimitedUses]",

		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "CodeName",
				},
				{
					kind = "argument",
					type = "string",
					name = "Brainrot",
				},
				{
					kind = "argument",
					type = "number",
					name = "Amount",
				},
				{
					kind = "argument",
					type = "number",
					name = "LimitedUses",
					optional = true,
				}
		end,

		callback = function(codeName, brainrotName, amount, limitedUses)
			if not codeName or codeName == "" then
				return false, "You must provide a code name!"
			end

			codeName = string.upper(codeName)

			if not brainrotName or brainrotName == "" then
				return false, "You must provide a brainrot name!"
			end

			-- Case-insensitive brainrot lookup
			local resolvedName
			local normalizedInput = string.lower(tostring(brainrotName))
			for animalName, animalData in pairs(AnimalsData) do
				if string.lower(tostring(animalName)) == normalizedInput then
					resolvedName = animalName
					break
				end
				if typeof(animalData) == "table" then
					if string.lower(tostring(animalData.Name or "")) == normalizedInput
						or string.lower(tostring(animalData.DisplayName or "")) == normalizedInput then
						resolvedName = animalName
						break
					end
				end
			end
			if not resolvedName then
				return false, "Brainrot '" .. tostring(brainrotName) .. "' not found in Animals data!"
			end
			brainrotName = resolvedName

			amount = tonumber(amount) or 1
			if amount < 1 then
				return false, "Amount must be at least 1."
			end

			if limitedUses ~= nil then
				limitedUses = tonumber(limitedUses)
				if not limitedUses or limitedUses < 1 then
					return false, "Limited uses must be a number >= 1."
				end
			end

			local rewardData = {
				Name = brainrotName,
				Amount = amount,
				Message = "You received " .. (amount > 1 and (amount .. "x ") or "a ") .. brainrotName .. "!",
				Mutations = { Normal = 35, Gold = 30, Diamond = 15, Rainbow = 3 },
			}

			if limitedUses then
				rewardData.Limited = limitedUses
				rewardData.Message = "You received " .. (amount > 1 and (amount .. "x ") or "a ") .. brainrotName .. "! (Limited: " .. limitedUses .. " uses)"
			end

			-- Register the code via CodeService.AddCustomCode
			local success, result = CodeService.AddCustomCode(codeName, "Brainrot", rewardData)
			if not success then
				return false, result
			end

			local msg = "Code '" .. codeName .. "' created! Reward: " .. amount .. "x " .. brainrotName
			if limitedUses then
				msg = msg .. " (Limited: " .. limitedUses .. " uses)"
			end
			return msg
		end,
	})

	-- ========================
	-- /deletecode <CodeName>
	-- ========================
	Conch.register("deletecode", {
		permissions = { Config.RequiredRole or "super-user" },

		description = "Delete a redeemable code.",

		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "CodeName",
				}
		end,

		callback = function(codeName)
			if not codeName or codeName == "" then
				return false, "You must provide a code name!"
			end

			codeName = string.upper(codeName)

			local success, err = CodeService.RemoveCode(codeName)
			if not success then
				return false, err
			end

			return "Code '" .. codeName .. "' has been deleted!"
		end,
	})

	-- ========================
	-- /listcodes
	-- ========================
	Conch.register("listcodes", {
		permissions = { Config.RequiredRole or "super-user" },

		description = "List all active redeem codes.",

		arguments = function()
			return
		end,

		callback = function()
			local codes = CodeService.GetCodesTable()
			if not codes or next(codes) == nil then
				return "No active codes found."
			end

			local lines = {"Active Codes:"}
			for codeName, data in pairs(codes) do
				local line
				if data.Reward == "Coins" then
					line = "  " .. codeName .. " -> " .. (data.Amount or 0) .. " Coins"
				elseif data.Reward == "Brainrot" then
					line = "  " .. codeName .. " -> " .. (data.Name or "?")
				elseif data.Reward == "LuckyBlock" then
					line = "  " .. codeName .. " -> " .. (data.Name or "?")
				else
					line = "  " .. codeName .. " -> " .. (data.Reward or "?")
				end
				if data.Limited then
					line = line .. " (Limited: " .. data.Limited .. ")"
				end
				table.insert(lines, line)
			end

			table.sort(lines, function(a, b) return a < b end)
			return table.concat(lines, "\n")
		end,
	})
end

return module