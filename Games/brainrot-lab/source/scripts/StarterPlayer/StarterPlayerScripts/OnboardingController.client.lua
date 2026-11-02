--!strict
-- LOCATION: StarterPlayerScripts/OnboardingController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [ ASSETS ]
local Templates = ReplicatedStorage:WaitForChild("Templates")
local BeamTemplate = Templates:WaitForChild("OnboardingBeam")
local Events = ReplicatedStorage:WaitForChild("Events")
local SetStepEvent = Events:WaitForChild("SetOnboardingStep")

-- [ UI REFERENCES ]
local mainGui = playerGui:WaitForChild("GUI")
local frames = mainGui:WaitForChild("Frames")
local notifFrame = frames:WaitForChild("Notifications")
local instructionsLabel = notifFrame:WaitForChild("Instructions") :: TextLabel

-- [ STATE ]
local currentStep = 0
local activeBeam: Beam?
local activeAttachment0: Attachment?
local activeAttachment1: Attachment?

local moneyConnection: RBXScriptConnection?

print("[OnboardingController] Initialized (No-Regression Patch Applied)")

-- [ HELPERS ]

local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local function checkHasItemTool()
	local char = player.Character
	local bp = player:FindFirstChild("Backpack")

	if char then
		for _, t in ipairs(char:GetChildren()) do
			if t:IsA("Tool") and not t:GetAttribute("IsWeight") then return true end
		end
	end
	if bp then
		for _, t in ipairs(bp:GetChildren()) do
			if t:IsA("Tool") and not t:GetAttribute("IsWeight") then return true end
		end
	end
	return false
end

local function checkHasWeightTool()
	local char = player.Character
	local bp = player:FindFirstChild("Backpack")

	if char then
		for _, t in ipairs(char:GetChildren()) do
			if t:IsA("Tool") and t:GetAttribute("IsWeight") then return true end
		end
	end
	if bp then
		for _, t in ipairs(bp:GetChildren()) do
			if t:IsA("Tool") and t:GetAttribute("IsWeight") then return true end
		end
	end
	return false
end

local function checkSlots()
	local plotName = "Plot_" .. player.Name
	local plot = Workspace:FindFirstChild(plotName)
	if not plot then return false, nil end

	local floor1 = plot:FindFirstChild("Floor1")
	local slots = floor1 and floor1:FindFirstChild("Slots")
	if slots then
		for _, slot in ipairs(slots:GetChildren()) do
			local sp = slot:FindFirstChild("Spawn")
			if sp and sp:FindFirstChild("VisualItem") then
				return true, slot
			end
		end
	end
	return false, nil
end

local function cleanupVisuals()
	if activeBeam then activeBeam:Destroy() end
	if activeAttachment0 then activeAttachment0:Destroy() end
	if activeAttachment1 then activeAttachment1:Destroy() end

	activeBeam = nil
	activeAttachment0 = nil
	activeAttachment1 = nil

	instructionsLabel.Visible = false

	if moneyConnection then moneyConnection:Disconnect(); moneyConnection = nil end
end

local function setupBeam(targetPart: BasePart)
	local char = getCharacter()
	local root = char:WaitForChild("HumanoidRootPart") :: BasePart

	cleanupVisuals()

	local att0 = Instance.new("Attachment")
	att0.Name = "OnboardingAtt0"
	att0.Parent = root
	activeAttachment0 = att0

	local att1 = Instance.new("Attachment")
	att1.Name = "OnboardingAtt1"
	att1.Parent = targetPart
	activeAttachment1 = att1

	local beam = BeamTemplate:Clone()
	beam.Attachment0 = att1 
	beam.Attachment1 = att0 

	beam.Parent = root
	activeBeam = beam
end

-- [ FORWARD DECLARATIONS ]
local startStep1, startStep2, startStep3, startStep4, startStep5, startStep6

