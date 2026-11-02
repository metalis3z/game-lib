-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AutoRejoinServiceClient, time of decompilation: Sun May  3 10:12:16 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Networker = require(ReplicatedStorage.Packages.Networker)
local u4 = false
local timestamp = os.time()
local thread = nil
local t1 = {
	networker = nil,
	init = function(p1) --[[ init ]] -- line: 15
		-- upvalues: Networker (copy)
		p1.networker = Networker.client.new("AutoRejoinService", p1)
		p1:enable()
	end
}

function t1.enable() -- line: 20
	-- upvalues: u4 (ref), thread (ref), timestamp (ref), t1 (copy)
	u4 = true

	if thread then
		return
	end

	timestamp = os.time()
	thread = task.spawn(function() -- line: 27
		-- upvalues: u4 (ref), timestamp (ref), t1 (copy)
		while u4 do
			if os.time() - timestamp >= 840 then
				t1.networker:fire("autoRejoin")
			end

			task.wait(5)
		end
	end)
end
function t1.disable() -- line: 37
	-- upvalues: u4 (ref), thread (ref)
	u4 = false

	if thread then
		task.cancel(thread)
		thread = nil
	end
end

UserInputService.InputEnded:Connect(function() -- line: 45
	-- upvalues: timestamp (ref)
	timestamp = os.time()
end)

return t1
