script.Parent.MouseEnter:Connect(function()
	script.Parent:TweenSize(UDim2.new(0.669, 0,0.142, 0),"InOut","Quad",0.3,true)
end)

script.Parent.MouseLeave:Connect(function()
	script.Parent:TweenSize(UDim2.new(0.785, 0,0.166, 0),"InOut","Quad",0.3,true)
end)