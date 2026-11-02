local rewardTimersFolder = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.PlayTimeRewards.UnclaimedRewards
local lowestValue = 0

while true do
	lowestValue = 0
	for i,v in pairs(rewardTimersFolder:GetChildren()) do
		if v:IsA("NumberValue") then
			lowestValue += 1
		end
	end
	if lowestValue > 0 then
		script.Parent.Parent.Parent.Parent.Visible = true
		script.Parent.Parent.Parent.Parent.Parent.NoClaim.Visible = false
		script.Parent.Parent.Parent.Parent.Parent.YesClaim.Visible = true
		script.Parent.Text = lowestValue
	else
		script.Parent.Parent.Parent.Parent.Parent.NoClaim.Visible = true
		script.Parent.Parent.Parent.Parent.Parent.YesClaim.Visible = false
		script.Parent.Parent.Parent.Parent.Visible = false
	end
	wait(0.5)
end