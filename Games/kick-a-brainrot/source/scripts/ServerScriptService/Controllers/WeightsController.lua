--!strict
-- LOCATION: ServerScriptService/Controllers/WeightsController

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local WeightConfigurations = require(ReplicatedStorage.Modules.WeightConfigurations)
local PlayerController

local WeightsController = {}

function WeightsController.GiveWeightTool(player: Player, weightName: string, powerGain: number)
	local char = player.Character
	local backpack = player:FindFirstChild("Backpack")

	local function clearOldWeights(container: Instance?)
		if not container then return end
		for _, item in ipairs(container:GetChildren()) do
			if item:IsA("Tool") and item:GetAttribute("IsWeight") then
				item:Destroy()
			end
		end
	end

	clearOldWeights(backpack)
	clearOldWeights(char)

	local tool = Instance.new("Tool")
	tool.Name = weightName 
	tool.RequiresHandle = false 
	tool:SetAttribute("IsWeight", true) 
	tool:SetAttribute("IsTemporary", true)

	local weightConfigData = WeightConfigurations.GetWeightData(weightName)
	if weightConfigData and weightConfigData.ImageId then
		tool.TextureId = weightConfigData.ImageId
	end

	local animTrack: AnimationTrack? = nil
	local powerLoopThread: thread? = nil
	local clonedWeight: Model? = nil 

	tool.Equipped:Connect(function()
		local currentChar = player.Character
		if not currentChar then return end

		local root = currentChar:FindFirstChild("HumanoidRootPart") :: BasePart
		local hum = currentChar:FindFirstChild("Humanoid") :: Humanoid
		local torso = currentChar:FindFirstChild("UpperTorso") or currentChar:FindFirstChild("Torso") :: BasePart

		if root and hum and torso then
			root.Anchored = true

			local animator = hum:FindFirstChild("Animator")
			if animator then
				local animTemplate = ReplicatedStorage.Templates:FindFirstChild("SquatAnimation")
				if animTemplate and animTemplate:IsA("Animation") then
					animTrack = animator:LoadAnimation(animTemplate)
					animTrack.Looped = true
					animTrack:Play()
				end
			end

			local weightsFolder = ReplicatedStorage:FindFirstChild("Weights")
			if weightsFolder then
				local weightTemplate = weightsFolder:FindFirstChild(weightName)
				if weightTemplate then
					clonedWeight = weightTemplate:Clone() :: Model

					local primary = clonedWeight.PrimaryPart or clonedWeight:FindFirstChildWhichIsA("BasePart")

					if primary then
						for _, p in ipairs(clonedWeight:GetDescendants()) do
							if p:IsA("BasePart") then
								p.Anchored = false
								p.CanCollide = false
								p.Massless = true

								if p ~= primary then
									local internalWeld = Instance.new("WeldConstraint")
									internalWeld.Part0 = primary
									internalWeld.Part1 = p
									internalWeld.Parent = p
								end
							end
						end

						local offset = CFrame.new(0, torso.Size.Y / 2, torso.Size.Z / 2)
						clonedWeight:PivotTo(torso.CFrame * offset)
						clonedWeight.Parent = currentChar

						local torsoWeld = Instance.new("WeldConstraint")
						torsoWeld.Part0 = torso
						torsoWeld.Part1 = primary
						torsoWeld.Parent = primary
					else
						warn("[WeightsController] No BasePart found in weight model to weld to: " .. weightName)
					end
				else
					warn("[WeightsController] No 3D model found for weight: " .. weightName)
				end
			end

			powerLoopThread = task.spawn(function()
				while tool.Parent == currentChar do
					task.wait(1)
					local leaderstats = player:FindFirstChild("leaderstats")
					if leaderstats then
						local powerStat = leaderstats:FindFirstChild("Power")
						local rebirthsStat = leaderstats:FindFirstChild("Rebirths")

						if powerStat and powerStat:IsA("NumberValue") then
							local rebirths = rebirthsStat and rebirthsStat.Value or 0
							local powerMultiplier = 1 + (rebirths * 0.25)

							local finalPowerGain = math.round(powerGain * powerMultiplier)

							powerStat.Value += finalPowerGain

							local powerPopupEvent = ReplicatedStorage.Events:FindFirstChild("ShowPowerPopUp")
							if powerPopupEvent then
								powerPopupEvent:FireClient(player, finalPowerGain)
							end
						end
					end
				end
			end)
		end
	end)

	tool.Unequipped:Connect(function()
		local currentChar = player.Character
		if currentChar then
			local root = currentChar:FindFirstChild("HumanoidRootPart") :: BasePart
			if root then
				root.Anchored = false
			end
		end

		if animTrack then
			animTrack:Stop()
			animTrack:Destroy()
			animTrack = nil
		end

		if powerLoopThread then
			task.cancel(powerLoopThread)
			powerLoopThread = nil
		end

		if clonedWeight then
			clonedWeight:Destroy()
			clonedWeight = nil
		end
	end)

	if backpack then
		tool.Parent = backpack
	end
