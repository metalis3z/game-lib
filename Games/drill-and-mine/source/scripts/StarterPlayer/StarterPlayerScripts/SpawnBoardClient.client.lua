-- SpawnBoardClient: renders the Zone-1 rare-spawn countdowns on the
-- Workspace.SpawnBoard board. The Mythic row's rainbow is NOT animated here:
-- its UIGradient carries the "VipTagGradient" tag, so VipTagFlowClient
-- scrolls it with the exact same 20-keypoint hue flow (0.25 cycles/sec) as
-- every other rainbow text in the game (VIP tag, Robux prices, store loot).
-- RarityItemSpawner owns the timers server-side and publishes each deadline
-- as a SpawnAt<Rarity> attribute (server time), so every client shows the
-- same countdown and late joiners are correct immediately.
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local boardFolder = Workspace:WaitForChild("SpawnBoard")
local boardPart = boardFolder:WaitForChild("BoardPart")
local gui = boardPart:WaitForChild("FrontBackgroundSurfaceGui")
local rows = gui:WaitForChild("TimerRows")

local RARITIES = { "Legendary", "Mythic", "Secret" }
local labels = {}
for _, rarity in ipairs(RARITIES) do
	labels[rarity] = rows:WaitForChild(rarity):WaitForChild("Title")
end

local function formatTime(sec)
	sec = math.max(0, math.floor(sec + 0.5))
	return ("%dm %ds"):format(math.floor(sec / 60), sec % 60)
end

local acc = 0
RunService.Heartbeat:Connect(function(dt)
	acc += dt
	if acc < 0.25 then return end
	acc = 0
	local now = Workspace:GetServerTimeNow()
	for _, rarity in ipairs(RARITIES) do
		local deadline = boardFolder:GetAttribute("SpawnAt" .. rarity)
		if deadline then
			local remaining = deadline - now
			if remaining <= 0 then
				labels[rarity].Text = rarity .. ": Spawning..."
			else
				-- short string on purpose: the label is TextScaled, so fewer
				-- characters = the text renders much larger in the row
				labels[rarity].Text = ("%s in: %s"):format(rarity, formatTime(remaining))
			end
		end
	end
end)
