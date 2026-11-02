--credit to leon games studio
local StarterGui = game:GetService("StarterGui")
local Window = require(script.Parent.CmdrInterface.Window)

return function(p1) --[[ Line: 4 | Upvalues: StarterGui (copy), Window (copy) ]]
	p1:HandleEvent("Message", function(p1) --[[ Line: 5 | Upvalues: StarterGui (ref) ]]
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = ("[Announcement] %s"):format(p1),
			Color = Color3.fromRGB(249, 217, 56)
		})
	end)
	p1:HandleEvent("AddLine", function(...) --[[ Line: 12 | Upvalues: Window (ref) ]]
		Window:AddLine(...)
	end)
end