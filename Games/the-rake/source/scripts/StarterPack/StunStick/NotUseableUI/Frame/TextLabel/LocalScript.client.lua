while true do
	wait()
	if workspace.PowerOutValue.Value == 1 then
		script.Parent.TextTransparency = 0
		script.Parent.TextStrokeTransparency = 0
	elseif workspace.PowerOutValue.Value == 0 then
		script.Parent.TextTransparency = 1
		script.Parent.TextStrokeTransparency = 1	
	end
end