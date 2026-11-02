-- LOCATION: Inside the NPC Model (Script)

local npc = script.Parent
local humanoid = npc:WaitForChild("Humanoid")
-- The Animator object handles loading animations smoothly
local animator = humanoid:WaitForChild("Animator") 

-- 1. Create the Animation Instance
local idleAnim = Instance.new("Animation")
idleAnim.Name = "IdleAnimation"
-- TODO: set this to a real animation ID that this experience actually owns/has access to
idleAnim.AnimationId = ""

-- 2. Function to Play
local function playIdle()
	if idleAnim.AnimationId == "" then
		warn("[SellNPC.Idle] No AnimationId set - skipping idle animation")
		return
	end
	local ok, track = pcall(function()
		return animator:LoadAnimation(idleAnim)
	end)
	if ok and track then
		track.Looped = true -- Ensures it repeats forever
		track.Priority = Enum.AnimationPriority.Idle
		track:Play()
	else
		warn("[SellNPC.Idle] Failed to load idle animation")
	end
end

-- 3. Run it
playIdle()