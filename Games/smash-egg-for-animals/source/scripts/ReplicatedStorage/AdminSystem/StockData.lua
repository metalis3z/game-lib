-- Shared state between AdminServer and PetServer (server-side only)
-- Stock: nil = unlimited (default), 0 = out of stock, >0 = available
-- Codes: code -> {MaxUses = number, Uses = number, Rewards = {Money=0, Eggs={}, Pets={}}}

local StockData = {
	Stock = {},
	Codes = {},
}

return StockData