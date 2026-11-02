local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

require(ReplicatedStorage.Library.Types.AssetItem)

local AssetItemUtil = require(ReplicatedStorage.Library.Util.AssetItemUtil)
local AssetOddsDisplay = require(ReplicatedStorage.Library.Util.AssetOddsDisplay)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local AreaIndexProgressComponent = require(script.AreaIndexProgressComponent)
local Areas = require(ReplicatedStorage.Directory.Areas)
local Assets = require(ReplicatedStorage.Directory.Assets)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local ClaimRewardPanel = require(script.ClaimRewardPanel)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local GetOrCreateUIScale = require(ReplicatedStorage.Library.Functions.GetOrCreateUIScale)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local GradientSwap = require(ReplicatedStorage.Library.Functions.GradientSwap)

require(script.Types.Interface)

local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)
local LimitedEgg = require(ReplicatedStorage.Directory.LimitedEgg)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Save = require(ReplicatedStorage.Library.Client.Save)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local AutoGridLayout = require(ReplicatedStorage.Library.Client.AutoGridLayout)
local UpdateTextAndShadow = require(ReplicatedStorage.Library.Functions.UpdateTextAndShadow)

local IndexController = {}
IndexController.__index = IndexController
IndexController.__class = "IndexController"

-- Constants
local IndexNetworkEvents = Network.NET_MAP.Index
local PAGES = { "Base" }

local OUTLINE_LOCKED_COLOR = Color3.fromRGB(255, 55, 55)
local OUTLINE_UNLOCKED_COLOR = Color3.fromRGB(255, 255, 255)
local HIDDEN_ICON_COLOR = Color3.fromRGB(0, 0, 0)

local PROGRESS_TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local PULSE_TWEEN_INFO = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local GRID_PADDING = UDim2.fromOffset(0, 0)

local logger = Log.new()
local actionLock = Lock()

-- UI References
local IndexUI = GUI.Index().Index
local SideButton = GUI.SideButtonTools().Index.Button
local SideNotificationBadge = SideButton.NotificationBadge
local SideBadgeText = SideNotificationBadge.Frame.BadgeFrame.TextLabelFrame.TextLabel

local IndexPage = IndexUI.Content.IndexPage
local IndexEntriesList = IndexPage.IndexListFrame.IndexEntries
local SectionTemplate = IndexEntriesList.Template
local LimitedEggSeparation = IndexEntriesList.LimitedEggSeparation

local IndexInfoFrame = IndexPage.IndexInfoFrame
local InfoImageLabel = IndexInfoFrame.Icon.ImageLabel
local InfoMutationIcon = IndexInfoFrame.Icon.MutationIcon
local InfoNameText = IndexInfoFrame.DisplayName.TextLabel
local InfoRarityText = IndexInfoFrame.Rarity.TextLabel
local InfoOddsText = IndexInfoFrame.RarityOdds.TextLabel
local InfoOddsGradient = InfoOddsText.UIGradient
local InfoEarningText = IndexInfoFrame.EarningRate.TextLabel
local InfoRarityGlow = IndexInfoFrame.Frame.RarityGlow
local InfoRarityStroke = InfoRarityGlow.UIStroke

local IndexRewardsFrame = IndexPage.IndexRewardsFrame
local ClaimButton = IndexRewardsFrame.ClaimButton
local ClaimAllButton = IndexPage.ClaimAllButton
local ClaimAllGradient = ClaimAllButton.TextButton.UIGradient

local ProgressBar = IndexPage.ProgressBar
local ProgressText = ProgressBar.ProgressText.TextLabel
local ProgressFill = ProgressBar.Progress.Fill


function IndexController._build()
	local self = setmetatable({}, IndexController)

	self._trove = Trove.new()
	self._openTrove = nil
	self._sections = {}
	self._sectionsByPage = {}
	self._currentPage = "Base"
	self._selectedCategory = nil
	self._isOpen = false
	self._indexNotificationTween = nil

	self:_buildEntries()
	self:_init()

	return self
end

