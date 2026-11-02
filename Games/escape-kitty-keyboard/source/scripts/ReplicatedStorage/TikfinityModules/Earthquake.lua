

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = {
	["DURATION"] = 2.5,
	["INTENSITY"] = 1.5,
	["FREQUENCY"] = 0.03
}
function v1.Run(p4) 

	local v5 = p4.Character
	if v5 then
		local u6 = v5:FindFirstChildOfClass("Humanoid")
		if u6 then
			task.spawn(function()

				local u7 = os.clock()
				local u8 = nil
				u8 = u2.RenderStepped:Connect(function()

					local v9 = os.clock() - u7
					if u3.DURATION <= v9 then
						u6.CameraOffset = Vector3.new(0, 0, 0)
						u8:Disconnect()
					else
						local v10 = 1 - v9 / u3.DURATION
						local v11 = u3.INTENSITY * v10
						local v12 = u6
						local v13 = (math.random() - 0.5) * 2 * v11
						local v14 = (math.random() - 0.5) * 2 * v11
						local v15 = (math.random() - 0.5) * 2 * v11 * 0.3
						v12.CameraOffset = Vector3.new(v13, v14, v15)
					end
				end)
			end)
		end
	else
		return
	end
end
return v1