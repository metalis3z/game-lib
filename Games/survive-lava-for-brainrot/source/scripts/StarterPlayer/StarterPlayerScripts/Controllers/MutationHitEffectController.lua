-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players").LocalPlayer
local v_u_4 = v2:WaitForChild("Assets")
local v_u_5 = v2:WaitForChild("Remotes"):WaitForChild("MutationEffect")
local v_u_6 = {}
local v_u_17 = {
	["Bloodmoon"] = function(p7)
		-- upvalues: (copy) v_u_4, (copy) v_u_6
		local v8 = v_u_4.LavaMutationHit:Clone()
		v8.Parent = workspace
		v8.CFrame = p7:GetPivot()
		v8:AddTag("MutationHitEffect")
		v8.Sound:Play()
		v_u_6:RecolorParticles(v8, Color3.fromRGB(252, 17, 0))
		v_u_6:EmitParticles(v8)
		game.Debris:AddItem(v8, 2)
	end,
	["Diamond"] = function(p9)
		-- upvalues: (copy) v_u_4, (copy) v_u_6
		local v10 = v_u_4.LavaMutationHit:Clone()
		v10.Parent = workspace
		v10.CFrame = p9:GetPivot()
		v10:AddTag("MutationHitEffect")
		v10.Sound:Play()
		v_u_6:RecolorParticles(v10, Color3.fromRGB(0, 158, 238))
		v_u_6:EmitParticles(v10)
		game.Debris:AddItem(v10, 2)
	end,
	["Emerald"] = function(p11)
		-- upvalues: (copy) v_u_4, (copy) v_u_6
		local v12 = v_u_4.LavaMutationHit:Clone()
		v12.Parent = workspace
		v12.CFrame = p11:GetPivot()
		v12:AddTag("MutationHitEffect")
		v12.Sound:Play()
		v_u_6:RecolorParticles(v12, Color3.fromRGB(24, 236, 0))
		v_u_6:EmitParticles(v12)
		game.Debris:AddItem(v12, 2)
	end,
	["Gold"] = function(p13)
		-- upvalues: (copy) v_u_4, (copy) v_u_6
		local v14 = v_u_4.LavaMutationHit:Clone()
		v14.Parent = workspace
		v14.CFrame = p13:GetPivot()
		v14:AddTag("MutationHitEffect")
		v14.Sound:Play()
		v_u_6:RecolorParticles(v14, Color3.fromRGB(255, 234, 0))
		v_u_6:EmitParticles(v14)
		game.Debris:AddItem(v14, 2)
	end,
	["Rainbow"] = function(p15)
		-- upvalues: (copy) v_u_4, (copy) v_u_6
		local v16 = v_u_4.LavaMutationHitRainbow:Clone()
		v16.Parent = workspace
		v16.CFrame = p15:GetPivot()
		v16:AddTag("MutationHitEffect")
		v16.Sound:Play()
		v_u_6:EmitParticles(v16)
		game.Debris:AddItem(v16, 2)
	end
}
function v_u_6.RecolorParticles(_, p18, p19)
	for _, v20 in p18:GetDescendants() do
		if v20:IsA("ParticleEmitter") then
			v20.Color = ColorSequence.new(p19)
		end
	end
end
function v_u_6.EmitParticles(_, p21)
	for _, v22 in p21:GetDescendants() do
		if v22:IsA("ParticleEmitter") then
			v22:Emit(v22:GetAttribute("EmitCount") or 1)
		end
	end
end
function v_u_6.PlayVFX(_, p23, p24)
	-- upvalues: (copy) v_u_17, (copy) v_u_3, (copy) v_u_1
	local v25 = v_u_17[p24]
	if v25 then
		local v26 = v_u_3.Character
		if v26 then
			if (v26:GetPivot().Position - p23:GetPivot().Position).Magnitude > 200 then
				return
			elseif #v_u_1:GetTagged("MutationHitEffect") <= 10 then
				print(p23, p24)
				v25(p23)
			end
		else
			return
		end
	else
		return
	end
end
function v_u_6.Start(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	v_u_5.OnClientEvent:Connect(function(p27, p28)
		-- upvalues: (ref) v_u_6
		v_u_6:PlayVFX(p27, p28)
	end)
end
task.spawn(function()
	-- upvalues: (copy) v_u_6
	v_u_6:Start()
end)
return v_u_6
