--// property of unknown, dont steal u mudafucka
local module = function(Conch, Config)
	Conch.register("spawnbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
				optional = true,
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true,
			},
			{
				kind = "argument",
				name = "Traits",
				type = "Traits",
				optional = true,
			}
		end,
		callback = function(brainrot, amount, mutation, traits)
			local success, Animals = pcall(function()
				return require(game:GetService("ReplicatedStorage").Datas.Animals)
			end)
			if not success or not Animals then
				return "Failed to load Animals data"
			end

			local successMut, Mutations = pcall(function()
				return require(game:GetService("ReplicatedStorage").Datas.Mutations)
			end)

			local successTraits, TraitsData = pcall(function()
				return require(game:GetService("ReplicatedStorage").Datas.Traits)
			end)

			local successSvc, AnimalService = pcall(function()
				return require(game:GetService("ServerScriptService").Services.AnimalService)
			end)
			if not successSvc or not AnimalService then
				return "AnimalService not initialized"
			end

			if not Animals[brainrot] or Animals[brainrot].LuckyBlock then
				return "Invalid Brainrot: " .. tostring(brainrot)
			end

			if mutation and mutation ~= "None" and (not successMut or not Mutations or not Mutations[mutation]) then
				return "Invalid Mutation: " .. tostring(mutation)
			end

			local parsedTraits = {}
			if traits then
				if type(traits) == "string" then
					for trait in string.gmatch(traits, "([^,]+)") do
						local trimmedTrait = string.gsub(trait, "^%s*(.-)%s*$", "%1")
						if trimmedTrait ~= "" then
							if successTraits and TraitsData and TraitsData[trimmedTrait] then
								table.insert(parsedTraits, trimmedTrait)
							else
								return "Invalid trait: " .. trimmedTrait
							end
						end
					end
				elseif type(traits) == "table" then
					for _, trait in ipairs(traits) do
						if type(trait) == "string" then
							if successTraits and TraitsData and TraitsData[trait] then
								table.insert(parsedTraits, trait)
							else
								return "Invalid trait: " .. trait
							end
						end
					end
				end
			end

			amount = tonumber(amount) or 1
			if amount < 1 then
				return "Amount must be at least 1"
			end

			local mutParam = nil
			if mutation == "Normal" then mutParam = nil else mutParam = mutation end
			local successCount = 0

			for i = 1, amount do
				local ok, err = pcall(function()
					AnimalService.spawnAnimalCustom(Animals[brainrot], mutParam, parsedTraits, nil, nil, nil)
				end)
				if ok then
					successCount = successCount + 1
				else
					warn("Failed to spawn animal:", err)
				end
			end

			if successCount == 0 then
				return string.format("Failed to spawn any %s", brainrot)
			end

			local traitText = ""
			if #parsedTraits > 0 then
				traitText = " with traits: " .. table.concat(parsedTraits, ", ")
			end

			return string.format("Spawned %d %s%s%s", successCount, brainrot, mutParam and (" (" .. mutParam .. ")") or "", traitText)
		end,
	})
end

return module