-- [ STEP 1: GO TO KICK ZONE ]
startStep1 = function()
	currentStep = 1

	-- If they already completed step 3 (they have an item or placed it), skip step 1
	if checkHasItemTool() or checkSlots() then
		SetStepEvent:FireServer(4)
		startStep4()
		return
	end

	local kickPart = Workspace:WaitForChild("KickPart", 10) :: BasePart
	if kickPart then
		setupBeam(kickPart)
	end

	instructionsLabel.Text = "Go to kick zone!"
	instructionsLabel.Visible = true

	task.spawn(function()
		while currentStep == 1 do
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if kickPart and root then
				local relPos = kickPart.CFrame:PointToObjectSpace(root.Position)
				local size = kickPart.Size

				local isInside = math.abs(relPos.X) <= size.X / 2 and
					math.abs(relPos.Y) <= (size.Y / 2) + 15 and
					math.abs(relPos.Z) <= size.Z / 2

				if isInside then
					print("[Onboarding] Reached kick zone")
					cleanupVisuals()
					SetStepEvent:FireServer(2)
					startStep2()
					break
				end
			end

			-- Dynamic safeguard
			if checkHasItemTool() or checkSlots() then
				cleanupVisuals()
				SetStepEvent:FireServer(4) 
				startStep4()
				break
			end

			task.wait(0.2)
		end
	end)
end

-- [ STEP 2: KICK A LUCKY BLOCK ]
startStep2 = function()
	currentStep = 2

	-- If they already completed step 3 (they have an item or placed it), skip step 2
	if checkHasItemTool() or checkSlots() then
		SetStepEvent:FireServer(4)
		startStep4()
		return
	end

	cleanupVisuals()

	instructionsLabel.Text = "Kick a lucky block!"
	instructionsLabel.Visible = true

	task.spawn(function()
		local kickPart = Workspace:FindFirstChild("KickPart") :: BasePart
		while currentStep == 2 do
			local char = player.Character

			if char and char:FindFirstChild("ActiveMorph") then
				print("[Onboarding] Morphed!")
				cleanupVisuals()
				SetStepEvent:FireServer(3) 
				startStep3()
				break
			end

			local root = char and char:FindFirstChild("HumanoidRootPart")
			if kickPart and root then
				local relPos = kickPart.CFrame:PointToObjectSpace(root.Position)
				local size = kickPart.Size
				local isInside = math.abs(relPos.X) <= size.X / 2 and
					math.abs(relPos.Y) <= (size.Y / 2) + 15 and
					math.abs(relPos.Z) <= size.Z / 2

				if not isInside and not (char and char:FindFirstChild("ActiveMorph")) then
					print("[Onboarding] Left kick zone, reverting to Step 1")
					cleanupVisuals()
					SetStepEvent:FireServer(1)
					startStep1()
					break
				end
			end

			task.wait(0.2)
		end
	end)
end

-- [ STEP 3: ESCAPE TSUNAMI ]
startStep3 = function()
	currentStep = 3

	-- Double check safeguard
	if checkHasItemTool() or checkSlots() then
		SetStepEvent:FireServer(4)
		startStep4()
		return
	end

	local plotName = "Plot_" .. player.Name
	local plot = Workspace:WaitForChild(plotName, 10)
	if plot then
		local plotSpawn = plot:FindFirstChild("Spawn") or plot.PrimaryPart
		if plotSpawn and plotSpawn:IsA("BasePart") then
			setupBeam(plotSpawn)
		end
	end

	instructionsLabel.Text = "Escape the Tsunami!"
	instructionsLabel.Visible = true

	task.spawn(function()
		while currentStep == 3 do
			local char = player.Character

			if not char or not char:FindFirstChild("ActiveMorph") then
				if checkHasItemTool() then
					print("[Onboarding] Step 3 Complete (Escaped and got tool!)")
					cleanupVisuals()
					SetStepEvent:FireServer(4)
					startStep4()
				else
					print("[Onboarding] Step 3 Failed (Caught by tsunami!)")
					cleanupVisuals()
					-- Drop back to step 1 LOCALLY ONLY so they can try again.
					startStep1()
				end
				break
			end

			task.wait(0.2)
		end
	end)
end

