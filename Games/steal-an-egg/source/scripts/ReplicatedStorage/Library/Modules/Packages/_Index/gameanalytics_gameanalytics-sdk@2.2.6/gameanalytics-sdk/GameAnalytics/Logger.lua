-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	_infoLogEnabled = false,
	_infoLogAdvancedEnabled = false,
	_debugEnabled = game:GetService("RunService"):IsStudio(),
	setDebugLog = function(p1, p2) --[[ setDebugLog | Line: 10 ]]
		p1._debugEnabled = p2
	end,
	setInfoLog = function(p1, p2) --[[ setInfoLog | Line: 14 ]]
		p1._infoLogEnabled = p2
	end,
	setVerboseLog = function(p1, p2) --[[ setVerboseLog | Line: 18 ]]
		p1._infoLogAdvancedEnabled = p2
	end,
	i = function(p1, p2) --[[ i | Line: 22 ]]
		if p1._infoLogEnabled then
			print("Info/GameAnalytics: " .. p2)
		end
	end,
	w = function(p1, p2) --[[ w | Line: 38 ]]
		warn("Warning/GameAnalytics: " .. p2)
	end,
	e = function(p1, p2) --[[ e | Line: 50 ]]
		task.spawn(function() --[[ Line: 51 | Upvalues: p2 (copy) ]]
			error("Error/GameAnalytics: " .. p2, 0)
		end)
	end,
	d = function(p1, p2) --[[ d | Line: 64 ]]
		if p1._debugEnabled then
			print("Debug/GameAnalytics: " .. p2)
		end
	end,
	ii = function(p1, p2) --[[ ii | Line: 80 ]]
		if p1._infoLogAdvancedEnabled then
			print("Verbose/GameAnalytics: " .. p2)
		end
	end
}