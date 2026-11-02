local camera = workspace.CurrentCamera -- Variable for CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable--allows us to script the camera

while true do
	for i = 1, 1350 do
		camera.CoordinateFrame = CFrame.new(889.938, 254.998, 461.963) * CFrame.Angles(0, i/200, 0)
		wait()
	end
end
