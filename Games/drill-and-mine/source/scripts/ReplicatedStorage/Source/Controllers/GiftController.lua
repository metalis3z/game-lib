-- GiftController
-- Client half of player-to-player gifting. While the local player is holding
-- something giftable -- an equipped lucky block / loot item (EquippedItem) or
-- a claimed rarity-loot Tool (RarityLootTool attribute), never the drill --
-- every other player's character carries a local-only hold-3s "Gift"
-- ProximityPrompt on its HumanoidRootPart. Triggering it fires GiftRequest at
-- GiftService, which re-derives the held item server-side and transfers it.
-- GiftResult payloads become the green/red toasts for both players.
--
-- The prompts are created on THIS client only (never replicated), so each
-- player sees Gift prompts on others exactly while they themselves hold a
-- giftable object -- per-viewer visibility without any server bookkeeping.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local NotificationsController = require(ReplicatedStorage.Source.Controllers.NotificationsController)

local GiftController = {}

local player = Players.LocalPlayer

local HOLD_SECONDS = 3
local PROMPT_DISTANCE = 8
local PROMPT_LIFT_STUDS = 2 -- WorldOffsetY: float the widget above the HRP, not in the torso

local equippedLuckyName = nil -- display name while a lucky block / loot item is equipped
local heldLootToolName = nil  -- display name while a claimed rarity-loot Tool is equipped
local prompts = {} -- [otherPlayer] = ProximityPrompt (dies with their character)

-- Tool first: EquipVisualController hides the held-block visual while any
-- Tool is out, so the tool is what's actually in the giver's hand. Matches
-- GiftService's server-side priority.
local function currentGiftName()
	return heldLootToolName or equippedLuckyName
end

local function refreshPrompts()
	local giftName = currentGiftName()
	for otherPlayer, prompt in pairs(prompts) do
		if prompt.Parent then
			prompt.Enabled = giftName ~= nil
			prompt.ObjectText = giftName or ""
		else
			prompts[otherPlayer] = nil
		end
	end
end

-- ---------------------------------------------------------------------
-- Gift prompts on other players
-- ---------------------------------------------------------------------

local GiftRequestEvent -- resolved in Init before any prompt can exist

local function attachPrompt(otherPlayer, character)
	local hrp = character:WaitForChild("HumanoidRootPart", 10)
	if not hrp then return end
	if otherPlayer.Parent ~= Players or otherPlayer.Character ~= character then return end

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "GiftPrompt"
	prompt.ActionText = "Gift"
	prompt.ObjectText = currentGiftName() or ""
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.HoldDuration = HOLD_SECONDS
	prompt.MaxActivationDistance = PROMPT_DISTANCE
	prompt.RequiresLineOfSight = false
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt:SetAttribute("WorldOffsetY", PROMPT_LIFT_STUDS)
	prompt.Enabled = currentGiftName() ~= nil
	prompt.Parent = hrp

	prompt.Triggered:Connect(function()
		if currentGiftName() == nil then return end
		GiftRequestEvent:FireServer(otherPlayer)
	end)

	prompts[otherPlayer] = prompt
end

local function watchPlayer(otherPlayer)
	if otherPlayer == player then return end
	otherPlayer.CharacterAdded:Connect(function(character)
		task.spawn(attachPrompt, otherPlayer, character)
	end)
	if otherPlayer.Character then
		task.spawn(attachPrompt, otherPlayer, otherPlayer.Character)
	end
end

-- ---------------------------------------------------------------------
-- What is the local player holding?
-- ---------------------------------------------------------------------

local function onEquippedItemUpdate(summary)
	local itemId = summary and summary.ItemId or ""
	local cfg = nil
	if itemId ~= "" and summary.ItemType == "LuckyBlock" then
		cfg = GameConfig.LuckyBlocks[itemId]
	end
	equippedLuckyName = cfg and (cfg.DisplayName or itemId) or nil
	refreshPrompts()
end

local function watchOwnCharacter(character)
	local function check()
		local toolName = nil
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("RarityLootTool") then
				toolName = child.Name
				break
			end
		end
		heldLootToolName = toolName
		refreshPrompts()
	end
	character.ChildAdded:Connect(check)
	character.ChildRemoved:Connect(check)
	check()
end

-- ---------------------------------------------------------------------
-- Result toasts
-- ---------------------------------------------------------------------

local function onGiftResult(payload)
	if type(payload) ~= "table" then return end
	if payload.Ok then
		local itemName = tostring(payload.ItemName or "item")
		local otherName = tostring(payload.OtherName or "someone")
		if payload.Role == "Giver" then
			NotificationsController.SendGreen("You gifted " .. itemName .. " to " .. otherName .. "!")
		else
			NotificationsController.SendGreen(otherName .. " gifted you " .. itemName .. "!")
		end
	elseif payload.Reason == "TooFar" then
		NotificationsController.SendRed("Too far away to gift!")
	end
end

function GiftController.Init()
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local giftRemotes = Remotes:WaitForChild("Gift") -- created by GiftService at startup
	GiftRequestEvent = giftRemotes:WaitForChild("GiftRequest")
	local giftResultEvent = giftRemotes:WaitForChild("GiftResult")
	local inventoryRemotes = Remotes:WaitForChild("InventoryService")
	local equippedItemUpdateEvent = inventoryRemotes:WaitForChild("EquippedItemUpdate")
	local requestEquippedItemFunc = inventoryRemotes:WaitForChild("RequestEquippedItem")

	equippedItemUpdateEvent.OnClientEvent:Connect(onEquippedItemUpdate)
	giftResultEvent.OnClientEvent:Connect(onGiftResult)

	Players.PlayerAdded:Connect(watchPlayer)
	for _, existing in ipairs(Players:GetPlayers()) do
		watchPlayer(existing)
	end
	Players.PlayerRemoving:Connect(function(leaving)
		prompts[leaving] = nil
	end)

	player.CharacterAdded:Connect(watchOwnCharacter)
	if player.Character then
		task.spawn(watchOwnCharacter, player.Character)
	end

	-- catch an item that was already equipped before this controller loaded
	task.spawn(function()
		local ok, summary = pcall(function()
			return requestEquippedItemFunc:InvokeServer()
		end)
		if ok and type(summary) == "table" then
			onEquippedItemUpdate(summary)
		end
	end)
end

return GiftController