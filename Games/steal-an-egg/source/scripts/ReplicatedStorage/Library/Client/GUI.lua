-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Library.Player)
require(ReplicatedStorage.Library.Types.GUI)

local Signal = require(ReplicatedStorage.Library.Signal)
local v1 = if RunService:IsStudio() then 30 else 99999999
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", v1)
local v2 = nil
local v3 = nil

v3 = {
	BaseUpgradeTransitionGui = function() --[[ BaseUpgradeTransitionGui | Line: 60 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BaseUpgradeTransitionGui", v1)
	end,
	PlayerGui = function() --[[ PlayerGui | Line: 63 | Upvalues: PlayerGui (copy) ]]
		return PlayerGui
	end,
	TreadmillScreenSideButtons = function() --[[ TreadmillScreenSideButtons | Line: 66 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillScreenSideButtons", v1)
	end,
	TreadmillScreenComments = function() --[[ TreadmillScreenComments | Line: 69 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillScreenComments", v1)
	end,
	TreadmillScreenFriendLikes = function() --[[ TreadmillScreenFriendLikes | Line: 72 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillScreenFriendLikes", v1)
	end,
	StealDnaMessage = function() --[[ StealDnaMessage | Line: 75 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("StealDnaMessage", v1)
	end,
	TreadmillVideoSurfaceGui = function() --[[ TreadmillVideoSurfaceGui | Line: 78 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillVideoSurfaceGui", v1)
	end,
	StaticTreadmillImageSurfaceGui = function() --[[ StaticTreadmillImageSurfaceGui | Line: 81 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("StaticTreadmillImageSurfaceGui", v1)
	end,
	BonusScreen = function() --[[ BonusScreen | Line: 84 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BonusScreen", v1)
	end,
	BonusScreenVignette = function() --[[ BonusScreenVignette | Line: 87 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BonusScreenVignette", v1)
	end,
	BottomUI = function() --[[ BottomUI | Line: 90 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		local BottomUI = PlayerGui:WaitForChild("BottomUI", v1)

		assert(BottomUI:IsA("ScreenGui"), "PlayerGui.BottomUI must be a ScreenGui")

		local BottomFrame = BottomUI.BottomFrame

		assert(BottomFrame:IsA("Frame"), "PlayerGui.BottomUI.BottomFrame must be a Frame")

		local Holder = BottomFrame.Holder

		assert(Holder:IsA("Frame"), "PlayerGui.BottomUI.BottomFrame.Holder must be a Frame")

		local List = Holder.List

		assert(List:IsA("Frame"), "PlayerGui.BottomUI.BottomFrame.Holder.List must be a Frame")

		local Luck = List.Luck

		assert(Luck:IsA("Frame"), "PlayerGui.BottomUI.BottomFrame.Holder.List.Luck must be a Frame")

		local Button = Luck.Button

		assert(Button:IsA("ImageButton"), "BottomUI Luck.Button must be an ImageButton")

		local v7 = Button.Content

		assert(v7:IsA("Frame"), "BottomUI Luck.Button.Content must be a Frame")

		local v9 = v7.Value

		assert(v9:IsA("Frame"), "BottomUI Luck.Button.Content.Value must be a Frame")
		assert(v9.TextLabel:IsA("TextLabel"), "BottomUI Luck value must be a TextLabel")

		local x2Luck = List.x2Luck

		assert(x2Luck:IsA("Frame"), "BottomUI x2Luck must be a Frame")
		assert(x2Luck.Icon:IsA("ImageButton"), "BottomUI x2Luck.Icon must be an ImageButton")
		assert(x2Luck.Timer:IsA("TextLabel"), "BottomUI x2Luck.Timer must be a TextLabel")

		local x2Growth = List.x2Growth

		assert(x2Growth:IsA("Frame"), "BottomUI x2Growth must be a Frame")
		assert(x2Growth.Icon:IsA("ImageButton"), "BottomUI x2Growth.Icon must be an ImageButton")
		assert(x2Growth.Timer:IsA("TextLabel"), "BottomUI x2Growth.Timer must be a TextLabel")

		return BottomUI
	end,
	Damage = function() --[[ Damage | Line: 120 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		local Damage = PlayerGui:WaitForChild("Damage", v1)

		assert(Damage:IsA("ScreenGui"), "PlayerGui.Damage must be a ScreenGui")
		assert(Damage:WaitForChild("ImageLabel", v1):IsA("ImageLabel"), "PlayerGui.Damage.ImageLabel must be an ImageLabel")

		return Damage
	end,
	OfflineMoneyInPlot = function() --[[ OfflineMoneyInPlot | Line: 129 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("OfflineMoneyInPlot", v1)
	end,
	PuzzleUI = function() --[[ PuzzleUI | Line: 132 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("PuzzleUI", v1)
	end,
	FuseMachine = function() --[[ FuseMachine | Line: 135 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("FuseMachine", v1)
	end,
	VIPSkinFuseMachine = function() --[[ VIPSkinFuseMachine | Line: 138 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("VIPSkinFuseMachine", v1)
	end,
	VIPBrainrotFuseMachine = function() --[[ VIPBrainrotFuseMachine | Line: 141 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("VIPBrainrotFuseMachine", v1)
	end,
	WeatherSchedules = function() --[[ WeatherSchedules | Line: 144 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("WeatherSchedules", v1)
	end,
	SkinFuseMachine = function() --[[ SkinFuseMachine | Line: 147 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("SkinFuseMachine", v1)
	end,
	BrainrotFuseMachine = function() --[[ BrainrotFuseMachine | Line: 150 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BrainrotFuseMachine", v1)
	end,
	PrivateBrainrotFuseMachine = function() --[[ PrivateBrainrotFuseMachine | Line: 153 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("PrivateBrainrotFuseMachine", v1)
	end,
	AbilityShop = function() --[[ AbilityShop | Line: 156 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("AbilityShop", v1)
	end,
	SkinShop = function() --[[ SkinShop | Line: 159 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("SkinShop", v1)
	end,
	BlackMarket = function() --[[ BlackMarket | Line: 162 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BlackMarket", v1)
	end,
	StealEffectVignette = function() --[[ StealEffectVignette | Line: 165 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Vignette", v1)
	end,
	ScaryText = function() --[[ ScaryText | Line: 168 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ScaryText", v1)
	end,
	AutoSell = function() --[[ AutoSell | Line: 171 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("AutoSell", v1)
	end,
	EggInventory = function() --[[ EggInventory | Line: 174 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("EggInventory", v1)
	end,
	AssetEggShop = function() --[[ AssetEggShop | Line: 177 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("AssetEggShop", v1)
	end,
	AssetEggData = function() --[[ AssetEggData | Line: 180 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("AssetEggData", v1)
	end,
	AssetHoverData = function() --[[ AssetHoverData | Line: 183 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		local AssetHoverData = PlayerGui:WaitForChild("AssetHoverData", v1)

		assert(AssetHoverData:IsA("ScreenGui"), "PlayerGui.AssetHoverData must be a ScreenGui.")

		return AssetHoverData
	end,
	ActiveAssetHover_UI = function() --[[ ActiveAssetHover_UI | Line: 188 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ActiveAssetHover_UI", v1)
	end,
	AreaGui = function() --[[ AreaGui | Line: 191 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("AreaGui", v1)
	end,
	BrainrotOddsHoverData = function() --[[ BrainrotOddsHoverData | Line: 194 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BrainrotOddsHoverData", v1)
	end,
	BloodNightShop = function() --[[ BloodNightShop | Line: 197 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BloodNightShop", v1)
	end,
	Index = function() --[[ Index | Line: 200 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Index", v1)
	end,
	BloodlutCurrency_UI = function() --[[ BloodlutCurrency_UI | Line: 203 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BloodlutCurrency_UI", v1)
	end,
	Backpack = function() --[[ Backpack | Line: 206 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BackpackGui", v1)
	end,
	DropHeldEgg = function() --[[ DropHeldEgg | Line: 209 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("DropHeldEgg", v1)
	end,
	Money = function() --[[ Money | Line: 212 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Money", v1)
	end,
	OfflineMoney = function() --[[ OfflineMoney | Line: 215 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("OfflineCashOnly", v1)
	end,
	OfflineCashOnly = function() --[[ OfflineCashOnly | Line: 218 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("OfflineCashOnly", v1)
	end,
	OfflineCashAndAssetLevelGrew = function() --[[ OfflineCashAndAssetLevelGrew | Line: 221 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("OfflineCashAndAssetLevelGrew", v1)
	end,
	TeleportUI = function() --[[ TeleportUI | Line: 224 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TeleportUI", v1)
	end,
	LuckyFoodShop = function() --[[ LuckyFoodShop | Line: 227 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("LuckyFoodShop", v1)
	end,
	TrailShop = function() --[[ TrailShop | Line: 230 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TrailShop", v1)
	end,
	TreadmillScreenButtonSwapLeft = function() --[[ TreadmillScreenButtonSwapLeft | Line: 233 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillScreenButtonSwapLeft", v1)
	end,
	TreadmillScreenButtonSwapRight = function() --[[ TreadmillScreenButtonSwapRight | Line: 236 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillScreenButtonSwapRight", v1)
	end,
	TreadmillScreenButtonShare = function() --[[ TreadmillScreenButtonShare | Line: 239 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillScreenButtonShare", v1)
	end,
	SwordShop = function() --[[ SwordShop | Line: 242 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("SwordShop", v1)
	end,
	Odds_UI = function() --[[ Odds_UI | Line: 245 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Odds_UI", v1)
	end,
	RunButton = function() --[[ RunButton | Line: 248 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("RunButton", v1)
	end,
	RunButtonButton = function() --[[ RunButtonButton | Line: 251 | Upvalues: v3 (ref), v1 (copy) ]]
		return v3.RunButton():WaitForChild("Button", v1)
	end,
	RunCharge = function() --[[ RunCharge | Line: 254 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("RunCharge", v1)
	end,
	RunChargeBaseLuck = function() --[[ RunChargeBaseLuck | Line: 257 | Upvalues: v3 (ref), v1 (copy) ]]
		return v3.RunCharge():WaitForChild("Main", v1):WaitForChild("Frame", v1):WaitForChild("Top", v1):WaitForChild("BaseLuck", v1)
	end,
	RunChargeTopScale = function() --[[ RunChargeTopScale | Line: 264 | Upvalues: v3 (ref), v1 (copy) ]]
		return v3.RunCharge():WaitForChild("Main", v1):WaitForChild("Frame", v1):WaitForChild("Top", v1):WaitForChild("UIScale", v1)
	end,
	RunChargeBar = function() --[[ RunChargeBar | Line: 271 | Upvalues: v3 (ref), v1 (copy) ]]
		return v3.RunCharge():WaitForChild("Main", v1):WaitForChild("CanvasGroup", v1):WaitForChild("Bar", v1)
	end,
	ChargeResultEffects = function() --[[ ChargeResultEffects | Line: 277 | Upvalues: v3 (ref) ]]
		return v3.RunCharge().Main
	end,
	ChargeResultEffectsFrame = function() --[[ ChargeResultEffectsFrame | Line: 280 | Upvalues: v3 (ref) ]]
		return v3.ChargeResultEffects().ChargeResultEffects
	end,
	ChargeResultEffectsBad = function() --[[ ChargeResultEffectsBad | Line: 283 | Upvalues: v3 (ref) ]]
		return v3.ChargeResultEffectsFrame().Bad
	end,
	ChargeResultEffectsGood = function() --[[ ChargeResultEffectsGood | Line: 286 | Upvalues: v3 (ref) ]]
		return v3.ChargeResultEffectsFrame().Good
	end,
	ChargeResultEffectsGreat = function() --[[ ChargeResultEffectsGreat | Line: 289 | Upvalues: v3 (ref) ]]
		return v3.ChargeResultEffectsFrame().Great
	end,
	ChargeResultEffectsExcellent = function() --[[ ChargeResultEffectsExcellent | Line: 292 | Upvalues: v3 (ref) ]]
		return v3.ChargeResultEffectsFrame().Excellent
	end,
	ChargeResultEffectsPerfect = function() --[[ ChargeResultEffectsPerfect | Line: 295 | Upvalues: v3 (ref) ]]
		return v3.ChargeResultEffectsFrame().Perfect
	end,
	ChargeResultEffectsBadScale = function() --[[ ChargeResultEffectsBadScale | Line: 298 | Upvalues: v2 (ref), v3 (ref) ]]
		return v2(v3.ChargeResultEffectsBad())
	end,
	ChargeResultEffectsGoodScale = function() --[[ ChargeResultEffectsGoodScale | Line: 301 | Upvalues: v2 (ref), v3 (ref) ]]
		return v2(v3.ChargeResultEffectsGood())
	end,
	ChargeResultEffectsGreatScale = function() --[[ ChargeResultEffectsGreatScale | Line: 304 | Upvalues: v2 (ref), v3 (ref) ]]
		return v2(v3.ChargeResultEffectsGreat())
	end,
	ChargeResultEffectsExcellentScale = function() --[[ ChargeResultEffectsExcellentScale | Line: 307 | Upvalues: v2 (ref), v3 (ref) ]]
		return v2(v3.ChargeResultEffectsExcellent())
	end,
	ChargeResultEffectsPerfectScale = function() --[[ ChargeResultEffectsPerfectScale | Line: 310 | Upvalues: v2 (ref), v3 (ref) ]]
		return v2(v3.ChargeResultEffectsPerfect())
	end,
	MutationPotionsShop = function() --[[ MutationPotionsShop | Line: 313 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("MutationPotionsShop", v1)
	end,
	GearShop = function() --[[ GearShop | Line: 316 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GearShop", v1)
	end,
	ConfirmPetEggPurchase = function() --[[ ConfirmPetEggPurchase | Line: 319 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ConfirmPetEggPurchase", v1)
	end,
	PetEggShop = function() --[[ PetEggShop | Line: 322 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("PetEggShop", v1)
	end,
	ActivePetUI = function() --[[ ActivePetUI | Line: 325 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ActivePetUI", v1)
	end,
	PetList = function() --[[ PetList | Line: 328 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("PetList", v1)
	end,
	PetUI = function() --[[ PetUI | Line: 331 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("PetUI", v1)
	end,
	FriendBoost = function() --[[ FriendBoost | Line: 334 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("FriendBoost", v1)
	end,
	FirstTimeClimbTower = function() --[[ FirstTimeClimbTower | Line: 337 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("FirstTimeClimbTower", v1)
	end,
	FirstTimeProgressTower = function() --[[ FirstTimeProgressTower | Line: 340 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("FirstTimeProgressTower", v1)
	end,
	SpeedGainAnimation = function() --[[ SpeedGainAnimation | Line: 343 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("SpeedGainAnimation", v1)
	end,
	BatchScaledUIs = function() --[[ BatchScaledUIs | Line: 346 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BatchScaledUIs", v1)
	end,
	Achievements = function() --[[ Achievements | Line: 349 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Achievements", v1)
	end,
	BattlePass = function() --[[ BattlePass | Line: 352 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BattlePass", v1)
	end,
	BoothOtherPlayer = function() --[[ BoothOtherPlayer | Line: 355 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BoothOtherPlayer", v1)
	end,
	BoothPrompt = function() --[[ BoothPrompt | Line: 358 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BoothPrompt", v1)
	end,
	NpcQuestsList = function() --[[ NpcQuestsList | Line: 361 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("NpcQuestsList", v1)
	end,
	Box = function() --[[ Box | Line: 364 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Box", v1)
	end,
	Codes = function() --[[ Codes | Line: 367 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Codes", v1)
	end,
	GroupReward = function() --[[ GroupReward | Line: 370 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GroupReward", v1)
	end,
	DropBrainrot = function() --[[ DropBrainrot | Line: 373 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("DropBrainrot", v1)
	end,
	DropBrainrotForTutorial = function() --[[ DropBrainrotForTutorial | Line: 376 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		local DropBrainrotForTutorial = PlayerGui:WaitForChild("DropBrainrot", v1):Clone()

		DropBrainrotForTutorial.Name = "DropBrainrotForTutorial"
		DropBrainrotForTutorial.Parent = PlayerGui

		return DropBrainrotForTutorial
	end,
	Changelog = function() --[[ Changelog | Line: 382 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Changelog", v1)
	end,
	Enchants = function() --[[ Enchants | Line: 385 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Enchants", v1)
	end,
	ExclusiveShopItems = function() --[[ ExclusiveShopItems | Line: 388 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ExclusiveShopItems", v1)
	end,
	GenerateRewards = function() --[[ GenerateRewards | Line: 391 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GenerateRewards", v1)
	end,
	GlobalEvents = function() --[[ GlobalEvents | Line: 394 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GlobalEvents", v1)
	end,
	GoalsSide = function() --[[ GoalsSide | Line: 397 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GoalsSide", v1)
	end,
	Guilds = function() --[[ Guilds | Line: 400 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Guilds", v1)
	end,
	HatchSettings = function() --[[ HatchSettings | Line: 403 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("HatchSettings", v1)
	end,
	HypeTickets = function() --[[ HypeTickets | Line: 406 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("HypeTickets", v1)
	end,
	Inventory = function() --[[ Inventory | Line: 409 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Inventory", v1)
	end,
	InviteFriends = function() --[[ InviteFriends | Line: 412 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("InviteFriends", v1)
	end,
	LootMessage = function() --[[ LootMessage | Line: 415 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("LootMessage", v1)
	end,
	Main = function() --[[ Main | Line: 418 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Main", v1)
	end,
	MainBottomRight = function() --[[ MainBottomRight | Line: 421 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Main", v1):WaitForChild("BottomRight", v1)
	end,
	MainLeft = function() --[[ MainLeft | Line: 424 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("MainLeft", v1)
	end,
	MainMobile = function() --[[ MainMobile | Line: 427 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("MainMobile", v1)
	end,
	Mastery = function() --[[ Mastery | Line: 430 | Upvalues: v3 (ref), v1 (copy) ]]
		return v3.BatchScaledUIs():WaitForChild("Mastery", v1)
	end,
	MasteryPerk = function() --[[ MasteryPerk | Line: 433 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("MasteryPerk", v1)
	end,
	Message = function() --[[ Message | Line: 436 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Message", v1)
	end,
	NewGift = function() --[[ NewGift | Line: 439 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("NewGift", v1)
	end,
	Notifications = function() --[[ Notifications | Line: 442 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Notifications", v1)
	end,
	ProgressBars = function() --[[ ProgressBars | Line: 445 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ProgressBars", v1)
	end,
	RaidSummary = function() --[[ RaidSummary | Line: 448 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("RaidSummary", v1)
	end,
	Rank = function() --[[ Rank | Line: 451 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Rank", v1)
	end,
	RankUp = function() --[[ RankUp | Line: 454 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("RankUp", v1)
	end,
	Rebirth = function() --[[ Rebirth | Line: 457 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Rebirth", v1)
	end,
	Revive = function() --[[ Revive | Line: 460 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Revive", v1)
	end,
	BrainrotSpinnyWheel = function() --[[ BrainrotSpinnyWheel | Line: 463 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("BrainrotSpinnyWheel", v1)
	end,
	RebirthDetails = function() --[[ RebirthDetails | Line: 466 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("RebirthDetails", v1)
	end,
	TycoonRebirthDetails = function() --[[ TycoonRebirthDetails | Line: 469 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TycoonRebirthDetails", v1)
	end,
	Settings = function() --[[ Settings | Line: 472 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Settings", v1)
	end,
	ShinyBonus = function() --[[ ShinyBonus | Line: 475 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ShinyBonus", v1)
	end,
	Starter = function() --[[ Starter | Line: 478 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Starter", v1)
	end,
	StarterpackDeal = function() --[[ StarterpackDeal | Line: 481 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("StarterpackDeal", v1)
	end,
	LimitedStarterPackOffer = function() --[[ LimitedStarterPackOffer | Line: 484 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("LimitedStarterPackOffer", v1)
	end,
	TeleportMap = function() --[[ TeleportMap | Line: 487 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TeleportMap", v1)
	end,
	TradeHistory = function() --[[ TradeHistory | Line: 490 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TradeHistory", v1)
	end,
	TradeMessage = function() --[[ TradeMessage | Line: 493 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TradeMessage", v1)
	end,
	TradePlayerList = function() --[[ TradePlayerList | Line: 496 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TradePlayerList", v1)
	end,
	TradePlazaChoice = function() --[[ TradePlazaChoice | Line: 499 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TradePlazaChoice", v1)
	end,
	TradeWindow = function() --[[ TradeWindow | Line: 502 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TradeWindow", v1)
	end,
	TradingTerminalLoading = function() --[[ TradingTerminalLoading | Line: 505 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TradingTerminalLoading", v1)
	end,
	Transition = function() --[[ Transition | Line: 508 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Transition", v1)
	end,
	Tutorial = function() --[[ Tutorial | Line: 511 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Tutorial", v1)
	end,
	TutorialInstructions = function() --[[ TutorialInstructions | Line: 514 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TutorialInstructions", v1)
	end,
	TutorialTapScreen = function() --[[ TutorialTapScreen | Line: 517 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TutorialTapScreen", v1)
	end,
	Ultimates = function() --[[ Ultimates | Line: 520 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Ultimates", v1)
	end,
	DigsiteMerchant = function() --[[ DigsiteMerchant | Line: 523 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("DigsiteMerchant", v1)
	end,
	FishingGame = function() --[[ FishingGame | Line: 526 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("FishingGame", v1)
	end,
	Digsite = function() --[[ Digsite | Line: 529 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("Digsite", v1)
	end,
	FishingMerchant = function() --[[ FishingMerchant | Line: 532 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("FishingMerchant", v1)
	end,
	RaceTimer = function() --[[ RaceTimer | Line: 535 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("RaceTimer", v1)
	end,
	ObbyTimer = function() --[[ ObbyTimer | Line: 538 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("ObbyTimer", v1)
	end,
	ChestRush = function() --[[ ChestRush | Line: 541 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("ChestRush", v1)
	end,
	FlowerMerchant = function() --[[ FlowerMerchant | Line: 544 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("FlowerMerchant", v1)
	end,
	Minecart = function() --[[ Minecart | Line: 547 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("Minecart", v1)
	end,
	AdvancedDigsiteMerchant = function() --[[ AdvancedDigsiteMerchant | Line: 550 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("AdvancedDigsiteMerchant", v1)
	end,
	AdvancedFishingMerchant = function() --[[ AdvancedFishingMerchant | Line: 553 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("AdvancedFishingMerchant", v1)
	end,
	ChestRaid = function() --[[ ChestRaid | Line: 556 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("ChestRaid", v1)
	end,
	ClawMachine = function() --[[ ClawMachine | Line: 559 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_INSTANCES", v1):WaitForChild("ClawMachine", v1)
	end,
	EggSlotsMachine = function() --[[ EggSlotsMachine | Line: 562 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("EggSlotsMachine", v1)
	end,
	EquipSlotsMachine = function() --[[ EquipSlotsMachine | Line: 565 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("EquipSlotsMachine", v1)
	end,
	GoldMachine = function() --[[ GoldMachine | Line: 568 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("GoldMachine", v1)
	end,
	DinoTycoonHugeChanceMachine = function() --[[ DinoTycoonHugeChanceMachine | Line: 571 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("DinoTycoonHugeChanceMachine", v1)
	end,
	TreehouseMerchant = function() --[[ TreehouseMerchant | Line: 575 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("TreehouseMerchant", v1)
	end,
	TransferMachine = function() --[[ TransferMachine | Line: 578 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("TransferMachine", v1)
	end,
	RainbowMachine = function() --[[ RainbowMachine | Line: 581 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("RainbowMachine", v1)
	end,
	TravelingMerchant = function() --[[ TravelingMerchant | Line: 584 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("TravelingMerchant", v1)
	end,
	UpgradeEnchantsMachineSingular = function() --[[ UpgradeEnchantsMachineSingular | Line: 587 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("UpgradeEnchantsMachineSingular", v1)
	end,
	UpgradePotionsMachineSingular = function() --[[ UpgradePotionsMachineSingular | Line: 591 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("UpgradePotionsMachineSingular", v1)
	end,
	PetIndexMachine = function() --[[ PetIndexMachine | Line: 595 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("PetIndexMachine", v1)
	end,
	SpinnyWheel = function() --[[ SpinnyWheel | Line: 598 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("SpinnyWheel", v1)
	end,
	XPPotionMachine = function() --[[ XPPotionMachine | Line: 601 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("XPPotionMachine", v1)
	end,
	DiceCraftingMachine = function() --[[ DiceCraftingMachine | Line: 604 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("DiceCraftingMachine", v1)
	end,
	CraftPotionsMachine = function() --[[ CraftPotionsMachine | Line: 607 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("CraftPotionsMachine", v1)
	end,
	PowerUpIndex = function() --[[ PowerUpIndex | Line: 610 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("PowerUpIndex", v1)
	end,
	Auction = function() --[[ Auction | Line: 613 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("Auction", v1)
	end,
	UpgradeFruitsMachine = function() --[[ UpgradeFruitsMachine | Line: 616 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("UpgradeFruitsMachine", v1)
	end,
	UpgradeFruitsSelectorMachine = function() --[[ UpgradeFruitsSelectorMachine | Line: 619 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("UpgradeFruitsSelectorMachine", v1)
	end,
	UpgradeFruitsShinyMachine = function() --[[ UpgradeFruitsShinyMachine | Line: 623 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("UpgradeFruitsShinyMachine", v1)
	end,
	DaycareMachine = function() --[[ DaycareMachine | Line: 626 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("DaycareMachine", v1)
	end,
	EnchantsSelectorMachine = function() --[[ EnchantsSelectorMachine | Line: 629 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("EnchantsSelectorMachine", v1)
	end,
	HugeMachine = function() --[[ HugeMachine | Line: 632 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("HugeMachine", v1)
	end,
	MailboxMachine = function() --[[ MailboxMachine | Line: 635 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("MailboxMachine", v1)
	end,
	TradingTerminal = function() --[[ TradingTerminal | Line: 638 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("TradingTerminal", v1)
	end,
	ReverseMerchant = function() --[[ ReverseMerchant | Line: 641 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("ReverseMerchant", v1)
	end,
	MagicMachine = function() --[[ MagicMachine | Line: 644 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("MagicMachine", v1)
	end,
	Merchant = function() --[[ Merchant | Line: 647 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("Merchant", v1)
	end,
	DailyQuestMachine = function() --[[ DailyQuestMachine | Line: 650 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("DailyQuestMachine", v1)
	end,
	SuperMachine = function() --[[ SuperMachine | Line: 653 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("SuperMachine", v1)
	end,
	ItemCreatorMachine = function() --[[ ItemCreatorMachine | Line: 656 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("ItemCreatorMachine", v1)
	end,
	UpgradePotionsMachineBulk = function() --[[ UpgradePotionsMachineBulk | Line: 659 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("UpgradePotionsMachineBulk", v1)
	end,
	UpgradeEnchantsMachineBulk = function() --[[ UpgradeEnchantsMachineBulk | Line: 662 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("UpgradeEnchantsMachineBulk", v1)
	end,
	ForgeMachineSelect = function() --[[ ForgeMachineSelect | Line: 666 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("ForgeMachineSelect", v1)
	end,
	ForgeMachine = function() --[[ ForgeMachine | Line: 669 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("ForgeMachine", v1)
	end,
	ExclusiveDaycareMachine = function() --[[ ExclusiveDaycareMachine | Line: 672 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("ExclusiveDaycareMachine", v1)
	end,
	EmpowerEnchantsMachine = function() --[[ EmpowerEnchantsMachine | Line: 675 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("EmpowerEnchantsMachine", v1)
	end,
	EnchantEssenceMachine = function() --[[ EnchantEssenceMachine | Line: 678 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("EnchantEssenceMachine", v1)
	end,
	SummerGiftMachine = function() --[[ SummerGiftMachine | Line: 681 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("SummerGiftMachine", v1)
	end,
	ActionMenu = function() --[[ ActionMenu | Line: 684 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("ActionMenu", v1)
	end,
	StarGrab = function() --[[ StarGrab | Line: 687 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("StarGrab", v1)
	end,
	Alert = function() --[[ Alert | Line: 690 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("Alert", v1)
	end,
	BuyMultiple = function() --[[ BuyMultiple | Line: 693 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("BuyMultiple", v1)
	end,
	Debris = function() --[[ Debris | Line: 696 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("Debris", v1)
	end,
	FFlags = function() --[[ FFlags | Line: 699 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("FFlags", v1)
	end,
	FreeGifts = function() --[[ FreeGifts | Line: 702 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("FreeGifts", v1)
	end,
	TextInput = function() --[[ TextInput | Line: 705 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("TextInput", v1)
	end,
	Loading = function() --[[ Loading | Line: 708 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("Loading", v1)
	end,
	RebirthFlash = function() --[[ RebirthFlash | Line: 711 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("RebirthFlash", v1)
	end,
	Tool = function() --[[ Tool | Line: 714 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("Tool", v1)
	end,
	Instancing = function() --[[ Instancing | Line: 717 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("Instancing", v1)
	end,
	TycoonTeleport = function() --[[ TycoonTeleport | Line: 720 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("TycoonTeleport", v1)
	end,
	BoxCustomize = function() --[[ BoxCustomize | Line: 723 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("BoxCustomize", v1)
	end,
	ChatFilters = function() --[[ ChatFilters | Line: 726 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("ChatFilters", v1)
	end,
	AdminCommands = function() --[[ AdminCommands | Line: 729 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Admin Commands", v1)
	end,
	AdminPanelItem = function() --[[ AdminPanelItem | Line: 732 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("AdminPanelItem", v1)
	end,
	AdminInventory = function() --[[ AdminInventory | Line: 735 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Admin Inventory", v1)
	end,
	RngUpgradeMachine = function() --[[ RngUpgradeMachine | Line: 738 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("RngUpgradeMachine", v1)
	end,
	RngEventPetMerchant = function() --[[ RngEventPetMerchant | Line: 741 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("RngEventPetMerchant", v1)
	end,
	RngUI = function() --[[ RngUI | Line: 744 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("RngUI", v1)
	end,
	Debug = function() --[[ Debug | Line: 747 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Debug", v1)
	end,
	ModeratorUtil = function() --[[ ModeratorUtil | Line: 750 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Moderator Util", v1)
	end,
	PlayerProfile = function() --[[ PlayerProfile | Line: 753 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("PlayerProfile", v1)
	end,
	Keybinds = function() --[[ Keybinds | Line: 756 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Keybinds", v1)
	end,
	BoostExchangeMachine = function() --[[ BoostExchangeMachine | Line: 759 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MACHINES", v1):WaitForChild("BoostExchangeMachine", v1)
	end,
	RaffleSelector = function() --[[ RaffleSelector | Line: 762 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("RaffleSelector", v1)
	end,
	InventorySelect = function() --[[ InventorySelect | Line: 765 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("InventorySelect", v1)
	end,
	DarkBg = function() --[[ DarkBg | Line: 768 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("DarkBg", v1)
	end,
	Core = function() --[[ Core | Line: 771 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Core", v1)
	end,
	HotBar = function() --[[ HotBar | Line: 774 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("HotBar", v1)
	end,
	SideButtons = function() --[[ SideButtons | Line: 777 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Elements", v1)
	end,
	SideButtonTools = function() --[[ SideButtonTools | Line: 780 | Upvalues: v3 (ref) ]]
		return v3.SideButtons().Left.Tools
	end,
	PlayerList = function() --[[ PlayerList | Line: 783 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("PlayerList", v1)
	end,
	Shop = function() --[[ Shop | Line: 786 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Shop", v1)
	end,
	TreadmillSpeedShop = function() --[[ TreadmillSpeedShop | Line: 789 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TreadmillSpeedShop", v1)
	end,
	ServerLuck = function() --[[ ServerLuck | Line: 792 | Upvalues: v3 (ref), v1 (copy) ]]
		return v3.Shop():WaitForChild("Frame", v1):WaitForChild("Main", v1):WaitForChild("ScrollingFrame", v1):WaitForChild("ServerLuck", v1):WaitForChild("Main", v1)
	end,
	Teleport = function() --[[ Teleport | Line: 800 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Teleport", v1)
	end,
	OnScreenPrompts = function() --[[ OnScreenPrompts | Line: 803 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Prompts", v1)
	end,
	StarsHolder = function() --[[ StarsHolder | Line: 806 | Upvalues: v3 (ref) ]]
		return v3.Core().Kernel.Header.Right.Tokens.Stars.Kernel
	end,
	DiamondsHolder = function() --[[ DiamondsHolder | Line: 809 | Upvalues: v3 (ref) ]]
		return v3.Core().Kernel.Header.Right.Tokens.Diamonds.Kernel
	end,
	HeaderItems = function() --[[ HeaderItems | Line: 812 | Upvalues: v3 (ref) ]]
		return v3.Core().Kernel.Header
	end,
	MasteryButton = function() --[[ MasteryButton | Line: 815 | Upvalues: v3 (ref) ]]
		return v3.SideButtonTools().Mastery.Button
	end,
	TopBarItems = function() --[[ TopBarItems | Line: 818 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TopBarItems", v1)
	end,
	TopBarStandard = function() --[[ TopBarStandard | Line: 821 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("TopbarStandard", v1)
	end,
	StreamingScreen = function() --[[ StreamingScreen | Line: 824 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Streaming", v1)
	end,
	Goal = function() --[[ Goal | Line: 827 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Goal", v1)
	end,
	ArrowHolder = function() --[[ ArrowHolder | Line: 830 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ArrowHolder", v1)
	end,
	WorldCutscenes = function() --[[ WorldCutscenes | Line: 833 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("_MISC", v1):WaitForChild("WorldCutscenes", v1)
	end,
	EdgeGlow = function() --[[ EdgeGlow | Line: 836 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("EdgeGlow", v1)
	end,
	OfflineLogs = function() --[[ OfflineLogs | Line: 840 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("OfflineLogs", v1)
	end,
	LeaveLuckyBlocksView = function() --[[ LeaveLuckyBlocksView | Line: 843 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("LeaveLuckyBlocksView", v1)
	end,
	Radio = function() --[[ Radio | Line: 846 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Radio", v1)
	end,
	FirstTimePanel = function() --[[ FirstTimePanel | Line: 849 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("FirstTimePanel", v1)
	end,
	GameStatus = function() --[[ GameStatus | Line: 852 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GameStatus", v1)
	end,
	GameResetTimer = function() --[[ GameResetTimer | Line: 855 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GameResetTimer", v1)
	end,
	Fade = function() --[[ Fade | Line: 858 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("Fade", v1)
	end,
	FadeFrame = function() --[[ FadeFrame | Line: 861 | Upvalues: v3 (ref) ]]
		return v3.Fade().Fade
	end,
	GiftNotification = function() --[[ GiftNotification | Line: 864 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GiftNotification", v1)
	end,
	GetMoreSpeedOnHit = function() --[[ GetMoreSpeedOnHit | Line: 867 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		local GetMoreSpeedOnHit = PlayerGui:WaitForChild("GetMoreSpeedOnHit", v1)

		assert(GetMoreSpeedOnHit:IsA("ScreenGui"), "PlayerGui.GetMoreSpeedOnHit must be a ScreenGui")

		return GetMoreSpeedOnHit
	end,
	GrowingEggList = function() --[[ GrowingEggList | Line: 872 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("GrowingEggList", v1)
	end,
	ResetStartTimer = function() --[[ ResetStartTimer | Line: 875 | Upvalues: PlayerGui (copy), v1 (copy) ]]
		return PlayerGui:WaitForChild("ResetStartTimer", v1)
	end,
	ResetStartTimerLabel = function() --[[ ResetStartTimerLabel | Line: 878 | Upvalues: v3 (ref) ]]
		return v3.ResetStartTimer().Frame.TextLabel
	end,
	ResetStartTimerLabelScale = function() --[[ ResetStartTimerLabelScale | Line: 881 | Upvalues: v2 (ref), v3 (ref) ]]
		return v2(v3.ResetStartTimerLabel())
	end
}

local v4 = table.clone(v3)
local v5 = setmetatable(v4, {
	__index = function(p1, p2) --[[ __index | Line: 887 ]]
		error("Missing GUI: " .. tostring(p2))
	end
})

table.freeze(v5)

local t2 = {}
local v6 = nil
local t3 = {}

v2 = function(p1) --[[ getOrCreateUIScale | Line: 902 ]]
	local UIScale = p1:FindFirstChildOfClass("UIScale")

	if UIScale then
		return UIScale
	end

	local UIScale2 = Instance.new("UIScale")

	UIScale2.Scale = 0
	UIScale2.Parent = p1

	return UIScale2
end
function t3.ToggleMouseLock(p1) --[[ ToggleMouseLock | Line: 918 | Upvalues: v6 (ref), PlayerGui (copy) ]]
	local v1 = p1 or false

	if v6 then
		v6.Modal = v1
		v6.Visible = v1

		return
	end

	local LockMouse = Instance.new("ScreenGui")

	LockMouse.Name = "LockMouse"
	LockMouse.Parent = PlayerGui

	local TextButton = Instance.new("TextButton")

	TextButton.Visible = false
	TextButton.BackgroundTransparency = 1
	TextButton.Text = ""
	TextButton.BorderSizePixel = 0
	TextButton.Size = UDim2.fromOffset(1, 1)
	TextButton.Parent = LockMouse
	v6 = TextButton
	TextButton.Modal = v1
	TextButton.Visible = v1
end

local t4 = {}

function t3.ButtonActivated(p1, p2) --[[ ButtonActivated | Line: 940 | Upvalues: t4 (copy), Signal (copy) ]]
	if t4[p1] then
		t4[p1].Signal:Disconnect()
		t4[p1].Default:Disconnect()
	end

	t4[p1] = {
		Default = p1.Activated:Connect(p2),
		Signal = Signal.Fired("Console: Pressed Button"):Connect(function(p12) --[[ Line: 947 | Upvalues: p1 (copy), Signal (ref), p2 (copy) ]]
			if p1 ~= p12 then
				return
			end

			local v1 = nil

			v1 = Signal.Fired("Console: Released Button"):Connect(function(p12) --[[ Line: 950 | Upvalues: p1 (ref), p2 (ref), v1 (ref) ]]
				if p1 ~= p12 then
					v1:Disconnect()

					return
				end

				p2()
				v1:Disconnect()
			end)
		end)
	}

	return t4[p1]
end
function t3.ToggleCursor(p1) --[[ ToggleCursor | Line: 962 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseIconEnabled = p1 or false
end
function t3.Get(p1) --[[ Get | Line: 966 | Upvalues: t2 (copy), v3 (ref) ]]
	if t2[p1] then
		return t2[p1]
	end

	local v1 = v3[p1]

	if not v1 then
		error("Missing UI: " .. p1)
	end

	local v2 = v1()

	if v2 then
		t2[p1] = v2

		return v2
	end

	error("Missing UI: " .. p1)
end

return setmetatable(t3, {
	__index = v5
})