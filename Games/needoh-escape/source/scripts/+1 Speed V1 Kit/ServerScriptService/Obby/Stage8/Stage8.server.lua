local TweenService = game:GetService("TweenService")

-- CONFIG
local GROW_SPEED = 155        -- studs per second (height growth rate)
local COOLDOWN = 2            -- seconds to wait before growing again after reset
local GROW_TWEEN_STYLE = Enum.EasingStyle.Sine
local GROW_TWEEN_DIRECTION = Enum.EasingDirection.In
local SHRINK_TWEEN_STYLE = Enum.EasingStyle.Sine
local SHRINK_TWEEN_DIRECTION = Enum.EasingDirection.Out

-- REFERENCES
local kill = workspace.Map.ObbyStuff.Stage8.Kill

-- START STATE
local startSize = Vector3.new(47.788, 1.048, 41.498)
local startPos  = Vector3.new(-2431.773, 124.286, -196.638)

-- END STATE
local endSize = Vector3.new(47.788, 258.427, 41.498)
local endPos  = Vector3.new(-2431.773, 259.437, -196.638)

-- Calculate grow time from speed (height difference / studs per second)
local heightDiff = endSize.Y - startSize.Y  -- 257.427 studs
local GROW_TIME  = heightDiff / GROW_SPEED  -- e.g. 257.427 / 100 = ~2.57s
local SHRINK_TIME = GROW_TIME               -- same speed going down

local function resetKill()
	kill.Size     = startSize
	kill.Position = startPos
	kill.Anchored = true
end

local function growAndShrink()
	-- GROW
	local growTween = TweenService:Create(kill, TweenInfo.new(
		GROW_TIME,
		GROW_TWEEN_STYLE,
		GROW_TWEEN_DIRECTION
		), {
			Size     = endSize,
			Position = endPos,
		})

	growTween:Play()
	growTween.Completed:Wait()

	-- SHRINK
	local shrinkTween = TweenService:Create(kill, TweenInfo.new(
		SHRINK_TIME,
		SHRINK_TWEEN_STYLE,
		SHRINK_TWEEN_DIRECTION
		), {
			Size     = startSize,
			Position = startPos,
		})

	shrinkTween:Play()
	shrinkTween.Completed:Wait()
end

-- MAIN LOOP
while true do
	resetKill()
	task.wait(COOLDOWN)
	growAndShrink()
end