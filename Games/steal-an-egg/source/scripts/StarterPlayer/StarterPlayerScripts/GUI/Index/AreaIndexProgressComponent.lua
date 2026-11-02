local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Asserts = require(ReplicatedStorage.Library.Asserts)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Gears = require(ReplicatedStorage.Directory.Gears)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Types.Interface)

local AreaIndexProgressComponent = {}
AreaIndexProgressComponent.__index = AreaIndexProgressComponent
AreaIndexProgressComponent.__class = "AreaIndexProgressComponent"

local EQUIPPED_COLOR = Color3.fromRGB(0, 182, 24)
local PROGRESS_TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function AreaIndexProgressComponent.new(view, onAction)
	local self = setmetatable({}, AreaIndexProgressComponent)

	self._view = view
	self._onAction = onAction
	self._sectionId = nil
	self._actionEnabled = false

	self._defaultEquipBatButtonColor = view.EquipBat.TextButton.BackgroundColor3
	self._defaultEquipBatButtonText = view.EquipBat.TextLabelFrame.TextLabel.Text

	self._progressTween = nil
	self._trove = Trove.new()

	self:_init()

	return self
end

function AreaIndexProgressComponent:_setProgress(progressFraction)
	if self._progressTween then
		self._progressTween:Cancel()
		self._progressTween:Destroy()
	end

	self._progressTween = TweenService:Create(self._view.ProgressBar.Progress.Fill, PROGRESS_TWEEN_INFO, {
		Size = UDim2.fromScale(progressFraction, 1)
	})

	self._progressTween:Play()
end

function AreaIndexProgressComponent:_render(sectionId, gearId, currentProgress, maxProgress, buttonText, useEquipColor, showBadge, actionEnabled)
	Asserts.string(sectionId)
	Asserts.string(gearId)
	Asserts.number(currentProgress)
	Asserts.number(maxProgress)
	Asserts.string(buttonText)
	Asserts.boolean(useEquipColor)
	Asserts.boolean(showBadge)
	Asserts.boolean(actionEnabled)

	self._sectionId = sectionId
	self._actionEnabled = actionEnabled

	local view = self._view
	local gearData = Gears.Directory[gearId]

	local isComplete = (maxProgress > 0) and (currentProgress >= maxProgress)
	local progressFraction = (maxProgress == 0) and 0 or math.clamp(currentProgress / maxProgress, 0, 1)

	view.ProgressBar.ProgressText.TextLabel.Text = ("%s/%s"):format(currentProgress, maxProgress)
	view.ProgressBar.BatImage.Image = gearData.Icon

	view.EquipBat.BatImage.Image = gearData.Icon
	view.EquipBat.TextButton.BackgroundColor3 = useEquipColor and EQUIPPED_COLOR or self._defaultEquipBatButtonColor
	view.EquipBat.TextLabelFrame.TextLabel.Text = buttonText

	view.ProgressBar.Visible = not isComplete
	view.EquipBat.Visible = isComplete
	view.EquipBat.NotificationBadge.Visible = isComplete and showBadge

	self:_setProgress(progressFraction)
end

function AreaIndexProgressComponent:RenderAreaBat(sectionId, gearId, currentProgress, maxProgress, hasClaimed, isEquipped)
	Asserts.string(sectionId)
	Asserts.string(gearId)
	Asserts.number(currentProgress)
	Asserts.number(maxProgress)
	Asserts.boolean(hasClaimed)
	Asserts.boolean(isEquipped)

	local buttonText = isEquipped and "Equipped" or self._defaultEquipBatButtonText

	self:_render(sectionId, gearId, currentProgress, maxProgress, buttonText, isEquipped, not hasClaimed, not isEquipped)
end

function AreaIndexProgressComponent:RenderGearClaim(sectionId, gearId, currentProgress, maxProgress, hasClaimed)
	Asserts.boolean(hasClaimed)

	local buttonText = hasClaimed and "CLAIMED!" or "CLAIM!"

	self:_render(sectionId, gearId, currentProgress, maxProgress, buttonText, hasClaimed, not hasClaimed, not hasClaimed)
end

function AreaIndexProgressComponent:Destroy()
	if self._progressTween then
		self._progressTween:Cancel()
		self._progressTween:Destroy()
		self._progressTween = nil
	end

	self._trove:Destroy()
end

function AreaIndexProgressComponent:_init()
	self._trove:Add(ButtonFX(self._view.EquipBat, nil, function()
		if self._sectionId == nil or not self._actionEnabled then
			return
		end

		self._onAction(self._sectionId)
	end))
end

return AreaIndexProgressComponent