-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GIF = require(ReplicatedStorage.Library.Client.GUIFX.GIF)

function Initialize(p1, p2) --[[ Initialize | Line: 4 | Upvalues: GIF (copy) ]]
	p1.Destroying:Connect((GIF(p1.GIFHolder.GIF, 1.75)))
end

return Initialize