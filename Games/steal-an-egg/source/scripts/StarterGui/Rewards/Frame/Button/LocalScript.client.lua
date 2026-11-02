-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

for v1, v2 in require(ReplicatedStorage.Library.Client.GUIFX.EasyVisuals).new(script.Parent, "Wrapper", 0.5, nil, nil, script.Parent.Gradient.Color).EffectObjects do
	if v2.__class == "Gradient" then
		v2:SetRotation(script.Parent.Gradient.Rotation, script.Parent.Gradient.Rotation)
	end
end