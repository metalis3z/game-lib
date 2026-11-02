-- ============================================================
--  RollingBall Script  |  ServerScriptService
-- ============================================================

-- ADJUSTABLE SETTINGS
local SPEED    = 195   -- studs per second down the ramp
local COOLDOWN = 1    -- seconds after deletion before next ball

-- ============================================================
--  References
-- ============================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")

local ballTemplate = ReplicatedStorage:WaitForChild("Models"):WaitForChild("Ball")

local stage7    = workspace:WaitForChild("Map")
	:WaitForChild("ObbyStuff")
	:WaitForChild("Stage7")

local spawnPart = stage7:WaitForChild("Spawn")
local endPart   = stage7:WaitForChild("End")

-- ============================================================
--  Kill on touch
-- ============================================================
local function onBallTouched(hit, ball)
	local character = hit.Parent
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.Health > 0 then
		humanoid.Health = 0
	end
end

-- ============================================================
--  Main loop
-- ============================================================
while true do
	-- Snap to the center line of the ramp by lerping between Spawn and End positions
	local startPos = spawnPart.Position
	local endPos   = endPart.Position

	-- Full 3D direction (follows the slope exactly)
	local direction = (endPos - startPos).Unit
	local totalDist = (endPos - startPos).Magnitude

	-- Clone ball, anchor it — we manually move it each frame so it never drifts
	local ball = ballTemplate:Clone()
	ball.Anchored   = true
	ball.CanCollide = true
	ball.CFrame     = CFrame.new(startPos)
	ball.Parent     = workspace

	local touchConn = ball.Touched:Connect(function(hit)
		onBallTouched(hit, ball)
	end)

	-- Rolling spin setup
	local radius       = ball.Size.X / 2
	local spinAxis     = direction:Cross(Vector3.new(0, 1, 0))
	if spinAxis.Magnitude < 0.001 then
		spinAxis = Vector3.new(1, 0, 0) -- fallback for perfectly vertical drops
	end
	spinAxis = spinAxis.Unit

	local traveled  = 0
	local totalSpin = 0
	local reached   = false

	local heartbeat
	heartbeat = RunService.Heartbeat:Connect(function(dt)
		if not ball or not ball.Parent then
			heartbeat:Disconnect()
			return
		end

		traveled   = traveled + SPEED * dt
		local alpha = math.min(traveled / totalDist, 1)

		-- Lock ball to the center line — no drift possible
		local pos = startPos:Lerp(endPos, alpha)

		-- Spin angle based on distance traveled (looks like real rolling)
		totalSpin = totalSpin + (SPEED * dt) / radius
		local spinRot = CFrame.fromAxisAngle(spinAxis, totalSpin)

		ball.CFrame = CFrame.new(pos) * spinRot

		if alpha >= 1 and not reached then
			reached = true
			heartbeat:Disconnect()
			task.wait(0.05)
			touchConn:Disconnect()
			ball:Destroy()
		end
	end)

	repeat task.wait(0.1) until not ball.Parent
	task.wait(COOLDOWN)
end