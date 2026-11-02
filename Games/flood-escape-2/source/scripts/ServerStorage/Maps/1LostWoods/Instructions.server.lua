local mapScript = workspace.Multiplayer.GetMapVals:Invoke() --Has: Map, Script, Button, btnFuncs
mapScript.Button:connect(function(p, bNo) if mapScript.btnFuncs[bNo] then mapScript.btnFuncs[bNo](bNo, p) end end)

wait(4)
mapScript.Script.moveWater(mapScript.Map.Intro._Water1, Vector3.new(0, 38, 0), 11, true)
wait(12)
mapScript.Script.moveWater(mapScript.Map.Intro._Water1, Vector3.new(0, 26, 0), 28, true)
wait(34)
mapScript.Script.setWaterState(mapScript.Map.Intro._Water1, "acid")
mapScript.Script.moveWater(mapScript.Map.Intro._Water1, Vector3.new(0, 31, 0), 14, true)
wait(18)
mapScript.Script.moveWater(mapScript.Map.Intro._Water1, Vector3.new(0, 50, 0), 12, true)