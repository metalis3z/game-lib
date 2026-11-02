local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AuraCore = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("AuraCore"))

local AURA_FOLDER_NAME = "ActiveAura"

local CosmeticService = {
	AppliedAuraByPlayer = {},
	AppliedCharacterByPlayer = {},
}

local function applyAttribute(target, attributeName, value)
	if target and target.Parent then
		target:SetAttribute(attributeName, value)
	end
end

local function hasActiveAuraFolder(model)
	local folder = model and model:FindFirstChild(AURA_FOLDER_NAME)
	return folder ~= nil and folder.Parent == model
end

local function shouldRefreshAura(player, character, auraKey)
	if not character or not character.Parent then
		return false
	end
	local lastCharacter = CosmeticService.AppliedCharacterByPlayer[player]
	local lastAuraKey = CosmeticService.AppliedAuraByPlayer[player]
	if lastCharacter ~= character then
		return true
	end
	if lastAuraKey ~= auraKey then
		return true
	end
	if auraKey == "" then
		return hasActiveAuraFolder(character)
	end
	return not hasActiveAuraFolder(character)
end

local function applyAuraToModel(model, auraKey)
	if not model or not model.Parent then
		return
	end

	pcall(function()
		AuraCore.DisableAuraFromModel(model, AURA_FOLDER_NAME)
	end)
	if auraKey == "" then
		return
	end
	pcall(function()
		AuraCore.EnableAuraOnModel(model, auraKey, AURA_FOLDER_NAME)
	end)
end

function CosmeticService.EnableAura(player, auraKey)
	if typeof(player) ~= "Instance" then
		return
	end

	auraKey = type(auraKey) == "string" and auraKey or ""
	local character = player.Character
	applyAttribute(player, "EquippedAuraKey", auraKey)
	applyAttribute(character, "EquippedAuraKey", auraKey)

	if not shouldRefreshAura(player, character, auraKey) then
		return
	end

	applyAuraToModel(character, auraKey)
	CosmeticService.AppliedAuraByPlayer[player] = auraKey
	CosmeticService.AppliedCharacterByPlayer[player] = character
end

function CosmeticService.ClearAura(player)
	CosmeticService.EnableAura(player, "")
	CosmeticService.AppliedAuraByPlayer[player] = ""
	CosmeticService.AppliedCharacterByPlayer[player] = player and player.Character or nil
end

return CosmeticService