function query()
	for i,v in pairs (script.Parent.Parent.Parent.running:GetChildren()) do
		if v.Visible then
			return true
		end
	end
	return false
end

function hideApps()
	for i,v in pairs(script.Parent.Parent.Parent.apps:GetChildren()) do
		if v.Visible then
			v.Visible = false
		end
	end
end

script.Parent.MouseButton1Click:Connect(function()
	local qu = query()
	if qu then return print("app already open") end
	print("cam click")
	script.Parent.Parent.Parent.running.cam.Visible = true
	hideApps()
end)