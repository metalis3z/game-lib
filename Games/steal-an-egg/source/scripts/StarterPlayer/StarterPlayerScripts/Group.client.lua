task.wait(15)

local GROUP_ID = 15518815 -- replace with your actual group ID

local GroupService = game:GetService("GroupService")
local success, result = pcall(function()
	return GroupService:PromptJoinAsync(GROUP_ID)
end)

if not success then
	warn("Failed to prompt group join: " .. tostring(result))
end