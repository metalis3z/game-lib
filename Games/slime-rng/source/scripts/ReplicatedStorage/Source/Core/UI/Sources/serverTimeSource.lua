-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: serverTimeSource, time of decompilation: Sun May  3 10:11:04 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local function getTime() -- line: 6
	-- upvalues: RunService (copy)
	if RunService:IsRunning() then
		return (math.round((workspace:GetServerTimeNow())))
	end

	return os.time()
end

local v4 = require(ReplicatedStorage.Packages.Vide).source(getTime())
local u5 = v4()

task.spawn(function() -- line: 17
	-- upvalues: v4 (copy), u5 (ref), getTime (copy)
	while true do
		task.wait(1)
		v4(v4() + 1)

		if v4() - u5 >= 60 then
			v4(getTime())
			u5 = v4()
		end
	end
end)

return v4
