-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local LocalizationService = game:GetService("LocalizationService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui

PlayerGui:WaitForChild("BackpackGui")

local Players = game:GetService("Players")
local v1 = nil
local v2, _, v3, _2, _3

if Players.LocalPlayer ~= nil then
	v2 = nil
	_ = function() --[[ getTranslator | Line: 18 | Upvalues: v2 (ref), PlayerGui (copy), LocalizationService (copy) ]]
		if v2 ~= nil then
			return v2
		end

		v2 = PlayerGui.CoreScriptLocalization:GetTranslator(LocalizationService.RobloxLocaleId)

		return v2
	end
	v3 = {}
	_2 = function(p13) --[[ getTranslatorForLocale | Line: 27 | Upvalues: v3 (copy), PlayerGui (copy) ]]
		local v1 = v3[p13]

		if v1 then
			return v1
		end

		local v2 = PlayerGui.CoreScriptLocalization:GetTranslator(p13)

		v3[p13] = v2

		return v2
	end
	_3 = function(p13, p23, p33) --[[ formatByKeyWithFallback | Line: 39 | Upvalues: v1 (ref) ]]
		local ok, result = pcall(function() --[[ Line: 40 | Upvalues: p33 (copy), p13 (copy), p23 (copy) ]]
			return p33:FormatByKey(p13, p23)
		end)

		if ok then
			return result
		end

		return v1:FormatByKey(p13, p23)
	end

	return {
		FormatByKey = function(p13, p23, p33) --[[ FormatByKey | Line: 53 | Upvalues: v2 (ref), PlayerGui (copy), LocalizationService (copy) ]]
			if v2 ~= nil then
				return v2:FormatByKey(p23, p33)
			end

			v2 = PlayerGui.CoreScriptLocalization:GetTranslator(LocalizationService.RobloxLocaleId)

			return v2:FormatByKey(p23, p33)
		end,
		FormatByKeyForLocale = function(p13, p23, p33, p43) --[[ FormatByKeyForLocale | Line: 61 | Upvalues: v3 (copy), PlayerGui (copy) ]]
			local v1 = v3[p33]
			local v2

			if v1 then
				v2 = v1
			else
				local v32 = PlayerGui.CoreScriptLocalization:GetTranslator(p33)

				v3[p33] = v32
				v2 = v32
			end

			return v2:FormatByKey(p23, p43)
		end
	}
end

Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
v2 = nil
_ = function() --[[ getTranslator | Line: 18 | Upvalues: v2 (ref), PlayerGui (copy), LocalizationService (copy) ]]
	if v2 ~= nil then
		return v2
	end

	v2 = PlayerGui.CoreScriptLocalization:GetTranslator(LocalizationService.RobloxLocaleId)

	return v2
end
v3 = {}
_2 = function(p13) --[[ getTranslatorForLocale | Line: 27 | Upvalues: v3 (copy), PlayerGui (copy) ]]
	local v1 = v3[p13]

	if v1 then
		return v1
	end

	local v2 = PlayerGui.CoreScriptLocalization:GetTranslator(p13)

	v3[p13] = v2

	return v2
end
_3 = function(p13, p23, p33) --[[ formatByKeyWithFallback | Line: 39 | Upvalues: v1 (ref) ]]
	local ok, result = pcall(function() --[[ Line: 40 | Upvalues: p33 (copy), p13 (copy), p23 (copy) ]]
		return p33:FormatByKey(p13, p23)
	end)

	if ok then
		return result
	end

	return v1:FormatByKey(p13, p23)
end

return {
	FormatByKey = function(p13, p23, p33) --[[ FormatByKey | Line: 53 | Upvalues: v2 (ref), PlayerGui (copy), LocalizationService (copy) ]]
		if v2 ~= nil then
			return v2:FormatByKey(p23, p33)
		end

		v2 = PlayerGui.CoreScriptLocalization:GetTranslator(LocalizationService.RobloxLocaleId)

		return v2:FormatByKey(p23, p33)
	end,
	FormatByKeyForLocale = function(p13, p23, p33, p43) --[[ FormatByKeyForLocale | Line: 61 | Upvalues: v3 (copy), PlayerGui (copy) ]]
		local v1 = v3[p33]
		local v2

		if v1 then
			v2 = v1
		else
			local v32 = PlayerGui.CoreScriptLocalization:GetTranslator(p33)

			v3[p33] = v32
			v2 = v32
		end

		return v2:FormatByKey(p23, p43)
	end
}