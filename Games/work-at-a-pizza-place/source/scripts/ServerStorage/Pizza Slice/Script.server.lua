local Tool = script.Parent;

enabled = true

local eatCount = 0

function onActivated()
	if not enabled  then
		return
	end

	enabled = false
	Tool.GripForward = Vector3.new(0.001, 0.305, -0.952)
	Tool.GripPos = Vector3.new(-0.752, -1.868, -0.45)
	Tool.GripRight = Vector3.new(-0.013, -0.952, -0.305)
	Tool.GripUp = Vector3.new(1, -0.012, -0.003)


	Tool.Handle.DrinkSound:Play()
	print("Changed")

	wait(.8)
	
	eatCount = eatCount + 1
	if eatCount == 3 then
		script.Parent:Destroy()
		return
	end

	Tool.GripForward = Vector3.new(0.001, -0.318, 0.948)
	Tool.GripPos = Vector3.new(0.04, 0.054, -0.824)
	Tool.GripRight = Vector3.new(-0.013, 0.948, 0.318)
	Tool.GripUp = Vector3.new(1, 0.012, 0.003)

	enabled = true

end



script.Parent.Activated:connect(onActivated)
