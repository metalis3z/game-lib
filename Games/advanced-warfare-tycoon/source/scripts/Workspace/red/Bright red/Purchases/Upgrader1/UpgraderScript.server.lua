script.Parent.Upgrade.Touched:connect(function(hit)
	if hit:FindFirstChild("Cash") then
		hit.Cash.Value = hit.Cash.Value + 13 
		hit.Reflectance = hit.Reflectance + 0.1
	end
end)