--!strict

--[[ 

	Works out which single product to prompt for a role. GamePasses win,
	then Assets, then Bundles, then a Group join

]]



-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Presets = require(modules.Parent.Controllers.UI.Config.Presets) :: any


-- TYPES
export type Giver = {
	kind: "GamePass" | "Asset" | "Bundle" | "Group",
	id: number?,
	infoType: Enum.InfoType?,
	groupId: number?,
}


-- LOCAL FUNCTIONS
local function classifyProduct(entry: any): (string?, number?, Enum.InfoType?)
	if typeof(entry) ~= "table" then return nil, nil, nil end
	local et = entry.type
	local id = entry.id
	if et == "GamePass" and typeof(id) == "number" then
		return "GamePass", id, Enum.InfoType.GamePass
	elseif et == "Asset" and typeof(id) == "number" then
		return "Asset", id, Enum.InfoType.Asset
	elseif et == "Bundle" and typeof(id) == "number" then
		return "Bundle", id, Enum.InfoType.Bundle
	elseif et == "Preset" and typeof(entry.preset) == "string" then
		local preset = Presets.products[entry.preset]
		if preset and typeof(preset.id) == "number" then
			local infoType = preset.infoType
			if infoType == Enum.InfoType.GamePass then return "GamePass", preset.id, infoType end
			if infoType == Enum.InfoType.Asset then return "Asset", preset.id, infoType end
			if infoType == Enum.InfoType.Bundle then return "Bundle", preset.id, infoType end
		end
	end
	return nil, nil, nil
end


-- FUNCTION
local function pickRoleGiver(giveToProducts: any, giveToGroups: any): Giver?
	local firstGamePass: Giver? = nil
	local firstAsset: Giver? = nil
	local firstBundle: Giver? = nil
	if typeof(giveToProducts) == "table" then
		for _, entry in giveToProducts :: { any } do
			local kind, id, infoType = classifyProduct(entry)
			if kind == "GamePass" and firstGamePass == nil then
				firstGamePass = { kind = "GamePass", id = id, infoType = infoType }
			elseif kind == "Asset" and firstAsset == nil then
				firstAsset = { kind = "Asset", id = id, infoType = infoType }
			elseif kind == "Bundle" and firstBundle == nil then
				firstBundle = { kind = "Bundle", id = id, infoType = infoType }
			end
		end
	end
	if firstGamePass then return firstGamePass end
	if firstAsset then return firstAsset end
	if firstBundle then return firstBundle end
	if typeof(giveToGroups) == "table" then
		for _, entry in giveToGroups :: { any } do
			if typeof(entry) == "table" and typeof((entry :: any).groupId) == "number" then
				return { kind = "Group", groupId = (entry :: any).groupId }
			end
		end
	end
	return nil
end


return pickRoleGiver