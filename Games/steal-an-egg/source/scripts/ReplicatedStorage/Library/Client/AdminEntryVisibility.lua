-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local v1 = UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled
local v2 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local v3 = false
local t = {
	Changed = Signal.new(),
	IsVisible = function() --[[ IsVisible | Line: 26 | Upvalues: v1 (copy), v3 (ref) ]]
		return v1 and v3
	end
}

function t.IsAdminPanelVisible() --[[ IsAdminPanelVisible | Line: 30 | Upvalues: v2 (copy), t (copy) ]]
	return if game.PlaceId == 106402047758394 then true else v2 or t.IsVisible()
end
UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 38 | Upvalues: v1 (copy), v3 (ref), t (copy) ]]
	if v1 and (not p2 and p1.KeyCode == Enum.KeyCode.F8) then
		v3 = not v3
		t.Changed:Fire(v3)
	end
end)

return t