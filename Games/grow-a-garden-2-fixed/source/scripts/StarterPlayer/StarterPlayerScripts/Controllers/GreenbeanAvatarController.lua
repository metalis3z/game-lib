--credit to leon games studio
local AvatarEditorService = game:GetService("AvatarEditorService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local GreenbeanAvatarItems = require(ReplicatedStorage.SharedData.GreenbeanAvatarItems)
local GreenbeanCheck = require(ReplicatedStorage.SharedData.GreenbeanCheck)
local GreenbeanHumanoidDescription = ReplicatedStorage.Assets.GreenbeanHumanoidDescription
local t = {}
local LocalPlayer = Players.LocalPlayer
local v1 = false

AvatarEditorService.PromptSaveAvatarCompleted:Connect(function(p1, p2) --[[ Line: 17 | Upvalues: v1 (ref), GreenbeanCheck (copy), Networking (copy) ]]
	v1 = false

	if p1 ~= Enum.AvatarPromptResult.Success or not GreenbeanCheck.IsGreenbeanDescription(p2) then
		return
	end

	Networking.Greenbean.Action:Fire("LoadAvatar")
end)
Networking.Greenbean.Action.OnClientEvent:Connect(function(p1) --[[ Line: 25 | Upvalues: MarketplaceService (copy), v1 (ref), AvatarEditorService (copy), GreenbeanHumanoidDescription (copy) ]]
	if p1 == "PromptBulkPurchase" then
		MarketplaceService.PromptBulkPurchaseFinished:Once(function(p1, p2, p3) --[[ Line: 27 | Upvalues: v1 (ref), AvatarEditorService (ref), GreenbeanHumanoidDescription (ref) ]]
			if p2 == Enum.MarketplaceBulkPurchasePromptStatus.Completed and not v1 then
				v1 = true
				pcall(function() --[[ Line: 33 | Upvalues: AvatarEditorService (ref), GreenbeanHumanoidDescription (ref) ]]
					AvatarEditorService:PromptSaveAvatar(GreenbeanHumanoidDescription, Enum.HumanoidRigType.R6)
				end)
			end
		end)

		return
	end

	if p1 ~= "PromptSaveAvatar" then
		return
	end

	if v1 then
		return
	end

	v1 = true
	pcall(function() --[[ Line: 43 | Upvalues: AvatarEditorService (ref), GreenbeanHumanoidDescription (ref) ]]
		AvatarEditorService:PromptSaveAvatar(GreenbeanHumanoidDescription, Enum.HumanoidRigType.R6)
	end)
end)

local v2 = nil

local function getItemsToPrompt(p1) --[[ getItemsToPrompt | Line: 50 | Upvalues: v2 (ref), MarketplaceService (copy), LocalPlayer (copy) ]]
	if v2 then
		return v2
	end

	local t = {}

	for v1, v22 in p1 do
		local v3 = false
		local v4 = false

		if v22.Type == Enum.MarketplaceProductType.AvatarAsset then
			local ok, result = pcall(function() --[[ Line: 59 | Upvalues: MarketplaceService (ref), LocalPlayer (ref), v22 (copy) ]]
				return MarketplaceService:PlayerOwnsAsset(LocalPlayer, (tonumber(v22.Id)))
			end)

			v3 = ok
			v4 = result
		elseif v22.Type == Enum.MarketplaceProductType.AvatarBundle then
			local ok, result = pcall(function() --[[ Line: 63 | Upvalues: MarketplaceService (ref), LocalPlayer (ref), v22 (copy) ]]
				return MarketplaceService:PlayerOwnsBundle(LocalPlayer, (tonumber(v22.Id)))
			end)

			v3 = ok
			v4 = result
		end

		if not (v3 and v4) then
			table.insert(t, v22)
		end
	end

	v2 = t
	task.delay(20, function() --[[ Line: 74 | Upvalues: v2 (ref) ]]
		v2 = nil
	end)

	return t
end

function t.Prompt(p1) --[[ Prompt | Line: 81 | Upvalues: v1 (ref), getItemsToPrompt (copy), GreenbeanAvatarItems (copy), Networking (copy) ]]
	if v1 then
		return
	end

	if #getItemsToPrompt(GreenbeanAvatarItems) == 0 then
		Networking.Greenbean.Action:Fire("PromptSaveAvatar")
	else
		Networking.Greenbean.Action:Fire("PromptBulkPurchase")
	end
end

return t