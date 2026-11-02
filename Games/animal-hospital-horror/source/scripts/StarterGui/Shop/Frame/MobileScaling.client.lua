-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if not game:GetService("UserInputService").TouchEnabled then
	return
end

local Size = script.Parent.Size

script.Parent.Size = UDim2.new(Size.X.Scale * 1.1, Size.X.Offset, Size.Y.Scale * 1.1, Size.Y.Offset)