--credit to quartz games studio
--[==[
============================================================
 CLAUDE DEPENDENCY REPORT
 Generated : 2026-06-13 10:37:53
 Scripts   : 1082  (ModuleScripts: 947)
 Edges     : 1237  (resolved: 931, unresolved: 306)
============================================================

## FORWARD  (script  ->  requiere)

[LocalScript] ReplicatedFirst.LoadingScreenController
    -> ReplicatedStorage.ClientModules.Blur

[ModuleScript] ReplicatedStorage.Assets.Cutscenes.GAGTrailer.Markers
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.PlantController
    -> ReplicatedStorage.ClientModules.CamShake
    -> ReplicatedStorage.ClientModules.BodyShaker

[ModuleScript] ReplicatedStorage.Assets.Cutscenes.GAGTrailerNoWalls.Markers
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.PlantController
    -> ReplicatedStorage.ClientModules.CamShake
    -> ReplicatedStorage.ClientModules.BodyShaker

[ModuleScript] ReplicatedStorage.Assets.Cutscenes.GAGTrailerShortVers.Markers
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.PlantController
    -> ReplicatedStorage.ClientModules.CamShake
    -> ReplicatedStorage.ClientModules.BodyShaker

[LocalScript] ReplicatedStorage.Assets.ExtraPreview.Billboard_UI.Billboard_UI.Objects.UIListLayout
    -> ReplicatedStorage.ClientModules.Device

[Script] ReplicatedStorage.Assets.NpcUIs.Response_UI.Script
    -> ReplicatedStorage.ClientModules.TopText

[ModuleScript] ReplicatedStorage.ClientModules.CCDIKController
    -> ReplicatedStorage.ClientModules.CCDIKController.VectorUtil
    -> ReplicatedStorage.ClientModules.CCDIKController.Maid

[ModuleScript] ReplicatedStorage.ClientModules.CamShake
    -> ReplicatedStorage.ClientModules.CamShake.CameraShaker

[ModuleScript] ReplicatedStorage.ClientModules.CamShake.CameraShaker
    -> ReplicatedStorage.ClientModules.CamShake.CameraShaker.CameraShakeInstance
    -> ReplicatedStorage.ClientModules.CamShake.CameraShaker.CameraShakePresets

[ModuleScript] ReplicatedStorage.ClientModules.CamShake.CameraShaker.CameraShakePresets
    -> ReplicatedStorage.ClientModules.CamShake.CameraShaker.CameraShakeInstance

[ModuleScript] ReplicatedStorage.ClientModules.Device
    -> ReplicatedStorage.ClientModules.Signal

[ModuleScript] ReplicatedStorage.ClientModules.Effects.LevelUpEffect
    -> ReplicatedStorage.ClientModules.SpiralTrail

[ModuleScript] ReplicatedStorage.ClientModules.FramePopup
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> [NO RESUELTO] ClientModules.Blur

[ModuleScript] ReplicatedStorage.ClientModules.Iris
    -> ReplicatedStorage.ClientModules.Iris.Types
    -> ReplicatedStorage.ClientModules.Iris.Internal
    -> ReplicatedStorage.ClientModules.Iris.config
    -> ReplicatedStorage.ClientModules.Iris.demoWindow
    -> ReplicatedStorage.ClientModules.Iris.widgets
    -> ReplicatedStorage.ClientModules.Iris.API

[ModuleScript] ReplicatedStorage.ClientModules.Iris.API
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.Internal
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.PubTypes
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.Types
    -> ReplicatedStorage.ClientModules.Iris.WidgetTypes

[ModuleScript] ReplicatedStorage.ClientModules.Iris.demoWindow
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets
    -> ReplicatedStorage.ClientModules.Iris.Types
    -> ReplicatedStorage.ClientModules.Iris.widgets.Root
    -> ReplicatedStorage.ClientModules.Iris.widgets.Window
    -> ReplicatedStorage.ClientModules.Iris.widgets.Menu
    -> ReplicatedStorage.ClientModules.Iris.widgets.Format
    -> ReplicatedStorage.ClientModules.Iris.widgets.Text
    -> ReplicatedStorage.ClientModules.Iris.widgets.Button
    -> ReplicatedStorage.ClientModules.Iris.widgets.Checkbox
    -> ReplicatedStorage.ClientModules.Iris.widgets.RadioButton
    -> ReplicatedStorage.ClientModules.Iris.widgets.Image
    -> ReplicatedStorage.ClientModules.Iris.widgets.Tree
    -> ReplicatedStorage.ClientModules.Iris.widgets.Tab
    -> ReplicatedStorage.ClientModules.Iris.widgets.Input
    -> ReplicatedStorage.ClientModules.Iris.widgets.Combo
    -> ReplicatedStorage.ClientModules.Iris.widgets.Plot
    -> ReplicatedStorage.ClientModules.Iris.widgets.Table

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Button
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Checkbox
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Combo
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Format
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Image
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Input
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Menu
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Plot
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.RadioButton
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Root
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Tab
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Table
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Text
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Tree
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.Iris.widgets.Window
    -> ReplicatedStorage.ClientModules.Iris.Types

[ModuleScript] ReplicatedStorage.ClientModules.MessagePrompt
    -> [NO RESUELTO] Controllers:WaitForChild("GuiController")

[ModuleScript] ReplicatedStorage.ClientModules.NPC
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> [NO RESUELTO] ClientModules.FramePopup

[ModuleScript] ReplicatedStorage.ClientModules.PlayerStateClient
    -> ReplicatedStorage.ClientModules.ReplicaClient

[ModuleScript] ReplicatedStorage.ClientModules.RagdollModule
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] ReplicatedStorage.ClientModules.ReplicaClient
    -> ReplicatedStorage.ReplicaShared.Remote
    -> ReplicatedStorage.ReplicaShared.Signal
    -> ReplicatedStorage.ReplicaShared.Maid
    -> [NO RESUELTO] p1

[ModuleScript] ReplicatedStorage.ClientModules.RestockStoreController
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.PlayerStateClient
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.SfxController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GreenbeanAvatarController
    -> ReplicatedStorage.SharedData.GreenbeanCheck
    -> ReplicatedStorage.ClientModules.WatchButtonHold

[ModuleScript] ReplicatedStorage.ClientModules.Reticule
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] ReplicatedStorage.ClientModules.ScreenResolution
    -> ReplicatedStorage.ClientModules.Signal

[ModuleScript] ReplicatedStorage.ClientModules.SpiralTrail
    -> ReplicatedStorage.ClientModules.SpiralTrail.CreateTrail

[ModuleScript] ReplicatedStorage.ClientModules.Trove.init.spec
    -> ReplicatedStorage.ClientModules.Trove

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus
    -> ReplicatedStorage.ClientModules.topbarplus.Types
    -> ReplicatedStorage.ClientModules.topbarplus.Reference
    -> [NO RESUELTO] v3
    -> ReplicatedStorage.ClientModules.topbarplus.Packages.GoodSignal
    -> ReplicatedStorage.ClientModules.topbarplus.Packages.Janitor
    -> ReplicatedStorage.ClientModules.topbarplus.Utility
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Themes
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Gamepad
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Overflow
    -> [NO RESUELTO] v12.Default
    -> [NO RESUELTO] v15.Container
    -> ReplicatedStorage.ClientModules.topbarplus.Attribute
    -> [NO RESUELTO] v15.Widget
    -> [NO RESUELTO] v15.Notice
    -> [NO RESUELTO] v15.Caption
    -> [NO RESUELTO] v15.Dropdown
    -> [NO RESUELTO] v15.Indicator
    -> ReplicatedStorage.ClientModules.topbarplus.Packages.GoodSignal
    -> ReplicatedStorage.ClientModules.topbarplus.Packages.Janitor
    -> ReplicatedStorage.ClientModules.topbarplus.Utility
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Themes
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Gamepad
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Overflow
    -> [NO RESUELTO] v12.Default
    -> [NO RESUELTO] v15.Container
    -> ReplicatedStorage.ClientModules.topbarplus.Attribute
    -> [NO RESUELTO] v15.Widget
    -> [NO RESUELTO] v15.Notice
    -> [NO RESUELTO] v15.Caption
    -> [NO RESUELTO] v15.Dropdown
    -> [NO RESUELTO] v15.Indicator

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Attribute
    -> ReplicatedStorage.ClientModules.topbarplus.VERSION

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Elements.Caption
    -> [NO RESUELTO] p1.iconModule

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Elements.Container
    -> ReplicatedStorage.ClientModules.topbarplus.Packages.GoodSignal
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Themes.Classic

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Elements.Dropdown
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Themes
    -> [NO RESUELTO] p1.iconModule

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Elements.Menu
    -> [NO RESUELTO] p1.iconModule
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Themes

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Elements.Notice
    -> [NO RESUELTO] Packages.Janitor
    -> [NO RESUELTO] Packages.GoodSignal
    -> ReplicatedStorage.ClientModules.topbarplus.Utility

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Elements.Widget
    -> ReplicatedStorage.ClientModules.topbarplus.Elements.Menu
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Gamepad
    -> ReplicatedStorage.ClientModules.topbarplus.Utility

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Features.Gamepad
    -> ReplicatedStorage.ClientModules.topbarplus.Elements.Selection

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Features.Overflow
    -> ReplicatedStorage.ClientModules.topbarplus.Utility

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Features.Themes
    -> ReplicatedStorage.ClientModules.topbarplus.Utility
    -> ReplicatedStorage.ClientModules.topbarplus.Features.Themes.Default
    -> [NO RESUELTO] p2

[ModuleScript] ReplicatedStorage.ClientModules.topbarplus.Utility
    -> ReplicatedStorage.ClientModules.topbarplus.Packages.Janitor
    -> [NO RESUELTO] p1.iconModule
    -> [NO RESUELTO] p1.iconModule

[ModuleScript] ReplicatedStorage.CmdrClient
    -> ReplicatedStorage.CmdrClient.Shared.Util
    -> ReplicatedStorage.CmdrClient.Shared.Registry
    -> ReplicatedStorage.CmdrClient.Shared.Dispatcher
    -> ReplicatedStorage.CmdrClient.CmdrInterface
    -> ReplicatedStorage.CmdrClient.DefaultEventHandlers

[ModuleScript] ReplicatedStorage.CmdrClient.CmdrInterface
    -> ReplicatedStorage.CmdrClient.CmdrInterface.Window
    -> ReplicatedStorage.CmdrClient.CmdrInterface.AutoComplete

[ModuleScript] ReplicatedStorage.CmdrClient.DefaultEventHandlers
    -> ReplicatedStorage.CmdrClient.CmdrInterface.Window

[ModuleScript] ReplicatedStorage.CmdrClient.Shared.Argument
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Shared.Command
    -> ReplicatedStorage.CmdrClient.Shared.Argument

[ModuleScript] ReplicatedStorage.CmdrClient.Shared.Dispatcher
    -> ReplicatedStorage.CmdrClient.Shared.Util
    -> ReplicatedStorage.CmdrClient.Shared.Command

[ModuleScript] ReplicatedStorage.CmdrClient.Shared.Registry
    -> ReplicatedStorage.CmdrClient.Shared.Util
    -> [NO RESUELTO] v
    -> [NO RESUELTO] p2
    -> [NO RESUELTO] p3

[ModuleScript] ReplicatedStorage.CmdrClient.Types.AfterRun
    -> [NO RESUELTO] game:GetService("ServerScriptService").UserGenerated.Analytics

[ModuleScript] ReplicatedStorage.CmdrClient.Types.BeforeRun
    -> ReplicatedStorage.SharedModules.DevAllowedIDs
    -> [NO RESUELTO] game:GetService("ServerScriptService").UserGenerated.Analytics

[ModuleScript] ReplicatedStorage.CmdrClient.Types.BrickColor
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.CardName
    -> ReplicatedStorage.CmdrClient.Shared.Util
    -> [NO RESUELTO] Card_Inventory_MODULE:FindFirstChild("CardData")

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Color3
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Command
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.CosmeticName
    -> ReplicatedStorage.SharedModules.PropData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.CrateName
    -> ReplicatedStorage.SharedModules.CrateData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.CrowbarName
    -> ReplicatedStorage.SharedModules.CrowbarData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Currency
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Duration
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.EggName
    -> ReplicatedStorage.SharedModules.EggData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.FreezerayName
    -> ReplicatedStorage.SharedModules.FreezeRayData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.FruitName
    -> ReplicatedStorage.SharedModules.SeedData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.GnomeName
    -> ReplicatedStorage.SharedModules.GnomeData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.GuildCrateName
    -> ReplicatedStorage.SharedModules.GuildCrateData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.LadderName
    -> ReplicatedStorage.SharedModules.LadderData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.MoonType
    -> ReplicatedStorage.SharedModules.TimeCycleData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.MushroomName
    -> ReplicatedStorage.SharedModules.MushroomData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.PackName
    -> ReplicatedStorage.CmdrClient.Shared.Util
    -> [NO RESUELTO] Pack_MODULE:FindFirstChild("PackData")

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Phases
    -> ReplicatedStorage.SharedModules.TimeCycleData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.PlaceType
    -> ReplicatedStorage.SharedModules.Environment

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Player
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.PlayerId
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.PowerhoseName
    -> ReplicatedStorage.SharedModules.PowerHoseData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Primitives
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.RaccoonName
    -> ReplicatedStorage.SharedModules.RaccoonData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.RakeName
    -> ReplicatedStorage.SharedModules.RakeData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.SeedName
    -> ReplicatedStorage.SharedModules.SeedData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.SeedPackName
    -> ReplicatedStorage.SharedModules.SeedPackData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.SprinklerName
    -> ReplicatedStorage.SharedModules.SprinklerData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.StoredKey
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Team
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.TeleporterName
    -> ReplicatedStorage.SharedModules.TeleporterData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.TrowelName
    -> ReplicatedStorage.SharedModules.TrowelData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Type
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.URL
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.UserInput
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Vector
    -> ReplicatedStorage.CmdrClient.Shared.Util

[ModuleScript] ReplicatedStorage.CmdrClient.Types.WateringCanName
    -> ReplicatedStorage.SharedModules.WateringcanData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.Weather
    -> ReplicatedStorage.SharedModules.WeatherData

[ModuleScript] ReplicatedStorage.CmdrClient.Types.WheelbarrowName
    -> ReplicatedStorage.SharedModules.WheelbarrowData

[ModuleScript] ReplicatedStorage.PlantGenerationModules.Plants.Venus Fly Trap
    -> StarterPlayer.StarterPlayerScripts.Controllers.InverseKinematicsController

[ModuleScript] ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedData.PetSizes
    -> ReplicatedStorage.SharedData.PetTypes

[ModuleScript] ReplicatedStorage.SharedModules.AnimatedGradient
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags

[ModuleScript] ReplicatedStorage.SharedModules.BenchmarkPackets
    -> ReplicatedStorage.SharedModules.Packet

[ModuleScript] ReplicatedStorage.SharedModules.CalculateStealDuration
    -> ReplicatedStorage.SharedModules.SellValueData
    -> ReplicatedStorage.SharedModules.MutationData

