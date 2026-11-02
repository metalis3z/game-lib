repeat wait() until script.Parent.Parent.Parent ~= nil

while true do
	script.Parent.Text = script.Parent.Parent.Parent.TimeValue.Value
	wait(0.1)
end