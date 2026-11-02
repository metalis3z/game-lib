local Camera = {}

local Char = require(script.Parent.Character)
local Physics = require(script.Parent.Physics)
local Input = require(script.Parent.Input)

local UIS = game:GetService("UserInputService")

Camera.Cam = workspace.CurrentCamera
Camera.Mode = "Orbital"
Camera.State = "InMenu"

Camera.DefaultSensitivity = 0.15
Camera.Sensitivity = 0.15
Camera.DefaultOffset = Vector3.new(0, 2.5, 0)
Camera.DefaultLookOffset = Vector3.new(0, 2.5, 0)
Camera.LookOffset = Vector3.new()
Camera.CamOffset = Vector3.new(0, 2.5, 0)
Camera.MinY = math.rad(-75)
Camera.MaxY = math.rad(75)
Camera.CustomEnabled = false
Camera.FOV = 70
Camera.Distance = 12
local distspring = Physics.Spring.new(0)
distspring.s = 17
distspring.d = 0.8
local lookoffsetspring = Physics.Spring.new(Vector3.new())
lookoffsetspring.s = 17
lookoffsetspring.d = 0.8
local fovspring = Physics.Spring.new(70)
fovspring.s = 17
fovspring.d = 0.8
local sensitivityspring = Physics.Spring.new(Camera.DefaultSensitivity)
sensitivityspring.s = 20
sensitivityspring.d = 0.85
local shakespring = Physics.Spring.new(Vector3.new())
shakespring.s = 17.5
shakespring.d = 0.8
local cameraspring = Physics.Spring.new(Vector3.new())
cameraspring.s = 17
cameraspring.d = 0.8
Camera.MinDistance = 3
function Camera.SetSensitivity(sens)
    Camera.Sensitivity = sens or Camera.DefaultSensitivity
end
function Camera.ResetSensitivity()
    Camera.SetSensitivity(Camera.DefaultSensitivity)
end
function Camera.AddDistance(dist, speed)
    distspring.s = speed or 17
    distspring.t = dist or 0
end
function RotateAboutAxis(cf, axisDirection, axisPosition, angle)
    return CFrame.fromAxisAngle(axisDirection.Unit, angle) * (cf - axisPosition) + axisPosition
end
local Cam = Camera.Cam
local MouseX, MouseY = 0, 0
local NewCamCF = CFrame.new()
local LastCamCF = CFrame.new()
function Camera.GetHeading()
    local look = Camera.Cam.CFrame.lookVector
    return math.atan2(-look.x, -look.z), math.asin((Camera.Cam.CoordinateFrame.p - Camera.Cam.Focus.p).Unit.Y)
end
function Camera.SetFOV(fov, speed)
    fovspring.s = speed or 17
    fovspring.t = fov or 70
end
function Camera:Shake(v)
    shakespring.a = v
end
function Camera.HStep(dt)
    if Camera.CustomEnabled then
        if UIS.MouseIconEnabled ~= false then
            UIS.MouseIconEnabled = false
        end
        if UIS.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
            UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    elseif Camera.CustomEnabled == false then
        if UIS.MouseIconEnabled ~= true then
            UIS.MouseIconEnabled = true
            UIS.MouseBehavior = Enum.MouseBehavior.Default
        end
    end
end

function Camera.clerp(p1,p2,percent)
    local p1x,p1y,p1z,p1R00,p1R01,p1R02,p1R10,p1R11,p1R12,p1R20,p1R21,p1R22 = p1:components()
    local p2x,p2y,p2z,p2R00,p2R01,p2R02,p2R10,p2R11,p2R12,p2R20,p2R21,p2R22 = p2:components()
    return CFrame.new(p1x+percent*(p2x-p1x), p1y+percent*(p2y-p1y) ,p1z+percent*(p2z-p1z),
        (p1R00+percent*(p2R00-p1R00)), (p1R01+percent*(p2R01-p1R01)) ,(p1R02+percent*(p2R02-p1R02)),
        (p1R10+percent*(p2R10-p1R10)), (p1R11+percent*(p2R11-p1R11)) , (p1R12+percent*(p2R12-p1R12)),
        (p1R20+percent*(p2R20-p1R20)), (p1R21+percent*(p2R21-p1R21)) ,(p1R22+percent*(p2R22-p1R22)))
end


lookoffset = Camera.DefaultOffset
local ArrowDelta = Vector3.new()

