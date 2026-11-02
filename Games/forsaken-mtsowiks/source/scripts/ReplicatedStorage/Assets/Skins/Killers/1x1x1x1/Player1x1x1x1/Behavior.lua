-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["GetRig"] = function(_, p_u_1)
		local v_u_2 = p_u_1.Rig:Clone()
		v_u_2:SetPrimaryPartCFrame(CFrame.new(0, 100000, 0))
		local v3
		if v_u_2 then
			v3 = v_u_2.PrimaryPart
		else
			v3 = v_u_2
		end
		if v3 then
			v3.Anchored = true
		end
		v_u_2.Parent = workspace
		pcall(function()
			-- upvalues: (copy) p_u_1, (copy) v_u_2
			local v4 = game.Players:GetHumanoidDescriptionFromUserId(p_u_1.Player.UserId)
			v4.Head = 0
			v4.Face = 0
			v_u_2.Humanoid:ApplyDescription(v4, Enum.AssetTypeVerification.Always)
			for _, v5 in pairs(v_u_2:GetChildren()) do
				if v5:IsA("CharacterMesh") and v5.MeshId ~= 48112070 then
					v5:Destroy()
				end
			end
			v_u_2["Right Cuff"].gubby.Color3 = v4.TorsoColor
			v_u_2["Left Cuff"].gubby.Color3 = v4.TorsoColor
			v_u_2.Crown.gubby.Color3 = v4.TorsoColor
			v_u_2.SkelTorso.gubby.Color3 = v4.TorsoColor
			v_u_2.SkelTorso.Attachment.PointLight.Color = v4.TorsoColor
			for _, v6 in pairs(v_u_2:GetDescendants()) do
				if v6:IsA("ParticleEmitter") and (v6.Name == "Number" or v6.Name == "Aura") then
					v6.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v4.TorsoColor), ColorSequenceKeypoint.new(1, v4.TorsoColor) })
				end
			end
			for _, v7 in pairs(v_u_2:GetDescendants()) do
				if v7:IsA("Decal") and (v7.Name == "gubby" or v7.Name == "Aura") then
					v7.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v4.TorsoColor), ColorSequenceKeypoint.new(1, v4.TorsoColor) })
				end
			end
		end)
		for _, v8 in pairs(v_u_2:GetChildren()) do
			if v8:IsA("Accessory") and (v8.AccessoryType == Enum.AccessoryType.Waist or (v8.AccessoryType == Enum.AccessoryType.Front or v8.AccessoryType == Enum.AccessoryType.Back)) then
				v8:Destroy()
			end
		end
		return v_u_2
	end
}