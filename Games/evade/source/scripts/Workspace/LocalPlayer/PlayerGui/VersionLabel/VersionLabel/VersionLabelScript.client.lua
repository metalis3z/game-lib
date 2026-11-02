--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Bunni.lol Decompiler

game:GetService("MarketplaceService")
local v_players = game:GetService("Players")
if game:GetService("RunService"):IsStudio() then
	return
else
	local v_u_parent = script.Parent
	local v_localplayer = v_players.LocalPlayer
	if not v_localplayer:GetAttribute("Role") then
		v_localplayer:GetAttributeChangedSignal("Role"):Wait()
	end
	local v_role = v_localplayer:GetAttribute("Role")
	if table.find({ "Lead", "Tester", "Dev" }, v_role) then
		v_u_parent.Visible = true
		v_u_parent.Text = ("VERSION: %*"):format(game.PlaceVersion)
		local v_u1 = false
		v_u_parent.Activated:Connect(function()
			-- upvalues: (ref) v_u1, (copy) v_u_parent
			v_u_parent.TextTransparency = v_u1 and 1 or 0
			v_u_parent.UIStroke.Transparency = v_u1 and 0 or 1
		end)
	end
end