function IndexController:_buildEntries()
	for _, pageName in ipairs(PAGES) do
		self._sectionsByPage[pageName] = {}
	end

	-- Build entries from Areas Directory
	for areaId, areaData in pairs(Areas.Directory) do
		for _, pageName in ipairs(PAGES) do
			local entries = {}

			for _, dropData in pairs(areaData.DropTable) do
				local categoryId = dropData[1]
				local dropWeight = dropData[2]
				local assetConfig = Assets.Directory[categoryId]

				if dropWeight > 0 and assetConfig.DontRoll ~= true then
					table.insert(entries, {
						Category = categoryId,
						Config = assetConfig,
						ItemData = {
							Scale = 1,
							HasBeenFirstPlaced = true,
							Category = categoryId,
							Mutations = {},
							Personality = Personalities.Personalities.Normal
						}
					})
				end
			end

			table.sort(entries, function(entryA, entryB)
				local rarityNumA = entryA.Config.Rarity.RarityNumber
				local rarityNumB = entryB.Config.Rarity.RarityNumber

				if rarityNumA == rarityNumB then
					if entryA.Config.DropWeight == entryB.Config.DropWeight then
						return entryA.Category < entryB.Category
					end
					return entryA.Config.DropWeight > entryB.Config.DropWeight
				end

				return rarityNumA < rarityNumB
			end)

			if #entries > 0 then
				table.insert(self._sectionsByPage[pageName], {
					RewardKind = "AreaBat",
					SectionId = areaId,
					DisplayName = areaData.DisplayName,
					Icon = areaData.Icon,
					HeaderGradient = areaData.Rarity.Gradient,
					SortOrder = areaData.Rarity.RarityNumber,
					RewardGearId = areaData.IndexBatGearId,
					Entries = entries
				})
			end
		end
	end

	-- Sort sections
	for _, pageName in ipairs(PAGES) do
		table.sort(self._sectionsByPage[pageName], function(sectionA, sectionB)
			if sectionA.SortOrder == sectionB.SortOrder then
				return sectionA.SectionId < sectionB.SectionId
			end
			return sectionA.SortOrder < sectionB.SortOrder
		end)
	end

	-- Add Limited Egg entries
	for _, pageName in ipairs(PAGES) do
		local limitedEntries = {}

		for _, eggData in ipairs(LimitedEgg.Entries) do
			local assetId = eggData.AssetId

			table.insert(limitedEntries, {
				Category = assetId,
				Config = Assets.Directory[assetId],
				ItemData = {
					Scale = 1,
					HasBeenFirstPlaced = true,
					Category = assetId,
					Mutations = {},
					Personality = Personalities.Personalities.Normal
				}
			})
		end

		table.sort(limitedEntries, function(entryA, entryB)
			if entryA.Config.Rarity.RarityNumber == entryB.Config.Rarity.RarityNumber then
				return entryA.Category < entryB.Category
			end
			return entryA.Config.Rarity.RarityNumber < entryB.Config.Rarity.RarityNumber
		end)

		table.insert(self._sectionsByPage[pageName], {
			SectionId = "LimitedEgg",
			DisplayName = "",
			Icon = "rbxassetid://70476079280223",
			HeaderGradient = nil,
			SortOrder = math.huge,
			RewardKind = "GearClaim",
			RewardGearId = "BeeLauncher",
			Entries = limitedEntries
		})
	end
end

function IndexController:_getSave()
	return Save.Get()
end

function IndexController:_isDiscovered(entry)
	local saveData = self:_getSave()
	if saveData == nil then return false end

	return saveData.Index[entry.Category] == true
end

function IndexController:_isClaimed(entry)
	local saveData = self:_getSave()
	if saveData == nil then return false end

	return saveData.IndexClaimedCategories[entry.Category] == true
end

function IndexController:_isClaimable(entry)
	return self:_isDiscovered(entry) and not self:_isClaimed(entry)
end

function IndexController:_getEntryDisplayName(entry)
	return ItemDisplay.GetNameFromItemData(entry.ItemData)
end

function IndexController:_getEntryByCategory(categoryId)
	if categoryId == nil then return nil end

	for _, section in ipairs(self._sectionsByPage[self._currentPage]) do
		for _, entry in ipairs(section.Entries) do
			if entry.Category == categoryId then
				return entry
			end
		end
	end

	return nil
