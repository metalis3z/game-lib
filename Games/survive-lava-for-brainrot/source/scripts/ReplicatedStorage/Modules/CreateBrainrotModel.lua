-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")
local v_u_2 = v1.Brainrots
require(v1.Registries.BrainrotRegistry)
require(v1.Registries.MutationRegistry)
return function(p3, p4, p5)
	-- upvalues: (copy) v_u_2
	local v6 = p5 or {}
	v6.Mutation = v6.Mutation or "Normal"
	if not p3 then
		warn("No brainrot name provided.", debug.traceback(nil, 2))
		p3 = "PipiKiwi"
	end
	local v7 = v_u_2:FindFirstChild(v6.Mutation)
	if not v7 then
		warn((("Mutation folder not found: %*"):format(v6.Mutation)))
		v7 = v_u_2.Normal
	end
	local v8 = v7:FindFirstChild(p3)
	if v8 then
		if v8:FindFirstChild("RootPart", true) then
			local v9 = v8:Clone()
			v9:SetAttribute("Name", p3)
			v9:SetAttribute("Mutation", v6.Mutation)
			v9:SetAttribute("UUID", v6.UUID)
			v9:SetAttribute("Owner", v6.Owner)
			v9:AddTag("Brainrot")
			if p4 then
				v9:AddTag("AnimatedBrainrot")
			end
			local v10 = v9:FindFirstChild("RootPart", true)
			v10.Parent = v9
			v9.PrimaryPart = v10
			for _, v11 in v9:GetDescendants() do
				if v11:IsA("BasePart") then
					v11.CanCollide = false
					v11.Massless = true
				end
			end
			return v9
		end
		warn((("Brainrot model is missing root part: %*/%*"):format(v6.Mutation, p3)))
	else
		warn((("Brainrot model not found: %*/%*"):format(v7.Name, p3)))
	end
end
