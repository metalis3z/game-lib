local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local LuckyBlockService = require(ServerScriptService.Source.Services.LuckyBlockService)

local LostBrainrotService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local LostRemotes = Remotes:WaitForChild("LostBrainrotService")
local ShowEvent = LostRemotes:WaitForChild("Show")
local HideEvent = LostRemotes:WaitForChild("Hide")
local GiveUpEvent = LostRemotes:WaitForChild("GiveUp")

-- Window during which a recovery purchase is honored. 60s matches the timer
-- the modal displays ("00:60" countdown). After that the lost blocks are
-- discarded server-side so a stale RobuxPurchase prompt can't restore them.
local RECOVERY_WINDOW = 60

-- pending[player] = { Blocks = {luckyBlockId, ...}, ExpireAt = osTime, Token = string }
-- Token guards against a second fall starting mid-prompt: the recovery callback
-- only applies if pending[player].Token still matches the token captured when
-- the prompt was issued (otherwise a second loss could double-restore).
local pending = {}

local function clearPending(player)
	pending[player] = nil
end

-- Called by IslandRespawnService once it has dropped the player's carried
-- lucky blocks and teleported them home. lostBlockIds is the array returned by
-- IslandBrainrotSpawner's DropCarriedLuckyOnFall bindable.
function LostBrainrotService.RegisterLoss(player, lostBlockIds)
	if not player or not lostBlockIds or #lostBlockIds == 0 then return end

	local token = tostring(os.clock()) .. "_" .. tostring(math.random(1000, 9999))
	local expireAt = os.time() + RECOVERY_WINDOW

	pending[player] = {
		Blocks = lostBlockIds,
		ExpireAt = expireAt,
		Token = token,
	}

	ShowEvent:FireClient(player, {
		Blocks = lostBlockIds,
		ExpireAt = expireAt,
		Token = token,
	})

	-- Auto-expire: if the player neither pays nor presses Give Up within the
	-- window the loss is finalized and the modal is hidden client-side.
	task.delay(RECOVERY_WINDOW + 1, function()
		local current = pending[player]
		if current and current.Token == token then
			pending[player] = nil
			if player.Parent then
				HideEvent:FireClient(player)
			end
		end
	end)
end

-- Called by PurchaseService when the player completes the dev-product
-- purchase. Adds every block back into the player's inventory via the same
-- LuckyBlockService.AddLuckyBlock used by the world carry-deposit path so the
-- hotbar / inventory updates flow normally.
function LostBrainrotService.OnRecoveryPurchase(player, token)
	local current = pending[player]
	if not current then return false end
	if token and current.Token ~= token then return false end
	if current.ExpireAt and os.time() > current.ExpireAt then
		pending[player] = nil
		if player.Parent then HideEvent:FireClient(player) end
		return false
	end

	local blocks = current.Blocks
	pending[player] = nil

	for _, luckyBlockId in ipairs(blocks) do
		LuckyBlockService.AddLuckyBlock(player, luckyBlockId, 1)
	end

	if player.Parent then HideEvent:FireClient(player) end
	return true
end

function LostBrainrotService.GetPendingToken(player)
	local current = pending[player]
	return current and current.Token or nil
end

local function onGiveUp(player)
	clearPending(player)
end

function LostBrainrotService.Init()
	GiveUpEvent.OnServerEvent:Connect(onGiveUp)
	Players.PlayerRemoving:Connect(clearPending)
end

return LostBrainrotService
