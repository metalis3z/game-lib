-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IsUserInGroup, time of decompilation: Sun May  3 10:10:53 2026 ]]
local GroupService = game:GetService("GroupService")

return function(n1: number, n2: number) -- line: 3
	-- upvalues: GroupService (copy)
	local ok, result = pcall(function() -- line: 4
		-- upvalues: GroupService (copy), n1 (copy)
		return GroupService:GetGroupsAsync(n1)
	end)

	if not ok or not result then
		warn("Failed to get groups for user", n1, result)

		return false
	end

	for _, v7 in result do
		if n2 == v7.Id then
			return true
		end
	end

	return false
end
