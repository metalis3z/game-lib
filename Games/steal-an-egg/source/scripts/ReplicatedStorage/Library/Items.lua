-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local AbstractItem = require(script.AbstractItem)
local Container = require(script.Container)
local Types = require(script.Types)
local t = {
	Root = AbstractItem,
	All = AbstractItem,
	Types = {
		Currency = require(script.CurrencyItem),
		Gear = require(script.GearItem),
		Brainrot = require(script.BrainrotItem),
		SpeedPower = require(script.SpeedPowerItem)
	},
	Container = Container,
	TypeUnchecked = Types.TypeUnchecked,
	Type = Types.Type,
	FromModule = Types.FromModule,
	From = Types.From,
	AssertModule = AbstractItem.AssertModule,
	AssertUID = AbstractItem.AssertUID,
	AssertOptionalUID = AbstractItem.AssertOptionalUID,
	AssertUIDFast = AbstractItem.AssertUIDFast,
	AssertOptionalUIDFast = AbstractItem.AssertOptionalUIDFast,
	GenerateUID = AbstractItem.GenerateUID,
	AssertOrGenerateUID = AbstractItem.AssertOrGenerateUID,
	AssertUniqueItems = AbstractItem.AssertUniqueItems,
	Nil = AbstractItem.Nil
}

setmetatable(t, {
	__index = t.Types
})

return t