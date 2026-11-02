--credit to quartz games studio
local t = {
	StartOrder = 4
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local HapticService = game:GetService("HapticService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)
local GrowEffects = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("GrowEffects"))
local MusicTracks = SoundService:WaitForChild("MusicTracks")
local t2 = {
	Normal = SoundService:WaitForChild("SFX"):WaitForChild("OfflineGrowthNormal"),
	Intense = SoundService:WaitForChild("SFX"):WaitForChild("OfflineGrowthIntense")
}

local function getOrdinalSuffix(p1) --[[ getOrdinalSuffix | Line: 84 ]]
	if p1 == 1 or (p1 == 21 or p1 == 31) then
		return "st"
	end

	if p1 == 2 or p1 == 22 then
		return "nd"
	end

	if p1 == 3 or p1 == 23 then
		return "rd"
	end

	return "th"
end

function t.CalculateCutsceneDuration(p1, p2) --[[ CalculateCutsceneDuration | Line: 96 ]]
	local sum = 0
	local count = 0

	for v1, v2 in p2 do
		local v3 = v2.maxAge or 0

		if v3 > 0 then
			sum = sum + math.max(v2.newAge - v2.oldAge, 0) / v3
			count = count + 1
		end

		for v5, v6 in v2.fruits do
			local v7 = v6.maxAge or 0

			if v7 > 0 then
				sum = sum + math.max(v6.newAge - v6.oldAge, 0) / v7
				count = count + 1
			end
		end
	end

	if count == 0 then
		return 5
	end

	return math.clamp(sum / count, 0, 1) * 5 + 5
end
function t.BuildGrowthChanges(p1, p2, p3) --[[ BuildGrowthChanges | Line: 127 ]]
	local t = {}
	local t2 = {}

	for v1, v2 in p3 do
		local v3 = p2[v1]
		local t3 = {
			plantId = v1,
			plantName = v2.PlantName,
			oldAge = if v3 then v3.Age or 0 else 0,
			newAge = v2.Age or 0,
			maxAge = v2.MaxAge or 0,
			fruits = {}
		}
		local t4 = {}
		local v7 = v3 and (v3.Fruits or {}) or {}

		for v9, v10 in v2.Fruits or {} do
			local v11 = v7[v9]
			local t5 = {
				fruitId = v9
			}

			t5.oldAge = if v11 then v11.Age or 0 else 0
			t5.newAge = v10.Age or 0
			t5.oldOvertimeGrowth = if v11 then v11.OvertimeGrowth or 1 else 1
			t5.newOvertimeGrowth = v10.OvertimeGrowth or 1
			t5.maxAge = v10.MaxAge or 0
			table.insert(t3.fruits, t5)
			t4[v9] = t5
		end

		table.insert(t, t3)
		t2[v1] = {
			plant = t3,
			fruitsById = t4
		}
	end

	return t, t2
end
function t.HasMeaningfulGrowthChanges(p1, p2) --[[ HasMeaningfulGrowthChanges | Line: 174 ]]
	for v1, v2 in p2 do
		local v3 = v2.oldAge or 0

		if math.abs((v2.newAge or v3) - v3) > 0.0001 then
			return true
		end

		for v5, v6 in v2.fruits do
			local v7 = v6.oldAge or 0

			if math.abs((v6.newAge or v7) - v7) > 0.0001 then
				return true
			end

			local v9 = v6.oldOvertimeGrowth or 1
			local v12 = math.max(math.abs(v9), 0.0001)

			if math.abs((v6.newOvertimeGrowth or v9) - v9) / v12 > 0.05 then
				return true
			end
		end
	end

	return false
end
function t.ClassifyGrowthIntensity(p1, p2) --[[ ClassifyGrowthIntensity | Line: 204 ]]
	if not p1:HasMeaningfulGrowthChanges(p2) then
		return "Normal"
	end

	local sum = 0
	local count = 0

	for v1, v2 in p2 do
		local v3 = v2.maxAge or 0

		if v3 > 0 then
			sum = sum + math.max(v2.newAge - v2.oldAge, 0) / v3
			count = count + 1
		end

		for v5, v6 in v2.fruits do
			local v7 = v6.maxAge or 0

			if v7 > 0 then
				sum = sum + math.max(v6.newAge - v6.oldAge, 0) / v7
				count = count + 1
			end
		end
	end

	if count == 0 then
		return "Normal"
	end

	if math.clamp(sum / count, 0, 1) >= 0.35 then
		return "Intense"
	end

	return "Normal"
end
function t.DuckMusic(p1, p2) --[[ DuckMusic | Line: 242 | Upvalues: MusicTracks (copy), TweenService (copy), Debris (copy) ]]
	local v1 = TweenInfo.new(p2 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local t = {}

	for v2, v3 in MusicTracks:GetDescendants() do
		if v3:IsA("Sound") and v3.IsPlaying then
			t[v3] = v3.Volume

			local v4 = TweenService:Create(v3, v1, {
				Volume = 0.2
			})

			v4:Play()
			Debris:AddItem(v4, v1.Time)
		end
	end

	return t
end
function t.RestoreMusic(p1, p2, p3) --[[ RestoreMusic | Line: 264 | Upvalues: TweenService (copy), Debris (copy) ]]
	local v1 = TweenInfo.new(p3 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

	for v2, v3 in p2 do
		if v2 and v2.Parent then
			local v4 = TweenService:Create(v2, v1, {
				Volume = v3
			})

			v4:Play()
			Debris:AddItem(v4, v1.Time)
		end
	end
end
function t.StartGrowthSound(p1, p2) --[[ StartGrowthSound | Line: 282 | Upvalues: t2 (copy) ]]
	if p2 and t2[p2] then
		local v1 = t2[p2]

		v1.Looped = true
		v1.Volume = 0.35
		v1:Play()

		return v1
	end

	return nil
end
function t.StopGrowthSound(p1, p2, p3) --[[ StopGrowthSound | Line: 297 | Upvalues: TweenService (copy), Debris (copy) ]]
	if not p2 then
		return
	end

	local v1 = p3 or 1

	if v1 > 0 then
		local v2 = TweenInfo.new(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v3 = TweenService:Create(p2, v2, {
			Volume = 0
		})

		v3:Play()
		Debris:AddItem(v3, v2.Time)
		v3.Completed:Once(function() --[[ Line: 309 | Upvalues: p2 (copy) ]]
			p2:Stop()
			p2.Looped = false
			p2.Volume = 2
		end)
	else
		p2:Stop()
		p2.Looped = false
	end
end
function t.ZeroAllPlantAndFruitAges(p1, p2, p3, p4, p5, p6, p7) --[[ ZeroAllPlantAndFruitAges | Line: 320 ]]
	local v1 = os.clock()
	local count = 0

	for v2, v3 in p3 do
		local v4 = p4(p2, v3.plantId)
		local v5 = p5(p2, v3.plantId)

		if v4 and v5 then
			local v6 = v3.oldAge or 0

			v4:SetAttribute("Age", v6)
			v5.CurrentAge = v6
		end

		if p6 and p7 then
			for v7, v8 in v3.fruits do
				local v9 = p6(p2, v3.plantId, v8.fruitId)
				local v10 = p7(p2, v3.plantId, v8.fruitId)

				if v9 and v10 then
					local v11 = v8.oldAge or 0

					v9:SetAttribute("Age", v11)
					v10.CurrentAge = v11
				end
			end
		end

		count = count + 1

		if count >= 10 and os.clock() - v1 >= 0.004 then
			task.wait()
			count, v1 = 0, os.clock()
		end
	end
end
function t.ApplyFinalGrowthState(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ ApplyFinalGrowthState | Line: 361 ]]
	local v1 = os.clock()
	local count = 0

	for v2, v3 in p3 do
		local v4 = p4(p2, v3.plantId)
		local v5 = p5(p2, v3.plantId)

		if v4 and v5 then
			v4:SetAttribute("Age", v3.newAge)
			v5.CurrentAge = v3.newAge
			v5._syncedAge = nil

			if (v3.maxAge or 0) <= v3.newAge then
				local v6 = v4:GetAttribute("SeedName")

				if v6 and p6(v6) then
					p7(v4)
				end
			end
		end

		if p8 and (p9 and p10) then
			for v7, v8 in v3.fruits do
				local v9 = p8(p2, v3.plantId, v8.fruitId)
				local v10 = p9(p2, v3.plantId, v8.fruitId)

				if v9 and v10 then
					v9:SetAttribute("Age", v8.newAge)
					v10.CurrentAge = v8.newAge
					v10.OvertimeGrowth = v8.newOvertimeGrowth
					v10._syncedAge = nil

					if (v8.maxAge or 0) <= v8.newAge then
						p10(v9, v3.plantId, v8.fruitId)
					end
				end
			end
		end

		count = count + 1

		if count >= 10 and os.clock() - v1 >= 0.004 then
			task.wait()
			count, v1 = 0, os.clock()
		end
	end
end
function t.AttachModelsToGrowthChanges(p1, p2, p3, p4, p5) --[[ AttachModelsToGrowthChanges | Line: 421 ]]
	for v1, v2 in p3 do
		v2.model = p4(p2, v2.plantId)

		if p5 then
			for v3, v4 in v2.fruits do
				v4.model = p5(p2, v2.plantId, v4.fruitId)
			end
		end
	end
end
function t.AreGrowthVisualsReady(p1, p2, p3, p4, p5, p6, p7) --[[ AreGrowthVisualsReady | Line: 438 ]]
	local v1 = false

	for v2, v3 in p3 do
		local v4 = p4(p2, v3.plantId)
		local v5 = p5(p2, v3.plantId)

		if v4 or v5 then
			if not (v4 and (v5 and v4.Parent)) then
				return false
			end

			if not v4:HasTag("InitializationComplete") then
				return false
			end

			v1 = true
		end

		if p6 and p7 then
			for v6, v7 in v3.fruits do
				local v8 = p6(p2, v3.plantId, v7.fruitId)
				local v9 = p7(p2, v3.plantId, v7.fruitId)

				if v8 or v9 then
					if not (v8 and (v9 and v8.Parent)) then
						return false
					end

					if not v8:HasTag("InitializationComplete") then
						return false
					end

					v1 = true
				end
			end
		end
	end

	return v1
end
function t.WaitForGrowthVisualsReady(p1, p2, p3, p4, p5, p6, p7) --[[ WaitForGrowthVisualsReady | Line: 481 | Upvalues: RunService (copy) ]]
	local v1 = os.clock()
	local count = 0

	while os.clock() - v1 < 20 do
		count = count + 1

		if count % 3 == 0 and p1:AreGrowthVisualsReady(p2, p3, p4, p5, p6, p7) then
			return true
		end

		RunService.Heartbeat:Wait()
	end

	return false
end
function t.TweenAgeAttribute(p1, p2, p3, p4, p5, p6) --[[ TweenAgeAttribute | Line: 512 | Upvalues: TweenService (copy), RunService (copy) ]]
	if not p2 then
		return false
	end

	local v1 = if p6 then p6 else {}
	local v2 = v1.easingStyle or Enum.EasingStyle.Quad
	local v3 = v1.easingDirection or Enum.EasingDirection.Out
	local cancelPredicate = v1.cancelPredicate
	local onStep = v1.onStep
	local v4

	if p3 == nil then
		local v5 = p2:GetAttribute("Age")

		v4 = if typeof(v5) == "number" then v5 else 0
	else
		v4 = p3
	end

	if p5 <= 0 then
		p2:SetAttribute("Age", p4)

		if not onStep then
			return true
		end

		onStep(p4, 1)

		return true
	end

	local v6 = os.clock()

	while not (cancelPredicate and cancelPredicate()) do
		if not p2.Parent then
			break
		end

		local v8 = math.clamp((os.clock() - v6) / p5, 0, 1)
		local v9 = TweenService:GetValue(v8, v2, v3)
		local v10 = v4 + (p4 - v4) * v9

		p2:SetAttribute("Age", v10)

		if onStep then
			onStep(v10, v9)
		end

		if v8 >= 1 then
			return true
		end

		RunService.Heartbeat:Wait()
	end

	return false
end
function t.TweenModelScale(p1, p2, p3, p4, p5, p6) --[[ TweenModelScale | Line: 576 | Upvalues: TweenService (copy), RunService (copy) ]]
	if not p2 then
		return false
	end

	local v1 = if p6 then p6 else {}
	local v2 = v1.easingStyle or Enum.EasingStyle.Quad
	local v3 = v1.easingDirection or Enum.EasingDirection.Out
	local cancelPredicate = v1.cancelPredicate
	local onStep = v1.onStep
	local v5 = math.max(if p3 == nil then 1 else p3, 0.001)
	local v6 = math.max(p4, 0.001)

	if p5 <= 0 then
		p2:ScaleTo(v6)

		if not onStep then
			return true
		end

		onStep(v6, 1)

		return true
	end

	local v7 = os.clock()

	while not (cancelPredicate and cancelPredicate()) do
		if not p2.Parent then
			break
		end

		local v9 = math.clamp((os.clock() - v7) / p5, 0, 1)
		local v10 = TweenService:GetValue(v9, v2, v3)
		local v11 = v5 + (v6 - v5) * v10

		p2:ScaleTo(v11)

		if onStep then
			onStep(v11, v10)
		end

		if v9 >= 1 then
			return true
		end

		RunService.Heartbeat:Wait()
	end

	return false
end
function t.RunBatchedAgeTweens(p1, p2, p3, p4, p5, p6) --[[ RunBatchedAgeTweens | Line: 637 | Upvalues: GrowEffects (copy), TweenService (copy), RunService (copy) ]]
	if #p2 == 0 then
		return
	end

	local v1 = if GrowEffects.InitialScale == 1 then false else true

	if p3 <= 0 then
		for v2, v3 in p2 do
			if v3.model and v3.model.Parent then
				if v1 and math.abs(v3.model:GetScale() - 1) > 0.0001 then
					v3.model:ScaleTo(1)
				end

				v3.model:SetAttribute("Age", v3.endAge)

				if v1 then
					local v5 = v3.maxAge or 0

					if v5 > 0 then
						local v6 = GrowEffects.GetGrowthScale(v3.endAge, v5)

						if math.abs(v6 - 1) > 0.0001 then
							v3.model:ScaleTo(v6)
						end
					end
				end
			end
		end
	else
		local v7 = os.clock()
		local v8 = 0

		while not (p6 and p6()) do
			local v10 = math.clamp((os.clock() - v7) / p3, 0, 1)
			local v11 = TweenService:GetValue(v10, p4, p5)
			local v12 = os.clock()
			local v13 = math.min(8, #p2)

			for i = 1, v13 do
				local v14 = p2[(v8 + i - 1) % #p2 + 1]

				if v14.model and v14.model.Parent then
					local v15 = v14.startAge + (v14.endAge - v14.startAge) * v11

					if v1 and math.abs(v14.model:GetScale() - 1) > 0.0001 then
						v14.model:ScaleTo(1)
					end

					v14.model:SetAttribute("Age", v15)

					if v1 then
						local v17 = v14.maxAge or 0

						if v17 > 0 then
							local v18 = GrowEffects.GetGrowthScale(v15, v17)

							if math.abs(v18 - 1) > 0.0001 then
								v14.model:ScaleTo(v18)
							end
						end
					end
				end

				if os.clock() - v12 >= 0.004 then
					v13 = i

					break
				end
			end

			v8 = (v8 + v13) % #p2

			if v10 >= 1 then
				for v19, v20 in p2 do
					if v20.model and v20.model.Parent then
						if v1 and math.abs(v20.model:GetScale() - 1) > 0.0001 then
							v20.model:ScaleTo(1)
						end

						v20.model:SetAttribute("Age", v20.endAge)

						if v1 then
							local v22 = v20.maxAge or 0

							if v22 > 0 then
								local v23 = GrowEffects.GetGrowthScale(v20.endAge, v22)

								if math.abs(v23 - 1) > 0.0001 then
									v20.model:ScaleTo(v23)
								end
							end
						end
					end
				end

				return
			end

			RunService.Heartbeat:Wait()
		end
	end
end
function t.AnimateOfflineGrowthAge(p1, p2, p3) --[[ AnimateOfflineGrowthAge | Line: 740 ]]
	local v1 = p3.animationDuration or 0
	local isSkipRequested = p3.isSkipRequested
	local t = {}
	local t2 = {}

	for v2, v3 in p2 do
		if v3.model then
			v3.model:SetAttribute("Age", v3.oldAge or 0)
		end

		local v4 = v3.oldAge or 0
		local v5 = v3.newAge or v4

		if v3.model and v5 - v4 > 0.0001 then
			table.insert(t, {
				model = v3.model,
				startAge = v4,
				endAge = v5,
				maxAge = v3.maxAge
			})
		end

		for v6, v7 in v3.fruits do
			if v7.model then
				v7.model:SetAttribute("Age", v7.oldAge or 0)
			end

			local v8 = v7.maxAge or 0
			local v9 = v7.oldAge or 0
			local v10 = v7.newAge or v9

			if v7.model and v10 - v9 > 0.0001 then
				table.insert(t2, {
					model = v7.model,
					startAge = v9,
					endAge = v10,
					maxAge = v8
				})
			end
		end
	end

	local v11 = if #t > 0 then true else false
	local v12 = if #t2 > 0 then true else false
	local sum = 0

	if v11 then
		sum = sum + 0.5
	end

	if v12 then
		sum = sum + 0.5
	end

	if sum <= 0 then
		return true
	end

	local v13 = v11 and v1 * (0.5 / sum) or 0

	if v11 then
		p1:RunBatchedAgeTweens(t, v13, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, isSkipRequested)
	end

	if isSkipRequested and isSkipRequested() then
		return false
	end

	if not v12 then
		return true
	end

	p1:RunBatchedAgeTweens(t2, v12 and v1 * (0.5 / sum) or 0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, isSkipRequested)

	return true
end
function t.PlayOfflineCutscene(p1, p2) --[[ PlayOfflineCutscene | Line: 825 | Upvalues: LocalPlayer (copy), UserInputService (copy), TweenService (copy), CollectionService (copy), HapticService (copy), RunService (copy), ContextActionService (copy), LightingController (copy) ]]
	local effectiveGrowthTime = p2.effectiveGrowthTime
	local actualOfflineTime = p2.actualOfflineTime
	local getSpawnPoint = p2.getSpawnPoint
	local getSpawnedPlant = p2.getSpawnedPlant
	local getPlantGrowthData = p2.getPlantGrowthData
	local isSingleHarvestPlant = p2.isSingleHarvestPlant
	local addPlantHarvestPrompt = p2.addPlantHarvestPrompt
	local getSpawnedFruit = p2.getSpawnedFruit
	local getFruitGrowthData = p2.getFruitGrowthData
	local addFruitHarvestPrompt = p2.addFruitHarvestPrompt
	local v1 = if p2.skipCamera == true then true else false
	local v2 = if p2.skipUI == true then true else false
	local v3 = if p2.skipLighting == true then true else false
	local v4 = if p2.skipMusicDuck == true then true else false
	local v5 = if p2.tweenCameraRestore == true then true else false
	local v6 = if p2.skipSFX == true then true else false
	local v7 = if p2.outlineGrowthPlants == true then true else false
	local v8 = p2.targetUserId or LocalPlayer.UserId
	local v9 = if v8 == LocalPlayer.UserId then true else false

	if v9 then
		LocalPlayer:SetAttribute("OfflineCutscenePlaying", true)
	end

	local v10, v11 = p1:BuildGrowthChanges(p2.oldPlants, p2.newPlants)

	if #v10 == 0 then
		if not v9 then
			return true
		end

		LocalPlayer:SetAttribute("OfflineCutscenePlaying", false)

		return true
	end

	local t = {}

	if v7 then
		for v12, v13 in v10 do
			if v13.model and v13.model.Parent then
				local GrowthOutline = Instance.new("Highlight")

				GrowthOutline.Name = "GrowthOutline"
				GrowthOutline.Adornee = v13.model
				GrowthOutline.FillColor = Color3.fromRGB(120, 255, 120)
				GrowthOutline.FillTransparency = 0.6
				GrowthOutline.OutlineColor = Color3.fromRGB(180, 255, 180)
				GrowthOutline.OutlineTransparency = 0
				GrowthOutline.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				GrowthOutline.Parent = v13.model
				table.insert(t, GrowthOutline)
			end
		end
	end

	local function clearGrowthHighlights() --[[ clearGrowthHighlights | Line: 902 | Upvalues: t (copy) ]]
		for v1, v2 in t do
			if v2 and v2.Parent then
				v2:Destroy()
			end
		end

		table.clear(t)
	end

	if p1:WaitForGrowthVisualsReady(v8, v10, getSpawnedPlant, getPlantGrowthData, getSpawnedFruit, getFruitGrowthData) then
		local OfflineAnimation = LocalPlayer.PlayerGui:WaitForChild("OfflineAnimation")

		if not v2 then
			local BottomBar = OfflineAnimation.BottomBar
			local TopBar = OfflineAnimation.TopBar

			BottomBar.AnchorPoint = Vector2.new(0, 0)
			BottomBar.Size = UDim2.new(1, 0, 0.141, 0)
			BottomBar.BackgroundTransparency = 0
			TopBar.AnchorPoint = Vector2.new(0, 1)
			TopBar.Size = UDim2.new(1, 0, 0.141, 0)
			TopBar.BackgroundTransparency = 0

			local Date = BottomBar:FindFirstChild("Date")
			local Time = BottomBar:FindFirstChild("Time")
			local HTSLabel = BottomBar:FindFirstChild("HTSLabel")
			local Title = TopBar:FindFirstChild("Title")

			if Date then
				Date.Visible = true
			end

			if Time then
				Time.Visible = true
			end

			if HTSLabel and HTSLabel:IsA("TextLabel") then
				HTSLabel.Visible = true

				local v14 = UserInputService:GetLastInputType()

				if if v14 == Enum.UserInputType.Gamepad1 or (v14 == Enum.UserInputType.Gamepad2 or v14 == Enum.UserInputType.Gamepad3) then true else v14 == Enum.UserInputType.Gamepad4 then
					HTSLabel.Text = ("Hold (%*) to skip"):format(if if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA):find("Cross", 1, true) == nil then false else true then "X" else "A")
				else
					HTSLabel.Text = "Hold to skip"
				end
			end

			if Title then
				Title.Visible = true
			end

			task.wait(0.5)
			TweenService:Create(OfflineAnimation.BottomBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				AnchorPoint = Vector2.new(0, 1)
			}):Play()
			TweenService:Create(OfflineAnimation.TopBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				AnchorPoint = Vector2.new(0, 0)
			}):Play()
		end

		local v18 = p1:CalculateCutsceneDuration(v10)
		local CurrentCamera = workspace.CurrentCamera
		local CameraType = CurrentCamera.CameraType
		local CameraSubject = CurrentCamera.CameraSubject
		local v19 = CurrentCamera.CFrame
		local Character = LocalPlayer.Character
		local v20 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
		local v21 = if v20 and v20:IsA("BasePart") then v20.CFrame else nil
		local v22 = getSpawnPoint(v8)

		if v22 then
			local v23 = nil

			if v22 and not v1 then
				local Signs = v22.Parent:FindFirstChild("Signs")

				if Signs then
					Signs.Parent = nil
					v23 = Signs
				end
			end

			local t2 = {}
			local t3 = {}
			local t4 = {}

			local function setBillboardEnabledSilently(p1, p2) --[[ setBillboardEnabledSilently | Line: 1035 | Upvalues: t4 (copy) ]]
				if p1.Enabled ~= p2 then
					t4[p1] = true
					p1.Enabled = p2
				end
			end

			local function trackOverheadBillboard(p1) --[[ trackOverheadBillboard | Line: 1041 | Upvalues: t2 (copy), LocalPlayer (ref), t4 (copy), t3 (copy) ]]
				if t2[p1] ~= nil then
					return
				end

				if not p1:IsDescendantOf(LocalPlayer.PlayerGui) then
					return
				end

				t2[p1] = p1.Enabled

				if p1.Enabled ~= false then
					t4[p1] = true
					p1.Enabled = false
				end

				t3[p1] = p1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1048 | Upvalues: t4 (ref), p1 (copy), t2 (ref) ]]
					if t4[p1] then
						t4[p1] = nil

						return
					end

					t2[p1] = p1.Enabled

					if not p1.Enabled then
						return
					end

					local v1 = p1

					if v1.Enabled == false then
						return
					end

					t4[v1] = true
					v1.Enabled = false
				end)
			end

			local v24

			if v1 then
				v24 = nil
			else
				for v25, v26 in CollectionService:GetTagged("OverheadUITag") do
					if v26:IsA("BillboardGui") then
						trackOverheadBillboard(v26)
					end
				end

				v24 = CollectionService:GetInstanceAddedSignal("OverheadUITag"):Connect(function(p1) --[[ Line: 1069 | Upvalues: trackOverheadBillboard (copy) ]]
					if not p1:IsA("BillboardGui") then
						return
					end

					trackOverheadBillboard(p1)
				end)
			end

			local Date = OfflineAnimation.BottomBar:FindFirstChild("Date")
			local Time = OfflineAnimation.BottomBar:FindFirstChild("Time")
			local Title = OfflineAnimation.TopBar:FindFirstChild("Title")
			local StarterGui = game:GetService("StarterGui")
			local t5 = {}

			if not v2 then
				for v28, v29 in LocalPlayer.PlayerGui:GetChildren() do
					if v29:IsA("ScreenGui") and v29.Name ~= "OfflineAnimation" then
						t5[v29] = v29.Enabled
						v29.Enabled = false
					end
				end

				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			end

			local v30 = os.time() - actualOfflineTime
			local t6 = {
				"January",
				"February",
				"March",
				"April",
				"May",
				"June",
				"July",
				"August",
				"September",
				"October",
				"November",
				"December"
			}
			local v31, v32, v33, v34, v35

			if v1 then
				v31 = nil
				v32 = nil
				v33 = nil
				v34 = nil
				v35 = nil
			else
				v35 = 4.2

				local v36 = 20
				local v37 = 200
				local v38 = 1.3
				local v39 = 1.8
				local v40 = 0.075
				local v41 = 0.55
				local v42 = 1.25
				local v43 = 2.2
				local v44 = 2.4
				local v45 = 2.1
				local v46 = 2
				local v47 = 18
				local v48 = 2
				local v49 = 7
				local LookVector = v22.CFrame.LookVector
				local v50 = Vector3.new(LookVector.X, 0, LookVector.Z)

				if v50.Magnitude < 0.01 then
					v50 = Vector3.new(0, 0, -1)
				end

				v33 = v50.Unit

				local Unit = v33:Cross(Vector3.new(0, 1, 0)).Unit
				local Position = v22.Position

				v32 = Position + v33 * 10

				local v51 = 0
				local v52 = 24
				local t7 = {}
				local v53 = 0

				local function smoothAlpha(p1, p2) --[[ smoothAlpha | Line: 1160 ]]
					return 1 - math.exp(-p1 * math.max(p2, 1 / 60))
				end

				v31 = function(p1, p2, p3, p4) --[[ Line: 1165 | Upvalues: v53 (ref), v11 (copy), getSpawnedPlant (copy), v8 (copy), Position (copy), t7 (copy), Unit (ref), v33 (ref), v38 (ref), v36 (ref), v37 (ref), v32 (ref), v43 (ref), v51 (ref), v45 (ref), v52 (ref), v44 (ref), v41 (ref), v40 (ref), v42 (ref), v48 (ref), v49 (ref), v46 (ref), v47 (ref), v39 (ref) ]]
					v53 = v53 + 1

					local v1 = if v53 <= 1 then true else v53 % 10 == 0
					local v2 = -1
					local v3 = (1 / 0)
					local v4 = (-1 / 0)
					local v5 = (1 / 0)
					local v6 = (-1 / 0)
					local v7 = (1 / 0)
					local v82 = (-1 / 0)
					local count = 0
					local v9 = 0
					local v10 = nil

					for v112, v12 in v11 do
						local plant = v12.plant
						local v13 = getSpawnedPlant(v8, v112)

						if v13 and v13.Parent then
							if v1 then
								local ok, result, result2 = pcall(function() --[[ Line: 1187 | Upvalues: v13 (copy) ]]
									return v13:GetBoundingBox()
								end)

								if ok and (result and result2) and ((result.Position - Position).Magnitude <= 200 and result2.Magnitude <= 400) then
									local v15 = math.max(v13:GetScale(), 0.001)

									if v15 < 1 then
										result2 = result2 / v15
									end

									t7[v112] = {
										cframe = result,
										size = result2
									}
								end
							end

							local v16 = t7[v112]

							if v16 then
								local sum = math.max(plant.newAge - plant.oldAge, 0)

								for v18, v19 in plant.fruits do
									sum = sum + math.max(v19.newAge - v19.oldAge, 0)
								end

								local Position2 = v16.cframe.Position
								local v21 = v16.size * 0.5
								local v22 = Position2 - Position
								local v23 = v22:Dot(Unit)
								local v24 = v22:Dot(v33)
								local v25 = math.abs(Unit.X) * v21.X
								local v26 = v25 + math.abs(Unit.Z) * v21.Z
								local v27 = math.abs(v33.X) * v21.X
								local v28 = v27 + math.abs(v33.Z) * v21.Z
								local v29 = math.min(v3, v23 - v26)
								local v30 = math.max(v4, v23 + v26)
								local v31 = math.min(v5, v24 - v28)
								local v322 = math.max(v6, v24 + v28)
								local v34 = math.min(v7, Position2.Y - v21.Y)
								local v362 = math.max(v82, Position2.Y + v21.Y)

								count = count + 1

								local v382 = math.max(v9, v16.size.Y * 0.35)

								if v2 < sum then
									v2, v3, v4, v5, v6, v7, v82, v9, v10 = sum, v29, v30, v31, v322, v34, v362, v382, {
										pos = Position2,
										size = v16.size,
										radius = v16.size.Magnitude * 0.5,
										growth = sum
									}

									continue
								end

								v3 = v29
								v4 = v30
								v5 = v31
								v6 = v322
								v7 = v34
								v82 = v362
								v9 = v382
							end
						end
					end

					local v392 = Position + v33 * 10
					local v402, v412

					if count > 0 then
						v402 = Position + Unit * ((v3 + v4) * 0.5) + v33 * ((v5 + v6) * 0.5) + Vector3.new(0, (v7 + v82) * 0.5 - Position.Y, 0)

						local CurrentCamera = workspace.CurrentCamera
						local v452 = math.rad(CurrentCamera.FieldOfView * 0.5)
						local v462 = CurrentCamera.ViewportSize.X / math.max(CurrentCamera.ViewportSize.Y, 1)

						v412 = math.clamp((math.max((v4 - v3) * 0.5 / math.tan((math.max(math.atan(math.tan(v452) * v462), 0.1))), (v82 - v7) * 0.5 / math.tan((math.max(v452, 0.1))), 5) + (v6 - v5) * 0.5) * v38, v36, v37)
					else
						v412 = v36
						v402 = v392
					end

					v32 = v32:Lerp(v402:Lerp(v10 and v10.pos or v402, (1 - math.abs(0.5 - p2) * 2) * 0.15 + 0.15), 1 - math.exp(-v43 * math.max(p4, 1 / 60)))
					v51 = v51 + (v9 - v51) * (1 - math.exp(-v45 * math.max(p4, 1 / 60)))
					v52 = v52 + (v412 - v52) * (1 - math.exp(-v44 * math.max(p4, 1 / 60)))

					local Unit2 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.sin(p3 * v41) * v40):VectorToWorldSpace(v33).Unit
					local v70 = Unit * (math.sin(p3 * v41 * 0.6) * v42)
					local v74 = math.clamp(v48 + (v49 - v48) * p1 + v51 * 0.12, v46, v47)
					local v77 = math.clamp(v39 - v51 * 0.08, 0.35, v39)

					return CFrame.new(v32 - Unit2 * v52 + Vector3.new(0, v74, 0) + v70, v32 + Vector3.new(0, v77, 0))
				end
				CurrentCamera.CameraType = Enum.CameraType.Scriptable

				local v54 = v31(0, 0, 0, 1 / 60)

				CurrentCamera.CFrame = v54
				v34 = v54
			end

			local Lighting = game:GetService("Lighting")
			local ClockTime = Lighting.ClockTime
			local v55 = math.min(actualOfflineTime / 3600, 120)

			p1:ZeroAllPlantAndFruitAges(v8, v10, getSpawnedPlant, getPlantGrowthData, getSpawnedFruit, getFruitGrowthData)
			p1:AttachModelsToGrowthChanges(v8, v10, getSpawnedPlant, getSpawnedFruit)

			local v56 = p1:ClassifyGrowthIntensity(v10)
			local v57 = if v4 then {} else p1:DuckMusic()
			local v58 = if v6 then nil else p1:StartGrowthSound(v56)
			local v59 = os.clock()

			local function clearHaptic() --[[ clearHaptic | Line: 1333 | Upvalues: HapticService (ref) ]]
				pcall(function() --[[ Line: 1334 | Upvalues: HapticService (ref) ]]
					HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0)
					HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
				end)
			end

			local v60

			if v58 then
				v60 = true
				task.spawn(function() --[[ Line: 1342 | Upvalues: HapticService (ref), v60 (ref), v58 (copy), RunService (ref) ]]
					local v1 = 0
					local v2 = (-1 / 0)
					local v3 = os.clock()
					local v4 = 0
					local v5 = false
					local v6 = false

					pcall(function() --[[ Line: 1354 | Upvalues: v5 (ref), HapticService (ref), v6 (ref) ]]
						v5 = HapticService:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small)
						v6 = HapticService:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large)
					end)

					while v60 and (v58 and v58.IsPlaying) do
						local v7 = os.clock()

						math.max(v7 - v3, 0.004166666666666667)

						local PlaybackLoudness = v58.PlaybackLoudness

						if v4 < PlaybackLoudness then
							v4 = PlaybackLoudness
						end

						local v8 = math.clamp(PlaybackLoudness / 10, 0, 1) ^ 5

						if v8 >= 0.05 and v7 - v2 >= 0.3 then
							v2, v1 = v7, math.clamp(v8 * 2, 0, 1)
						end

						local v11 = math.min(v1 * math.exp(-(v7 - v2) * 8) * 0.6, 0.6)

						if v5 then
							pcall(function() --[[ Line: 1388 | Upvalues: HapticService (ref), v11 (copy) ]]
								HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, v11)
							end)
						end

						if v6 then
							pcall(function() --[[ Line: 1393 | Upvalues: HapticService (ref), v11 (copy) ]]
								HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, v11 * 0.4)
							end)
						end

						if v2 == v7 then
							local v12 = math.clamp(v1 * 0.6 * 1.5, 0, 1)

							task.spawn(function() --[[ Line: 1402 | Upvalues: v12 (copy) ]]
								local ok, result = pcall(function() --[[ Line: 1403 | Upvalues: v12 (ref) ]]
									local HapticEffect = Instance.new("HapticEffect")

									HapticEffect.Type = Enum.HapticEffectType.Custom
									HapticEffect:SetWaveformKeys({ FloatCurveKey.new(0, 0, Enum.KeyInterpolationMode.Linear), FloatCurveKey.new(27.5, v12, Enum.KeyInterpolationMode.Linear), FloatCurveKey.new(110, 0, Enum.KeyInterpolationMode.Linear) })
									HapticEffect.Parent = workspace

									return HapticEffect
								end)

								if not (ok and result) then
									return
								end

								result.Ended:Connect(function() --[[ Line: 1415 | Upvalues: result (copy) ]]
									result:Destroy()
								end)
								pcall(function() --[[ Line: 1418 | Upvalues: result (copy) ]]
									result:Play()
								end)
							end)
						end

						RunService.Heartbeat:Wait()
						v3 = v7
					end

					pcall(function() --[[ Line: 1334 | Upvalues: HapticService (ref) ]]
						HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0)
						HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
					end)
				end)
			end

			local v61 = 0
			local v62 = 0
			local v63 = 0
			local v64 = false
			local v65 = false
			local v66 = nil
			local v67 = false
			local t7 = {}
			local v68, HoldProgressBar

			if v2 then
				v68 = false
				HoldProgressBar = nil
			else
				HoldProgressBar = Instance.new("Frame")
				HoldProgressBar.Name = "HoldProgressBar"
				HoldProgressBar.AnchorPoint = Vector2.new(0, 0)
				HoldProgressBar.Position = UDim2.new(0, 0, 0, 0)
				HoldProgressBar.Size = UDim2.new(0, 0, 0, 4)
				HoldProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HoldProgressBar.BackgroundTransparency = 0.2
				HoldProgressBar.BorderSizePixel = 0
				HoldProgressBar.ZIndex = OfflineAnimation.BottomBar.ZIndex + 1
				HoldProgressBar.Parent = OfflineAnimation.BottomBar

				local function beginHold() --[[ beginHold | Line: 1474 | Upvalues: v66 (ref) ]]
					v66 = os.clock()
				end

				local function endHold() --[[ endHold | Line: 1478 | Upvalues: v66 (ref), HoldProgressBar (ref), TweenService (ref) ]]
					v66 = nil

					if not HoldProgressBar then
						return
					end

					TweenService:Create(HoldProgressBar, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
						Size = UDim2.new(0, 0, 0, 4)
					}):Play()
				end

				local function isHoldInput(p1) --[[ isHoldInput | Line: 1486 ]]
					return if p1.UserInputType == Enum.UserInputType.MouseButton1 then true else p1.UserInputType == Enum.UserInputType.Touch
				end

				table.insert(t7, UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 1491 | Upvalues: v66 (ref) ]]
					if not (if p1.UserInputType == Enum.UserInputType.MouseButton1 then true else p1.UserInputType == Enum.UserInputType.Touch) then
						return
					end

					v66 = os.clock()
				end))
				table.insert(t7, UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 1497 | Upvalues: endHold (copy) ]]
					if not (if p1.UserInputType == Enum.UserInputType.MouseButton1 then true else p1.UserInputType == Enum.UserInputType.Touch) then
						return
					end

					endHold()
				end))
				ContextActionService:BindActionAtPriority("OfflineCutsceneSkipHold", function(p1, p2, p3) --[[ Line: 1508 | Upvalues: v66 (ref), endHold (copy) ]]
					if p2 == Enum.UserInputState.Begin then
						v66 = os.clock()
					else
						if p2 ~= Enum.UserInputState.End and p2 ~= Enum.UserInputState.Cancel then
							return Enum.ContextActionResult.Pass
						end

						endHold()
					end

					return Enum.ContextActionResult.Pass
				end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonA, Enum.KeyCode.ButtonR2)
				v68 = true
			end

			task.spawn(function() --[[ Line: 1524 | Upvalues: p1 (copy), v10 (copy), effectiveGrowthTime (copy), actualOfflineTime (copy), v18 (copy), v11 (copy), v63 (ref), v62 (ref), v67 (ref), v65 (ref), v64 (ref) ]]
				local ok, result = pcall(function() --[[ Line: 1525 | Upvalues: p1 (ref), v10 (ref), effectiveGrowthTime (ref), actualOfflineTime (ref), v18 (ref), v11 (ref), v63 (ref), v62 (ref), v67 (ref) ]]
					return p1:AnimateOfflineGrowthAge(v10, {
						effectiveGrowthTime = effectiveGrowthTime,
						actualOfflineTime = actualOfflineTime,
						animationDuration = v18,
						changesByPlantId = v11,
						getAlpha = function() --[[ getAlpha | Line: 1531 | Upvalues: v63 (ref) ]]
							return v63
						end,
						getRawAlpha = function() --[[ getRawAlpha | Line: 1532 | Upvalues: v62 (ref) ]]
							return v62
						end,
						isSkipRequested = function() --[[ isSkipRequested | Line: 1533 | Upvalues: v67 (ref) ]]
							return v67
						end
					})
				end)

				v65 = if ok then result == true else false
				v64 = true
			end)

			while true do
				local v69 = os.clock() - v59
				local v70 = math.clamp(v69 / v18, 0, 1)
				local v72 = v70 < 0.5 and v70 * 2 * v70 or 1 - (v70 * -2 + 2) ^ 3 / 2

				if not v3 then
					Lighting.ClockTime = (ClockTime + v55 * v72) % 24
				end

				if v58 and v58.IsPlaying then
					v58.Volume = v70 ^ 1.6 * 2.25 + 0.35
				end

				if not v2 then
					if Date and Time then
						local v73 = os.date("*t", v30 + actualOfflineTime * v72)
						local day = v73.day

						Date.Text = string.format("%s %d%s %d", t6[v73.month], v73.day, if day == 1 or (day == 21 or day == 31) then "st" elseif day == 2 or day == 22 then "nd" elseif day == 3 or day == 23 then "rd" else "th", v73.year)

						local v76 = v73.hour % 12

						if v76 == 0 then
							v76 = 12
						end

						Time.Text = string.format("%d:%02d %s", v76, v73.min, if v73.hour >= 12 then "PM" else "AM")
					end

					for v78 in t5 do
						if v78:IsA("ScreenGui") then
							v78.Enabled = false
						end
					end
				end

				if not v1 then
					CurrentCamera.CameraType = Enum.CameraType.Scriptable

					local v79 = v34:Lerp(v31(v72, v70, v69, v61), (math.clamp(v35 * ((1 - v70) * 0.45 + 0.55) * v61, 0, 0.12)))

					CurrentCamera.CFrame = v79
					v34 = v79
				end

				if not v2 and v66 then
					local v81 = math.clamp((os.clock() - v66) / 1, 0, 1)

					if HoldProgressBar then
						HoldProgressBar.Size = UDim2.new(v81, 0, 0, 4)
					end

					if v81 >= 1 then
						v67 = true
					end
				end

				if v67 or v64 and (v65 and v18 <= v69) then
					for v82, v83 in t7 do
						v83:Disconnect()
					end

					if v68 then
						ContextActionService:UnbindAction("OfflineCutsceneSkipHold")
					end

					v60 = false
					pcall(function() --[[ Line: 1334 | Upvalues: HapticService (ref) ]]
						HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0)
						HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
					end)

					if v67 then
						p1:StopGrowthSound(v58, 0)
						p1:RestoreMusic(v57, 0.3)
					else
						p1:StopGrowthSound(v58, 1.5)
						p1:RestoreMusic(v57, 1.5)
					end

					if HoldProgressBar then
						HoldProgressBar:Destroy()
					end

					if not (v1 or v67) then
						local v84 = os.clock()

						while os.clock() - v84 < 2 do
							local v86 = math.clamp((os.clock() - v84) / 2, 0, 1)

							TweenService:GetValue(v86, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

							local v87 = v31(1, 1, os.clock() - v59, v61)
							local v89 = v34:Lerp(v87:Lerp(CFrame.new(v87.Position + Vector3.new(0, -1.25, 0) + v33 * 2, v32 + Vector3.new(0, 0.55, 0)), v86), (math.clamp(3.2 * v61, 0, 0.1)))

							CurrentCamera.CFrame = v89
							v34, v61 = v89, RunService.Heartbeat:Wait()
						end
					end

					if v23 then
						v23.Parent = v22.Parent
					end

					if v24 then
						v24:Disconnect()
					end

					for v91, v92 in t2 do
						local v93 = t3[v91]

						if v93 then
							v93:Disconnect()
							t3[v91] = nil
						end

						t4[v91] = nil

						if v91.Parent then
							v91.Enabled = v92
						end
					end

					table.clear(t2)

					if not v2 then
						if Date then
							Date.Visible = false
						end

						if Time then
							Time.Visible = false
						end

						if Title then
							Title.Visible = false
						end

						local HTSLabel = OfflineAnimation.BottomBar:FindFirstChild("HTSLabel")

						if HTSLabel then
							HTSLabel.Visible = false
						end

						TweenService:Create(OfflineAnimation.BottomBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
							Size = UDim2.fromScale(1, 0.5)
						}):Play()
						TweenService:Create(OfflineAnimation.TopBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
							Size = UDim2.fromScale(1, 0.5)
						}):Play()
						task.wait(0.5)
					end

					if not v3 then
						LightingController:SetImmediate({
							ClockTime = LightingController:GetCurrentTarget().ClockTime
						})
					end

					if not v2 then
						StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
						StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

						for v94, v95 in t5 do
							v94.Enabled = v95
						end
					end

					if not v64 then
						while not v64 do
							RunService.Heartbeat:Wait()
						end
					end

					p1:ApplyFinalGrowthState(v8, v10, getSpawnedPlant, getPlantGrowthData, isSingleHarvestPlant, addPlantHarvestPrompt, getSpawnedFruit, getFruitGrowthData, addFruitHarvestPrompt)

					if not v1 and v5 then
						local v96 = CurrentCamera.CFrame
						local v97 = if v21 then v21:ToObjectSpace(v19) else nil

						local function getLiveTarget() --[[ getLiveTarget | Line: 1757 | Upvalues: LocalPlayer (ref), v97 (copy), v19 (copy) ]]
							local Character = LocalPlayer.Character
							local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

							if v1 and (v1:IsA("BasePart") and v97) then
								return v1.CFrame * v97
							end

							return v19
						end

						local v98 = os.clock()

						while true do
							local v99
							local v101 = math.clamp((os.clock() - v98) / 0.3, 0, 1)
							local v102 = TweenService:GetValue(v101, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
							local Character2 = LocalPlayer.Character
							local v103 = if Character2 then Character2:FindFirstChild("HumanoidRootPart") else Character2

							v99 = if v103 and (v103:IsA("BasePart") and v97) then v103.CFrame * v97 else v19
							CurrentCamera.CFrame = v96:Lerp(v99, v102)

							if v101 >= 1 then
								break
							end

							RunService.Heartbeat:Wait()
						end

						CurrentCamera.CameraType = CameraType
						CurrentCamera.CameraSubject = CameraSubject
					elseif not v1 then
						CurrentCamera.CameraType = CameraType
						CurrentCamera.CameraSubject = CameraSubject
						CurrentCamera.CFrame = v19
					end

					if not v2 then
						TweenService:Create(OfflineAnimation.BottomBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
							BackgroundTransparency = 1
						}):Play()
						TweenService:Create(OfflineAnimation.TopBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
							BackgroundTransparency = 1
						}):Play()
					end

					clearGrowthHighlights()

					if not v9 then
						return true
					end

					LocalPlayer:SetAttribute("OfflineCutscenePlaying", false)

					return true
				end

				v61 = RunService.Heartbeat:Wait()
			end
		else
			if not v2 then
				TweenService:Create(OfflineAnimation.BottomBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundTransparency = 1
				}):Play()
				TweenService:Create(OfflineAnimation.TopBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundTransparency = 1
				}):Play()
			end

			clearGrowthHighlights()

			if not v9 then
				return false
			end

			LocalPlayer:SetAttribute("OfflineCutscenePlaying", false)

			return false
		end
	else
		clearGrowthHighlights()

		if not v9 then
			return false
		end

		LocalPlayer:SetAttribute("OfflineCutscenePlaying", false)

		return false
	end
end

return t