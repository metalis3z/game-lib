--//aiden32132's coding starts here\\--
script.Parent.Parent.Enter.MouseButton1Click:Connect(function()
local IsOpen = script.Parent.IsOpen
local RightDoor = script.Parent.RightDoor
script.Parent.Parent.Parent.Parent.info.SurfaceGui.SCREEN.Text = "Opening Door..."
script.Parent.Parent.Parent.Parent.go.Value = true
script.Parent.Parent.Parent.Parent.door_l.PrimaryPart = script.Parent.Parent.Parent.Parent.door_l.Primary
script.Parent.Parent.Parent.Parent.door_r.PrimaryPart = script.Parent.Parent.Parent.Parent.door_r.Primary
if RightDoor.Value == false then
	for i = 1,600 do
		wait(.005)
		script.Parent.Parent.Parent.Parent.door_l:SetPrimaryPartCFrame(script.Parent.Parent.Parent.Parent.door_l:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(-0.0025,0,0))
		script.Parent.Parent.Parent.Parent.door_r:SetPrimaryPartCFrame(script.Parent.Parent.Parent.Parent.door_r:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(0.0025,0,0))
	end
	end
IsOpen.Value = true
script.Parent.Parent.Parent.Parent.go.Value = true
wait(7)
script.Parent.Parent.Parent.Parent.go.Value = true
script.Parent.Parent.Parent.Parent.info.SurfaceGui.SCREEN.Text = "Closing Door..."
if RightDoor.Value == false then
	for i = 1,600 do
		wait(.005)
		script.Parent.Parent.Parent.Parent.door_l:SetPrimaryPartCFrame(script.Parent.Parent.Parent.Parent.door_l:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(0.0025,0,0))
		script.Parent.Parent.Parent.Parent.door_r:SetPrimaryPartCFrame(script.Parent.Parent.Parent.Parent.door_r:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(-0.0025,0,0))
	end
	end
IsOpen.Value = false
wait(3)
script.Parent.Parent.Parent.Parent.go.Value = true
script.Parent.Parent.Parent.Parent.info.SurfaceGui.SCREEN.Text = ("\\ Gate is ON //")
end)
--\\and ends here//--