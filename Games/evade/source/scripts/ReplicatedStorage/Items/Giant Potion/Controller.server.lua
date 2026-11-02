local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Items = require(ReplicatedStorage.Datas.Items)

local Tool = script.Parent.Parent
local Handle = Tool.Handle

local ItemData = Items[Tool.Name]

local CanUse = true
local GIANT_SCALE = 3
local GIANT_DURATION = 30

Tool.TextureId = ItemData.Icon
Tool.ToolTip = ItemData.Name

if ItemData.HasHighlight then
	local Highlight = Instance.new("Highlight")
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.Parent = Tool

	if ItemData.HighlightConfig then
		local HighlightConfig = ItemData.HighlightConfig
		if HighlightConfig.FillColor then
			Highlight.FillColor = HighlightConfig.FillColor
		end
		if HighlightConfig.FillTransparency then
			Highlight.FillTransparency = HighlightConfig.FillTransparency
		end
		if HighlightConfig.OutlineColor then
			Highlight.OutlineColor = HighlightConfig.OutlineColor
		end
		if HighlightConfig.OutlineTransparency then
			Highlight.OutlineTransparency = HighlightConfig.OutlineTransparency
		end
		if HighlightConfig.OutilineTransparency then
			Highlight.OutlineTransparency = HighlightConfig.OutilineTransparency
		end
	else
		Highlight.FillTransparency = 1
		Highlight.OutlineTransparency = 0
	end
end

local DrinkSound = Instance.new("Sound", Tool)
DrinkSound.Name = "DrinkSound"
DrinkSound.SoundId = "rbxassetid://10722059"
DrinkSound.Volume = 0.5

local function ScaleCharacter(character, scaleFactor)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local bodyScale = humanoid:FindFirstChild("BodyHeightScale") or Instance.new("NumberValue")
	if not bodyScale.Parent then
		bodyScale.Name = "BodyHeightScale"
		bodyScale.Value = 1
		bodyScale.Parent = humanoid
	end

	local scaledProps = {"HipHeight", "WalkSpeed", "JumpPower"}

	if scaleFactor == GIANT_SCALE then
		bodyScale.Value = GIANT_SCALE

		for _, prop in ipairs(scaledProps) do
			humanoid:SetAttribute("Original_"..prop, humanoid[prop])
			humanoid[prop] = humanoid[prop] * scaleFactor
		end

	elseif scaleFactor == 1 / GIANT_SCALE then
		bodyScale.Value = 1

		for _, prop in ipairs(scaledProps) do
			local originalValue = humanoid:GetAttribute("Original_"..prop)
			if originalValue then
				humanoid[prop] = originalValue
				humanoid:SetAttribute("Original_"..prop, nil)
			end
		end
	end
end

local function ApplyGiantEffect(targetPlayer, targetCharacter)
	if not targetCharacter then return end

	local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
	if not targetHumanoid then return end

	if targetCharacter:GetAttribute("IsGiant") then return end

	targetCharacter:SetAttribute("IsGiant", true)
	targetCharacter:SetAttribute("GiantSteps", true)

	ScaleCharacter(targetCharacter, GIANT_SCALE)

	if ItemData.HasParticles then
		pcall(function()
			local root = targetCharacter:FindFirstChild("HumanoidRootPart")
			if root then
				ItemData.HasParticles(root, Tool)
			end
		end)
	end

	if ItemData.OnUse then
		pcall(function()
			ItemData.OnUse(targetPlayer, targetCharacter)
		end)
	end

	task.wait(GIANT_DURATION)

	if targetCharacter and targetCharacter.Parent then
		ScaleCharacter(targetCharacter, 1 / GIANT_SCALE)
		targetCharacter:SetAttribute("IsGiant", nil)
		targetCharacter:SetAttribute("GiantSteps", nil)
	end
end

Tool.Activated:Connect(function()
	if not CanUse then return end

	local character = Tool.Parent
	local player = Players:GetPlayerFromCharacter(character)

	if not player or not character or not character:FindFirstChildOfClass("Humanoid") then
		return
	end

	CanUse = false

	DrinkSound:Play()

	ApplyGiantEffect(player, character)

	task.wait(0.5)
	Tool:Destroy()
end)