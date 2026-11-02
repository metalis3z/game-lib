-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Particles = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Particles")
local Functions = require(Library.Functions)
local Confetti = Particles:WaitForChild("Confetti")

function EmitConfetti(p1, p2, p3) --[[ EmitConfetti | Line: 8 | Upvalues: Functions (copy), Confetti (copy) ]]
	return Functions.Emit(p1, function(p1) --[[ Line: 9 | Upvalues: p2 (copy), p3 (copy), Functions (ref) ]]
		if p2 then
			p1:SetAttribute("EmitCount", (p1:GetAttribute("EmitCount") or 0) * p2)
		end

		if not p3 then
			return
		end

		Functions.Scaler()(p1, p3)
	end, Confetti:GetChildren())
end

return EmitConfetti