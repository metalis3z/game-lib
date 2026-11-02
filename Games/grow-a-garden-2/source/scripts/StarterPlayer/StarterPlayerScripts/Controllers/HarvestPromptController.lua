--credit to prince games studio
local t = {}
local CollectionService = game:GetService("CollectionService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DevProductController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController)
local v1 = nil
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HoldToCollect = PlayerGui:WaitForChild("HoldToCollect")
local Collect = HoldToCollect:WaitForChild("Collect")
local HoldToSteal = PlayerGui:WaitForChild("HoldToSteal")
local Collect2 = HoldToSteal:WaitForChild("Collect")
local t2 = {}
local t3 = {}
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = 0

local function isBlockedBambooSteal(p1) --[[ isBlockedBambooSteal | Line: 40 ]]
	return p1:HasTag("StealPrompt") and p1.HoldDuration > 0
end

local function triggerPromptProgrammatically(p1) --[[ triggerPromptProgrammatically | Line: 44 ]]
	p1:InputHoldBegin()

	if p1.HoldDuration > 0 then
		task.delay(p1.HoldDuration + 0.05, function() --[[ Line: 47 | Upvalues: p1 (copy) ]]
			if not (p1 and p1:IsDescendantOf(workspace)) then
				return
			end

			p1:InputHoldEnd()
		end)
	else
		p1:InputHoldEnd()
	end
end

local t4 = {
	{
		name = "Harvest",
		tag = "HarvestPrompt",
		holding = false,
		pressing = false,
		activateOnTrigger = true,
		ui = HoldToCollect,
		button = Collect,
		visible = {},
		queue = {},
		perform = function(p1, p2, p3, p4) --[[ perform | Line: 67 | Upvalues: v1 (ref) ]]
			v1.Garden.CollectFruit:Fire(p3, p4 or "")
		end
	},
	{
		name = "Steal",
		tag = "StealPrompt",
		holding = false,
		pressing = false,
		activateOnTrigger = false,
		ui = HoldToSteal,
		button = Collect2,
		visible = {},
		queue = {},
		gate = function() --[[ isNight | Line: 72 | Upvalues: ReplicatedStorage (copy) ]]
			local Night = ReplicatedStorage:FindFirstChild("Night")

			return if Night == nil then false else Night.Value == true
		end,
		perform = function(p1, p2, p3, p4) --[[ perform | Line: 88 | Upvalues: triggerPromptProgrammatically (copy) ]]
			triggerPromptProgrammatically(p1)
		end
	}
}

local function getChannelForPrompt(p1) --[[ getChannelForPrompt | Line: 95 | Upvalues: t4 (copy) ]]
	for v1, v2 in t4 do
		if p1:HasTag(v2.tag) then
			return v2
		end
	end

	return nil
end

local function getCharacterPosition() --[[ getCharacterPosition | Line: 104 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		return HumanoidRootPart.Position
	end

	return nil
end

local function getModelForPrompt(p1) --[[ getModelForPrompt | Line: 118 ]]
	local v1 = p1.Parent

	if v1 then
		return v1:FindFirstAncestorWhichIsA("Model")
	end

	return nil
end

local function getClosestPointOnPart(p1, p2) --[[ getClosestPointOnPart | Line: 127 ]]
	local v1 = p1.CFrame:PointToObjectSpace(p2)
	local v2 = p1.Size * 0.5

	return p1.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))))
end

local function getBestPromptPosition(p1, p2) --[[ getBestPromptPosition | Line: 140 | Upvalues: getClosestPointOnPart (copy) ]]
	local v1 = (1 / 0)
	local v2 = nil

	for v3, v4 in p1 do
		if v4.Parent then
			local v5 = getClosestPointOnPart(v4, p2)
			local Magnitude = (p2 - v5).Magnitude

			if Magnitude < v1 then
				v1 = Magnitude
				v2 = v5
			end
		end
	end

	if not v2 then
		return nil
	end

	local v6 = p2 - v2

	return v2 + (if v6.Magnitude < 0.0001 then Vector3.new(0, 1, 0) else v6.Unit) * 0.75
end

