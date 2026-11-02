local Products = {
    gun = { id = 3611182311, displayName = "Gun", enabled = true },
    m4 = { id = 3611181999, displayName = "Rifle", enabled = true },
	all_tools = { id = 3626744258, displayName = "All Tools", enabled = true },
	ambulance_call = { id = 3626742388, displayName = "Ambulance", enabled = true },
	skip_shift = { id = 3626741192, displayName = "Skip Shift", enabled = true },
	adminpanel = { id = 3626739297, displayName = "Admin Panel", enabled = true },
	infinite_sanity = { id = 3626746332, displayName = "Infinite Sanity", enabled = true },
	buy_npc = { id = 3625267531, displayName = "Buy NPC", enabled = true },
    sword = { id = 3611182168, displayName = "Sword", enabled = true },
	hd_admin = { id = 3626748552, displayName = "HD Admin", enabled = true },
	be_owner = { id = 3626747396, displayName = "Be Owner", enabled = true },
    boombox = { id = 3611182227, displayName = "Radio", enabled = true },
	no_cooldowns = { id = 3626750005, displayName = "No Cooldowns", enabled = true },
	chocolate = { id = 3626998194, displayName = "Chocolate", enabled = true },

	revive = { id = 3626751494, displayName = "Revive", enabled = true },
	revive_second = { id = 3626752567, displayName = "Revive Again", enabled = true },
	revive_all = { id = 3626753702, displayName = "Revive All", enabled = true },

    -- Troll panel: single target
	troll_fling = { id = 3611182673, displayName = "Fling", enabled = true, action = "Fling" },
	troll_explode = { id = 3611182692, displayName = "Explode", enabled = true, action = "Explode" },
	troll_freeze = { id = 3611182650, displayName = "Freeze", enabled = true, action = "Freeze" },
	troll_trip = { id = 3611182753, displayName = "Trip", enabled = true, action = "Trip" },
	troll_kill = { id = 3611182725, displayName = "Kill", enabled = true, action = "Kill" },
	troll_kick = { id = 3611190086, displayName = "Kick", enabled = true, action = "Kick" },

    -- Troll panel: whole server
	troll_fling_all = { id = 3611182513, displayName = "Fling All", enabled = true, action = "FlingAll" },
	troll_explode_all = { id = 3611182528, displayName = "Explode All", enabled = true, action = "ExplodeAll" },
	troll_freeze_all = { id = 3611182468, displayName = "Freeze All", enabled = true, action = "FreezeAll" },
	troll_kill_all = { id = 3611182550, displayName = "Kill All", enabled = true, action = "KillAll" },
	troll_trip_all = { id = 3611182581, displayName = "Trip All", enabled = true, action = "TripAll" },

    instant_brew = { id = 3611183627, displayName = "Instant Brew", enabled = false },
    instant_taser = { id = 3611183649, displayName = "Instant Taser", enabled = false },
    jumpscare_all = { id = 3611183680, displayName = "Jumpscare All", enabled = false },
    run_cola = { id = 3611183842, displayName = "Run Cola", enabled = false },
    detect_skinwalker = { id = 3611183874, displayName = "Detect Skinwalker", enabled = false },
    revive_other = { id = 3611183977, displayName = "Revive Other", enabled = false },
    reroll_shop = { id = 3611184010, displayName = "Reroll Shop", enabled = false },
    upgr1 = { id = 3611184076, displayName = "Upgrade 1", enabled = false },
    upgr2 = { id = 3611184103, displayName = "Upgrade 2", enabled = false },
	upgr3 = { id = 3611184129, displayName = "Upgrade 3", enabled = false },

    -- Kept only so this old ID is not hidden in a random world script.
    legacy_heal_all_display = {
        id = 3571978990,
        displayName = "Legacy Heal All Display",
        enabled = false,
    },
}

local ProductConfig = {
    Products = Products,
    ById = {},

    -- GUI instance name -> product key
    ShopButtons = {
        AdminPanel = "adminpanel",
        AllTool = "all_tools",
        AmbulanceCall = "ambulance_call",
        BuyNPC = "buy_npc",
        HDadmin = "hd_admin",
        SkipShift = "skip_shift",
        boombox = "boombox",
        sword = "sword",
    },

    -- GUI button name -> product entry
    TrollButtons = {
        Single = {
            fling = Products.troll_fling,
            explode = Products.troll_explode,
            freeze = Products.troll_freeze,
            trip = Products.troll_trip,
            kill = Products.troll_kill,
            kick = Products.troll_kick,
        },
        All = {
            fling = Products.troll_fling_all,
            explode = Products.troll_explode_all,
            freeze = Products.troll_freeze_all,
            kill = Products.troll_kill_all,
            trip = Products.troll_trip_all,
        },
    },
}

for key, product in pairs(Products) do
    assert(type(product.id) == "number" and product.id > 0, ("Invalid product ID for %s"):format(key))
    assert(ProductConfig.ById[product.id] == nil, ("Duplicate product ID %d"):format(product.id))

    product.key = key
    product.Name = product.displayName
    product.val = product.val or 1
    product.cost = product.cost or "R$"

    ProductConfig[key] = product
    ProductConfig[product.id] = product
    ProductConfig.ById[product.id] = product
end

function ProductConfig.Get(keyOrId)
    if type(keyOrId) == "number" then
        return ProductConfig.ById[keyOrId]
    end
    return Products[keyOrId]
end

function ProductConfig.GetId(key)
    local product = Products[key]
    return product and product.id or nil
end

return ProductConfig
