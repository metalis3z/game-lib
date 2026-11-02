--!strict
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Task = require(modules.Objects.Task)
local Prompt = require(modules.Prompt)

return function(assetType: Enum.AssetType, task: Task.Class, integer: number, callback: (item: Instance) -> ())
	local typeName = assetType.Name
	if integer <= 0 then
		Prompt.error(task.caller, `Invalid {typeName}Id`)
		return
	end
	local config = task.config
	local caller = task.caller
	local isTypeAsync = require(modules.VerifyUtil.isTypeAsync)
	local verifyConfigLists = require(modules.VerifyUtil.verifyConfigLists)
	local success, newIdOrWarning = verifyConfigLists(caller, config, integer)
	if not success then
		Prompt.error(caller, tostring(newIdOrWarning))
		return
	end
	local originalId = integer
	if newIdOrWarning ~= integer then
		integer = newIdOrWarning :: number
		Prompt.info(caller, `{typeName}Id {originalId} was replaced with {integer} by the game's developer`)
	end
	if not isTypeAsync(integer, assetType) then
		Prompt.error(caller, `ID is not a {typeName} Asset`)
		return
	end
	local isGear = assetType == Enum.AssetType.Gear
	local success: boolean, assetOrWarning: any
	if isGear then
		-- LoadAssetAsync sandboxes everything it returns so gear scripts never run
		local InsertService = game:GetService("InsertService")
		success, assetOrWarning = pcall(function()
			return InsertService:LoadAsset(integer)
		end)
	else
		local AssetService = game:GetService("AssetService")
		success, assetOrWarning = pcall(function()
			return AssetService:LoadAssetAsync(integer)
		end)
	end
	if not success or typeof(assetOrWarning) ~= "Instance" then
		Prompt.error(caller, `Failed to load {typeName} {integer}: {assetOrWarning}`)
		return
	end
	local item = assetOrWarning:GetChildren()[1]
	if not item then
		Prompt.error(caller, `No item found in {typeName} Asset`)
		assetOrWarning:Destroy()
		return
	end
	if isGear and not item:IsA("Tool") then
		Prompt.error(caller, `Asset {integer} is not a gear tool`)
		assetOrWarning:Destroy()
		return
	end
	callback(item)
	assetOrWarning:Destroy()
end