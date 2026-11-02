local Lib = require(game.ReplicatedStorage.Lib)
local keys = Lib.UI.Get("Objective"):WaitForChild("Frame"):WaitForChild("keys")
local v1 = require(Lib.UI.GetScript("OffscreenPointer"))
local t = {}

local function SetObjective(p1, p2, p3) --[[ SetObjective | Line: 7 | Upvalues: keys (copy), Lib (copy), v1 (copy) ]]
	keys.objective.Text = p1 or ""

	if p1 and (not p2 and p1 ~= "") then
		Lib.MusicService.Get("mission"):Play()
	end

	keys.Visible = if p1 then p1 ~= "" else p1

	if p3 then
		Lib.SetPointerTarget(p3)
	else
		v1.ClearTarget()
	end
end

keys.Visible = false
Lib.Network:BindEvents({
	SetObjective = SetObjective,
	SetObjectiveByLocation = function(p1, p2, p3) --[[ SetObjectiveByLocation | Line: 24 | Upvalues: t (copy), keys (copy), Lib (copy), v1 (copy) ]]
		t[p1] = p2
		keys.objective.Text = p2 or ""

		if p2 and (not p3 and p2 ~= "") then
			Lib.MusicService.Get("mission"):Play()
		end

		keys.Visible = if p2 then p2 ~= "" else p2
		v1.ClearTarget()
	end
})

return {}