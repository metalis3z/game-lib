-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-03-18 09:03:38
-- Luau version 6, Types version 3
-- Time taken: 0.000544 seconds

if script:IsDescendantOf(workspace) then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Highlight"
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.FillTransparency = 1
	Highlight.OutlineColor = Color3.fromRGB(255, 12, 12)
	Highlight.Parent = script.Parent
end