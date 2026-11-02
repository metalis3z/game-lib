--credit to quartz games studio
local EmitOnce = require(game.ReplicatedStorage.UserGenerated.VFX.EmitOnce)

local function v1(p1) --[[ Emit | Line: 22 | Upvalues: EmitOnce (copy), v1 (copy) ]]
	local v12 = 0

	if p1:IsA("ParticleEmitter") then
		v12 = math.max(v12, EmitOnce(p1))
	end

	for i, v in ipairs(p1:GetChildren()) do
		v12 = math.max(v12, v1(v))
	end

	return v12
end

return v1