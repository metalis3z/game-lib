local Lib = workspace.Multiplayer.GetMapVals:Invoke() --Has: Map, Script, Button, btnFuncs
Lib.Button:connect(function(p, bNo) if Lib.btnFuncs[bNo] then Lib.btnFuncs[bNo](bNo, p) end end)

wait(4)
Lib.Script.moveWater(Lib.Map.Intro._Water1, Vector3.new(0, 38, 0), 11, true)
wait(12)
Lib.Script.moveWater(Lib.Map.Intro._Water1, Vector3.new(0, 26, 0), 28, true)
wait(34)
Lib.Script.setWaterState(Lib.Map.Intro._Water1, "acid")
Lib.Script.moveWater(Lib.Map.Intro._Water1, Vector3.new(0, 31, 0), 14, true)
wait(18)
Lib.Script.moveWater(Lib.Map.Intro._Water1, Vector3.new(0, 50, 0), 12, true)