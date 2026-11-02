-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

local PoseController = require(script.PoseController)
local Connections = require(script.Connections)
local t = {}
local t2 = {
	__index = t
}

function t.Destroy(p1) --[[ Destroy | Line: 9 ]]
	p1.PoseController:Destroy()
	p1.Connections:Destroy()
	setmetatable(p1, nil)
	table.clear(p1)
end

return {
	new = function(p1, p2, p3) --[[ new | Line: 23 | Upvalues: PoseController (copy), Connections (copy), t2 (copy) ]]
		local v1 = p1:FindFirstChildWhichIsA("Animator", true)

		if not v1 then
			error((("Animator not found for rig %*"):format(p1)))
		end

		local v2 = PoseController.new(p1, p2)

		return setmetatable({
			_animator = v1,
			_rig = p1,
			PoseController = v2,
			Connections = Connections.new(v2, p1, p3)
		}, t2)
	end
}