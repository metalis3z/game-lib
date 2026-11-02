local detector = script.Parent
local open = false
local animation = false
local model = script.Parent.Parent
local left = model.Left
local right = model.Right

function InDriveThrough(player,areaBlock)
	if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local sizeX = areaBlock.Size.X
		local sizeZ = areaBlock.Size.Z
		local positionX = areaBlock.Position.X
		local positionZ = areaBlock.Position.Z
		local torsoPos = player.Character.HumanoidRootPart.Position
		
		if torsoPos.x > positionX - (sizeX/2) then
		if torsoPos.x < positionX + (sizeX/2) then
		if torsoPos.z > positionZ - (sizeZ/2) then
		if torsoPos.z < positionZ + (sizeZ/2) then
			return true
		end
		end
		end
		end
	end
	return false
end

function IsCustomerInDriveThrough()
	for _,car in ipairs(workspace.CustomerCars:GetChildren()) do
		if car and car:FindFirstChild("Seat") and (car.Seat.Position - left.Handle.Position).magnitude < 20 then
			return true
		end
	end
	for _,player in ipairs(game.Players:GetPlayers()) do
		if InDriveThrough(player,workspace.CustomerBlock2) then
			return true
		end
	end
	return false
end

function animate(leftDir,rightDir)
	animation = true
	for i=1,4 do
		wait(.07)
		left:TranslateBy(Vector3.new(0,0,leftDir))
		right:TranslateBy(Vector3.new(0,0,rightDir))
	end
	animation = false
end

local threadRunning = false
function onMouseClick(player)
	if not animation then
		if not open then
			animate(-1,1)
			open = true
			
			spawn(function()
				if threadRunning then return end
				threadRunning = true
				wait(5)
				while open and IsCustomerInDriveThrough() do
					wait(2)
				end
				if not IsCustomerInDriveThrough() and not animation and open then
					animate(1,-1)
					open = false
				end
				threadRunning = false
			end)
		
		else
			animate(1,-1)
			open = false
		end
	end
end
detector.Detector.Event:connect(onMouseClick)


detector.Parent.CloseWindow.Event:connect(function()
	if open and not animation then
		animate(1,-1)
		open = false
	end
end)



















