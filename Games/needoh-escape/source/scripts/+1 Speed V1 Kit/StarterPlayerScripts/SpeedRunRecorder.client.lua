--!strict
-- LOCATION: StarterPlayerScripts/SpeedRunRecorder
-- Records the local player's HumanoidRootPart at 20fps from SpeedRunStart
-- to SpeedRunEnd, tracks which frame indices were revive-teleports, and
-- submits the full recording to the server so SpeedRunReplayHandler can
-- store it (only kept server-side if it's a new PB — see handler).

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")

local player = Players.LocalPlayer

local events = ReplicatedStorage:WaitForChild("Events")
local SpeedRunStart  = events:WaitForChild("SpeedRunStart") :: RemoteEvent
local SpeedRunEnd    = events:WaitForChild("SpeedRunEnd") :: RemoteEvent
local SpeedRunReset  = events:WaitForChild("SpeedRunReset") :: RemoteEvent
local SubmitReplay   = events:WaitForChild("SubmitReplay") :: RemoteEvent

local RECORD_FPS     = 20
local FRAME_DURATION = 1 / RECORD_FPS
local MAX_FRAMES      = 12000 -- matches server cap (10 min)

local isRecording = false
local frames: {{number}} = {}
local reviveMarkers: {number} = {}
local recordConn: RBXScriptConnection? = nil
local characterConn: RBXScriptConnection? = nil
local lastTick = 0
local pendingReviveMark = false -- set true right after a death, consumed on next frame

local function getHRP(): BasePart?
	local character = player.Character
	if not character then return nil end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function stopRecording(shouldSubmit: boolean, finalTime: number?)
	if not isRecording then return end
	isRecording = false

	if recordConn then recordConn:Disconnect(); recordConn = nil end

	if shouldSubmit and finalTime and #frames > 0 then
		print("[SpeedRunRecorder] Submitting replay | frames:", #frames, "| time:", finalTime)
		SubmitReplay:FireServer(finalTime, frames, reviveMarkers)
	else
		print("[SpeedRunRecorder] Discarding recording | frames:", #frames)
	end

	frames = {}
	reviveMarkers = {}
end

local function startRecording()
	frames = {}
	reviveMarkers = {}
	pendingReviveMark = false
	isRecording = true
	lastTick = os.clock()

	if recordConn then recordConn:Disconnect() end
	recordConn = RunService.Heartbeat:Connect(function()
		if not isRecording then return end

		local now = os.clock()
		if now - lastTick < FRAME_DURATION then return end
		lastTick = now

		local hrp = getHRP()
		if not hrp then return end

		if #frames >= MAX_FRAMES then
			stopRecording(false, nil)
			return
		end

		local cf = hrp.CFrame
		local pos = cf.Position
		local rx, ry, rz = cf:ToEulerAnglesYXZ()

		table.insert(frames, {pos.X, pos.Y, pos.Z, ry, rx, rz})

		if pendingReviveMark then
			reviveMarkers[#reviveMarkers + 1] = #frames
			pendingReviveMark = false
		end
	end)
end

-- [ EVENTS ] -------------------------------------------------------------------

SpeedRunStart.OnClientEvent:Connect(function(elapsed: number?)
	if elapsed and elapsed > 0 then
		-- Resuming after revive: keep existing frames, just mark this point
		pendingReviveMark = true
		if not isRecording then
			-- Edge case: recorder wasn't running (e.g. script loaded late) — start fresh
			startRecording()
		end
	else
		-- Fresh run start
		startRecording()
	end
end)

SpeedRunEnd.OnClientEvent:Connect(function(finalTime: number)
	stopRecording(true, finalTime)
end)

SpeedRunReset.OnClientEvent:Connect(function()
	stopRecording(false, nil)
end)

player.CharacterAdded:Connect(function(character)
	-- If a run is active and the character respawns (e.g. revive teleport),
	-- recording continues seamlessly since we just re-fetch HRP each frame.
end)

