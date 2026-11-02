--credit to quartz games studio
return {
	new = function(p1) --[[ new | Line: 4 ]]
		local v2 = p1.Delay or 1
		local v3 = p1.SizeMin or Vector3.new(1, 1, 1)
		local v4 = p1.SizeMax or Vector3.new(1, 1, 1)
		local v5 = p1.Colors or { Color3.new(255/255, 255/255, 255/255) }
		local v6 = p1.Material or Enum.Material.Plastic
		local v7 = p1.Velocity or 30
		local _ = p1.Direction or Vector3.new(0, 1, 0)
		local v8 = p1.Spread or 45
		local v9 = p1.Lifetime or 3
		local Origin = p1.Origin
		local v10 = Random.new()
		local t = {}

		for i = 1, p1.Amount or 4 do
			local Part = Instance.new("Part")

			Part.Anchored = false
			Part.CanCollide = true
			Part.Size = Vector3.new(v10:NextNumber(v3.X, v4.X), v10:NextNumber(v3.Y, v4.Y), v10:NextNumber(v3.Z, v4.Z))
			Part.Transparency = 0
			Part.CFrame = Origin
			Part.Material = v6
			Part.Color = v5[math.random(1, #v5)]
			table.insert(t, Part)
		end

		for v13, v14 in t do
			v14.Parent = workspace.Temporary
			game.Debris:AddItem(v14, v9 + v2)

			local v15 = v10:NextNumber(-v8, v8)
			local v16 = v10:NextNumber(-v8, v8)

			v14:ApplyImpulse((Origin * CFrame.Angles(0, math.rad(v15), 0) * CFrame.Angles(math.rad(v16), 0, 0)).LookVector * v7 * v14.AssemblyMass)
			task.delay(v2, function() --[[ Line: 65 | Upvalues: v14 (copy), v9 (copy) ]]
				game.TweenService:Create(v14, TweenInfo.new(v9), {
					Size = Vector3.new(0, 0, 0)
				}):Play()
				task.delay(0.1, function() --[[ Line: 67 | Upvalues: v14 (ref) ]]
					v14.CanCollide = true
				end)
			end)
		end
	end
}