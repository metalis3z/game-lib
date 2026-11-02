grp1 = script.Parent.G1:GetChildren()
while true do
wait(0)
if script.Parent.on.Value == true then
	
	for i = 1,#grp1 do
		grp1[i].Transparency = 0
		grp1[i].Light.Enabled = true
	end
	script.Parent.MeshPart.Transparency = 0
	script.Parent.MeshPart.TextureID = ""
	script.Parent.MeshPart.Light.Enabled = true
	wait(0.35)
	
	for i = 1,#grp1 do
		grp1[i].Transparency = 1
		grp1[i].Light.Enabled = false
	end
	script.Parent.MeshPart.Transparency = 0
	script.Parent.MeshPart.TextureID = "rbxassetid://4504919219"
	script.Parent.MeshPart.Light.Enabled = false
	wait(0.35)
else
	for i = 1,#grp1 do
		grp1[i].Transparency = 1
		grp1[i].Light.Enabled = false
	end
	script.Parent.MeshPart.Transparency = 1
	script.Parent.MeshPart.Light.Enabled = false
end
end