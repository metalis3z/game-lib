script.Parent:SetAttribute("JumpModifier", 2)

script.Parent.Equipped:Connect(function()
	script.Parent.Handle.CoilSound:Play()
end)