local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("CollectionService")
task.wait(1)

local v1 = script.Parent
local Humanoid = v1:WaitForChild("Humanoid")
local v2 = RaycastParams.new()

v2.FilterType = Enum.RaycastFilterType.Include

local v3 = nil
local v4 = nil

(function() --[[ loop | Line: 15 | Upvalues: v1 (copy), Humanoid (copy), Lib (copy), v2 (copy), v3 (ref), v4 (ref) ]]
	while v1 and (v1.Parent and Humanoid.Health > 0) do
		task.wait(0.1)

		if workspace.CurrentCamera:HasTag("InCutscene") then
			continue
		end

		v2.FilterDescendantsInstances = Lib.CS:GetTagged("FloorModifier")

		local v12 = workspace:Raycast(v1.PrimaryPart.Position, Vector3.new(0, -10, 0), v2)

		if v12 and v12.Instance then
			if not v3 then
				local Sound = v12.Instance:FindFirstChildOfClass("Sound")
				local v22 = v12.Instance.Parent:GetAttribute("SpeedMod") or 1

				v4 = v22

				if Sound then
					Sound:Play()
				end

				local v32 = Humanoid

				v32.WalkSpeed = v32.WalkSpeed * v22
			end

			v3 = v12.Instance

			continue
		end

		if v3 then
			local v5 = Humanoid

			v5.WalkSpeed = v5.WalkSpeed / (v4 or (v3.Parent:GetAttribute("SpeedMod") or 1))
			v4 = nil
		end

		v3 = nil
	end

	print("end")
end)()