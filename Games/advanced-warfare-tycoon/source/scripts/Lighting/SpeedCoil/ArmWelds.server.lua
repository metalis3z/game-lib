script.Parent.Equipped:connect(function(equip)

human = script.Parent.Parent
if human:IsA("Model") then
	print("Yus")
Weld = Instance.new("ManualWeld") 
Weld.Name = "ArmWelds"
Weld.C0 = CFrame.fromEulerAnglesXYZ(1.6,0,0)  --Angle of the actual "item"
Weld.Parent = human.Torso --Dunno
Weld.Part0 = human["Left Arm"]
Weld.Part1 = script.Parent["LeftHandle"]
end
end)
--made by ninja5566