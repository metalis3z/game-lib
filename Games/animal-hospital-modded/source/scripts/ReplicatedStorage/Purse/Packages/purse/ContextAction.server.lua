local ContextActionService = game:GetService("ContextActionService")
local v1 = require(script.Parent)

ContextActionService:BindAction("BackpackToggle", function(p1, p2, p3) --[[ handleAction | Line: 8 | Upvalues: v1 (copy) ]]
	if p1 ~= "BackpackToggle" or (p2 ~= Enum.UserInputState.Begin or not v1.OpenClose) then
		return
	end

	v1.OpenClose()
end, false, Enum.KeyCode.Backquote)