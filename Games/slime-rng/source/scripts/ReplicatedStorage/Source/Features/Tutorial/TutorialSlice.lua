-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TutorialSlice, time of decompilation: Sun May  3 10:12:00 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)

return {
	step = function() -- line: 5
		-- upvalues: getDataSource (copy)
		return getDataSource({
			"tutorial",
			"step"
		})
	end,
	completed = function() -- line: 9
		-- upvalues: getDataSource (copy)
		return getDataSource({
			"tutorial",
			"completed"
		})
	end
}
