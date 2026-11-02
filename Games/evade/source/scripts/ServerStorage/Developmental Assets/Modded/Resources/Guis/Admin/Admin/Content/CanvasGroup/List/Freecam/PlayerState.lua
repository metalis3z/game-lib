-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
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
	-- upvalues: (copy) v_u_2
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
	-- upvalues: (copy) v_u_2
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
