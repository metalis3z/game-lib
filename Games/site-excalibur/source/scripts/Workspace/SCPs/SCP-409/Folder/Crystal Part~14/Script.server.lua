function onTouched(part)
	local h = part.Parent:findFirstChild("Humanoid")
	if h~=nil then
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(1)
		h.Health = h.Health -1
		wait(10)
		h.Health = h.Health -100	
		wait(9)
		
	end
end

script.Parent.Touched:connect(onTouched)

