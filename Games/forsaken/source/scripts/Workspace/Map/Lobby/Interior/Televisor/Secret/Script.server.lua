-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

if not workspace:GetAttribute("Testing") then
	local v_u_1 = script.Parent
	local v2 = Instance.new("ClickDetector")
	v2.Parent = v_u_1
	local v_u_3 = 0
	local v_u_4 = false
	local v_u_5 = require(game.ReplicatedStorage.Modules.Network)
	v2.MouseClick:Connect(function(_)
		-- upvalues: (ref) v_u_3, (ref) v_u_4, (copy) v_u_1, (copy) v_u_5
		v_u_3 = v_u_3 + 1
		if not v_u_4 then
			local v6 = v_u_1:FindFirstChild("Beam")
			if v6 then
				v6:Destroy()
			end
			v_u_1.Glass.Transparency = 0.8
			v_u_1.Neon.Transparency = 1
			v_u_1.Image.Decal.Texture = "rbxassetid://101971414372024"
			v_u_4 = true
		end
		if v_u_3 <= 15 then
			local v_u_7 = Instance.new("Sound")
			v_u_7.SoundId = "rbxassetid://7796215954"
			v_u_7.Volume = 0.25
			v_u_7.Parent = v_u_1
			v_u_7:Play()
			v_u_7.Ended:Connect(function()
				-- upvalues: (copy) v_u_7
				v_u_7:Destroy()
			end)
		end
		if v_u_3 == 15 then
			v_u_5:FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "TVTIME")
		end
	end)
end
