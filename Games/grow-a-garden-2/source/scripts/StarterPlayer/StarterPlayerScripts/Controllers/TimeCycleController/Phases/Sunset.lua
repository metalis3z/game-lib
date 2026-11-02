--credit to prince games studio
local t = {}
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)
local t2 = {
	ClockTime = 17
}

function t.Start(p1, p2, p3) --[[ Start | Line: 9 | Upvalues: LightingController (copy), t2 (copy) ]]
	local t = {}

	for v1, v2 in LightingController:GetDefault() do
		t[v1] = v2
	end

	for v3, v4 in t2 do
		t[v3] = v4
	end

	LightingController:TransitionTo(t)
end
function t.End(p1) --[[ End | Line: 20 ]] end

return t