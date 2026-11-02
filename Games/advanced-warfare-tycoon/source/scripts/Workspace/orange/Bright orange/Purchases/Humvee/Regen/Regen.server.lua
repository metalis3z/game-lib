
model = script.Parent.Parent.Hum--Indicates that the script interacts with the model the button is grouped with.

backup = model:clone()
enabled = true

function regenerate()
	model:remove()
	model = backup:clone()
	model.Parent = script.Parent.Parent
	model:makeJoints()

	script.Disabled = true
	script.Parent.BrickColor = BrickColor.new(26)--Black
	wait(10)--Change this number to change the time in between regenerations via the button, in seconds..
	script.Parent.BrickColor = BrickColor.new(104)--Purple
	script.Disabled = false
end

function onHit(hit)
	if (hit.Parent:FindFirstChild("Humanoid") ~= nil) and enabled then
		regenerate()
	end
end

script.Parent.Touched:connect(onHit)