
local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value

debounce = false
function touch(hit)
	if hit  and hit.Parent and hit.Parent:FindFirstChild("Humanoid")  then
		debounce = true
		
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player and player == owner then
			workspace.Main.SetWindowVisible:FireClient(owner,"KickList",true)
		end
		wait(.2)
		debounce = false
	end
end

local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object.Parent == model then
		touch(hit)
	end
end)

model.ClickDetector.MouseClick:connect(function(player) touch(player.Character.HumanoidRootPart) end)