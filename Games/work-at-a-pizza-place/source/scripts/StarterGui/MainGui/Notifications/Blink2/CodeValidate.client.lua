local window = script.Parent
local Code = window:WaitForChild("Step4"):WaitForChild("Code")
local Done = Code:WaitForChild("Done")
local Invalid = Code:WaitForChild("Invalid")

Done.MouseButton1Click:connect(function()
	if string.match(Code.Text,"%d+") == Code.Text then
		workspace.Main.ValidateCode:FireServer(tonumber(Code.Text))
	else
		Invalid.Visible = true
	end
end)

workspace.Main.ValidateCode.OnClientEvent:connect(function(valid)
	if not valid then
		Invalid.Visible = true
	else
		window.Visible = false
	end
end)


window.Changed:connect(function(property)
	if property == "Visible" then
		if window.Visible then
			Invalid.Visible = false
			
		end
	end
end)

