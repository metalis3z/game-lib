-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("PolicyService")
local v_u_2 = game:GetService("Players").LocalPlayer
local v3, v4 = pcall(function()
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	return v_u_1:GetPolicyInfoForPlayerAsync(v_u_2)
end)
if v3 and v4 then
	local v5 = v4.AllowedExternalLinkReferences
	local v6 = { "X", "Discord", "YouTube" }
	local v7 = 0
	for _, v8 in pairs(v5) do
		if table.find(v6, v8) then
			v7 = v7 + 1
		end
	end
	if v7 < #v6 then
		script.Parent.Text = "See HD Admin\'s description (in Marketplace) for updates"
	end
end
