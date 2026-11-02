--[[
	
	This will allow for whitelisted people to fake dono.
	Put the id or name of who you wanna whitelist inside the Whitelist table.
	
	To add a name, make sure it is inside those: "",
	example: "Roblox",
	
	To add an id, simply put the id,
	example: 1,
	
	MAKE SURE TO ADD A COMMA AFTER THE ID/NAME
	
	To do a fake dono, you gotta use a chat command
	!fakedono [PRICE] [CUSTOM MESSAGE]
	
	If you want the command to be hidden, add /e at the start
	/e !fakedono [PRICE] [CUSTOM MESSAGE]
	
	Examples:
	!fakedono 15000 this is a message
	/e !fakedono 1 im rich
	
]]--

local Whitelist = {
	1,
	"gaberrgg1",
	"micbryce",
	"gabrys5j"
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

for _, Info in ipairs(Whitelist) do
	table.insert(Returning, (typeof(Info) == "number" and Info) or (typeof(Info) == "string" and GetUserId(Info)))
end

return Returning