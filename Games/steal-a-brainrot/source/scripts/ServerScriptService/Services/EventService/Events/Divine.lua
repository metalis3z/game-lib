local Divine = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local Net = require(ReplicatedStorage.Packages.Net)
local Hit = Net:RemoteEvent("EventService/Divine/Hit")

local SignDefaultCloned = nil

local isActive = false
local DivineTask = nil
local recentlyTargeted = {}

local MapObjects = {
	RoadPanel = workspace:WaitForChild("RoadPanel")
}

local OriginalCFrames = {}
for name, model in pairs(MapObjects) do
	OriginalCFrames[name] = model:GetPivot()
end

local TargetCFrames = {
	RoadPanel = CFrame.new(-445.252, -1, -140.844) * CFrame.Angles(0, math.rad(0), 0),
}

local function MoveMapObjects(toTarget)
	for name, model in pairs(MapObjects) do
		model:PivotTo(toTarget and TargetCFrames[name] or OriginalCFrames[name])
	end
end

function Divine.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("DivineEvent", true)
	ReplicatedStorage:SetAttribute("DivineStairsEnabled", true)
	
	MoveMapObjects(true)

	if DivineTask then
		task.cancel(DivineTask)
	end
	
	SignDefaultCloned = script.SignDefault:Clone()
	SignDefaultCloned.Parent = Workspace

	DivineTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(5, 10)
			task.wait(waitTime)

			if not isActive then
				break
			end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 15 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasDivine = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Halo" then
									hasDivine = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasDivine then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				Hit:FireAllClients(selected.Name)
				recentlyTargeted[selected.Name] = now

				task.delay(0.1, function()
					if not selected or not selected.Parent then
						return
					end

					local currentTraitsJson = selected:GetAttribute("Traits")
					local currentTraits = {}

					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							currentTraits = decoded
						end
					end

					for _, trait in ipairs(currentTraits) do
						if trait == "Halo" then
							return
						end
					end

					table.insert(currentTraits, "Halo")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function Divine.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("DivineEvent", false)
	ReplicatedStorage:SetAttribute("DivineStairsEnabled", nil)
	ReplicatedStorage:SetAttribute("DivineEvent", nil)
	ReplicatedStorage:SetAttribute("DivineEventLastTime", os.time())
	
	MoveMapObjects(false)

	if DivineTask then
		task.cancel(DivineTask)
		DivineTask = nil
	end
	
	if SignDefaultCloned then
		SignDefaultCloned:Destroy()
	end

	recentlyTargeted = {}
end

return Divine
