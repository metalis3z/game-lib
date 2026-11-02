local rs = game:GetService("ReplicatedStorage")

local robberyStates = rs:WaitForChild("RobberyStates")
local alarms = robberyStates:WaitForChild("Alarms")

local jewAlarm = alarms:WaitForChild('Jew')
local jewOpen = robberyStates:WaitForChild("jewopen")

local jew = game.Workspace:WaitForChild('jew')
local JewAlarmSound = jew.alarm.Sound

jewAlarm.Changed:Connect(function()
	if jewAlarm.Value == true then
		JewAlarmSound:Play()
		
		wait(120)
		
		for i,v in pairs(game.Players:GetChildren()) do
			if v.IsRobJew.Value == true then
				v.IsRobJew.Value = false
				
				v.CashCollected.Value = 0
				
				robberyStates.Rob:FireClient(v, "Jew", false)
				
				local alltp = jew.TeleportCriminals:GetChildren()
				
				local ramdomtp = alltp[math.random(1,#alltp)]
				v.Character.Head.CFrame = CFrame.new(ramdomtp.Position)
			end
		end
		jewAlarm.Value = false
		jewOpen.Value = false
	end
end)


jewOpen.Changed:Connect(function()
	if jewOpen.Value == false then
		wait(180)
		jewOpen.Value = true 
	end
end)