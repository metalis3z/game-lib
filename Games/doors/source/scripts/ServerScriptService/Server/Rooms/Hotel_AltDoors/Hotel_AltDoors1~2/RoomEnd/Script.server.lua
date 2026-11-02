local part = Instance.new("Part")
part.Anchored = true
part.Size = Vector3.new(2, 2, 2)
part.Parent = workspace
part:PivotTo(script.Parent.CFrame * CFrame.new(0, -15, -40))