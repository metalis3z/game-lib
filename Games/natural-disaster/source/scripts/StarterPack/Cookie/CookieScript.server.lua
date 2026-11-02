local Tool = script.Parent

enabled = true




function onActivated()
	if not enabled  then
		return
	end

	enabled = false
	Tool.GripForward = Vector3.new(0.439, 0.878, 0.189)
	Tool.GripPos = Vector3.new(-0.3, 1.2, -1.3)
	Tool.GripRight = Vector3.new(0.0844, 0.169, -0.982)
	Tool.GripUp = Vector3.new(0.894, -0.347, 0)


	Tool.Handle.EatSound:Play()

script.Parent.Bites.Value = script.Parent.Bites.Value + 1
	wait(.8)
	
Eable()
	local h = Tool.Parent:FindFirstChild("Humanoid")
	if (h ~= nil) then
		if (h.MaxHealth > h.Health + 1.6) then
			h.Health = h.Health + 1.6
		else	
			h.Health = h.MaxHealth
		end
	end

	Tool.GripForward = Vector3.new(-1, 1, -0)
	Tool.GripPos = Vector3.new(0.1, -0.3, 0)
	Tool.GripRight = Vector3.new(0,0, -1)
	Tool.GripUp = Vector3.new(1,0,0)


	enabled = true

end

function onEquipped()

end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)


script.Parent.Handle.Touched:connect(onTouched)

function Eable()
if (script.Parent.Bites.Value) > 2 then 
script.Parent:Remove()
end
end

