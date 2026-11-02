script.Parent.Upgrader.Touched:connect(function(hit)
	if hit:FindFirstChild("Cash") then
		hit.Cash.Value = hit.Cash.Value + hit.Cash.Value + 67 
		hit.Reflectance = hit.Reflectance + 0.3
	end
end)