local function rebuildHarvestPartCache(p1) --[[ rebuildHarvestPartCache | Line: 169 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and v2.Name ~= "HarvestPart" then
			table.insert(t, v2)
		end
	end

	return t
end

local function getOrCreateModelHarvestPart(p1) --[[ getOrCreateModelHarvestPart | Line: 179 ]]
	local HarvestPart = p1:FindFirstChild("HarvestPart")

	if HarvestPart and HarvestPart:IsA("BasePart") then
		return HarvestPart
	end

	local v1 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")

	if v1 then
		local HarvestPart2 = Instance.new("Part")

		HarvestPart2.Name = "HarvestPart"
		HarvestPart2.Size = Vector3.new(1, 1, 1)
		HarvestPart2.Transparency = 1
		HarvestPart2.Anchored = true
		HarvestPart2.CanCollide = false
		HarvestPart2.CanTouch = false
		HarvestPart2.CanQuery = false
		HarvestPart2.CFrame = v1.CFrame
		HarvestPart2.Parent = p1

		return HarvestPart2
	end

	return nil
end

local function destroyCurrentHighlight() --[[ destroyCurrentHighlight | Line: 204 | Upvalues: v2 (ref), v3 (ref) ]]
	if v2 then
		v2:Destroy()
		v2 = nil
	end

	v3 = nil
end

local function applyHighlightToModel(p1) --[[ applyHighlightToModel | Line: 212 | Upvalues: v3 (ref), v2 (ref) ]]
	if v3 == p1 and (v2 and v2.Parent) then
		return
	end

	local ActiveHarvestHighlight

	if not v2 then
		v3 = nil
		ActiveHarvestHighlight = Instance.new("Highlight")
		ActiveHarvestHighlight.Name = "ActiveHarvestHighlight"
		ActiveHarvestHighlight.Adornee = p1
		ActiveHarvestHighlight.FillColor = Color3.fromRGB(255, 224, 94)
		ActiveHarvestHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		ActiveHarvestHighlight.FillTransparency = 1
		ActiveHarvestHighlight.OutlineTransparency = 0.5
		ActiveHarvestHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
		ActiveHarvestHighlight.Parent = p1
		v2 = ActiveHarvestHighlight
		v3 = p1

		return
	end

	v2:Destroy()
	v2 = nil
	v3 = nil
	ActiveHarvestHighlight = Instance.new("Highlight")
	ActiveHarvestHighlight.Name = "ActiveHarvestHighlight"
	ActiveHarvestHighlight.Adornee = p1
	ActiveHarvestHighlight.FillColor = Color3.fromRGB(255, 224, 94)
	ActiveHarvestHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	ActiveHarvestHighlight.FillTransparency = 1
	ActiveHarvestHighlight.OutlineTransparency = 0.5
	ActiveHarvestHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
	ActiveHarvestHighlight.Parent = p1
	v2 = ActiveHarvestHighlight
	v3 = p1
end

local function updateActivePromptHighlight() --[[ updateActivePromptHighlight | Line: 233 | Upvalues: LocalPlayer (copy), v2 (ref), v3 (ref), t2 (copy), applyHighlightToModel (copy) ]]
	local Character = LocalPlayer.Character
	local v1

	if Character then
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		v1 = if HumanoidRootPart then HumanoidRootPart.Position else nil
	else
		v1 = nil
	end

	if v1 then
		local v22 = (1 / 0)
		local v32 = nil

		for v5 in t2 do
			local v4

			if v5:IsDescendantOf(workspace) and v5.Enabled then
				local v6 = v5.Parent

				v4 = if v6 then v6:FindFirstAncestorWhichIsA("Model") else nil

				if v4 then
					local _, v8 = v4:GetBoundingBox()
					local v9 = (v1 - v4:GetPivot().Position).Magnitude - v8.Magnitude * 0.5

					if v9 < v22 then
						v22 = v9
						v32 = v5
					end
				end
			end
		end

		if v32 then
			local v10 = v32.Parent
			local v11 = if v10 then v10:FindFirstAncestorWhichIsA("Model") else nil

			if v11 then
				applyHighlightToModel(v11)

				return
			end
		end
	end

	if not v2 then
		v3 = nil

		return
	end

	v2:Destroy()
	v2 = nil
	v3 = nil
end

local function isSmartPrompt(p1) --[[ isSmartPrompt | Line: 270 ]]
	return p1:HasTag("HarvestPrompt") or (p1:HasTag("StealPrompt") or p1:HasTag("GrowPrompt"))
end

local function trackSmartPrompt(p1) --[[ trackSmartPrompt | Line: 276 | Upvalues: t3 (copy), getOrCreateModelHarvestPart (copy), rebuildHarvestPartCache (copy), t2 (copy), t4 (copy), updateActivePromptHighlight (copy), v4 (ref) ]]
	if t3[p1] then
		return
	end

	if not p1:IsDescendantOf(workspace) then
		return
	end

	local v1 = p1.Parent
	local v2 = if v1 then v1:FindFirstAncestorWhichIsA("Model") else nil
	local v3 = p1.Parent

	if not (v2 and (v3 and v3:IsA("BasePart"))) then
		return
	end

	p1.MaxActivationDistance = 10

	if v3.Name ~= "HarvestPart" then
		local v42 = getOrCreateModelHarvestPart(v2)

		if v42 then
			p1.Parent = v42
			v3 = v42
		end
	end

	local t = {
		needsSnap = true,
		model = v2,
		part = v3,
		parts = rebuildHarvestPartCache(v2),
		boundingRadius = select(2, v2:GetBoundingBox()).Magnitude * 0.5
	}

	local function refreshParts(p1) --[[ refreshParts | Line: 308 | Upvalues: t (copy), rebuildHarvestPartCache (ref), v2 (copy) ]]
		if not p1 or p1:IsA("BasePart") then
			t.parts = rebuildHarvestPartCache(v2)
			t.boundingRadius = select(2, v2:GetBoundingBox()).Magnitude * 0.5
		end
	end

	t.partsConn = v2.DescendantAdded:Connect(refreshParts)
	t.partsRemovedConn = v2.DescendantRemoving:Connect(refreshParts)
	t3[p1] = t
	p1.Destroying:Once(function() --[[ Line: 319 | Upvalues: t3 (ref), p1 (copy), t2 (ref), t4 (ref), updateActivePromptHighlight (ref), v4 (ref) ]]
		local v1 = t3[p1]

		if v1 then
			if v1.partsConn then
				v1.partsConn:Disconnect()
			end

			if v1.partsRemovedConn then
				v1.partsRemovedConn:Disconnect()
			end
		end

		t3[p1] = nil
		t2[p1] = nil

		for v2, v3 in t4 do
			v3.visible[p1] = nil
		end

		updateActivePromptHighlight()
		v4()
	end)
end

local function updateSmartPromptPositions(p1) --[[ updateSmartPromptPositions | Line: 335 | Upvalues: LocalPlayer (copy), t3 (copy), getBestPromptPosition (copy) ]]
	local Character = LocalPlayer.Character
	local v1

	if Character then
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		v1 = if HumanoidRootPart then HumanoidRootPart.Position else nil
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	local v2 = math.clamp(p1 * 18, 0, 1)

	for v3, v4 in t3 do
		if v3:IsDescendantOf(workspace) then
			local model = v4.model
			local part = v4.part

			if model and (model:IsDescendantOf(workspace) and (part and part.Parent)) then
				-- PERF: el reposicionamiento del prompt es solo cosmetico y solo
				-- importa cuando el prompt esta visible. Saltar los prompts no
				-- mostrados (t2) evita recorrer GetPivot()+getBestPromptPosition
				-- (que itera TODAS las partes del modelo) sobre cada planta/fruta
				-- del mundo cada frame -> el lag escala con la cantidad de plantas.
				if not t2[v3] then
					continue
				end

				local Position = model:GetPivot().Position

				if not (math.max(24, v3.MaxActivationDistance + 8) < (Position - v1).Magnitude - (v4.boundingRadius or 0)) then
					local v6 = getBestPromptPosition(v4.parts, v1)

					if v6 then
						if v4.needsSnap then
							part.CFrame = CFrame.new(v6)
							v4.needsSnap = false

							continue
						end

						part.CFrame = CFrame.new((part.Position:Lerp(v6, v2)))
					end
				end

				continue
			end

			if v4.partsConn then
				v4.partsConn:Disconnect()
			end

			if v4.partsRemovedConn then
				v4.partsRemovedConn:Disconnect()
			end

			t3[v3] = nil

			continue
		end

		if v4.partsConn then
			v4.partsConn:Disconnect()
		end

		if v4.partsRemovedConn then
			v4.partsRemovedConn:Disconnect()
		end

		t3[v3] = nil
	end
end

local function isMobile() --[[ isMobile | Line: 381 | Upvalues: UserInputService (copy) ]]
	return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local function f6(p1) --[[ Line: 385 | Upvalues: UserInputService (copy) ]]
	if not (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled) then
		p1.ui.Enabled = false

		return
	end

	p1.ui.Enabled = true

	if p1.gate and not p1.gate() then
		p1.button.Visible = false

		return
	end

	if p1.pressing then
		p1.button.Visible = true

		return
	end

	local v2 = false

	for v3 in p1.visible do
		if v3:IsDescendantOf(workspace) and v3.Enabled and not (v3:HasTag("StealPrompt") and v3.HoldDuration > 0) then
			v2 = true

			break
		end
	end

	p1.button.Visible = v2
end

v4 = function() --[[ Line: 413 | Upvalues: t4 (copy), f6 (ref) ]]
	for v1, v2 in t4 do
		f6(v2)
	end
end

local function activatePrompt(p1, p2) --[[ activatePrompt | Line: 419 ]]
	if p1.gate and not p1.gate() then
		return false
	end

	if not p2:IsDescendantOf(workspace) then
		return false
	end

	if not p2.Enabled then
		return false
	end

	if p2:GetAttribute("Collected") then
		return false
	end

	if p2:HasTag("StealPrompt") and (if p2.HoldDuration > 0 then true else false) then
		return false
	end

	local v2 = p2.Parent

	if not v2 then
		return false
	end

	local v3 = v2:FindFirstAncestorWhichIsA("Model")

	if not v3 then
		return false
	end

	local v4 = v3:GetAttribute("PlantId")
	local v5 = v3:GetAttribute("FruitId")

	if p1.activateOnTrigger and not v4 then
		return false
	end

	p2:SetAttribute("Collected", true)
	task.delay(math.max(0.09, p2.HoldDuration + 0.1), function() --[[ Line: 440 | Upvalues: p2 (copy) ]]
		if not (p2 and p2:IsDescendantOf(workspace)) then
			return
		end

		p2:SetAttribute("Collected", nil)
	end)
	p1.perform(p2, v3, v4, v5)

	return true
end

local function enqueue(p1, p2) --[[ enqueue | Line: 451 ]]
	if table.find(p1.queue, p2) then
		return
	end

	table.insert(p1.queue, p2)
end

local function dequeue(p1) --[[ dequeue | Line: 457 ]]
	if #p1.queue == 0 then
		return nil
	end

	return table.remove(p1.queue, 1)
end

local function runHoldLoop(p1) --[[ runHoldLoop | Line: 462 | Upvalues: ProximityPromptService (copy), activatePrompt (copy) ]]
	if p1.holding then
		return
	end

	p1.holding = true

	for v1 in p1.visible do
		if not table.find(p1.queue, v1) then
			table.insert(p1.queue, v1)
		end
	end

	local v2 = ProximityPromptService.PromptShown:Connect(function(p12) --[[ Line: 470 | Upvalues: p1 (copy) ]]
		if not p12:HasTag(p1.tag) then
			return
		end

		local v1 = p1

		if table.find(v1.queue, p12) then
			return
		end

		table.insert(v1.queue, p12)
	end)

	while p1.holding do
		if #p1.queue == 0 then
			for v3 in p1.visible do
				if not table.find(p1.queue, v3) then
					table.insert(p1.queue, v3)
				end
			end
		end

		local v4 = if #p1.queue == 0 then nil else table.remove(p1.queue, 1)

		if v4 then
			activatePrompt(p1, v4)
		end

		task.wait(0.1)
	end

	v2:Disconnect()
	table.clear(p1.queue)
end

local function stopHoldLoop(p1) --[[ stopHoldLoop | Line: 494 | Upvalues: f6 (ref) ]]
	p1.holding = false
	p1.pressing = false
	f6(p1)
end

local function stopAllHoldLoops() --[[ stopAllHoldLoops | Line: 500 | Upvalues: t4 (copy), f6 (ref) ]]
	for v1, v2 in t4 do
		v2.holding = false
		v2.pressing = false
		f6(v2)
	end
end

local function beginKeyboardHoldWatch(p1) --[[ beginKeyboardHoldWatch | Line: 506 | Upvalues: UserInputService (copy), runHoldLoop (copy) ]]
	local v1 = false
	local v2 = nil

	v2 = UserInputService.InputEnded:Connect(function(p1) --[[ Line: 509 | Upvalues: v2 (ref), v1 (ref) ]]
		if p1.KeyCode ~= Enum.KeyCode.E and p1.KeyCode ~= Enum.KeyCode.ButtonX then
			return
		end

		v2:Disconnect()
		v1 = true
	end)
	task.wait(0.5)

	if v1 then
		return
	end

	v2:Disconnect()
	runHoldLoop(p1)
end

local function bindChannelButton(p1) --[[ bindChannelButton | Line: 524 | Upvalues: f6 (ref), activatePrompt (copy), runHoldLoop (copy) ]]
	if p1.button:IsA("GuiButton") then
		p1.button.MouseButton1Down:Connect(function() --[[ Line: 529 | Upvalues: p1 (copy), f6 (ref), activatePrompt (ref), runHoldLoop (ref) ]]
			p1.pressing = true
			f6(p1)

			for v1 in p1.visible do
				activatePrompt(p1, v1)
			end

			local v2 = false
			local v3 = p1.button.MouseButton1Up:Once(function() --[[ Line: 539 | Upvalues: v2 (ref) ]]
				v2 = true
			end)

			task.wait(0.5)

			if v3.Connected then
				v3:Disconnect()
			end

			if v2 then
				return
			end

			runHoldLoop(p1)
		end)
		p1.button.MouseButton1Up:Connect(function() --[[ Line: 554 | Upvalues: p1 (copy), f6 (ref) ]]
			local v1 = p1

			v1.holding = false
			v1.pressing = false
			f6(v1)
		end)
	end
end

function t.Init(p1) --[[ Init | Line: 559 | Upvalues: v1 (ref), ReplicatedStorage (copy), v4 (ref), CollectionService (copy), trackSmartPrompt (copy), ProximityPromptService (copy), t2 (copy), updateActivePromptHighlight (copy), t4 (copy), f6 (ref), bindChannelButton (copy), activatePrompt (copy), UserInputService (copy), beginKeyboardHoldWatch (copy), DevProductController (copy), stopAllHoldLoops (copy), LocalPlayer (copy), RunService (copy), updateSmartPromptPositions (copy), v5 (ref) ]]
	v1 = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
	v4()
	task.spawn(function() --[[ Line: 564 | Upvalues: ReplicatedStorage (ref), v4 (ref) ]]
		local Night = ReplicatedStorage:WaitForChild("Night", 10)

		if not Night then
			return
		end

		Night.Changed:Connect(v4)
	end)

	for v12, v2 in { "HarvestPrompt", "StealPrompt", "GrowPrompt" } do
		for v3, v42 in CollectionService:GetTagged(v2) do
			if v42:IsA("ProximityPrompt") then
				trackSmartPrompt(v42)
			end
		end

		CollectionService:GetInstanceAddedSignal(v2):Connect(function(p1) --[[ Line: 578 | Upvalues: trackSmartPrompt (ref) ]]
			if not p1:IsA("ProximityPrompt") then
				return
			end

			trackSmartPrompt(p1)
		end)
	end

	ProximityPromptService.PromptShown:Connect(function(p1) --[[ Line: 585 | Upvalues: trackSmartPrompt (ref), t2 (ref), updateActivePromptHighlight (ref), t4 (ref), f6 (ref) ]]
		if p1:HasTag("HarvestPrompt") or (p1:HasTag("StealPrompt") or p1:HasTag("GrowPrompt")) then
			trackSmartPrompt(p1)
			t2[p1] = true
			updateActivePromptHighlight()
		end

		local v2 = nil

		for v3, v4 in t4 do
			if p1:HasTag(v4.tag) then
				v2 = v4

				break
			end
		end

		if not v2 then
			return
		end

		v2.visible[p1] = true
		f6(v2)
	end)
	ProximityPromptService.PromptHidden:Connect(function(p1) --[[ Line: 599 | Upvalues: t4 (ref), f6 (ref), t2 (ref), updateActivePromptHighlight (ref) ]]
		local v1 = nil

		for v2, v3 in t4 do
			if p1:HasTag(v3.tag) then
				v1 = v3

				break
			end
		end

		if v1 then
			v1.visible[p1] = nil
			f6(v1)
		end

		if not (p1:HasTag("HarvestPrompt") or (p1:HasTag("StealPrompt") or p1:HasTag("GrowPrompt"))) then
			return
		end

		t2[p1] = nil
		updateActivePromptHighlight()
	end)

	for v52, v6 in t4 do
		bindChannelButton(v6)
	end

	ProximityPromptService.PromptTriggered:Connect(function(p1) --[[ Line: 616 | Upvalues: t4 (ref), activatePrompt (ref) ]]
		local v1 = nil

		for v2, v3 in t4 do
			if p1:HasTag(v3.tag) then
				v1 = v3

				break
			end
		end

		if not (v1 and v1.activateOnTrigger) then
			return
		end

		activatePrompt(v1, p1)
	end)
	ProximityPromptService.PromptTriggered:Connect(function(p1) --[[ Line: 623 | Upvalues: t4 (ref), UserInputService (ref), beginKeyboardHoldWatch (ref) ]]
		local v1 = nil

		for v2, v3 in t4 do
			if p1:HasTag(v3.tag) then
				v1 = v3

				break
			end
		end

		if not v1 then
			return
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX) then
			beginKeyboardHoldWatch(v1)
		end
	end)
	ProximityPromptService.PromptTriggered:Connect(function(p1) --[[ Line: 634 | Upvalues: v1 (ref), DevProductController (ref) ]]
		if not p1:HasTag("GrowPrompt") then
			return
		end

		local v12 = p1.Parent
		local v2 = if v12 then v12:FindFirstAncestorWhichIsA("Model") else nil

		if not v2 then
			return
		end

		local v4 = v2:GetAttribute("PlantId")

		if not v4 then
			return
		end

		v1.GrowPlant:Fire(v4)
		DevProductController:PromptPurchase("Standalone:Grow Plant:1")
	end)
	UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 645 | Upvalues: t4 (ref), beginKeyboardHoldWatch (ref) ]]
		if p1.KeyCode ~= Enum.KeyCode.E and p1.KeyCode ~= Enum.KeyCode.ButtonX then
			return
		end

		for v1, v2 in t4 do
			if next(v2.visible) ~= nil then
				task.spawn(beginKeyboardHoldWatch, v2)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(p1) --[[ Line: 655 | Upvalues: t4 (ref), f6 (ref) ]]
		if p1.KeyCode ~= Enum.KeyCode.E and p1.KeyCode ~= Enum.KeyCode.ButtonX then
			return
		end

		for v1, v2 in t4 do
			v2.holding = false
			v2.pressing = false
			f6(v2)
		end
	end)
	UserInputService.InputEnded:Connect(function(p1) --[[ Line: 661 | Upvalues: t4 (ref), f6 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		for v1, v2 in t4 do
			v2.holding = false
			v2.pressing = false
			f6(v2)
		end
	end)
	UserInputService.WindowFocusReleased:Connect(stopAllHoldLoops)
	updateActivePromptHighlight()
	v4()
	LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 672 | Upvalues: updateActivePromptHighlight (ref), v4 (ref) ]]
		task.defer(function() --[[ Line: 673 | Upvalues: updateActivePromptHighlight (ref), v4 (ref) ]]
			updateActivePromptHighlight()
			v4()
		end)
	end)
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 679 | Upvalues: updateSmartPromptPositions (ref), v5 (ref), updateActivePromptHighlight (ref) ]]
		debug.profilebegin("Controllers/HarvestPromptController/Heartbeat")
		updateSmartPromptPositions(p1)
		v5 = v5 + 1

		if v5 >= 3 then
			v5 = 0
			updateActivePromptHighlight()
		end

		debug.profileend()
	end)
end
function t.Start(p1) --[[ Start | Line: 691 ]] end

return t