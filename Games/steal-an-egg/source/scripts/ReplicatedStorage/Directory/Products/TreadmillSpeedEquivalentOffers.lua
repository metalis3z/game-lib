-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types.Interface)

local list = {
	{
		ProductName = "TreadmillSpeed_5Minutes",
		DurationSeconds = 300,
		ProductId = 3612508008
	},
	{
		ProductName = "TreadmillSpeed_30Minutes",
		DurationSeconds = 1800,
		ProductId = 3612508088
	},
	{
		ProductName = "TreadmillSpeed_1Hour",
		DurationSeconds = 3600,
		ProductId = 3612508192
	},
	{
		ProductName = "TreadmillSpeed_4Hours",
		DurationSeconds = 14400,
		ProductId = 3612508244
	}
}

for i, v in ipairs(list) do
	table.freeze(v)
end

return table.freeze(list)