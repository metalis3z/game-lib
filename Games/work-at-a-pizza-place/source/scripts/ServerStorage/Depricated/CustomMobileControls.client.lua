--[[while not _G["StartedPlaying"] do wait(2) end
local PlayerGui = script.Parent.Parent:WaitForChild("PlayerGui")
local ScreenGui = PlayerGui:WaitForChild("NewMobileControls")
local Walk = ScreenGui:WaitForChild("Walk")
local UIS = game:GetService("UserInputService")
local CameraLocked = PlayerGui:WaitForChild("WorkTool"):WaitForChild("CameraLocked")
local Enabled = true
if UIS.TouchEnabled then
	PlayerGui:WaitForChild("TouchGui"):Destroy()
else
	Walk.Visible = false
	script:Destroy()
end

local rotation = 0 -- 0-360
local radius = 12  --studs
local height = 6 --studs above head
local sensitivity = 1


local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local head = player.Character.Head
local camera = workspace.CurrentCamera
local Walking = false
local leftButtonDown = false
camera.CameraType = Enum.CameraType.Scriptable
lastXPosition = 0
UIS.InputChanged:connect(function(inputObject,gameProcessed)
	
	if not gameProcessed and not CameraLocked.Value then
		
		if UIS.TouchEnabled and inputObject.UserInputType == Enum.UserInputType.Touch then
			rotation = rotation + (inputObject.Delta.X * sensitivity)
		elseif not UIS.TouchEnabled and leftButtonDown then
			--for debugging only
			local deltaX = lastXPosition - inputObject.Position.X
			rotation = rotation + (-deltaX * sensitivity)
			lastXPosition = inputObject.Position.X
		end
	end
end)


--for debuging only
if not UIS.TouchEnabled then
	
	local mouse = player:GetMouse()
	
	mouse.Button2Down:connect(function()
		lastXPosition = mouse.X
		leftButtonDown = true
	end)
	
	mouse.Button2Up:connect(function()
		leftButtonDown = false
	end)
	
	
	
	mouse.Button1Down:connect(function()
		Walking = true
	end)
	
	mouse.Button1Up:connect(function()
			Walking = false
		player.Character.Humanoid:MoveTo(player.Character.Torso.Position)
	end)

end





Walk.InputBegan:connect(function(inputObject)

	Walking = true
end)

Walk.InputEnded:connect(function(inputObject)
	Walking = false
	player.Character.Humanoid:MoveTo(player.Character.Torso.Position)
end)

local part = Instance.new("Part",workspace)
part.Anchored = true
part.CanCollide = false





RunService:BindToRenderStep("Camera", Enum.RenderPriority.Camera.Value, function()
	
	if CameraLocked.Value then return end

	local X = math.cos(math.rad(rotation))
	local Y = math.sin(math.rad(rotation))
	local unitY = Y * radius
	local unitX = X * radius
	camera.CoordinateFrame = CFrame.new(Vector3.new(head.Position.X + unitX,head.Position.Y + height,head.Position.Z + unitY),head.Position)
	if Walking then
		player.Character.Humanoid:MoveTo(camera.CoordinateFrame.p + camera.CoordinateFrame.lookVector * 100)
	end
	
	
	local ray = Ray.new(head.Position,(head.Position-camera.CoordinateFrame.p)*-1)
	
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
end)]]




































