-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local EmitOne = require(game.ReplicatedStorage.Library.Functions.EmitOne)

function EmitDescendants(p1, p2) --[[ EmitDescendants | Line: 10 | Upvalues: EmitOne (copy) ]]
	local v1 = 0

	if p1:IsA("ParticleEmitter") then
		v1 = math.max(v1, EmitOne(p1, p2))
	end

	for i, v in ipairs(p1:GetChildren()) do
		v1 = math.max(v1, EmitDescendants(v, p2))
	end

	return v1
end

return EmitDescendants