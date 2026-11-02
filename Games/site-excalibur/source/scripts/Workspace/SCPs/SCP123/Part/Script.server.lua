bin = script.Parent

function onTouched(part)
	part.BrickColor = BrickColor.new(26)
	wait(.3)
	part.Transparency = .2
	wait(.1)
	part.Transparency = .4
	wait(.1)
	part.Transparency = .6
	wait(.1)
	part.Transparency = .8
	wait(.1)
	part.Parent = nil
end

connection = bin.Touched:connect(onTouched)