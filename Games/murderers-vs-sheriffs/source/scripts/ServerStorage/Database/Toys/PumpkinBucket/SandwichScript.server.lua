local Tool = script.Parent;

enabled = true


local gripf, gripp, gripr, gripu = Tool.GripForward, Tool.GripPos, Tool.GripRight, Tool.GripUp

function onActivated()
	if not enabled  then
		return
	end

	enabled = false
	Tool.GripForward = Vector3.new(-0.976,0,-0.217)
	Tool.GripPos = Vector3.new(.95,-0.76,1.4)
	Tool.GripRight = Vector3.new(0.217,0, 0.976)
	Tool.GripUp = Vector3.new(0,1,0)


	Tool.Handle.DrinkSound:Play()

	wait(.8)

	Tool.GripForward = gripf
	Tool.GripPos = gripp
	Tool.GripRight = gripr
	Tool.GripUp = gripu


	enabled = true

end

function onEquipped()
	Tool.Handle.OpenSound:play()
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
