--credit to quartz games studio
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local v1 = nil
local v2 = 0

local function updateHolding() --[[ updateHolding | Line: 19 | Upvalues: v1 (ref), v2 (ref) ]]
	if not v1 then
		return
	end

	local v12 = os.clock()

	if not (v12 < v1.t or v12 - v2 < v1.interval) then
		v2 = v12
		v1.callback(v12 - v1.t)
	end
end

local function clearHolding() --[[ clearHolding | Line: 33 | Upvalues: v1 (ref), v2 (ref) ]]
	if not v1 then
		return
	end

	if v1.conn then
		v1.conn:Disconnect()
		v1.conn = nil
	end

	local v12 = os.clock()

	if v1.t <= v12 then
		task.spawn(v1.callback, v12 - v1.t, true)
	end

	v2 = 0
	v1 = nil
end

UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 50 | Upvalues: clearHolding (copy) ]]
	if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Touch and p1.KeyCode ~= Enum.KeyCode.ButtonA) then
		return
	end

	clearHolding()
end)

return function(p1, p2, p3) --[[ Line: 56 | Upvalues: clearHolding (copy), v1 (ref), RunService (copy), updateHolding (copy) ]]
	local v12 = p1.MouseButton1Down:Connect(function() --[[ Line: 57 | Upvalues: clearHolding (ref), v1 (ref), p1 (copy), p3 (copy), p2 (copy), RunService (ref), updateHolding (ref) ]]
		clearHolding()

		local t = {
			button = p1
		}

		t.t = os.clock() + (if p3 then p3.minimumHoldTime or 0 else 0)
		t.interval = if p3 then p3.interval or 0 else 0
		t.callback = p2
		t.conn = RunService.PostSimulation:Connect(updateHolding)
		v1 = t
	end)
	local v2 = p1.MouseButton1Up:Connect(function() --[[ Line: 69 | Upvalues: v1 (ref), p1 (copy), clearHolding (ref) ]]
		if not v1 or v1.button ~= p1 then
			return
		end

		clearHolding()
	end)
	local v3 = p1.Destroying:Once(function() --[[ Line: 75 | Upvalues: v1 (ref), p1 (copy), clearHolding (ref) ]]
		if not v1 or v1.button ~= p1 then
			return
		end

		clearHolding()
	end)

	return function() --[[ Line: 81 | Upvalues: v3 (copy), v12 (copy), v2 (copy) ]]
		v3:Disconnect()
		v12:Disconnect()
		v2:Disconnect()
	end
end