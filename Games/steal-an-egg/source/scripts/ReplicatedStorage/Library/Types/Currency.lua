-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {}
local t3 = {}

t2.SchemaValidation = t3
t3.AllCurrencyTypes = t.union(t.literal("Money"), t.literal("SpinnyWheelTickets"))
t2.AllCurrencyTypes = {
	Money = "Money",
	SpinnyWheelTickets = "SpinnyWheelTickets"
}
t2.AllCurrencyTypesArray = { "Money", "SpinnyWheelTickets" }

return t2