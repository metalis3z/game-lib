local Window = script.Parent
local player = game.Players.LocalPlayer
local Code = Window:WaitForChild("Code")
local Done = Code:WaitForChild("Done")
local Invalid = Code:WaitForChild("Invalid")
local CancelButton = Window:WaitForChild("CancelButton")
local BlinkWindow = Window.Parent:WaitForChild("Blink")
local OpenPopupIcon = Window.Parent:WaitForChild("OpenPopupIcon")



Done.MouseButton1Click:connect(function()
	if string.match(Code.Text,"%a+") == Code.Text then
		local code = Code.Text
		Code.Text = workspace.Main.FilterString:InvokeServer(nil,Code.Text)
		
		workspace.Main.ValidateCode:FireServer(code)
	else
		Invalid.Visible = true
	end
end)

workspace.Main.ValidateCode.OnClientEvent:connect(function(valid)
	if not valid then
		Invalid.Visible = true
	else
		Window.Visible = false
		OpenPopupIcon.Visible = false
	end
end)

Code.Focused:connect(function()
	Invalid.Visible = false
end)



CancelButton.MouseButton1Click:connect(function() BlinkWindow.Visible = true Window.Visible = false end)

