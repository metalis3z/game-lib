local v1 = script.Parent
local Spin = v1:WaitForChild("Spin")
local Text = v1:WaitForChild("Text")
task.spawn(function()
	while true do
		Spin.Rotation = (Spin.Rotation + 180 * task.wait()) % 360
	end
end)
task.spawn(function()
	local t = { "", ".", "..", "..." }
	local v1 = 1
	while true do
		Text.Text = "Generating AI" .. t[v1]
		task.wait(0.4)
		v1 = v1 % #t + 1
	end
end)