--credit to quartz games studio
local t = {}
local ClientModules = game:GetService("ReplicatedStorage"):WaitForChild("ClientModules")
local FieldOfViewController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)
local FramePopup = require(ClientModules.FramePopup)
local v1 = false

function t.CanSpeak() --[[ CanSpeak | Line: 12 | Upvalues: v1 (ref) ]]
	return not v1
end
function t.StartSpeaking() --[[ StartSpeaking | Line: 16 | Upvalues: v1 (ref), FieldOfViewController (copy) ]]
	v1 = true
	FieldOfViewController:SetAdjuster(-5)
end
function t.EndSpeaking() --[[ EndSpeaking | Line: 21 | Upvalues: v1 (ref), FramePopup (copy), FieldOfViewController (copy) ]]
	v1 = false

	if not FramePopup.CanInteract() then
		return
	end

	FieldOfViewController:ClearAdjuster()
end

return t