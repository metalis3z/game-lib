--by dued1
local CameraUtil = {}
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")


--vertical angle
function CameraUtil:GetPitchAngle(focus)
	local radius = (camera.CoordinateFrame.p - focus.Position).magnitude
	local y = camera.CoordinateFrame.p.Y - focus.Position.Y
 	return math.deg(math.asin(y/radius))
end


--rotation angle
function CameraUtil:GetYawAngle(focus)
	--local radius = (camera.CoordinateFrame.p * Vector3.new(1,0,1) - focus.Position * Vector3.new(1,0,1)).unit.magnitude
	local x = camera.CoordinateFrame.p.x - focus.Position.x
	local z = camera.CoordinateFrame.p.z - focus.Position.z
	local angle = math.deg(math.atan2(z,x))
	if angle < 0 then
		angle = 360 + angle
	end
 	return angle
end



function CameraUtil:GetCoordiantesFromAngle(angle,radius)
	local unitX = math.cos(math.rad(angle))
	local unitY = math.sin(math.rad(angle))
	local Y = unitY * radius
	local X = unitX * radius
	return X, Y
end


function CameraUtil:LookAtObject(object)
	
end


local TweenPanEnabled = false
function CameraUtil:TweenPan(player,velocity)
		

	if TweenPanEnabled or not player.Character or not player.Character:FindFirstChild("Head") then return end
	local rotation = self:GetYawAngle(player.Character.Head)
	
	local height = camera.CoordinateFrame.p.Y - player.Character.Head.Position.Y
	local radius = (camera.CoordinateFrame.p - player.Character.Head.Position).magnitude
	
	camera.CameraType = Enum.CameraType.Scriptable
	
	TweenPanEnabled = true
	--[[spawn(function()
		while TeenPanEnabled do
			
			wait(
		end
	end)]]
	
	RunService:BindToRenderStep("CameraPan", Enum.RenderPriority.Camera.Value, function()
		local head = player.Character.Head
		
		
		local focusPos = head.Position
		
		
		rotation = rotation + velocity
				
		
	
		local X,Z = self:GetCoordiantesFromAngle(rotation,radius)
	
	
		
		camera.CoordinateFrame = CFrame.new(Vector3.new(head.Position.X + X,head.Position.Y + height,head.Position.Z + Z),head.Position)
		
		
		
		local ray = Ray.new(focusPos,(focusPos-camera.CoordinateFrame.p)*-1)
		
		local ignoreList = {head.Parent}
		while true do
			local hitPart, point, normal, Material = workspace:FindPartOnRayWithIgnoreList(ray,ignoreList,true,true)
		
			if hitPart then
		
				if hitPart.CanCollide and hitPart.Transparency ~= 1 then --
					camera.CoordinateFrame = CFrame.new(point,head.Position)
					break
				else
					table.insert(ignoreList,hitPart) --keep casting ray until find opeque and colliabled
				end
			else
				break
			end
		end
	end)

end


function CameraUtil:EndTweenPan()
	
	if TweenPanEnabled then
		TweenPanEnabled = false
		RunService:UnbindFromRenderStep("CameraPan")
	end
end




function CameraUtil:SetCameraAngle(angle,radius,direction,focus)
		
		local x = zoom * math.cos(math.rad(angle))
		local y = zoom * math.sin(math.rad(angle))
		local focusPos = focus.Position
		
		
		local coord = foucsPos + (direction * -x)
		local coordX =  coord.X
		local coordZ = coord.Z
	
		local coordY = player.Character.Head.Position.Y + y

		
		camera.CameraType = Enum.CameraType.Scriptable
		camera.CoordinateFrame = CFrame.new(Vector3.new(coordX,coordY,coordZ),foucsPos)
		
		
end


return CameraUtil
