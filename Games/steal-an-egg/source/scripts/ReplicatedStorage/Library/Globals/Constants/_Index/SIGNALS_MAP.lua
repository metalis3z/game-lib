-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Server = script.Server
local Client = script.Client
local Shared = script.Shared
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}

t.Server = t2
t.Client = t3
t.Shared = t4
t4.AssetGenerationUtil = require(Shared.AssetGenerationUtil)
t2.MoneyService = require(Server.MoneyService)
t2.GearInventory = require(Server.GearInventory)
t2.EggInventory = require(Server.EggInventory)
t2.SwordInventory = require(Server.SwordInventory)
t2.SkinInventory = require(Server.SkinInventory)
t2.Inventory = require(Server.Inventory)
t2.Rebirth = require(Server.Rebirth)
t2.Guards = require(Server.Guards)
t2.AreaBrainrot = require(Server.AreaBrainrot)
t2.Kernel = require(Server.Kernel)
t2.MurderMystery = require(Server.MurderMystery)
t2.ActiveAssetsController = require(Server.ActiveAssetsController)
t2.BrainrotItem = require(Server.BrainrotItem)
t3.ActiveAssetItems = require(Client.ActiveAssetItems)
t3.Plots = require(Client.Plots)
t3.ClientCharacter = require(Client.ClientCharacter)
t3.TradingNotifications = require(Client.TradingNotifications)
t3.FuseMachine = require(Client.FuseMachine)

return t