-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	while p1 and p1.Parent do
		if p1:IsA("ScreenGui") then
			return p1.Enabled
		end

		if p1.Visible == false then
			break
		end

		p1 = p1.Parent
	end

	return false
end