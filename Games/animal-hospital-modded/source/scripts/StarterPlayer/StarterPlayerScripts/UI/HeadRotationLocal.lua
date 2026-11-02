local CS = require(game.ReplicatedStorage:WaitForChild("Lib")).CS
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

local function RotateHeadsLoop() --[[ RotateHeadsLoop | Line: 8 | Upvalues: LocalPlayer (copy), CS (copy), CurrentCamera (copy) ]]
	local Character = LocalPlayer.Character

	if not (Character and Character.PrimaryPart) then
		return
	end

	for i, v in ipairs(CS:GetTagged("HeadRotationEnabled")) do
		if v:IsDescendantOf(workspace) then
			local v1 = v:FindFirstChild("NeckBone") and v.NeckBone.Value

			if v1 then
				local v2 = v1:GetAttribute("HeadRotationFull")
				local v3 = v1:GetAttribute("HeadRotationMax")

				v1.WorldCFrame = CFrame.new(v1.WorldCFrame.Position, CurrentCamera.CFrame.Position)

				local v4 = if v3 then 10000 else 15

				if v1.Orientation.X < -v4 then
					v1.Orientation = Vector3.new(-v4, v1.Orientation.Y, v1.Orientation.Z)
				elseif v4 < v1.Orientation.X then
					v1.Orientation = Vector3.new(v4, v1.Orientation.Y, v1.Orientation.Z)
				end

				local v5 = if v3 then 10000 elseif v2 then 100 else 50

				if v5 < v1.Orientation.Y then
					v1.Orientation = Vector3.new(v1.Orientation.X, v5, v1.Orientation.Z)

					continue
				end

				if v1.Orientation.Y < -v5 then
					v1.Orientation = Vector3.new(v1.Orientation.X, -v5, v1.Orientation.Z)
				end
			end

			continue
		end

		v:RemoveTag("HeadRotationEnabled")
	end
end

task.spawn(function() --[[ Line: 38 | Upvalues: RotateHeadsLoop (copy), RunService (copy) ]]
	while true do
		RotateHeadsLoop()
		RunService.Stepped:Wait()
	end
end)
CS:GetInstanceRemovedSignal("HeadRotationEnabled"):Connect(function(p1) --[[ Line: 45 ]]
	if not p1:IsDescendantOf(workspace) then
		return
	end

	local v1 = p1:FindFirstChild("NeckBone") and p1.NeckBone.Value

	task.wait(0.1)
	v1.CFrame = v1:GetAttribute("OriginalCFrame")
end)

return {}