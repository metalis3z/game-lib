local F = {}
local body = script.Parent.Parent.Parent.Body.Lights
local tk = script.Parent.Parent.Parent.Misc.TK.Lights
local car = script.Parent.Parent.Parent
local BlinkersEnabled = true
local player = nil

local ts = game:GetService("TweenService")
local ti_rl = TweenInfo.new(.2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false)

F.updateLights = function(lights, bool)
	if lights == 'brake' then
		local goal = {}
		goal.Transparency = bool and 0 or 1
		local a = ts:Create(body.RLeft, ti_rl, goal)
		a:Play()
		a = ts:Create(body.RRight, ti_rl, goal)
		a:Play()
		tk.Brake.BrickColor = bool and BrickColor.new("Bright red") or BrickColor.new("Crimson")
		tk.Brake.Material = bool and "Neon" or "SmoothPlastic"
		
		
	elseif lights == 'beam' then
		body.FB.BrickColor = bool and BrickColor.new("Pearl") or BrickColor.new("Black")
		body.FB.Material = bool and "Neon" or "SmoothPlastic"
		body.RBL.BrickColor = bool and BrickColor.new("Bright red") or BrickColor.new("Crimson")
		body.RBL.Material = bool and "Neon" or "SmoothPlastic"
		body.RBR.BrickColor = bool and BrickColor.new("Bright red") or BrickColor.new("Crimson")
		body.RBR.Material = bool and "Neon" or "SmoothPlastic"
		body.L.Light.Enabled = bool
		car.DriveSeat.Lights.Value = bool
	end
end

local b = ''

function Toggle(dir, tog)
	if dir == 'Left' then
		body.LeftIn.Material = tog and "Neon" or "SmoothPlastic"
		body.LeftIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		local goal = {}
		goal.Transparency = tog and 0 or 1
		local a = ts:Create(body.RLeft, ti_rl, goal)
		a:Play()
		car.DriveSeat.LI.Value = tog
	elseif dir == 'Right' then
		body.RightIn.Material = tog and "Neon" or "SmoothPlastic"
		body.RightIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		local goal = {}
		goal.Transparency = tog and 0 or 1
		local a = ts:Create(body.RRight, ti_rl, goal)
		a:Play()
		car.DriveSeat.RI.Value = tog
	elseif dir == 'Hazards' then
		body.LeftIn.Material = tog and "Neon" or "SmoothPlastic"
		body.LeftIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		body.RightIn.Material = tog and "Neon" or "SmoothPlastic"
		body.RightIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		local goal = {}
		goal.Transparency = tog and 0 or 1
		local a = ts:Create(body.RLeft, ti_rl, goal)
		a:Play()
		a = ts:Create(body.RRight, ti_rl, goal)
		a:Play()
		
		car.DriveSeat.LI.Value = tog
		car.DriveSeat.RI.Value = tog
	end
end

function blink(typ)
	b = typ
	if blinking == true then
		blinking = false
	else
		blinking = true
		while blinking do
			Toggle(typ, true)
			script.Parent:FireClient(player, 'blink', .9, true)
			wait(1/3)
			Toggle(typ, false)
			script.Parent:FireClient(player, 'blink', 0.8, true)
			wait(1/3)
		end
		Toggle('Hazards', false)
		script.Parent:FireClient(player, 'blink', .9, false)
	end
end

script.Parent.Parent.ChildRemoved:connect(function(child)
	if child:IsA("Weld") and BlinkersEnabled then
		if blinking == true and b == 'Hazards' then
			return
		else
			blinking = false
		end
	end
end)

F.blinkers = function(dir)
	blink(dir)
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	player = pl
	F[Fnc](...)
end)