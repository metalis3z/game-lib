local MaxCapacity = tostring(script.Parent.Parent.Parent.Parent.Capacity.Value)

while task.wait() do
	script.Parent.Text = tostring(script.Parent.Parent.Parent.Parent.Capacity.Value).."/"..MaxCapacity
end