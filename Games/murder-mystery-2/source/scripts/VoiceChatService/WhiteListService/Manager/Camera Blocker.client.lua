local camera		= workspace.CurrentCamera
local camBlock		= Instance.new('Part',camera)
local camMesh		= Instance.new('SpecialMesh',camBlock)
camBlock.CFrame		= CFrame.new(999999*math.random(),999999*math.random(),999999*math.random())
game:GetService("RunService").RenderStepped:connect(function()
	camBlock.Anchored		= true
	camBlock.FormFactor		= Enum.FormFactor.Symmetric
	camBlock.Size			= Vector3.new(2,2,2)
	camBlock.Material		= Enum.Material.Neon
	camBlock.BrickColor		= BrickColor.new("Really black")
	camBlock.Transparency	= 0
	camMesh.Scale			= Vector3.new(-1,-1,-1)
	camera.CameraType		= Enum.CameraType.Scriptable
	camera.CoordinateFrame 	= camBlock.CFrame
	camera.FieldOfView		= 1
end)