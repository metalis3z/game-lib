-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if not game:GetService("UserInputService").TouchEnabled then
	return
end

local Size = script.Parent.Size

script.Parent.Position = UDim2.new(script.Parent.Position.X.Scale, script.Parent.Position.X.Offset, script.Parent.Position.Y.Scale - 0.15, script.Parent.Position.Y.Offset)