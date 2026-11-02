--Feel free to delete the 'ThumbnailCamera' and 'Part'. I use this for the model's thumbnail.

--[[	
	
local part = workspace["HD Admin"].ThumbnailCamera.Part
local camera = game.Workspace.Camera
camera.CameraSubject= part
camera.CameraType = "Fixed"
camera.CoordinateFrame= part.CFrame * CFrame.new(0,0,3)
camera.Focus = part.CFrame

--]]