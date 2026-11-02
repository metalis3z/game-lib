--!strict
-- Check all items within ReplicatedStorage, ServerStorage, Lighting, and StarterPack
local toolInfoArray: {ToolInfo} = {}
local hasFetchedTools = false
local toolLowerNamesDict: {[string]: Tool} = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local RunService = game:GetService("RunService")

export type ToolInfo = {
	name: string,
	textureId: string,
	tool: Tool?,
}

return function(): (boolean, {ToolInfo} | string)
	if RunService:IsClient() then
		if hasFetchedTools then
			return true, toolInfoArray
		end
		local Remote = require(modules.Objects.Remote)
		local getToolsInfo = Remote.get("GetToolsInfo")
		local success, result = getToolsInfo:invokeServerAsync()
		if not success then
			return false, tostring(result)
		end
		toolInfoArray = result
		hasFetchedTools = true
		return true, result
	end
	if hasFetchedTools then
		return true, toolInfoArray
	end
	local servicesToCheck = {
		"ReplicatedStorage",
		"ServerStorage",
		"Lighting",
		"StarterPack",
	}
	local count = 0
	for _, serviceName in servicesToCheck do
		local service = game:GetService(serviceName)
		for _, item in service:GetDescendants() do
			count += 1
			if count % 1000 == 0 then
				task.wait()
			end
			if item:IsA("Tool") then
				-- Same-name copies can exist across these services (like an archived
				-- admin copy carrying its own Sword), so each name only lists once
				local nameLower = item.Name:lower()
				if toolLowerNamesDict[nameLower] then
					continue
				end
				table.insert(toolInfoArray, {name = item.Name, textureId = item.TextureId, tool = item})
				toolLowerNamesDict[nameLower] = item
			end
		end
	end
	hasFetchedTools = true
	return true, toolInfoArray
end