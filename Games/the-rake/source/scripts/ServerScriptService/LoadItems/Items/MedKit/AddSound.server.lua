local Tool = script.Parent

script.Parent.Equipped:Connect(function()
	Tool.Handle.HealSound.Parent = script.Parent.Parent.Head
	script.Disabled = true
	script:Destroy()
end)