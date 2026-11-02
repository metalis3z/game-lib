local rs = game:GetService("ReplicatedStorage")

local robberyStates = rs:WaitForChild("RobberyStates")
local alarms = robberyStates:WaitForChild("Alarms")

local BankAlarm = alarms:WaitForChild("Bank")
local BankOpen = robberyStates:WaitForChild("bankopen")

local bank = game.Workspace:WaitForChild("bank")

BankAlarm.Changed:Connect(function()
	if BankAlarm.Value == true then
		
		wait(120)
		
		for i,v in pairs(game.Players:GetChildren()) do
			if v.IsRobBank.Value == true then
				v.IsRobBank.Value = false
				
				v.CashCollected.Value = 0
				
				robberyStates.Rob:FireClient(v, "Bank", false)
				
				local alltp = bank.TeleportCriminals:GetChildren()
				
				local ramdomtp = alltp[math.random(1,#alltp)]
				v.Character.Head.CFrame = CFrame.new(ramdomtp.Position)
			end
		end
		BankAlarm.Value = false
		BankOpen.Value = false
	end
end)


BankOpen.Changed:Connect(function()
	if BankOpen.Value == false then
		wait(180)
		BankOpen.Value = true 
	end
end)