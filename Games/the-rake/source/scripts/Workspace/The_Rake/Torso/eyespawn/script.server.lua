script.Parent.Parent.Parent.NPC.Changed:Connect(function()
	if script.Parent.Parent.Parent.NPC.Health == 0 then
		script.Parent.Enabled = false
	end
end)