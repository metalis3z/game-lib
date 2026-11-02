-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")

return function() --[[ Line: 3 | Upvalues: HttpService (copy) ]]
	return HttpService:GenerateGUID(false):gsub("-", ""):lower()
end