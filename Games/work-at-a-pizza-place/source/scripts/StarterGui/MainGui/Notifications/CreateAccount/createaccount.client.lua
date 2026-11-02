script.Parent:WaitForChild("Popup"):WaitForChild("Frame"):WaitForChild("Ok")
script.Parent:WaitForChild("Ok")




extra_time = 0
if game.Players.LocalPlayer.userId <= 0 then
	script.Parent.Ok.MouseButton1Click:connect(function()
		script.Parent:Destroy()
	end)
	script.Parent.CancelButton.MouseButton1Click:connect(function()
		script.Parent:Destroy()
	end)
	wait(300)
	script.Parent.Visible = true
end

