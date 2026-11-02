return {
	Created = function(_, p_u_17)
		if game["Run Service"]:IsClient() then return end
		if p_u_17.Player then
			local gui = p_u_17.Config.GUI:Clone()
			gui.Parent = p_u_17.Player.PlayerGui
			for i, v in ipairs(gui:GetDescendants()) do
				if v:IsA("Script") or v:IsA("LocalScript") then
					v.Enabled = true
				end
			end
		else
			print(p_u_17)
		end
	end,
}