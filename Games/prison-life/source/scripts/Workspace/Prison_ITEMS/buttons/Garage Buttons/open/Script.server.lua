function onclicked()
	if script.Parent.Parent.Value.Value == false then
		script.Parent.Parent.Value.Value = true
		for i = 1, 15 do
			script.Parent.Parent.Parent.Parent.Parent.Warehouses.Warehouse1.doors.leftDoor.CFrame = script.Parent.Parent.Parent.Parent.Parent.Warehouses.Warehouse1.doors.leftDoor.CFrame * CFrame.new(0,0,1.06)
			script.Parent.Parent.Parent.Parent.Parent.Warehouses.Warehouse1.doors.rightDoor.CFrame = script.Parent.Parent.Parent.Parent.Parent.Warehouses.Warehouse1.doors.rightDoor.CFrame * CFrame.new(0,0,-1.06)
			wait()
		end
	end
end

script.Parent.ClickDetector.MouseClick:Connect(onclicked)
