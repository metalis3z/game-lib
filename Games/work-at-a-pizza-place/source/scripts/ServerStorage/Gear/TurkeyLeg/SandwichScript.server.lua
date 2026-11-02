local Tool = script.Parent;

enabled = true




function onActivated()
	if not enabled  then
		return
	end

	enabled = false
	Tool.GripForward = Vector3.new(0.675, -0.675, -0.3)
	Tool.GripPos = Vector3.new(0.4, -0.59, 1.1)
	Tool.GripRight = Vector3.new(0.212, -0.212, 0.954)
	Tool.GripUp = Vector3.new(0.707, 0.707, 0)


	
	
	wait(.2)
	
	local mesh = script.Parent.Handle.Mesh
	if mesh.Scale == Vector3.new(1.5,1.5,1.5) then
		mesh.Scale = Vector3.new(1,1.5,1)
		
	elseif mesh.Scale == Vector3.new(1,1.5,1) then
		mesh.Scale = Vector3.new(.5,1.5,.5)
		
	elseif mesh.Scale == Vector3.new(.5,1.5,.5) then
		Tool.Handle.DrinkSound:Play()
		script.Parent:Destroy()
		return
	end

	wait(.5)
	Tool.Handle.DrinkSound:Play()
	

	Tool.GripForward = Vector3.new(-0.976,0,-0.217)
	Tool.GripPos = Vector3.new(0, -0.4, 0)
	Tool.GripRight = Vector3.new(0.217,0,-0.976)
	Tool.GripUp = Vector3.new(0,1,0)

	
	enabled = true

end

function onEquipped()
	
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
