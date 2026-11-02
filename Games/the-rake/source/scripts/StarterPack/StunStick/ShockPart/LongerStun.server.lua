local HowLong = workspace.The_Rake.Configuration.StunTime.Value
repeat
	wait(HowLong)
	workspace.The_Rake.Stunning.Value = 0
until workspace.The_Rake.Stunning.Value == 0
