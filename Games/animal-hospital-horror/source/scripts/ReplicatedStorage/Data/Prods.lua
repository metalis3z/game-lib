local tbl = {
	gun = {
		id = 3610019249,
		val = 1,
		cost = "\238\128\130"
	},
	all_tools = {
		id = 3610019297,
		val = 1,
		cost = "\238\128\130"
	},
	ambulance_call = {
		id = 3610019361,
		val = 1,
		cost = "\238\128\130"
	},
	skip_shift = {
		id = 3610019554,
		val = 1,
		cost = "\238\128\130"
	},
	adminpanel = {
		id = 3610019591,
		val = 1,
		cost = "\238\128\130"
	},
	buy_npc = {
		id = 3610019657,
		val = 1,
		cost = "\238\128\130"
	},
	sword = {
		id = 3610019686,
		val = 1,
		cost = "\238\128\130"
	},
	hd_admin = {
		id = 3610019721,
		val = 1,
	},
	be_owner = {
		id = 3610019759,
		val = 1,
	},
	boombox = {
		id = 3610019784,
		val = 1,
		cost = "\238\128\130"
	},
	-- ⚠️ PON AQUÍ el Developer Product id de "No Cooldowns" (reemplaza el 0).
	-- Mientras sea 0, el botón NoCooldowns avisará que aún no está configurado.
	no_cooldowns = {
		id = 3610019818,
		val = 1,
		cost = "\238\128\130"
	},
	instant_brew = {
		id = 3590064413,
		val = 1,
		cost = "\238\128\130"
	},
	instant_taser = {
		id = 3590063561,
		val = 1,
		cost = "\238\128\130"
	},
	jumpscare_all = {
		id = 3590060220,
		val = 1,
		cost = "\238\128\130"
	},
	revive = {
		id = 3590061448,
		val = 1,
		cost = "\238\128\130"
	},
	revive_second = {
		id = 3592209201,
		val = 1,
		cost = "\238\128\130"
	},
	revive_all = {
		id = 3591822968,
		val = 1,
		cost = "\238\128\130"
	},
	run_cola = {
		id = 3590055543,
		val = 1,
		cost = "\238\128\130"
	},
	detect_skinwalker = {
		id = 3590065653,
		val = 1,
		cost = "\238\128\130"
	},
	chocolate = {
		id = 3609114000,
		val = 1,
		cost = "\238\128\130"
	},
	revive_other = {
		id = 3594147846,
		val = 1,
		cost = "\238\128\130"
	},
	reroll_shop = {
		id = 3595812135,
		val = 1,
		cost = "\238\128\130"
	},
	upgr1 = {
		id = 3601285046,
		val = 1,
		cost = "\238\128\130"
	},
	upgr2 = {
		id = 3601285207,
		val = 1,
		cost = "\238\128\130"
	},
	upgr3 = {
		id = 3601285343,
		val = 1,
		cost = "\238\128\130"
	}
}

for k, v in pairs(tbl) do
	v.Name = k
	task.spawn(function() --[[ Line: 26 | Upvalues: v (copy) ]]
		for i = 1, 3 do
			local ok, _ = pcall(function() --[[ Line: 28 | Upvalues: v (ref) ]]
				local v1 = game:GetService("MarketplaceService"):GetProductInfo(v.id, Enum.InfoType.Product)

				v.Name = v1.Name
				v.cost = v1.PriceInRobux
				v.Desc = v1.Description
			end)

			if ok then
				break
			end

			task.wait(0.2)
		end

		require(game.ReplicatedStorage:WaitForChild("Lib")).UpdateRobuxPrice:Fire()
	end)
end

for k, v in pairs(tbl) do
	tbl[v.id] = v
end

({}).Products = tbl

return tbl