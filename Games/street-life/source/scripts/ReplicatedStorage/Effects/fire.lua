local module = {}

-- blur stuff --
local secondsEnabled = 0.1 -- how quick the blur is
local secondsBetweenEnable = 0.15 -- the transition time between the blur and blur remove
local maxBlur = 10 -- the blur it goes up to when playing the blur effect
local backBlur = 0 -- should always be 0 but you can change for whatever reason (how much blur it goes back to, which is 0)
local bblur = game.Lighting.GunHSBLUR -- don't edit this, for the script

local CameraMovementEnabled = true
local noCameraMovement = {"Test"} -- following guns will receive no movement on camera
local customCameraMovement = {
	["TestGun"] = {
		["DividedBy"] = 1,
		["Speed"] = 29,
		["Damper"] = 1,
		["AngleX_Min"] = 1,
		["AngleX_Max"] = 1,
		["AngleY_Min"] = 0, 
		["AngleY_Max"] = 1,
	}
} -- following guns will receive CUSTOMIZED camera movement, so you can change to high or minimal.
local defaultCameraMovement = {
	["DividedBy"] = 2, -- what it will be divided by (default is always 1 anyway) 
	["Damper"] = 1,
	["Speed"] = 2,
	-- X AXIS
	
	["AngleX_Min"] = 1, -- the minimum amount the camera will move on the X axis
	["AngleX_Max"] = 2, -- the maximum amount the camera will move on the X axis
	
	-- Y AXIS
	
	["AngleY_Min"] = -3, -- the minimum amount the camera will move on the X axis
	["AngleY_Max"] = 1, -- the maximum amount the camera will move on the X axis
	
	-- Z AXIS

	["AngleZ_Min"] = 1, -- the minimum amount the camera will move on the Z axis
	["AngleZ_Max"] = 2, -- the maximum amount the camera will move on the Z axis
} -- the camera movement any other tool will receive that is not in the noCameraMovement or customCameraMovement tables

local running = false -- don't edit this, for the script
local camera = game.Workspace.CurrentCamera -- don't edit this, for the script
local tweenService = game:GetService("TweenService") -- don't edit this, for the script
--local cameraModule = require(script.CameraModule) -- do not edit, for the script

function RAND(Min, Max, Accuracy)
	local Inverse = 1 / (Accuracy or 1)
	return (math.random(Min * Inverse, Max * Inverse) / Inverse)
end -- do not edit, for the script

function blur()
	bblur.Size = 0
	bblur.Enabled = true
	
	local newTween = tweenService:Create(bblur,TweenInfo.new(secondsEnabled),{ Size=maxBlur })
	newTween:Play()
	newTween.Completed:Wait()
end

function unblur()
	local returnTween = tweenService:Create(bblur,TweenInfo.new(secondsEnabled),{ Size=backBlur })
	returnTween:Play()
	returnTween.Completed:Wait()

	bblur.Enabled = false
	
	running = false
end

local cam = {}
local physics = require(script.PhysicsModule)
local hasRanTest = false
cam.current = workspace.CurrentCamera

function cam:accelerate(x,y,z)
	cam.recoil.x.impulse(x)
	cam.recoil.y.impulse(y)
	cam.recoil.z.impulse(z)
end

function cam:accelerateXY(x,y)
	cam.recoil.x.impulse(x)
	cam.recoil.y.impulse(y)
end

local function updatecam()			
	cam.current.CoordinateFrame = cam.current.CoordinateFrame*CFrame.Angles(cam.recoil.x.p(),cam.recoil.y.p(),cam.recoil.z.p())
end
if CameraMovementEnabled then
	game:GetService("RunService"):BindToRenderStep("RecoilCam",2000,function()
		if hasRanTest then updatecam() end
	end)
end

function runCameraMovement(Module)
	hasRanTest = true
	cam.current = workspace.CurrentCamera
	cam.angles = {}
	cam.angles.x = 0
	cam.angles.y = 0
	cam.angles.z = 0
	cam.recoil = {}
	cam.recoil.x = physics.spring.new{d=Module["Damper"];s=Module["Speed"];}
	cam.recoil.y = physics.spring.new{d=Module["Damper"];s=Module["Speed"];}
	cam.recoil.z = physics.spring.new{d=Module["Damper"];s=Module["Speed"];}
	
	local RecoilX = math.rad(RAND(Module["AngleX_Min"], Module["AngleX_Max"], Module["DividedBy"]))
	local RecoilY = math.rad(RAND(Module["AngleY_Min"], Module["AngleY_Max"], Module["DividedBy"]))
	local RecoilZ = math.rad(RAND(Module["AngleZ_Min"], Module["AngleZ_Max"], Module["DividedBy"]))
	cam:accelerate(RecoilX,RecoilY,RecoilZ)	    
	delay(0.03, function()
		cam:accelerateXY(-RecoilX,-RecoilY)
	end)
end

function module.play()	
	if running or _G.HsRunning == true then return end
	
	if CameraMovementEnabled == true then
		local getTool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
		if not getTool then
			runCameraMovement(defaultCameraMovement)
		else
			if table.find(noCameraMovement,getTool.Name) then
				-- nothing
			elseif customCameraMovement[getTool.Name] then
				runCameraMovement(customCameraMovement[getTool.Name])
			else
				runCameraMovement(defaultCameraMovement)
			end
		end
	end
	
	running = true
	
	spawn(blur)
	delay(secondsBetweenEnable,function()
		spawn(unblur)	
	end)
end

return module
