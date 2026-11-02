wait(0.2)
if game.ServerScriptService.DevProductHandler.In_Nuke.Value == false then
	script.Parent:TweenPosition(UDim2.new(0.22, 0,-0.07, 0), "Out", "Quad", 0.4, true)
end

game.ServerScriptService.DevProductHandler.In_Nuke.Changed:connect(function(v)
	if v == true then
		script.Parent.Active = false
		script.Parent:TweenPosition(UDim2.new(-0.6, 0,-0.07, 0), "Out", "Quad", 0.4, true)
	else
		script.Parent.Active = true
		script.Parent:TweenPosition(UDim2.new(0.22, 0,-0.07, 0), "Out", "Quad", 0.4, true)
	end
end)