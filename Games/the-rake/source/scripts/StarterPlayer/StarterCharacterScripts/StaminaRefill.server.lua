--script.Parent.Stamina.Changed:Connect(function()
while true do
	wait()
		wait(1)
		repeat
			wait(2)
		script.Parent.Stamina.Value = script.Parent.Stamina.Value + 1
	until script.Parent.Stamina.Value == 10
end
	--end)