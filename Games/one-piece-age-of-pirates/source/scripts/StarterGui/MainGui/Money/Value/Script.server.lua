repeat wait() until script.Parent.Parent.Parent ~= nil

while true do
	script.Parent.Text = script.Parent.Parent.Parent.Parent.Parent.Data.Money.Value
	wait(0.1)
	
	if script.Parent.Parent.Parent.Parent.Parent.Data.Money.Value < 0 then
		script.Parent.Parent.Parent.Parent.Parent.Data.Money.Value = 0
	end
end