


local v1 = {}
local v_u_2 = game:GetService("UserInputService")
Camera = workspace.CurrentCamera
mouseBehavior = ""
mouseIconEnabled = ""
cameraType = ""
cameraFocus = ""
cameraCFrame = ""
cameraFieldOfView = ""
function v1.Push()
	cameraFieldOfView = Camera.FieldOfView
	Camera.FieldOfView = 70
	cameraType = Camera.CameraType
	Camera.CameraType = Enum.CameraType.Custom
	cameraCFrame = Camera.CFrame
	cameraFocus = Camera.Focus
	mouseIconEnabled = v_u_2.MouseIconEnabled
	v_u_2.MouseIconEnabled = true
	mouseBehavior = v_u_2.MouseBehavior
	v_u_2.MouseBehavior = Enum.MouseBehavior.Default
end
function v1.Pop()
	Camera.FieldOfView = 70
	Camera.CameraType = cameraType
	cameraType = nil
	Camera.CFrame = cameraCFrame
	cameraCFrame = nil
	Camera.Focus = cameraFocus
	cameraFocus = nil
	v_u_2.MouseIconEnabled = mouseIconEnabled
	mouseIconEnabled = nil
	v_u_2.MouseBehavior = mouseBehavior
	mouseBehavior = nil
end
return v1
