--credit to quartz games studio
--[[
	MultiplierProductIds  (MODDED)
	====================================================================
	Escalera del multiplicador de SHECKLES (botón P2W > Third > X2schekles).
	Se compran EN ORDEN: cada compra sube al siguiente multiplicador (x2, x4, x8…)
	hasta x1000, y se puede comprar infinitas veces (hasta el tope de la lista).

	Poné TU DevProductId por cada tier (0 = sin definir, no comprable todavía).
	El multiplicador aplica a los SHECKLES GANADOS al vender (PlantService).
	El server (DevProductService) lo otorga en ProcessReceipt y persiste (GameServer).

	Podés agregar/cambiar tiers libremente (deben ir en orden creciente de mult).
]]

return {
	ScheckleTiers = {
		{ mult = 2,    productId = 3604758508 },
		{ mult = 4,    productId = 3604758545 },
		{ mult = 8,    productId = 3604758558 },
		{ mult = 12,   productId = 3604758580 },
		{ mult = 16,   productId = 3604758631 },
		{ mult = 18,   productId = 3604758708 },
		{ mult = 22,   productId = 3604763438 },
		{ mult = 24,   productId = 3604763473 },
		{ mult = 30,   productId = 3604763509 },
		{ mult = 40,   productId = 3604763543 },
		{ mult = 55,   productId = 3604763606 },
		{ mult = 75,   productId = 3604763636 },
		{ mult = 100,  productId = 3604763684 },
		{ mult = 250,  productId = 3604763724 },
		{ mult = 760,  productId = 3604763757 },
		{ mult = 1000, productId = 3604763791 },
	},
}
