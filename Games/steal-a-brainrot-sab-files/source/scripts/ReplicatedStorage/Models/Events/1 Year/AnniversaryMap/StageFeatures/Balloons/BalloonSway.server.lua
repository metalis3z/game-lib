
if not script:IsDescendantOf(workspace) then
	return
end

local RunService = game:GetService("RunService")
local scriptParent = script.Parent

for _, v in ipairs(scriptParent:GetDescendants()) do
	if v.Name == "Balloon" and v:IsA("BasePart") then
		task.spawn(function()
			local random = Random.new()
			local vCFrame = v.CFrame
			local v7 = random:NextNumber(0.4, 0.8)
			local v8 = random:NextNumber(2, 4)
			local v9 = random:NextNumber(0.08726646259971647, 0.17453292519943295)
			local v10 = random:NextNumber(0, 6.283185307179586)

			while v.Parent do
				local v11 = os.clock() * v7 + v10
				local v12 = math.sin(v11) * v8
				local v13 = math.sin(v11) * v9

				v.CFrame = vCFrame * CFrame.new(0, v12, 0) * CFrame.Angles(v13, 0, v13)
				RunService.Heartbeat:Wait()
			end
		end)
	end
end
