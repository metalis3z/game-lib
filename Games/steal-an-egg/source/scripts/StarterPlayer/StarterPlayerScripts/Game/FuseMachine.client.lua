-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Directory = require(ReplicatedStorage.Directory.Assets).Directory
local Audio = require(ReplicatedStorage.Library.Audio)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local FuseMachineAnimation = require(ReplicatedStorage.Library.Client.FuseMachineAnimation)
local FuseMachine = require(ReplicatedStorage.Library.Types.FuseMachine)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Message = require(ReplicatedStorage.Library.Client.Message)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message2 = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Signal = require(ReplicatedStorage.Library.Signal)
local AssetSizeClassification = require(ReplicatedStorage.Library.Util.AssetSizeClassification)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local v1 = Log.new()
local Machines = Workspace:WaitForChild("__OBJECTS").Machines

assert(Machines:IsA("Folder"), "Workspace.__OBJECTS.Machines must be a Folder")

local FuseMachine2 = Machines.FuseMachine

assert(FuseMachine2:IsA("Model"), "Workspace FuseMachine must be a Model")

local Machine = FuseMachine2.Machine

assert(Machine:IsA("BasePart"), "FuseMachine.Machine must be a BasePart")

local Attachment = Machine.Attachment

assert(Attachment:IsA("Attachment"), "FuseMachine.Machine.Attachment must be an Attachment")

local ProximityPrompt = Attachment.ProximityPrompt

assert(ProximityPrompt:IsA("ProximityPrompt"), "FuseMachine proximity prompt must be a ProximityPrompt")

local v7 = 0

local function notifyError(p1) --[[ notifyError | Line: 46 | Upvalues: Message2 (copy) ]]
	Message2.Bottom({
		Time = 3,
		Message = p1,
		Color = Color3.fromRGB(255, 0, 0)
	})
end

local function playFuseAndGrant(p1) --[[ playFuseAndGrant | Line: 54 | Upvalues: Directory (copy), v1 (copy), v7 (ref), ProximityPrompt (copy), FuseMachineAnimation (copy), FuseMachine2 (copy), Machine (copy), Audio (copy), AssetSizeClassification (copy), Message (copy), Network (copy), Constants (copy), Message2 (copy), TabController (copy) ]]
	local AssetCategory = p1.AssetCategory
	local v12 = Directory[AssetCategory]

	if v12 == nil then
		v1:AtError():Log("Fuse result category has no asset config", {
			Category = AssetCategory
		})

		return
	end

	local Egg = v12.Egg

	v7 = v7 + 1

	local v2 = v7

	ProximityPrompt.Enabled = false

	if not FuseMachineAnimation.Play(FuseMachine2, Machine, function() --[[ Line: 66 | Upvalues: v7 (ref), v2 (copy) ]]
		return v7 == v2
	end) then
		ProximityPrompt.Enabled = true

		return
	end

	Audio.Play(103131639134026, script, 1, 1)

	local v3 = AssetSizeClassification.Resolve(p1.AssetScale)

	Message.New(("You fused %*<font color=\"#%*\">%*</font>"):format(if v3 then ("%* "):format(v3.RichText) else "", v12.Rarity.Color:ToHex(), Egg.DisplayName), {
		dontRestore = true,
		icon = Egg.Icon
	})

	local v5, v6 = Network.Invoke(Constants.NETWORK_MAP.FuseMachine.COMPLETE_REVEAL)

	if v5 then
		ProximityPrompt.Enabled = true
		TabController.CloseTab(true)

		return
	end

	local v72 = if typeof(v6) == "string" then v6 else "Failed to grant fused egg"

	Message2.Bottom({
		Time = 3,
		Message = v72,
		Color = Color3.fromRGB(255, 0, 0)
	})
	ProximityPrompt.Enabled = true
	TabController.CloseTab(true)
end

ProximityPrompt.ActionText = "Fuse Pets"
ProximityPrompt.Triggered:Connect(function() --[[ Line: 95 | Upvalues: TabController (copy) ]]
	TabController.OpenTab("FuseMachine")
end)
Signal.Fired(Constants.SIGNALS_MAP.Client.FuseMachine.FUSE_STARTED):Connect(function(p1) --[[ Line: 99 | Upvalues: FuseMachine (copy), playFuseAndGrant (copy) ]]
	assert(FuseMachine.FuseResult(p1), "Fuse started signal requires a valid serialized reward egg")
	task.spawn(playFuseAndGrant, p1)
end)