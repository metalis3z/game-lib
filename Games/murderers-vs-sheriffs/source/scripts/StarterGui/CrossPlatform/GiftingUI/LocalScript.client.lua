local v_u_1 = script.Parent
game.Players.LocalPlayer.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_1
	v_u_1.Visible = false
end)
