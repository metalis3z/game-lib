-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v5 = {
	["DisplayName"] = "Chronoshift",
	["Description"] = "This happens every time you waste your Ult.",
	["Credits"] = "Made By: snowyblessing & ProbablyDemo",
	["RenderImage"] = "rbxassetid://139203361911725",
	["Price"] = 650,
	["AssetID"] = "rbxassetid://87639402487247",
	["SFX"] = "rbxassetid://137501116290172",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["CreatedServer"] = function(p_u_1)
		local v_u_2 = p_u_1.Character
		if v_u_2 then
			v_u_2 = p_u_1.Character.PrimaryPart
		end
		local v_u_3 = p_u_1.Emote
		local v_u_4 = script.BillboardGui:Clone()
		v_u_4.Parent = p_u_1.Character
		v_u_4.Adornee = p_u_1.Character.PrimaryPart
		if math.random(1, 10) == 2 then
			v_u_4.TextLabel.Text = "MAP AWARENESS"
		end
		task.spawn(function()
			-- upvalues: (copy) p_u_1, (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
			while p_u_1 and (v_u_2 and (v_u_3 and v_u_3.IsPlaying)) do
				v_u_4.Enabled = not v_u_4.Enabled
				task.wait(0.17)
			end
			if v_u_4 then
				v_u_4:Destroy()
			end
		end)
	end
}
return v5
