
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)

require(ReplicatedStorage.Controllers.WorldBrainrotController)

local Trove = require(ReplicatedStorage.Packages.Trove)
local v6 = Net:RemoteEvent("EggrotHunt/HarpPlay")
local t3 = {
	Start = function(_: {[any]: any}, t2: {[any]: any})
		local v10 = Trove.new()

		v10:Add(v6.OnClientEvent:Connect(function(cFrame: CFrame, s1: string?)
			SoundController:PlaySound("Sounds.Events.Easter.Harp", cFrame.Position, false)

			if not s1 then
				return
			end

			local v13 = cFrame + Vector3.new(0, 100, 0)
			local cFrame2 = CFrame.new(0, -10000, 0)
			local elapsed = os.clock()
			local u16 = nil

			u16 = RunService.PostSimulation:Connect(function()
				local v19 = t2[s1]

				if v19 and v19.model then
					v19.model:PivotTo(cFrame2)
				end

				if os.clock() - elapsed >= 4 and u16 then
					u16:Disconnect()
					u16 = nil
				end
			end)
			v10:Add(function()
				if u16 then
					u16:Disconnect()
				end
			end)
			task.wait(4)

			if u16 then
				u16:Disconnect()
			end

			local elapsed2 = os.clock()
			local connection = nil

			connection = RunService.PostSimulation:Connect(function()
				local v20 = math.clamp((os.clock() - elapsed2) / 2, 0, 1)
				local v21 = 1 - (1 - v20) * (1 - v20)
				local v22 = t2[s1]

				if not v22 or not v22.model then
					if v20 >= 1 and connection then
						connection:Disconnect()
					end

					return
				end

				local v23 = v13:Lerp(cFrame, v21)

				v22.model:PivotTo(v23)

				if v20 >= 1 and connection then
					connection:Disconnect()
				end
			end)
			v10:Add(function()
				if connection then
					connection:Disconnect()
				end
			end)
		end))

		return function()
			v10:Destroy()
		end
	end
}

return table.freeze(t3)
