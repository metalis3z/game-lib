local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)

local HoleEffect = Net:RemoteEvent("EventService/Glitch/HoleEffect")

local GlitchEvent = {}
local isActive = false
local holeTask
local recentlyTargeted = {}
local activeGlitchScripts = {}

function GlitchEvent.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("GlitchEvent", true)

	local glitchScript = script:FindFirstChild("Glitch")
	if glitchScript then
		local clone = glitchScript:Clone()
		clone.Parent = workspace
		table.insert(activeGlitchScripts, clone)
	end

	holeTask = task.spawn(function()
		while isActive do
			task.wait(math.random(100, 180) / 10)

			local now = workspace:GetServerTimeNow()
			for name, last in pairs(recentlyTargeted) do
				if now - last > 20 then
					recentlyTargeted[name] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart then
					if not recentlyTargeted[animal.Name] then
						local traits = {}
						local json = animal:GetAttribute("Traits")
						if json then
							local success, decoded = pcall(HttpService.JSONDecode, HttpService, json)
							if success and type(decoded) == "table" then
								traits = decoded
							end
						end

						local hasGlitched = false
						for _, t in ipairs(traits) do
							if t == "Glitched" then
								hasGlitched = true
								break
							end
						end

						if not hasGlitched then
							table.insert(candidates, animal)
						end
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(#candidates)]
				HoleEffect:FireAllClients(selected.Name, now)
				recentlyTargeted[selected.Name] = now

				-- Force idle temporairement
				selected:SetAttribute("ForceIdle", true)
				task.delay(1.5, function()
					if selected.Parent then
						selected:SetAttribute("ForceIdle", false)
						selected:SetAttribute("ForceIdle", nil)
					end
				end)

				-- Ajout du trait après un très court délai
				task.delay(0.05, function()
					if not selected.Parent then return end

					-- Récupère les traits actuels
					local json = selected:GetAttribute("Traits")
					local traits = {}
					if json then
						local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
						if ok and type(decoded) == "table" then
							traits = decoded
						end
					end

					-- Vérifie si "Glitched" est déjà présent
					local hasGlitched = false
					for _, t in ipairs(traits) do
						if t == "Glitched" then
							hasGlitched = true
							break
						end
					end

					-- Ajoute le trait s'il n'existe pas
					if not hasGlitched then
						table.insert(traits, "Glitched")
						selected:SetAttribute("Traits", HttpService:JSONEncode(traits))
					end
				end)
			end
		end
	end)
end

function GlitchEvent.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("GlitchEvent", false)

	if holeTask then
		task.cancel(holeTask)
		holeTask = nil
	end

	recentlyTargeted = {}

	for _, s in ipairs(activeGlitchScripts) do
		if s.Parent then
			s:Destroy()
		end
	end
	activeGlitchScripts = {}
end

return GlitchEvent