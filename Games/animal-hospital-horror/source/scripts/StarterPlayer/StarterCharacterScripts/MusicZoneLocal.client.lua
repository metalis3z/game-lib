local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

task.wait(1)

local v1 = script.Parent
local Humanoid = v1:WaitForChild("Humanoid")
local Areas = workspace:WaitForChild("Areas")
local v2 = RaycastParams.new()

v2.FilterType = Enum.RaycastFilterType.Include
v2.CollisionGroup = "MusicZone"

local v3 = Lib.CS:GetTagged("MusicZone")

for i, v in ipairs(v3) do
	v.Transparency = 1
	v.Parent = Areas
end

v2.FilterDescendantsInstances = v3;
(function() --[[ loop | Line: 25 | Upvalues: v1 (copy), Humanoid (copy), v2 (copy), Lib (copy) ]]
	while v1 and (v1.Parent and Humanoid.Health > 0) do
		task.wait(0.2)

		if workspace.CurrentCamera:HasTag("InCutscene") or game.Players:HasTag("GameOver") then
			continue
		end

		local v12 = workspace:Raycast(v1:GetPivot().Position, Vector3.new(0, 50, 0), v2)

		if v12 and v12.Instance then
			local v22 = v12.Instance:GetAttribute("MusicTrack")

			if not v22 or v22 == "" then
				v22 = "HouseSlow"
			end

			v1:SetAttribute("Zone", v12.Instance.Name)

			local v3 = Lib.MusicService.GetCurrent()

			if not v3 or v3.Name ~= v22 then
				local v4 = Lib.MusicService.Get(v22)

				if v4 then
					v4:Broadcast(0.1)

					continue
				end

				print(v22, "not found")
			end

			continue
		end

		v1:SetAttribute("Zone", nil)
	end
end)()