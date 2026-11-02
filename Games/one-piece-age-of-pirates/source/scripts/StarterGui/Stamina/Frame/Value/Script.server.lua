repeat wait() until script.Parent.Parent.Parent.Parent.Parent.Character ~= nil
wait(1)

while true do
	if script.Parent.Value < 100 then
		script.Parent.Value = script.Parent.Value + 1
		wait(0.5)
	end
	wait()
end