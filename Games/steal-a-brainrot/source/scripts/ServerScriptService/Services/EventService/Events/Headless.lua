local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Shoot = Net:RemoteEvent("EventService/Headless/Shoot")  -- ← événement de GUIGUI

local WitchingHour = {}
local isActive = false
local strikeTask = nil
local recentlyTargeted = {}

function WitchingHour.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("HeadlessEvent", true)

	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(90, 150) / 10   -- 18s à 30s
			task.wait(waitTime)

			local TweenService = game:GetService("TweenService")
			local sammyModel = workspace.Events["Witching Hour"]:FindFirstChild("Model") and workspace.Events["Witching Hour"].Model:FindFirstChild("Sammy")
			local headJoint = sammyModel and sammyModel:FindFirstChild("Head") and sammyModel.Head:FindFirstChild("Neck")
			local waistJoint = sammyModel and sammyModel:FindFirstChild("UpperTorso") and sammyModel.UpperTorso:FindFirstChild("Waist")

			local originalNeckC0 = headJoint and headJoint.C0
			local originalWaistC0 = waistJoint and waistJoint.C0

			local function returnToOriginal()
				if headJoint and originalNeckC0 then
					local neckReset = TweenService:Create(headJoint, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { C0 = originalNeckC0 })
					neckReset:Play()
				end
				if waistJoint and originalWaistC0 then
					local waistReset = TweenService:Create(waistJoint, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { C0 = originalWaistC0 })
					waistReset:Play()
				end
			end

			local function faceTarget(targetPosition)
				if not sammyModel or not sammyModel.Head or not headJoint or not waistJoint then return end
				local head = sammyModel.Head
				local root = sammyModel.HumanoidRootPart

				local headPos = head.Position
				local lookCFrame = CFrame.lookAt(headPos, targetPosition)
				local relativeRotation = root.CFrame:ToObjectSpace(lookCFrame)
				local angleX, angleY = relativeRotation:ToEulerAnglesYXZ()
				angleX = math.clamp(angleX, math.rad(-30), math.rad(30))

				local neckTween = TweenService:Create(headJoint, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					C0 = originalNeckC0 * CFrame.Angles(angleX, angleY, 0)
				})
				neckTween:Play()
				neckTween.Completed:Wait()

				local neckTweenReturn = TweenService:Create(headJoint, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { C0 = originalNeckC0 })
				neckTweenReturn:Play()

				local waistTween = TweenService:Create(waistJoint, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					C0 = originalWaistC0 * CFrame.Angles(0, angleY, 0)
				})
				waistTween:Play()
				waistTween.Completed:Wait()
			end

			if not isActive then break end

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
					local hasMuta = false
					local traitsJson = animal:GetAttribute("Traits")
					if traitsJson then
						local success, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
						if success and type(decoded) == "table" then
							for _, t in ipairs(decoded) do
								if t == "Headless" then   -- ← la muta (trait GUIGUI)
									hasMuta = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasMuta then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				faceTarget(selected.PrimaryPart.Position)

				-- Utilise l'événement Shoot de GUIGUI
				Shoot:FireAllClients(selected.Name, now)

				recentlyTargeted[selected.Name] = now

				-- Après 3 secondes : ajout de la mutation "GUIGUI"
				task.delay(3, function()
					returnToOriginal()
					local currentTraitsJson = selected:GetAttribute("Traits")
					local currentTraits = {}
					if currentTraitsJson then
						local success, decoded = pcall(HttpService.JSONDecode, HttpService, currentTraitsJson)
						if success and type(decoded) == "table" then
							currentTraits = decoded
						end
					end
					for _, t in ipairs(currentTraits) do
						if t == "Headless" then return end
					end
					table.insert(currentTraits, "Headless")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function WitchingHour.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("HeadlessEvent", false)
	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end
	recentlyTargeted = {}
end

return WitchingHour