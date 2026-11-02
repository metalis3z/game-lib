local Car = script.Parent.Parent.Parent

local Rtimer = 60

local deleteTimerLeft = Rtimer
local deleting = false

Car.DriveSeat.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		deleting = false
		deleteTimerLeft = Rtimer
	end
end)

Car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		deleting = true
		deleteTimerLeft = Rtimer
	end
end)	

while wait(1) do
	if deleting == true then
		if Car:FindFirstChild("DriveSeat"):FindFirstChild("Locked") then
			deleting = false
			deleteTimerLeft = Rtimer
		else
			local newTimer = deleteTimerLeft - 1
			deleteTimerLeft = math.clamp(newTimer,0,Rtimer)
			Car:FindFirstChild("Body"):FindFirstChild("CarDeleteGui").Enabled = true
			Car:FindFirstChild("Body"):FindFirstChild("CarDeleteGui"):FindFirstChild("MainFrame"):FindFirstChild("texti").Text = "(REMOVING IN "..newTimer.." SEC)"

			if newTimer == 0 then
				--Car:Destroy()
				--new and improved system :cool:
				_G.hookCarRemove(Car)
				break
			end
		end
	else
		Car:FindFirstChild("Body"):FindFirstChild("CarDeleteGui").Enabled = false
	end
end