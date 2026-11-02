local Lib = workspace.Multiplayer.GetMapVals:Invoke() --Has: Map, Script, Button, btnFuncs
Lib.Button:connect(function(p, bNo) if Lib.btnFuncs[bNo] then Lib.btnFuncs[bNo](bNo, p) end end)


wait(11.5)
Lib.Script.moveWater(Lib.Map._Door1, Vector3.new(0, 56, 0), 7, true)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 56, 0), 7, true)

wait(10.5)
Lib.Script.moveWater(Lib.Map._Door2, Vector3.new(0, 56, 0), 7, true)
Lib.Script.moveWater(Lib.Map._Water2, Vector3.new(0, 56, 0), 7, true)

wait(14.5)
Lib.Script.moveWater(Lib.Map._Door3, Vector3.new(0, 128, 0), 10.5, true)
Lib.Script.moveWater(Lib.Map._Water3, Vector3.new(0, 128, 0), 10.5, true)

wait(38.5)
Lib.Script.moveWater(Lib.Map._Door4, Vector3.new(0, 59, 0), 7, true)
Lib.Script.moveWater(Lib.Map._Water4, Vector3.new(0, 59, 0), 7, true)

wait(10)
Lib.Script.moveWater(Lib.Map._Water5, Vector3.new(0, 165, 0), 24, true)