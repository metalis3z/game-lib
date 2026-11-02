-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

return {
	["Type"] = "Client",
	["Start"] = function(_, _)
		local v1 = game.Players.LocalPlayer
		local _ = v1.Character
		local v_u_2 = script.static:Clone()
		v_u_2.Parent = v1.PlayerGui.TemporaryUI
		task.spawn(function()
			-- upvalues: (copy) v_u_2
			while v_u_2.Parent do
				for v3 = 0, 2 do
					for v4 = 0, 2 do
						if v4 ~= 2 or v3 ~= 2 then
							v_u_2.ImageRectOffset = Vector2.new(333 * v4, 250 * v3)
							task.wait()
						end
					end
				end
			end
		end)
	end,
	["Destroy"] = function(_) end
}
