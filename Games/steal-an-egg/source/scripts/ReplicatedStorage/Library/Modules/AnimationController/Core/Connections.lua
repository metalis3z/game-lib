-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local Utility = script.Parent.Parent.Utility

require(script.Parent.Parent.Types)

local Bin = require(Utility.Bin)
local t = {
	Running = true,
	Climbing = true,
	Swimming = true,
	Freefall = true,
	Jumping = true
}

local function stateChanged(p1, p2, p3) --[[ stateChanged | Line: 18 | Upvalues: t (copy) ]]
	local v1 = p3.Name

	if t[v1] then
		p1._pose = v1
	else
		p1._controller:ChangePose(v1, 1, true)
	end
end

local function jumping(p1) --[[ jumping | Line: 29 ]]
	p1._jumpTimer = p1.JumpDuration
	p1._controller:ChangePose("Jumping", 1, true)
end

local function movementChPose(p1, p2, p3) --[[ movementChPose | Line: 36 ]]
	local v1 = p3 / p1.BaseMoveSpeed
	local v2 = p1._controller:GetCurrentTrack()

	if v2 then
		v2:AdjustSpeed(v1)
	end

	p1._controller:ChangePose(p2, v1, true)
end

local function climbing(p1, p2) --[[ climbing | Line: 47 ]]
	local v1 = p2 / p1.BaseMoveSpeed
	local v2 = p1._controller:GetCurrentTrack()

	if v2 then
		v2:AdjustSpeed(v1)
	end

	p1._controller:ChangePose("Climbing", v1, true)
end

local function swimming(p1, p2) --[[ swimming | Line: 51 ]]
	local v1 = if p2 <= p1.SwimIdleThreshold then "SwimIdle" else "Swimming"
	local v3 = (v1 == "SwimIdle" and p1.SwimIdleSpeed or p2) / p1.BaseMoveSpeed
	local v4 = p1._controller:GetCurrentTrack()

	if v4 then
		v4:AdjustSpeed(v3)
	end

	p1._controller:ChangePose(v1, v3, true)
end

local function running(p1, p2) --[[ running | Line: 57 ]]
	local v1 = p1._controller:GetPose()
	local v2 = if p2 == 0 or (v1 == "Landed" or (v1 == "Jumping" or v1 == "Freefall")) then "Idle" elseif p2 <= p1.BaseMoveSpeed then "Walk" else "Run"
	local v4 = (v2 == "Idle" and p1.IdleSpeed or p2) / p1.BaseMoveSpeed
	local v5 = p1._controller:GetCurrentTrack()

	if v5 then
		v5:AdjustSpeed(v4)
	end

	p1._controller:ChangePose(v2, v4, true)
end

local t2 = {}
local t3 = {
	__index = t2
}

local function pwarn(p1, p2) --[[ pwarn | Line: 73 ]]
	warn(string.format("Usage of deprecated function: Connections:%s(), set Connections.%s directly instead.", p1, p2))
end

function t2.SetRunThreshold(p1, p2) --[[ SetRunThreshold | Line: 80 ]]
	warn(string.format("Usage of deprecated function: Connections:%s(), set Connections.%s directly instead.", "SetRunThreshold", "BaseMoveSpeed"))
	p1.BaseMoveSpeed = p2
end
function t2.SetSwimIdleSpeed(p1, p2) --[[ SetSwimIdleSpeed | Line: 87 ]]
	warn(string.format("Usage of deprecated function: Connections:%s(), set Connections.%s directly instead.", "SetSwimIdleSpeed", "SwimIdleSpeed"))
	p1.SwimIdleSpeed = p2
end
function t2.SetIdleSpeed(p1, p2) --[[ SetIdleSpeed | Line: 94 ]]
	warn(string.format("Usage of deprecated function: Connections:%s(), set Connections.%s directly instead.", "SetIdleSpeed", "IdleSpeed"))
	p1.IdleSpeed = p2
end
function t2.SetSwimThreshold(p1, p2) --[[ SetSwimThreshold | Line: 101 ]]
	warn(string.format("Usage of deprecated function: Connections:%s(), set Connections.%s directly instead.", "SetSwimThreshold", "SwimIdleThreshold"))
	p1.SwimIdleThreshold = p2
