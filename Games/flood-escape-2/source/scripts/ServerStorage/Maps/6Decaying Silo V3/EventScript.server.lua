local Lib = workspace.Multiplayer.GetMapVals:Invoke() --Has: Map, Script, Button, btnFuncs
Lib.Button:connect(function(p, bNo) if Lib.btnFuncs[bNo] then Lib.btnFuncs[bNo](bNo, p) end end)

Lib.btnFuncs[1] = function()
	Lib.Script.moveWater(Lib.Map._Move.Interactive, Vector3.new(0, -11.5, 0), 1, true, "Quad", "Out")
	Lib.Script.moveWater(Lib.Map._Move.Part1, Vector3.new(0, -11.5, 0), 1, true, "Quad", "Out")
	Lib.Script.moveWater(Lib.Map._Move.Part2, Vector3.new(0, -11.5, 0), 1, true, "Quad", "Out")
	Lib.Script.moveWater(Lib.Map._Move.Part3, Vector3.new(0, -11.5, 0), 1, true, "Quad", "Out")
end

Lib.btnFuncs[2] = function()
	Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, -10, 0), 1, true, "Sine", "Out")
end

Lib.btnFuncs[3] = function()
	wait(2)
	Lib.Script.moveWater(Lib.Map._Door3._Door3, Vector3.new(0, 0, -7.5), 3, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Door3._Glass3, Vector3.new(0, 0, -7.5), 3, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Door4._Door2, Vector3.new(0, 0, 7.5), 3, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Door4._Glass2, Vector3.new(0, 0, 7.5), 3, true, "Sine", "InOut")
end

Lib.btnFuncs[4] = function()
	Lib.Script.moveWater(Lib.Map._Door3._Glass3, Vector3.new(0, 0, -7.5), 3, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Door3._Door3, Vector3.new(0, 0, -7.5), 3, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, -40, 0), 3, true, "Sine", "Out")
	task.wait(5)
	Lib.Map.nuclear:Destroy()
end

Lib.btnFuncs[5] = function()
	Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, -60, 0), 3, true, "Sine", "Out")
	wait(1)
	Lib.Script.moveWater(Lib.Map._Slide1.Metal3, Vector3.new(0, 1.75, 0), 0.5, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Slide1.SlideBeam, Vector3.new(0, 1.75, 0), 0.5, true, "Sine", "InOut")
	wait(2)
	Lib.Script.moveWater(Lib.Map._Container.Container, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.Metal3, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.Part, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.Part1, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.Part2, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.Part3, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.Part4, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.Part5, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
	Lib.Script.moveWater(Lib.Map._Container.SlideBeam, Vector3.new(0, -13, 0), 2, true, "Sine", "InOut")
end

Lib.btnFuncs[6] = function()
	wait(1)
	local TweenService = game:GetService("TweenService")

	local TweenInfo = TweenInfo.new(
		1,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut,
		0,
		false,
		0
	)
	local TweenGoals = {
		CFrame = Lib.Map.BridgeCFrame.CFrame
	}

	local Tween = TweenService:Create(Lib.Map.Bridge, TweenInfo, TweenGoals)
	-- This tween will make the part grow to 10, 10, 10 in size in a bounce shape over 2 seconds, aswell as make it red
	Tween:Play()
end


task.wait(3) -- was 1
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 115, 0), 20, true, "Sine", "Out")
task.wait(23)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 28, 0), 5, true, "Sine", "Out")
task.wait(5)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 35, 0), 7.5, true, "Sine", "InOut")
task.wait(7.5)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 28, 0), 7, true, "Sine", "In")
task.wait(8)
Lib.Map._Water1.Explosion:Play()
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 100, 0), 14.5, true)
task.wait(22)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 25, 0), 8., true)
task.wait(14)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 80, 0), 14, true, "Sine", "In")
wait(7)
--LastTower1:Play()
--LastTower2:Play()
Lib.Map._Water2.boom:Play()
Lib.Map._Water2.Alarm:Play()
Lib.Script.moveWater(Lib.Map._Water2, Vector3.new(0, 10, 0), 2, true, "Sine", "Out")
Lib.Script.moveWater(Lib.Map.Lava, Vector3.new(0, 10, 0), 2, true, "Sine", "Out")
task.wait(1.83)
Lib.Script.moveWater(Lib.Map._Water2, Vector3.new(0, 81, 0), 8, true)
Lib.Script.moveWater(Lib.Map.Lava, Vector3.new(0, 81, 0), 8, true)
Lib.Script.moveWater(Lib.Map.Door, Vector3.new(0, 81, 0), 8, true)
task.wait(5.25)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 48, 0), 8.5, true)
task.wait(1.75)
Lib.Script.moveWater(Lib.Map.LastGate.Union, Vector3.new(0, 14, 0), 3, true, "Sine", "InOut")
Lib.Script.moveWater(Lib.Map.LastGate.exclam, Vector3.new(0, 14, 0), 3, true, "Sine", "InOut")
Lib.Script.moveWater(Lib.Map.LastGate.Part1, Vector3.new(0, 14, 0), 3, true, "Sine", "InOut")
Lib.Script.moveWater(Lib.Map.LastGate.Part2, Vector3.new(0, 14, 0), 3, true, "Sine", "InOut")
Lib.Script.moveWater(Lib.Map.LastGate.Part3, Vector3.new(0, 14, 0), 3, true, "Sine", "InOut")
Lib.Map.LastGate.OpenGate:Play()
task.wait(0.25)
Lib.Script.moveWater(Lib.Map._Water2, Vector3.new(0, 40, 0), 4.5, true)
Lib.Script.moveWater(Lib.Map.Door, Vector3.new(0, 40, 0), 4.5, true)
task.wait(5)
Lib.Map.Alarm:Play()
Lib.Script.moveWater(Lib.Map._DoorEnd1, Vector3.new(0, 0, -17), 11.5, true)
Lib.Script.moveWater(Lib.Map.FinalDoor.Part, Vector3.new(0, -17.75, 0), 11.5, true)
Lib.Script.moveWater(Lib.Map.FinalDoor.SlideBeam, Vector3.new(0, -17.75, 0), 11.5, true)
Lib.Script.moveWater(Lib.Map._DoorEnd2, Vector3.new(0, 0, 17.5), 11.5, true)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 15, 0), 7.5, true)
task.wait(7.5)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 60, 0), 7, true)
