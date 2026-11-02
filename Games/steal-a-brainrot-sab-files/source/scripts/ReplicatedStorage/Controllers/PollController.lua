-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")

local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local Timer       = require(ReplicatedStorage.Packages.Timer)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local Spr         = require(ReplicatedStorage.Packages.Spr)
local Net         = require(ReplicatedStorage.Packages.Net)
local FFlags      = require(ReplicatedStorage.Packages.FFlags)

require(ReplicatedStorage.Shared.Poll)

local LocalPlayer = Players.LocalPlayer
local PollUI      = LocalPlayer.PlayerGui:WaitForChild("TopUI").Frame.Poll
local PollStore   = ReplicatorClient.get("Polls")

local SECRET_KEY   = "1931dcba-f6f9-4e8e-bb80-346e1b072674"
local OPTION_A_KEY = "571bdc6b-fedd-4c38-ab3a-1c3b2f28917b"
local OPTION_B_KEY = "5b86bb8d-0ee7-4a62-b929-523d73c82a93"

local RATE_SMOOTHING = 3.0
local NOISE_FACTOR   = 0.18
local UNDERSHOOT_GAP = 2
local MIN_RATE       = 0.4
local MIDDLE_TIER_SPEED = 12

return {
	["Start"] = function(_)
		local isPollVisible     = false
		local isShowingResults  = false
		local localVoteCooldown = false
		local activePollId      = nil

		local displayVotesA, displayVotesB = 0, 0
		local targetVotesA,  targetVotesB  = 0, 0
		local rateA,         rateB         = 0, 0

		local fakeVotesA, fakeVotesB = 0, 0

		local lastRoundedA, lastRoundedB = -1, -1

		local localVote       = nil
		local localVotePollId = nil

		local displayTier = tonumber(FFlags:GetInstant("PollDisplayTier", 2)) or 2
		FFlags:OnChange("PollDisplayTier", function(newVal)
			displayTier = tonumber(newVal) or 2
		end)

		local fill1Text = PollUI.Bar.Fill1Text
		local fill2Text = PollUI.Bar.Fill2Text

		PollUI.Visible = false


		local function updateBarAndText(roundA, roundB)
			fill1Text.Text = NumberUtils:Comma(roundA)
			fill2Text.Text = NumberUtils:Comma(roundB)

			local total = roundA + roundB
			local ratio = total == 0 and 0.5 or roundA / total
			Spr.target(PollUI.Bar.Fill.UIGradient, 1, 5, {
				Offset = Vector2.new(math.lerp(-0.5, 0.5, ratio), 0)
			})
		end

		local function updateButtonStates(pollData)
			local now = workspace:GetServerTimeNow()

			if pollData.endsAt <= now then
				Spr.target(PollUI.Buttons["1"].Disabled, 1, 5, { BackgroundTransparency = 0.5 })
				Spr.target(PollUI.Buttons["2"].Disabled, 1, 5, { BackgroundTransparency = 0.5 })
				return
			end

			local myVote = localVote

			if myVote then
				Spr.target(PollUI.Buttons["1"].Disabled, 1, 5,
					{ BackgroundTransparency = myVote == "A" and 1 or 0.5 })
				Spr.target(PollUI.Buttons["2"].Disabled, 1, 5,
					{ BackgroundTransparency = myVote == "B" and 1 or 0.5 })
			else
				Spr.target(PollUI.Buttons["1"].Disabled, 1, 5, { BackgroundTransparency = 1 })
				Spr.target(PollUI.Buttons["2"].Disabled, 1, 5, { BackgroundTransparency = 1 })
			end
		end

		local function clearPollState()
			isPollVisible    = false
			isShowingResults = false
			PollUI.Visible   = false
			activePollId     = nil
			localVote        = nil
			localVotePollId  = nil

			displayVotesA, displayVotesB = 0, 0
			targetVotesA,  targetVotesB  = 0, 0
			rateA,         rateB         = 0, 0
			fakeVotesA,    fakeVotesB    = 0, 0
			lastRoundedA,  lastRoundedB  = -1, -1
		end

		local function refreshUI()
			local activeId = PollStore:TryIndex({ "activePoll" })
			local pollData = activeId and PollStore:TryIndex({ "polls", activeId })
			local now      = workspace:GetServerTimeNow()

			if activeId and activeId ~= localVotePollId then
				localVote       = nil
				localVotePollId = nil
			end

			local isActive = pollData ~= nil and pollData.endsAt > now

			if isActive then
				isShowingResults = false
				PollUI.Buttons.Visible = true

				if not isPollVisible then
					isPollVisible  = true
					PollUI.Visible = true

					local colorA = Color3.fromHex(pollData.option1colorHex or "2197ff")
					local colorB = Color3.fromHex(pollData.option2colorHex or "da261a")

					PollUI.Bar.Fill.UIGradient.Color     = ColorSequence.new(colorA)
					PollUI.Bar.BackgroundColor3           = colorB
					PollUI.Buttons["1"].BackgroundColor3  = colorA
					PollUI.Buttons["2"].BackgroundColor3  = colorB
				end

				if activePollId ~= activeId then
					activePollId = activeId

					displayVotesA = 0
					displayVotesB = 0
					rateA         = 0
					rateB         = 0

					fakeVotesA = pollData.startVotesA or 0
					fakeVotesB = pollData.startVotesB or 0

					targetVotesA = pollData.votes.A
					targetVotesB = pollData.votes.B

					lastRoundedA = -1
					lastRoundedB = -1
				else
					targetVotesA = pollData.votes.A
					targetVotesB = pollData.votes.B
				end

				PollUI.Buttons["1"].Function.Text = pollData.option1
				PollUI.Buttons["2"].Function.Text = pollData.option2

				local timeLeft = math.max(0, (pollData.endsAt - now) // 1)
				PollUI.Template.Text = ("%s (%ds)"):format(pollData.text, timeLeft)

				updateButtonStates(pollData)

			else
				if isPollVisible and not isShowingResults then
					isShowingResults = true

					PollUI.Buttons.Visible = true
					Spr.target(PollUI.Buttons["1"].Disabled, 1, 5, { BackgroundTransparency = 0.5 })
					Spr.target(PollUI.Buttons["2"].Disabled, 1, 5, { BackgroundTransparency = 0.5 })

					PollUI.Template.Text = pollData and pollData.text or ""

					if pollData then
						targetVotesA = pollData.votes.A
						targetVotesB = pollData.votes.B

						displayVotesA = targetVotesA + fakeVotesA
						displayVotesB = targetVotesB + fakeVotesB
						rateA         = 0
						rateB         = 0
						lastRoundedA  = -1
						lastRoundedB  = -1
					end

					task.delay(5, function()
						if isShowingResults then
							clearPollState()
						end
					end)

				elseif not isPollVisible then
					PollUI.Visible = false
				end
			end
		end

		PollUI.Buttons["1"].Activated:Connect(function()
			if localVoteCooldown then return end
			local activeId = PollStore:TryIndex({ "activePoll" })
			if not activeId then return end
			local poll = PollStore:TryIndex({ "polls", activeId })
			if not poll then return end
			if workspace:GetServerTimeNow() >= poll.endsAt then return end

			local myVote = localVote
			if myVote == "A" then return end
			if myVote and not poll.allowSwitch then return end

			localVoteCooldown = true
			task.delay(1, function() localVoteCooldown = false end)

			localVote       = "A"
			localVotePollId = activeId
			updateButtonStates(poll)

			Net:RemoteEvent("PollService/Vote"):FireServer(SECRET_KEY, activeId, OPTION_A_KEY)
		end)

		PollUI.Buttons["2"].Activated:Connect(function()
			if localVoteCooldown then return end
			local activeId = PollStore:TryIndex({ "activePoll" })
			if not activeId then return end
			local poll = PollStore:TryIndex({ "polls", activeId })
			if not poll then return end
			if workspace:GetServerTimeNow() >= poll.endsAt then return end

			local myVote = localVote
			if myVote == "B" then return end
			if myVote and not poll.allowSwitch then return end

			localVoteCooldown = true
			task.delay(1, function() localVoteCooldown = false end)

			localVote       = "B"
			localVotePollId = activeId
			updateButtonStates(poll)

			Net:RemoteEvent("PollService/Vote"):FireServer(SECRET_KEY, activeId, OPTION_B_KEY)
		end)

		RunService.Heartbeat:Connect(function(dt)
			if not isPollVisible then return end

			local activeId = PollStore:TryIndex({ "activePoll" })
			local pollData = activeId and PollStore:TryIndex({ "polls", activeId })

			if pollData then
				local now      = workspace:GetServerTimeNow()
				local timeLeft = math.max(0, math.floor(pollData.endsAt - now))

				if not isShowingResults then
					PollUI.Template.Text = ("%s (%ds)"):format(pollData.text, timeLeft)
					if timeLeft <= 0 then refreshUI() end
				end
			end

			local trueA = targetVotesA + fakeVotesA
			local trueB = targetVotesB + fakeVotesB

			local function updateRate(currentRate, display, trueTotal)
				local gap = (trueTotal - UNDERSHOOT_GAP) - display

				local desired
				if isShowingResults then
					desired = gap > 0 and (gap / RATE_SMOOTHING) or 0
				else
					desired = gap > 0
						and math.max(gap / RATE_SMOOTHING, MIN_RATE)
						or  MIN_RATE
				end

				return currentRate + (desired - currentRate) * math.min(dt * 2, 1)
			end

			if displayTier <= 0 then
				displayVotesA = trueA
				displayVotesB = trueB
			elseif displayTier == 1 then
				local alpha = math.min(dt * MIDDLE_TIER_SPEED, 1)
				displayVotesA = math.min(displayVotesA + (trueA - displayVotesA) * alpha, trueA)
				displayVotesB = math.min(displayVotesB + (trueB - displayVotesB) * alpha, trueB)
				if trueA - displayVotesA < 0.5 then displayVotesA = trueA end
				if trueB - displayVotesB < 0.5 then displayVotesB = trueB end
			else
				rateA = updateRate(rateA, displayVotesA, trueA)
				rateB = updateRate(rateB, displayVotesB, trueB)

				local noiseA = 1 + (math.random() * 2 - 1) * NOISE_FACTOR
				local noiseB = 1 + (math.random() * 2 - 1) * NOISE_FACTOR

				displayVotesA = math.min(displayVotesA + rateA * noiseA * dt, trueA)
				displayVotesB = math.min(displayVotesB + rateB * noiseB * dt, trueB)
			end

			local roundA = math.floor(displayVotesA)
			local roundB = math.floor(displayVotesB)

			if roundA ~= lastRoundedA or roundB ~= lastRoundedB then
				lastRoundedA = roundA
				lastRoundedB = roundB
				updateBarAndText(roundA, roundB)
			end
		end)

		local cleanupPollObserver = nil
		PollStore:WaitForLoaded()

		PollStore:Observe({ "activePoll" }, function(newId)
			if cleanupPollObserver then
				cleanupPollObserver()
				cleanupPollObserver = nil
			end

			if newId then
				local unobservePoll   = PollStore:Observe({ "polls", newId }, function() refreshUI() end)
				local timerDisconnect = Timer.Simple(1, refreshUI, true)

				cleanupPollObserver = function()
					unobservePoll()
					timerDisconnect:Disconnect()
				end

				refreshUI()
			else
				if isPollVisible and not isShowingResults then
					clearPollState()
				end
			end
		end)
	end
}