--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local VERSION = require(frontend.Config.VERSION)
local CosmeticMarket = require(frontend.Util.CosmeticMarket)
local clientUser = require(modules.References.clientUser)
local warmed = false


-- FUNCTIONS
local AboutPreload = {}

-- Fires the About page's async lookups early so the page builds in its final
-- state on first visit instead of snapping once each web call lands
function AboutPreload.warm()
	if warmed then
		return
	end
	warmed = true
	task.spawn(function()
		VERSION.getLatestVersion()
	end)
	task.spawn(function()
		local success, catalog = clientUser.everyone:fetchAsync("SpecialAccessories")
		if not success or typeof(catalog) ~= "table" then
			return
		end
		-- Same pick as the About page's featured pair, the first two by order
		local list = {}
		for _, accessory in catalog :: any do
			if typeof(accessory) == "table" and accessory.id then
				table.insert(list, accessory)
			end
		end
		table.sort(list, function(left, right)
			local leftOrder, rightOrder = left.order or math.huge, right.order or math.huge
			if leftOrder ~= rightOrder then
				return leftOrder < rightOrder
			end
			return tostring(left.name) < tostring(right.name)
		end)
		for index = 1, math.min(2, #list) do
			local accessory = list[index]
			if accessory.comingSoon == true then
				continue
			end
			CosmeticMarket.seedPrice(accessory.id)
			CosmeticMarket.seedFavourite(accessory.id)
		end
	end)
end

return AboutPreload
