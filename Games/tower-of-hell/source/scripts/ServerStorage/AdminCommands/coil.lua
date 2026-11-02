local module = {}

local modules = game:GetService("ServerStorage").AdminModules

local playersService = game:GetService("Players")

local gears = game:GetService("ServerStorage").Gears

function lowerChild(str, obj)
	for _,child in pairs(obj:GetChildren()) do
		if child.Name:lower() == str then return child end
	end
end

module.run = function(player, message, args)
	if not args[1] then return end
	
	local chosenGears
	if args[1]:lower() == "all" then chosenGears = gears:GetChildren()
	else chosenGears = {lowerChild(args[1]:lower(), gears)}
	end
	if not chosenGears or not chosenGears[1] then return end
	
	local target 
	if args[2] then target = require(modules.FetchTarget)(args[2]:lower(), player)
	else target = {player}
	end
	if not target or not target[1] then return end
	
	for _, plr in pairs(target) do
		if not plr:FindFirstChild("Backpack") then continue end
		for _, chosenGear in pairs(chosenGears) do
			chosenGear:Clone().Parent = plr.Backpack
		end
	end
	
end

return module