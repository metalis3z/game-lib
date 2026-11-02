local connection
connection = script.Parent.MouseClick:Connect(function()
	connection:Disconnect()
	script.Parent.Parent.music:Play()
	task.wait(30.482)
	script.Parent.Parent.yay:Play()
	script.Parent.Parent.Parent.cake.confetti.Enabled = true
	wait(5)
	script.Parent.Parent.Parent.cake.confetti.Enabled = false
	script.Parent.Parent.Parent.cake.Attachment.PointLight.Enabled = false
end)