[ModuleScript] ReplicatedStorage.SharedModules.CrateData
    -> ReplicatedStorage.SharedModules

[ModuleScript] ReplicatedStorage.SharedModules.DevProducts
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] ReplicatedStorage.SharedModules.EggData
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts
    -> ReplicatedStorage.SharedData.PetData

[ModuleScript] ReplicatedStorage.SharedModules.ExclusiveShopData
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GearShopData")
    -> ReplicatedStorage.SharedModules.SeedPackData

[ModuleScript] ReplicatedStorage.SharedModules.Flags.AntiAfkFlags
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.Flags.CrateShopFlags
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.Flags.GardenFlags
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.Flags.GearShopFlags
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.Flags.MailboxFlags
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.Flags.PerfFlags
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.Flags.SeedShopFlags
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.FruitProxyUtil
    -> ReplicatedStorage.SharedModules.WeightFormat
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] ReplicatedStorage.SharedModules.FruitValueCalc
    -> ReplicatedStorage.SharedModules.SellValueData
    -> ReplicatedStorage.SharedModules.MutationData
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.SharedModules.GetGenerationPerMinute
    -> StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.SellValueData

[ModuleScript] ReplicatedStorage.SharedModules.Guild.Asserts
    -> ReplicatedStorage.UserGenerated.Lang.Asserts
    -> ReplicatedStorage.SharedModules.Guild.Types
    -> ReplicatedStorage.SharedModules.Guild.IconPool

[ModuleScript] ReplicatedStorage.SharedModules.GuildCompetition
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> ReplicatedStorage.SharedModules.WeightFormat

[ModuleScript] ReplicatedStorage.SharedModules.GuildCrateData
    -> [NO RESUELTO] v1

[ModuleScript] ReplicatedStorage.SharedModules.MutationData
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts
    -> ReplicatedStorage.SharedModules.MutationData.Gold
    -> ReplicatedStorage.SharedModules.MutationData.Rainbow
    -> ReplicatedStorage.SharedModules.MutationData.Electric
    -> ReplicatedStorage.SharedModules.MutationData.Frozen
    -> ReplicatedStorage.SharedModules.MutationData.Bloodlit
    -> ReplicatedStorage.SharedModules.MutationData.Chained
    -> ReplicatedStorage.SharedModules.MutationData.Starstruck

[ModuleScript] ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] "./Packet"

[ModuleScript] ReplicatedStorage.SharedModules.Packet
    -> ReplicatedStorage.SharedModules.Packet.Signal
    -> ReplicatedStorage.SharedModules.Packet.Task
    -> ReplicatedStorage.SharedModules.Packet.Types

[ModuleScript] ReplicatedStorage.SharedModules.Packet.Signal
    -> ReplicatedStorage.SharedModules.Packet.Task

[ModuleScript] ReplicatedStorage.SharedModules.Packet.Types
    -> ReplicatedStorage.SharedModules.Packet.Types.Characters
    -> ReplicatedStorage.SharedModules.Packet.Types.Enums
    -> ReplicatedStorage.SharedModules.Packet.Types.Static1
    -> ReplicatedStorage.SharedModules.Packet.Types.Static2
    -> ReplicatedStorage.SharedModules.Packet.Types.Static3

