-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	if typeof(p1) == "Color3" then
		return ColorSequence.new(p1)
	end

	return p1
end