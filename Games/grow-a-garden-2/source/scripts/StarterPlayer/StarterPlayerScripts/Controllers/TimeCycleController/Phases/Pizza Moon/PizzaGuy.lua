--credit to leon games studio
local t = {}
local Spring2 = require(game.ReplicatedStorage.ClientModules.Spring2)

t.__index = t
function t.new(p1) --[[ new | Line: 5 | Upvalues: Spring2 (copy), t (copy) ]]
	local v1 = Spring2.new(p1:GetPivot().Position)

	v1.Speed = 11
	v1.Damper = 0.85

	local t2 = {
		MainRoot = p1,
		Spring = v1,
		Target = p1:GetPivot()
	}

	setmetatable(t2, t)

	return t2
end
function t.Start(p1) --[[ Start | Line: 24 ]]
	p1.MainRoot.PizzaRig.Humanoid:LoadAnimation(game.ReplicatedStorage.Assets.Animations.FlyLoop):Play()
	p1.Active = true
	task.spawn(function() --[[ Line: 29 | Upvalues: p1 (copy) ]]
		while p1.Active do
			local v1 = game:GetService("RunService").Heartbeat:Wait()
			local v2 = tick() * 2
			local v8 = Vector3.new(math.cos((math.rad(v2 * 3))) * 0.3, math.sin(v2 * 2.2) * 0.4, math.cos((math.rad(v2 * 1.6))) * 0.1)
			local v9 = p1.MainRoot:GetPivot():VectorToObjectSpace(v8)

			p1.Spring.Target = p1.MainRoot:GetPivot().Position + v9
			p1.Spring:Update(v1)

			local Position = p1.Spring.Position
			local v10 = CFrame.new(Position, Position + p1.MainRoot:GetPivot().LookVector)

			p1.MainRoot.PizzaRig:PivotTo(v10 * CFrame.Angles(math.cos(tick() * 2) * 0.06, math.sin(tick() * 1.5) * 0.1, math.sin(tick() * 2) * 0.1))
		end
	end)
end
function t.Stop(p1) --[[ Stop | Line: 57 ]]
	p1.Active = false
end

return t