-- Created and Supported by LSPLASH

local p1 = 1

while true do
	p1 = p1 + 1
	local r = 7.5*math.random(2, 3)/math.random(2, 2.25)	
	r = r // 2
	
	--print("nahhh we need wait "..r.."s to check players of localplayer, and we love picca :)")
	
	task.delay(r, function()
		for i, child in ipairs(game:GetService("Players"):GetChildren()) do
			if game:GetService("Players").LocalPlayer:IsFriendsWith(child.UserId) then
				local badge = game:GetService("ReplicatedStorage"):FindFirstChild("EntityInfo"):WaitForChild("FriendAccept")
				badge:FireServer()
				break
			end
		end
	end)
	task.wait(r)
	if p1 == 15 then
		break
	end
end