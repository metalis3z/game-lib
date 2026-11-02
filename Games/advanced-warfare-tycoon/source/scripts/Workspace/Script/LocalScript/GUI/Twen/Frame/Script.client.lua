for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA('TextButton') then
		v.MouseEnter:connect(function()
			v.BorderSizePixel = 4
		end)
		v.MouseLeave:connect(function()
			v.BorderSizePixel = 0
		end)
		v.MouseButton1Click:connect(function()
			if v:FindFirstChild('AAA') then
				script.Parent.Parent.Parent.Parent.Parent.TeamColor = v.AAA.Value
				script.Parent.Parent.Parent.Parent.Parent.Character:BreakJoints()
				script.Parent.Parent.Parent.Parent:Destroy()
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
				game.Workspace.CurrentCamera.CameraType = "Custom"
			end
		end)
	end
end