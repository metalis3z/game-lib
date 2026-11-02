local mapScript = require(game.ServerScriptService.MapScript)
local btnPress = game.ServerStorage.Bindables.BtnPress

local btnFuncs = {} 

btnPress.Event:connect(function(plr, btnNo) if btnFuncs[btnNo] then  btnFuncs[btnNo](btnNo, plr) end end)

spawn(function()
	wait(18.5)
	for i,v in pairs(script.Parent.Intro.FloatingBoxes:GetChildren()) do
		v.Anchored = false
		local vel = Instance.new("BodyVelocity",v)
		vel.MaxForce = Vector3.new(0,math.huge,0)
		mapScript.moveWater(v, Vector3.new(0, 14, 0), 1, true)
	end
end)

wait(14.5)
mapScript.moveWater(script.Parent._Water1, Vector3.new(0, 84.5, 0), 9, true)

wait(30.5)
mapScript.setWaterState(script.Parent._Water1,"acid")

wait(30)
mapScript.moveWater(script.Parent._Water1, Vector3.new(0, 100, 0), 10, true)

wait(2)
mapScript.setWaterState(script.Parent._Water1,"lava")