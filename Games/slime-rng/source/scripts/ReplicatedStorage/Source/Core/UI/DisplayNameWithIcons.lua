-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DisplayNameWithIcons, time of decompilation: Sun May  3 10:10:56 2026 ]]
return function(p1) -- line: 1
	local s1 = ""

	if p1.HasVerifiedBadge then
		s1 = utf8.char(57344) .. " "
	end

	if p1.MembershipType == Enum.MembershipType.Premium then
		s1 ..= utf8.char(57345) .. " "
	end

	return s1 .. p1.DisplayName
end
