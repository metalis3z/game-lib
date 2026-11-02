--credit to leon games studio
--[[
	DevProductOverrides
	====================================================================
	AQUÍ pones los DevProduct / Gamepass IDs DE TU JUEGO.

	Los IDs del dump (workspace.RemoteDeveloperProducts) son del juego ORIGINAL y NO
	se pueden vender en tu lugar. Este módulo SOBRESCRIBE esos IDs con los tuyos: lo
	aplican DevProductController (cliente: precio + prompt) y DevProductService
	(servidor: ProcessReceipt) DESPUÉS de cargar los del dump, así que estos GANAN.

	------------------------------------------------------------------
	COMPRAS A GRANEL (x3 / x10) CON UN SOLO ID  ·  TABLA DINÁMICA
	------------------------------------------------------------------
	La tienda arma la key como  <Prefijo>:<Nombre>:<Cantidad>  (RestockStoreController
	línea ~1013), p.ej.  Seed:Carrot:3  /  Gear:Trowel:10. En vez de crear un ID por
	cada semilla/gear y cantidad, definí UN ID compartido por cantidad abajo en
	BULK_PRODUCT_IDS y este módulo lo aplica AUTOMÁTICAMENTE a TODAS las semillas y
	gears (incluso los que agregues luego, porque los nombres se leen de SeedData /
	GearShopData en tiempo real). Los x1 los seguís poniendo a mano (precio propio).

	OJO precio: al compartir el ID, TODOS los x3 muestran el MISMO precio en Robux
	(el del producto compartido); igual los x10. Es lo esperado al reusar un ID.

	Para que el server entregue el ítem correcto pese a compartir ID, DevProductService
	usa la key que el cliente envía por DevProductPendingPurchase (validando que el
	ProductId coincida, así nadie escala a un producto más caro).

	Para que cobre Robux DE VERDAD: DevProductService pone InstantPurchasesEnabled=false
	(ya hecho). En Studio no se completa una compra real; probar en el juego publicado.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

----------------------------------------------------------------------
-- 1) IDs COMPARTIDOS PARA x3 / x10 (y los que quieras)
--    Poné acá TU DevProductId. 0 = sin definir (usa el ID del dump, no vendible).
--    Podés agregar más cantidades, p.ej. [5] = ..., [50] = ...
----------------------------------------------------------------------
local BULK_PRODUCT_IDS = {
	[3]  = 3604736162,   -- <-- TU DevProductId para TODOS los "x3"  (Seed y Gear)
	[10] = 3604736169,   -- <-- TU DevProductId para TODOS los "x10" (Seed y Gear)
}

----------------------------------------------------------------------
-- 2) IDs MANUALES (x1 y casos con precio propio)
----------------------------------------------------------------------
local Products = {
	--==================================================================
	-- GACHA  (RobuxShop)   SeedPack:Ghost Pepper Pack:<cantidad>
	-- (gacha = precios propios por cantidad, NO usa la tabla dinámica)
	--==================================================================
	["SeedPack:Ghost Pepper Pack:1"]  = 3604653624,  -- Set1 Buy1Button
	["SeedPack:Ghost Pepper Pack:3"]  = 3604653650,  -- Set2 Buy3Button
	["SeedPack:Ghost Pepper Pack:10"] = 3604653664,  -- Set3 Buy10Button
	["SeedPack:Ghost Pepper Pack:50"] = 3604653674,  -- Set4 Buy50Button

	--==================================================================
	-- SHECKLES  (RobuxShop)
	--==================================================================
	["Currency:Sheckles:5000"]   = 3604653699,
	["Currency:Sheckles:10000"]  = 3604653714,
	["Currency:Sheckles:25000"]  = 3604653727,
	["Currency:Sheckles:50000"]  = 3604653755,
	["Currency:Sheckles:100000"] = 3604653774,

	--==================================================================
	-- STARTER PACK
	--==================================================================
	["Standalone:StarterPack:1"] = 3604653795,

	--==================================================================
	-- GROW  (GrowingList: botón Grow por planta y Grow All)  ·  MODDED
	--==================================================================
	["Standalone:Grow Plant:1"] = 3604876935,   -- crecer 1 planta
	["Standalone:Grow All:1"]   = 3604876954,   -- crecer todas

	--==================================================================
	-- RESTOCK  (botón Restock de las tiendas)  ·  mismo DevID para las 3
	--==================================================================
	["Restock:Seeds:1"] = 3604750843,
	["Restock:Gears:1"] = 3604750843,
	["Restock:Props:1"] = 3604750843,

	--==================================================================
	-- GEAR x1   (GearShop > Sheckles_Shelf, botón ToggleRobux)
	-- (descomenta y pon tu ID; los x3/x10 los pone la tabla dinámica)
	--==================================================================
	["Gear:Common Watering Can:1"]   = 3604735862, -- 37
	["Gear:Common Sprinkler:1"]      = 3604735876, -- 38
	["Gear:Sign:1"]                  = 3604735895, -- 39
	["Gear:Lantern:1"]               = 3604735977, -- 40
	["Gear:Wheelbarrow:1"]           = 3604735988, -- 41
	["Gear:Uncommon Sprinkler:1"]    = 3604735997, -- 42
	["Gear:Rare Sprinkler:1"]        = 3604736010, -- 43
	["Gear:Legendary Sprinkler:1"]   = 3604736020, -- 44
	["Gear:Super Sprinkler:1"]       = 3604736027, -- 45
	["Gear:Trowel:1"]                = 3604736031, -- 46
	["Gear:Speed Mushroom:1"]        = 3604736038, -- 47
	["Gear:Jump Mushroom:1"]         = 3604736046, -- 48
	["Gear:Gnome:1"]                 = 3604736054, -- 49
	["Gear:Shrink Mushroom:1"]       = 3604736070, -- 50
	["Gear:Supersize Mushroom:1"]    = 3604736084, -- 51
	["Gear:Invisibility Mushroom:1"] = 3604736099, -- 52
	["Gear:Teleporter:1"]            = 3604736107, -- 53
	["Gear:Super Watering Can:1"]    = 3604736116, -- 54
	["Gear:Basic Pot:1"]             = 3604736130, -- 55
	["Gear:Flashbang:1"]             = 3604736141, -- 56

	--==================================================================
	-- SEMILLAS x1   (SeedShop > Robux_Shelf / ToggleRobux)
	-- (descomenta y pon tu ID; los x3/x10 los pone la tabla dinámica)
	--==================================================================
	["Seed:Carrot:1"]            = 3604653624, -- 1
	["Seed:Strawberry:1"]        = 3604653650, -- 2
	["Seed:Blueberry:1"]         = 3604653664, -- 3
	["Seed:Tulip:1"]             = 3604653674, -- 4
	["Seed:Tomato:1"]            = 3604653699, -- 5
	["Seed:Apple:1"]             = 3604653114, -- 6
	["Seed:Bamboo:1"]            = 3604653727, -- 7
	["Seed:Corn:1"]              = 3604653755, -- 8
	["Seed:Cactus:1"]            = 3604653774, -- 9
	["Seed:Pineapple:1"]         = 3604653795, -- 10
	["Seed:Mushroom:1"]          = 3604653812, -- 11
	["Seed:Green Bean:1"]        = 3604653825, -- 12
	["Seed:Banana:1"]            = 3604653837, -- 13
	["Seed:Grape:1"]             = 3604653852, -- 14
	["Seed:Coconut:1"]           = 3604653879, -- 15
	["Seed:Mango:1"]             = 3604653895, -- 16
	["Seed:Dragon Fruit:1"]      = 3604653911, -- 17
	["Seed:Acorn:1"]             = 3604653925, -- 18 (67)
	["Seed:Cherry:1"]            = 3604653944, -- 19
	["Seed:Sunflower:1"]         = 3604653965, -- 20
	["Seed:Venus Fly Trap:1"]    = 3604735241, -- 21
	["Seed:Pomegranate:1"]       = 3604735252, -- 22
	["Seed:Poison Apple:1"]      = 3604735285, -- 23
	["Seed:Moon Bloom:1"]        = 3604735291, -- 24
	["Seed:Dragon's Breath:1"]   = 3604735297, -- 25
	["Seed:Ghost Pepper:1"]      = 3604735306, -- 26
	["Seed:Poison Ivy:1"]        = 3604735312, -- 27
	["Seed:Baby Cactus:1"]       = 3604735423, -- 28
	["Seed:Glow Mushroom:1"]     = 3604735428, -- 29
	["Seed:Romanesco:1"]         = 3604735442, -- 30
	["Seed:Horned Melon:1"]      = 3604735449, -- 31 (##)
	["Seed:Gold:1"]              = 3604735451, -- 32
	["Seed:Rainbow:1"]           = 3604735459, -- 33
}

----------------------------------------------------------------------
-- 3) TABLA DINÁMICA: aplica los IDs compartidos a TODOS los x3/x10
--    de SeedShop (prefijo "Seed") y GearShop (prefijo "Gear").
----------------------------------------------------------------------

