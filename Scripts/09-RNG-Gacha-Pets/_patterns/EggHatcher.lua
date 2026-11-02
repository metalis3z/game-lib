--!strict
-- EggHatcher: server-authoritative egg hatching (cost, luck, tiers, mutations, index, auto-hatch).
-- Pattern module written for this library. Ideas taken from:
--   rcu-roller (EggService: rate limit, amount clamp, cost check, weight^(1/luck), Golden/Toxic tier roll,
--               stack duplicates, index descriptor "name:tier")
--   slime-rng (RollService: independent mutation chances, auto-equip into free slots, index update)
--   pet-rng   (what NOT to do: rolling on the client and sending the pet name to the server)
-- Needs WeightedTable.lua next to it.
--
-- Usage (Script in ServerScriptService):
--   local EggHatcher = require(script.Parent.EggHatcher)
--   local hatcher = EggHatcher.new({
--       Eggs = {
--           Basic = { Cost = 100, Currency = "Coins", Pets = { Dog = 60, Cat = 35, Unicorn = 5 } },
--       },
--       Tiers = { { Name = "Golden", Chance = 0.01 }, { Name = "Rainbow", Chance = 0.001 } }, -- rarest last
--       Mutations = { Shiny = 0.02, Huge = 0.005 },
--       MaxPerRequest = 8,
--       Cooldown = 0.5,
--       Store = {  -- plug in your own data layer (ProfileService, DataStore wrapper, etc.)
--           GetBalance = function(player, currency) return profile(player).Data[currency] end,
--           Spend      = function(player, currency, amount) profile(player).Data[currency] -= amount end,
--           AddPet     = function(player, pet) table.insert(profile(player).Data.Pets, pet) end,
--           MarkIndex  = function(player, key) profile(player).Data.Index[key] = true end,
--           GetLuck    = function(player) return 1 + boosts(player) end,
--           CanHatch   = function(player, eggId) return #profile(player).Data.Pets < 500 end,  -- optional
--       },
--   })
--   HatchRemote.OnServerInvoke = function(player, eggId, amount)
--       return hatcher:Hatch(player, eggId, amount)    -- returns ok, results-or-reason
--   end
--   Players.PlayerRemoving:Connect(function(p) hatcher:Forget(p) end)
--
-- Auto-hatch: keep the loop on the client (it just calls the remote again after the animation);
-- the server cooldown + cost check make that safe.

local HttpService = game:GetService("HttpService") -- only for GenerateGUID, no web requests
local WeightedTable = require(script.Parent.WeightedTable)

export type Pet = { Id: string, Name: string, Tier: string?, Mutations: { [string]: boolean }?, Egg: string, At: number }

local EggHatcher = {}
EggHatcher.__index = EggHatcher

function EggHatcher.new(config)
	local self = setmetatable({}, EggHatcher)
	self.Config = config
	self.Store = config.Store
	self.Tables = {}
	self.LastHatch = {}
	for eggId, egg in pairs(config.Eggs) do
		local entries = {}
		for petName, weight in pairs(egg.Pets) do
			table.insert(entries, { Value = petName, Weight = weight })
		end
		table.sort(entries, function(a, b) return a.Weight > b.Weight end) -- most common first
		self.Tables[eggId] = WeightedTable.new(entries)
	end
	return self
end

-- tier roll: rarest tier is checked first, each with an independent chance scaled by luck
function EggHatcher:_rollTier(luck: number): string?
	local tiers = self.Config.Tiers or {}
	for i = #tiers, 1, -1 do
		local t = tiers[i]
		if math.random() < math.min(t.Chance * luck, 1) then
			return t.Name
		end
	end
	return nil
end

function EggHatcher:_rollMutations(luck: number): { [string]: boolean }?
	local muts = self.Config.Mutations
	if not muts then
		return nil
	end
	local got, any = {}, false
	for name, chance in pairs(muts) do
		if math.random() < math.min(chance * luck, 1) then
			got[name] = true
			any = true
		end
	end
	return if any then got else nil
end

-- Returns (true, { Pet, ... }) or (false, reason)
function EggHatcher:Hatch(player: Player, eggId: any, amount: any): (boolean, any)
	-- 1. never trust remote arguments
	if type(eggId) ~= "string" then
		return false, "BadEgg"
	end
	local egg = self.Config.Eggs[eggId]
	local tbl = self.Tables[eggId]
	if not egg or not tbl then
		return false, "BadEgg"
	end
	local count = math.clamp(math.floor(tonumber(amount) or 1), 1, self.Config.MaxPerRequest or 1)

	-- 2. rate limit (stops auto-clickers and exploit spam)
	local now = os.clock()
	if now - (self.LastHatch[player] or 0) < (self.Config.Cooldown or 0.5) then
		return false, "Cooldown"
	end
	self.LastHatch[player] = now

	-- 3. optional custom gate (inventory full, zone not unlocked, ...)
	if self.Store.CanHatch and not self.Store.CanHatch(player, eggId, count) then
		return false, "CannotHatch"
	end

	-- 4. cost check and spend BEFORE rolling
	local currency = egg.Currency or "Coins"
	local total = (egg.Cost or 0) * count
	if (self.Store.GetBalance(player, currency) or 0) < total then
		return false, "NotEnough"
	end
	self.Store.Spend(player, currency, total)

	-- 5. roll everything on the server
	local luck = math.max(self.Store.GetLuck and self.Store.GetLuck(player) or 1, 1)
	local results = {}
	for _ = 1, count do
		local petName = tbl:Roll(luck, "Exponent")
		local tier = self:_rollTier(luck)
		local pet: Pet = {
			Id = HttpService:GenerateGUID(false),
			Name = petName,
			Tier = tier,
			Mutations = self:_rollMutations(luck),
			Egg = eggId,
			At = os.time(),
		}
		self.Store.AddPet(player, pet)
		if self.Store.MarkIndex then
			self.Store.MarkIndex(player, petName .. ":" .. (tier or "Normal"))
		end
		table.insert(results, pet)
	end

	-- 6. the client only gets the results to animate; it never decides them
	return true, results
end

-- Odds text for the egg preview UI ("1/20"), computed on the server or client from the same config.
function EggHatcher:Odds(eggId: string, petName: string, luck: number?): string
	local tbl = self.Tables[eggId]
	return if tbl then tbl:OddsText(petName, luck, "Exponent") else "?"
end

function EggHatcher:Forget(player: Player)
	self.LastHatch[player] = nil
end

return EggHatcher
