-- BridgeFadeHandler (Server)
-- Server only handles collision toggling + sets attributes for client timing.
-- Visual fade is handled entirely client-side (BridgeFadeClient) to avoid replication lag.

local bridge = workspace:FindFirstChild("Bridge1")
if not bridge then
	warn("[BridgeFadeHandler] Bridge1 not found in Workspace")
	return
end

local FADE_DURATION = 3
local INVISIBLE_DURATION = 2
local VISIBLE_DURATION = 0.7

-- Collect parts only for collision toggling (no transparency changes on server)
local parts = {}
local originalCanCollide = {}

for _, desc in ipairs(bridge:GetDescendants()) do
	if desc:IsA("BasePart") then
		table.insert(parts, desc)
		originalCanCollide[desc] = desc.CanCollide
	end
end

while true do
	bridge:SetAttribute("ServerStartTime", workspace:GetServerTimeNow())
	bridge:SetAttribute("BridgeDie", FADE_DURATION)
	bridge:SetAttribute("FadePhase", "fading")

	task.wait(FADE_DURATION)

	bridge:SetAttribute("FadePhase", "invisible")
	for _, part in ipairs(parts) do
		part.CanCollide = false
	end

	task.wait(INVISIBLE_DURATION)

	bridge:SetAttribute("FadePhase", "visible")
	for _, part in ipairs(parts) do
		part.CanCollide = originalCanCollide[part] or true
	end

	task.wait(VISIBLE_DURATION)
end
