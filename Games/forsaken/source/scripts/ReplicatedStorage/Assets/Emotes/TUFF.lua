-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.Util)
game:GetService("CollectionService")
local v25 = {
	["DisplayName"] = "Who Wins",
	["Description"] = "\'VS FICTION...",
	["Credits"] = "Made By: AndrewDotW3b & ms_d0ss",
	["RenderImage"] = "rbxassetid://80669217430800",
	["Price"] = 1000,
	["Created"] = function(p3)
		-- upvalues: (copy) v_u_2
		if v_u_2:GetSettingValue("EpilepsyMode") then
			local v4 = script:FindFirstChild("HRPEffects")
			local v5 = p3.Character:FindFirstChild("HumanoidRootPart")
			if v5 and v4 then
				local v6 = v4.HRPPart.Floor:Clone()
				v6:SetAttribute("TUFFEmoteVFX", true)
				v6.Parent = v5
			end
		else
			local v7 = p3.Character
			if not v7 then
				return
			end
			local function v12(p8, p9)
				if p8 and p9 then
					for _, v10 in ipairs(p8:GetChildren()) do
						local v11 = v10:Clone()
						v11.Parent = p9
						v11:SetAttribute("TUFFEmoteVFX", true)
					end
				end
			end
			local v13 = v7:FindFirstChild("Torso")
			local v14 = v7:FindFirstChild("HumanoidRootPart")
			local v15 = {
				v7:FindFirstChild("Left Arm"),
				v7:FindFirstChild("Right Arm"),
				v7:FindFirstChild("Left Leg"),
				v7:FindFirstChild("Right Leg")
			}
			local v16 = script:FindFirstChild("TorsoEffects")
			if v13 and (v16 and v16:FindFirstChild("TorsoPart")) then
				v12(v16.TorsoPart, v13)
			end
			local v17 = script:FindFirstChild("HRPEffects")
			if v14 and (v17 and v17:FindFirstChild("HRPPart")) then
				v12(v17.HRPPart, v14)
			end
			local v18 = script:FindFirstChild("ArmsNLegs")
			if v18 and v18:FindFirstChild("LimbPart") then
				for _, v19 in ipairs(v15) do
					if v19 then
						v12(v18.LimbPart, v19)
					end
				end
				return
			end
		end
	end,
	["Destroyed"] = function(p20)
		local v21 = p20.Character
		if v21 then
			local v22 = {
				v21:FindFirstChild("Torso"),
				v21:FindFirstChild("HumanoidRootPart"),
				v21:FindFirstChild("Left Arm"),
				v21:FindFirstChild("Right Arm"),
				v21:FindFirstChild("Left Leg"),
				v21:FindFirstChild("Right Leg")
			}
			for _, v23 in ipairs(v22) do
				if v23 then
					for _, v24 in ipairs(v23:GetChildren()) do
						if (v24:IsA("Attachment") or v24:IsA("ParticleEmitter")) and v24:GetAttribute("TUFFEmoteVFX") then
							v24:Destroy()
						end
					end
				end
			end
		end
	end,
	["AssetID"] = "rbxassetid://95773017455324",
	["SFX"] = "rbxassetid://96092932461238",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["SyncMusic"] = true,
	["SyncAnim"] = true
}
return v25
