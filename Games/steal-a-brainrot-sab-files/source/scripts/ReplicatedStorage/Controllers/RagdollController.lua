-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Players = game:GetService("Players")
local Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")

require(Packages.Net)
require(Packages.Ragdoll)

local LocalPlayer = Players.LocalPlayer
local t2 = {
	ToggleControls = function(_: {[any]: any}, b1: boolean)
		local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
		local Controls = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls()

		if b1 == true then
			Controls:Enable()

			return
		end

		if b1 == false then
			Controls:Disable()
		end
	end,
	IsInRagdoll = function(_)
		local ServerTimeNow = workspace:GetServerTimeNow()

		return math.clamp((LocalPlayer:GetAttribute("RagdollEndTime") or ServerTimeNow) - ServerTimeNow, 0, 1e999) > 0
	end
}

function t2.Start(_)
	local thread = nil

	LocalPlayer:GetAttributeChangedSignal("RagdollEndTime"):Connect(function()
		if thread and coroutine.status(thread) ~= "dead" then
			task.cancel(thread)
		end

		thread = task.spawn(function()
			local ServerTimeNow = workspace:GetServerTimeNow()
			local v14 = math.clamp((LocalPlayer:GetAttribute("RagdollEndTime") or ServerTimeNow) - ServerTimeNow, 0, 1e999)

			if v14 < 0 then
				t2:ToggleControls(true)

				return
			end

			t2:ToggleControls(false)
			thread = coroutine.running()
			task.wait(v14)
			t2:ToggleControls(true)
		end)
	end)
end

return t2
