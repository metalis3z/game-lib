local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)

local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local PlotController = require(ReplicatedStorage.Controllers.PlotController)

local TroveObj = Trove.new()
local LocalPlayer = Players.LocalPlayer
local TutorialGui = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("Tutorial")
local TutorialLabel = TutorialGui:WaitForChild("TextLabel")

local StartTutorialEvent = Net:RemoteEvent("TutorialService/StartTutorial")
local FinishTutorialEvent = Net:RemoteEvent("TutorialService/FinishTutorial")
local CashCollectedEvent = Net:RemoteEvent("PlotService/CashCollected")

local FTUEController = {}

local function createArrow(playerRoot, target)
	local arrowTemplate = script:FindFirstChild("TutorialArrow")
	if not arrowTemplate then
		warn("[FTUEController] Missing TutorialArrow inside the script!")
		return nil
	end

	local arrow = arrowTemplate:Clone()
	arrow.Parent = workspace

	local startPart = arrow:FindFirstChild("Start")
	local endPart = arrow:FindFirstChild("End")

	if not startPart or not endPart then
		warn("[FTUEController] TutorialArrow missing Start or End parts!")
		arrow:Destroy()
		return nil
	end

	startPart.CFrame = playerRoot.CFrame
	local weldStart = Instance.new("WeldConstraint")
	weldStart.Part0 = playerRoot
	weldStart.Part1 = startPart
	weldStart.Parent = startPart

	if target and target:IsA("BasePart") then
		endPart.CFrame = target.CFrame
		local weldEnd = Instance.new("WeldConstraint")
		weldEnd.Part0 = target
		weldEnd.Part1 = endPart
		weldEnd.Parent = endPart
	end

	return arrow
end

local function Setup(syncObj)
	local active = false
	local finished = false

	local function updateTutorial()
		task.wait(0.5)
		local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart", 5)
		if not hrp then return end

		TutorialLabel.Visible = false
		TroveObj:Clean()

		if syncObj:Get("TutorialFinished") == true then
			finished = true
			if active then
				active = false
				TutorialLabel.Text = "Steal Brainrots from other players and bring them back to your base!"
				TutorialLabel.Visible = true
				task.delay(10, function()
					TutorialLabel.Visible = false
				end)
			end
			TroveObj:Destroy()
			return
		end

		active = true
		local hasAnimal, data = AnimalController:HasAnimal("Noobini Pizzanini")

		if hasAnimal then
			local plot = PlotController:GetMyPlot()
			if plot then
				local main = plot.PlotModel.AnimalPodiums:FindFirstChild(data[1])
				if main then
					local claim = main:FindFirstChild("Claim") and main.Claim:FindFirstChild("Main")
					if claim then
						local arrow = createArrow(hrp, claim)
						if arrow then
							TroveObj:Add(arrow)
						end
					end
				end
			end

			TutorialLabel.Text = "Go collect your cash!"
			TutorialLabel.Visible = true

			TroveObj:Add(CashCollectedEvent.OnClientEvent:Connect(function()
				FinishTutorialEvent:FireServer()
			end))

			TroveObj:Add(syncObj:OnChanged("AnimalAddedOrRemoved", updateTutorial))
			return
		end

		local moving = AnimalController:HasAnimalMovingToBase("Noobini Pizzanini")
		if moving then
			local uid = moving.UID
			TutorialLabel.Text = "Wait for Noobini Pizzanini to reach your base!"
			TutorialLabel.Visible = true

			TroveObj:Add(AnimalController.OnAnimalDestroyed:Connect(function(id)
				if id == uid then
					updateTutorial()
				end
			end))
			TroveObj:Add(AnimalController.OnFollowingChanged:Connect(function(name)
				if name == "Noobini Pizzanini" then
					updateTutorial()
				end
			end))
			TroveObj:Add(moving.Instance.PrimaryPart.PromptAttachment.ProximityPrompt:GetAttributeChangedSignal("TargetPlayer"):Connect(updateTutorial))
			return
		end

		local arrow = createArrow(hrp)
		if not arrow then return end
		TroveObj:Add(arrow)

		TutorialLabel.Text = "Go buy a Noobini Pizzanini"
		TutorialLabel.Visible = true

		local closestAnimal
		TroveObj:Add(Timer.Simple(0.1, function()
			local char = LocalPlayer.Character
			if not char then return end

			local pivot = char:GetPivot()
			local closest, minDist = nil, math.huge

			for _, animal in AnimalController:GetAnimals() do
				if animal.Index == "Noobini Pizzanini" then
					local prompt = animal.Instance.PrimaryPart:FindFirstChild("PromptAttachment"):FindFirstChildOfClass("ProximityPrompt")
					if prompt and not prompt:GetAttribute("TargetPlayer") then
						local dist = (pivot.Position - animal.AnimalModel.PrimaryPart.Position).Magnitude
						if dist < minDist then
							minDist = dist
							closest = animal
						end
					end
				end
			end
			closestAnimal = closest
		end, true))

		TroveObj:Add(RunService.PostSimulation:Connect(function()
			if closestAnimal and closestAnimal.AnimalModel and closestAnimal.AnimalModel.PrimaryPart then
				local endPart = arrow:FindFirstChild("End")
				if endPart then
					endPart.CFrame = closestAnimal.AnimalModel.PrimaryPart.CFrame
				end
				local beam = arrow.Start:FindFirstChild("Beam")
				if beam then
					beam.Enabled = true
				end
				TutorialLabel.Visible = true
			else
				local beam = arrow.Start:FindFirstChild("Beam")
				if beam then
					beam.Enabled = false
				end
				TutorialLabel.Visible = false
			end
		end))

		TroveObj:Add(AnimalController.OnFollowingChanged:Connect(function(name)
			if name == "Noobini Pizzanini" then
				updateTutorial()
			end
		end))
	end

	if syncObj:Get("TutorialFinished") == true then
		return
	end

	syncObj:OnChanged("TutorialFinished", updateTutorial, true)
	if LocalPlayer.Character then
		task.spawn(updateTutorial)
	else
		LocalPlayer.CharacterAdded:Once(updateTutorial)
	end

	StartTutorialEvent:FireServer()
end

function FTUEController.Start()
	Synchronizer:WaitAndCall(LocalPlayer, Setup)
	local function updateTopbarInset()
		TutorialGui.Position = UDim2.fromScale(0.5, 0) + UDim2.fromOffset(0, GuiService.TopbarInset.Height)
	end
	GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(updateTopbarInset)
	updateTopbarInset()
end

return FTUEController