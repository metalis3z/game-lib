-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: is, time of decompilation: Sun May  3 10:10:00 2026 ]]
return function(p1) --[[ is ]] -- line: 21
	return typeof(p1) == "table" and (#p1 > 0 and next(p1, #p1) == nil)
end
