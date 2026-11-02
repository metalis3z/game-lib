while true do
	local offset = 0
	for i=1,2,.07 do
		wait()
		script.Parent.SizeOffset =  Vector2.new(0,i)
	end
	for i=2,1,-.07 do
		wait()
		script.Parent.SizeOffset =  Vector2.new(0,i)
	end
end