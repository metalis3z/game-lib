local ts = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local fovjump = ts:Create(workspace.Camera,tweeninfo,{FieldOfView = 50})

repeat wait() until script.Parent:FindFirstChildOfClass("Humanoid")
script.Parent.Humanoid.Changed:Connect(function()
script.Parent.Humanoid.Died:Connect(function()
		if (script.Parent.Torso.Position - workspace.Values.Jumpscarer.Value.Position).magnitude<10 then
			workspace.Camera.FieldOfView = 120
			fovjump:Play()
	workspace.Jumpscarer.Scare:Play()
	workspace.Camera.CameraType = "Scriptable"
	workspace.Camera.CFrame = workspace.Jumpscarer.Camera.CFrame
		end	
	end)
end)