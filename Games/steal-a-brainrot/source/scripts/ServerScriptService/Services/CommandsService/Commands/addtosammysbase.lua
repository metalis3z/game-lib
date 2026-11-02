local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local AnimalsData     = require(ReplicatedStorage.Datas.Animals)
local MutationsData   = require(ReplicatedStorage.Datas.Mutations)
local TraitsData      = require(ReplicatedStorage.Datas.Traits)
local NumberUtils     = require(ReplicatedStorage.Utils.NumberUtils)
local Gradients       = require(ReplicatedStorage.Packages.Gradients)
local Rarities        = require(ReplicatedStorage.Datas.Rarities)
local PlotService     = require(ServerScriptService.Services.PlotService)
local StealService    = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local GlobalMessagingService = require(ServerScriptService.Services:FindFirstChild('GlobalMessagingService'))

local sharedAnimals   = require(ReplicatedStorage.Shared.Animals)

local ACTION_TYPE = "AddToSammysBase_Notify_V1"

-- Register handler with centralized service
GlobalMessagingService.Register(ACTION_TYPE, function(data, sourceJobId)
	if sourceJobId == game.JobId then return end

	-- Notify all players in this server
	for _, player in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(
			player,
			data.message,
			5,
			"Sounds.Sfx.Success"
		)
	end
end)

