script.Parent.Upgrader.Touched:connect(function(hit)
	if hit:FindFirstChild("Cash") then
		hit.Cash.Value = hit.Cash.Value + 6000
	end
end)