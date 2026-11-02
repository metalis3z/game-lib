--credit to prince games studio
local StarterGui = game:GetService("StarterGui")

while not pcall(function() --[[ Line: 5 | Upvalues: StarterGui (copy) ]]
	StarterGui:SetCore("ResetButtonCallback", false)
end) do
	task.wait(1)
end