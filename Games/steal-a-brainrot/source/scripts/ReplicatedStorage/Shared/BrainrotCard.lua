local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Animals2 = require(ReplicatedStorage.Shared.Animals)
local Traits = require(ReplicatedStorage.Datas.Traits)
local Rarities = require(ReplicatedStorage.Datas.Rarities)

-- BrainrotCounts folder is maintained by BrainrotExitCounter server script
-- It contains IntValue objects with the count of each brainrot type

local BrainrotCard = {}

BrainrotCard.OneOfOneStroke = Color3.fromRGB(255, 215, 0)
BrainrotCard.OneOfOneBackground = Color3.fromRGB(40, 30, 10)

function BrainrotCard.IsOneOfOne(data)
	if not data or not data.Index then
		return false
	end
	local countsFolder = ReplicatedStorage:FindFirstChild("BrainrotCounts")
	if not countsFolder then
		return false
	end
	local intValue = countsFolder:FindFirstChild(data.Index)
	if not intValue then
		return false
	end
	return intValue.Value == 1
end

function BrainrotCard.Render(cardFrame, brainrotData, trove, context)
	local animalData = Animals[brainrotData.Index]

	-- Set name
	local nameLabel = cardFrame:FindFirstChild("NameLabel")
	if nameLabel then
		nameLabel.Text = animalData and animalData.DisplayName or brainrotData.Index
	end

	-- Set rarity
	local rarityLabel = cardFrame:FindFirstChild("RarityLabel")
	if rarityLabel then
		if animalData and animalData.Rarity then
			rarityLabel.Text = animalData.Rarity
			local rarityData = Rarities[animalData.Rarity]
			if rarityData and rarityData.Color then
				rarityLabel.TextColor3 = rarityData.Color
			end
		else
			rarityLabel.Text = ""
		end
	end

	-- Set mutation
	local mutationLabel = cardFrame:FindFirstChild("MutationLabel")
	if mutationLabel then
		if brainrotData.Mutation and brainrotData.Mutation ~= "Default" then
			mutationLabel.Text = brainrotData.Mutation
			mutationLabel.Visible = true
		else
			mutationLabel.Visible = false
		end
	end

	-- Attach viewport model
	local viewportFrame = cardFrame:FindFirstChild("ViewportFrame")
	if viewportFrame then
		local cleanup = Animals2:AttachOnViewportWithOptimizations(
			brainrotData.Index,
			viewportFrame,
			nil,
			brainrotData.Mutation
		)
		if cleanup then
			trove:Add(cleanup)
		end
	end

	-- Render traits
	local traitsFrame = cardFrame:FindFirstChild("Traits")
	if traitsFrame then
		local template = traitsFrame:FindFirstChild("Template")
		for _, trait in brainrotData.Traits or {} do
			local traitData = Traits[trait]
			if traitData and template then
				local clone = trove:Clone(template)
				clone.Name = trait
				clone.Visible = true
				clone.Image = traitData.Icon
				clone.Parent = traitsFrame
			end
		end
	end

	-- One-of-one visual effects
	local isOneOfOne = BrainrotCard.IsOneOfOne(brainrotData)

	local banner = cardFrame:FindFirstChild("Banner")
	if banner then
		banner.Visible = isOneOfOne
		if isOneOfOne then
			local text = banner:FindFirstChild("Text")
			if text then
				text.Text = "1/1"
			end
		end
	end

	local crowm = cardFrame:FindFirstChild("Crowm")
	if crowm then
		crowm.Visible = isOneOfOne
	end

	local starburst = cardFrame:FindFirstChild("Starburst")
	if starburst then
		starburst.Visible = isOneOfOne
	end
end

return BrainrotCard