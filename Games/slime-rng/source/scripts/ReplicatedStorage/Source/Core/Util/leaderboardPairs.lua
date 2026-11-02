-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: leaderboardPairs, time of decompilation: Sun May  3 10:11:09 2026 ]]
return function(p1) -- line: 3
	local n1 = 0
	local CurrentPage = p1:GetCurrentPage()

	return function() -- line: 6
		-- upvalues: n1 (ref), CurrentPage (ref), p1 (copy)
		n1 += 1

		if n1 > 100 then
			return
		end

		local v4 = CurrentPage[n1]

		if not v4 then
			if p1.IsFinished then
				return
			end

			local ok, result = pcall(function() -- line: 20
				-- upvalues: p1 (copy)
				p1:AdvanceToNextPageAsync()
			end)

			if not ok then
				warn("Failed to get next page of leaderboard data:\n", result)

				return
			end

			CurrentPage = p1:GetCurrentPage()
		end

		return v4.key, v4.value
	end
end
