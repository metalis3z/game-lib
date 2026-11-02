-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ReplicatedStorage/Source/Controllers/CashDisplayController.lua  (luau, 294 lines)
-- Categories: ui-animation 13.2, utility 9.8
-- What it does: Count-up currency display: exponential lerp of the displayed value toward the real value each frame (only rewriting Text when it changes) plus a Size pulse on change.
-- Excerpt of lines 63-129 (rest of the file is game-specific wiring)

local function pulseLabel(label, originalSize)
	if not label then return end
	local scaleUp = UDim2.new(
		originalSize.X.Scale * 1.12, originalSize.X.Offset,
		originalSize.Y.Scale * 1.12, originalSize.Y.Offset
	)
	TweenService:Create(label, PULSE_INFO, { Size = scaleUp }):Play()
	task.delay(0.15, function()
		if label and label.Parent then
			TweenService:Create(label, PULSE_BACK_INFO, { Size = originalSize }):Play()
		end
	end)
end

local function getCashPerSec(baseCashPerSec, level)
	if level <= 1 then return baseCashPerSec end

	local levelIndex = level - 1

	return baseCashPerSec + (baseCashPerSec * CPS_BONUS_PERCENT * levelIndex)
end

local function recalcTotalIncome()
	local sum = 0
	for _, data in pairs(podiumData) do
		sum = sum + (data.CashPerSec or 0)
	end
	totalIncome = sum * rebirthMultiplier * getCashBoostMultiplier()
end


local function updateDisplays(dt)
	if cashLabel then
		if displayedCash ~= currentCash then
			local diff = currentCash - displayedCash
			local step = diff * math.min(1, LERP_SPEED * dt)
			if math.abs(diff) < 1 then
				displayedCash = currentCash
			else
				displayedCash = displayedCash + step
			end
		end
			local newText = "$" .. FormatUtils.Abbreviate(math.floor(displayedCash))
		if newText ~= lastCashText then
			cashLabel.Text = newText
			if cashLabelInner then cashLabelInner.Text = newText end
			lastCashText = newText
		end
	end

	if incomeLabel then
		if displayedIncome ~= totalIncome then
			local diff = totalIncome - displayedIncome
			local step = diff * math.min(1, INCOME_LERP_SPEED * dt)
			if math.abs(diff) < 0.01 then
				displayedIncome = totalIncome
			else
				displayedIncome = displayedIncome + step
			end
		end
		local newText = "$" .. FormatUtils.Abbreviate(displayedIncome) .. "/s"
		if newText ~= lastIncomeText then
			incomeLabel.Text = newText
			lastIncomeText = newText
		end
	end
end