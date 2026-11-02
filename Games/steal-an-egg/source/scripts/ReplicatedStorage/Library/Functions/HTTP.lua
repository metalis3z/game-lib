-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")

return function(p1) --[[ HTTP | Line: 32 | Upvalues: HttpService (copy) ]]
	local ok, result = pcall(function() --[[ Line: 33 | Upvalues: HttpService (ref), p1 (copy) ]]
		return HttpService:RequestAsync(p1)
	end)

	if ok and type(result) == "table" then
		return result
	end

	return {
		Success = false,
		StatusCode = 400,
		Body = nil,
		TransportError = true,
		StatusMessage = tostring(result),
		Headers = {}
	}
end