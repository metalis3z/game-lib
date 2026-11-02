function onPlayerDied(dead)
	local h = script.Parent.Humanoid
		if (h.Health==0) then
			local head = script.Parent.Head
			local blood1 = Instance.new("Part")
			blood1.BrickColor = BrickColor.new(21)
			blood1.formFactor = 2
			blood1.Size = Vector3.new(1, 0.4, 1)
			blood1.Position = head.Position
			blood1.Name = "Blood"
			blood1.Parent = script.Parent
           blood1.Locked = true
			local blood2 = Instance.new("Part")
			blood2.BrickColor = BrickColor.new(21)
			blood2.formFactor = 2
			blood2.Size = Vector3.new(1, 0.4, 1)
			blood2.Position = head.Position
			blood2.Name = "Blood"
			blood2.Parent = script.Parent
                        blood2.Locked = true
			local blood3 = Instance.new("Part")
			blood3.BrickColor = BrickColor.new(21)
			blood3.formFactor = 2
			blood3.Size = Vector3.new(1, 0.4, 1)
			blood3.Position = head.Position
			blood3.Name = "Blood"
			blood3.Parent = script.Parent
                                   blood3.Locked = true
			local blood4 = Instance.new("Part")
			blood4.BrickColor = BrickColor.new(21)
			blood4.formFactor = 2
			blood4.Size = Vector3.new(1, 0.4, 1)
			blood4.Position = head.Position
			blood4.Name = "Blood"
			blood4.Parent = script.Parent
           blood4.Locked = true
			
		end
end

script.Parent.Humanoid.Died:connect(onPlayerDied)
