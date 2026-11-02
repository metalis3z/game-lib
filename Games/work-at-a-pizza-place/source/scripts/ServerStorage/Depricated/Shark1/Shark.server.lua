number = tonumber(string.sub(script.Parent.Name,6,6))

--[[local sharks = {}
for _,shark in ipairs(script.Parent.Parent:GetChildren()) do
	if shark ~= script.Parent then
		table.insert(sharks,shark)
	end
end]]

math.randomseed(tick()+number)
math.random()


function findHat(player)
	for _,obj in ipairs(player.Character:GetChildren()) do
		if obj:IsA("Accessory") or obj:IsA("Hat") then
			return obj
		end
	end
	return nil
end
wait(math.random(1,100)/10)

function IsAlreadyTargeted(torso)
	--[[for _,shark in ipairs(sharks) do
		if shark.RocketPropulsion.Target == torso then
			return true
		end
	end
	return false]]
	return false
end


function findClosestPlayer(distance)
	local dis = distance
	local closest = nil
	for _,player in ipairs(game.Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local d = (player.Character.HumanoidRootPart.Position - script.Parent.Position).magnitude
			if d < dis and not IsAlreadyTargeted(player.Character.HumanoidRootPart) then
				local hat = findHat(player)
				if (d > 20 and player.Character.HumanoidRootPart.Position.Y < -3.1) or (d < 30) or (hat and hat:FindFirstChild("BodyPosition") and hat.BodyPosition.Y ~= 0) then
					closest = player.Character.HumanoidRootPart
					dis = d
				end
			end
		end
	end
	return closest
end


function touched(hit)
	if not debounce then
		debounce = true
		delay(.5,function() debounce = false end)
	else
		return
	end
	if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
		hit.Parent.Humanoid.Health = 0
	end
end
script.Parent.Touched:connect(touched)

local closest = nil

spawn(function()
while true do
	wait(math.random(5,10))
	if closest then
		script.Parent.RocketPropulsion.MaxSpeed = math.random(20,25)
		wait(math.random(2,5))
		script.Parent.RocketPropulsion.MaxSpeed = 18
	end
end
end)

delay(2.9,function() script.Parent.Anchored = false end)
while true do
	wait(3)
	closest = findClosestPlayer(200)
	
	if closest then
		script.Parent.RocketPropulsion.Target = closest
		script.Parent.RocketPropulsion:Fire()
		if script.Parent.Anchored then
			script.Parent.Anchored = false
		end
	else
		script.Parent.RocketPropulsion.Target = workspace["SharkSpawn" .. number]
		script.Parent.RocketPropulsion:Fire()
		
		if not script.Parent.Anchored and(workspace["SharkSpawn" .. number].Position - script.Parent.Position).magnitude < 30 then
			script.Parent.Anchored = true
			script.Parent.RocketPropulsion:Abort()
		end
	end
end




	



