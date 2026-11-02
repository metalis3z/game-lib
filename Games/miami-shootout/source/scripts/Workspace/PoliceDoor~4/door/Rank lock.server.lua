GroupId = 33212672 --Your group ID here (the numbers in: http://www.roblox.com/My/Groups.aspx?gid=xxxxxxxx)
GroupRank = 1 ----The rank number in group>Group Admin>Rank>Number (0-255) Set to 0 if you want everyone to be able to get the tools.
KillIfNotInGroup = false --Will it kill the person if they are not in the group?
StayOpenTime = 1 --How many seconds the door stays open if the player is in the group specified at line 1

local Door = script.Parent
function onTouched(hit) 
	local p = game.Players:GetPlayerFromCharacter(hit.Parent)
	local human = hit.Parent:findFirstChild("Humanoid") 
	if human then 
		if p.Team == game.Teams.Police then
			Door.Transparency = 0.15
			Door.CanCollide = false 
			wait(StayOpenTime) 
			Door.CanCollide = true
			Door.Transparency = 0.15  
		elseif KillIfNotInGroup == true then
			human.Health = 0
		else
			print("Access denied") 
		end 
	end 
end 

script.Parent.Touched:connect(onTouched)
