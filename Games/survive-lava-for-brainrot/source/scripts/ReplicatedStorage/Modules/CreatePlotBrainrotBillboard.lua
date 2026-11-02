-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("ServerStorage")
local v3 = v1.Assets
local v_u_4 = v1.Brainrots.Normal
local v_u_5 = v3.BrainrotAtt
local v_u_6 = require(v1.Shared.FormatNumber)
local v_u_7 = require(v2.Services.GameService)
local v_u_8 = require(v1.Registries.BrainrotRegistry)
local v_u_9 = require(v1.Registries.MutationRegistry)
local v_u_10 = require(v1.Registries.RarityRegistry)
return function(p11, p12, p13, p14)
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_5, (copy) v_u_9, (copy) v_u_10, (copy) v_u_7, (copy) v_u_6
	local v15 = p14 or {}
	v15.Mutation = v15.Mutation or "Normal"
	if p13 then
		if not p12 then
			warn("No brainrot name provided.", debug.traceback(nil, 2))
			p12 = "PipiKiwi"
		end
		local v16 = v_u_4:FindFirstChild(p12)
		if v16 then
			local v17 = v_u_8[p12]
			if v17 then
				local v18 = v15.Level
				local v19 = v15.Mutation
				local v20 = v15.Traits
				local v21 = v17.Rarity
				local v22 = v_u_5:Clone()
				v22.CFrame = CFrame.new(0, p13.PrimaryPart.Size.Y / 2 + 4, 0) + (v16:GetAttribute("AttOffset") or Vector3.new(0, 0, 0))
				v22.BillboardGui.Mutation.Text = v19
				v22.BillboardGui.Mutation.Visible = v19 ~= "Normal"
				v22.BillboardGui.Mutation.TextColor3 = v_u_9[v19].Color
				v22.BillboardGui.Rarity.Text = v21
				v22.BillboardGui.Rarity.TextColor3 = v_u_10[v21].Color
				if v19 == "Rainbow" then
					v22.BillboardGui.Mutation:AddTag("Rainbow")
				end
				if v21 == "Secret" then
					v22.BillboardGui.Rarity:AddTag("Secret")
				end
				if v21 == "Celestial" then
					v22.BillboardGui.Rarity:AddTag("Celestial")
				end
				if v21 == "Godly" then
					v22.BillboardGui.Rarity:AddTag("Godly")
				end
				local v23 = v_u_7:GetCashPerSec(v17.CashPerSec, v19, v18, v20)
				local v24 = v17.DisplayName or p12:gsub("(%u)", " %1"):gsub("^ ", "")
				v22.BillboardGui.Title.Text = v24 .. " [Lv. " .. v18 .. "]"
				v22.BillboardGui.Cash.Text = "$" .. v_u_6(v_u_7:GetPerSecLevel(v23, v18) * p11:GetAttribute("CashMultiplier")) .. "/s"
				v22.Parent = p13.RootPart
				return v22
			end
			warn((("Brainrot entry not found: %*"):format(p12)))
		else
			warn((("Normal model not found: Normal/%*"):format(p12)))
		end
	else
		warn("No brainrot model provided.", debug.traceback(nil, 2))
		return
	end
end
