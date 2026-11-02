--[[
	This is client only and shows Roblox's native favourite prompt, yields until the user answers,
	and returns true if they confirmed
--]]

local PROMPT_TIMEOUT = 30

local AvatarEditorService = game:GetService("AvatarEditorService")
local RunService = game:GetService("RunService")
local isClient = RunService:IsClient() 
local prompting = false

return function(assetId: number, shouldFavourite: boolean): boolean
	if not isClient then
		return false
	end
	if prompting then
		return false
	end
	prompting = true

	-- Connect the completion listener BEFORE prompting so it's ready when the user responds
	local result: Enum.AvatarPromptResult? = nil
	local connection = AvatarEditorService.PromptSetFavoriteCompleted:Once(function(promptResult)
		result = promptResult
	end)

	local ok = pcall(function()
		AvatarEditorService:PromptSetFavorite(assetId, Enum.AvatarItemType.Asset, shouldFavourite)
	end)
	if ok then
		-- Yield until the prompt completes, with a timeout so a never-answered prompt
		-- doesnt wait forever
		local startClock = os.clock()
		while result == nil and os.clock() - startClock < PROMPT_TIMEOUT do
			task.wait()
		end
	end

	connection:Disconnect()
	prompting = false

	-- Confirmed unless the user declined / lacked permission
	return result ~= nil and result ~= Enum.AvatarPromptResult.PermissionDenied
end
