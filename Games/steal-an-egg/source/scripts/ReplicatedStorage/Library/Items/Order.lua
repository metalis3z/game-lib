-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local list = {
	"Box",
	"Currency",
	"Pet",
	"Egg",
	"Lootbox",
	"Charm",
	"Ultimate",
	"Enchant",
	"XPPotion",
	"Potion",
	"Misc",
	"Hoverboard",
	"Booth",
	"Fruit",
	"Seed",
	"Page"
}
local t = {}

for i, v in ipairs(list) do
	t[v] = i
end

return {
	Order = t,
	OrderInv = list
}