local module = function(Conch, Config)

	local function createOverhead(animalName, spawnPart, model, selectedMutation)
		local animalData = AnimalsData[animalName]
		if not animalData then return nil end

		local attachment = model:FindFirstChild("OVERHEAD_ATTACHMENT") 
			or Instance.new("Attachment")
		attachment.Name = "OVERHEAD_ATTACHMENT"
		attachment.Position = Vector3.new(0, model:GetExtentsSize().Y * 0.75 * (animalData.OverheadYOffsetModifier or 1), 0)
		attachment.Parent = spawnPart

		local overhead = ReplicatedStorage.Overheads.AnimalOverhead:Clone()
		overhead.Generation.Text = ("$%*/s"):format(NumberUtils:ToString(sharedAnimals:GetGeneration(animalName)))
		overhead.DisplayName.Text = animalData.DisplayName or animalName
		overhead.Price.Text = "$" .. NumberUtils:ToString(animalData.Price or 0)
		overhead.Rarity.Text = animalData.Rarity or "Common"

		if Rarities[animalData.Rarity] then
			overhead.Rarity.TextColor3 = Rarities[animalData.Rarity].Color
			if Rarities[animalData.Rarity].StrokeColor then
				overhead.Rarity.UIStroke.Color = Rarities[animalData.Rarity].StrokeColor
			end
			if Rarities[animalData.Rarity].GradientPreset then
				Gradients.apply(overhead.Rarity, Rarities[animalData.Rarity].GradientPreset)
			end
		end

		overhead.Mutation.Visible = false

		if selectedMutation and MutationsData[selectedMutation] then
			local mutData = MutationsData[selectedMutation]
			if mutData.UseRichText then
				overhead.Mutation.RichText = true
				overhead.Mutation.Text = mutData.DisplayWithRichText
			else
				overhead.Mutation.Text = mutData.DisplayText
			end
			if mutData.GradientPreset then
				Gradients.apply(overhead.Mutation, mutData.GradientPreset)
			else
				overhead.Mutation.TextColor3 = mutData.MainColor
			end
			overhead.Mutation.Visible = true
		end

		overhead.Parent = attachment
		return overhead
	end

	Conch.register("addtosammysbase", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Brainrot or Lucky Block",
				name = "Brainrot/LuckyBlock",
			},
			{
				kind = "argument",
				type = "number",
				name = "PodiumIndex"
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true
			},
			{
				kind = "argument",
				type = "Traits",
				name = "Traits",
				optional = true
			}
		end,
		callback = function(brainrotName, plotNumber, mutationInput, traitsInput)
			local base = Workspace:FindFirstChild("SammyBase")
			if not base or not base:IsDescendantOf(Workspace) then
				return false, "Sammy Base event is not currently active."
			end

			local animalTemplate = ReplicatedStorage.Models.Animals:FindFirstChild(brainrotName)
			if not animalTemplate then
				return false, "Brainrot '" .. tostring(brainrotName) .. "' not found in ReplicatedStorage.Models.Animals"
			end

			local podiums = base.AnimalPodiums:GetChildren()
			table.sort(podiums, function(a,b) return tonumber(a.Name) < tonumber(b.Name) end)

			local podiumIndex = math.floor(tonumber(plotNumber) or 0)
			if podiumIndex < 1 or podiumIndex > #podiums then
				return false, "Invalid PlotNumber. Must be between 1 and " .. #podiums
			end

			local podium = podiums[podiumIndex]
			local spawnPart = podium:FindFirstChild("Base") 
				and podium.Base:FindFirstChild("Spawn") 
				or podium:FindFirstChild("Spawn") 
				or podium:FindFirstChildWhichIsA("BasePart")

			if not spawnPart then
				return false, "Podium " .. podiumIndex .. " has no valid Spawn part."
			end

			local selectedMutation = nil
			if mutationInput and mutationInput ~= "" and mutationInput ~= "Normal" and mutationInput ~= "Default" then
				if not MutationsData[mutationInput] then
					return false, "Mutation '" .. mutationInput .. "' not found."
				end
				selectedMutation = mutationInput
			end

			local traits = nil
			if traitsInput then
				if type(traitsInput) ~= "table" then
					return false, "Traits must be a table {string, ...}"
				end
				traits = {}
				local seen = {}
				for _, t in ipairs(traitsInput) do
					if seen[t] then return false, "Duplicate trait: " .. t end
					seen[t] = true
					if not TraitsData[t] then return false, "Trait not found: " .. t end
					table.insert(traits, t)
				end
			end

			for _, child in ipairs(base:GetChildren()) do
				if child:IsA("Model") and child.Name == brainrotName or AnimalsData[child.Name] then
					for _, desc in ipairs(spawnPart:GetDescendants()) do
						if desc:IsA("WeldConstraint") and desc.Part1 and desc.Part1:IsDescendantOf(child) then
							child:Destroy()
							break
						end
					end
				end
			end

			for _, child in ipairs(spawnPart:GetChildren()) do
				if child:IsA("ProximityPrompt") then 
					child:Destroy() 
				end
			end

			-- Clear old welds on THIS spawn part only
			for _, child in ipairs(spawnPart:GetChildren()) do
				if child:IsA("WeldConstraint") then
					child:Destroy()
				end
			end

			local animalClone = animalTemplate:Clone()

			if selectedMutation then
				sharedAnimals:ApplyMutation(animalClone, brainrotName, selectedMutation)
			end

			-- Set PrimaryPart FIRST
			if not animalClone.PrimaryPart then
				local pp = animalClone:FindFirstChildWhichIsA("BasePart", true)
				if pp then animalClone.PrimaryPart = pp end
			end

			if not animalClone.PrimaryPart then
				animalClone:Destroy()
				return false, "Animal model has no valid PrimaryPart!"
			end

			animalClone:PivotTo(spawnPart:GetPivot())

			for _, part in animalClone:GetDescendants() do
				if part:IsA("BasePart") then
					part.Anchored = false
					part.CanCollide = false
				end
			end

			local weld = Instance.new("WeldConstraint")
			weld.Part0 = spawnPart
			weld.Part1 = animalClone.PrimaryPart
			weld.Parent = spawnPart

			animalClone.Parent = base

			local animFolder = ReplicatedStorage.Animations.Animals:FindFirstChild(animalClone.Name)
			if animFolder then
				local idle = animFolder:FindFirstChild("Idle")
				if idle and animalClone:FindFirstChild("AnimationController") then
					local animator = animalClone.AnimationController:FindFirstChildWhichIsA("Animator")
					if animator then
						animator:LoadAnimation(idle):Play()
					end
				end
			end

			local overhead = createOverhead(brainrotName, spawnPart, animalClone, selectedMutation)

			local prompt = Instance.new("ProximityPrompt")
			prompt.ActionText = "Steal"
			prompt.ObjectText = brainrotName
			prompt.HoldDuration = 1.5
			prompt.MaxActivationDistance = 10
			prompt.Parent = spawnPart

			prompt.Triggered:Connect(function(player)
				if PlotService:IsBaseFull(player) then
					warn(player.Name .. " needs more room to steal")
					return
				end

				for _, part in ipairs(animalClone:GetDescendants()) do
					if part:IsA("BasePart") and part ~= animalClone.PrimaryPart then
						if part:GetAttribute("DefaultTransparency") == nil then
							part:SetAttribute("DefaultTransparency", part.Transparency)
						end
						if part.Transparency < 1 then
							part.Transparency = 0.5
						end
					end
				end

				if overhead then
					overhead.DisplayName.Visible = false
					overhead.Generation.Visible = true
					overhead.Mutation.Visible = false
					overhead.Price.Visible = false
					overhead.Rarity.Visible = false
					overhead.Stolen.Visible = true
				end

				if prompt then
					prompt.Enabled = false
				end

				local success = StealService:SimulateSteal(
					player.Name,
					brainrotName,
					animalClone,
					overhead,
					prompt,
					selectedMutation
				)

				if not success then
					for _, part in ipairs(animalClone:GetDescendants()) do
						if part:IsA("BasePart") and part ~= animalClone.PrimaryPart then
							local defaultTransparency = part:GetAttribute("DefaultTransparency")
							if defaultTransparency ~= nil and defaultTransparency < 1 then
								part.Transparency = defaultTransparency
							end
						end
					end

					if overhead then
						overhead.DisplayName.Visible = true
						overhead.Generation.Visible = true
						overhead.Mutation.Visible = selectedMutation ~= nil
						overhead.Price.Visible = true
						overhead.Rarity.Visible = true
						overhead.Stolen.Visible = false
					end

					if prompt then
						prompt.Enabled = true
					end
				end
			end)

			-- Notify all players across ALL servers using MessagingService
			local notifyMessage = 'Sammy <font color="#FFD700">' .. brainrotName .. '</font> has been added to podium #' .. podiumIndex .. '!'

			-- Notify players in THIS server
			for _, player in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(
					player,
					notifyMessage,
					5,
					"Sounds.Sfx.Success"
				)
			end

			-- Broadcast to ALL other servers
			GlobalMessagingService.Publish(ACTION_TYPE, { message = notifyMessage })

			return true, "Added **" .. brainrotName .. "** (mutation: " 
				.. (selectedMutation or "none") .. ") to podium #" .. podiumIndex
		end
	})
end

return module