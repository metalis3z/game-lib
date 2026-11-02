local t = {}
local PlayerModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))

function t.Disable() --[[ Disable | Line: 4 | Upvalues: PlayerModule (copy) ]]
	PlayerModule:GetControls():Disable()
end
function t.Enable() --[[ Enable | Line: 9 | Upvalues: PlayerModule (copy) ]]
	PlayerModule:GetControls():Enable()
end

return t