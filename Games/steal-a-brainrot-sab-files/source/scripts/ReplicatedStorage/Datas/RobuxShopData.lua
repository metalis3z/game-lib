local RobuxShopData = {}

RobuxShopData.Products = {
	[3606430464] = { Type = "Animal", Display = "Los Skibidis",          Price = 14 },
	[3606430457] = { Type = "Animal", Display = "Los Meowls",            Price = 19 },
	[3606430447] = { Type = "Animal", Display = "Los Elephants",         Price = 24 },
	[3606430436] = { Type = "Animal", Display = "Los Ogs",                Price = 29 },
	[3606430426] = { Type = "Animal", Display = "Los Headless",          Price = 34 },
	[3606430421] = { Type = "Animal", Display = "Jandel",                Price = 39 },
	[3606430412] = { Type = "Animal", Display = "Sammy",                 Price = 44 },
	[3606430406] = { Type = "Animal", Display = "Los Admins",            Price = 49 },
	[3606430397] = { Type = "Animal", Display = "Los John Porks",        Price = 54 },

	[3606430390] = { Type = "Event", Event = "Brotinho's Base", Scope = "Server", Global = 3606430385 },
	[3606430375] = { Type = "Event", Event = "France",          Scope = "Server", Global = 3606430367 },

	[1891120742] = {
		Type        = "Gamepass",
		Key         = "VIP",
		Display     = "Private Server+",
		Price       = 149,
		KohlsRole   = "vip",
		PrivateOnly = true,
		Ids         = {1891120742, 1880938307, 1867057678, 1865175254, 1867457656, 1865965480, 1779392737, 1861744030, 1867827116, 1879534495 },
	},

	[1918844585] = {
		Type      = "Gamepass",
		Key       = "AdminPanel",
		Display   = "Admin Panel (Public Servers)",
		Price     = 49,
		Attribute = "AdminCommands",
		Ids       = {1890010703, 1875400725, 1881244286, 1867868505, 1868555953, 1866838191, 1867288953, 1772565000, 1860431630, 1867243652 },
	},


	[1918844585] = {
		Type    = "Gamepass",
		Key     = "Cooldown",
		Display = "No Cooldowns",
		Price   = 29,
		Ids     = {1889812707, 1875304835, 1867057679, 1866795172, 1865246213, 1867041341, 1709334888, 1863248647, 1867100167, 1880416463 },
	},

	[3606430332] = { Type = "Product", Key = "GlobalBrainrot",  Display = "Global Brainrot Spawn" },
	[3606430342] = { Type = "Product", Key = "GlobalEvent",     Display = "Global Event" },
	[3606430351] = { Type = "Product", Key = "GlobalSnap",      Display = "Global Snap" },
	[3606430356] = { Type = "Product", Key = "GlobalMessage",   Display = "Global Announcements" },
}

RobuxShopData.ByKey = {}
RobuxShopData.ById  = {}

for primaryId, entry in pairs(RobuxShopData.Products) do
	if entry.Ids == nil then
		entry.Ids = { primaryId }
	else
		local hasPrimary = false
		for _, id in ipairs(entry.Ids) do
			if id == primaryId then
				hasPrimary = true
				break
			end
		end
		if not hasPrimary then
			table.insert(entry.Ids, 1, primaryId)
		end
	end

	entry.Id = entry.Ids[1]

	for _, id in ipairs(entry.Ids) do
		RobuxShopData.ById[id] = entry
	end

	if entry.Key then
		RobuxShopData.ByKey[entry.Key] = entry
	end
end

local MarketplaceService = game:GetService("MarketplaceService")

function RobuxShopData.GetEntry(key)
	return RobuxShopData.ByKey[key]
end

function RobuxShopData.FromId(id)
	return RobuxShopData.ById[id]
end

function RobuxShopData.GetId(key)
	local e = RobuxShopData.ByKey[key]
	return e and e.Id or nil
end

function RobuxShopData.GetIds(key)
	local e = RobuxShopData.ByKey[key]
	return e and e.Ids or {}
end

function RobuxShopData.OwnsGamepass(player, key)
	local e = RobuxShopData.ByKey[key]
	if not e then
		return false
	end
	for _, id in ipairs(e.Ids) do
		local ok, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, id)
		end)
		if ok and owns then
			return true
		end
	end
	return false
end

function RobuxShopData.Prompt(player, key, idOverride)
	local e = RobuxShopData.ByKey[key]
	if not e then
		warn("[RobuxShopData] Prompt: unknown key '" .. tostring(key) .. "'")
		return
	end
	local id = idOverride or e.Id
	if e.Type == "Gamepass" then
		MarketplaceService:PromptGamePassPurchase(player, id)
	else
		MarketplaceService:PromptProductPurchase(player, id)
	end
end

return RobuxShopData