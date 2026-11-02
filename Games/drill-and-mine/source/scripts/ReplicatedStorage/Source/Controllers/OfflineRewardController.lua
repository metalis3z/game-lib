-- OfflineRewardController: presents the "Earnings -- While Offline you made.."
-- popup on every join (offline STRENGTH row + offline CASH row) and wires the
-- CLAIM! button to credit both in one call.
--
-- Server contract (PodiumService):
--   Remotes.PodiumService.OfflineRewardReady     :FireClient(player, cash, strength)
--   Remotes.PodiumService.RequestOfflineTotal    :InvokeServer() -> cash, strength
--   Remotes.PodiumService.CollectAllOfflineCash  :InvokeServer() -> ok, cashCredited, strengthCredited
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)
local FrameAnimator = require(ReplicatedStorage.Source.Modules.FrameAnimator)

-- Standard game-wide claim SFX: SoundService.Sounds.PurchasedSound -- the same
-- sound DailyReward, loot claims and purchases play, so the Earnings claim
-- matches every other claim button.
local CLAIM_SOUND_NAME = "PurchasedSound"

local player = Players.LocalPlayer

local OfflineRewardController = {}

-- Join-popup sequencing: DailyRewardController waits for this to resolve so
-- the Earnings popup always shows FIRST on rejoin. Resolved = either no
-- offline-earnings popup is coming this join, or it was shown and closed.
OfflineRewardController.Done = false
local doneBindable = Instance.new("BindableEvent")
OfflineRewardController.DoneEvent = doneBindable.Event
local function markDone()
	if OfflineRewardController.Done then return end
	OfflineRewardController.Done = true
	doneBindable:Fire()
end

local function getOfflineFrame()
	local pg = player:WaitForChild("PlayerGui")
	local gui = pg:WaitForChild("GUI")
	local folder = gui:WaitForChild("Folder")
	return folder:WaitForChild("OfflineReward")
end

local function setLabelText(label, text)
	if not label then return end
	label.Text = text
	local inner = label:FindFirstChild("Double")
	if inner and inner:IsA("TextLabel") then
		inner.Text = text
	end
end

local function formatAmount(amount, isCash)
	-- "+1.60B" (strength) / "+$1.38M" (cash) -- abbreviated like the HUD.
	local abbrev = FormatUtils and FormatUtils.Abbreviate and FormatUtils.Abbreviate(amount)
	local prefix = isCash and "+$" or "+"
	return prefix .. (abbrev or tostring(amount))
end

local function hide(frame)
	-- Route through FrameAnimator so the close path runs the same fade-out +
	-- bg blur restore the other frames in this game use. Falls back to Visible
	-- toggling if FrameAnimator isn't initialized yet.
	if FrameAnimator and FrameAnimator.Close then
		FrameAnimator:Close(frame)
	else
		frame.Visible = false
	end
end

local function show(frame, cashAmount, strengthAmount)
	cashAmount = math.max(0, math.floor(cashAmount or 0))
	strengthAmount = math.max(0, math.floor(strengthAmount or 0))

	-- Both rows ALWAYS show (the design mock has both) -- a stat the player
	-- didn't earn simply reads "+0".
	local strengthRow = frame:FindFirstChild("StrengthRow")
	local cashRow = frame:FindFirstChild("CashRow")
	if strengthRow then
		setLabelText(strengthRow:FindFirstChild("Amount"), formatAmount(strengthAmount))
		strengthRow.Visible = true
	end
	if cashRow then
		setLabelText(cashRow:FindFirstChild("Amount"), formatAmount(cashAmount, true))
		cashRow.Visible = true
	end

	if FrameAnimator and FrameAnimator.Open then
		FrameAnimator:Open(frame)
		-- FrameAnimator:Open silently no-ops while ANY frame animation is in
		-- flight (isAnimating) or another frame is open -- both are likely in
		-- the first seconds after join. Keep retrying until the popup actually
		-- lands; Open() switches away whatever frame is currently open.
		if not frame.Visible then
			task.spawn(function()
				for _ = 1, 24 do
					task.wait(0.25)
					if frame.Visible then return end
					FrameAnimator:Open(frame)
				end
				-- animator never took it (some modal is stuck open): last resort
				-- plain show so the earnings are never silently swallowed
				if not frame.Visible then
					frame.Visible = true
				end
			end)
		end
	else
		frame.Visible = true
	end
end

