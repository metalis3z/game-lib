local ContextActionService = game:GetService("ContextActionService")

local XboxModule = {}

function XboxModule.Bind(actionName, inputTypes, functionToBind)
	ContextActionService:BindAction(actionName, function(player, inputState, inputObject)
		if inputState == Enum.UserInputState.Begin and not _G.PauseBinds then
			functionToBind()
		end
	end, false, inputTypes)
end

function XboxModule.Unbind(actionName)
	ContextActionService:UnbindAction(actionName)
end

return XboxModule