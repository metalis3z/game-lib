-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

return {
	["Type"] = "Client",
	["Start"] = function(_, _)
		local v1 = require(game.ReplicatedStorage.Modules.Network)
		local v_u_2 = game.Players.LocalPlayer
		local _ = script.Parent.Parent.Instances
		v1:SetConnection("ExeJumpscare", "UREMOTE_EVENT", function()
			-- upvalues: (copy) v_u_2
			local v3 = v_u_2.PlayerGui:FindFirstChild("TemporaryUI")
			if v3 then
				v3 = v3:FindFirstChild("static")
			end
			if v3 then
				v3.ImageTransparency = 0
				game.TweenService:Create(v3, TweenInfo.new(1), {
					["ImageTransparency"] = 1
				}):Play()
			end
		end)
	end,
	["Destroy"] = function(_)
		require(game.ReplicatedStorage.Modules.Network):RemoveConnection("ExeJumpscare")
	end
}
