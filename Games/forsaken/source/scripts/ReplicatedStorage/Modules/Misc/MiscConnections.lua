-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = {}
local v_u_3 = require(game.ReplicatedStorage.Modules.Actors)
local v_u_4 = require(game.ReplicatedStorage.Modules.Network)
local v_u_5 = require(v1.Modules.Util)
function v2.Start(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
	if game["Run Service"]:IsServer() then
		v_u_4:SetConnection("RevealedAura", "REMOTE_EVENT", function(p6, p7, p8)
			-- upvalues: (ref) v_u_3
			if p7 and p7:IsA("Player") then
				local v9 = v_u_3.CurrentActors[p7]
				if v9 and (v9.Behavior and v9.Behavior.OnAuraRevealed) then
					v9.Behavior:OnAuraRevealed(v9, p6, p8)
				end
			end
		end)
		v_u_4:SetConnection("DamageSelf", "REMOTE_EVENT", function(p10, p11)
			-- upvalues: (ref) v_u_5
			if p10.Character.Parent == "Survivors" or p10.Character.Parent == "Killers" then
				v_u_5:ApplyDamage(p10.Character, p11)
			end
		end)
	elseif game["Run Service"]:IsClient() then
		v_u_4:SetConnection("KB", "REMOTE_EVENT", function(p12)
			-- upvalues: (ref) v_u_5
			local v13 = v_u_5:DeserializeVector(p12)
			local v14 = game.Players.LocalPlayer.Character
			if v_u_5:IsAlive(v14) then
				local v15 = v14.PrimaryPart
				local v16 = v13 + v15.AssemblyLinearVelocity / 2
				local v17 = Instance.new("LinearVelocity", v15)
				v17.VectorVelocity = v16
				v17.MaxForce = 80000
				v17.Attachment0 = v15:FindFirstChildOfClass("Attachment")
				game.TweenService:Create(v17, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					["MaxForce"] = 10
				}):Play()
				game.Debris:AddItem(v17, 0.2)
			end
		end)
	end
end
return v2