end

function IndexController:_stopIndexNotificationPulse()
	if self._indexNotificationTween == nil then
		GetOrCreateUIScale(SideNotificationBadge).Scale = 1
		return
	end

	self._indexNotificationTween:Cancel()
	self._indexNotificationTween:Destroy()
	self._indexNotificationTween = nil
	GetOrCreateUIScale(SideNotificationBadge).Scale = 1
end

function IndexController:_startIndexNotificationPulse()
	if self._indexNotificationTween == nil then
		local uiScale = GetOrCreateUIScale(SideNotificationBadge)
		uiScale.Scale = 0.8

		self._indexNotificationTween = TweenService:Create(uiScale, PULSE_TWEEN_INFO, {
			Scale = 1.2
		})
		self._indexNotificationTween:Play()
	end
end

function IndexController:_setBadge(badgeUI, badgeTextUI, count, doPulse)
	local hasCount = count > 0

	badgeUI.Visible = hasCount
	badgeTextUI.Text = tostring(count)

	if not doPulse then return end

	if hasCount then
		self:_startIndexNotificationPulse()
	else
		self:_stopIndexNotificationPulse()
	end
end

function IndexController:_renderHiddenIcon(imageLabel)
	imageLabel.ImageColor3 = HIDDEN_ICON_COLOR
	imageLabel.ImageTransparency = 0.35
end

function IndexController:_renderVisibleIcon(imageLabel)
	imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel.ImageTransparency = 0
end

function IndexController:_applyRarityGradient(gradientUI, rarityGradient)
	gradientUI.Color = rarityGradient.Color
	gradientUI.Rotation = rarityGradient.Rotation
	gradientUI.Transparency = rarityGradient.Transparency
	gradientUI.Offset = rarityGradient.Offset
end

function IndexController:_renderRarityOddsGradient(rarityGradient)
	self:_applyRarityGradient(InfoOddsGradient, rarityGradient)
end

function IndexController:_renderEntryIcon(imageLabel, entry, isDiscovered)
	imageLabel.Image = Assets.Directory[entry.Category].Icon or ""

	if isDiscovered then
		self:_renderVisibleIcon(imageLabel)
	else
		self:_renderHiddenIcon(imageLabel)
	end
end

