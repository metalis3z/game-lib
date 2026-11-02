local MaxCapacity = script.Parent.Value

local ResetTime = script.Parent.Parent.ResetTime.Value

while task.wait(ResetTime) do
	
	script.Parent.Value = MaxCapacity
	
end