local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = {}

-- =====================================================================
-- Core: Player Data
-- =====================================================================
-- Every field here is persisted to ProfileService. Adding a new field is
-- safe; renaming or removing a field invalidates existing saves.

GameConfig.Data = {}

GameConfig.Data.PlayerDataTemplate = {
	-- Currency / progression
	Cash             = 100,
	TotalCash        = 0,
	Rebirths         = 0,
	-- Clicker stats: StrengthClickServer mirrors these into the Strength /
	-- Level / XP player attributes on profile load and writes gains back.
	Strength         = 0,
	Level            = 1,
	XP               = 0,
	-- Strength ladder tier owned (GameConfig.StrengthLadder dev products,
	-- StrengthLadderServer): every strength gain is multiplied by 2^tier.
	StrengthMultLevel = 0,

	-- Inventory
	Inventory          = {},
	BrainrotInventory  = {},
	BrainrotUnlocked   = {},
	PlacedBrainrot     = {},
	EquippedItem       = "",

	-- Upgrades
	StorageLevel      = 0,
	DamageLevel       = 0,
	CarryLevel        = 0,
	BaseUpgradeLevel  = 0,

	-- Axes
	OwnedAxes         = {},
	SelectedAxe       = "",

	-- Drills (drill shop)
	OwnedDrills       = {},
	SelectedDrill     = "",

	-- Trails (trail shop)
	OwnedTrails       = {},
	EquippedTrail     = "",

	-- Activity / tree chopping
	BridgeMaterial    = 0,

	-- Tutorial
	TutorialStage     = 0,
	TutorialComplete  = false,

	-- Favorite-game reminder: set true once the player has seen & dismissed the
	-- "Favorite the game" popup, so it never shows again on future visits.
	FavoritePromptDone = false,

	-- Index / boosts
	IndexRewardsClaimed = {},
	IndexCashBoost      = 0,
	-- Loot index: [itemName] = true once the player has ever picked it up
	LootDiscovered      = {},
	-- Paid pedestal loot (e.g. Dragon Egg) that must survive a rejoin even if
	-- the buyer never sold it. Farmed loot stays session-only; ONLY entries
	-- flagged persistent (Robux pedestal grants) are mirrored here, each as
	-- { Item, Rarity, Value, Uid }.
	PersistentLoot      = {},

	-- Shop / packs
	PurchasedPacks            = {},
	-- Lucky block store gamepasses: [storeKey] = true once the one-time
	-- block grant for that pass has been delivered (survives rejoins).
	LuckyBlockPassGranted     = {},
	StarterPackPlaytimeUsed   = 0,

	-- Daily reward
	DailyRewardDay        = 1,
	DailyRewardLastClaim  = 0,
	DailyRewardStreak     = 0,

	-- Settings + session bookkeeping
	Settings           = {},
	FirstLogin         = 0,
	LastLogin          = 0,
	TotalPlaytime      = 0,
	TotalRobuxSpent    = 0,
	PurchaseHistory    = {},
}

-- =====================================================================
-- Progression: Rarity / Rarities / Rebirth / Upgrades / BaseUpgrades
-- =====================================================================

-- Numeric sort-order lookup. Used wherever code needs to compare two
-- rarities ("Mythic" > "Epic"). Keep the values dense (1..N) so simple
-- numeric comparisons work.
GameConfig.Rarity = {
	Common    = 1,
	Uncommon  = 2,
	Rare      = 3,
	Epic      = 4,
	Legendary = 5,
	Mythic    = 6,
	Exclusive = 7,
	-- Store loot-block tiers (Gradients.Rarity ships matching UIGradients).
	Godly     = 8,
	Secret    = 9,
	Divine    = 10,
	-- Zone-30-exclusive loot tier (RarityItemsConfig Rainbow / Rainbow Gem)
	Rainbow   = 11,
}

-- =====================================================================
-- Brainrot pack (ReplicatedStorage.Brainrots)
-- =====================================================================
-- New pack layout: ReplicatedStorage.Brainrots.<Rarity>.<Mutation>.<modelName>.
-- We auto-import every Normal-mutation model under each rarity into
-- GameConfig.Items, so adding/removing a model in the pack just shows up in
-- the game on next reload. The Secret folder is promoted to the Exclusive
-- rarity to match the existing GameConfig.Rarity enum.
local BRAINROTS_FOLDER = ReplicatedStorage:WaitForChild("Brainrots")
local FOLDER_TO_RARITY = {
	Common = "Common", Uncommon = "Uncommon", Rare = "Rare",
	Epic = "Epic", Legendary = "Legendary", Mythic = "Mythic",
	Secret = "Exclusive",
}
-- Tuned so endgame upgrades are reachable in ~8-12h of dedicated play.
-- The cash brake for the RainbowAxe ($25B) is intentionally kept long --
-- the user's pacing target is for the player to finish the *upgrades*
-- (Storage 175) in ~8h, not to also unlock every axe tier. Late upgrade
-- tiers still carry the heavy lift -- a Mythic podium farm is what drives
-- the player past the $100M threshold for maxed Storage/Damage.
local CPS_BY_RARITY = {
	Common = 8, Uncommon = 25, Rare = 70, Epic = 200,
	Legendary = 800, Mythic = 3500, Exclusive = 12000,
}

local function prettifyBrainrotName(raw)
	local s = raw:gsub("_Rig$", ""):gsub("_Idle$", ""):gsub("_", " ")
	-- Split lower→upper transitions: "CactoHipopotamo" → "Cacto Hipopotamo".
	s = s:gsub("(%l)(%u)", "%1 %2")
	return s
end

-- Build the rarity → brainrotId[] map. Same brainrot model showing up in
-- multiple rarities (shouldn't happen in the pack, but be defensive) gets
-- pinned to the first rarity it appears in.
GameConfig.BrainrotsByRarity = {}
local _seenBrainrots = {}
for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
	local rarity = FOLDER_TO_RARITY[rarityFolder.Name]
	if rarity then
		local normalFolder = rarityFolder:FindFirstChild("Normal")
		if normalFolder then
			GameConfig.BrainrotsByRarity[rarity] = GameConfig.BrainrotsByRarity[rarity] or {}
			for _, model in ipairs(normalFolder:GetChildren()) do
				if model:IsA("Model") and not _seenBrainrots[model.Name] then
					_seenBrainrots[model.Name] = rarity
					table.insert(GameConfig.BrainrotsByRarity[rarity], model.Name)
				end
			end
		end
	end
end

-- ReplicatedStorage.Brainrots.<Rarity>.<MutationFolder>.<brainrotId>. Mutation
-- folder names match GameConfig.Mutations entries (Normal is the implicit base).
function GameConfig.GetBrainrotTemplate(brainrotId, mutationId)
	local rarity = _seenBrainrots[brainrotId]
	if not rarity then return nil end
	-- Re-resolve the rarity folder via reverse map
	local rarityFolderName = nil
	for folderName, mapped in pairs(FOLDER_TO_RARITY) do
		if mapped == rarity then rarityFolderName = folderName; break end
	end
	if not rarityFolderName then return nil end
	local rarityFolder = BRAINROTS_FOLDER:FindFirstChild(rarityFolderName)
	if not rarityFolder then return nil end
	local mutationFolder = (mutationId and mutationId ~= "") and rarityFolder:FindFirstChild(mutationId) or rarityFolder:FindFirstChild("Normal")
	if not mutationFolder then
		mutationFolder = rarityFolder:FindFirstChild("Normal")
	end
	if not mutationFolder then return nil end
	return mutationFolder:FindFirstChild(brainrotId)
end

-- Display metadata for each rarity. The shop / inventory / index controllers
-- read DisplayName + Gradient to colour cards and labels.
GameConfig.Rarities = {
	Common = {
		Order = 1,
		DisplayName = "Common",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 220, 220)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160)),
		}),
	},
	Uncommon = {
		Order = 2,
		DisplayName = "Uncommon",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 240, 160)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 180, 90)),
		}),
	},
	Rare = {
		Order = 3,
		DisplayName = "Rare",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 230, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 130, 220)),
		}),
	},
	Epic = {
		Order = 4,
		DisplayName = "Epic",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 100, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 40, 200)),
		}),
	},
	Legendary = {
		Order = 5,
		DisplayName = "Legendary",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 60)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 40)),
		}),
	},
	Mythic = {
		Order = 6,
		DisplayName = "Mythic",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 90)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 20, 30)),
		}),
	},
	Exclusive = {
		Order = 7,
		-- Internally still keyed 'Exclusive' (Rarity enum + Items.<id>.Rarity)
		-- but rendered as 'Secret' in every player-facing label so the brainrots
		-- coming from SecretIsland actually read as 'Secret' in the world.
		DisplayName = "Secret",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 180, 180)),
			ColorSequenceKeypoint.new(1.0, Color3.fromRGB(  0,   0,   0)),
		}),
	},
	-- Godly / Divine: drill-shop-only tiers above Mythic. Authored
	-- UIGradients with the same names exist in ReplicatedStorage.Gradients.Rarity
	-- and win over these fallback sequences on the cards.
	Godly = {
		Order = 8,
		DisplayName = "Godly",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 40, 210)),
		}),
	},
	Divine = {
		Order = 9,
		DisplayName = "Divine",
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 130)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 120, 20)),
		}),
	},
}

