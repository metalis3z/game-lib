local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)

-- Require for types/side-effects
require(ReplicatedStorage.Library.Types.ActiveAssets)

local AssetDnaProductResolver = require(ReplicatedStorage.AssetDnaProductResolver)
local AssetDnaRarityClassification = require(script.Parent.AssetDnaRarityClassification)
local AssetInteractionPromptAnchor = require(script.Parent.AssetInteractionPromptAnchor)
local AssetDnaStealPrompt = require(ReplicatedStorage.Library.Client.AssetDnaStealPrompt)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

local AssetDnaStealInteraction = {}
AssetDnaStealInteraction.__index = AssetDnaStealInteraction

--==============================--
-- Module Methods
--==============================--

function AssetDnaStealInteraction.new(ownerUserId, uid, itemData, model)
	Asserts.number(ownerUserId)
	Asserts.string(uid)
	Asserts.Model(model)
	assert(AssetItem.AssetItemData(itemData))

	local self = setmetatable({}, AssetDnaStealInteraction)

	self._trove = Trove.new()
	self._activate = nil
	self._prompt = nil
	self._suppressed = false

	local isLocalPlayer = ownerUserId == Players.LocalPlayer.UserId

	if not isLocalPlayer then
		local primaryPart = assert(model.PrimaryPart, ("Asset model %s must have a PrimaryPart"):format(model.Name))
		local promptAnchor = AssetInteractionPromptAnchor.Create(model, primaryPart)
		self._trove:Add(promptAnchor)

		local interactionPrompt = Instance.new("ProximityPrompt")
		interactionPrompt.Name = "AssetInteractionPrompt"
		interactionPrompt.HoldDuration = 0
		interactionPrompt.RequiresLineOfSight = false
		interactionPrompt.ObjectText = Assets.Directory[itemData.Category].DisplayName
		interactionPrompt.ActionText = '<font color="#FF0000">Steal</font> DNA 🧬'
		interactionPrompt.Parent = promptAnchor
		interactionPrompt.Style = Enum.ProximityPromptStyle.Custom
		interactionPrompt.MaxActivationDistance = 14
		self._prompt = interactionPrompt

		local actionLock = Lock()

		self._activate = function()
			actionLock(function()
				if itemData.IsStolenDNA == true then
					Message.Bottom({
						Message = "Cannot steal that pets DNA, this pets was already stolen from someone!",
						Time = 2,
						Color = Color3.fromRGB(255, 0, 0)
					})
					return
				end

				local productId = AssetDnaProductResolver.GetProductId(itemData)
				if productId == nil then
					Message.Bottom({
						Message = "This DNA steal product is not configured yet",
						Time = 2
					})
					return
				end

				local rarityNumber = Assets.Directory[itemData.Category].Rarity.RarityNumber
				local sizeRichText = AssetDnaRarityClassification.Resolve(itemData, rarityNumber).SizeRichText
				if AssetDnaStealPrompt.Prompt(itemData, sizeRichText) ~= true then
					return
				end

				local success, errorMessage = Network.Invoke(Network.NET_MAP.ActiveAssets.REQUEST_STEAL_TARGET, {
					ProductId = productId,
					OwnerUserId = ownerUserId,
					UID = uid
				})

				if success == true then
					PromptPurchase.Prompt(productId, true)
					return
				end

				Message.Bottom({
					Message = if typeof(errorMessage) == "string" then errorMessage else "Choose a valid pet to steal DNA from first.",
					Time = 2
				})
			end)
		end

		self._trove:Add(interactionPrompt.Triggered:Connect(function(player)
			if player == Players.LocalPlayer then
				self:Activate()
			end
		end))
	end

	return self
end

function AssetDnaStealInteraction.Activate(self)
	if not self._suppressed then
		assert(self._activate, "Cannot activate DNA steal interaction for the local player's asset")()
	end
end

function AssetDnaStealInteraction.SetSuppressed(self, isSuppressed)
	Asserts.boolean(isSuppressed)
	self._suppressed = isSuppressed

	local prompt = self._prompt
	if prompt == nil then
		return
	end

	prompt.Enabled = not isSuppressed
end

function AssetDnaStealInteraction.Destroy(self)
	self._trove:Destroy()
end

return AssetDnaStealInteraction