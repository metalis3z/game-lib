debounce = false
function touch(hit)
	if not debounce and hit ~= nil and hit.Parent ~= nil and hit:FindFirstChild("Fire") then
		debounce = true
	
		hit.Fire:Destroy()
		wait(.3)
		debounce = false
	end
	
end
script.Parent.Touched:connect(touch)