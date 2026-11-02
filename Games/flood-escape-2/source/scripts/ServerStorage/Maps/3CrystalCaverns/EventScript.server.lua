local Lib = workspace.Multiplayer.GetMapVals:Invoke() --Has: Map, Script, Button, btnFuncs, and Conveyors
Lib.Button:connect(function(p, bNo) if Lib.btnFuncs[bNo] then Lib.btnFuncs[bNo](bNo, p) end end)

wait(33)
Lib.Script.moveWater(Lib.Map._Water1, Vector3.new(0, 112, 0), 18.5, true)