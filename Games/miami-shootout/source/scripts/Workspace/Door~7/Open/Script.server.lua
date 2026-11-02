local IsOpen = script.Parent.IsOpen
local RightDoor = script.Parent.RightDoor
local cd = script.Parent.ClickDetector
script.Parent.Parent.PrimaryPart = script.Parent.Parent.Primary

function opendoor()
	if RightDoor.Value == false then
		script.Parent.Parent:SetPrimaryPartCFrame(script.Parent.Parent:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(-1.5,0,0))
	elseif RightDoor.Value == true then
		script.Parent.Parent:SetPrimaryPartCFrame(script.Parent.Parent:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(1.5,0,0))
	end
	IsOpen.Value = true
end
function closedoor()
	if RightDoor.Value == false then
		script.Parent.Parent:SetPrimaryPartCFrame(script.Parent.Parent:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(1.5,0,0))
	elseif RightDoor.Value == true then
		script.Parent.Parent:SetPrimaryPartCFrame(script.Parent.Parent:GetPrimaryPartCFrame()*CFrame.fromEulerAnglesXYZ(-1.5,0,0))
	end
	IsOpen.Value = false
end
cd.MouseClick:connect(function()
	if IsOpen.Value == true then
		closedoor()
	elseif IsOpen.Value == false then
		opendoor()
	end
end)