local function wireClaim(frame, claimAll)
	local buttons = frame:FindFirstChild("Buttons")
	if not buttons then return end
	for _, child in ipairs(buttons:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("ImageButton") then
			child.MouseButton1Click:Connect(claimAll)
		end
	end
end

function OfflineRewardController.Init()
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local PodiumRemotes = Remotes:WaitForChild("PodiumService")
	local OfflineRewardReady = PodiumRemotes:WaitForChild("OfflineRewardReady", 30)
	local RequestOfflineTotal = PodiumRemotes:WaitForChild("RequestOfflineTotal", 30)
	local CollectAllOfflineCash = PodiumRemotes:WaitForChild("CollectAllOfflineCash", 30)

	local frame = getOfflineFrame()
	-- The StarterGui copy ships with Visible=true so the design surface stays
	-- readable; hide it at runtime until the server says there's offline cash.
	hide(frame)

	-- resolve the join sequencing once the popup has been shown AND closed
	-- (claim or X, both route through FrameAnimator's Visible flip)
	local shown = false
	frame:GetPropertyChangedSignal("Visible"):Connect(function()
		if frame.Visible then
			shown = true
		elseif shown then
			markDone()
		end
	end)

	local claimInFlight = false
	local function playClaimSound()
		local soundsFolder = SoundService:FindFirstChild("Sounds")
		local template = soundsFolder and soundsFolder:FindFirstChild(CLAIM_SOUND_NAME)
		if not template then return end
		-- clone so overlapping claims never cut each other off
		local s = template:Clone()
		s.Parent = SoundService
		s:Play()
		s.Ended:Once(function() s:Destroy() end)
		task.delay(4, function() if s.Parent then s:Destroy() end end)
	end
	local function claimAll()
		if claimInFlight then return end
		claimInFlight = true
		-- pcall returns (ok, ...serverReturns). The server's onCollectAllOfflineCash
		-- returns (true, rounded). Before this fix we destructured into
		-- (ok, credited) which made credited = true (the server's first return),
		-- not the amount -- so the sound check `credited > 0` errored and was
		-- swallowed by Lua's silent boolean comparison.
		local ok, serverOk, credited, strengthCredited = pcall(function() return CollectAllOfflineCash:InvokeServer() end)
		claimInFlight = false
		if ok and serverOk then
			hide(frame)
			local gotCash = typeof(credited) == "number" and credited > 0
			local gotStrength = typeof(strengthCredited) == "number" and strengthCredited > 0
			if gotCash or gotStrength then
				playClaimSound()
			end
		end
	end
	wireClaim(frame, claimAll)

	OfflineRewardReady.OnClientEvent:Connect(function(total, strength)
		total = type(total) == "number" and total or 0
		strength = type(strength) == "number" and strength or 0
		-- REJOIN only, and only if there's something to show.
		if player:GetAttribute("IsRejoin") ~= true or (total <= 0 and strength <= 0) then
			return
		end
		if frame.Visible or shown then return end
		show(frame, total, strength)
	end)

	-- Catch-up poll: PodiumService fires OfflineRewardReady once when the
	-- profile load + calcOfflineCash finishes. If the client's Init lands
	-- after that event already fired, this round-trip queries the same
	-- aggregated number a beat later so the popup still appears.
	task.defer(function()
		-- The IsRejoin attribute is set by PodiumService's ProfileLoaded handler,
		-- so its existence == profile loaded. Wait for it (bounded), then one more
		-- beat for the server's delayed earnings computation (task.delay(1)).
		local deadline = os.clock() + 10
		while player:GetAttribute("IsRejoin") == nil and os.clock() < deadline do
			task.wait(0.25)
		end
		task.wait(1.5)
		local ok, total, strength = pcall(function() return RequestOfflineTotal:InvokeServer() end)
		total = (ok and type(total) == "number") and total or 0
		strength = (ok and type(strength) == "number") and strength or 0
		-- Only a REJOIN gets the join popup; a first-ever session shows nothing.
		local isRejoin = player:GetAttribute("IsRejoin") == true
		if isRejoin and (total > 0 or strength > 0) and not frame.Visible and not shown then
			show(frame, total, strength)
		elseif not frame.Visible and not shown then
			-- nothing to show this join -> unblock the daily-reward popup.
			-- (if the popup IS open/shown, the Visible-close handler resolves it)
			markDone()
		end
	end)
end

return OfflineRewardController