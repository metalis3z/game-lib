local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ZonePlus = require(ReplicatedStorage.Packages.ZonePlus)

local SpawnRequest = Net:RemoteEvent("AnimalSpawnService/SpawnRequest")
local FinishTutorial = Net:RemoteEvent("TutorialService/FinishTutorial")
local ToggleSetting = Net:RemoteFunction("SettingsService/ToggleSetting")

local SpawnedEvent = ReplicatedStorage.SpawnedEvent
local SpawnedAnimal = ReplicatedStorage.SpawnedAnimal

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local AdminPanelController = require(ReplicatedStorage.Controllers.AdminPanelController)

local AdminPanelGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("AdminPanel"):WaitForChild("Background")

local TutorialController = {
	TutorialBrainrotDestroyed = Signal.new(),
	EventStageOver = Signal.new(),
	ArrowTrove = Trove.new(),
	SpotlightTrove = Trove.new(),
	EventTrove = Trove.new(),
	HighlightTrove = Trove.new(),
	RunningTutorial = false,
}

function TutorialController:Start()
	task.spawn(function()
		local playerData = Synchronizer:Wait(LocalPlayer)

		if playerData:Get("SeenTutorial") then
			return
		end

		if not playerData:Get("Settings.Modded UIs") then
			ToggleSetting:InvokeServer("Modded UIs")
		end

		self.RunningTutorial = true

		self:SetArrow(workspace.TutorialZone.Position + Vector3.new(0, 10, 0))
		ZonePlus.new(workspace.TutorialZone).localPlayerEntered:Wait()

		local adminPanelButton = LocalPlayer.PlayerGui.LeftCenter.LeftCenter.Buttons.AdminPanel
		self:SetSpotlight(adminPanelButton)

		if not AdminPanelGui.Visible then
			AdminPanelGui:GetPropertyChangedSignal("Visible"):Wait()
		end

		self:SetArrow(nil)
		self:DisableTabs(true)

		local tabScrollFrame = AdminPanelGui.TabContent.ScrollingFrame
		local brainrotsTab = AdminPanelGui.Content.Brainrots

		self:SetSpotlight(brainrotsTab.List)

		local brainrotList = brainrotsTab.List
		local strawberryElephant = brainrotList:WaitForChild("Strawberry Elephant")

		tabScrollFrame.ScrollingEnabled = false

		for _, tab in pairs(tabScrollFrame:GetChildren()) do
			if tab:IsA("TextButton") or tab:IsA("ImageButton") then
				tab.Interactable = false
			end
		end

		for _, item in pairs(brainrotList:GetChildren()) do
			if (item:IsA("TextButton") or item:IsA("ImageButton")) and item ~= strawberryElephant then
				item.Interactable = false
			end
		end

		AdminPanelController:ChangeTab("Brainrots")
		task.wait(2)

		self:JumpScrollingFrame(brainrotList, strawberryElephant).Completed:Wait()
		self:SetSpotlight(strawberryElephant)

		local spawnButton = brainrotsTab.SpawnButton
		if not spawnButton:GetAttribute("Selected") then
			spawnButton:GetAttributeChangedSignal("Selected"):Wait()
		end

		self:SetSpotlight(spawnButton)
		SpawnedAnimal.Event:Wait()

		self:DisableTabs(true)

		for _, item in pairs(brainrotList:GetChildren()) do
			if item:IsA("TextButton") or item:IsA("ImageButton") then
				item.Interactable = true
			end
		end

		adminPanelButton.Interactable = false
		tabScrollFrame.ScrollingEnabled = true
		brainrotList.ScrollingEnabled = true

		self:SetSpotlight(nil)
		InterfaceController:Toggle("AdminPanel", false)

		self.TutorialBrainrotDestroyed:Wait()
		self.ArrowTrove:Clean()

		adminPanelButton.Interactable = true

		if playerData:Get("EventKeys.Keys") > 0 then
			self:SetSpotlight(adminPanelButton)
			AdminPanelGui:GetPropertyChangedSignal("Visible"):Wait()

			local eventsTab = AdminPanelGui.TabContent.ScrollingFrame.Events
			self:DisableTabs(true)
			eventsTab.Interactable = true

			self:SetSpotlight(eventsTab)

			if not eventsTab:GetAttribute("Active") then
				eventsTab:GetAttributeChangedSignal("Active"):Wait()
			end

			self:HighlightRandomEvent()
			self.EventStageOver:Wait()

			self.EventTrove:Clean()
			self:SetSpotlight(nil)
			InterfaceController:Toggle("AdminPanel", false)
			self:DisableTabs(false)
		end

		FinishTutorial:FireServer()
		self.RunningTutorial = false
	end)

	SpawnedEvent.Event:Connect(function()
		self.EventStageOver:Fire()
	end)

	SpawnRequest.OnClientEvent:Connect(function(animalId)
		if self.RunningTutorial then
			self:HighlightBrainrot(animalId)
		end
	end)
end

function TutorialController:DisableTabs(disabled)
	for _, tab in pairs(AdminPanelGui.TabContent.ScrollingFrame:GetChildren()) do
		if tab:IsA("TextButton") or tab:IsA("ImageButton") then
			tab.Interactable = not disabled
		end
	end
end