function IndexController:_ensureSectionPool(requiredCount)
	if self._openTrove == nil then return end

	while #self._sections < requiredCount do
		local sectionClone = SectionTemplate:Clone()
		sectionClone.Name = ("IndexArea%d"):format(#self._sections + 1)
		sectionClone.Visible = false
		sectionClone.Parent = IndexEntriesList
		sectionClone.Main.Template.Visible = false

		local sectionData = {
			Section = nil,
			Frame = sectionClone,
			Slots = {},
			ProgressComponent = AreaIndexProgressComponent.new(sectionClone.Frame, function(sectionId)
				actionLock(function()
					if sectionId == "LimitedEgg" then
						self:_claimLimitedEggReward()
					else
						self:_equipAreaBat(sectionId)
					end
				end)
			end)
		}

		sectionData.GridUpdater = AutoGridLayout(sectionClone.Main, {
			{
				ResolutionThreshold = math.huge,
				PerRow = 4,
				Padding = GRID_PADDING
			}
		})

		table.insert(self._sections, sectionData)
		self._openTrove:Add(sectionClone)
		self._openTrove:Add(function()
			sectionData.ProgressComponent:Destroy()
		end)
	end
end

function IndexController:_ensureSlotPool(sectionData, requiredCount)
	if self._openTrove == nil then return end

	while #sectionData.Slots < requiredCount do
		local slotClone = sectionData.Frame.Main.Template:Clone()
		slotClone.Name = ("IndexEntry%d"):format(#sectionData.Slots + 1)
		slotClone.Visible = false
		slotClone.Parent = sectionData.Frame.Main

		local slotData = {
			Entry = nil,
			Frame = slotClone
		}
		table.insert(sectionData.Slots, slotData)

		local clickConnection = ButtonFX(slotClone.Button, nil, function()
			local entry = slotData.Entry
			if entry ~= nil and self._selectedCategory ~= entry.Category then
				self:_selectEntry(entry.Category)
			end
		end)

		self._openTrove:Add(clickConnection)
		self._openTrove:Add(ButtonFX(slotClone.Button))
		self._openTrove:Add(slotClone)
	end
end

function IndexController:_renderSlot(slotData, entry)
	local frame = slotData.Frame
	slotData.Entry = entry

	if entry == nil then
		frame.Visible = false
		return
	end

	local isDiscovered = self:_isDiscovered(entry)
	local isClaimed = self:_isClaimed(entry)

	frame.Visible = true
	frame.Name = entry.Category
	frame.Button.TextLabelFrame.TextLabel.Text = AssetOddsDisplay.GetDisplayForItemData(entry.Config, entry.ItemData, false)

	GradientSwap(frame, entry.Config.Rarity.Gradient)
	self:_renderEntryIcon(frame.Button.Icon.ImageLabel, entry, isDiscovered)
	frame.Button.MutationIcon.Visible = false

	if isDiscovered then
		local displayName = self:_getEntryDisplayName(entry)
		UpdateTextAndShadow(frame.DisplayName.TextLabel, displayName)
		frame.DisplayName.DropShadow.Text = displayName
	else
		UpdateTextAndShadow(frame.DisplayName.TextLabel, "???")
		frame.DisplayName.DropShadow.Text = "???"
	end

	local isClaimableNow = isDiscovered and not isClaimed
	local showOutline = self._selectedCategory == entry.Category or isClaimableNow

	frame.Outline.Visible = showOutline
	frame.Outline.ImageColor3 = isClaimableNow and OUTLINE_LOCKED_COLOR or OUTLINE_UNLOCKED_COLOR
end

function IndexController:_renderSlots()
	local activeSections = self._sectionsByPage[self._currentPage]

	self:_ensureSectionPool(#activeSections)
	LimitedEggSeparation.Visible = #activeSections > 0
	LimitedEggSeparation.LayoutOrder = #activeSections

	for index, sectionData in ipairs(self._sections) do
		local activeSection = activeSections[index]
		sectionData.Section = activeSection

		if activeSection == nil then
			sectionData.Frame.Visible = false
			for _, slotData in ipairs(sectionData.Slots) do
				self:_renderSlot(slotData, nil)
			end
			continue
		end

		sectionData.Frame.Visible = true
		sectionData.Frame.Name = activeSection.SectionId
		sectionData.Frame.LayoutOrder = activeSection.RewardKind == "GearClaim" and (index + 1) or index
		sectionData.Frame.Frame.TextLabel.Text = activeSection.DisplayName

		if activeSection.HeaderGradient ~= nil then
			GradientSwap(sectionData.Frame.Frame.TextLabel, activeSection.HeaderGradient)
		end

		sectionData.Frame.Frame.Image.Image = activeSection.Icon

		local discoveredCount = 0
		for _, entry in activeSection.Entries do
			if self:_isDiscovered(entry) then
				discoveredCount = discoveredCount + 1
			end
		end

		local saveData = self:_getSave()
		local ownsReward = saveData and (saveData.GearInventory[activeSection.RewardGearId] or 0) > 0 or false
		local hasVisited = saveData and saveData.VisitedGears[activeSection.RewardGearId] == true or false

		if activeSection.RewardKind == "AreaBat" then
			sectionData.ProgressComponent:RenderAreaBat(activeSection.SectionId, activeSection.RewardGearId, discoveredCount, #activeSection.Entries, hasVisited, ownsReward)
		else
			sectionData.ProgressComponent:RenderGearClaim(activeSection.SectionId, activeSection.RewardGearId, discoveredCount, #activeSection.Entries, ownsReward)
		end

		self:_ensureSlotPool(sectionData, #activeSection.Entries)

		for slotIndex, slotData in ipairs(sectionData.Slots) do
			self:_renderSlot(slotData, activeSection.Entries[slotIndex])
		end
	end

	self:_updateIndexEntriesGridLayout()

	task.delay(0.2, function()
		if not self._isOpen then return end
		self:_updateIndexEntriesGridLayout()
	end)
end

function IndexController:_updateIndexEntriesGridLayout()
	for _, sectionData in ipairs(self._sections) do
		if sectionData.Frame.Visible and sectionData.GridUpdater ~= nil then
			sectionData.GridUpdater()
		end
	end
end

function IndexController:_selectEntry(categoryId)
	self._selectedCategory = categoryId
	self:_renderSlots()
	self:_renderInfo()
	self:_renderRewards()
end

function IndexController:_selectDefaultEntry()
	if self:_getEntryByCategory(self._selectedCategory) ~= nil then
		return
	end

	for _, section in ipairs(self._sectionsByPage[self._currentPage]) do
		local firstEntry = section.Entries[1]
		if firstEntry ~= nil then
			self._selectedCategory = firstEntry.Category
			return
		end
	end
end

function IndexController:_renderInfo()
	local entry = self:_getEntryByCategory(self._selectedCategory)
	if entry == nil then return end

	local isDiscovered = self:_isDiscovered(entry)

	self:_renderEntryIcon(InfoImageLabel, entry, isDiscovered)
	InfoMutationIcon.Visible = false
	InfoRarityText.Text = entry.Config.Rarity._id
	InfoOddsText.Text = AssetOddsDisplay.GetDisplayForItemData(entry.Config, entry.ItemData, false)
	self:_renderRarityOddsGradient(entry.Config.Rarity.Gradient)

	InfoRarityGlow.BackgroundColor3 = entry.Config.Rarity.Color
	InfoRarityStroke.Color = entry.Config.Rarity.Color

	if isDiscovered then
		UpdateTextAndShadow(InfoNameText, self:_getEntryDisplayName(entry))
		InfoEarningText.Text = "$" .. Simple.FormatCompact(AssetItemUtil.GetIndexMoneyRewardAmount(entry.Category) / 100, ".#") .. "/s"
	else
		UpdateTextAndShadow(InfoNameText, "???")
		InfoEarningText.Text = "???"
	end
end

function IndexController:_renderRewards()
	local entry = self:_getEntryByCategory(self._selectedCategory)
	local isClaimed = entry ~= nil and self:_isClaimed(entry) or false
	local isClaimable = entry ~= nil and self:_isClaimable(entry) or false

	ClaimRewardPanel.Render(IndexRewardsFrame, entry, isClaimed, isClaimable)
end

function IndexController:_countUnclaimedByPage(pageName)
	local count = 0
	for _, section in ipairs(self._sectionsByPage[pageName]) do
		for _, entry in ipairs(section.Entries) do
			if self:_isClaimable(entry) then
				count = count + 1
			end
		end
	end
	return count
end

function IndexController:_countDiscoveredByPage(pageName)
	local count = 0
	for _, section in ipairs(self._sectionsByPage[pageName]) do
		for _, entry in ipairs(section.Entries) do
			if self:_isDiscovered(entry) then
				count = count + 1
			end
		end
	end
	return count
end

function IndexController:_countEntriesByPage(pageName)
	local sum = 0
	for _, section in ipairs(self._sectionsByPage[pageName]) do
		sum = sum + #section.Entries
	end
	return sum
end

function IndexController:_renderProgressAndBadges()
	local totalEntries = self:_countEntriesByPage(self._currentPage)
	local discoveredEntries = self:_countDiscoveredByPage(self._currentPage)

	local totalUnclaimed = 0
	for _, pageName in ipairs(PAGES) do
		totalUnclaimed = totalUnclaimed + self:_countUnclaimedByPage(pageName)
	end

	self:_setBadge(SideNotificationBadge, SideBadgeText, totalUnclaimed, true)
	self:_setBadge(ClaimAllButton.NotificationBadge, ClaimAllButton.NotificationBadge.Frame.BadgeFrame.TextLabelFrame.TextLabel, totalUnclaimed, false)

	ClaimAllButton.Visible = totalUnclaimed > 0
	ProgressBar.Visible = totalUnclaimed == 0
	ClaimAllGradient.Enabled = totalUnclaimed > 0

	ProgressText.Text = ("%d/%d"):format(discoveredEntries, totalEntries)

	local progressFraction = totalEntries == 0 and 0 or math.clamp(discoveredEntries / totalEntries, 0, 1)
	TweenService:Create(ProgressFill, PROGRESS_TWEEN_INFO, {
		Size = UDim2.fromScale(progressFraction, 1)
	}):Play()
end

function IndexController:_render()
	if self._isOpen then
		self:_selectDefaultEntry()
		self:_renderSlots()
		self:_renderInfo()
		self:_renderRewards()
	end

	self:_renderProgressAndBadges()
end

function IndexController:_open()
	if not self._isOpen then
		self._isOpen = true
		self._currentPage = "Base"
		self._selectedCategory = nil
		self._openTrove = Trove.new()
		self:_render()
	end
end

function IndexController:_close()
	self._isOpen = false
	self._currentPage = "Base"
	self._selectedCategory = nil
	LimitedEggSeparation.Visible = false

	if self._openTrove ~= nil then
		self._openTrove:Destroy()
		self._openTrove = nil
	end

	table.clear(self._sections)
	self:_render()
end

function IndexController:_processClaimResults(claimedData)
	if claimedData == nil then return end

	for _, result in ipairs(claimedData) do
		Save.ProcessManualTableKeyChange("IndexClaimedCategories", result.Category, true)
	end
end

function IndexController:_claimSelected()
	local entry = self:_getEntryByCategory(self._selectedCategory)

	if entry == nil or not self:_isClaimable(entry) then return end

	local success, errorMessage, claimedData = Network.Invoke(IndexNetworkEvents.REQUEST_CLAIM, entry.Category)

	if success then
		self:_processClaimResults(claimedData)
		self:Refresh()
	else
		logger:AtWarning():Log(("[Index] Claim failed: %s"):format(tostring(errorMessage)))
	end
end

function IndexController:_claimAll()
	local success, errorMessage, claimedData = Network.Invoke(IndexNetworkEvents.REQUEST_CLAIM_ALL)

	if success then
		self:_processClaimResults(claimedData)
		self:Refresh()
	else
		logger:AtWarning():Log(("[Index] Claim all failed: %s"):format(tostring(errorMessage)))
	end
end

function IndexController:_equipAreaBat(sectionId)
	local success, errorMessage = Network.Invoke(IndexNetworkEvents.REQUEST_EQUIP_AREA_BAT, sectionId)

	if success then
		self:Refresh()
	else
		logger:AtWarning():Log(("[Index] Equip area bat failed: %s"):format(tostring(errorMessage)))
	end
end

function IndexController:_claimLimitedEggReward()
	local success, errorMessage = Network.Invoke(IndexNetworkEvents.REQUEST_CLAIM_LIMITED_EGG_REWARD)

	if success then
		self:Refresh()
	else
		logger:AtWarning():Log(("[Index] Limited Egg reward claim failed: %s"):format(tostring(errorMessage)))
	end
end

function IndexController:Refresh()
	self:_render()
end

function IndexController:_init()
	IndexUI.MutationsTab.Visible = false
	SectionTemplate.Visible = false
	SectionTemplate.Main.Template.Visible = false
	LimitedEggSeparation.Visible = false

	self._trove:Add(ButtonFX(SideButton, nil, function()
		TabController.ToggleTab("Index")
	end))

	self._trove:Add(ButtonFX(ClaimButton, nil, function()
		self:_claimSelected()
	end))

	self._trove:Add(ButtonFX(ClaimAllButton, nil, function()
		self:_claimAll()
	end))

	self._trove:Add(Save.ConnectForDataChanged({ "Index", "IndexClaimedCategories", "VisitedGears", "GearInventory" }, function()
		self:Refresh()
	end))

	self._trove:Connect(TabController.Opened, function(tabName)
		if tabName ~= "Index" then return end
		self:_open()
	end)

	self._trove:Connect(TabController.Closed, function(tabName)
		if tabName ~= "Index" then return end
		self:_close()
	end)

	self:_render()
end

return IndexController._build()