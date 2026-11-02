-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Functions = require(Library.Functions)

return function(p1) --[[ EmitSparkles | Line: 5 | Upvalues: ReplicatedStorage (copy), Functions (copy) ]]
	Functions.Emit(p1, nil, (ReplicatedStorage.Assets.Particles:FindFirstChild("Sparkles"):Clone()))
end