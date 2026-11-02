-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local Result = v1.Result

v1:BindToMessageParallel("GetPartsInPart", function(p1, p2, p3) --[[ Line: 6 | Upvalues: Result (copy) ]]
	task.defer(Result.Fire, Result, p1:GetPartsInPart(p3, p2))
end)