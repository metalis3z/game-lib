script.Parent.MouseButton1Click:connect(function() script.Parent.Parent.Visible =false end)

game.Workspace.Main.PointsAwarded.OnClientEvent:connect(function(total)
	if not _G.GamepadEnabled then	
		script.Parent.Parent.Visible = true
		script.Parent.Parent.total.Text = "You have earned " .. total .. " player points from this game so far."
	end
end)