[ModuleScript] ReplicatedStorage.SharedModules.PetBehaviors.BlackDragonDefend
    -> ReplicatedStorage.SharedModules.PetBehaviors.BehaviorBase
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedData.PetSizes
    -> [NO RESUELTO] Services:WaitForChild("DragonDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("DragonFireService")
    -> [NO RESUELTO] Services:WaitForChild("DataService")
    -> [NO RESUELTO] Services:WaitForChild("DragonDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("DragonDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("DragonDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("DragonFireService")
    -> [NO RESUELTO] Services:WaitForChild("DataService")
    -> [NO RESUELTO] Services:WaitForChild("DragonFireService")

[ModuleScript] ReplicatedStorage.SharedModules.PetBehaviors.DefendGarden
    -> ReplicatedStorage.SharedModules.PetBehaviors.BehaviorBase
    -> [NO RESUELTO] SharedModules.Networking
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedData.PetSizes
    -> ReplicatedStorage.SharedData.PetData
    -> [NO RESUELTO] Services:WaitForChild("BeeDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("PetBehaviorService")
    -> [NO RESUELTO] Services:WaitForChild("DataService")
    -> [NO RESUELTO] Services:WaitForChild("BeeDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("DataService")
    -> [NO RESUELTO] Services:WaitForChild("BeeDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("BeeDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("PetBehaviorService")
    -> [NO RESUELTO] Services:WaitForChild("BeeDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("BeeDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("DataService")
    -> [NO RESUELTO] Services:WaitForChild("BeeDefenseService")

[ModuleScript] ReplicatedStorage.SharedModules.PetBehaviors.IceSerpentDefend
    -> ReplicatedStorage.SharedModules.PetBehaviors.BehaviorBase
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedData.PetSizes
    -> [NO RESUELTO] Services:WaitForChild("DragonDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("IceSerpentFireService")
    -> [NO RESUELTO] Services:WaitForChild("DataService")
    -> [NO RESUELTO] Services:WaitForChild("DragonDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("DragonDefenseService")
    -> [NO RESUELTO] Services:WaitForChild("IceSerpentFireService")
    -> [NO RESUELTO] Services:WaitForChild("DataService")
    -> [NO RESUELTO] Services:WaitForChild("IceSerpentFireService")

[ModuleScript] ReplicatedStorage.SharedModules.PetBehaviors.Index
    -> ReplicatedStorage.SharedModules.PetBehaviors.StealFruit
    -> ReplicatedStorage.SharedModules.PetBehaviors.DefendGarden
    -> ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    -> ReplicatedStorage.SharedModules.PetBehaviors.BlackDragonDefend
    -> ReplicatedStorage.SharedModules.PetBehaviors.IceSerpentDefend

[ModuleScript] ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    -> ReplicatedStorage.SharedModules.PetBehaviors.BehaviorBase
    -> [NO RESUELTO] Services.DataService
    -> [NO RESUELTO] Services.ObjectPositionService
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedData.PetSizes
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedModules.RarityVisuals
    -> ReplicatedStorage.SharedModules.SeedData
    -> [NO RESUELTO] Services:WaitForChild("MonkeyService")
    -> [NO RESUELTO] Services:WaitForChild("MonkeyService")
    -> [NO RESUELTO] Services:WaitForChild("MonkeyService")
    -> [NO RESUELTO] Services:WaitForChild("MonkeyService")
    -> [NO RESUELTO] Services:WaitForChild("MonkeyService")
    -> [NO RESUELTO] Services:WaitForChild("MonkeyService")
    -> [NO RESUELTO] Services:WaitForChild("MonkeyService")

[ModuleScript] ReplicatedStorage.SharedModules.PetBehaviors.StealFruit
    -> ReplicatedStorage.SharedModules.PetBehaviors.BehaviorBase
    -> [NO RESUELTO] Services.DataService
    -> [NO RESUELTO] Services.ShovelService
    -> [NO RESUELTO] Services.ObjectPositionService
    -> [NO RESUELTO] Services.FruitHarvestService
    -> [NO RESUELTO] Services.GardenZoneService
    -> [NO RESUELTO] Services.BadgesService
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedModules.RarityVisuals
    -> ReplicatedStorage.SharedModules.SeedData
    -> [NO RESUELTO] Services.PetBehaviorService
    -> [NO RESUELTO] Services.PetBehaviorService
    -> [NO RESUELTO] Services.PetBehaviorService

[ModuleScript] ReplicatedStorage.SharedModules.PetBehaviors.TEMPLATE
    -> ReplicatedStorage.SharedModules.PetBehaviors.BehaviorBase

[ModuleScript] ReplicatedStorage.SharedModules.PetModules
    -> ReplicatedStorage.SharedModules.PetModules.Raccoon
    -> ReplicatedStorage.SharedModules.PetModules.Monkey
    -> ReplicatedStorage.SharedModules.PetModules.Robin
    -> ReplicatedStorage.SharedModules.PetModules.Frog
    -> ReplicatedStorage.SharedModules.PetModules.Bunny
    -> ReplicatedStorage.SharedModules.PetModules.Deer
    -> ReplicatedStorage.SharedModules.PetModules.Owl
    -> ReplicatedStorage.SharedModules.PetModules.Bee
    -> ReplicatedStorage.SharedModules.PetModules.Unicorn
    -> ReplicatedStorage.SharedModules.PetModules.GoldenDragonfly
    -> ReplicatedStorage.SharedModules.PetModules.BlackDragon
    -> ReplicatedStorage.SharedModules.PetModules.IceSerpent

[ModuleScript] ReplicatedStorage.SharedModules.SeedPackData
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.SellValueData

[ModuleScript] ReplicatedStorage.SharedModules.Zone
    -> ReplicatedStorage.SharedModules.Zone.Enum
    -> ReplicatedStorage.SharedModules.Zone.Janitor
    -> ReplicatedStorage.SharedModules.Zone.Signal
    -> ReplicatedStorage.SharedModules.Zone.ZonePlusReference
    -> ReplicatedStorage.SharedModules.Zone.ZoneController
    -> [NO RESUELTO] v2.Value
    -> [NO RESUELTO] Tracker
    -> [NO RESUELTO] Tracker
    -> [NO RESUELTO] CollectiveWorldModel
    -> [NO RESUELTO] Tracker
    -> [NO RESUELTO] Tracker
    -> [NO RESUELTO] CollectiveWorldModel

[ModuleScript] ReplicatedStorage.SharedModules.Zone.Enum
    -> [NO RESUELTO] v

[ModuleScript] ReplicatedStorage.SharedModules.Zone.ZoneController
    -> ReplicatedStorage.SharedModules.Zone.Janitor
    -> ReplicatedStorage.SharedModules.Zone.Enum
    -> ReplicatedStorage.SharedModules.Zone.Signal
    -> ReplicatedStorage.SharedModules.Zone.ZoneController.Tracker
    -> ReplicatedStorage.SharedModules.Zone.ZoneController.CollectiveWorldModel

[ModuleScript] ReplicatedStorage.SharedModules.Zone.ZoneController.Tracker
    -> ReplicatedStorage.SharedModules.Zone.Signal
    -> ReplicatedStorage.SharedModules.Zone.Janitor

[ModuleScript] ReplicatedStorage.UserGenerated.ABTests
    -> ReplicatedStorage.UserGenerated.ABTests.SharedABTests
    -> ServerScriptService.UserGenerated.Server.ServerABTests
    -> ReplicatedStorage.UserGenerated.Client.ClientABTests

[Script] ReplicatedStorage.UserGenerated.ABTests.ClientRunner
    -> ReplicatedStorage.UserGenerated.ABTests

[ModuleScript] ReplicatedStorage.UserGenerated.ABTests.SharedABTests
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.Analytics.ClientKit
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[Script] ReplicatedStorage.UserGenerated.Analytics.ClientRunner
    -> ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper
    -> ReplicatedStorage.UserGenerated.Concurrency.ThreadJoin
    -> ReplicatedStorage.UserGenerated.Analytics.ClientKit
    -> ReplicatedStorage.UserGenerated.Strings.UTF8Sub

[ModuleScript] ReplicatedStorage.UserGenerated.Client.ClientABTests
    -> ReplicatedStorage.UserGenerated.ABTests.SharedABTests
    -> ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable

[ModuleScript] ReplicatedStorage.UserGenerated.Client.ClientFastFlags
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable
    -> ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags
    -> ReplicatedStorage.UserGenerated.Lang.Asserts
    -> ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe
    -> ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe
    -> ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe
    -> ReplicatedStorage.UserGenerated.Strings.ObjectPaths

[ModuleScript] ReplicatedStorage.UserGenerated.Collections.DropTable
    -> ReplicatedStorage.UserGenerated.Lang.Asserts
    -> ReplicatedStorage.UserGenerated.Randoms.ISAAC

[ModuleScript] ReplicatedStorage.UserGenerated.Concurrency.Cache
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable
    -> ReplicatedStorage.UserGenerated.Collections.DeepFreeze
    -> ReplicatedStorage.UserGenerated.Concurrency.Lock
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.Concurrency.Lock
    -> ReplicatedStorage.UserGenerated.Lang.Finally

[ModuleScript] ReplicatedStorage.UserGenerated.Concurrency.Observable
    -> ReplicatedStorage.UserGenerated.Collections.DeepEquals
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable

[ModuleScript] ReplicatedStorage.UserGenerated.Concurrency.Render
    -> ReplicatedStorage.UserGenerated.Logging
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags
    -> ReplicatedStorage.UserGenerated.Client.ClientFastFlags
    -> ServerScriptService.UserGenerated.Server.ServerFastFlags

[Script] ReplicatedStorage.UserGenerated.FastFlags.ClientRunner
    -> ReplicatedStorage.UserGenerated.FastFlags

[ModuleScript] ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.AES
    -> ReplicatedStorage.UserGenerated.IO.Crypto.AES.Modes
    -> ReplicatedStorage.UserGenerated.IO.Crypto.AES.Pads

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.HMAC
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.MD5
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.SHA1
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.SHA224
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.SHA256
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.SHA384
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.SHA512
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption
    -> ReplicatedStorage.UserGenerated.IO.Crypto.AES
    -> ReplicatedStorage.UserGenerated.IO.Base64
    -> ReplicatedStorage.UserGenerated.IO.Crypto.HMAC
    -> ReplicatedStorage.UserGenerated.Randoms.ISAAC
    -> ReplicatedStorage.UserGenerated.IO.Crypto.SHA256
    -> ReplicatedStorage.UserGenerated.IO.Crypto.Hash

[ModuleScript] ReplicatedStorage.UserGenerated.IO.HTTP
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.IO.HTTP.URL
    -> ReplicatedStorage.UserGenerated.Lang.Keys
    -> ReplicatedStorage.UserGenerated.Lang.Asserts
    -> ReplicatedStorage.UserGenerated.IO.JSONEncoder

[ModuleScript] ReplicatedStorage.UserGenerated.Lang.Janitor
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable

[ModuleScript] ReplicatedStorage.UserGenerated.Lang.Tests
    -> ReplicatedStorage.UserGenerated.Strings.Stringify
    -> ReplicatedStorage.UserGenerated.Collections.DeepEquals

[ModuleScript] ReplicatedStorage.UserGenerated.Logging
    -> ReplicatedStorage.UserGenerated.Lang.Keys
    -> ReplicatedStorage.UserGenerated.Lang.Asserts
    -> ReplicatedStorage.UserGenerated.Strings.Stringify

[Script] ReplicatedStorage.UserGenerated.Logging.ClientRunner
    -> ReplicatedStorage.UserGenerated.FastFlags
    -> ReplicatedStorage.UserGenerated.Logging

[ModuleScript] ReplicatedStorage.UserGenerated.Lottie
    -> ReplicatedStorage.UserGenerated.Lottie.Types
    -> ReplicatedStorage.UserGenerated.Lottie.Easing

[ModuleScript] ReplicatedStorage.UserGenerated.Lottie.Easing
    -> ReplicatedStorage.UserGenerated.Lottie.Types

[ModuleScript] ReplicatedStorage.UserGenerated.Lottie.PNG
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.Types
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.chunks
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.crc32
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.zlib

[ModuleScript] ReplicatedStorage.UserGenerated.Lottie.PNG.chunks
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.IHDR
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.PLTE
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.tRNS

[ModuleScript] ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.IHDR
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.Types

[ModuleScript] ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.PLTE
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.Types

[ModuleScript] ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.tRNS
    -> ReplicatedStorage.UserGenerated.Lottie.PNG.Types

[ModuleScript] ReplicatedStorage.UserGenerated.Math.RoundFigures
    -> ReplicatedStorage.UserGenerated.Math.StableExp10

[ModuleScript] ReplicatedStorage.UserGenerated.Randoms
    -> ReplicatedStorage.UserGenerated.Randoms.Base
    -> ReplicatedStorage.UserGenerated.Randoms.Xorshift128

[ModuleScript] ReplicatedStorage.UserGenerated.Randoms.ISAAC
    -> ReplicatedStorage.UserGenerated.Randoms.Base
    -> ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed

[ModuleScript] ReplicatedStorage.UserGenerated.Randoms.Xorshift128
    -> ReplicatedStorage.UserGenerated.Randoms.Base
    -> ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed
    -> ReplicatedStorage.UserGenerated.Randoms.Xorshift128.Theory

[ModuleScript] ReplicatedStorage.UserGenerated.Roblox.GroupServiceHelper
    -> ReplicatedStorage.UserGenerated.Concurrency.Cache
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.Roblox.LocalizationServiceHelper
    -> ReplicatedStorage.UserGenerated.Concurrency.Cache
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.Roblox.MarketplaceServiceHelper
    -> ReplicatedStorage.UserGenerated.Concurrency.Cache
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.Roblox.PolicyServiceHelper
    -> ReplicatedStorage.UserGenerated.Concurrency.Cache
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper
    -> ReplicatedStorage.UserGenerated.Concurrency.Cache
    -> ReplicatedStorage.UserGenerated.Lang.Asserts

[ModuleScript] ReplicatedStorage.UserGenerated.Strings.Commas
    -> ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString

[ModuleScript] ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated
    -> ReplicatedStorage.UserGenerated.Math.RoundFigures
    -> ReplicatedStorage.UserGenerated.Math.StableExp10
    -> ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString

[ModuleScript] ReplicatedStorage.UserGenerated.Strings.FormatChance
    -> ReplicatedStorage.UserGenerated.Strings.FormatOdds
    -> ReplicatedStorage.UserGenerated.Strings.FormatPercent

[ModuleScript] ReplicatedStorage.UserGenerated.Strings.FormatFigures
    -> ReplicatedStorage.UserGenerated.Math.RoundFigures
    -> ReplicatedStorage.UserGenerated.Strings.Commas

[ModuleScript] ReplicatedStorage.UserGenerated.Strings.FormatOdds
    -> ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated

[ModuleScript] ReplicatedStorage.UserGenerated.Strings.FormatPercent
    -> ReplicatedStorage.UserGenerated.Strings.FormatFigures

[ModuleScript] ReplicatedStorage.UserGenerated.VFX.Emit
    -> ReplicatedStorage.UserGenerated.VFX.EmitOnce

[ModuleScript] ReplicatedStorage.UserGenerated.VFX.PlayVFX
    -> ReplicatedStorage.UserGenerated.VFX.Emit

[Script] ServerScriptService.GameServer
    -> ServerScriptService.ServerPackages.ProfileStore
    -> ReplicatedStorage.SharedData.ExpansionPrices
    -> ReplicatedStorage.SharedModules.Networking
    -> ServerScriptService.UserGenerated.Server.ServerFastFlags
    -> ServerScriptService.GameServerAPI
    -> ServerScriptService.GameServerAPI

[Script] ServerScriptService.PlantService
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.FruitValueCalc
    -> ServerScriptService.GameServerAPI
    -> [NO RESUELTO] genModule

[Script] ServerScriptService.Script
    -> [NO RESUELTO] script.Parent.Modulo
    -> [NO RESUELTO] game:GetService("ReplicatedStorage").Shared.Net
    -> [NO RESUELTO] RS.Mod
    -> [NO RESUELTO] m
    -> [NO RESUELTO] ...
    -> [NO RESUELTO] [^%w_]
    -> [NO RESUELTO] ...

[ModuleScript] ServerScriptService.ServerPackages.Cmdr
    -> [NO RESUELTO] script.Parent._Index["evaera_cmdr@1.12.0"]["cmdr"]

[ModuleScript] ServerScriptService.ServerPackages.ProfileStore
    -> [NO RESUELTO] script.Parent._Index["lm-loleris_profilestore@1.0.3"]["profilestore"]

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Registry
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Dispatcher
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Initialize

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.BrickColor
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Color3
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Command
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Duration
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Player
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.PlayerId
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Primitives
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.StoredKey
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Team
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Type
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.URL
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.UserInput
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Vector
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient
    -> [NO RESUELTO] Shared:WaitForChild("Util")
    -> [NO RESUELTO] Shared.Registry
    -> [NO RESUELTO] Shared.Dispatcher
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.DefaultEventHandlers

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface.Window
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface.AutoComplete

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.DefaultEventHandlers
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface.Window

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Initialize
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CreateGui

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Argument
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Command
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Argument

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Dispatcher
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Command

[ModuleScript] ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Registry
    -> ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util
    -> [NO RESUELTO] object
    -> [NO RESUELTO] commandScript
    -> [NO RESUELTO] commandServerScript

[ModuleScript] ServerScriptService.ServerPackages._Index.lm-loleris_profilestore@1.0.3.profilestore
    -> [NO RESUELTO] game.ReplicatedStorage.Shared.Util

[Script] ServerScriptService.TimeCycleServer
    -> ReplicatedStorage.SharedModules.TimeCycleData

[ModuleScript] ServerScriptService.UserGenerated.Server.ServerABTests
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable

[ModuleScript] ServerScriptService.UserGenerated.Server.ServerFastFlags
    -> ReplicatedStorage.UserGenerated.Concurrency.Bindable
    -> ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags
    -> ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe
    -> ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe

[Script] ServerScriptService.WeatherService
    -> ReplicatedStorage.SharedModules.WeatherData

[Script] ServerScriptService.WildPetService
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedModules.Networking
    -> ServerScriptService.GameServerAPI

[LocalScript] StarterGui.CrateShop.Frame.Header.ExitButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.CrateShop.Frame.Header.RefreshIn.LocalScript
    -> ReplicatedStorage.SharedModules.Networking

[LocalScript] StarterGui.CrateShop.Frame.Header.RestockButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController

[LocalScript] StarterGui.CrateShop.Frame.ScrollingFrame.GenerateItems
    -> ReplicatedStorage.SharedModules.CrateData
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RestockStoreController
    -> ReplicatedStorage.SharedModules.Flags.CrateShopFlags

[LocalScript] StarterGui.CustomiseFenceTheme.Frame.FenceScrollingFrame.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.NotificationController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.PlayerStateClient
    -> ReplicatedStorage.SharedModules.FenceData
    -> ReplicatedStorage.SharedModules.CrateData

[LocalScript] StarterGui.CustomiseFenceTheme.Frame.GardenStatsContent.Frame.Visiblity
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> StarterPlayer.StarterPlayerScripts.Controllers.SfxController

[LocalScript] StarterGui.CustomiseFenceTheme.Frame.GardenStatsContent.RefundButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> ReplicatedStorage.SharedModules.DevProducts

[LocalScript] StarterGui.GearShop.Frame.Header.ExitButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.GearShop.Frame.Header.RefreshIn.LocalScript
    -> ReplicatedStorage.SharedModules.Networking

[LocalScript] StarterGui.GearShop.Frame.Header.RestockButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController

[LocalScript] StarterGui.GearShop.Frame.ScrollingFrame.GenerateItems
    -> ReplicatedStorage.SharedModules.GearShopData
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RestockStoreController
    -> ReplicatedStorage.ClientModules.PlayerStateClient
    -> ReplicatedStorage.SharedModules.Flags.GearShopFlags

[LocalScript] StarterGui.GrowingList.Frame.Header.GrowAll.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> ReplicatedStorage.SharedModules.DevProducts

[LocalScript] StarterGui.GuildShop.MainFrame.Header.ExitButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.HUD.CurrenciesScript
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("PlayerStateClient")
    -> ReplicatedStorage.SharedModules.NumberUtils

[LocalScript] StarterGui.MushroomUI.Frame.MushroomUIClient
    -> ReplicatedStorage.SharedModules.MushroomData

[LocalScript] StarterGui.Odds.Frame.CrateName.Frame_Update
    -> [NO RESUELTO] v12

[LocalScript] StarterGui.Odds.Frame.Header.ExitButton.Close
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.PlayerSelector.PlayerSelectClient
    -> ReplicatedStorage.SharedModules.Networking

[LocalScript] StarterGui.PremiumSeedShop.Frame.Header.ExitButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.PremiumSeedShop.Frame.ScrollingFrame.GenerateItems
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.DevProducts
    -> [NO RESUELTO] ReplicatedStorage.ClientModules.DevProductsClient
    -> ReplicatedStorage.ClientModules.PlayerStateClient
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.DevProductController

[LocalScript] StarterGui.PropsFrame.Controller2
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.PropData
    -> ReplicatedStorage.ClientModules.PlayerStateClient
    -> ReplicatedStorage.ClientModules.PlacementGrid
    -> ReplicatedStorage.ClientModules.Trove
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.RobuxShop.RobuxShopClient
    -> [NO RESUELTO] Controllers:WaitForChild("DevProductController")
    -> [NO RESUELTO] Controllers:WaitForChild("GuiController")
    -> [NO RESUELTO] Controllers:WaitForChild("SeedInspectController")
    -> [NO RESUELTO] Controllers:WaitForChild("GearInspectController")
    -> [NO RESUELTO] SharedModules:WaitForChild("DevProducts")
    -> [NO RESUELTO] SharedModules:WaitForChild("RobuxShopContent")
    -> [NO RESUELTO] SharedModules:WaitForChild("SeedPackData")
    -> [NO RESUELTO] SharedModules:WaitForChild("SeedData")
    -> [NO RESUELTO] SharedModules:WaitForChild("GearShopData")
    -> [NO RESUELTO] SharedModules:WaitForChild("NumberUtils")
    -> [NO RESUELTO] SharedModules:WaitForChild("Networking")

[LocalScript] StarterGui.SeedShop.Frame.ExclusiveShop.GenerateItems
    -> StarterPlayer.StarterPlayerScripts.Controllers.ExclusiveStoreController

[LocalScript] StarterGui.SeedShop.Frame.Header.ExitButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.SeedShop.Frame.Header.RefreshIn.LocalScript
    -> ReplicatedStorage.SharedModules.Networking

[LocalScript] StarterGui.SeedShop.Frame.Header.RestockButton.LocalScript
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController

[LocalScript] StarterGui.SeedShop.Frame.NormalShop.GenerateItems
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RestockStoreController
    -> ReplicatedStorage.SharedModules.Flags.SeedShopFlags

[LocalScript] StarterGui.Settings.Frame.Content.BGM.Slider.SliderMusic
    -> ReplicatedStorage.SharedModules.Networking

[LocalScript] StarterGui.Settings.Frame.Content.CodesFrame.Codes
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.NotificationController

[LocalScript] StarterGui.Settings.Frame.Content.SFX.Slider.SliderSFX
    -> ReplicatedStorage.SharedModules.Networking

[LocalScript] StarterGui.Settings.Frame.Header.ExitButton.Close
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[LocalScript] StarterGui.TeleportButtons.SideButtons.SideButtonsScript
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GuiController")

[LocalScript] StarterGui.TeleportButtons.TeleportButtons.ButtonHandler
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] Controllers:WaitForChild("PetVisualController")

[LocalScript] StarterGui.TeleportButtons.TimeCycleBar.Scaler
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPack.Bloodmoon
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.Trove

[LocalScript] StarterPlayer.StarterCharacterScripts.Billboard_UI.Billboard_UI.Objects.UIListLayout
    -> ReplicatedStorage.ClientModules.Device

[LocalScript] StarterPlayer.StarterPlayerScripts.ControllerStarter
    -> ReplicatedStorage.SharedModules.Environment

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.AntiAfkController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.Flags.AntiAfkFlags

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.BeeStingController
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] PlayerModule
    -> [NO RESUELTO] CameraInput

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.BenchmarkController
    -> ReplicatedStorage.SharedModules.BenchmarkPackets

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.BirdController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.BirdHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.BirdVisualController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.BlackDragonFireController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.BuildHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.CMDRController
    -> ReplicatedStorage.ClientModules.topbarplus
    -> [NO RESUELTO] CmdrClient

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ClickSFXControlelr
    -> StarterPlayer.StarterPlayerScripts.Controllers.SfxController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ColorPickerGuildController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.CrateController
    -> StarterPlayer.StarterPlayerScripts.Controllers.RollController
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.CrateController.CrateOpenEffect

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.CrateHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.CreateGuildController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.Guild.Asserts
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.ColorPickerGuildController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.CrowbarController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.CrowbarHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.CutsceneController
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] p1.Animations
    -> [NO RESUELTO] p1.Markers
    -> [NO RESUELTO] p1.FoV
    -> [NO RESUELTO] p1.Animations

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    -> ReplicatedStorage.ClientModules.Signal
    -> ReplicatedStorage.ClientModules.MessagePrompt
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.DevProducts
    -> ReplicatedStorage.SharedModules.Environment
    -> ReplicatedStorage.ClientModules.PlayerStateClient

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.DisplayPlantGrowthController
    -> ReplicatedStorage.SharedModules.SeedData
    -> [NO RESUELTO] v4
    -> [NO RESUELTO] v6
    -> ReplicatedStorage.SharedModules.PlantSizeMultipliers

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController
    -> StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController.CCDIKController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RagdollModule

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController.CCDIKController
    -> StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController.CCDIKController.VectorUtil
    -> StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController.CCDIKController.Maid

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.DroppedItemController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.RarityVisuals
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.EditGuildController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.Guild.Asserts
    -> ReplicatedStorage.SharedModules.Guild.IconPool
    -> ReplicatedStorage.UserGenerated.Roblox.MarketplaceServiceHelper
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.ColorPickerGuildController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.EggHandleController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggEffect

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggEffect
    -> ReplicatedStorage.ClientModules.Bezier
    -> StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggHatchAnim
    -> StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggScreenShake
    -> ReplicatedStorage.SharedModules.PetModules
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedData.PetSizes
    -> ReplicatedStorage.SharedModules.AnimatedGradient

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggHatchAnim
    -> ReplicatedStorage.ClientModules.SpiralTrail

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggScreenShake
    -> ReplicatedStorage.ClientModules.CamShake

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.EmptyPotController
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    -> ReplicatedStorage.SharedModules.SeedData
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ExclusiveStoreController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> [NO RESUELTO] Players.LocalPlayer.PlayerScripts.Controllers.DevProductController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ExtraEggHatchController
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.BlockSmashController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.FlashbangVFXController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.FreezeRayController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.WeightFormat
    -> ReplicatedStorage.SharedModules.GrowEffects
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags
    -> ReplicatedStorage.SharedModules.Environment
    -> ReplicatedStorage.SharedModules.SellValueData
    -> ReplicatedStorage.SharedModules.MutationData
    -> ReplicatedStorage.SharedModules.CalculateStealDuration
    -> ReplicatedStorage.SharedModules.CalculateOvertimeGrowth
    -> [NO RESUELTO] v2
    -> [NO RESUELTO] v4

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController
    -> ReplicatedStorage.ClientModules.Trove
    -> StarterPlayer.StarterPlayerScripts.Controllers.GuiController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController.SceneApi
    -> StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.RobuxShopContent
    -> ReplicatedStorage.SharedModules.DevProducts
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> ReplicatedStorage.SharedModules.GearShopData
    -> [NO RESUELTO] v2.Module
    -> [NO RESUELTO] v4.Module

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController.GearScenes.Vine Wrapper Old.Scene
    -> ReplicatedStorage.ClientModules.CatmullRomSpline
    -> ReplicatedStorage.ClientModules.CCDIKController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController.GearScenes.Vine Wrapper.Scene
    -> ReplicatedStorage.ClientModules.CatmullRomSpline
    -> ReplicatedStorage.ClientModules.CCDIKController
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.VineWrapperController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GhostPepperController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.Signal

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GiftingController
    -> [NO RESUELTO] "@game/ReplicatedStorage/SharedModules/Networking"

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GnomeController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GnomeHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GreenbeanAvatarController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedData.GreenbeanAvatarItems
    -> ReplicatedStorage.SharedData.GreenbeanCheck

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GrowingListController
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> ReplicatedStorage.SharedModules.GrowRateData
    -> StarterPlayer.StarterPlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GardenSyncController")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GuiController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> ReplicatedStorage.ClientModules.Signal
    -> [NO RESUELTO] v2
    -> [NO RESUELTO] v2

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GuiController.Components.Click
    -> ReplicatedStorage.ClientModules.Signal
    -> ReplicatedStorage.ClientModules.Trove

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GuildChatTagController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GuildChatTagController.GuildChatTag

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GuildInviteController
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GuildShopController
    -> ReplicatedStorage.SharedModules.SeedPackData
    -> ReplicatedStorage.SharedModules.GearShopData
    -> ReplicatedStorage.SharedModules.EggData
    -> ReplicatedStorage.SharedModules.SeedData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.GuildWeekCompleteController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.HarvestPromptController
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.HarvestPromptLabelController
    -> [NO RESUELTO] SharedModules:WaitForChild("SeedData")
    -> [NO RESUELTO] SharedModules:WaitForChild("RarityVisuals")
    -> [NO RESUELTO] SharedModules:WaitForChild("MutationData")
    -> [NO RESUELTO] SharedModules:WaitForChild("WeightFormat")
    -> StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.HarvestedFruitHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener
    -> ReplicatedStorage.SharedModules.Environment
    -> StarterPlayer.StarterPlayerScripts.Controllers.MutationController
    -> [NO RESUELTO] v2
    -> [NO RESUELTO] v4

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.IceSerpentFireController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    -> ReplicatedStorage.SharedModules.MushroomData
    -> ReplicatedStorage.SharedModules.GnomeData
    -> ReplicatedStorage.SharedModules.RaccoonData
    -> ReplicatedStorage.SharedModules.CrateData
    -> ReplicatedStorage.SharedModules.SeedPackData
    -> ReplicatedStorage.SharedModules.EggData
    -> ReplicatedStorage.SharedModules.TeleporterData
    -> ReplicatedStorage.SharedModules.PowerHoseData
    -> ReplicatedStorage.SharedModules.MutationData
    -> ReplicatedStorage.SharedModules.WeightFormat
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.FruitProxyUtil
    -> ReplicatedStorage.SharedModules.AnimatedGradient
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Utility
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.GameTranslator
    -> [NO RESUELTO] game:GetService("ReplicatedStorage").ClientModules.topbarplus
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.SprinklerData
    -> ReplicatedStorage.SharedModules.RakeData
    -> ReplicatedStorage.SharedModules.WateringcanData
    -> ReplicatedStorage.SharedModules.ShovelData
    -> ReplicatedStorage.SharedModules.TrowelData
    -> ReplicatedStorage.SharedModules.BuildData
    -> ReplicatedStorage.SharedModules.CrowbarData
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GuiController")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Reference
    -> [NO RESUELTO] v3
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Packages.GoodSignal
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Packages.Janitor
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Attribute
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Themes
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Gamepad
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Overflow
    -> [NO RESUELTO] Themes2.Default
    -> [NO RESUELTO] Elements.Container
    -> [NO RESUELTO] Themes2.Classic
    -> [NO RESUELTO] Elements.Widget
    -> [NO RESUELTO] Elements.Notice
    -> [NO RESUELTO] Elements.Caption
    -> [NO RESUELTO] Elements.Dropdown
    -> [NO RESUELTO] Elements.Indicator

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Elements.Caption
    -> [NO RESUELTO] p1.iconModule

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Elements.Dropdown
    -> [NO RESUELTO] p1.iconModule
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Elements.Menu
    -> [NO RESUELTO] p1.iconModule
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Themes

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Elements.Notice
    -> [NO RESUELTO] Packages.Janitor
    -> [NO RESUELTO] Packages.GoodSignal
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Elements.Widget
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Elements.Menu
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Gamepad
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Gamepad
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Elements.Selection

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Overflow
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Themes
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Features.Themes.Default
    -> [NO RESUELTO] p2

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Packages.Janitor
    -> [NO RESUELTO] game:GetService("ReplicatedStorage").Framework
    -> [NO RESUELTO] game:GetService("ReplicatedStorage").Framework
    -> [NO RESUELTO] game:GetService("ReplicatedStorage").Framework

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Utility
    -> StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Icon.Packages.Janitor
    -> [NO RESUELTO] p1.iconModule
    -> [NO RESUELTO] p1.iconModule

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main.Utility
    -> [NO RESUELTO] PlayerGui.RobloxGui.Modules.VR.Panel3D
    -> [NO RESUELTO] PlayerGui.RobloxGui.Modules.VR.Panel3D
    -> [NO RESUELTO] PlayerGui.RobloxGui.Modules.VR.Panel3D
    -> [NO RESUELTO] PlayerGui.RobloxGui.Modules.VR.Panel3D
    -> [NO RESUELTO] PlayerGui.RobloxGui.Modules.VR.Panel3D

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.KingController
    -> ReplicatedStorage.SharedModules.SeedData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.LadderController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.LeaveGuildController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.MessagePrompt
    -> [NO RESUELTO] Players.LocalPlayer.PlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MailboxController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.PlayerStateClient
    -> ReplicatedStorage.SharedModules.AnimatedGradient
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedModules.Flags.MailboxFlags
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.MailboxController.MailboxItemCatalog

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MoonBloomController
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.RadialFXController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MushroomController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MushroomHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MusicController
    -> [NO RESUELTO] SharedModules:WaitForChild("WeatherData")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController
    -> [NO RESUELTO] v
    -> [NO RESUELTO] v1

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Bloodlit
    -> ReplicatedStorage.SharedModules.GrowEffects
    -> ReplicatedStorage.SharedModules.EffectLoadManager
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Chained
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Electric
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Frozen
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Gold
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Rainbow
    -> ReplicatedStorage.SharedModules.GrowEffects
    -> ReplicatedStorage.SharedModules.EffectLoadManager
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Secret
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Starstruck
    -> ReplicatedStorage.SharedModules.EffectLoadManager

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.NPCController
    -> [NO RESUELTO] v2

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Gilbert
    -> ReplicatedStorage.ClientModules.TopText
    -> ReplicatedStorage.ClientModules.NPC
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.ViewGuildProgressController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Sell_Steven
    -> [NO RESUELTO] "../NPCDialogueController"
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("TopText")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("SellValueData")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("FruitValueCalc")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("MutationData")
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("BidOddModule")
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> StarterPlayer.StarterPlayerScripts.Controllers.HarvestedFruitHandleController
    -> StarterPlayer.StarterPlayerScripts.Controllers.RadialFXController
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.PlantLifecycleHandler
    -> [NO RESUELTO] game:GetService("ReplicatedStorage").UserGenerated.ABTests
    -> ReplicatedStorage.SharedData.PetData
    -> StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.NPCDialogueController
    -> ReplicatedStorage.ClientModules.TopText
    -> ReplicatedStorage.ClientModules.NPC

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> ReplicatedStorage.ClientModules.Chalk
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController.NotificationCondenser
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.DevProductController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.NotificationController.NotificationCondenser
    -> ReplicatedStorage.ClientModules.Chalk

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.OfflineGrowthAnimationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController
    -> ReplicatedStorage.SharedModules.GrowEffects

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PartColorChangeController
    -> [NO RESUELTO] v2

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetEquipController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.PlayerStateClient

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetHandleController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.BackpackListener
    -> ReplicatedStorage.SharedModules.PetModules
    -> ReplicatedStorage.SharedData.PetSizes
    -> ReplicatedStorage.SharedData.PetTypes

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetHoverTooltipController
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedModules.RarityVisuals
    -> ReplicatedStorage.SharedModules.AnimatedGradient
    -> StarterPlayer.StarterPlayerScripts.Controllers.PetListController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetListController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedData.PetSlotPrices
    -> ReplicatedStorage.SharedModules.AnimatedGradient
    -> [NO RESUELTO] LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Controllers"):WaitForChild("GuiController")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetModuleINIT
    -> [NO RESUELTO] v

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetRainbowController
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController
    -> ReplicatedStorage.SharedModules.PetModules
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedData.PetSizes
    -> ReplicatedStorage.SharedData.PetTypes

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController.ClientPetControllers.Raccoon
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.SeedData
    -> StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PlantController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PlantHoverTooltipController
    -> [NO RESUELTO] SharedModules:WaitForChild("SeedData")
    -> [NO RESUELTO] SharedModules:WaitForChild("RarityVisuals")
    -> [NO RESUELTO] SharedModules:WaitForChild("MutationData")
    -> [NO RESUELTO] SharedModules:WaitForChild("WeightFormat")
    -> ReplicatedStorage.ClientModules.ScreenResolution
    -> StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PlantLifecycleHandler
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.SeedData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> StarterPlayer.StarterPlayerScripts.Controllers.OfflineGrowthAnimationController
    -> ReplicatedStorage.SharedModules.SeedData
    -> StarterPlayer.StarterPlayerScripts.Controllers.PlantLifecycleHandler
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.SellValueData
    -> ReplicatedStorage.SharedModules.GrowRateData
    -> ReplicatedStorage.SharedModules.GrowEffects
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags
    -> ReplicatedStorage.SharedModules.CalculateStealDuration
    -> [NO RESUELTO] v2
    -> StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PlayerStateController
    -> ReplicatedStorage.ClientModules.PlayerStateClient

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PlotsController
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> ReplicatedStorage.SharedData.ExpansionPrices
    -> ReplicatedStorage.SharedModules.Flags.GardenFlags
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("PlayerStateClient")
    -> StarterPlayer.StarterPlayerScripts.Controllers.FlashbangVFXController
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] "./SfxController"
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> ReplicatedStorage.SharedModules.Environment

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PoisonIvyController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.Signal
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PotPlacementController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.PlacementGrid
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] v9
    -> [NO RESUELTO] v27

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PottedPlantHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener
    -> [NO RESUELTO] v2
    -> [NO RESUELTO] v4

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PowerHoseController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> ReplicatedStorage.ClientModules.PlacementGrid
    -> StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.FakeSeat
    -> [NO RESUELTO] v17

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Big Sign
    -> [NO RESUELTO] "./__Sign"

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Big Teleport Pad
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> ReplicatedStorage.SharedModules.Zone

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Common Bear Trap
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RagdollModule

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Dark Oak Owner Door
    -> ReplicatedStorage.ClientModules.Trove

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.FakeSeat
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Bear Trap
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RagdollModule

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Owner Door
    -> ReplicatedStorage.ClientModules.Trove

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Seesaw
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Sign
    -> [NO RESUELTO] "./__Sign"

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Huge Teleport Pad
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> ReplicatedStorage.SharedModules.Zone

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Mythic Spring
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Oak Owner Door
    -> ReplicatedStorage.ClientModules.Trove

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Bear Trap
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RagdollModule

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Owner Door
    -> ReplicatedStorage.ClientModules.Trove

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Seesaw
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Sign
    -> [NO RESUELTO] "./__Sign"

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rare Spring
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rope Lights
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Sign
    -> [NO RESUELTO] "./__Sign"

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Small Hanging Rope Light
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Star Lights
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt")

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Super Spring
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Teleport Pad
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> ReplicatedStorage.SharedModules.Zone

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Uncommon Spring
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Weather Machine
    -> ReplicatedStorage.SharedModules.Zone
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Wood Seesaw
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.__Sign
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking")
    -> [NO RESUELTO] game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt")
    -> [NO RESUELTO] "../GuiController"
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.RaccoonHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.RadialFXController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.RainbowMagicCarpetController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.RakeController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.RakeData
    -> ReplicatedStorage.ClientModules.PlacementGrid

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.RakeVisualizerController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> ReplicatedStorage.SharedModules.RakeData
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.RollController
    -> ReplicatedStorage.SharedModules.PropData
    -> ReplicatedStorage.SharedModules.FenceData
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SeedHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SeedInspectController
    -> ReplicatedStorage.ClientModules.Trove
    -> StarterPlayer.StarterPlayerScripts.Controllers.DisplayPlantGrowthController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GuiController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SeedPackHandleController
    -> StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.SeedPackData
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.SeedPackData
    -> ReplicatedStorage.SharedModules.SeedData
    -> StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController.SeedPackEffect

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController.SeedPackEffect
    -> ReplicatedStorage.ClientModules.Bezier
    -> ReplicatedStorage.ClientModules.Spring2
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.CamShake

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SeedToolTipController
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.SellValueData
    -> ReplicatedStorage.SharedModules.NumberUtils
    -> ReplicatedStorage.SharedModules.WeatherData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SfxController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ShecklePopController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ShovelController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.Environment
    -> ReplicatedStorage.ClientModules.MessagePrompt
    -> ReplicatedStorage.ClientModules.PlayerStateClient

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ShovelHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SignToolController
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] "./GuiController"
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SkillPointEffectController
    -> ReplicatedStorage.ClientModules.Effects.LevelUpEffect
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SpawnSeedPackController
    -> ReplicatedStorage.SharedModules.Networking
    -> [NO RESUELTO] Players.LocalPlayer.PlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SprinklerController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.SprinklerData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SprinklerHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.SprinklerVisualizerController
    -> StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    -> ReplicatedStorage.SharedModules.SprinklerData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.StealController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.Environment
    -> ReplicatedStorage.SharedModules.SellValueData
    -> ReplicatedStorage.SharedModules.FruitValueCalc
    -> ReplicatedStorage.SharedModules.MutationData
    -> ReplicatedStorage.SharedModules.SeedData
    -> StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    -> ReplicatedStorage.ClientModules.Effects.ChunkDebris
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] v2
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] v2

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.StealReturnArrowController
    -> StarterPlayer.StarterPlayerScripts.Controllers.TutorialController.TutorialUtils

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TeleporterController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.TeleporterData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TeleporterHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleBarController
    -> ReplicatedStorage.SharedModules.TimeCycleData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController
    -> ReplicatedStorage.SharedModules.TimeCycleData
    -> ReplicatedStorage.ClientModules.Skybox
    -> StarterPlayer.StarterPlayerScripts.Controllers.MusicController
    -> [NO RESUELTO] v12

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Bloodmoon
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.CamShake
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController
    -> StarterPlayer.StarterPlayerScripts.Controllers.MusicController
    -> ReplicatedStorage.ClientModules.Reticule
    -> ReplicatedStorage.ClientModules.Skybox
    -> ReplicatedStorage.ClientModules.ButtonMash
    -> ReplicatedStorage.ClientModules.RagdollModule
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Day
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController
    -> ReplicatedStorage.SharedModules.TimeCycleData

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Goldmoon
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController
    -> ReplicatedStorage.ClientModules.Skybox

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Moon
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.CamShake
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController
    -> StarterPlayer.StarterPlayerScripts.Controllers.MusicController
    -> ReplicatedStorage.ClientModules.Reticule
    -> ReplicatedStorage.ClientModules.Skybox
    -> StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon.PizzaGuy
    -> ReplicatedStorage.ClientModules.ButtonMash
    -> ReplicatedStorage.ClientModules.RagdollModule
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.Bezier

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon.PizzaGuy
    -> ReplicatedStorage.ClientModules.Spring2

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Rainbow Moon
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.CamShake
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController
    -> ReplicatedStorage.ClientModules.Skybox

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Sunset
    -> StarterPlayer.StarterPlayerScripts.Controllers.LightingController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TrowelController
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TrowelHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TutorialController
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.TutorialController.TutorialRunner

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TutorialController.TutorialRunner
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.TutorialController.TutorialUtils
    -> [NO RESUELTO] PlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.TutorialController.TutorialUtils
    -> ReplicatedStorage.SharedModules.FruitProxyUtil

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.VenusFlyTrapController
    -> StarterPlayer.StarterPlayerScripts.Controllers.VenusFlyTrapController.CCDIKController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.RagdollModule

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.VenusFlyTrapController.CCDIKController
    -> StarterPlayer.StarterPlayerScripts.Controllers.VenusFlyTrapController.CCDIKController.VectorUtil
    -> StarterPlayer.StarterPlayerScripts.Controllers.VenusFlyTrapController.CCDIKController.Maid

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.GuildCompetition
    -> ReplicatedStorage.SharedModules.Guild.Asserts
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.DevProductController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.LeaveGuildController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.ViewGuildProgressController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildLeaderboardController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.GuildCompetition
    -> ReplicatedStorage.SharedModules.Guild.Asserts
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.ViewGuildController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.ViewGuildProgressController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildProgressController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedData.PetData
    -> ReplicatedStorage.SharedData.PetSizes
    -> ReplicatedStorage.SharedData.PetTypes
    -> ReplicatedStorage.SharedModules.AnimatedGradient
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.GuiController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.MailboxController.MailboxItemCatalog

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.VineWrapperController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.ClientModules.CatmullRomSpline
    -> ReplicatedStorage.ClientModules.CCDIKController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WaterRevivePromptController
    -> ReplicatedStorage.SharedModules.SeedData
    -> ReplicatedStorage.SharedModules.GearShopData
    -> ReplicatedStorage.ClientModules.PlayerStateClient
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.PlantLifecycleHandler

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WateringcanController
    -> ReplicatedStorage.SharedModules.WateringcanData
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WateringcanHandleController
    -> ReplicatedStorage.ClientModules.BackpackListener

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WeatherController
    -> ReplicatedStorage.SharedModules.WeatherData
    -> [NO RESUELTO] v1

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Lightning
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Rainbow
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> ReplicatedStorage.SharedModules.Networking
    -> ReplicatedStorage.SharedModules.EffectLoadManager

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Snowfall
    -> ReplicatedStorage.SharedModules.Networking
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Starfall
    -> StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    -> ReplicatedStorage.ClientModules.Skybox
    -> ReplicatedStorage.SharedModules.Networking

[ModuleScript] StarterPlayer.StarterPlayerScripts.Controllers.WheelbarrowController
    -> [NO RESUELTO] LocalPlayer.PlayerScripts.Controllers.NotificationController

[LocalScript] StarterPlayer.StarterPlayerScripts.InfiniteGradient
    -> ReplicatedStorage.SharedModules.Flags.PerfFlags

[LocalScript] StarterPlayer.StarterPlayerScripts.LimitedShop
    -> ReplicatedStorage.ClientModules.Trove
    -> [NO RESUELTO] Controllers:WaitForChild("SeedInspectController")
    -> ReplicatedStorage.SharedModules.SeedPackData

[LocalScript] StarterPlayer.StarterPlayerScripts._DiagClient
    -> ReplicatedStorage.ClientModules.PlayerStateClient

[Script] Workspace.NPCS.Charlotte.HumanoidRootPart.ProximityPrompt.Script
    -> ReplicatedStorage.ClientModules.TopText
    -> ReplicatedStorage.ClientModules.NPC
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController
    -> ReplicatedStorage.SharedModules.Flags.CrateShopFlags

[Script] Workspace.NPCS.Model.George.HumanoidRootPart.ProximityPrompt.Script
    -> ReplicatedStorage.ClientModules.TopText
    -> ReplicatedStorage.ClientModules.NPC
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[Script] Workspace.NPCS.Sam.HumanoidRootPart.ProximityPrompt.Script
    -> ReplicatedStorage.ClientModules.TopText
    -> ReplicatedStorage.ClientModules.NPC
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController

[Script] Workspace.NPCS.Steven.HumanoidRootPart.ProximityPrompt.Script
    -> ReplicatedStorage.ClientModules.TopText
    -> ReplicatedStorage.ClientModules.NPC
    -> [NO RESUELTO] game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController


## REVERSE  (module  <-  requerido por)

ReplicatedStorage.ClientModules.BackpackListener   (18)
    <- StarterPlayer.StarterPlayerScripts.Controllers.BirdHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.BuildHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.CrateHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.CrowbarHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GnomeHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.HarvestedFruitHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.MushroomHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PottedPlantHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.RaccoonHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ShovelHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SprinklerHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TeleporterHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TrowelHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.WateringcanHandleController

ReplicatedStorage.ClientModules.Bezier   (3)
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController.SeedPackEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon

ReplicatedStorage.ClientModules.Blur   (1)
    <- ReplicatedFirst.LoadingScreenController

ReplicatedStorage.ClientModules.BodyShaker   (3)
    <- ReplicatedStorage.Assets.Cutscenes.GAGTrailer.Markers
    <- ReplicatedStorage.Assets.Cutscenes.GAGTrailerNoWalls.Markers
    <- ReplicatedStorage.Assets.Cutscenes.GAGTrailerShortVers.Markers

ReplicatedStorage.ClientModules.ButtonMash   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon

ReplicatedStorage.ClientModules.CCDIKController   (3)
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController.GearScenes.Vine Wrapper Old.Scene
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController.GearScenes.Vine Wrapper.Scene
    <- StarterPlayer.StarterPlayerScripts.Controllers.VineWrapperController

ReplicatedStorage.ClientModules.CCDIKController.Maid   (1)
    <- ReplicatedStorage.ClientModules.CCDIKController

ReplicatedStorage.ClientModules.CCDIKController.VectorUtil   (1)
    <- ReplicatedStorage.ClientModules.CCDIKController

ReplicatedStorage.ClientModules.CamShake   (8)
    <- ReplicatedStorage.Assets.Cutscenes.GAGTrailer.Markers
    <- ReplicatedStorage.Assets.Cutscenes.GAGTrailerNoWalls.Markers
    <- ReplicatedStorage.Assets.Cutscenes.GAGTrailerShortVers.Markers
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggScreenShake
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController.SeedPackEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Rainbow Moon

ReplicatedStorage.ClientModules.CamShake.CameraShaker   (1)
    <- ReplicatedStorage.ClientModules.CamShake

ReplicatedStorage.ClientModules.CamShake.CameraShaker.CameraShakeInstance   (2)
    <- ReplicatedStorage.ClientModules.CamShake.CameraShaker
    <- ReplicatedStorage.ClientModules.CamShake.CameraShaker.CameraShakePresets

ReplicatedStorage.ClientModules.CamShake.CameraShaker.CameraShakePresets   (1)
    <- ReplicatedStorage.ClientModules.CamShake.CameraShaker

ReplicatedStorage.ClientModules.CatmullRomSpline   (3)
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController.GearScenes.Vine Wrapper Old.Scene
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController.GearScenes.Vine Wrapper.Scene
    <- StarterPlayer.StarterPlayerScripts.Controllers.VineWrapperController

ReplicatedStorage.ClientModules.Chalk   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    <- StarterPlayer.StarterPlayerScripts.Controllers.NotificationController.NotificationCondenser

ReplicatedStorage.ClientModules.Device   (2)
    <- ReplicatedStorage.Assets.ExtraPreview.Billboard_UI.Billboard_UI.Objects.UIListLayout
    <- StarterPlayer.StarterCharacterScripts.Billboard_UI.Billboard_UI.Objects.UIListLayout

ReplicatedStorage.ClientModules.Effects.ChunkDebris   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.StealController

ReplicatedStorage.ClientModules.Effects.LevelUpEffect   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.SkillPointEffectController

ReplicatedStorage.ClientModules.Iris.API   (1)
    <- ReplicatedStorage.ClientModules.Iris

ReplicatedStorage.ClientModules.Iris.Internal   (1)
    <- ReplicatedStorage.ClientModules.Iris

ReplicatedStorage.ClientModules.Iris.Types   (21)
    <- ReplicatedStorage.ClientModules.Iris
    <- ReplicatedStorage.ClientModules.Iris.API
    <- ReplicatedStorage.ClientModules.Iris.Internal
    <- ReplicatedStorage.ClientModules.Iris.PubTypes
    <- ReplicatedStorage.ClientModules.Iris.demoWindow
    <- ReplicatedStorage.ClientModules.Iris.widgets
    <- ReplicatedStorage.ClientModules.Iris.widgets.Button
    <- ReplicatedStorage.ClientModules.Iris.widgets.Checkbox
    <- ReplicatedStorage.ClientModules.Iris.widgets.Combo
    <- ReplicatedStorage.ClientModules.Iris.widgets.Format
    <- ReplicatedStorage.ClientModules.Iris.widgets.Image
    <- ReplicatedStorage.ClientModules.Iris.widgets.Input
    <- ReplicatedStorage.ClientModules.Iris.widgets.Menu
    <- ReplicatedStorage.ClientModules.Iris.widgets.Plot
    <- ReplicatedStorage.ClientModules.Iris.widgets.RadioButton
    <- ReplicatedStorage.ClientModules.Iris.widgets.Root
    <- ReplicatedStorage.ClientModules.Iris.widgets.Tab
    <- ReplicatedStorage.ClientModules.Iris.widgets.Table
    <- ReplicatedStorage.ClientModules.Iris.widgets.Text
    <- ReplicatedStorage.ClientModules.Iris.widgets.Tree
    <- ReplicatedStorage.ClientModules.Iris.widgets.Window

ReplicatedStorage.ClientModules.Iris.WidgetTypes   (1)
    <- ReplicatedStorage.ClientModules.Iris.Types

ReplicatedStorage.ClientModules.Iris.config   (1)
    <- ReplicatedStorage.ClientModules.Iris

ReplicatedStorage.ClientModules.Iris.demoWindow   (1)
    <- ReplicatedStorage.ClientModules.Iris

ReplicatedStorage.ClientModules.Iris.widgets   (1)
    <- ReplicatedStorage.ClientModules.Iris

ReplicatedStorage.ClientModules.Iris.widgets.Button   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Checkbox   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Combo   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Format   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Image   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Input   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Menu   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Plot   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.RadioButton   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Root   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Tab   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Table   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Text   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Tree   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.Iris.widgets.Window   (1)
    <- ReplicatedStorage.ClientModules.Iris.widgets

ReplicatedStorage.ClientModules.MessagePrompt   (3)
    <- StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    <- StarterPlayer.StarterPlayerScripts.Controllers.LeaveGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ShovelController

ReplicatedStorage.ClientModules.NPC   (6)
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Gilbert
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCDialogueController
    <- Workspace.NPCS.Charlotte.HumanoidRootPart.ProximityPrompt.Script
    <- Workspace.NPCS.Model.George.HumanoidRootPart.ProximityPrompt.Script
    <- Workspace.NPCS.Sam.HumanoidRootPart.ProximityPrompt.Script
    <- Workspace.NPCS.Steven.HumanoidRootPart.ProximityPrompt.Script

ReplicatedStorage.ClientModules.PlacementGrid   (4)
    <- StarterGui.PropsFrame.Controller2
    <- StarterPlayer.StarterPlayerScripts.Controllers.PotPlacementController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.RakeController

ReplicatedStorage.ClientModules.PlayerStateClient   (12)
    <- ReplicatedStorage.ClientModules.RestockStoreController
    <- StarterGui.CustomiseFenceTheme.Frame.FenceScrollingFrame.LocalScript
    <- StarterGui.GearShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.PremiumSeedShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.PropsFrame.Controller2
    <- StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    <- StarterPlayer.StarterPlayerScripts.Controllers.MailboxController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetEquipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlayerStateController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ShovelController
    <- StarterPlayer.StarterPlayerScripts.Controllers.WaterRevivePromptController
    <- StarterPlayer.StarterPlayerScripts._DiagClient

ReplicatedStorage.ClientModules.RagdollModule   (7)
    <- StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Common Bear Trap
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Bear Trap
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Bear Trap
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.VenusFlyTrapController

ReplicatedStorage.ClientModules.ReplicaClient   (1)
    <- ReplicatedStorage.ClientModules.PlayerStateClient

ReplicatedStorage.ClientModules.RestockStoreController   (3)
    <- StarterGui.CrateShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.GearShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.SeedShop.Frame.NormalShop.GenerateItems

ReplicatedStorage.ClientModules.Reticule   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon

ReplicatedStorage.ClientModules.ScreenResolution   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantHoverTooltipController

ReplicatedStorage.ClientModules.Signal   (7)
    <- ReplicatedStorage.ClientModules.Device
    <- ReplicatedStorage.ClientModules.ScreenResolution
    <- StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GhostPepperController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuiController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuiController.Components.Click
    <- StarterPlayer.StarterPlayerScripts.Controllers.PoisonIvyController

ReplicatedStorage.ClientModules.Skybox   (6)
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Goldmoon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Rainbow Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Starfall

ReplicatedStorage.ClientModules.SpiralTrail   (2)
    <- ReplicatedStorage.ClientModules.Effects.LevelUpEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggHatchAnim

ReplicatedStorage.ClientModules.SpiralTrail.CreateTrail   (1)
    <- ReplicatedStorage.ClientModules.SpiralTrail

ReplicatedStorage.ClientModules.Spring2   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController.SeedPackEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon.PizzaGuy

ReplicatedStorage.ClientModules.TopText   (7)
    <- ReplicatedStorage.Assets.NpcUIs.Response_UI.Script
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Gilbert
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCDialogueController
    <- Workspace.NPCS.Charlotte.HumanoidRootPart.ProximityPrompt.Script
    <- Workspace.NPCS.Model.George.HumanoidRootPart.ProximityPrompt.Script
    <- Workspace.NPCS.Sam.HumanoidRootPart.ProximityPrompt.Script
    <- Workspace.NPCS.Steven.HumanoidRootPart.ProximityPrompt.Script

ReplicatedStorage.ClientModules.Trove   (11)
    <- ReplicatedStorage.ClientModules.Trove.init.spec
    <- StarterGui.PropsFrame.Controller2
    <- StarterPack.Bloodmoon
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuiController.Components.Click
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Dark Oak Owner Door
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Owner Door
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Oak Owner Door
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Owner Door
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedInspectController
    <- StarterPlayer.StarterPlayerScripts.LimitedShop

ReplicatedStorage.ClientModules.WatchButtonHold   (1)
    <- ReplicatedStorage.ClientModules.RestockStoreController

ReplicatedStorage.ClientModules.topbarplus   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.CMDRController

ReplicatedStorage.ClientModules.topbarplus.Attribute   (2)
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus

ReplicatedStorage.ClientModules.topbarplus.Elements.Menu   (1)
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Widget

ReplicatedStorage.ClientModules.topbarplus.Elements.Selection   (1)
    <- ReplicatedStorage.ClientModules.topbarplus.Features.Gamepad

ReplicatedStorage.ClientModules.topbarplus.Features.Gamepad   (3)
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Widget

ReplicatedStorage.ClientModules.topbarplus.Features.Overflow   (2)
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus

ReplicatedStorage.ClientModules.topbarplus.Features.Themes   (4)
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Dropdown
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Menu

ReplicatedStorage.ClientModules.topbarplus.Features.Themes.Classic   (1)
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Container

ReplicatedStorage.ClientModules.topbarplus.Features.Themes.Default   (1)
    <- ReplicatedStorage.ClientModules.topbarplus.Features.Themes

ReplicatedStorage.ClientModules.topbarplus.Packages.GoodSignal   (3)
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Container

ReplicatedStorage.ClientModules.topbarplus.Packages.Janitor   (3)
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus.Utility

ReplicatedStorage.ClientModules.topbarplus.Reference   (1)
    <- ReplicatedStorage.ClientModules.topbarplus

ReplicatedStorage.ClientModules.topbarplus.Types   (1)
    <- ReplicatedStorage.ClientModules.topbarplus

ReplicatedStorage.ClientModules.topbarplus.Utility   (6)
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Notice
    <- ReplicatedStorage.ClientModules.topbarplus.Elements.Widget
    <- ReplicatedStorage.ClientModules.topbarplus.Features.Overflow
    <- ReplicatedStorage.ClientModules.topbarplus.Features.Themes

ReplicatedStorage.ClientModules.topbarplus.VERSION   (1)
    <- ReplicatedStorage.ClientModules.topbarplus.Attribute

ReplicatedStorage.CmdrClient.CmdrInterface   (1)
    <- ReplicatedStorage.CmdrClient

ReplicatedStorage.CmdrClient.CmdrInterface.AutoComplete   (1)
    <- ReplicatedStorage.CmdrClient.CmdrInterface

ReplicatedStorage.CmdrClient.CmdrInterface.Window   (2)
    <- ReplicatedStorage.CmdrClient.CmdrInterface
    <- ReplicatedStorage.CmdrClient.DefaultEventHandlers

ReplicatedStorage.CmdrClient.DefaultEventHandlers   (1)
    <- ReplicatedStorage.CmdrClient

ReplicatedStorage.CmdrClient.Shared.Argument   (1)
    <- ReplicatedStorage.CmdrClient.Shared.Command

ReplicatedStorage.CmdrClient.Shared.Command   (1)
    <- ReplicatedStorage.CmdrClient.Shared.Dispatcher

ReplicatedStorage.CmdrClient.Shared.Dispatcher   (1)
    <- ReplicatedStorage.CmdrClient

ReplicatedStorage.CmdrClient.Shared.Registry   (1)
    <- ReplicatedStorage.CmdrClient

ReplicatedStorage.CmdrClient.Shared.Util   (20)
    <- ReplicatedStorage.CmdrClient
    <- ReplicatedStorage.CmdrClient.Shared.Argument
    <- ReplicatedStorage.CmdrClient.Shared.Dispatcher
    <- ReplicatedStorage.CmdrClient.Shared.Registry
    <- ReplicatedStorage.CmdrClient.Types.BrickColor
    <- ReplicatedStorage.CmdrClient.Types.CardName
    <- ReplicatedStorage.CmdrClient.Types.Color3
    <- ReplicatedStorage.CmdrClient.Types.Command
    <- ReplicatedStorage.CmdrClient.Types.Currency
    <- ReplicatedStorage.CmdrClient.Types.Duration
    <- ReplicatedStorage.CmdrClient.Types.PackName
    <- ReplicatedStorage.CmdrClient.Types.Player
    <- ReplicatedStorage.CmdrClient.Types.PlayerId
    <- ReplicatedStorage.CmdrClient.Types.Primitives
    <- ReplicatedStorage.CmdrClient.Types.StoredKey
    <- ReplicatedStorage.CmdrClient.Types.Team
    <- ReplicatedStorage.CmdrClient.Types.Type
    <- ReplicatedStorage.CmdrClient.Types.URL
    <- ReplicatedStorage.CmdrClient.Types.UserInput
    <- ReplicatedStorage.CmdrClient.Types.Vector

ReplicatedStorage.ReplicaShared.Maid   (1)
    <- ReplicatedStorage.ClientModules.ReplicaClient

ReplicatedStorage.ReplicaShared.Remote   (1)
    <- ReplicatedStorage.ClientModules.ReplicaClient

ReplicatedStorage.ReplicaShared.Signal   (1)
    <- ReplicatedStorage.ClientModules.ReplicaClient

ReplicatedStorage.SharedData.ExpansionPrices   (2)
    <- ServerScriptService.GameServer
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlotsController

ReplicatedStorage.SharedData.GreenbeanAvatarItems   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.GreenbeanAvatarController

ReplicatedStorage.SharedData.GreenbeanCheck   (2)
    <- ReplicatedStorage.ClientModules.RestockStoreController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GreenbeanAvatarController

ReplicatedStorage.SharedData.PetData   (11)
    <- ReplicatedStorage.SharedModules.EggData
    <- ReplicatedStorage.SharedModules.PetBehaviors.DefendGarden
    <- ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    <- ReplicatedStorage.SharedModules.PetBehaviors.StealFruit
    <- ServerScriptService.WildPetService
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Sell_Steven
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHoverTooltipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetListController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildProgressController

ReplicatedStorage.SharedData.PetSizes   (9)
    <- ReplicatedStorage.SharedData.PetData
    <- ReplicatedStorage.SharedModules.PetBehaviors.BlackDragonDefend
    <- ReplicatedStorage.SharedModules.PetBehaviors.DefendGarden
    <- ReplicatedStorage.SharedModules.PetBehaviors.IceSerpentDefend
    <- ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildProgressController

ReplicatedStorage.SharedData.PetSlotPrices   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetListController

ReplicatedStorage.SharedData.PetTypes   (11)
    <- ReplicatedStorage.SharedData.PetData
    <- ReplicatedStorage.SharedModules.PetBehaviors.BlackDragonDefend
    <- ReplicatedStorage.SharedModules.PetBehaviors.DefendGarden
    <- ReplicatedStorage.SharedModules.PetBehaviors.IceSerpentDefend
    <- ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    <- StarterPlayer.StarterPlayerScripts.Controllers.MailboxController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHoverTooltipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetListController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildProgressController

ReplicatedStorage.SharedModules   (1)
    <- ReplicatedStorage.SharedModules.CrateData

ReplicatedStorage.SharedModules.AnimatedGradient   (6)
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.MailboxController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHoverTooltipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetListController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildProgressController

ReplicatedStorage.SharedModules.BenchmarkPackets   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.BenchmarkController

ReplicatedStorage.SharedModules.BuildData   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.CalculateOvertimeGrowth   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController

ReplicatedStorage.SharedModules.CalculateStealDuration   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController

ReplicatedStorage.SharedModules.CrateData   (4)
    <- ReplicatedStorage.CmdrClient.Types.CrateName
    <- StarterGui.CrateShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.CustomiseFenceTheme.Frame.FenceScrollingFrame.LocalScript
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.CrowbarData   (2)
    <- ReplicatedStorage.CmdrClient.Types.CrowbarName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.DevAllowedIDs   (1)
    <- ReplicatedStorage.CmdrClient.Types.BeforeRun

ReplicatedStorage.SharedModules.DevProducts   (5)
    <- StarterGui.CustomiseFenceTheme.Frame.GardenStatsContent.RefundButton.LocalScript
    <- StarterGui.GrowingList.Frame.Header.GrowAll.LocalScript
    <- StarterGui.PremiumSeedShop.Frame.ScrollingFrame.GenerateItems
    <- StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController

ReplicatedStorage.SharedModules.EffectLoadManager   (4)
    <- StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Bloodlit
    <- StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Rainbow
    <- StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Starstruck
    <- StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Rainbow

ReplicatedStorage.SharedModules.EggData   (3)
    <- ReplicatedStorage.CmdrClient.Types.EggName
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuildShopController
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.Environment   (8)
    <- ReplicatedStorage.CmdrClient.Types.PlaceType
    <- StarterPlayer.StarterPlayerScripts.ControllerStarter
    <- StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.HarvestedFruitHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlotsController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ShovelController
    <- StarterPlayer.StarterPlayerScripts.Controllers.StealController

ReplicatedStorage.SharedModules.FenceData   (2)
    <- StarterGui.CustomiseFenceTheme.Frame.FenceScrollingFrame.LocalScript
    <- StarterPlayer.StarterPlayerScripts.Controllers.RollController

ReplicatedStorage.SharedModules.Flags.AntiAfkFlags   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.AntiAfkController

ReplicatedStorage.SharedModules.Flags.CrateShopFlags   (2)
    <- StarterGui.CrateShop.Frame.ScrollingFrame.GenerateItems
    <- Workspace.NPCS.Charlotte.HumanoidRootPart.ProximityPrompt.Script

ReplicatedStorage.SharedModules.Flags.GardenFlags   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlotsController

ReplicatedStorage.SharedModules.Flags.GearShopFlags   (1)
    <- StarterGui.GearShop.Frame.ScrollingFrame.GenerateItems

ReplicatedStorage.SharedModules.Flags.MailboxFlags   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.MailboxController

ReplicatedStorage.SharedModules.Flags.PerfFlags   (8)
    <- ReplicatedStorage.SharedModules.AnimatedGradient
    <- StarterPlayer.StarterPlayerScripts.Controllers.DroppedItemController
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Bloodlit
    <- StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Rainbow
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetRainbowController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    <- StarterPlayer.StarterPlayerScripts.InfiniteGradient

ReplicatedStorage.SharedModules.Flags.SeedShopFlags   (1)
    <- StarterGui.SeedShop.Frame.NormalShop.GenerateItems

ReplicatedStorage.SharedModules.FreezeRayData   (1)
    <- ReplicatedStorage.CmdrClient.Types.FreezerayName

ReplicatedStorage.SharedModules.FruitProxyUtil   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.TutorialController.TutorialUtils

ReplicatedStorage.SharedModules.FruitValueCalc   (2)
    <- ServerScriptService.PlantService
    <- StarterPlayer.StarterPlayerScripts.Controllers.StealController

ReplicatedStorage.SharedModules.GearShopData   (4)
    <- StarterGui.GearShop.Frame.ScrollingFrame.GenerateItems
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuildShopController
    <- StarterPlayer.StarterPlayerScripts.Controllers.WaterRevivePromptController

ReplicatedStorage.SharedModules.GnomeData   (2)
    <- ReplicatedStorage.CmdrClient.Types.GnomeName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.GrowEffects   (5)
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Bloodlit
    <- StarterPlayer.StarterPlayerScripts.Controllers.MutationController.Rainbow
    <- StarterPlayer.StarterPlayerScripts.Controllers.OfflineGrowthAnimationController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController

ReplicatedStorage.SharedModules.GrowRateData   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.GrowingListController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController

ReplicatedStorage.SharedModules.Guild.Asserts   (4)
    <- StarterPlayer.StarterPlayerScripts.Controllers.CreateGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.EditGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildLeaderboardController

ReplicatedStorage.SharedModules.Guild.IconPool   (2)
    <- ReplicatedStorage.SharedModules.Guild.Asserts
    <- StarterPlayer.StarterPlayerScripts.Controllers.EditGuildController

ReplicatedStorage.SharedModules.Guild.Types   (1)
    <- ReplicatedStorage.SharedModules.Guild.Asserts

ReplicatedStorage.SharedModules.GuildCompetition   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildLeaderboardController

ReplicatedStorage.SharedModules.GuildCrateData   (1)
    <- ReplicatedStorage.CmdrClient.Types.GuildCrateName

ReplicatedStorage.SharedModules.LadderData   (1)
    <- ReplicatedStorage.CmdrClient.Types.LadderName

ReplicatedStorage.SharedModules.MushroomData   (3)
    <- ReplicatedStorage.CmdrClient.Types.MushroomName
    <- StarterGui.MushroomUI.Frame.MushroomUIClient
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.MutationData   (5)
    <- ReplicatedStorage.SharedModules.CalculateStealDuration
    <- ReplicatedStorage.SharedModules.FruitValueCalc
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.StealController

ReplicatedStorage.SharedModules.MutationData.Bloodlit   (1)
    <- ReplicatedStorage.SharedModules.MutationData

ReplicatedStorage.SharedModules.MutationData.Chained   (1)
    <- ReplicatedStorage.SharedModules.MutationData

ReplicatedStorage.SharedModules.MutationData.Electric   (1)
    <- ReplicatedStorage.SharedModules.MutationData

ReplicatedStorage.SharedModules.MutationData.Frozen   (1)
    <- ReplicatedStorage.SharedModules.MutationData

ReplicatedStorage.SharedModules.MutationData.Gold   (1)
    <- ReplicatedStorage.SharedModules.MutationData

ReplicatedStorage.SharedModules.MutationData.Rainbow   (1)
    <- ReplicatedStorage.SharedModules.MutationData

ReplicatedStorage.SharedModules.MutationData.Starstruck   (1)
    <- ReplicatedStorage.SharedModules.MutationData

ReplicatedStorage.SharedModules.Networking   (122)
    <- ReplicatedStorage.ClientModules.RagdollModule
    <- ReplicatedStorage.ClientModules.RestockStoreController
    <- ReplicatedStorage.ClientModules.Reticule
    <- ReplicatedStorage.SharedModules.DevProducts
    <- ReplicatedStorage.SharedModules.FruitProxyUtil
    <- ServerScriptService.GameServer
    <- ServerScriptService.PlantService
    <- ServerScriptService.WildPetService
    <- StarterGui.CrateShop.Frame.Header.RefreshIn.LocalScript
    <- StarterGui.CrateShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.CustomiseFenceTheme.Frame.FenceScrollingFrame.LocalScript
    <- StarterGui.CustomiseFenceTheme.Frame.GardenStatsContent.Frame.Visiblity
    <- StarterGui.GearShop.Frame.Header.RefreshIn.LocalScript
    <- StarterGui.GearShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.PlayerSelector.PlayerSelectClient
    <- StarterGui.PremiumSeedShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.PropsFrame.Controller2
    <- StarterGui.SeedShop.Frame.Header.RefreshIn.LocalScript
    <- StarterGui.SeedShop.Frame.NormalShop.GenerateItems
    <- StarterGui.Settings.Frame.Content.BGM.Slider.SliderMusic
    <- StarterGui.Settings.Frame.Content.CodesFrame.Codes
    <- StarterGui.Settings.Frame.Content.SFX.Slider.SliderSFX
    <- StarterGui.TeleportButtons.TeleportButtons.ButtonHandler
    <- StarterPack.Bloodmoon
    <- StarterPlayer.StarterPlayerScripts.Controllers.AntiAfkController
    <- StarterPlayer.StarterPlayerScripts.Controllers.BeeStingController
    <- StarterPlayer.StarterPlayerScripts.Controllers.BirdController
    <- StarterPlayer.StarterPlayerScripts.Controllers.BirdVisualController
    <- StarterPlayer.StarterPlayerScripts.Controllers.BlackDragonFireController
    <- StarterPlayer.StarterPlayerScripts.Controllers.CrateController
    <- StarterPlayer.StarterPlayerScripts.Controllers.CreateGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.CrowbarController
    <- StarterPlayer.StarterPlayerScripts.Controllers.CutsceneController
    <- StarterPlayer.StarterPlayerScripts.Controllers.DevProductController
    <- StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController
    <- StarterPlayer.StarterPlayerScripts.Controllers.DroppedItemController
    <- StarterPlayer.StarterPlayerScripts.Controllers.EditGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController
    <- StarterPlayer.StarterPlayerScripts.Controllers.EmptyPotController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ExclusiveStoreController
    <- StarterPlayer.StarterPlayerScripts.Controllers.FlashbangVFXController
    <- StarterPlayer.StarterPlayerScripts.Controllers.FreezeRayController
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GhostPepperController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GnomeController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GreenbeanAvatarController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GrowingListController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuildInviteController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuildWeekCompleteController
    <- StarterPlayer.StarterPlayerScripts.Controllers.HarvestPromptController
    <- StarterPlayer.StarterPlayerScripts.Controllers.IceSerpentFireController
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.LadderController
    <- StarterPlayer.StarterPlayerScripts.Controllers.LeaveGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.MailboxController
    <- StarterPlayer.StarterPlayerScripts.Controllers.MoonBloomController
    <- StarterPlayer.StarterPlayerScripts.Controllers.MushroomController
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Sell_Steven
    <- StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetEquipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetListController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController.ClientPetControllers.Raccoon
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantLifecycleHandler
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PoisonIvyController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PotPlacementController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PowerHoseController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Common Bear Trap
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.FakeSeat
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Bear Trap
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Gold Seesaw
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Mythic Spring
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Bear Trap
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rainbow Seesaw
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Rare Spring
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Super Spring
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Uncommon Spring
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Weather Machine
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Wood Seesaw
    <- StarterPlayer.StarterPlayerScripts.Controllers.RadialFXController
    <- StarterPlayer.StarterPlayerScripts.Controllers.RainbowMagicCarpetController
    <- StarterPlayer.StarterPlayerScripts.Controllers.RakeController
    <- StarterPlayer.StarterPlayerScripts.Controllers.RakeVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController.SeedPackEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.SfxController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ShecklePopController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ShovelController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SignToolController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SkillPointEffectController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SpawnSeedPackController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SprinklerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.StealController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TeleporterController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Bloodmoon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Chained Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Goldmoon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Pizza Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Rainbow Moon
    <- StarterPlayer.StarterPlayerScripts.Controllers.TrowelController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TutorialController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TutorialController.TutorialRunner
    <- StarterPlayer.StarterPlayerScripts.Controllers.VenusFlyTrapController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildLeaderboardController
    <- StarterPlayer.StarterPlayerScripts.Controllers.ViewGuildProgressController
    <- StarterPlayer.StarterPlayerScripts.Controllers.VineWrapperController
    <- StarterPlayer.StarterPlayerScripts.Controllers.WateringcanController
    <- StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Lightning
    <- StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Rainbow
    <- StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Snowfall
    <- StarterPlayer.StarterPlayerScripts.Controllers.WeatherController.Starfall

ReplicatedStorage.SharedModules.NumberUtils   (10)
    <- ReplicatedStorage.ClientModules.RestockStoreController
    <- ReplicatedStorage.SharedModules.GuildCompetition
    <- StarterGui.HUD.CurrenciesScript
    <- StarterGui.PremiumSeedShop.Frame.ScrollingFrame.GenerateItems
    <- StarterPlayer.StarterPlayerScripts.Controllers.ExclusiveStoreController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Sell_Steven
    <- StarterPlayer.StarterPlayerScripts.Controllers.NotificationController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlotsController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedToolTipController

ReplicatedStorage.SharedModules.Packet   (1)
    <- ReplicatedStorage.SharedModules.BenchmarkPackets

ReplicatedStorage.SharedModules.Packet.Signal   (1)
    <- ReplicatedStorage.SharedModules.Packet

ReplicatedStorage.SharedModules.Packet.Task   (2)
    <- ReplicatedStorage.SharedModules.Packet
    <- ReplicatedStorage.SharedModules.Packet.Signal

ReplicatedStorage.SharedModules.Packet.Types   (1)
    <- ReplicatedStorage.SharedModules.Packet

ReplicatedStorage.SharedModules.Packet.Types.Characters   (1)
    <- ReplicatedStorage.SharedModules.Packet.Types

ReplicatedStorage.SharedModules.Packet.Types.Enums   (1)
    <- ReplicatedStorage.SharedModules.Packet.Types

ReplicatedStorage.SharedModules.Packet.Types.Static1   (1)
    <- ReplicatedStorage.SharedModules.Packet.Types

ReplicatedStorage.SharedModules.Packet.Types.Static2   (1)
    <- ReplicatedStorage.SharedModules.Packet.Types

ReplicatedStorage.SharedModules.Packet.Types.Static3   (1)
    <- ReplicatedStorage.SharedModules.Packet.Types

ReplicatedStorage.SharedModules.PetBehaviors.BehaviorBase   (6)
    <- ReplicatedStorage.SharedModules.PetBehaviors.BlackDragonDefend
    <- ReplicatedStorage.SharedModules.PetBehaviors.DefendGarden
    <- ReplicatedStorage.SharedModules.PetBehaviors.IceSerpentDefend
    <- ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    <- ReplicatedStorage.SharedModules.PetBehaviors.StealFruit
    <- ReplicatedStorage.SharedModules.PetBehaviors.TEMPLATE

ReplicatedStorage.SharedModules.PetBehaviors.BlackDragonDefend   (1)
    <- ReplicatedStorage.SharedModules.PetBehaviors.Index

ReplicatedStorage.SharedModules.PetBehaviors.DefendGarden   (1)
    <- ReplicatedStorage.SharedModules.PetBehaviors.Index

ReplicatedStorage.SharedModules.PetBehaviors.IceSerpentDefend   (1)
    <- ReplicatedStorage.SharedModules.PetBehaviors.Index

ReplicatedStorage.SharedModules.PetBehaviors.PickFruit   (1)
    <- ReplicatedStorage.SharedModules.PetBehaviors.Index

ReplicatedStorage.SharedModules.PetBehaviors.StealFruit   (1)
    <- ReplicatedStorage.SharedModules.PetBehaviors.Index

ReplicatedStorage.SharedModules.PetModules   (3)
    <- StarterPlayer.StarterPlayerScripts.Controllers.EggOpenController.EggEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController

ReplicatedStorage.SharedModules.PetModules.Bee   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.BlackDragon   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Bunny   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Deer   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Frog   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.GoldenDragonfly   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.IceSerpent   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Monkey   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Owl   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Raccoon   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Robin   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PetModules.Unicorn   (1)
    <- ReplicatedStorage.SharedModules.PetModules

ReplicatedStorage.SharedModules.PlantSizeMultipliers   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.DisplayPlantGrowthController

ReplicatedStorage.SharedModules.PowerHoseData   (2)
    <- ReplicatedStorage.CmdrClient.Types.PowerhoseName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.PropData   (3)
    <- ReplicatedStorage.CmdrClient.Types.CosmeticName
    <- StarterGui.PropsFrame.Controller2
    <- StarterPlayer.StarterPlayerScripts.Controllers.RollController

ReplicatedStorage.SharedModules.RaccoonData   (2)
    <- ReplicatedStorage.CmdrClient.Types.RaccoonName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.RakeData   (4)
    <- ReplicatedStorage.CmdrClient.Types.RakeName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.RakeController
    <- StarterPlayer.StarterPlayerScripts.Controllers.RakeVisualizerController

ReplicatedStorage.SharedModules.RarityVisuals   (4)
    <- ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    <- ReplicatedStorage.SharedModules.PetBehaviors.StealFruit
    <- StarterPlayer.StarterPlayerScripts.Controllers.DroppedItemController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetHoverTooltipController

ReplicatedStorage.SharedModules.RobuxShopContent   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController

ReplicatedStorage.SharedModules.SeedData   (24)
    <- ReplicatedStorage.CmdrClient.Types.FruitName
    <- ReplicatedStorage.CmdrClient.Types.SeedName
    <- ReplicatedStorage.SharedModules.DevProducts
    <- ReplicatedStorage.SharedModules.FruitValueCalc
    <- ReplicatedStorage.SharedModules.GetGenerationPerMinute
    <- ReplicatedStorage.SharedModules.PetBehaviors.PickFruit
    <- ReplicatedStorage.SharedModules.PetBehaviors.StealFruit
    <- ReplicatedStorage.SharedModules.SeedPackData
    <- ServerScriptService.PlantService
    <- StarterGui.PremiumSeedShop.Frame.ScrollingFrame.GenerateItems
    <- StarterGui.SeedShop.Frame.NormalShop.GenerateItems
    <- StarterPlayer.StarterPlayerScripts.Controllers.DisplayPlantGrowthController
    <- StarterPlayer.StarterPlayerScripts.Controllers.EmptyPotController
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuildShopController
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.KingController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PetVisualController.ClientPetControllers.Raccoon
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantLifecycleHandler
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController.SeedPackEffect
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedToolTipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.StealController
    <- StarterPlayer.StarterPlayerScripts.Controllers.WaterRevivePromptController

ReplicatedStorage.SharedModules.SeedPackData   (7)
    <- ReplicatedStorage.CmdrClient.Types.SeedPackName
    <- ReplicatedStorage.SharedModules.ExclusiveShopData
    <- StarterPlayer.StarterPlayerScripts.Controllers.GuildShopController
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackHandleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedPackOpenController
    <- StarterPlayer.StarterPlayerScripts.LimitedShop

ReplicatedStorage.SharedModules.SellValueData   (8)
    <- ReplicatedStorage.SharedModules.CalculateStealDuration
    <- ReplicatedStorage.SharedModules.FruitValueCalc
    <- ReplicatedStorage.SharedModules.GetGenerationPerMinute
    <- ReplicatedStorage.SharedModules.SeedPackData
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedToolTipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.StealController

ReplicatedStorage.SharedModules.ShovelData   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.SprinklerData   (4)
    <- ReplicatedStorage.CmdrClient.Types.SprinklerName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.SprinklerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.SprinklerVisualizerController

ReplicatedStorage.SharedModules.TeleporterData   (3)
    <- ReplicatedStorage.CmdrClient.Types.TeleporterName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.TeleporterController

ReplicatedStorage.SharedModules.TimeCycleData   (6)
    <- ReplicatedStorage.CmdrClient.Types.MoonType
    <- ReplicatedStorage.CmdrClient.Types.Phases
    <- ServerScriptService.TimeCycleServer
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleBarController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController
    <- StarterPlayer.StarterPlayerScripts.Controllers.TimeCycleController.Phases.Day

ReplicatedStorage.SharedModules.TrowelData   (2)
    <- ReplicatedStorage.CmdrClient.Types.TrowelName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.WateringcanData   (3)
    <- ReplicatedStorage.CmdrClient.Types.WateringCanName
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main
    <- StarterPlayer.StarterPlayerScripts.Controllers.WateringcanController

ReplicatedStorage.SharedModules.WeatherData   (4)
    <- ReplicatedStorage.CmdrClient.Types.Weather
    <- ServerScriptService.WeatherService
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedToolTipController
    <- StarterPlayer.StarterPlayerScripts.Controllers.WeatherController

ReplicatedStorage.SharedModules.WeightFormat   (4)
    <- ReplicatedStorage.SharedModules.FruitProxyUtil
    <- ReplicatedStorage.SharedModules.GuildCompetition
    <- StarterPlayer.StarterPlayerScripts.Controllers.FruitVisualizerController
    <- StarterPlayer.StarterPlayerScripts.Controllers.InventoryController.Main

ReplicatedStorage.SharedModules.WheelbarrowData   (1)
    <- ReplicatedStorage.CmdrClient.Types.WheelbarrowName

ReplicatedStorage.SharedModules.Zone   (4)
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Big Teleport Pad
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Huge Teleport Pad
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Teleport Pad
    <- StarterPlayer.StarterPlayerScripts.Controllers.PropVisualizerController.Weather Machine

ReplicatedStorage.SharedModules.Zone.Enum   (2)
    <- ReplicatedStorage.SharedModules.Zone
    <- ReplicatedStorage.SharedModules.Zone.ZoneController

ReplicatedStorage.SharedModules.Zone.Janitor   (3)
    <- ReplicatedStorage.SharedModules.Zone
    <- ReplicatedStorage.SharedModules.Zone.ZoneController
    <- ReplicatedStorage.SharedModules.Zone.ZoneController.Tracker

ReplicatedStorage.SharedModules.Zone.Signal   (3)
    <- ReplicatedStorage.SharedModules.Zone
    <- ReplicatedStorage.SharedModules.Zone.ZoneController
    <- ReplicatedStorage.SharedModules.Zone.ZoneController.Tracker

ReplicatedStorage.SharedModules.Zone.ZoneController   (1)
    <- ReplicatedStorage.SharedModules.Zone

ReplicatedStorage.SharedModules.Zone.ZoneController.CollectiveWorldModel   (1)
    <- ReplicatedStorage.SharedModules.Zone.ZoneController

ReplicatedStorage.SharedModules.Zone.ZoneController.Tracker   (1)
    <- ReplicatedStorage.SharedModules.Zone.ZoneController

ReplicatedStorage.SharedModules.Zone.ZonePlusReference   (1)
    <- ReplicatedStorage.SharedModules.Zone

ReplicatedStorage.UserGenerated.ABTests   (1)
    <- ReplicatedStorage.UserGenerated.ABTests.ClientRunner

ReplicatedStorage.UserGenerated.ABTests.SharedABTests   (2)
    <- ReplicatedStorage.UserGenerated.ABTests
    <- ReplicatedStorage.UserGenerated.Client.ClientABTests

ReplicatedStorage.UserGenerated.Analytics.ClientKit   (1)
    <- ReplicatedStorage.UserGenerated.Analytics.ClientRunner

ReplicatedStorage.UserGenerated.Client.ClientABTests   (1)
    <- ReplicatedStorage.UserGenerated.ABTests

ReplicatedStorage.UserGenerated.Client.ClientFastFlags   (1)
    <- ReplicatedStorage.UserGenerated.FastFlags

ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe   (2)
    <- ReplicatedStorage.UserGenerated.Client.ClientFastFlags
    <- ServerScriptService.UserGenerated.Server.ServerFastFlags

ReplicatedStorage.UserGenerated.Collections.DeepEquals   (2)
    <- ReplicatedStorage.UserGenerated.Concurrency.Observable
    <- ReplicatedStorage.UserGenerated.Lang.Tests

ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe   (1)
    <- ReplicatedStorage.UserGenerated.Client.ClientFastFlags

ReplicatedStorage.UserGenerated.Collections.DeepFreeze   (1)
    <- ReplicatedStorage.UserGenerated.Concurrency.Cache

ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe   (3)
    <- ReplicatedStorage.UserGenerated.Client.ClientABTests
    <- ReplicatedStorage.UserGenerated.Client.ClientFastFlags
    <- ServerScriptService.UserGenerated.Server.ServerFastFlags

ReplicatedStorage.UserGenerated.Concurrency.Bindable   (9)
    <- ReplicatedStorage.UserGenerated.ABTests.SharedABTests
    <- ReplicatedStorage.UserGenerated.Client.ClientABTests
    <- ReplicatedStorage.UserGenerated.Client.ClientFastFlags
    <- ReplicatedStorage.UserGenerated.Concurrency.Cache
    <- ReplicatedStorage.UserGenerated.Concurrency.Observable
    <- ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags
    <- ReplicatedStorage.UserGenerated.Lang.Janitor
    <- ServerScriptService.UserGenerated.Server.ServerABTests
    <- ServerScriptService.UserGenerated.Server.ServerFastFlags

ReplicatedStorage.UserGenerated.Concurrency.Cache   (5)
    <- ReplicatedStorage.UserGenerated.Roblox.GroupServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.LocalizationServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.MarketplaceServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.PolicyServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper

ReplicatedStorage.UserGenerated.Concurrency.Lock   (1)
    <- ReplicatedStorage.UserGenerated.Concurrency.Cache

ReplicatedStorage.UserGenerated.Concurrency.ThreadJoin   (1)
    <- ReplicatedStorage.UserGenerated.Analytics.ClientRunner

ReplicatedStorage.UserGenerated.FastFlags   (13)
    <- ReplicatedStorage.SharedModules.EggData
    <- ReplicatedStorage.SharedModules.Flags.AntiAfkFlags
    <- ReplicatedStorage.SharedModules.Flags.CrateShopFlags
    <- ReplicatedStorage.SharedModules.Flags.GardenFlags
    <- ReplicatedStorage.SharedModules.Flags.GearShopFlags
    <- ReplicatedStorage.SharedModules.Flags.MailboxFlags
    <- ReplicatedStorage.SharedModules.Flags.PerfFlags
    <- ReplicatedStorage.SharedModules.Flags.SeedShopFlags
    <- ReplicatedStorage.SharedModules.FruitValueCalc
    <- ReplicatedStorage.SharedModules.MutationData
    <- ReplicatedStorage.UserGenerated.ABTests.SharedABTests
    <- ReplicatedStorage.UserGenerated.FastFlags.ClientRunner
    <- ReplicatedStorage.UserGenerated.Logging.ClientRunner

ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags   (3)
    <- ReplicatedStorage.UserGenerated.Client.ClientFastFlags
    <- ReplicatedStorage.UserGenerated.FastFlags
    <- ServerScriptService.UserGenerated.Server.ServerFastFlags

ReplicatedStorage.UserGenerated.IO.Base64   (1)
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption

ReplicatedStorage.UserGenerated.IO.Crypto.AES   (1)
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption

ReplicatedStorage.UserGenerated.IO.Crypto.AES.Modes   (1)
    <- ReplicatedStorage.UserGenerated.IO.Crypto.AES

ReplicatedStorage.UserGenerated.IO.Crypto.AES.Pads   (1)
    <- ReplicatedStorage.UserGenerated.IO.Crypto.AES

ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed   (2)
    <- ReplicatedStorage.UserGenerated.Randoms.ISAAC
    <- ReplicatedStorage.UserGenerated.Randoms.Xorshift128

ReplicatedStorage.UserGenerated.IO.Crypto.HMAC   (1)
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption

ReplicatedStorage.UserGenerated.IO.Crypto.Hash   (8)
    <- ReplicatedStorage.UserGenerated.IO.Crypto.HMAC
    <- ReplicatedStorage.UserGenerated.IO.Crypto.MD5
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SHA1
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SHA224
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SHA256
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SHA384
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SHA512
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption

ReplicatedStorage.UserGenerated.IO.Crypto.SHA256   (1)
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption

ReplicatedStorage.UserGenerated.IO.JSONEncoder   (1)
    <- ReplicatedStorage.UserGenerated.IO.HTTP.URL

ReplicatedStorage.UserGenerated.Lang.Asserts   (25)
    <- ReplicatedStorage.SharedModules.EggData
    <- ReplicatedStorage.SharedModules.Flags.AntiAfkFlags
    <- ReplicatedStorage.SharedModules.Flags.CrateShopFlags
    <- ReplicatedStorage.SharedModules.Flags.GardenFlags
    <- ReplicatedStorage.SharedModules.Flags.GearShopFlags
    <- ReplicatedStorage.SharedModules.Flags.MailboxFlags
    <- ReplicatedStorage.SharedModules.Flags.PerfFlags
    <- ReplicatedStorage.SharedModules.Flags.SeedShopFlags
    <- ReplicatedStorage.SharedModules.FruitValueCalc
    <- ReplicatedStorage.SharedModules.Guild.Asserts
    <- ReplicatedStorage.SharedModules.MutationData
    <- ReplicatedStorage.UserGenerated.ABTests.SharedABTests
    <- ReplicatedStorage.UserGenerated.Analytics.ClientKit
    <- ReplicatedStorage.UserGenerated.Client.ClientFastFlags
    <- ReplicatedStorage.UserGenerated.Collections.DropTable
    <- ReplicatedStorage.UserGenerated.Concurrency.Cache
    <- ReplicatedStorage.UserGenerated.Concurrency.Render
    <- ReplicatedStorage.UserGenerated.IO.HTTP
    <- ReplicatedStorage.UserGenerated.IO.HTTP.URL
    <- ReplicatedStorage.UserGenerated.Logging
    <- ReplicatedStorage.UserGenerated.Roblox.GroupServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.LocalizationServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.MarketplaceServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.PolicyServiceHelper
    <- ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper

ReplicatedStorage.UserGenerated.Lang.Finally   (1)
    <- ReplicatedStorage.UserGenerated.Concurrency.Lock

ReplicatedStorage.UserGenerated.Lang.Keys   (2)
    <- ReplicatedStorage.UserGenerated.IO.HTTP.URL
    <- ReplicatedStorage.UserGenerated.Logging

ReplicatedStorage.UserGenerated.Logging   (2)
    <- ReplicatedStorage.UserGenerated.Concurrency.Render
    <- ReplicatedStorage.UserGenerated.Logging.ClientRunner

ReplicatedStorage.UserGenerated.Lottie.Easing   (1)
    <- ReplicatedStorage.UserGenerated.Lottie

ReplicatedStorage.UserGenerated.Lottie.PNG.Types   (4)
    <- ReplicatedStorage.UserGenerated.Lottie.PNG
    <- ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.IHDR
    <- ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.PLTE
    <- ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.tRNS

ReplicatedStorage.UserGenerated.Lottie.PNG.chunks   (1)
    <- ReplicatedStorage.UserGenerated.Lottie.PNG

ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.IHDR   (1)
    <- ReplicatedStorage.UserGenerated.Lottie.PNG.chunks

ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.PLTE   (1)
    <- ReplicatedStorage.UserGenerated.Lottie.PNG.chunks

ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.tRNS   (1)
    <- ReplicatedStorage.UserGenerated.Lottie.PNG.chunks

ReplicatedStorage.UserGenerated.Lottie.PNG.crc32   (1)
    <- ReplicatedStorage.UserGenerated.Lottie.PNG

ReplicatedStorage.UserGenerated.Lottie.PNG.zlib   (1)
    <- ReplicatedStorage.UserGenerated.Lottie.PNG

ReplicatedStorage.UserGenerated.Lottie.Types   (2)
    <- ReplicatedStorage.UserGenerated.Lottie
    <- ReplicatedStorage.UserGenerated.Lottie.Easing

ReplicatedStorage.UserGenerated.Math.RoundFigures   (2)
    <- ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated
    <- ReplicatedStorage.UserGenerated.Strings.FormatFigures

ReplicatedStorage.UserGenerated.Math.StableExp10   (2)
    <- ReplicatedStorage.UserGenerated.Math.RoundFigures
    <- ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated

ReplicatedStorage.UserGenerated.Randoms.Base   (3)
    <- ReplicatedStorage.UserGenerated.Randoms
    <- ReplicatedStorage.UserGenerated.Randoms.ISAAC
    <- ReplicatedStorage.UserGenerated.Randoms.Xorshift128

ReplicatedStorage.UserGenerated.Randoms.ISAAC   (2)
    <- ReplicatedStorage.UserGenerated.Collections.DropTable
    <- ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption

ReplicatedStorage.UserGenerated.Randoms.Xorshift128   (1)
    <- ReplicatedStorage.UserGenerated.Randoms

ReplicatedStorage.UserGenerated.Randoms.Xorshift128.Theory   (1)
    <- ReplicatedStorage.UserGenerated.Randoms.Xorshift128

ReplicatedStorage.UserGenerated.Roblox.MarketplaceServiceHelper   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.EditGuildController

ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper   (1)
    <- ReplicatedStorage.UserGenerated.Analytics.ClientRunner

ReplicatedStorage.UserGenerated.Strings.Commas   (1)
    <- ReplicatedStorage.UserGenerated.Strings.FormatFigures

ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated   (1)
    <- ReplicatedStorage.UserGenerated.Strings.FormatOdds

ReplicatedStorage.UserGenerated.Strings.FormatFigures   (1)
    <- ReplicatedStorage.UserGenerated.Strings.FormatPercent

ReplicatedStorage.UserGenerated.Strings.FormatOdds   (1)
    <- ReplicatedStorage.UserGenerated.Strings.FormatChance

ReplicatedStorage.UserGenerated.Strings.FormatPercent   (1)
    <- ReplicatedStorage.UserGenerated.Strings.FormatChance

ReplicatedStorage.UserGenerated.Strings.ObjectPaths   (1)
    <- ReplicatedStorage.UserGenerated.Client.ClientFastFlags

ReplicatedStorage.UserGenerated.Strings.Stringify   (2)
    <- ReplicatedStorage.UserGenerated.Lang.Tests
    <- ReplicatedStorage.UserGenerated.Logging

ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString   (2)
    <- ReplicatedStorage.UserGenerated.Strings.Commas
    <- ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated

ReplicatedStorage.UserGenerated.Strings.UTF8Sub   (1)
    <- ReplicatedStorage.UserGenerated.Analytics.ClientRunner

ReplicatedStorage.UserGenerated.VFX.Emit   (1)
    <- ReplicatedStorage.UserGenerated.VFX.PlayVFX

ReplicatedStorage.UserGenerated.VFX.EmitOnce   (1)
    <- ReplicatedStorage.UserGenerated.VFX.Emit

ServerScriptService.GameServerAPI   (4)
    <- ServerScriptService.GameServer
    <- ServerScriptService.GameServer
    <- ServerScriptService.PlantService
    <- ServerScriptService.WildPetService

ServerScriptService.ServerPackages.ProfileStore   (1)
    <- ServerScriptService.GameServer

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface.AutoComplete   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface.Window   (2)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.CmdrInterface
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.DefaultEventHandlers

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient.DefaultEventHandlers   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CmdrClient

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.CreateGui   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Initialize

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Initialize   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Argument   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Command

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Command   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Dispatcher

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Dispatcher   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Registry   (1)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr

ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Util   (17)
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.BrickColor
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Color3
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Command
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Duration
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Player
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.PlayerId
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Primitives
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.StoredKey
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Team
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Type
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.URL
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.UserInput
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInTypes.Vector
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Argument
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Dispatcher
    <- ServerScriptService.ServerPackages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Registry

ServerScriptService.UserGenerated.Server.ServerABTests   (1)
    <- ReplicatedStorage.UserGenerated.ABTests

ServerScriptService.UserGenerated.Server.ServerFastFlags   (2)
    <- ReplicatedStorage.UserGenerated.FastFlags
    <- ServerScriptService.GameServer

StarterPlayer.StarterPlayerScripts.Controllers.CrateController.CrateOpenEffect   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.CrateController

StarterPlayer.StarterPlayerScripts.Controllers.DevProductController   (2)
    <- StarterPlayer.StarterPlayerScripts.Controllers.GearInspectController
    <- StarterPlayer.StarterPlayerScripts.Controllers.NPCController.Sell_Steven

StarterPlayer.StarterPlayerScripts.Controllers.DisplayPlantGrowthController   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.SeedInspectController

StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController.CCDIKController   (1)
    <- StarterPlayer.StarterPlayerScripts.Controllers.DragonBreathController

]==]
return {}
