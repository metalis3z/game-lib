--credit to prince games studio
--[[
	ProductIds  (MODDED)
	====================================================================
	Acá van TODOS los DevProductId de las funciones modded que compran con
	Robux directo (MarketplaceService:PromptProductPurchase), NO por el
	sistema de keys de la SeedShop/GearShop (eso vive en DevProductOverrides).

	Los usan:
	  • StarterGui.P2W.P2WClient            -> First (botones) y Second (rainbow pets)
	  • StarterGui.RobuxShop ...Admin.AdminBuyClient  -> 4 sets de Admin Panel
	  • StarterGui.RobuxShop ...Pets.PetBuyClient      -> 4 pets
	  • ServerScriptService.DevProductService -> los ENTREGA en ProcessReceipt

	Poné TU DevProductId en cada uno (0 = sin definir, no se puede comprar todavía).
	En Studio el prompt de Robux no se completa; probar en el juego publicado.
]]

return {
	Products = {
		--==============================================================
		-- P2W  >  First  >  Buttons   (compra directa)
		--==============================================================
		SpawnAllWeathers = 3604751171,   -- "SpawnAllWeather": fuerza TODOS los climas a la vez
		OPSeedPacks      = 3604751196,   -- "OPseedPacks":     da varios Ghost Pepper Packs
		RandomOpPet      = 3604751215,   -- "RandomOPPet":     da una pet rara al azar
		OpSizeRandomSeed = 3604758433,            -- P2W Third "OpSizeRandomSeed": seed random que crece gigante
		SpawnRandomHugeOpPet = 3604770080,       -- P2W fourth "SpawnRandonHugeOpet": pet OP random tamaño Huge

		--==============================================================
		-- P2W  >  Second   (pets rainbow)
		--==============================================================
		RainbowRaccoon    = 3604751103,  -- da pet Raccoon
		RainbowIceSerpent = 3604751107,  -- da pet Ice Serpent

		--==============================================================
		-- RobuxShop > Admin   (acceso al Admin Panel)
		--==============================================================
		AdminPanel5    = 3604751294,     -- Set1: 5 minutos de acceso
		AdminPanel10   = 3604751307,    -- Set2: 10 minutos de acceso
		AdminPanel15   = 3604751334,     -- Set3: 15 minutos de acceso
		AdminPanelPerm = 3604751353,     -- Set4: acceso PERMANENTE (muestra "Owned")

		--==============================================================
		-- RobuxShop > Pets   (comprar pet con Robux)
		--==============================================================
		PetRaccoon    = 3604750901,      -- Raccoon
		PetIceSerpent = 3604750912,      -- Ice Serpent
		PetUnicorn    = 3604751042,      -- Unicorn
		PetDragonfly  = 3604750934,      -- Dragonfly (pet real: GoldenDragonfly)

		--==============================================================
		-- Ban Hammer  (compra con Robux: 5 R$)
		--==============================================================
		BanHammer        = 3604869556,   -- da el Ban Hammer (tool no-persistente)
		BanHammerRevenge = 3604872275,   -- Revenge: libera al baneado y banea al baneador
	},
}