-- [ STEP 4: PLACE ON PLOT ]
startStep4 = function()
	currentStep = 4

	local plotName = "Plot_" .. player.Name
	local plot = Workspace:WaitForChild(plotName, 10)
	if not plot then return end

	local floor1 = plot:WaitForChild("Floor1", 10)
	local slots = floor1 and floor1:WaitForChild("Slots", 10)
	local slot1 = slots and slots:WaitForChild("Slot1", 10)
	local spawnPart = slot1 and slot1:WaitForChild("Spawn", 10) :: BasePart

	if spawnPart then setupBeam(spawnPart) end

	instructionsLabel.Text = "Place the item on your plot!"
	instructionsLabel.Visible = true

	local hasFilledSlot, _ = checkSlots()
	if hasFilledSlot then
		print("[Onboarding] Step 4 Auto-Complete")
		cleanupVisuals()
		SetStepEvent:FireServer(5)
		startStep5()
		return
	end

	task.spawn(function()
		while currentStep == 4 do
			local hasSlotNow, _ = checkSlots()
			if hasSlotNow then
				print("[Onboarding] Step 4 Complete (Placed item!)")
				cleanupVisuals()
				SetStepEvent:FireServer(5)
				startStep5()
				break
			end

			-- No more backwards regression here! If they drop the item, they stay on Step 4.

			task.wait(0.2)
		end
	end)
end

-- [ STEP 5: EARN $100 CASH ]
startStep5 = function()
	currentStep = 5

	local hasFilledSlot, filledSlot = checkSlots()
	if filledSlot then
		local collectPart = filledSlot:FindFirstChild("CollectTouch") :: BasePart
		if collectPart then setupBeam(collectPart) end
	else
		cleanupVisuals()
	end

	instructionsLabel.Text = "Earn $100 cash!"
	instructionsLabel.Visible = true

	local leaderstats = player:WaitForChild("leaderstats")
	local moneyStat = leaderstats:WaitForChild("Money") :: NumberValue

	local function checkMoney()
		if moneyStat.Value >= 100 then
			if moneyConnection then moneyConnection:Disconnect(); moneyConnection = nil end
			print("[Onboarding] Step 5 Complete (Earned $100!)")
			cleanupVisuals()
			SetStepEvent:FireServer(6)
			startStep6()
		end
	end

	if moneyConnection then moneyConnection:Disconnect() end
	moneyConnection = moneyStat.Changed:Connect(checkMoney)
	checkMoney() 
end

-- [ STEP 6: BUY FIRST WEIGHT ]
startStep6 = function()
	currentStep = 6

	local weightsModel = Workspace:WaitForChild("Weights", 10)
	if weightsModel then
		local targetPart = weightsModel:IsA("Model") and (weightsModel.PrimaryPart or weightsModel:FindFirstChildWhichIsA("BasePart")) or (weightsModel:IsA("BasePart") and weightsModel or nil)
		if targetPart then
			setupBeam(targetPart)
		end
	else
		cleanupVisuals()
	end

	instructionsLabel.Text = "Buy your first weight!"
	instructionsLabel.Visible = true

	task.spawn(function()
		while currentStep == 6 do
			if checkHasWeightTool() then
				print("[Onboarding] ALL STEPS COMPLETE")
				cleanupVisuals()
				SetStepEvent:FireServer(7) 
				currentStep = 7
				break
			end
			task.wait(0.5)
		end
	end)
end


-- [ INIT ]
local function initializeOnboarding()
	local savedStep = player:GetAttribute("OnboardingStep")

	if not savedStep then
		task.spawn(function()
			while not savedStep do
				task.wait(0.5)
				savedStep = player:GetAttribute("OnboardingStep")
			end
			initializeOnboarding() 
		end)
		return
	end

	print("[Onboarding] Starting from Step:", savedStep)

	if savedStep == 1 then startStep1()
	elseif savedStep == 2 then startStep2()
	elseif savedStep == 3 then startStep3()
	elseif savedStep == 4 then startStep4()
	elseif savedStep == 5 then startStep5()
	elseif savedStep == 6 then startStep6()
	else
		print("[Onboarding] Already Completed.")
	end
end

task.spawn(function()
	task.wait(2)
	initializeOnboarding()
end)

player.CharacterAdded:Connect(function()
	task.wait(1)
	cleanupVisuals()

	if currentStep == 1 then startStep1()
	elseif currentStep == 2 then startStep2()
	elseif currentStep == 3 then startStep3()
	elseif currentStep == 4 then startStep4()
	elseif currentStep == 5 then startStep5()
	elseif currentStep == 6 then startStep6()
	end
end)