end
function t2.SetJumpDuration(p1, p2) --[[ SetJumpDuration | Line: 108 ]]
	warn(string.format("Usage of deprecated function: Connections:%s(), set Connections.%s directly instead.", "SetJumpDuration", "JumpDuration"))
	p1.JumpDuration = p2
end
function t2.Destroy(p1) --[[ Destroy | Line: 118 ]]
	p1._trash:Clear()
	setmetatable(p1, nil)
	table.clear(p1)
end

return {
	new = function(p1, p2, p3) --[[ new | Line: 136 | Upvalues: Bin (copy), t3 (copy), t (copy), RunService (copy) ]]
		local v1 = if p3 then p3 else p2:FindFirstChildWhichIsA("Humanoid")

		if v1 then
			local v2, v3, v4, v5

			v2 = Bin.new()
			v3 = {
				_jumpTimer = 0,
				JumpDuration = 0.2,
				SwimIdleSpeed = 12,
				SwimIdleThreshold = 2,
				IdleSpeed = 16,
				BaseMoveSpeed = 16,
				_controller = p1,
				_trash = v2,
				_pose = p1:GetPose()
			}
			v4 = t3
			v5 = setmetatable(v3, t3)
			v2:Add(v1.Running:Connect(function(p13) --[[ Line: 161 | Upvalues: v5 (copy) ]]
				local v1 = v5
				local v2 = v1._controller:GetPose()
				local v3 = if p13 == 0 or (v2 == "Landed" or (v2 == "Jumping" or v2 == "Freefall")) then "Idle" elseif p13 <= v1.BaseMoveSpeed then "Walk" else "Run"
				local v52 = (v3 == "Idle" and v1.IdleSpeed or p13) / v1.BaseMoveSpeed
				local v6 = v1._controller:GetCurrentTrack()

				if v6 then
					v6:AdjustSpeed(v52)
				end

				v1._controller:ChangePose(v3, v52, true)
			end), v1.Climbing:Connect(function(p13) --[[ Line: 164 | Upvalues: v5 (copy) ]]
				local v1 = v5
				local v2 = p13 / v1.BaseMoveSpeed
				local v3 = v1._controller:GetCurrentTrack()

				if v3 then
					v3:AdjustSpeed(v2)
				end

				v1._controller:ChangePose("Climbing", v2, true)
			end), v1.Swimming:Connect(function(p13) --[[ Line: 167 | Upvalues: v5 (copy) ]]
				local v1 = v5
				local v2 = if p13 <= v1.SwimIdleThreshold then "SwimIdle" else "Swimming"
				local v4 = (v2 == "SwimIdle" and v1.SwimIdleSpeed or p13) / v1.BaseMoveSpeed
				local v52 = v1._controller:GetCurrentTrack()

				if v52 then
					v52:AdjustSpeed(v4)
				end

				v1._controller:ChangePose(v2, v4, true)
			end), v1.StateChanged:Connect(function(p13, p23) --[[ Line: 170 | Upvalues: v5 (copy), t (ref) ]]
				local v1 = v5
				local v2 = p23.Name

				if t[v2] then
					v1._pose = v2
				else
					v1._controller:ChangePose(v2, 1, true)
				end
			end), v1.Jumping:Connect(function() --[[ Line: 173 | Upvalues: v5 (copy) ]]
				local v1 = v5

				v1._jumpTimer = v1.JumpDuration
				v1._controller:ChangePose("Jumping", 1, true)
			end), RunService.Heartbeat:Connect(function(p13) --[[ Line: 176 | Upvalues: v5 (copy), p1 (copy) ]]
				v5._jumpTimer = math.max(v5._jumpTimer - p13, 0)

				local v3 = p1:GetPose()

				if v5._pose == "Freefall" and (v3 == "Run" or v3 == "Walk") then
					p1:ChangePose("FellOff", 1, true)
				end

				if v5._pose ~= "Freefall" or not (v5._jumpTimer <= 0) then
					return
				end

				p1:ChangePose("Freefall", 1, true)
			end))

			return v5
		end

		error((("Humanoid not found for rig %*"):format(p2)))
	end
}