GameConfig.Rebirth = {
	CashMultiplierPerRebirth     = 0.25,
	MaterialMultiplierPerRebirth = 0.5,
	-- Rebirth resets Strength to 0 (ONLY Strength -- drills/trails/level/
	-- upgrades and every other boost survive) and pays it back with a
	-- permanent Strength-GAIN multiplier: x(1 + N * this) on clicks and
	-- training pads, stacking multiplicatively with drill Power and the
	-- trail boost.
	StrengthMultiplierPerRebirth = 0.5,
	-- Rebirth N (0-based) requires LevelRequiredTable[N + 1]; past the
	-- table each further rebirth adds LevelRequiredTailStep. Retuned
	-- 2026-07-23 (user: "first rebirth stays easy, the next ones WAY
	-- harder -- people finish the game in a few playtime hours"): the old
	-- linear 25 + 25*N (250 by rebirth 10) collapsed against the
	-- exponential income stack (x1.5 gain per rebirth * drills * trails *
	-- the x2..x1024 strength ladder). On the 1.05 XP curve every +14
	-- levels DOUBLES the total XP, so the late entries below are real
	-- walls: rebirth 10 at level 520 costs ~150,000x the XP of the old
	-- level-275 gate. Robux skips (RobuxLadder) bypass the gate unchanged.
	-- Single source of truth: GetRequiredLevel below -- RebirthService
	-- (the gate), RebirthController (the frame) and the HUD
	-- RebirthProgressController all call it.
	LevelRequiredTable           = { 25, 100, 175, 250, 300, 350, 400, 440, 480, 520 },
	LevelRequiredTailStep        = 40,
	-- Storage now caps at 10 on an exponential ladder, so each rebirth asks
	-- for ONE more slot than the last (clamped to max storage in
	-- RebirthService.getRequiredStorage -- rebirths stay possible forever).
	StorageRequiredIncrement     = 1,
	-- Escalating Robux skip (user request 2026-07-17): entry [rebirths + 1]
	-- is the product that buys the NEXT rebirth, so the price climbs on
	-- every purchase (29 -> 99 -> 199 -> ... -> 2499). Only the first
	-- MaxRobuxRebirths rebirths are buyable -- past that the Skip button
	-- hides and rebirths must be earned by level. RebirthService picks the
	-- product server-side from the player's CURRENT rebirth count and
	-- grants in the purchase callback (the client never chooses a product).
	-- Entry 1 is the original "Skip Rebirth" product (R$29).
	MaxRobuxRebirths             = 10,
	RobuxLadder = {
		{ Price = 29,   ProductId = 3632907213 },
		{ Price = 99,   ProductId = 3632908638 },
		{ Price = 199,  ProductId = 3632909952 },
		{ Price = 299,  ProductId = 3632911055 },
		{ Price = 499,  ProductId = 3632912045 },
		{ Price = 749,  ProductId = 3632913998 },
		{ Price = 999,  ProductId = 3632914981 },
		{ Price = 1499, ProductId = 3632916913 },
		{ Price = 1999, ProductId = 3632917684 },
		{ Price = 2499, ProductId = 3632918571 },
	},
	Sound                        = "rbxassetid://112283037672337",
}

function GameConfig.Rebirth.GetRequiredLevel(rebirths)
	local r = GameConfig.Rebirth
	local n = math.max(rebirths or 0, 0)
	local t = r.LevelRequiredTable
	if n < #t then
		return t[n + 1]
	end
	return t[#t] + r.LevelRequiredTailStep * (n - #t + 1)
end

-- Per-stat upgrade tuning. Cost at level N -> N+1 is
--   floor(CostBase * CostMultiplier^N / 10) * 10 + CostOffset
-- The snap-to-$10 + per-stat CostOffset guarantees that no two upgrades
-- (across Storage / Damage / Carry / BaseUpgrades) can ever share an exact
-- price -- the cost mod 10 is fixed per stat and the offsets {0, 3, 0, 9}
-- keep prices visually distinct. ResetOnRebirth = true zeroes the level on rebirth.
--
-- Pacing target: anchored to actual brainrot CPS_BY_RARITY income
-- (Common 8/s, Uncommon 25/s, Rare 70/s, Epic 200/s, Legendary 800/s,
-- Mythic 3.5K/s, Secret 12K/s). Each upgrade level costs roughly 1-15 minutes
-- of the income tier where it becomes available, so a player progressing
-- through islands keeps unlocking upgrades in seconds-minutes rather than
-- hours. Final L165 Storage ~ $500M = ~1 hour of endgame Secret farming
-- (30 podiums of mixed Mythic/Secret yields ~$9M/min).
GameConfig.Upgrades = {
	Storage = {
		-- Loot backpack slots: start at 1, +1 per level. Retuned 2026-07-16
		-- (user: "thousands -> hundreds of thousands -> millions in just
		-- three upgrades; it should not be this easy") -- explicit CostTable
		-- replaces the old x4 exponential ($4K/$16K/$64K early was too cheap).
		-- CostTable[level+1] = cost to buy the NEXT slot:
		--   L0 $5K (->2)    L1 $250K (->3)   L2 $2.5M (->4)
		--   L3 $10M (->5)   L4 $40M (->6)    L5 $160M (->7)
		--   L6 $640M (->8)  L7 $2.5B (->9)   L8 $10B (->10, final)
		Base = 1, PerLevel = 1, MaxLevel = 9,
		CostTable = { 5_000, 250_000, 2_500_000, 10_000_000, 40_000_000,
			160_000_000, 640_000_000, 2_500_000_000, 10_000_000_000 },
		CostBase = 4000, CostOffset = 0,
		CostMultiplier = 4.0, -- fallback beyond the table (unused at MaxLevel 9)
		RobuxSingleProductId = 3610222136, -- legacy "+1 Storage Slot" (R$40); superseded by RobuxLadder
		-- Escalating per-level Robux price (user request): entry [level+1]
		-- is the product for buying the NEXT level. Charged prices verified.
		RobuxLadder = {
			{ Price = 9,   ProductId = 3633043736 },
			{ Price = 40,  ProductId = 3633050374 },
			{ Price = 99,  ProductId = 3633070268 },
			{ Price = 139, ProductId = 3633078866 },
			{ Price = 199, ProductId = 3633079726 },
			{ Price = 249, ProductId = 3633080648 },
			{ Price = 299, ProductId = 3633081732 },
			{ Price = 399, ProductId = 3633082732 },
			{ Price = 499, ProductId = 3633083597 },
		},
		ResetOnRebirth = true,
	},
	Damage = {
		-- Damage L0 = $203, same shape as Storage but ~4x base since damage
		-- benefits stack with the axe ladder (RainbowAxe 800x) for tree
		-- chopping. Approximate ladder:
		--   L0: $203   L10: ~$520   L20: ~$2.1K   L30: ~$5.4K
		--   L50: ~$37K   L80: ~$640K   L100: ~$4.3M
		--   L130: ~$75M   L150: ~$505M
		Base = 5, PerLevel = 1, MaxLevel = 150,
		CostBase = 200, CostOffset = 3,
		CostMultiplier = 1.10, -- legacy fallback (= CostMultiplierLate)
		CostMultiplierEarly = 1.10,
		CostMultiplierMid   = 1.15,
		CostMultiplierLate  = 1.10,
		RobuxBulkAmount = 20, RobuxBulkProductId = 3610222137, -- "+20 Damage" (R$49)
		ResetOnRebirth = true,
	},
	Carry = {
		-- MaxLevel 3 -> max carry 4 brainrots (down from 8). User-requested
		-- cap so carry is a quick early-mid goal, not a late-rebirth grind.
		-- 4.0x per level keeps each step meaningful. Full ladder:
		--   L0: $500K (display 1 -> 2)
		--   L1: $2M   (display 2 -> 3)
		--   L2: $8M   (display 3 -> 4, final purchase)
		-- Total to max all 3 levels = $10.5M (~30 min Epic-tier farming).
		Base = 1, PerLevel = 1, MaxLevel = 3,
		CostBase = 500000, CostMultiplier = 4.0, CostOffset = 0,
		RobuxSingleProductId = 3610222139, -- "+1 Carry" (R$99)
		ResetOnRebirth = false,
	},
	Walkspeed = {
		-- Speed 36 at L0 (matches StarterPlayer.CharacterWalkSpeed; was 30 ->
		-- 60 -> 45, trimmed to 36 on 2026-07-22 -- user said 45 still too
		-- fast; 36 matches Kick Door), +1 per level up to 46. Applied to the
		-- Humanoid by UpgradeShopService via the "WalkSpeed" player
		-- attribute. Ladder: L0 $250K, L5 ~$1.9M, L9 ~$9.6M.
		Base = 36, PerLevel = 1, MaxLevel = 10,
		CostBase = 250000, CostMultiplier = 1.5, CostOffset = 5,
		RobuxSingleProductId = 3633056163, -- legacy "+1 Walkspeed" (R$16); superseded by RobuxLadder
		RobuxLadder = {
			{ Price = 9,   ProductId = 3633056163 },
			{ Price = 19,  ProductId = 3633058009 },
			{ Price = 29,  ProductId = 3633063369 },
			{ Price = 39,  ProductId = 3633089823 },
			{ Price = 49,  ProductId = 3633092025 },
			{ Price = 69,  ProductId = 3633093116 },
			{ Price = 99,  ProductId = 3633094024 },
			{ Price = 129, ProductId = 3633095148 },
			{ Price = 159, ProductId = 3633096594 },
			{ Price = 199, ProductId = 3633097494 },
		},
		ResetOnRebirth = false,
	},
}

-- Base slot upgrades — each upgrade reveals the next podium in order. Add
-- another Floors entry to extend with more podiums. MaxLevel is derived as
-- the sum of (LastPodiumIndex - FirstPodiumIndex + 1) across all floors.
GameConfig.BaseUpgrades = {
	-- 3-segment curve anchored to CPS_BY_RARITY income tiers (same pattern
	-- Storage uses). Pivots at L5 (Rare->Epic income transition, FirstFloor
	-- ends at L10) and L12 (SecondFloor begins, Legendary/Mythic chase).
	-- Approximate ladder:
	--   L1: $50K    L5: $418K    L10: $23.6M   L12: $136M
	--   L15: $3.3B  L18: $109B   L19: $350B    L20: $1.12T
	-- Early game is cheap so a fresh player buys their first 5-6 podiums
	-- quickly with Common income, while the final upgrade still lands in
	-- trillions so endgame has a real chase. Cost = floor(start*mult^L/10)*10
	-- + CostOffset, so every BaseUpgrade price ends in 9 and never collides
	-- with the per-stat upgrades (which end in 7, 3, 1).
	StartPrice          = 50000,
	PriceMultiplier     = 2.4, -- legacy fallback (= MidMultiplier)
	PriceMultiplierEarly = 1.7, -- L0-L5  (FirstFloor unlock pacing - gentle)
	PriceMultiplierMid   = 2.4, -- L6-L12 (SecondFloor transition)
	PriceMultiplierLate  = 3.2, -- L13+   (endgame trillion-tier chase)
	EarlyMidThreshold   = 5,
	MidLateThreshold    = 12,
	CostOffset          = 9,
	UpgradeSound    = "rbxassetid://2976773885",
	Floors = {
		{ Name = "FirstFloor",  FirstPodiumIndex = 11, LastPodiumIndex = 20 },
		{ Name = "SecondFloor", FirstPodiumIndex = 21, LastPodiumIndex = 30 },
	},
}

-- =====================================================================
-- World & Placeable Items
-- =====================================================================
-- Items = the placeable income-generators that spawn on islands and sit
-- on podiums. Auto-generated from the ReplicatedStorage.Brainrots pack —
-- one entry per Normal-mutation model under each rarity. Each entry's
-- CashPerSec scales with rarity (CPS_BY_RARITY above) so adding a new
-- brainrot is a drag-and-drop into the pack with no code change.

GameConfig.Items = {}
for rarity, brainrotIds in pairs(GameConfig.BrainrotsByRarity) do
	local cps = CPS_BY_RARITY[rarity] or 10
	for _, brainrotId in ipairs(brainrotIds) do
		GameConfig.Items[brainrotId] = {
			ModelName   = brainrotId,
			DisplayName = prettifyBrainrotName(brainrotId),
			Rarity      = rarity,
			CashPerSec  = cps,
			income      = cps,
			animationId = "",
			imageId     = "",
		}
	end
end

-- Defensive backfill so callers can still read .income / .rarity uniformly.
for _, cfg in pairs(GameConfig.Items) do
	cfg.income     = cfg.income or cfg.CashPerSec or 1
	cfg.CashPerSec = cfg.CashPerSec or cfg.income
	cfg.rarity     = cfg.rarity or cfg.Rarity or "Common"
end

-- Per-island config. Keyed by the Workspace.Assets.Islands.<Name> Part name.
-- Slot coordinates are in the island Part's object space:
--   lz = position along the long  (~270-stud) axis, useful range ~-120..120
--   lx = position along the narrow (~42-stud)  axis, useful range ~-15..15
GameConfig.Islands = {
	Zone1Island = {
		Order = 1,
		Rarity = "Common",
		DisplayName = "Common Island",
		RarityColor = Color3.fromRGB(200, 200, 200),
		brainrots = {
			"67",
			"Agarrini La Palini",
			"Ballerina Cappuccina",
			"Bananita Dolphinita",
		},
		slots = {
			{ lx =  -8, lz = -110, lifetime = math.random(45, 90), initialDelay = 0  },
			{ lx =   6, lz =  -70, lifetime = math.random(45, 90), initialDelay = 4  },
			{ lx =  -6, lz =  -30, lifetime = math.random(45, 90), initialDelay = 8  },
			{ lx =   8, lz =   10, lifetime = math.random(45, 90), initialDelay = 12 },
			{ lx =  -8, lz =   50, lifetime = math.random(45, 90), initialDelay = 16 },
			{ lx =   6, lz =   90, lifetime = math.random(45, 90), initialDelay = 20 },
		},
	},

	Zone2Island = {
		Order = 2,
		Rarity = "Uncommon",
		DisplayName = "Uncommon Island",
		RarityColor = Color3.fromRGB(120, 220, 120),
		-- No `brainrots` list on purpose: GameConfig.GetItemRarity builds its
		-- id->rarity cache from island `brainrots`, and the Uncommon lucky-block
		-- loot reuses ids that already belong to other islands. Keeping this
		-- island out of that cache avoids mislabelling those brainrots. The
		-- Uncommon loot table lives in the LuckyBlock config further below.
		slots = {
			{ lx =  -8, lz = -100, lifetime = math.random(45, 90), initialDelay = 0  },
			{ lx =   8, lz =  -50, lifetime = math.random(45, 90), initialDelay = 6  },
			{ lx =  -6, lz =    0, lifetime = math.random(45, 90), initialDelay = 12 },
			{ lx =   8, lz =   50, lifetime = math.random(45, 90), initialDelay = 18 },
			{ lx =  -8, lz =  100, lifetime = math.random(45, 90), initialDelay = 24 },
		},
	},

	Zone3Island = {
		Order = 3,
		Rarity = "Rare",
		DisplayName = "Rare Island",
		RarityColor = Color3.fromRGB(70, 130, 255),
		brainrots = {
			"Bombombini Gusini",
			"Boneca Ambalabu",
			"Cacto Hipopotamo",
			"Cappuccino Assassino",
		},
		slots = {
			{ lx =  -8, lz = -100, lifetime = math.random(45, 90), initialDelay = 0  },
			{ lx =   8, lz =  -50, lifetime = math.random(45, 90), initialDelay = 6  },
			{ lx =  -6, lz =    0, lifetime = math.random(45, 90), initialDelay = 12 },
			{ lx =   8, lz =   50, lifetime = math.random(45, 90), initialDelay = 18 },
			{ lx =  -8, lz =  100, lifetime = math.random(45, 90), initialDelay = 24 },
		},
	},

	Zone4Island = {
		Order = 4,
		Rarity = "Epic",
		DisplayName = "Epic Island",
		RarityColor = Color3.fromRGB(170, 80, 255),
		brainrots = {
			"Chimpanzini Bananini",
			"Cocofanto Elefanto",
			"Frigo Camelo",
			"Gangster Footera",
		},
		slots = {
			{ lx =  -8, lz =  -90, lifetime = math.random(45, 90), initialDelay = 0  },
			{ lx =   8, lz =  -30, lifetime = math.random(45, 90), initialDelay = 9  },
			{ lx =  -8, lz =   30, lifetime = math.random(45, 90), initialDelay = 18 },
			{ lx =   8, lz =   90, lifetime = math.random(45, 90), initialDelay = 27 },
		},
	},

	Zone5Island = {
		Order = 5,
		Rarity = "Legendary",
		DisplayName = "Legendary Island",
		RarityColor = Color3.fromRGB(255, 180, 50),
		brainrots = {
			"Karkerkar Kurkur",
			"La Vacca Saturno Saturnita",
			"Lirili Larila",
			"Los Bros",
		},
		slots = {
			{ lx =  -8, lz =  -80, lifetime = math.random(45, 90), initialDelay = 0  },
			{ lx =   8, lz =    0, lifetime = math.random(45, 90), initialDelay = 15 },
			{ lx =  -8, lz =   80, lifetime = math.random(45, 90), initialDelay = 30 },
		},
	},

	Zone6Island = {
		Order = 6,
		Rarity = "Mythic",
		DisplayName = "Mythic Island",
		RarityColor = Color3.fromRGB(255, 70, 70),
		brainrots = {
			"Los Tralaleritos",
			"Odin Din Din Dun",
			"Pakrahmatmamat",
			"Pipi Kiwi",
		},
		slots = {
			{ lx =  -8, lz =  -70, lifetime = math.random(45, 90), initialDelay = 0  },
			{ lx =   8, lz =    0, lifetime = math.random(45, 90), initialDelay = 20 },
			{ lx =  -8, lz =   70, lifetime = math.random(45, 90), initialDelay = 40 },
		},
	},

	Zone7Island = {
		Order = 7,
		Rarity = "Exclusive",
		DisplayName = "Secret Island",
		RarityColor = Color3.fromRGB(255, 255, 100),
		brainrots = {
			"Rhino Toasterino",
			"Tralalero Tralala",
			"Trippi Troppi",
			"Trulimero Trulicina",
			"Tung Tung Tung Sahur",
		},
		slots = {
			{ lx =  -8, lz =  -60, lifetime = math.random(45, 90), initialDelay = 0  },
			{ lx =   8, lz =   60, lifetime = math.random(45, 90), initialDelay = 60 },
		},
	},
}

-- Overwrite each island's `brainrots` list with the new-pack ids of its rarity
-- (and seed the empty UncommonIsland too). Old-pack hand-typed names are
-- ignored — the pack is now the source of truth.
for _, islandCfg in pairs(GameConfig.Islands) do
	local pool = GameConfig.BrainrotsByRarity[islandCfg.Rarity]
	if pool then
		local copy = {}
		for _, id in ipairs(pool) do table.insert(copy, id) end
		islandCfg.brainrots = copy
	end
end

-- Returns the rarity of an item, derived from which island it's listed under.
-- Falls back to the item's own Rarity / rarity field, then "Common".
local _itemRarityCache = nil
function GameConfig.GetItemRarity(brainrotId)
	if not _itemRarityCache then
		_itemRarityCache = {}
		for _, islandCfg in pairs(GameConfig.Islands or {}) do
			if islandCfg.brainrots then
				for _, brId in ipairs(islandCfg.brainrots) do
					_itemRarityCache[brId] = islandCfg.Rarity
				end
			end
		end
	end
	local cached = _itemRarityCache[brainrotId]
	if cached then return cached end
	local cfg = GameConfig.Items[brainrotId]
	return (cfg and (cfg.Rarity or cfg.rarity)) or "Common"
end

-- Per-mutation icon overrides for the item image shown in inventory / index /
-- podium UI. Leave a brainrotId out to fall back to the normal item icon
-- (tinted by ImageColor where the rendering code supports it).
local GoldImageIds = {
	-- ["Tralalero Tralala"] = "rbxassetid://...",
}

local DiamondImageIds = {
	-- ["Tralalero Tralala"] = "rbxassetid://...",
}

-- Per-mutation tuning. Only Golden / Diamond / Prismatic are live tiers.
--   SpawnChance: probability that a freshly-spawned brainrot (island item OR
--                lucky-block hatch) rolls this mutation. Remainder spawns
--                Normal. Roll order: rarest first, so a 1/5000 Prismatic
--                isn't shadowed by the 1/10 Golden cumulative bucket.
--   CashBoost:   multiplier applied to the item's CashPerSec when this mutation
--                is placed on a podium (1.10 = +10%, 1.25 = +25%, etc).
--   VFXName:     attachment under ReplicatedStorage.MutationVFX whose particle
--                children get cloned onto the brainrot's PrimaryPart.
--   GradientType: UIGradient name under ReplicatedStorage.Gradients.Type
--                applied to the mutation TextLabel in the podium billboard.
GameConfig.Mutations = {
	Golden = {
		DisplayName  = "Gold",
		GradientType = "Golden",
		ImageColor   = Color3.fromRGB(255, 215, 0),
		VFXName      = "GoldenVFX",
		SpawnChance  = 0.30,   -- 1 in ~3.3 (was 1 in 10)
		CashBoost    = 1.10,   -- +10%
		ImageIds     = GoldImageIds,
		FolderName   = "Golden",
	},
	Diamond = {
		DisplayName  = "Diamond",
		GradientType = "Diamond",
		ImageColor   = Color3.fromRGB(125, 249, 255),
		VFXName      = "DiamondVFX",
		SpawnChance  = 0.10,   -- 1 in 10 (was 1 in 100)
		CashBoost    = 1.15,   -- +15%
		ImageIds     = DiamondImageIds,
		FolderName   = "Diamond",
	},
	Prismatic = {
		DisplayName  = "Prismatic",
		GradientType = "Prismatic",
		ImageColor   = Color3.fromRGB(190, 140, 255),
		VFXName      = "PrismaticVFX",
		SpawnChance  = 0.01,   -- 1 in 100 (was 1 in 5000)
		CashBoost    = 1.25,   -- +25%
		ImageIds     = {},
		FolderName   = "Prismatic",
	},
}

-- Rarest-first roll order so cumulative probability lets the lowest-chance
-- mutation hit first. Edit this list if a new tier is added.
GameConfig.MutationRollOrder = { "Prismatic", "Diamond", "Golden" }

-- Returns the icon asset id for an item, checking mutation overrides first.
function GameConfig.GetItemImage(brainrotId, mutationId)
	if mutationId and mutationId ~= "" then
		local mutCfg = GameConfig.Mutations[mutationId]
		if mutCfg and mutCfg.ImageIds then
			local override = mutCfg.ImageIds[brainrotId]
			if override and override ~= "" then
				return override
			end
		end
	end
	local cfg = GameConfig.Items[brainrotId]
	if cfg then
		return cfg.imageId or cfg.ImageId or ""
	end
	return ""
end

-- Rolls a mutation id for a newly-spawned brainrot (island item OR lucky-block
-- hatch), or nil for a plain Normal spawn. Probabilities are taken from each
-- Mutations[id].SpawnChance; iteration walks GameConfig.MutationRollOrder so
-- the rarest tier gets the first shot at the roll (otherwise a 1/5000
-- Prismatic would be invisible behind a 1/10 Golden cumulative bucket).
function GameConfig.RollIslandMutation()
	local order = GameConfig.MutationRollOrder
	local roll = math.random()
	local cumulative = 0
	if order then
		for _, mutId in ipairs(order) do
			local mutCfg = GameConfig.Mutations[mutId]
			local chance = (mutCfg and mutCfg.SpawnChance) or 0
			if chance > 0 then
				cumulative = cumulative + chance
				if roll < cumulative then
					return mutId
				end
			end
		end
		return nil
	end
	-- Fallback (no roll-order list): unordered iteration like before.
	for mutId, mutCfg in pairs(GameConfig.Mutations) do
		local chance = mutCfg.SpawnChance or 0
		if chance > 0 then
			cumulative = cumulative + chance
			if roll < cumulative then
				return mutId
			end
		end
	end
	return nil
end

-- Index categories shown as tabs in StarterGui.GUI.Folder.Index.Buttons.
--   name             = button child name in the Buttons frame
--   mutationId       = nil for the un-mutated tab ("Normal"); else a Mutations key
--   Required         = how many items in this category must be unlocked to claim
--   CashBoostPercent = % added to all cash income while claimed
GameConfig.IndexCategories = {
	{ name = "Normal",  mutationId = nil,       Required = 20, CashBoostPercent = 25  },
	{ name = "Gold",    mutationId = "Gold",    Required = 15, CashBoostPercent = 50  },
	{ name = "Diamond", mutationId = "Diamond", Required = 10, CashBoostPercent = 100 },
}

-- Legacy lookup form keyed by category name (kept so IndexRewardService stays compatible).
GameConfig.IndexRewards = {}
for _, cat in ipairs(GameConfig.IndexCategories) do
	GameConfig.IndexRewards[cat.name] = {
		Required = cat.Required,
		CashBoostPercent = cat.CashBoostPercent,
		MutationId = cat.mutationId,
	}
end

-- =====================================================================
-- Activities: Trees / Bridge / Axes
-- =====================================================================

-- Reward jumps roughly track ChopsToFell jumps (below) so a tree of any tier
-- is ~40-60% of max storage when felled. With max storage 175, one Void
-- tree (250-450 wood reward) effectively caps the player after a single
-- chop -- but they need late-game axes + Damage to fell one in fewer than
-- ~20 swings.
GameConfig.Trees = {
	[1] = { TreeType = "Normal",  HealthMin = 20,   HealthMax = 40,   Cols = 3, Rows = 9, MaterialRewardMin = 5,   MaterialRewardMax = 10,  RespawnDelay = 10 },
	[2] = { TreeType = "Golden",  HealthMin = 100,  HealthMax = 200,  Cols = 3, Rows = 9, MaterialRewardMin = 50,  MaterialRewardMax = 90,  RespawnDelay = 10 },
	[3] = { TreeType = "Diamond", HealthMin = 500,  HealthMax = 1000, Cols = 3, Rows = 9, MaterialRewardMin = 130, MaterialRewardMax = 220, RespawnDelay = 10 },
	[4] = { TreeType = "Void",    HealthMin = 3000, HealthMax = 6000, Cols = 3, Rows = 9, MaterialRewardMin = 250, MaterialRewardMax = 450, RespawnDelay = 10 },
}

GameConfig.Bridge = {
	MaxStorage      = 10,
	StarterMaterial = 0,
	MaterialPerPart = 1,
	ChopRange       = 20,
	ChopFacingDot   = 0.3,
	MinTreeScale    = 0.45,
	-- Per-tree-area chop budget; the actual per-swing chop count comes from
	-- (player BaseDamage * axe DamageMultiplier / 5) in TreeAreaController,
	-- so a maxed Damage (155) + RainbowAxe (800x) player one-shots even Void
	-- trees while a fresh player with NormalAxe needs the full count below.
	-- L1 = 5 hits with the base NormalAxe (user-requested tutorial pacing).
	ChopsToFell     = { 5, 50, 300, 2000 },
}

-- DamageMultiplier is relative to NormalAxe = 1.0. Final damage =
-- player BaseDamage attribute * axe DamageMultiplier. Order drives shop
-- sorting; keys MUST match the Tool name in ReplicatedStorage.Axes.
-- Axe ladder paced across the full 24-36h curve. Each tier ~12-15x the
-- previous; final RainbowAxe at $25B is a true endgame purchase, paired
-- with maxed Damage so the per-swing chop output one-shots Void trees.
GameConfig.Axes = {
	NormalAxe  = { Order = 1, Price = 0,             SwingTime = 0.8,  DamageMultiplier = 1.0,   Rarity = "Common",    DisplayName = "Normal Axe",  ImageId = "131013959460709" },
	GoldAxe    = { Order = 2, Price = 10000,         SwingTime = 0.7,  DamageMultiplier = 3.0,   Rarity = "Common",    DisplayName = "Gold Axe",    ImageId = "90825477382509"  },
	DiamondAxe = { Order = 3, Price = 250000,        SwingTime = 0.6,  DamageMultiplier = 10.0,  Rarity = "Rare",      DisplayName = "Diamond Axe", ImageId = "131588095454209" },
	ToxicAxe   = { Order = 4, Price = 5000000,       SwingTime = 0.5,  DamageMultiplier = 30.0,  Rarity = "Epic",      DisplayName = "Toxic Axe",   ImageId = "95861076137574"  },
	VoidAxe    = { Order = 5, Price = 100000000,     SwingTime = 0.45, DamageMultiplier = 100.0, Rarity = "Legendary", DisplayName = "Void Axe",    ImageId = "98812073951602"  },
	MagmaAxe   = { Order = 6, Price = 1500000000,    SwingTime = 0.4,  DamageMultiplier = 300.0, Rarity = "Mythic",    DisplayName = "Magma Axe",   ImageId = "113047608030628" },
	RainbowAxe = { Order = 7, Price = 25000000000,   SwingTime = 0.3,  DamageMultiplier = 800.0, Rarity = "Mythic",    DisplayName = "Rainbow Axe", ImageId = "130283144820220" },
}

-- =====================================================================
-- Drills (drill shop)
-- =====================================================================
-- One entry per model in workspace.Drills; the key IS the model name so
-- the shop viewport / DrillSystemServer template lookup needs no mapping.
-- Price ladder: user-anchored 50 / 100 / 300 then ~x3 per tier so the
-- catalog spans the whole cash curve (late zones drop trillions).
-- Power = flat damage-per-second added on top of the player's Strength
-- while drilling (DrillSystemServer reads the DrillPower attribute).
-- ProductId = developer product for the Robux price; 0 disables the
-- Robux button until the real product ids are created.
GameConfig.DefaultDrill = "Drill1 - Wood"

local DRILL_LADDER = {
	-- name,                     price,               robux, power,          rarity
	{ "Drill1 - Wood",           0,                   0,     0,              "Common"    },
	{ "Drill2 - Blue",           50,                  5,     5,              "Common"    },
	{ "Drill3 - Twin Red",       100,                 9,     12,             "Common"    },
	{ "Drill4 - Green",          300,                 15,    30,             "Common"    },
	{ "Drill5 - Royal Purple",   1_000,               19,    75,             "Uncommon"  },
	{ "Drill6 - Industrial",     3_000,               29,    180,            "Uncommon"  },
	{ "Drill7 - Gold",           10_000,              39,    450,            "Uncommon"  },
	{ "Drill8 - Cyber Twin",     30_000,              49,    1_100,          "Uncommon"  },
	{ "Drill9 - Magma",          100_000,             69,    2_750,          "Rare"      },
	{ "Drill10 - Diamond",       300_000,             99,    6_500,          "Rare"      },
	{ "Drill11 - Toxic",         1_000_000,           129,   16_000,         "Rare"      },
	{ "Drill12 - Candy",         3_000_000,           149,   40_000,         "Rare"      },
	{ "Drill13 - Yin Yang",      10_000_000,          179,   100_000,        "Epic"      },
	{ "Drill14 - Demon",         30_000_000,          199,   240_000,        "Epic"      },
	{ "Drill15 - Angel",         100_000_000,         229,   600_000,        "Epic"      },
	{ "Drill16 - Triple",        300_000_000,         259,   1_500_000,      "Epic"      },
	{ "Drill17 - Racing Quad",   1_000_000_000,       299,   3_500_000,      "Legendary" },
	{ "Drill18 - Black Gold",    3_000_000_000,       329,   8_500_000,      "Legendary" },
	{ "Drill19 - Hacked",        10_000_000_000,      359,   20_000_000,     "Legendary" },
	{ "Drill20 - Cloud",         30_000_000_000,      399,   50_000_000,     "Legendary" },
	{ "Drill21 - Strawberry",    100_000_000_000,     449,   120_000_000,    "Mythic"    },
	{ "Drill22 - Jackhammer",    300_000_000_000,     499,   300_000_000,    "Mythic"    },
	{ "Drill23 - Auger",         1_000_000_000_000,   549,   700_000_000,    "Mythic"    },
	{ "Drill24 - Mech",          3_000_000_000_000,   599,   1_750_000_000,  "Godly"     },
	{ "Drill25 - Crystal",       10_000_000_000_000,  649,   4_000_000_000,  "Godly"     },
	{ "Drill26 - Rocket",        30_000_000_000_000,  679,   10_000_000_000, "Godly"     },
	{ "Drill27 - Royal Crown",   100_000_000_000_000, 699,   25_000_000_000, "Divine"    },
	-- the ONE catalog item allowed above 1000 Robux (user pricing rule)
	{ "Drill28 - Plasma Core",   300_000_000_000_000, 1199,  60_000_000_000, "Divine"    },
}

-- Robux-EXCLUSIVE drills (user request): no cash price ever -- the cash
-- button hides and DrillShopService refuses cash buys, mirroring the
-- Gold Trail. Spread across the ladder as impulse-buy exclusives.
-- Robux-exclusive drills disabled (user request): every drill is now
-- cash-purchasable, so each card shows its CashButton alongside the Robux
-- button and DrillShopService accepts cash buys for all of them.
local ROBUX_ONLY_DRILLS = {}

-- Live developer products (universe 10411982053, created 2026-07-16 via the
-- Creator Dashboard v2 API; charged price verified == RobuxPrice).
local DRILL_PRODUCT_IDS = {
	["Drill2 - Blue"] = 3633108382,
	["Drill3 - Twin Red"] = 3633110817,
	["Drill4 - Green"] = 3633112789,
	["Drill5 - Royal Purple"] = 3633117791,
	["Drill6 - Industrial"] = 3633120662,
	["Drill7 - Gold"] = 3633123908,
	["Drill8 - Cyber Twin"] = 3633125557,
	["Drill9 - Magma"] = 3633127636,
	["Drill10 - Diamond"] = 3633131930,
	["Drill11 - Toxic"] = 3633133688,
	["Drill12 - Candy"] = 3633135763,
	["Drill13 - Yin Yang"] = 3633137671,
	["Drill14 - Demon"] = 3633152248,
	["Drill15 - Angel"] = 3633153949,
	["Drill16 - Triple"] = 3633155592,
	["Drill17 - Racing Quad"] = 3633175255,
	["Drill18 - Black Gold"] = 3633176766,
	["Drill19 - Hacked"] = 3633178713,
	["Drill20 - Cloud"] = 3633179857,
	["Drill21 - Strawberry"] = 3633181511,
	["Drill22 - Jackhammer"] = 3633183426,
	["Drill23 - Auger"] = 3633200032,
	["Drill24 - Mech"] = 3633204131,
	["Drill25 - Crystal"] = 3633214253,
	["Drill26 - Rocket"] = 3633220377,
	["Drill27 - Royal Crown"] = 3633216128,
	["Drill28 - Plasma Core"] = 3633217870,
}

-- Flat card art (uploaded 2026-07-22): replaces every drill ViewportFrame
-- (shop cards + hotbar slot -- user request "no more viewports for drills").
-- Consumers keep a viewport fallback for any drill without an ImageId.
local DRILL_IMAGE_IDS = {
	["Drill1 - Wood"] = "rbxassetid://111660196950781",
	["Drill2 - Blue"] = "rbxassetid://89104505668105",
	["Drill3 - Twin Red"] = "rbxassetid://129285232631413",
	["Drill4 - Green"] = "rbxassetid://131574800376278",
	["Drill5 - Royal Purple"] = "rbxassetid://91347821202104",
	["Drill6 - Industrial"] = "rbxassetid://71919945905198",
	["Drill7 - Gold"] = "rbxassetid://76997739156808",
	["Drill8 - Cyber Twin"] = "rbxassetid://125223736062260",
	["Drill9 - Magma"] = "rbxassetid://109032385157969",
	["Drill10 - Diamond"] = "rbxassetid://136532434169709",
	["Drill11 - Toxic"] = "rbxassetid://76074915192138",
	["Drill12 - Candy"] = "rbxassetid://71083109879346",
	["Drill13 - Yin Yang"] = "rbxassetid://77206987038874",
	["Drill14 - Demon"] = "rbxassetid://130457418212146",
	["Drill15 - Angel"] = "rbxassetid://134915031669589",
	["Drill16 - Triple"] = "rbxassetid://75866586112518",
	["Drill17 - Racing Quad"] = "rbxassetid://133068116585969",
	["Drill18 - Black Gold"] = "rbxassetid://139079483556135",
	["Drill19 - Hacked"] = "rbxassetid://111373376393556",
	["Drill20 - Cloud"] = "rbxassetid://108893325643182",
	["Drill21 - Strawberry"] = "rbxassetid://77618622214225",
	["Drill22 - Jackhammer"] = "rbxassetid://109911174509546",
	["Drill23 - Auger"] = "rbxassetid://132983318425739",
	["Drill24 - Mech"] = "rbxassetid://72254551420680",
	["Drill25 - Crystal"] = "rbxassetid://76892653688100",
	["Drill26 - Rocket"] = "rbxassetid://126878007544229",
	["Drill27 - Royal Crown"] = "rbxassetid://84484860796277",
	["Drill28 - Plasma Core"] = "rbxassetid://116968837934559",
}

GameConfig.Drills = {}
for order, row in ipairs(DRILL_LADDER) do
	local name = row[1]
	GameConfig.Drills[name] = {
		Order = order,
		DisplayName = name:match(" %- (.+)$") or name,
		Price = row[2],
		RobuxPrice = row[3],
		ProductId = DRILL_PRODUCT_IDS[name] or 0,
		Power = row[4],
		Rarity = row[5],
		RobuxOnly = ROBUX_ONLY_DRILLS[name] or nil,
		ImageId = DRILL_IMAGE_IDS[name],
	}
end

-- =====================================================================
-- Trails (trail shop)
-- =====================================================================
-- Cosmetic walking trail + a Strength-gain multiplier (clicks AND
-- training-pad payouts are multiplied by the EQUIPPED trail's Boost;
-- Robux strength packs are NOT). TrailShopService owns the state
-- (OwnedTrails / EquippedTrail in the profile, mirrored to the
-- EquippedTrail / TrailBoost player attributes).
-- Boost ladder mirrors the reference aura shop (1.2x .. 3.5x) with two
-- original endgame tiers (Void 4x, Rainbow 5x) on top.
-- Colors = gradient keypoints along the trail (first = freshest edge).
-- ProductId = developer product for the Robux price; 0 disables the
-- Robux button until the real product ids are created.

-- Price ladder user-anchored 2026-07-16: 100K entry so the first trail is
-- an early buy, then 1M / 10M / 20M / 50M and on up.
local TRAIL_LADDER = {
	-- name,             price,             robux, boost, colors (front -> back)
	{ "Red Trail",       100_000,           60,    1.2, { Color3.fromRGB(255, 170, 140), Color3.fromRGB(255, 70, 50), Color3.fromRGB(180, 0, 20) } },
	{ "Green Trail",     1_000_000,         90,    1.4, { Color3.fromRGB(190, 255, 140), Color3.fromRGB(80, 230, 80), Color3.fromRGB(10, 150, 40) } },
	{ "Purple Trail",    10_000_000,        120,   1.6, { Color3.fromRGB(230, 170, 255), Color3.fromRGB(170, 85, 255), Color3.fromRGB(96, 10, 200) } },
	{ "Orange Trail",    20_000_000,        240,   1.8, { Color3.fromRGB(255, 236, 130), Color3.fromRGB(255, 170, 40), Color3.fromRGB(255, 84, 0) } },
	{ "Blue Trail",      50_000_000,        349,   2.5, { Color3.fromRGB(170, 235, 255), Color3.fromRGB(60, 170, 255), Color3.fromRGB(0, 70, 230) } },
	{ "Pink Trail",      100_000_000,       399,   3,   { Color3.fromRGB(255, 205, 245), Color3.fromRGB(255, 110, 220), Color3.fromRGB(230, 30, 160) } },
	{ "White Trail",     250_000_000,       499,   3.5, { Color3.fromRGB(255, 255, 255), Color3.fromRGB(235, 240, 255), Color3.fromRGB(185, 200, 230) } },
	{ "Void Trail",      1_000_000_000,     599,   4,   { Color3.fromRGB(150, 60, 255), Color3.fromRGB(60, 0, 110), Color3.fromRGB(10, 0, 20) } },
	-- Robux-exclusive (RobuxOnly below): no cash price, ever
	{ "Gold Trail",      0,                 699,   4.5, { Color3.fromRGB(255, 245, 180), Color3.fromRGB(255, 200, 40), Color3.fromRGB(200, 130, 0) } },
	{ "Rainbow Trail",   10_000_000_000,    699,   5,   { Color3.fromRGB(255, 60, 60), Color3.fromRGB(255, 200, 40), Color3.fromRGB(70, 255, 90), Color3.fromRGB(60, 170, 255), Color3.fromRGB(190, 90, 255), Color3.fromRGB(255, 60, 200) } },
}

-- Live developer products (universe 10411982053, created 2026-07-16;
-- charged price verified == RobuxPrice).
local TRAIL_PRODUCT_IDS = {
	["Red Trail"] = 3632643350,
	["Green Trail"] = 3632645253,
	["Purple Trail"] = 3632646880,
	["Orange Trail"] = 3632651796,
	["Blue Trail"] = 3632653823,
	["Pink Trail"] = 3632658482,
	["White Trail"] = 3632659835,
	["Void Trail"] = 3632663494,
	["Gold Trail"] = 3632666691,
	["Rainbow Trail"] = 3632668971,
}

GameConfig.Trails = {}
for order, row in ipairs(TRAIL_LADDER) do
	local name = row[1]
	GameConfig.Trails[name] = {
		Order = order,
		DisplayName = name,
		Price = row[2],
		RobuxPrice = row[3],
		ProductId = TRAIL_PRODUCT_IDS[name] or 0,
		Boost = row[4],
		Colors = row[5],
		-- Robux-exclusive: no cash button, server refuses cash buys
		RobuxOnly = (name == "Gold Trail") or nil,
		-- Rainbow gets the client-side hue-cycling FX (RainbowTrailClient)
		Rainbow = (name == "Rainbow Trail") or nil,
		-- Void reads better dark: less emissive, longer smoky tail
		LightEmission = (name == "Void Trail") and 0.45 or nil,
		Lifetime = (name == "Void Trail" or name == "Rainbow Trail") and 0.8 or nil,
	}
end

-- =====================================================================
-- Economy: Shop / Packs / Side Offers
-- =====================================================================

-- Shop config covers everything sold under PlayerGui.GUI.Folder.Shop.
-- LuckyBlock = the exclusive lucky-block tiers (Buy1/Buy3/Buy10).
-- Cash = three Robux-for-cash tiers (Small/Medium/Big) that grant cash
--   proportional to the player's effective income.
-- Passes = gamepasses (x2Cash, AutoCollect, Vip, x5Offline).
GameConfig.Shop = {
	LuckyBlock = {
		ModelName   = "LuckyBlock",
		DisplayName = "Exclusive Lucky Block",
		-- ModelName is looked up in ReplicatedStorage.LuckyBlocks first, then as a
		-- direct child of ReplicatedStorage — so a single MeshPart at
		-- ReplicatedStorage.LuckyBlock works.
		--
		-- ProductId 3587169934 is a placeholder shared by all three tiers; replace
		-- with per-tier devproduct ids before release.
		Tiers = {
			Buy1  = { ProductId = 3632565656, PriceRobux = 49,  Amount = 1  },
			Buy3  = { ProductId = 3632567509, PriceRobux = 129, Amount = 3  },
			Buy10 = { ProductId = 3632569944, PriceRobux = 399, Amount = 10 },
		},
		-- Chance values are relative weights — they do NOT need to sum to 100.
		-- IMPORTANT: these BrainrotIds must exist in GameConfig.Items (i.e. the
		-- ReplicatedStorage.Brainrots pack). The previous list used names from
		-- the old pack which no longer match anything, causing the unbox roll
		-- to pick invalid ids and the reveal animation to render no models.
		PossibleBrainrots = (function()
			local weights = { 50, 25, 15, 9, 1 }
			local ids = GameConfig.BrainrotsByRarity.Exclusive or {}
			local list = {}
			for i, brId in ipairs(ids) do
				list[#list + 1] = { BrainrotId = brId, Chance = weights[i] or 1 }
			end
			return list
		end)(),
	},
}

-- Cash packs wired to Shop.Cash.<UIName>. Amount granted = effective
-- cash-per-sec (income * rebirth * boost) * SecondsAhead. FallbackAmount
-- is granted if the player has no income yet.
GameConfig.Shop.Cash = {
	Small  = { UIName = "Small",  ProductId = 3632571777, PriceRobux = 49,  SecondsAhead = 3600,  FallbackAmount = 5000   },
	Medium = { UIName = "Medium", ProductId = 3632573598, PriceRobux = 99,  SecondsAhead = 10800, FallbackAmount = 25000  },
	Big    = { UIName = "Big",    ProductId = 3632575515, PriceRobux = 199, SecondsAhead = 21600, FallbackAmount = 100000 },
}

-- Store "- Lucky Blocks -" tier cards. Each card sells a DEV PRODUCT
-- (user request 2026-07-16, was gamepasses -- those 3 passes are now
-- off-sale on the dashboard): every purchase grants ONE GrantBlockId
-- lucky block into the inventory, REPEATABLE (buy as many as you want;
-- receipt context "LootBlock_<key>" -> LootBlockService.GrantStoreBlock).
-- ProductId = 0 falls back to the free-grant test path.
-- The granted block is opened IN-HAND by clicking while holding it and
-- pays out from GameConfig.LuckyBlocks[GrantBlockId].Loot.
-- DisplayBlockId (optional) = model shown in the card viewport when it
-- should differ from the granted block's model.
GameConfig.Shop.LuckyBlockStore = {
	Legendary = { Order = 1, ProductId = 3632580351, PriceRobux = 99,  BlockId = "LavaLuckyBlock",   DisplayBlockId = "YellowLuckyBlock", Title = "LEGENDARY", GrantBlockId = "LegendaryLootBlock" },
	Godly     = { Order = 2, ProductId = 3632583004, PriceRobux = 199, BlockId = "DragonLuckyBlock", Title = "GODLY",  GrantBlockId = "GodlyLootBlock" },
	Secret    = { Order = 3, ProductId = 3632584443, PriceRobux = 399, BlockId = "VoidLuckyBlock",   Title = "SECRET", GrantBlockId = "SecretLootBlock" },
}

-- Gamepasses. GamepassId 0 short-circuits the prompt until set.
-- BoostPercent (x2Cash / Vip) registers with CashBoostService.
-- AutoCollect makes brainrot cash credit instantly per server tick.
-- OfflineMultiplier (x5Offline) multiplies offline accumulated cash on next login.
-- Live gamepasses (universe 10411982053, created 2026-07-16; charged
-- price verified == PriceRobux).
-- x2Strength is RETIRED (taken off-sale 2026-07-23): the HUD X2DrillPanel
-- now sells the GameConfig.StrengthLadder dev products instead. The entry
-- stays so GamepassService keeps mirroring OwnsGamepass_x2Strength --
-- legacy pass owners are floored at ladder tier 1 (x2 strength) by
-- StrengthLadderServer. No BoostPercent: it must never register as a
-- cash boost.
GameConfig.Shop.Passes = {
	x2Cash      = { UIName = "x2Cash",      GamepassId = 1940490284, PriceRobux = 49, BoostPercent = 100 },
	AutoCollect = { UIName = "AutoCollect", GamepassId = 1940826294, PriceRobux = 49 },
	Vip         = { UIName = "Vip",         GamepassId = 1941150282, PriceRobux = 49, BoostPercent = 25, ChatTag = "[VIP]", ChatTagColor = "#C266FF" },
	x5Offline   = { UIName = "x5Offline",   GamepassId = 1940532270, PriceRobux = 49, OfflineMultiplier = 5 },
	x2Strength  = { UIName = "x2Strength",  GamepassId = 1940388282, PriceRobux = 3 },
	-- Training ore pads (Spawn.LdbsArea pads 7 / 8 / 1000): permanent pad
	-- access, converted from dev products 2026-07-16 (old products off-sale;
	-- legacy buyers keep access via the TrainingPadX<mult>Owned profile flag).
	-- Keys MUST match DrillSystemServer's pad key ("TrainingPadX<mult>") --
	-- the mirrored OwnsGamepass_<key> attribute IS the pad ownership check.
	-- No Passes card in the Shop UI; the pads themselves are the storefront.
	TrainingPadX15  = { GamepassId = 1943424256, PriceRobux = 99 },  -- Azurite Ore
	TrainingPadX25  = { GamepassId = 1940718277, PriceRobux = 249 }, -- Amethyst Ore
	TrainingPadX100 = { GamepassId = 1941264285, PriceRobux = 599 }, -- Rhodonite Ore
}

-- Strength multiplier ladder (2026-07-23): replaces the retired x2
-- Strength gamepass with an escalating chain of DEV PRODUCTS -- buying
-- tier N grants a permanent x2^N multiplier on every strength gain
-- (clicks, training pads, offline strength), so the chain runs
-- x2 -> x4 -> x8 -> ... -> x1024. The HUD X2DrillPanel always sells the
-- NEXT tier ("x4 Strength / ONLY 9") and hides at the top tier.
-- StrengthLadderServer owns prompting + granting; the owned tier
-- persists as the StrengthMultLevel profile field. All charged prices
-- verified exact via the v2 dashboard list 2026-07-23.
GameConfig.StrengthLadder = {
	{ Mult = 2,    Price = 3,   ProductId = 3632778441 },
	{ Mult = 4,    Price = 9,   ProductId = 3632780736 },
	{ Mult = 8,    Price = 19,  ProductId = 3632782069 },
	{ Mult = 16,   Price = 39,  ProductId = 3632783671 },
	{ Mult = 32,   Price = 69,  ProductId = 3632784969 },
	{ Mult = 64,   Price = 99,  ProductId = 3632786189 },
	{ Mult = 128,  Price = 149, ProductId = 3632788044 },
	{ Mult = 256,  Price = 249, ProductId = 3632789812 },
	{ Mult = 512,  Price = 399, ProductId = 3632791767 },
	{ Mult = 1024, Price = 699, ProductId = 3632793451 },
}

-- ============================================================================
--  WORLD LUCKY BLOCKS  —  PER-MODEL CONFIG  (edit the Luck values here)
-- ============================================================================
-- Every lucky-block MODEL (ReplicatedStorage.LuckyBlocks.<Model>) is its own
-- collectible. Each rarity island spawns a random model from its rarity list
-- below; the island overhead shows the model's DisplayName, its Rarity, and
-- its Luck rendered as "xN.NN Luck".
--
--   Luck = luck multiplier. LuckyBlockService.rollBrainrot uses it for a
--   per-roll chance to "tier up" one rarity and roll from that higher tier's
--   loot table instead. Luck = 1.00 -> never tiers up (original even odds are
--   preserved exactly); higher Luck -> escalating chance at a better brainrot.
--
--   >>>  To retune a block, just change its Luck number below.  <<<
-- Luck values pulled in across the board. Combined with the tier-climb
-- cap (LuckyBlockService.MAX_TIER_CLIMB) this means a Common block can
-- at most yield Rare-tier brainrots and never Mythic/Exclusive -- so
-- players actually have to progress through islands to access better
-- loot, instead of farming Common for a lucky Exclusive roll.
GameConfig.LuckyBlockModels = {
	Common = {
		{ Model = "YellowLuckyBlock",       Luck = 1.00 },
		{ Model = "BlueLuckyBlock",         Luck = 1.10 },
		{ Model = "PinkLuckyBlock",         Luck = 1.20 },
	},
	Uncommon = {
		{ Model = "RedLuckyBlock",          Luck = 1.30 },
		{ Model = "GreenLuckyBlock",        Luck = 1.40 },
		{ Model = "YellowShieldLuckyBlock", Luck = 1.50 },
	},
	Rare = {
		{ Model = "SpikedLuckyBlock",       Luck = 1.65 },
		{ Model = "RedAngelLuckyBlock",     Luck = 1.80 },
		{ Model = "PurpleAngelLuckyBlock",  Luck = 1.95 },
	},
	Epic = {
		{ Model = "BulkyLuckyBlock",        Luck = 2.10 },
		{ Model = "GreenBulkyLuckyBlock",   Luck = 2.30 },
		{ Model = "BulkyHeavenLuckyBlock",  Luck = 2.50 },
	},
	Legendary = {
		{ Model = "LavaLuckyBlock",         Luck = 2.65 },
		{ Model = "SlimeLuckyBlock",        Luck = 2.90 },
		{ Model = "AutumnLuckyBlock",       Luck = 3.15 },
	},
	Mythic = {
		{ Model = "KingLuckyBlock",         Luck = 3.30 },
		{ Model = "PlanetLuckyBlock",       Luck = 3.60 },
		{ Model = "DragonLuckyBlock",       Luck = 3.90 },
	},
	-- Keyed by the island Rarity field (Islands.SecretIsland.Rarity =
	-- "Exclusive"). Previously this was "Secret" -- the mismatch was why
	-- IslandLuckyBlockSpawner warned "no LuckyBlockSpawn config for island
	-- 'SecretIsland', skipping" and the secret area never spawned any blocks.
	Exclusive = {
		{ Model = "ChainedLuckyBlock",      Luck = 4.50 },
		{ Model = "VoidLuckyBlock",         Luck = 5.50 },
	},
}

-- Brainrot loot per rarity, derived from the auto-imported pack so the loot
-- tables can never drift out of sync with the actual model names in
-- ReplicatedStorage.Brainrots. Previously this used hardcoded names with
-- spaces ("Rhino Toasterino") that no longer matched the pack ids
-- ("RhinoToasterino"), which left Uncommon + Exclusive lucky blocks with an
-- empty loot pool -- rollBrainrot returned nil, OpenPlacedBlock returned
-- false, and the pad was cleared with no unbox animation.
local LuckyBlockLootIds = {
	Common    = GameConfig.BrainrotsByRarity.Common    or {},
	Uncommon  = GameConfig.BrainrotsByRarity.Uncommon  or {},
	Rare      = GameConfig.BrainrotsByRarity.Rare      or {},
	Epic      = GameConfig.BrainrotsByRarity.Epic      or {},
	Legendary = GameConfig.BrainrotsByRarity.Legendary or {},
	Mythic    = GameConfig.BrainrotsByRarity.Mythic    or {},
	-- Keyed by rarity name to match Islands.<Name>.Rarity (renamed Secret
	-- -> Exclusive so SecretIsland's lookup finds its loot pool).
	Exclusive = GameConfig.BrainrotsByRarity.Exclusive or {},
}

-- rarity -> { {BrainrotId, Chance}, ... }. Used both as each block's own loot
-- table and as the upgrade target when a lucky roll tiers up.
GameConfig.LuckyBlockLootByRarity = {}
for rarity, ids in pairs(LuckyBlockLootIds) do
	local possible = {}
	for _, brId in ipairs(ids) do
		if GameConfig.Items[brId] then
			possible[#possible + 1] = { BrainrotId = brId, Chance = 1 }
		end
	end
	GameConfig.LuckyBlockLootByRarity[rarity] = possible
end

-- Rarity climb order for the luck tier-up roll.
GameConfig.LuckyBlockRarityOrder = {
	"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Exclusive",
}

-- Open timer removed at user request — placed lucky blocks are immediately
-- openable. Helper kept (returns 0) so PodiumService doesn't need a special-case.
function GameConfig.GetLuckyBlockOpenTime(_luckyBlockId)
	-- No timer: placed lucky blocks are openable immediately. Kept as a
	-- function so callers (PodiumService.onPlaceBrainrot) keep working without
	-- changes if a per-rarity delay is ever reintroduced.
	return 0
end

-- "PinkLuckyBlock" -> "Pink Lucky Block"
local function prettyLuckyName(modelName)
	return (modelName:gsub("(%l)(%u)", "%1 %2"))
end

-- LuckyBlockService.rollBrainrot reads from GameConfig.LuckyBlocks[id]; alias
-- the Exclusive entry to the Shop config so brainrots live in one place.
GameConfig.LuckyBlocks = {
	Exclusive = GameConfig.Shop.LuckyBlock,
}

-- Generic id kept working: DailyRewardService grants "LuckyBlock".
GameConfig.LuckyBlocks.LuckyBlock = {
	ModelName         = "PinkLuckyBlock",
	DisplayName       = "Lucky Block",
	Rarity            = "Common",
	Luck              = 1.00,
	PossibleBrainrots = GameConfig.LuckyBlockLootByRarity.Common,
}

-- One GameConfig.LuckyBlocks entry per model + one LuckyBlockSpawn entry per
-- island, both derived from the editable tables above.
--   GameConfig.LuckyBlocks[<Model>]          = { ModelName, DisplayName, Rarity, Luck, PossibleBrainrots }
--   GameConfig.LuckyBlockSpawn[<IslandName>] = { Rarity, DisplayName, Models = {<Model>, ...} }
GameConfig.LuckyBlockSpawn = {}
for islandName, islandCfg in pairs(GameConfig.Islands) do
	local rarity = islandCfg.Rarity or "Common"
	local models = GameConfig.LuckyBlockModels[rarity]
	if models then
		local loot = GameConfig.LuckyBlockLootByRarity[rarity] or {}
		local modelNames = {}
		for _, def in ipairs(models) do
			modelNames[#modelNames + 1] = def.Model
			GameConfig.LuckyBlocks[def.Model] = {
				ModelName         = def.Model,
				DisplayName       = prettyLuckyName(def.Model),
				Rarity            = rarity,
				Luck              = def.Luck or 1.0,
				PossibleBrainrots = loot,
			}
		end
		GameConfig.LuckyBlockSpawn[islandName] = {
			Rarity      = rarity,
			DisplayName = rarity .. " Lucky Block",
			Models      = modelNames,
		}
	end
end

-- =====================================================================
-- Store loot blocks (in-hand click-to-open) + their loot items
-- =====================================================================
-- The three "- Lucky Blocks -" store cards grant these blocks (one per
-- gamepass). Unlike the island/pad blocks they do NOT roll brainrots:
-- clicking while holding one plays the in-hand open animation and pays a
-- one-time cash reward + the physical loot item (models live under
-- ReplicatedStorage.LuckyBlockLoot.<LootFolder>.<ModelName>).
--
-- Chance values are relative weights (kept summing to 100 so they read as
-- percentages). Loot list order = the order shown on the store card, with
-- the rarest (single-digit %) entry LAST.
-- Cash scale mirrors the drill ladder (mid drills cost 10M-1B, endgame
-- 300T): Legendary pays hundreds of thousands to low millions, Godly tens
-- to hundreds of millions, Secret hundreds of millions with the 1T jackpot
-- on The Void.
GameConfig.LuckyBlockLootItems = {
	-- Legendary block loot
	Crystal          = { LootFolder = "Legendary", DisplayName = "Crystal",           Rarity = "Rare",      CashReward = 250_000 },
	PinkOrb          = { LootFolder = "Legendary", DisplayName = "Pink Orb",          Rarity = "Epic",      CashReward = 750_000 },
	VictoriousHelmet = { LootFolder = "Legendary", DisplayName = "Victorious Helmet", Rarity = "Legendary", CashReward = 2_500_000 },
	NebulaOrb        = { LootFolder = "Legendary", DisplayName = "Nebula Orb",        Rarity = "Mythic",    CashReward = 10_000_000 },
	-- Godly block loot
	CopperOre  = { LootFolder = "Godly", DisplayName = "Copper Ore",  Rarity = "Epic",      CashReward = 5_000_000 },
	IronOre    = { LootFolder = "Godly", DisplayName = "Iron Ore",    Rarity = "Legendary", CashReward = 15_000_000 },
	GoldOre    = { LootFolder = "Godly", DisplayName = "Gold Ore",    Rarity = "Mythic",    CashReward = 50_000_000 },
	DiamondOre = { LootFolder = "Godly", DisplayName = "Diamond Ore", Rarity = "Godly",     CashReward = 250_000_000 },
	-- Secret block loot
	BlackHole      = { LootFolder = "Secret", DisplayName = "Black Hole",      Rarity = "Godly",  CashReward = 100_000_000 },
	ElectrifiedOrb = { LootFolder = "Secret", DisplayName = "Electrified Orb", Rarity = "Secret", CashReward = 500_000_000 },
	TheVoid        = { LootFolder = "Secret", DisplayName = "The Void",        Rarity = "Divine", CashReward = 1_000_000_000_000 },
}

-- Loot items are registered in GameConfig.LuckyBlocks so the ENTIRE existing
-- inventory pipeline (playerData.Inventory map, hotbar viewport slots, equip/
-- hold visuals, profile-load migration sweep) accepts them with no special
-- casing. IsLootItem = true keeps them out of the pad-placement / brainrot
-- open flows.
for lootId, def in pairs(GameConfig.LuckyBlockLootItems) do
	GameConfig.LuckyBlocks[lootId] = {
		ModelName   = lootId,
		DisplayName = def.DisplayName,
		Rarity      = def.Rarity,
		IsLootItem  = true,
		LootFolder  = def.LootFolder,
		CashReward  = def.CashReward,
	}
end

-- The three grantable store blocks. IsLootBlock = true routes them to the
-- in-hand click-to-open flow (LootBlockService/LootBlockController) instead
-- of the pad/brainrot flows.
GameConfig.LuckyBlocks.LegendaryLootBlock = {
	ModelName   = "YellowLuckyBlock",
	DisplayName = "Legendary Lucky Block",
	Rarity      = "Legendary",
	IsLootBlock = true,
	Loot = {
		{ LootId = "Crystal",          Chance = 44 },
		{ LootId = "PinkOrb",          Chance = 33 },
		{ LootId = "VictoriousHelmet", Chance = 20 },
		{ LootId = "NebulaOrb",        Chance = 3  },
	},
}
GameConfig.LuckyBlocks.GodlyLootBlock = {
	ModelName   = "DragonLuckyBlock",
	DisplayName = "Godly Lucky Block",
	Rarity      = "Godly",
	IsLootBlock = true,
	Loot = {
		{ LootId = "CopperOre",  Chance = 44 },
		{ LootId = "IronOre",    Chance = 33 },
		{ LootId = "GoldOre",    Chance = 20 },
		{ LootId = "DiamondOre", Chance = 3  },
	},
}
GameConfig.LuckyBlocks.SecretLootBlock = {
	ModelName   = "VoidLuckyBlock",
	DisplayName = "Secret Lucky Block",
	Rarity      = "Secret",
	IsLootBlock = true,
	Loot = {
		{ LootId = "BlackHole",      Chance = 57 },
		{ LootId = "ElectrifiedOrb", Chance = 40 },
		{ LootId = "TheVoid",        Chance = 3  },
	},
}

-- One-time Robux packs. PurchaseService routes "Pack_<name>" contexts to
-- StoreService.ProcessPackPurchase. Rewards is a list — add entries with:
--   { Type = "Cash",     Amount = N }
--   { Type = "Brainrot", BrainrotId = "<id>", Amount = N (optional, default 1) }
-- BrainrotId must exist in GameConfig.Items.
GameConfig.Packs = {
	StarterPack = {
		ProductId  = 3595408851,
		PriceRobux = 9,
		Rewards = {
			{ Type = "Cash",     Amount = 50000 },
			{ Type = "Brainrot", BrainrotId = "Trulimero Trulicina" },
			{ Type = "Brainrot", BrainrotId = "Bombombini Gusini"   },
		},
	},
}

-- Strength shop (PlayerGui.GUI.Folder.StrengthShop). One dev product per
-- offer; Amount is added straight to the Strength attribute (and XP) through
-- StrengthClickServer's GrantStrength bindable when the purchase lands.
-- ProductId = 0 disables the buy button until the real products are created.
GameConfig.StrengthShop = {
	T1   = { Order = 1, ProductId = 3632808639, PriceRobux = 640, Amount = 1e12, Label = "+ 1.00T STRENGTH", Big = true },
	B100 = { Order = 2, ProductId = 3632812812, PriceRobux = 240, Amount = 1e11, Label = "+100B" },
	B10  = { Order = 3, ProductId = 3632816033, PriceRobux = 80,  Amount = 1e10, Label = "+10.0B" },
	B1   = { Order = 4, ProductId = 3632819836, PriceRobux = 16,  Amount = 1e9,  Label = "+1.00B" },
}

-- Side-offer HUD chips on PlayerGui.GUI.HUD.RightSide.
-- RandomBrainrot: rolls one item from GameConfig.Items; mutation rolls
--   separately using the same Gold/Diamond SpawnChance values.
-- MaterialProduct: grants Amount BridgeMaterial via AddMaterialOverfill
--   (bypasses MaxStorage cap until the player chops it down).
GameConfig.RandomBrainrotProduct = {
	ProductId = 3595408852,
}

GameConfig.MaterialProduct = {
	ProductId = 3595408857,
	Amount    = 25,
}

-- =====================================================================
-- Boosts & Engagement: FriendBoost / RobloxPlus / DailyRewards
-- =====================================================================

-- Any friend in the server grants the full BoostPercent (binary toggle);
-- registered into CashBoostService so it stacks with every other boost.
GameConfig.FriendBoost = {
	BoostPercent = 5,
}

-- Official group / community. Used by anything that needs to check group
-- membership (boosts, join-group HUD buttons, the FreeGiftFrame claim, etc.).
-- Community URL:
--   https://www.roblox.com/communities/923513734/+1 Drilling Game
GameConfig.Group = {
	GroupId = 923513734,
	Name = "+1 Drilling Game",
	Url = "https://www.roblox.com/communities/923513734/1-Drilling-Game",
}

-- Free reward popup (GUI.Folder.FreeGiftFrame): like the game + join the
-- group. Only group membership is verifiable in-game (GameConfig.Group.GroupId);
-- FreeGiftService grants the cash once per player.
GameConfig.FreeGift = {
	CashAmount = 10_000,
}

-- Offline strength for the Earnings popup (GUI.Folder.OfflineReward).
-- While offline the player is treated as clicking ClicksPerSecond times per
-- second at their live per-click value ((1 + drill Power) * trail boost *
-- rebirth multiplier * x2 pass); the x5Offline gamepass multiplies it like
-- it does offline cash. Claimed together with offline cash by the popup.
-- 0.002 clicks/s = ~1/5000th of nonstop active clicking (~10/s), per user
-- spec (offline must pay in the 1/1000..1/10000 band of active farming).
GameConfig.OfflineStrength = {
	ClicksPerSecond = 0.002,
	MaxOfflineSeconds = 12 * 60 * 60,
	MinOfflineSeconds = 10, -- below this the popup simply doesn't appear
}

-- Offline cash for the Earnings popup. The podium offline income is dead in
-- this map (Workspace.Assets.Plots is empty), so offline cash is instead
-- based on the player's OWN measured earning pace: PodiumService saves
-- TotalCash-earned-per-second over each session (>= MinSessionSeconds) to
-- the profile's OfflineCashRate, and the next join pays
-- rate * offlineSeconds * RateFraction (x5Offline gamepass multiplies it).
-- RateFraction 1/5000 mirrors the strength tuning above.
GameConfig.OfflineCash = {
	RateFraction = 1 / 5000,
	MaxOfflineSeconds = 12 * 60 * 60,
	MinSessionSeconds = 120,
	MinOfflineSeconds = 10, -- below this the popup simply doesn't appear
}

-- "Roblox Plus" in this template means Roblox Premium membership.
-- Server detects via Player.MembershipType == Enum.MembershipType.Premium.
GameConfig.RobloxPlus = {
	BoostPercent = 10,
}

-- Skip-stage pads: one dev product per zone (live, charged prices
-- verified). SkipStageService stamps the ProductId + SkipPrice attributes
-- onto each zone's SkipStagePad and teleports the buyer to the next zone.
GameConfig.SkipZones = {
	[1] = { ProductId = 3632994021, Price = 9 },
	[2] = { ProductId = 3632994912, Price = 19 },
	[3] = { ProductId = 3632996364, Price = 29 },
	[4] = { ProductId = 3632997682, Price = 39 },
	[5] = { ProductId = 3632999182, Price = 49 },
	[6] = { ProductId = 3633000352, Price = 59 },
	[7] = { ProductId = 3633035140, Price = 69 },
	[8] = { ProductId = 3633239805, Price = 79 },
	[9] = { ProductId = 3633240389, Price = 89 },
	[10] = { ProductId = 3633242065, Price = 99 },
	[11] = { ProductId = 3633243801, Price = 119 },
	[12] = { ProductId = 3633247155, Price = 139 },
	[13] = { ProductId = 3633249514, Price = 159 },
	[14] = { ProductId = 3633258085, Price = 179 },
	[15] = { ProductId = 3633259272, Price = 199 },
	[16] = { ProductId = 3633260113, Price = 219 },
	[17] = { ProductId = 3633260999, Price = 239 },
	[18] = { ProductId = 3633262069, Price = 259 },
	[19] = { ProductId = 3633262983, Price = 279 },
	[20] = { ProductId = 3633263985, Price = 299 },
	[21] = { ProductId = 3633306097, Price = 319 },
	[22] = { ProductId = 3633307052, Price = 339 },
	[23] = { ProductId = 3633308390, Price = 349 },
	[24] = { ProductId = 3633309620, Price = 369 },
	[25] = { ProductId = 3633311126, Price = 389 },
	[26] = { ProductId = 3633314991, Price = 399 },
	[27] = { ProductId = 3633322447, Price = 419 },
	[28] = { ProductId = 3633338141, Price = 439 },
	[29] = { ProductId = 3633339242, Price = 469 },
	[30] = { ProductId = 3633340439, Price = 499 },
}

-- 7-day login reward chain. Streak resets if the player is offline longer
-- than StreakResetSeconds. SkipAllProductId 0 disables the skip-all prompt.
-- Reward types:
--   Cash       -> AddStat Cash
--   LuckyBlock -> LuckyBlockService.AddLuckyBlock(BlockId or "LuckyBlock")
--   LootItem   -> RarityItemSpawner GrantClaimedLoot bindable: a claimed
--                 copy of the RarityItemsConfig item (tool + index
--                 discovery + sellable/giftable like any picked-up loot).
-- LootItem / BlockId days render an Index-style model viewport instead of
-- the Icon image (DailyRewardController.setupDayViewport).
GameConfig.DailyRewards = {
	Days = {
		[1] = { Type = "Cash",       Amount = 1000,                          Label = "+$1.0K",        Icon = "rbxassetid://128499103360164", Rarity = "Common" },
		[2] = { Type = "Cash",       Amount = 2500,                          Label = "+$2.5K",        Icon = "rbxassetid://128499103360164", Rarity = "Common" },
		[3] = { Type = "Cash",       Amount = 7500,                          Label = "+$7.5K",        Icon = "rbxassetid://128499103360164", Rarity = "Rare" },
		[4] = { Type = "LootItem",   ItemName = "Golden Key",                Label = "Golden Key",    Rarity = "Rare" },
		[5] = { Type = "Cash",       Amount = 25000,                         Label = "+$25K",         Icon = "rbxassetid://128499103360164", Rarity = "Epic" },
		[6] = { Type = "LuckyBlock", BlockId = "LegendaryLootBlock", Amount = 1, Label = "Legendary Lucky Block", Rarity = "Legendary" },
		-- NOT Dragon Egg: that's the paid pedestal item (workspace.DevProduct1)
		[7] = { Type = "LootItem",   ItemName = "Thunder Hammer",            Label = "Thunder Hammer", Rarity = "Mythic" },
	},
	SkipAllProductId   = 3632842002,
	SecondsPerDay      = 86400,
	StreakResetSeconds = 172800,
}

return GameConfig
