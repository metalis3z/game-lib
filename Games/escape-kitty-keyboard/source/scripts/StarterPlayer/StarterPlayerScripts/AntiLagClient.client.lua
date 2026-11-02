-- AntiLagClient - Client-side performance optimization (NO per-frame loops)
-- Lightweight: NO iteration over thousands of instances, NO Heartbeat loops
-- StreamingEnabled already handles distance-based part culling automatically

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- =======================================================
-- 1. POST-PROCESSING OPTIMIZATION
-- Reduce or disable expensive visual effects
-- =======================================================
local function optimizePostProcessing()
	-- Disable SunRays (expensive GPU effect)
	local sunRays = Lighting:FindFirstChild("SunRays")
	if sunRays and sunRays:IsA("SunRaysEffect") then
		sunRays.Intensity = 0
	end

	-- Reduce Bloom intensity
	local bloom = Lighting:FindFirstChild("Bloom")
	if bloom and bloom:IsA("BloomEffect") then
		bloom.Intensity = 0.4
		bloom.Threshold = 1.5
	end

	-- Disable MenuBlur when not in menu (it stays active and wastes GPU)
	local blur = Lighting:FindFirstChild("MenuBlur")
	if blur and blur:IsA("BlurEffect") then
		blur.Size = 0
	end
end

-- =======================================================
-- 2. FPS-BASED DYNAMIC QUALITY (checked every 5s, NOT per-frame)
-- =======================================================
local fpsFrameCount = 0
local lastFpsCheck = 0
local isLowQuality = false

task.spawn(function()
	while true do
		task.wait(5) -- Check every 5 seconds (NOT per-frame)

		local now = os.clock()
		local elapsed = now - lastFpsCheck
		if lastFpsCheck > 0 and elapsed > 0 then
			local fps = fpsFrameCount / elapsed

			if fps < 20 and not isLowQuality then
				-- FPS critically low, enable emergency optimizations
				isLowQuality = true
				local sunRays = Lighting:FindFirstChild("SunRays")
				if sunRays then sunRays.Enabled = false end
				local bloom = Lighting:FindFirstChild("Bloom")
				if bloom then bloom.Enabled = false end
				local atmosphere = Lighting:FindFirstChild("Atmosphere")
				if atmosphere then atmosphere.Enabled = false end
				print("[AntiLagClient] FPS low (" .. math.floor(fps) .. "), enabling emergency optimizations")
			elseif fps >= 30 and isLowQuality then
				-- FPS recovered, restore some quality
				isLowQuality = false
				local sunRays = Lighting:FindFirstChild("SunRays")
				if sunRays then sunRays.Enabled = true; sunRays.Intensity = 0 end
				local bloom = Lighting:FindFirstChild("Bloom")
				if bloom then bloom.Enabled = true; bloom.Intensity = 0.4 end
				print("[AntiLagClient] FPS recovered (" .. math.floor(fps) .. "), restoring quality")
			end
		end

		lastFpsCheck = now
		fpsFrameCount = 0
	end
end)

-- Lightweight FPS counter (just increments a number, no iteration)
local renderConn
game:GetService("RunService").RenderStepped:Connect(function()
	fpsFrameCount = fpsFrameCount + 1
end)

-- =======================================================
-- 3. STREAMING OPTIMIZATION
-- =======================================================
-- Since StreamingEnabled is ON, we just ensure pause mode is set
pcall(function()
	Workspace.StreamingPauseMode = Enum.StreamingPauseMode.ClientPause
end)

-- =======================================================
-- 4. INITIAL OPTIMIZATION (one-time, at join)
-- =======================================================
optimizePostProcessing()

print("[AntiLagClient] Lightweight optimization active. No per-frame loops, no mass iteration.")