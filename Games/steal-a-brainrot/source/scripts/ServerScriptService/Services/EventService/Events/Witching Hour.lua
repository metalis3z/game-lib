local WitchingHour = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local Net = require(ReplicatedStorage.Packages.Net)
local Projectile = Net:RemoteEvent("EventService/WitchingHour/Projectile")
local Burst = Net:RemoteEvent("EventService/WitchingHour/Burst")

local isActive = false
local strikeTask = nil
local recentlyTargeted = {}

local EventsFolder = workspace:WaitForChild("Events")
local WitchingHourFolder = EventsFolder:WaitForChild("Witching Hour")
local Model = WitchingHourFolder:WaitForChild("Model")
local Carpet = workspace:WaitForChild("Map"):WaitForChild("Carpet")

local originalModelCFrame = CFrame.new(0, 100000, 0)
local originalCarpetCFrame = Carpet:GetPivot()

local modelTargetCFrame = CFrame.new(-381.109, -9.5, 17.906)
local carpetTargetCFrame = CFrame.new(0, 100000, 0)

local function updateScene(state)
	if state then
		Model:PivotTo(modelTargetCFrame)
		Carpet:PivotTo(carpetTargetCFrame)
	else
		Model:PivotTo(originalModelCFrame)
		Carpet:PivotTo(originalCarpetCFrame)
	end
end

function WitchingHour.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("WitchingHourEvent", true)
	updateScene(true)

	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			task.wait(math.random(90, 175) / 10)

			if not isActive then
				break
			end

			local sammyModel = Model:FindFirstChild("Sammy")
			if not sammyModel then
				continue
			end

			local head = sammyModel:FindFirstChild("Head")
			local upperTorso = sammyModel:FindFirstChild("UpperTorso")
			local root = sammyModel:FindFirstChild("HumanoidRootPart")

			if not (head and upperTorso and root) then
				continue
			end

			local neckJoint = head:FindFirstChild("Neck")
			local waistJoint = upperTorso:FindFirstChild("Waist")

			if not (neckJoint and waistJoint) then
				continue
			end

			local originalNeckC0 = neckJoint.C0
			local originalWaistC0 = waistJoint.C0

			local function returnToOriginal()
				TweenService:Create(neckJoint, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					C0 = originalNeckC0
				}):Play()

				TweenService:Create(waistJoint, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					C0 = originalWaistC0
				}):Play()
			end

			local function faceTarget(targetPosition)
				local headPos = head.Position
				local lookCFrame = CFrame.lookAt(headPos, targetPosition)
				local relativeRotation = root.CFrame:ToObjectSpace(lookCFrame)
				local angleX, angleY, _ = relativeRotation:ToEulerAnglesYXZ()

				angleX = math.clamp(angleX, math.rad(-30), math.rad(30))

				TweenService:Create(neckJoint, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					C0 = originalNeckC0 * CFrame.Angles(angleX, angleY, 0)
				}):Play()

				TweenService:Create(waistJoint, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					C0 = originalWaistC0 * CFrame.Angles(0, angleY, 0)
				}):Play()
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
				if animal.PrimaryPart and not recentlyTargeted[animal.Name] then
					local hasWitchHat = false
					local traitsJson = animal:GetAttribute("Traits")

					if traitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(traitsJson)
						end)

						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Witch Hat" then
									hasWitchHat = true
									break
								end
							end
						end
					end

					if not hasWitchHat then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()
				local travelTime = 2.5

				faceTarget(selected.PrimaryPart.Position)

				Projectile:FireAllClients(
					selected.Name,
					1,
					travelTime,
					now,
					#candidates,
					selected
				)

				recentlyTargeted[selected.Name] = now

				task.delay(3, function()
					Burst:FireAllClients(selected.Name)
					returnToOriginal()

					local currentTraits = {}
					local traitsJson = selected:GetAttribute("Traits")

					if traitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(traitsJson)
						end)

						if success and type(decoded) == "table" then
							currentTraits = decoded
						end
					end

					for _, trait in ipairs(currentTraits) do
						if trait == "Witch Hat" then
							return
						end
					end

					table.insert(currentTraits, "Witch Hat")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function WitchingHour.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("WitchingHourEvent", false)
	updateScene(false)

	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end

	recentlyTargeted = {}
end

return WitchingHour