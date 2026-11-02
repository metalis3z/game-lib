script.parent.Equipped:Connect(function()
	script.Parent.Base.VestSound.Parent=script.Parent.Parent.Head
	script:Destroy()
end)