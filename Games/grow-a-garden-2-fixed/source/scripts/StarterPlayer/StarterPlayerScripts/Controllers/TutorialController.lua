--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local TutorialRunner = require(script.TutorialRunner)

return {
	StartOrder = 3,
	Init = function(p1) --[[ Init | Line: 10 ]] end,
	Start = function(p1) --[[ Start | Line: 12 | Upvalues: Networking (copy), TutorialRunner (copy) ]]
		local v1 = false

		Networking.Tutorial.Start.OnClientEvent:Connect(function(p1) --[[ Line: 14 | Upvalues: v1 (ref), TutorialRunner (ref) ]]
			if not v1 then
				v1 = true
				TutorialRunner(p1)
			end
		end)
		task.spawn(function() --[[ Line: 22 | Upvalues: v1 (ref), Networking (ref) ]]
			local LocalPlayer = game:GetService("Players").LocalPlayer

			while assert(LocalPlayer):GetAttribute("LoadingScreenDone") ~= true do
				task.wait(0.5)
			end

			local count = 0

			while not v1 and count < 30 do
				Networking.Tutorial.Ready:Fire()
				task.wait(2)
				count = count + 1
			end
		end)
	end
}