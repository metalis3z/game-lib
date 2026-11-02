script.Parent:SetAttribute("JumpModifier", 2)
script.Parent:SetAttribute("SpeedModifier", 1.5)

script.Parent.Equipped:Connect(function()
	script.Parent.Handle.CoilSound:Play()
	script.Parent.Handle.CoilSound2:Play()
end)