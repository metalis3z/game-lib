Button = script.Parent.Button.ButtonPart
Door = script.Parent.Main
Ready = true
function onClicked()
if Ready == true then
Ready = false
Button.BrickColor = BrickColor.new("Bright red")
Button.CFrame = CFrame.new(Button.Position + Vector3.new(0.1,0,0))
Door.Move.SurfaceGui.Slide:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, false, nil)
wait(1.5)
for i = 1,90,1 do
	Door.Left1.CFrame = CFrame.new(Door.Left1.Position + Vector3.new(-0.1,0,0))
	Door.Left2.CFrame = CFrame.new(Door.Left2.Position + Vector3.new(-0.1,0,0))
	Door.Right1.CFrame = CFrame.new(Door.Right1.Position + Vector3.new(0.1,0,0))
	Door.Right2.CFrame = CFrame.new(Door.Right2.Position + Vector3.new(0.1,0,0))
	wait(.01)
end
wait(5)
for i = 1,90,1 do
	Door.Left1.CFrame = CFrame.new(Door.Left1.Position + Vector3.new(0.1,0,0))
	Door.Left2.CFrame = CFrame.new(Door.Left2.Position + Vector3.new(0.1,0,0))
	Door.Right1.CFrame = CFrame.new(Door.Right1.Position + Vector3.new(-0.1,0,0))
	Door.Right2.CFrame = CFrame.new(Door.Right2.Position + Vector3.new(-0.1,0,0))
	wait(.01)
end
wait(4.5)
Door.Move.SurfaceGui.Slide:TweenSize(UDim2.new(1, 0, 1, 0), "In", "Quad", 0.5, false, nil)
wait(0.5)
Button.CFrame = CFrame.new(Button.Position + Vector3.new(-0.1,0,0))
Button.BrickColor = BrickColor.new("Bright green")
Ready = true
else
end
end
Button.ClickDetector.MouseClick:connect(onClicked)

--Zyleak