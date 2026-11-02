--credit to quartz games studio
game:GetService("RunService")

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CreateTrail = require(script.CreateTrail)

return {
	Init = function(p1, p2) --[[ Init | Line: 11 | Upvalues: TweenService (copy), CreateTrail (copy), Debris (copy) ]]
		local v2 = p2.Radius or nil
		local v3 = p2.Lifetime or (1 / 0)
		local v4 = p2.Time or 0.45
		local v5 = p2.Offset or 0.05

		for i = 1, p2.Frequency or (1 / 0) do
			local v6 = 0
			local v8 = p2.Color or Color3.fromRGB(255, 255, 255)
			local v10 = TweenInfo.new(v4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.CanCollide = false
			Part.CanTouch = false
			Part.CanQuery = false
			Part.CFrame = p1.CFrame * CFrame.new(0, -(p1.Size.Y / 2), 0)
			Part.Size = Vector3.new(1, 1, 1)
			Part.Transparency = 1
			Part.Parent = p1
			TweenService:Create(Part, v10, {
				Orientation = Part.Orientation + Vector3.new(0, 360, 0)
			}):Play()

			local Part2 = Instance.new("Part")

			Part2.Anchored = true
			Part2.CanCollide = false
			Part2.CanTouch = false
			Part2.CanQuery = false
			Part2.CFrame = Part.CFrame
			Part2.Size = Vector3.new(1, 1, 1)
			Part2.Transparency = 1
			Part2.Parent = workspace.Temporary

			local v11 = CreateTrail(Part2, p2.Size or 0.275, v8, p2.Transparency or 0)
			local v12 = task.spawn(function() --[[ Line: 54 | Upvalues: v6 (ref), v3 (copy), Part (copy), v5 (copy), v2 (copy), p1 (copy), Part2 (copy) ]]
				repeat
					local v1 = task.wait(0)

					v6 = (v6 + v1 / v3) % 1
					Part.CFrame = Part.CFrame * CFrame.new(0, v5 * v1, 0)

					local v32 = v2

					if not v32 then
						v32 = math.sqrt(p1.Size.X ^ 2 + p1.Size.Y ^ 2) / 2
					end

					Part2.CFrame = Part.CFrame * CFrame.Angles(0, 6.283185307179586 * v6, 0) * CFrame.new(0, 0, v32)
				until not v32
			end)

			task.wait(1.35)
			v11.Enabled = false
			Debris:AddItem(Part, 1)
			Debris:AddItem(Part2, 1)
			task.wait(1)
			task.cancel(v12)
		end
	end
}