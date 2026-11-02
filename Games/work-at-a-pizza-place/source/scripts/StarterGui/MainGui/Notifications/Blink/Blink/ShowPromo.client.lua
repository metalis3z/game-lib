local Window = script.Parent
local OpenPopupIcon = Window.Parent:WaitForChild("OpenPopupIcon")
local HoursLeft = Window:WaitForChild("HoursLeft")

workspace.Main.ShowPromo.OnClientEvent:connect(function(hoursLeft)
	Window.Visible = true
	HoursLeft.Text = hoursLeft .. " hours left"
	OpenPopupIcon.Visible = true
end)

Window:WaitForChild("Redeem").MouseButton1Click:connect(function()
	Window.Visible = false
	Window.Parent.RedeemCode.Visible = true
	Window.Parent.RedeemCode.Code.Invalid.Visible = false
end)

Window:WaitForChild("CancelButton").MouseButton1Click:connect(function()
	Window.Visible = false
end)

OpenPopupIcon.MouseButton1Click:connect(function()
	Window.Visible = true
end)
