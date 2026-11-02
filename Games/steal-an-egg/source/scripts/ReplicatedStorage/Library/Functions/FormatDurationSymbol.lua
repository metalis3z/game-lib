-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatDuration = require(script.Parent.FormatDuration)
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 11 | Upvalues: Asserts (copy), FormatDuration (copy) ]]
	Asserts.number(p1)

	local v2 = math.ceil((math.max(p1, 0)))

	if v2 < 60 then
		return FormatDuration(v2)
	end

	if v2 < 3600 then
		local v3 = v2 // 60
		local v4 = v2 % 60

		if v4 <= 0 then
			return ("%*m"):format(v3)
		end

		return ("%*m %*s"):format(v3, v4)
	end

	if v2 < 86400 then
		local v5 = v2 // 3600
		local v6 = v2 % 3600 // 60

		if v6 <= 0 then
			return ("%*h"):format(v5)
		end

		return ("%*h %*m"):format(v5, v6)
	end

	local v7 = v2 // 86400
	local v8 = v2 % 86400 // 3600

	if v8 <= 0 then
		return ("%*d"):format(v7)
	end

	return ("%*d %*h"):format(v7, v8)
end