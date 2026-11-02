-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Types.Currency)

local CurrencyItem = require(ReplicatedStorage.Library.Items.CurrencyItem)

return function(p1, p2, p3, p4) --[[ Line: 9 | Upvalues: CurrencyItem (copy) ]]
	p1.boost.Text = string.format("+%d%% %s", p4, p3)
	p1.icon.Image = CurrencyItem(p3):GetIcon()

	local v1 = p1.boost:FindFirstChild(p3)

	if not v1 then
		return
	end

	v1.Enabled = true
end