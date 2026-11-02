--credit to prince games studio
local BehaviorBase = require(script.Parent.BehaviorBase)
local StealFruit = setmetatable({}, {
	__index = BehaviorBase
})

StealFruit.__index = StealFruit
StealFruit.Name = "StealFruit"
function StealFruit.new(p1) --[[ new | Line: 10 | Upvalues: BehaviorBase (copy), StealFruit (copy) ]]
	local v1 = BehaviorBase.New(StealFruit, p1)

	v1.TargetPlayer = nil
	v1.TargetPlantId = nil
	v1.TargetFruitId = nil
	v1.CarriedFruitData = nil
	v1.States = {
		Targeting = {
			Enter = function(p1) --[[ Enter | Line: 23 ]]
				p1:Stop("NotImplemented")
			end
		}
	}

	return v1
end
function StealFruit.GetInitialState(p1) --[[ GetInitialState | Line: 33 ]]
	return "Targeting"
end
function StealFruit.CanStart(p1) --[[ CanStart | Line: 38 ]]
	return true
end

return StealFruit