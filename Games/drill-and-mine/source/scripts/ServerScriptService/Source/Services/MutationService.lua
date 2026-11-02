local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local MutationService = {}

function MutationService.IsValidMutation(mutationId: string): boolean
	return GameConfig.Mutations[mutationId] ~= nil
end

function MutationService.GetMutationConfig(mutationId: string)
	return GameConfig.Mutations[mutationId]
end

function MutationService.GetAllMutationIds(): {string}
	local ids = {}
	for id in pairs(GameConfig.Mutations) do
		table.insert(ids, id)
	end
	return ids
end

function MutationService.GetDisplayName(mutationId: string): string?
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return nil end
	return mutCfg.DisplayName
end

function MutationService.GetImageId(mutationId: string, brainrotId: string): string?
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return nil end

	local brainrotCfg = GameConfig.Items[brainrotId]
	return brainrotCfg and brainrotCfg.ImageId or nil
end

function MutationService.GetImageColor(mutationId: string): Color3?
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return nil end
	return mutCfg.ImageColor
end

function MutationService.GetModelName(mutationId: string, brainrotId: string): string?
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return nil end

	-- New pack: each brainrot's mutation variant is stored at
	-- ReplicatedStorage.Brainrots.<Rarity>.<MutationFolderName>.<brainrotId>.
	-- The model name itself is identical to the base brainrotId, so callers
	-- look it up via GameConfig.GetBrainrotTemplate. Return the base id only
	-- when a mutation variant actually exists in the pack — otherwise nil so
	-- the caller falls back to the normal model.
	if GameConfig.GetBrainrotTemplate then
		local folderName = mutCfg.FolderName or mutationId
		local mutTemplate = GameConfig.GetBrainrotTemplate(brainrotId, folderName)
		if mutTemplate then
			return brainrotId
		end
	end
	return nil
end

function MutationService.GetModelFolder(mutationId: string): string?
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return nil end
	return mutCfg.ModelFolder
end

function MutationService.GetModelTemplate(mutationId: string, brainrotId: string): Model?
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return nil end
	local folderName = mutCfg.FolderName or MutationService.GetModelFolder(mutationId) or mutationId
	if GameConfig.GetBrainrotTemplate then
		return GameConfig.GetBrainrotTemplate(brainrotId, folderName)
	end
	return nil
end

function MutationService.GetGradientType(mutationId: string): string?
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return nil end
	return mutCfg.GradientType
end

function MutationService.GetGradient(mutationId: string): Instance?
	local gradientType = MutationService.GetGradientType(mutationId)
	if not gradientType then return nil end

	local gradientsRoot = ReplicatedStorage:FindFirstChild("Gradients")
	if not gradientsRoot then return nil end

	local typeFolder = gradientsRoot:FindFirstChild("Type")
	if not typeFolder then return nil end

	return typeFolder:FindFirstChild(gradientType)
end

function MutationService.GetCashBoost(mutationId: string): number
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return 1.0 end
	return mutCfg.CashBoost or 1.0
end

function MutationService.GetMutatedCashPerSec(brainrotId: string, mutationId: string?): number
	local brainrotCfg = GameConfig.Items[brainrotId]
	if not brainrotCfg then return 0 end

	local baseCps = brainrotCfg.CashPerSec or 0
	if not mutationId then return baseCps end

	return baseCps * MutationService.GetCashBoost(mutationId)
end

function MutationService.GetMutationInfo(mutationId: string, brainrotId: string)
	if not MutationService.IsValidMutation(mutationId) then
		return nil
	end

	local brainrotCfg = GameConfig.Items[brainrotId]
	if not brainrotCfg then return nil end

	return {
		MutationId = mutationId,
		BrainrotId = brainrotId,
		DisplayName = MutationService.GetDisplayName(mutationId),
		ImageId = MutationService.GetImageId(mutationId, brainrotId),
		ImageColor = MutationService.GetImageColor(mutationId),
		ModelName = MutationService.GetModelName(mutationId, brainrotId),
		ModelFolder = MutationService.GetModelFolder(mutationId),
		GradientType = MutationService.GetGradientType(mutationId),
		CashBoost = MutationService.GetCashBoost(mutationId),
		MutatedCashPerSec = MutationService.GetMutatedCashPerSec(brainrotId, mutationId),
		BaseCashPerSec = brainrotCfg.CashPerSec or 0,
	}
end

function MutationService.Init()
end

return MutationService