local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local HoleEffect = Net:RemoteEvent("EventService/Glitch/HoleEffect")

local GlitchEvent = {}
local isActive = false
local eventTrove = nil
local recentlyTargeted = {}
local forcedIdleAnimals = {}

function GlitchEvent.OnStart()
	if isActive then
		return
	end

	isActive = true
	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("GlitchEvent", true)

	local glitchScript = script:FindFirstChild("Glitch")
	if glitchScript then
		local clone = glitchScript:Clone()
		clone.Parent = workspace
		eventTrove:Add(clone)
	end

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(40, 80) / 10)

			if not isActive then break end

			local now = workspace:GetServerTimeNow()

			for name, last in pairs(recentlyTargeted) do
				if now - last > 20 then
					recentlyTargeted[name] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart then
					if recentlyTargeted[animal.Name] then
						continue
					end

					if not SharedEventUtils.isPointInCarpet(animal.PrimaryPart.Position) then
						continue
					end

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

			if #candidates > 0 then
				local selected = candidates[math.random(#candidates)]
				HoleEffect:FireAllClients(selected.Name, now)
				recentlyTargeted[selected.Name] = now

				selected:SetAttribute("ForceIdle", true)
				forcedIdleAnimals[selected] = true

				eventTrove:Add(task.spawn(function()
					task.wait(1.5)
					forcedIdleAnimals[selected] = nil
					if selected and selected.Parent then
						selected:SetAttribute("ForceIdle", false)
						selected:SetAttribute("ForceIdle", nil)
					end
				end))

				eventTrove:Add(task.spawn(function()
					task.wait(0.05)
					if not selected or not selected.Parent then return end

					local traits = {}
					local json = selected:GetAttribute("Traits")
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
						table.insert(traits, "Glitched")
						selected:SetAttribute("Traits", HttpService:JSONEncode(traits))
					end
				end))
			end
		end
	end))
end

function GlitchEvent.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("GlitchEvent", false)

	for animal in pairs(forcedIdleAnimals) do
		if animal and animal.Parent then
			animal:SetAttribute("ForceIdle", false)
			animal:SetAttribute("ForceIdle", nil)
		end
	end
	forcedIdleAnimals = {}

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	recentlyTargeted = {}
end

return GlitchEvent