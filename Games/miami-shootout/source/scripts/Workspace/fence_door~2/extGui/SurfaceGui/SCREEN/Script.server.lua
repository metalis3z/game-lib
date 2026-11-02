Code = "1313" --edit this, but not past it
button = script.Parent.Parent.Enter
function Enter()
if (script.Parent.Text == Code) then
print("Accepted")
script.Parent.Text = "ACCESS GRANTED"
script.Parent.Parent.Sound2:play()
wait(1)
script.Parent.Text = "Gates Are Opening"
script.Parent.Parent.Parent.Parent.go.Value = true
wait(2)
script.Parent.Text = "PLEASE WAIT"
--//aiden32132's coding starts here\\--
local IsOpen = script.Parent.IsOpen
local RightDoor = script.Parent.RightDoor
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
script.Parent.Text = "Please enter"
for i = 1,7 do
	wait(0.5)
	script.Parent.Parent.Parent.Parent.sign.Decal.Transparency = 0
	script.Parent.Parent.Parent.Parent.sign2.Decal.Transparency = 0
	wait(0.5)
	script.Parent.Parent.Parent.Parent.sign.Decal.Transparency = 1
	script.Parent.Parent.Parent.Parent.sign2.Decal.Transparency = 1
end
script.Parent.Text = "Closing Door..."
script.Parent.Parent.Parent.Parent.go.Value = true
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
script.Parent.Text = ""
--\\aaand aiden32132's scripts end here//--


return end
script.Parent.TextColor3 = Color3.new(1,0,0)
wait(0.1)
script.Parent.TextColor3 = Color3.new(1,1,1)
wait(0.1)
script.Parent.TextColor3 = Color3.new(1,0,0)
wait(0.1)
script.Parent.TextColor3 = Color3.new(1,1,1)
wait(0.1)
script.Parent.TextColor3 = Color3.new(1,0,0)
wait(0.1)
script.Parent.TextColor3 = Color3.new(1,1,1)
wait(0.1)
script.Parent.Text = "ACCESS DISCARDED"
script.Parent.Parent.Sound3:play()
wait(0.1)
script.Parent.Parent.Sound3:play()
script.Parent.TextColor3 = Color3.new(1,0,0)
wait(0.5)
script.Parent.TextColor3 = Color3.new(1,1,1)
script.Parent.Text = ""
print("Denied")
end

button.MouseButton1Click:connect(Enter)