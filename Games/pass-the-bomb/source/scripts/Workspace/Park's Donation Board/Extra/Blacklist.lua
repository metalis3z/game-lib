--[[
	
	This will make people not be able to donate.
	Put the id or name of who you wanna blacklist inside the Blacklist table.
	
	To add a name, make sure it is inside those: "",
	example: "Roblox",
	
	To add an id, simply put the id,
	example: 1,
	
	MAKE SURE TO ADD A COMMA AFTER THE ID/NAME
	
]]--

local Blacklist = {
	1,
	"builderman",
}

local Players = game:GetService("Players")

local Returning = {}

local function GetUserId(Name)
	local Success, Result = pcall(function()
		return Players:GetUserIdFromNameAsync(Name)
	end)
	
	if Success then
		return Result
	else
		task.wait(0.25)
		
		return GetUserId(Name)
	end
end

for _, Info in ipairs(Blacklist) do
	table.insert(Returning, (typeof(Info) == "number" and Info) or (typeof(Info) == "string" and GetUserId(Info)))
end

return Returning