end

function WeightsController:Init(controllers)
	PlayerController = controllers.PlayerController

	local Events = ReplicatedStorage:WaitForChild("Events")
	local buyEvent = Events:FindFirstChild("RequestWeightPurchase")

	if not buyEvent then
		buyEvent = Instance.new("RemoteEvent")
		buyEvent.Name = "RequestWeightPurchase"
		buyEvent.Parent = Events
	end

	local powerPopupEvent = Events:FindFirstChild("ShowPowerPopUp")
	if not powerPopupEvent then
		powerPopupEvent = Instance.new("RemoteEvent")
		powerPopupEvent.Name = "ShowPowerPopUp"
		powerPopupEvent.Parent = Events
	end

	-- Fix: Added missing events that the Client waits for
	local updateUI = Events:FindFirstChild("UpdateWeightsUI") or Instance.new("RemoteEvent", Events)
	updateUI.Name = "UpdateWeightsUI"

	local resetUI = Events:FindFirstChild("ResetWeightsUI") or Instance.new("RemoteEvent", Events)
	resetUI.Name = "ResetWeightsUI"

	local getUnlocked = Events:FindFirstChild("GetUnlockedWeights") or Instance.new("RemoteFunction", Events)
	getUnlocked.Name = "GetUnlockedWeights"

	getUnlocked.OnServerInvoke = function(p)
		local profile = PlayerController:GetProfile(p)
		return profile and profile.Data.UnlockedWeights or {}
	end

	buyEvent.OnServerEvent:Connect(function(player, weightName)
		local profile = PlayerController:GetProfile(player)
		if not profile then return end

		local weightData = WeightConfigurations.GetWeightData(weightName)
		if not weightData then return end

		if profile.Data.UnlockedWeights[weightName] then
			WeightsController.GiveWeightTool(player, weightName, weightData.Power)

			local notif = Events:FindFirstChild("ShowNotification")
			if notif then notif:FireClient(player, "Equipped " .. weightName .. "!", "Success") end

			local updateWeightsUI = Events:FindFirstChild("UpdateWeightsUI")
			if updateWeightsUI then updateWeightsUI:FireClient(player, weightName) end
			return
		end

		if weightData.Price > 0 then
			if PlayerController:DeductMoney(player, weightData.Price) then
				profile.Data.UnlockedWeights[weightName] = true
				WeightsController.GiveWeightTool(player, weightName, weightData.Power)

				local notif = Events:FindFirstChild("ShowNotification")
				if notif then notif:FireClient(player, "Purchased " .. weightName .. "!", "Success") end

				local updateWeightsUI = Events:FindFirstChild("UpdateWeightsUI")
				if updateWeightsUI then updateWeightsUI:FireClient(player, weightName) end
			else
				local notif = Events:FindFirstChild("ShowNotification")
				if notif then notif:FireClient(player, "Not enough money!", "Error") end
			end
		else
			profile.Data.UnlockedWeights[weightName] = true
			WeightsController.GiveWeightTool(player, weightName, weightData.Power)

			local notif = Events:FindFirstChild("ShowNotification")
			if notif then notif:FireClient(player, "Equipped " .. weightName .. "!", "Success") end

			local updateWeightsUI = Events:FindFirstChild("UpdateWeightsUI")
			if updateWeightsUI then updateWeightsUI:FireClient(player, weightName) end
		end
	end)

	print("[WeightsController] Initialized")
end

function WeightsController:Start()
	local function onCharacterAdded(player: Player, char: Model)
		task.spawn(function()
			local profile = PlayerController:GetProfile(player)
			while not profile do
				task.wait(0.5)
				if not player.Parent then return end
				profile = PlayerController:GetProfile(player)
			end

			task.wait(1)

			if not char.Parent then return end

			local bestWeight = nil
			local highestPower = -1

			for weightName, isUnlocked in pairs(profile.Data.UnlockedWeights) do
				if isUnlocked then
					local weightData = WeightConfigurations.GetWeightData(weightName)
					if weightData and weightData.Power > highestPower then
						highestPower = weightData.Power
						bestWeight = weightName
					end
				end
			end

			if bestWeight then
				local weightData = WeightConfigurations.GetWeightData(bestWeight)
				WeightsController.GiveWeightTool(player, bestWeight, weightData.Power)

				local updateUI = ReplicatedStorage.Events:FindFirstChild("UpdateWeightsUI")
				if updateUI then updateUI:FireClient(player, bestWeight) end
			end
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(char)
			onCharacterAdded(player, char)
		end)
		if player.Character then onCharacterAdded(player, player.Character) end
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then onCharacterAdded(player, player.Character) end
	end
end

return WeightsController