local Ignore = {}
local function CastRay(CastedRay)
    table.insert(Ignore, Char.Character)
    local Success = false
    local Hit, Position, Normal
    repeat
        Hit, Position, Normal = workspace:FindPartOnRayWithIgnoreList(CastedRay	, Ignore)
        if Hit then
            if Hit.CanCollide then
                if Hit.Transparency >= 0.5 then
                    table.insert(Ignore, Hit)
                else
                    Success = true
                end
            else
                table.insert(Ignore, Hit)
            end
        else
            Success = true
        end
    until Success
    return Hit, Position, Normal
end

local TweenService = game:GetService("TweenService")

function lerp(a, b, t)
	return a + (b - a) * t
end

function Camera.Step(dt)
    if Camera.Mode == "Orbital" then
        local ti = 0.1
        local delta = ArrowDelta + Input.MouseDelta + Input.GamepadDelta:Lerp(Input.GamepadDelta, ti) + Input.TouchDelta
        local rootcf = Char.RootPart.CFrame * CFrame.new(0, -Char.CrouchP * 1.5, 0)
        local Focus = (rootcf * CFrame.new(lookoffset)).p + Vector3.new(0, 2, 0)
        local ZoomCF = CFrame.new(0, 0, 0)
        local Center = Char.RootPart.Position + Vector3.new(0, 2, 0)
        lookoffsetspring.t = Camera.DefaultLookOffset + Camera.LookOffset
        lookoffset = lookoffsetspring.p
        Camera.FOV = fovspring.p
        sensitivityspring.t = Camera.Sensitivity
        MouseX = MouseX + math.rad(delta.x * sensitivityspring.p)
        MouseY = MouseY - math.rad(delta.y * sensitivityspring.p)
        MouseY = math.clamp(MouseY, Camera.MinY, Camera.MaxY)
        local camdist = Camera.Distance + distspring.p
        if camdist <= Camera.MinDistance then
            camdist = Camera.MinDistance
        end
        NewCamCF = CFrame.new(rootcf.p) * CFrame.Angles(0, -MouseX, 0) * CFrame.Angles(MouseY, 0, 0) * CFrame.new(0, 0, camdist) * CFrame.new(lookoffset) * CFrame.Angles(-shakespring.p.y, shakespring.p.x, shakespring.p.z)
        if NewCamCF ~= LastCamCF then
            local CastedRay = Ray.new(Center, NewCamCF.Position - Center)
			local Hit, Pos, Norm = CastRay(CastedRay)
			if Hit then
				Pos = Pos + Norm * 0.2
			end
						
			local NewCameraCFrame = Camera.clerp(Camera.Cam.CFrame, CFrame.new(Pos) * (NewCamCF - NewCamCF.Position), 0.4)
				
			Camera.Cam.CFrame = CFrame.new(NewCameraCFrame.Position, NewCameraCFrame.Position + NewCameraCFrame.LookVector)
			LastCamCF = Camera.Cam.CFrame
        end
        Camera.Cam.FieldOfView = fovspring.p
    end
end

Input.InputBegan:Connect(function(io, cancel)
    if cancel then
        return
    end
    if io.KeyCode == Enum.KeyCode.Left then
        ArrowDelta = ArrowDelta - Vector3.new(10, 0, 0)
    end
    if io.KeyCode == Enum.KeyCode.Right then
        ArrowDelta = ArrowDelta - Vector3.new(-10, 0, 0)
    end
    if io.KeyCode == Enum.KeyCode.ButtonSelect then
        local newpos = Camera.Distance + 2
        if newpos > 20 then
            newpos = 7
        end
        Camera.Distance = newpos
    end
end)
UIS.InputChanged:Connect(function(io, cancel)
    if cancel then
        return
    end
    if io.UserInputType == Enum.UserInputType.MouseWheel then
        local newpos = io.Position.z * 2
        Camera.Distance = Camera.Distance - newpos
        Camera.Distance = math.clamp(Camera.Distance, 7, 20)
    end
end)
Input.InputEnded:Connect(function(io, cancel)
    if io.KeyCode == Enum.KeyCode.Left then
        ArrowDelta = ArrowDelta + Vector3.new(10, 0, 0)
    end
    if io.KeyCode == Enum.KeyCode.Right then
        ArrowDelta = ArrowDelta + Vector3.new(-10, 0, 0)
    end
end)

return Camera
