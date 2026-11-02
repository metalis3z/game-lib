-- PedestalOfferTimerClient: renders the pedestal limited-offer countdown
-- (Workspace.DevProductN SkipBillboard TimerFrame) from the OfferDeadline
-- attribute DevProductPedestalServer publishes (unix seconds, DataStore-
-- backed so server restarts never reset it -- the Dragon Egg counts a real
-- 7 days). Rendered with the server-synced clock so every client shows the
-- same remaining time; clamps at 0d 0h 0m 0s once expired. Ported from
-- "+1 Kick Door Per Click" 2026-07-21.
local Workspace = game:GetService("Workspace")

local watched = {} -- [pedestal Model] = { label = TextLabel, inner = TextLabel? }

local function formatRemaining(seconds)
	seconds = math.max(0, math.floor(seconds))
	local d = math.floor(seconds / 86400)
	local h = math.floor((seconds % 86400) / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60
	return string.format("%dd %dh %dm %ds", d, h, m, s)
end

local function watch(model)
	if watched[model] then return end
	task.spawn(function()
		local timerFrame
		for _ = 1, 30 do
			timerFrame = model:FindFirstChild("TimerFrame", true)
			if timerFrame then break end
			task.wait(1)
		end
		local label = timerFrame and timerFrame:FindFirstChild("Timer")
		if not label then return end
		watched[model] = { label = label, inner = label:FindFirstChild("Inner") }
	end)
end

for _, inst in ipairs(Workspace:GetChildren()) do
	if inst:IsA("Model") and inst.Name:match("^DevProduct%d+$") then
		watch(inst)
	end
end
Workspace.ChildAdded:Connect(function(inst)
	if inst:IsA("Model") and inst.Name:match("^DevProduct%d+$") then
		watch(inst)
	end
end)

while true do
	local now = Workspace:GetServerTimeNow()
	for model, refs in pairs(watched) do
		if not model.Parent or not refs.label.Parent then
			watched[model] = nil
		else
			local deadline = tonumber(model:GetAttribute("OfferDeadline"))
			if deadline then
				local text = formatRemaining(deadline - now)
				if refs.label.Text ~= text then
					refs.label.Text = text
					if refs.inner then refs.inner.Text = text end
				end
			end
		end
	end
	task.wait(1)
end