-- Nombres de respaldo por si no se pudiera leer el data module.
local FALLBACK_SEEDS = {
	"Carrot","Strawberry","Blueberry","Tulip","Tomato","Apple","Bamboo","Corn","Cactus",
	"Pineapple","Mushroom","Green Bean","Banana","Grape","Coconut","Mango","Dragon Fruit",
	"Acorn","Cherry","Sunflower","Venus Fly Trap","Pomegranate","Poison Apple","Moon Bloom",
	"Dragon's Breath","Ghost Pepper","Poison Ivy","Baby Cactus","Glow Mushroom","Romanesco",
	"Horned Melon","Gold","Rainbow",
}
local FALLBACK_GEARS = {
	"Common Watering Can","Common Sprinkler","Sign","Lantern","Wheelbarrow","Uncommon Sprinkler",
	"Rare Sprinkler","Legendary Sprinkler","Super Sprinkler","Trowel","Speed Mushroom","Jump Mushroom",
	"Gnome","Shrink Mushroom","Supersize Mushroom","Invisibility Mushroom","Teleporter",
	"Super Watering Can","Basic Pot","Flashbang",
}

local function dedupeList(list)
	local seen, out = {}, {}
	for _, name in ipairs(list) do
		if type(name) == "string" and name ~= "" and not seen[name] then
			seen[name] = true
			out[#out + 1] = name
		end
	end
	return out
end

local function getSeedNames()
	local out = {}
	local ok, SeedData = pcall(require, ReplicatedStorage.SharedModules.SeedData)
	if ok and type(SeedData) == "table" then
		for _, entry in pairs(SeedData) do
			if type(entry) == "table" and type(entry.SeedName) == "string" then
				out[#out + 1] = entry.SeedName
			end
		end
	end
	if #out == 0 then
		out = FALLBACK_SEEDS
	end
	return dedupeList(out)
end

local function getGearNames()
	local out = {}
	local ok, GearShopData = pcall(require, ReplicatedStorage.SharedModules.GearShopData)
	if ok and type(GearShopData) == "table" and type(GearShopData.Data) == "table" then
		-- GearShopData.Data es un ARRAY; el nombre del gear está en .ItemName
		for _, entry in pairs(GearShopData.Data) do
			if type(entry) == "table" and type(entry.ItemName) == "string" then
				out[#out + 1] = entry.ItemName
			end
		end
	end
	if #out == 0 then
		out = FALLBACK_GEARS
	end
	return dedupeList(out)
end

-- Registra <prefijo>:<nombre>:<cantidad> (y su variante :Gift) con el ID compartido.
local function applyBulk(prefix, names)
	for _, name in ipairs(names) do
		for qty, id in pairs(BULK_PRODUCT_IDS) do
			if type(id) == "number" and id > 0 and qty ~= 1 then
				local key = ("%s:%s:%d"):format(prefix, name, qty)
				Products[key] = id
				Products[key .. ":Gift"] = id  -- el botón Gift reusa el mismo ID
			end
		end
	end
end

applyBulk("Seed", getSeedNames())
applyBulk("Gear", getGearNames())

----------------------------------------------------------------------
-- 4) GAMEPASSES
----------------------------------------------------------------------
local Gamepasses = {
	["Gamepass:VineWrapper:1"]   = 1874395877,
	["Gamepass:PowerHose:1"]     = 1875849873,
	["Gamepass:FreezeRay:1"]     = 1874485832,
	["Gamepass:RainbowCarpet:1"] = 1875633875,
}

return {
	Products = Products,
	Gamepasses = Gamepasses,
}