function TutorialController:JumpScrollingFrame(scrollFrame, targetFrame)
	local targetY = targetFrame.AbsolutePosition.Y - scrollFrame.AbsolutePosition.Y
	local newCanvasY = scrollFrame.CanvasPosition.Y + targetY - scrollFrame.AbsoluteSize.Y / 2 + targetFrame.AbsoluteSize.Y / 2
	local maxCanvasY = scrollFrame.AbsoluteCanvasSize.Y - scrollFrame.AbsoluteSize.Y
	local clampedY = math.clamp(newCanvasY, 0, maxCanvasY)

	local tween = TweenService:Create(
		scrollFrame,
		TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ CanvasPosition = Vector2.new(scrollFrame.CanvasPosition.X, clampedY) }
	)

	tween:Play()

	task.spawn(function()
		tween.Completed:Wait()
		scrollFrame.CanvasPosition = Vector2.new(scrollFrame.CanvasPosition.X, clampedY)
	end)

	return tween
end

function TutorialController:HighlightRandomEvent()
	local eventsData = Synchronizer:Wait("Events")
	local eventsList = AdminPanelGui.Content.Events.List

	local function updateHighlight()
		local activeEvents = eventsData:Get("ActiveEvents")
		local availableEvents = {}

		for _, eventFrame in pairs(eventsList:GetChildren()) do
			if eventFrame:IsA("ImageLabel") then
				local isActive = false

				for _, activeEvent in pairs(activeEvents) do
					if activeEvent.eventName == eventFrame.Name then
						isActive = true
						break
					end
				end

				if not isActive then
					table.insert(availableEvents, eventFrame)
				end
			end
		end

		if #availableEvents <= 0 then
			self.EventStageOver:Fire()
		else
			local randomEvent = availableEvents[math.random(1, #availableEvents)]
			self:JumpScrollingFrame(eventsList, randomEvent)
			self:SetSpotlight(randomEvent)
		end
	end

	updateHighlight()
	self.EventTrove:Add(eventsData:OnArrayInserted("ActiveEvents", updateHighlight))
end

function TutorialController:HighlightBrainrot(animalId)
	self.HighlightTrove:Clean()

	local function highlightAnimal(animalData)
		local pulseTime = 0
		local highlight = Instance.new("Highlight")
		highlight.FillColor = Color3.fromRGB(255, 255, 0)
		highlight.Parent = animalData.AnimalModel

		self.HighlightTrove:Add(RunService.RenderStepped:Connect(function(deltaTime)
			pulseTime = (pulseTime + deltaTime) % 1
			local angle = pulseTime * math.pi * 2
			highlight.FillTransparency = (math.sin(angle) + 1) / 2 * 0.5
		end))

		self.HighlightTrove:Add(animalData.AnimalModel.Destroying:Connect(function()
			self.TutorialBrainrotDestroyed:Fire()
			self.HighlightTrove:Clean()
		end))

		self.HighlightTrove:Add(highlight)
		self:SetArrow(animalData.AnimalModel.PrimaryPart)
	end

	if AnimalController:GetAnimals()[animalId] then
		highlightAnimal(AnimalController:GetAnimals()[animalId])
	else
		local connection
		connection = AnimalController.OnAnimalSpawn:Connect(function()
			if AnimalController:GetAnimals()[animalId] then
				highlightAnimal(AnimalController:GetAnimals()[animalId])
				connection:Disconnect()
			end
		end)
		self.HighlightTrove:Add(connection)
	end
end

function TutorialController:SetArrow(target)
	self.ArrowTrove:Clean()

	if target then
		local hrp = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
		local arrow = self.ArrowTrove:Clone(script.TutorialArrow)
		arrow.Parent = workspace
		arrow.Start.CFrame = hrp.CFrame

		local weld = Instance.new("WeldConstraint", arrow.Start)
		weld.Part0 = hrp
		weld.Part1 = arrow.Start
		self.ArrowTrove:Add(weld)

		if typeof(target) == "Instance" then
			arrow.End.CFrame = CFrame.new(target.Position)
			local endWeld = Instance.new("WeldConstraint", arrow.End)
			endWeld.Part0 = arrow.End
			endWeld.Part1 = target
			self.ArrowTrove:Add(endWeld)
			return
		end

		arrow.End.Anchored = true
		arrow.End.CFrame = CFrame.new(target)
	end
end

function TutorialController:SetSpotlight(target)
	self.SpotlightTrove:Clean()

	if target then
		local spotlightGui = self.SpotlightTrove:Clone(script.SpotlightGui)
		local spotlightFrame = spotlightGui:WaitForChild("SpotlightFrame")
		spotlightFrame.Position = UDim2.fromScale(0.5, 0.5)
		spotlightFrame.Size = UDim2.fromScale(2, 2)
		spotlightGui.Parent = LocalPlayer.PlayerGui

		local uiScale = Instance.new("UIScale", spotlightFrame)
		local pulseTime = 0

		self.SpotlightTrove:Add(RunService.RenderStepped:Connect(function(deltaTime)
			pulseTime = (pulseTime + deltaTime) % 1
			local angle = pulseTime * math.pi * 2
			uiScale.Scale = (math.sin(angle) + 1) / 2 * 0.1 + 1
		end))

		if typeof(target) == "table" then
			TweenService:Create(
				spotlightFrame,
				TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ Size = target.Size, Position = target.Position }
			):Play()
		elseif typeof(target) == "Instance" then
			local function updateSpotlight()
				local center = target.AbsolutePosition + target.AbsoluteSize / 2
				local guiSize = spotlightGui.AbsoluteSize
				local position = UDim2.fromScale(center.X / guiSize.X, center.Y / guiSize.Y)
				local size = UDim2.fromScale(
					target.AbsoluteSize.X / guiSize.X * 1.05,
					target.AbsoluteSize.Y / guiSize.Y * 1.05
				)

				TweenService:Create(
					spotlightFrame,
					TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{ Size = size, Position = position }
				):Play()
			end

			updateSpotlight()
			self.SpotlightTrove:Add(target:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSpotlight))
			self.SpotlightTrove:Add(target:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateSpotlight))
		end
	end
end

return TutorialController