-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Sentries = Workspace.__OBJECTS.Sentries

assert(Sentries:IsA("Folder"), "Workspace.__OBJECTS.Sentries must be a Folder")

return function(p1, p2) --[[ Line: 23 | Upvalues: Asserts (copy), Sentries (copy) ]]
	Asserts.Vector3(p1)
	Asserts.number(p2)

	for i, v in ipairs(Sentries:GetChildren()) do
		if v:IsA("Model") and (v:GetPivot().Position - p1).Magnitude <= p2 then
			v:Destroy()
		end
	end
end