pcall(function()
local GA = require(script.Parent)
end)

local players = {}
game.Workspace.Main.TouchEnabled.OnServerEvent:connect(function(player,touchEnabled,screenSizeX,screenSizeY)
	pcall(function()
		local GA = require(game.ServerScriptService.GoogleAnalytics)
		local screenSize = math.floor(math.sqrt(math.pow(screenSizeX,2)+math.pow(screenSizeY,2)))
		if not touchEnabled then
			GA:ReportEvent(player, "Plateform","Desktop","ScreenSize",screenSize)
		else
			GA:ReportEvent(player, "Plateform","Mobile","ScreenSize",screenSize)
		end
	end)
end)

--GA:ReportEvent(player, category, action, label, value)
--GA:ReportPurchase(player, productId, currencyType, price)
--GA:ReportTiming(player, category, variableName, time)

--[[
while true do
GA:ReportEvent(nil, "Test Category", "Test Action1", "Test Label", 1)
GA:ReportEvent(nil, "Test Category", "Test Action2", "Test Label", 2)
GA:ReportEvent(nil, "Test Category", "Test Action3", "Test Label", 3)
GA:ReportEvent(nil, "Test Category", "Test Action4", "Test Label", 4)
wait(.05)
end
--]]