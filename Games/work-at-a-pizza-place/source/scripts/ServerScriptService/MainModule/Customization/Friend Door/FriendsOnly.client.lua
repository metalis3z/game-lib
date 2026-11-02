local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value


local areFriends
while true do
	
	areFriends = workspace.Main.IsFriendsWithPlayer:InvokeServer(house.Owner.Value.userId)
	
	if areFriends or house.Owner.Value == game.Players.LocalPlayer then
		for _,furniture in ipairs(house.Furniture:GetChildren()) do
			if furniture.Name == "Friend Door" then
				furniture.DoorClosed.CanCollide = false
			end
		end
		wait()
		script:Destroy() --if a new friend door is added, we need create a new script
	end
	wait(30)
end