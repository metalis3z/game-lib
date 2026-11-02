--!strict
-- PurchasePrompt (clean pattern) - ModuleScript, client only.
-- Wraps MarketplaceService prompts so UI code can simply do:
--     local bought = PurchasePrompt.GamePass(12345)   -- yields until the Roblox dialog closes
-- and gets: no double prompts while one is open, a timeout, and an optional "pending" callback
-- for showing a spinner / blur.
--
-- Credits / ideas taken from:
--   murderers-vs-sheriffs  AdminBoardPurchaseClient  (pendingPrompt lock, PromptGamePassPurchaseFinished filter,
--                                                    refresh button to "Purchased" afterwards)
--   murderers-vs-sheriffs / steal-an-egg  "purchase pending" overlays (blur + spinner while the dialog is up;
--                                                    those files were decompiled so they are NOT copied here)
--
-- IMPORTANT: for Developer Products the client result only says the dialog was accepted.
-- The item must be granted on the SERVER in MarketplaceService.ProcessReceipt. Use the return value
-- here only for UI (close the shop, show a "thanks" toast).
--
-- Usage:
--   local PurchasePrompt = require(game.ReplicatedStorage.PurchasePrompt)
--   PurchasePrompt.SetPendingCallback(function(isOpen) blur.Enabled = isOpen end) -- optional
--
--   buyButton.Activated:Connect(function()
--       if PurchasePrompt.GamePass(VIP_PASS_ID) then
--           Toast.Success("Thanks for buying VIP!")
--       end
--   end)
--
--   local accepted = PurchasePrompt.Product(COINS_1000_ID)
--   if PurchasePrompt.OwnsGamePass(VIP_PASS_ID) then ... end

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local PurchasePrompt = {}

local TIMEOUT = 120 -- seconds before we give up waiting for the dialog

local player = Players.LocalPlayer
local busy = false
local pendingCallback: ((boolean) -> ())? = nil
local ownedCache: { [number]: boolean } = {}

function PurchasePrompt.SetPendingCallback(callback: ((isOpen: boolean) -> ())?)
	pendingCallback = callback
end

local function setPending(isOpen: boolean)
	if pendingCallback then
		task.spawn(pendingCallback, isOpen)
	end
end

-- Generic runner: `prompt` opens the dialog, `signal` + `match` recognise our finish event.
local function run(prompt: () -> (), signal: RBXScriptSignal, match: (...any) -> (boolean, boolean)): boolean
	if busy then
		return false -- a dialog is already open: ignore spam clicks
	end
	busy = true
	setPending(true)

	local done = Instance.new("BindableEvent")
	local result = false
	local finished = false

	local conn = signal:Connect(function(...)
		local isOurs, purchased = match(...)
		if isOurs and not finished then
			finished = true
			result = purchased
			done:Fire()
		end
	end)

	local ok, err = pcall(prompt)
	if not ok then
		warn("[PurchasePrompt] prompt failed:", err)
		finished = true
	else
		task.delay(TIMEOUT, function()
			if not finished then
				finished = true
				done:Fire()
			end
		end)
		if not finished then
			done.Event:Wait()
		end
	end

	conn:Disconnect()
	done:Destroy()
	setPending(false)
	busy = false
	return result
end

-- Game pass. Returns true if bought in this dialog.
function PurchasePrompt.GamePass(gamePassId: number): boolean
	if PurchasePrompt.OwnsGamePass(gamePassId) then
		return true
	end
	local bought = run(function()
		MarketplaceService:PromptGamePassPurchase(player, gamePassId)
	end, MarketplaceService.PromptGamePassPurchaseFinished, function(who: Player, id: number, wasPurchased: boolean)
		return who == player and id == gamePassId, wasPurchased
	end)
	if bought then
		ownedCache[gamePassId] = true
	end
	return bought
end

-- Developer product. Returns true if the player accepted the dialog (grant on the server!).
function PurchasePrompt.Product(productId: number): boolean
	return run(function()
		MarketplaceService:PromptProductPurchase(player, productId)
	end, MarketplaceService.PromptProductPurchaseFinished, function(userId: number, id: number, isPurchased: boolean)
		return userId == player.UserId and id == productId, isPurchased
	end)
end

-- Cached ownership check (UserOwnsGamePassAsync can yield and can fail).
function PurchasePrompt.OwnsGamePass(gamePassId: number): boolean
	if ownedCache[gamePassId] then
		return true
	end
	local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, gamePassId)
	if ok and owns then
		ownedCache[gamePassId] = true
		return true
	end
	return false
end

function PurchasePrompt.IsBusy(): boolean
	return busy
end

-- Fetch price/name for a shop button label. infoType: Enum.InfoType.GamePass or Enum.InfoType.Product
function PurchasePrompt.GetPriceText(id: number, infoType: Enum.InfoType): string?
	local ok, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, id, infoType)
	if ok and info and info.PriceInRobux then
		return utf8.char(0xE002) .. tostring(info.PriceInRobux) -- Robux glyph + price
	end
	return nil
end

return PurchasePrompt
