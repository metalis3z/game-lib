-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v8 = {
	["Data"] = {
		["Duration"] = 10,
		["MaxLevel"] = 4,
		["Stackable"] = true
	},
	["Applied"] = function(p_u_1)
		if game["Run Service"]:IsClient() then
			local v2 = script
			local v3 = p_u_1.Level
			local v4 = v2:FindFirstChild((tostring(v3)))
			if v4 then
				if p_u_1.VisualEffects then
					p_u_1.VisualEffects:Destroy()
				end
				if p_u_1.ColorCorrection then
					p_u_1.ColorCorrection:Destroy()
				end
				if p_u_1.Connection then
					p_u_1.Connection:Disconnect()
				end
				p_u_1.VisualEffects = v4.EffectParts:Clone()
				p_u_1.VisualEffects.Parent = workspace.Map.Ingame
				p_u_1.ColorCorrection = v4.ColorCorrection:Clone()
				p_u_1.ColorCorrection.Parent = game.Lighting
				p_u_1.Connection = game["Run Service"].RenderStepped:Connect(function(p5)
					-- upvalues: (copy) p_u_1
					if p_u_1.VisualEffects and p_u_1.VisualEffects.PrimaryPart then
						p_u_1.VisualEffects:SetPrimaryPartCFrame(workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -8))
						local v6 = p_u_1.VisualEffects.Scanlines
						v6.CFrame = v6.CFrame * CFrame.new(0, -p5 / 2, 0)
					end
				end)
			end
		end
	end,
	["Removed"] = function(p7)
		if p7.VisualEffects then
			p7.VisualEffects:Destroy()
		end
		if p7.ColorCorrection then
			p7.ColorCorrection:Destroy()
		end
		if p7.Connection then
			p7.Connection:Disconnect()
		end
		p7.VisualEffects = nil
		p7.ColorCorrection = nil
		p7.Connection = nil
	end,
	["Heartbeat"] = function(_, _) end
}
return v8
