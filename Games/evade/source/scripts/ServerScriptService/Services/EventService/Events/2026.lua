local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)

-- 2026 remotes (must match client controller)
local CreateFirework = Net:RemoteEvent("EventService/2026/CreateFirework")
local ExplodeTraitEffect = Net:RemoteEvent("EventService/2026/ExplodeTraitEffect")

local Event2026 = {}

local isActive = false
local fireworkTask = nil
local traitApplyTask = nil

local recentlyTargeted = {}
local fireworkPositions = {}

local TRAIT_NAME = "26"

function Event2026.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("2026Event", true)

	if fireworkTask then
		task.cancel(fireworkTask)
	end

	if traitApplyTask then
		task.cancel(traitApplyTask)
	end

	-- Cache firework positions
	local fireworksFolder = ReplicatedStorage.Models.Events["2026"].Fireworks
	local fireworkModels = fireworksFolder:GetChildren()

	table.sort(fireworkModels, function(a, b)
		return tonumber(a.Name) < tonumber(b.Name)
	end)

	for i, model in ipairs(fireworkModels) do
		local cf = nil

		if model:IsA("Model") and model.PrimaryPart then
			cf = model.PrimaryPart.CFrame
		elseif model:IsA("BasePart") then
			cf = model.CFrame
		end

		if cf then
			fireworkPositions[i] = cf
		end
	end

	--Fireworks loop
	fireworkTask = task.spawn(function()
		while isActive do
			task.wait(math.random(20, 40) / 10)
			if not isActive then
				break
			end

			local fireworkData = {}
			local count = math.random(1, 3)

			for _ = 1, count do
				local keys = {}
				for index in pairs(fireworkPositions) do
					table.insert(keys, index)
				end

				if #keys > 0 then
					local chosen = keys[math.random(1, #keys)]
					table.insert(fireworkData, {
						Chosen = chosen,
						Height = math.random(80, 120),
						FireworkEffect = math.random(1, 3),
						Falloffs = {}
					})
				end
			end

			if #fireworkData > 0 then
				CreateFirework:FireAllClients(fireworkData)
			end
		end
	end)

	-- Trait application loop
	traitApplyTask = task.spawn(function()
		while isActive do
			task.wait(math.random(50, 100) / 10)
			if not isActive then
				break
			end

			local animals = CollectionService:GetTagged("Animal")
			local now = workspace:GetServerTimeNow()

			for name, last in pairs(recentlyTargeted) do
				if (now - last) > 15 then
					recentlyTargeted[name] = nil
				end
			end

			local candidates = {}

			for _, animal in ipairs(animals) do
				if animal.PrimaryPart then
					local traitsJson = animal:GetAttribute("Traits")
					local hasTrait = false

					if traitsJson then
						local ok, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
						if ok and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == TRAIT_NAME then
									hasTrait = true
									break
								end
							end
						end
					end

					if not hasTrait and not recentlyTargeted[animal.Name] then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				recentlyTargeted[selected.Name] = now

				-- client-side burst effect
				ExplodeTraitEffect:FireAllClients(1, selected.Name)

				task.delay(0.5, function()
					local traits = {}
					local json = selected:GetAttribute("Traits")

					if json then
						local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
						if ok and type(decoded) == "table" then
							traits = decoded
						end
					end

					for _, trait in ipairs(traits) do
						if trait == TRAIT_NAME then
							return
						end
					end

					table.insert(traits, TRAIT_NAME)
					selected:SetAttribute("Traits", HttpService:JSONEncode(traits))
				end)
			end
		end
	end)
end

function Event2026.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("2026Event", false)

	if fireworkTask then
		task.cancel(fireworkTask)
		fireworkTask = nil
	end

	if traitApplyTask then
		task.cancel(traitApplyTask)
		traitApplyTask = nil
	end

	recentlyTargeted = {}
	fireworkPositions = {}
end

return Event2026