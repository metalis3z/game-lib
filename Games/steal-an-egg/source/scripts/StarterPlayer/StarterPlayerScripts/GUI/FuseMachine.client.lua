-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)

require(ReplicatedStorage.Library.Types.AssetItem)

local Directory = require(ReplicatedStorage.Directory.Assets).Directory
local Audio = require(ReplicatedStorage.Library.Audio)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local DictionaryLength = require(ReplicatedStorage.Library.Functions.DictionaryLength)
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)
local FuseKernelUtil = require(ReplicatedStorage.Library.Util.FuseKernelUtil)
local FuseMachineBackpackSelection = require(script.FuseMachineBackpackSelection)
local FuseMachineProgressPresentation = require(script.FuseMachineProgressPresentation)
local FuseMachineSelectedSlot = require(script.FuseMachineSelectedSlot)
local FuseMachine = require(ReplicatedStorage.Library.Types.FuseMachine)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Signal = require(ReplicatedStorage.Library.Signal)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local v1 = Color3.fromRGB(255, 0, 0)
local v2 = Log.new()
local v3 = Lock()
local v4 = Lock()
local v5 = Lock()
local FuseMachine2 = GUI.FuseMachine().Main.FuseMachine

assert(FuseMachine2:IsA("Frame"), "FuseMachine.FuseMachine must be a Frame")

local v7 = FuseMachine2.Content

assert(v7:IsA("Frame"), "FuseMachine.Content must be a Frame")

local Template = v7.Template

assert(Template:IsA("Frame"), "FuseMachine.Content.Template must be a Frame")

local Buy = FuseMachine2.Buy

assert(Buy:IsA("ImageButton"), "FuseMachine.Buy must be an ImageButton")

local Price = Buy.Price

assert(Price:IsA("TextLabel"), "FuseMachine.Buy.Price must be a TextLabel")

local BackgroundColor3 = Buy.BackgroundColor3
local v12 = BackgroundColor3:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
local BackpackScrollingFrameContainer = FuseMachine2.BackpackScrollingFrameContainer

assert(BackpackScrollingFrameContainer:IsA("GuiObject"), "FuseMachine BackpackScrollingFrameContainer must be a GuiObject")

local Container = BackpackScrollingFrameContainer.Container

assert(Container:IsA("GuiObject"), "FuseMachine backpack Container must be a GuiObject")

local ScrollingFrame = Container.ScrollingFrame

assert(ScrollingFrame:IsA("ScrollingFrame"), "FuseMachine Container.ScrollingFrame must be a ScrollingFrame")
assert(ScrollingFrame.UIGridLayout:IsA("UIGridLayout"), "FuseMachine Container.ScrollingFrame.UIGridLayout must be a UIGridLayout")

local Connectors = FuseMachine2.Connectors

assert(Connectors:IsA("Folder"), "FuseMachine.Connectors must be a Folder")

local Output = FuseMachine2.Output

assert(Output:IsA("Frame"), "FuseMachine.Output must be a Frame")

local Info = FuseMachine2.Info

assert(Info:IsA("Frame"), "FuseMachine.Info must be a Frame")

local Ok = Info.Ok

assert(Ok:IsA("GuiButton"), "FuseMachine.Info.Ok must be a GuiButton")

local Machines = Workspace:WaitForChild("__OBJECTS").Machines

assert(Machines:IsA("Folder"), "Workspace.__OBJECTS.Machines must be a Folder")

local FuseMachine3 = Machines.FuseMachine

assert(FuseMachine3:IsA("Model"), "Workspace FuseMachine must be a Model")

local Overhead = FuseMachine3.Overhead

assert(Overhead:IsA("BasePart"), "FuseMachine.Overhead must be a BasePart")

local BillboardGui = Overhead.BillboardGui

assert(BillboardGui:IsA("BillboardGui"), "FuseMachine.Overhead.BillboardGui must be a BillboardGui")

local Countdown = BillboardGui.Countdown

assert(Countdown:IsA("TextLabel"), "FuseMachine overhead Countdown must be a TextLabel")

local v26 = FuseMachineBackpackSelection.new(ScrollingFrame)
local v27 = FuseMachineProgressPresentation.new(Connectors, Output)
local t = {}
local v28 = false

local function notifyError(p1) --[[ notifyError | Line: 99 | Upvalues: Message (copy), v1 (copy) ]]
	Message.Bottom({
		Time = 3,
		Message = p1,
		Color = v1
	})
end

local function getSelectedCategory(p1) --[[ getSelectedCategory | Line: 107 ]]
	local v1 = p1.FusionSlots[1]

	if v1 == nil then
		return nil
	end

	local v2 = p1.Inventory[v1]

	if v2 then
		return v2.Category
	end

	return nil
end

local function getNoMatchMessage(p1) --[[ getNoMatchMessage | Line: 116 | Upvalues: Directory (copy) ]]
	local v1 = Directory[p1]

	assert(v1 ~= nil, (("Missing asset config %*"):format(p1)))

	return ("You have no other <font color=\"#%*\">%*</font> to add!"):format(v1.Rarity.Color:ToHex(), v1.DisplayName)
end

local function updateOverheadInputCount(p1) --[[ updateOverheadInputCount | Line: 122 | Upvalues: Countdown (copy) ]]
	local count = 0

	if p1 ~= nil then
		local v1 = p1.FusionSlots[1]

		if v1 ~= nil and p1.Inventory[v1] ~= nil then
			count = count + 1
		end

		local v2 = p1.FusionSlots[2]

		if v2 ~= nil and p1.Inventory[v2] ~= nil then
			count = count + 1
		end

		local v3 = p1.FusionSlots[3]

		if v3 ~= nil and p1.Inventory[v3] ~= nil then
			count = count + 1
		end
	end

	Countdown.Text = ("%*/%*"):format(count, 3)
end

local function destroySlot(p1) --[[ destroySlot | Line: 135 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	v1:Destroy()
	t[p1] = nil
end

local function requestReturn(p1) --[[ requestReturn | Line: 143 | Upvalues: v4 (copy), Network (copy), Constants (copy), Message (copy), v1 (copy) ]]
	v4(function() --[[ Line: 144 | Upvalues: Network (ref), Constants (ref), p1 (copy), Message (ref), v1 (ref) ]]
		local v12, v2 = Network.Invoke(Constants.NETWORK_MAP.FuseMachine.REMOVE_MOB, p1)

		if v12 then
			return
		end

		Message.Bottom({
			Time = 3,
			Message = if typeof(v2) == "string" then v2 else "Failed to return pet",
			Color = v1
		})
	end)
end

local function render() --[[ render | Line: 152 | Upvalues: Save (copy), Info (copy), updateOverheadInputCount (copy), Buy (copy), v12 (copy), Price (copy), v27 (copy), v7 (copy), t (copy), FuseMachineSelectedSlot (copy), Template (copy), requestReturn (copy), AssetItemSerialization (copy), Directory (copy), BackgroundColor3 (copy), Simple (copy), FuseKernelUtil (copy) ]]
	local v1 = Save.Get()

	Info.Visible = if v1 == nil then false else not v1.FusionInfoAcknowledged
	updateOverheadInputCount(v1)

	if v1 == nil then
		Buy.Visible = true
		Buy.Active = false
		Buy.BackgroundColor3 = v12
		Price.Text = ("%* Pet Left"):format(3)
		v27:Update(0, nil)

		return
	end

	local list = {}
	local v4 = nil

	for i = 1, 3 do
		local v5 = v1.FusionSlots[i]
		local v6 = if v5 then v1.Inventory[v5] else nil
		local v72 = v7[("Empty.%*"):format(i)]
		local v8 = v72:IsA("Frame")

		assert(v8, (("FuseMachine.Content.Empty.%* must be a Frame"):format(i)))

		if v5 == nil or v6 == nil then
			local v10 = t[i]

			if v10 then
				v10:Destroy()
				t[i] = nil
			end

			v72.Visible = true

			continue
		end

		local v11 = if v4 then v4 else v6.Category
		local v122 = t[i]

		if v122 == nil or v122:GetUid() ~= v5 then
			local v13 = t[i]

			if v13 then
				v13:Destroy()
				t[i] = nil
			end

			t[i] = FuseMachineSelectedSlot.new(Template, v7, i, v5, v6, requestReturn)
		end

		v4 = v11
		v72.Visible = false
		table.insert(list, AssetItemSerialization.Deserialize(v6))
	end

	local v14 = if #list == 3 then not v1.FusionLocked and v1.FusionEggReward == false else false
	local v15

	if v4 == nil then
		v15 = nil
	else
		local v16 = Directory[v4]

		assert(v16 ~= nil, (("Missing asset config %*"):format(v4)))
		v15 = v16.Egg.Icon
	end

	v27:Update(#list, v15)

	if v14 then
		for i, v in ipairs(list) do
			if v.Category ~= v4 then
				v14 = false

				break
			end
		end
	end

	Buy.Visible = true
	Buy.Active = v14

	if v14 then
		Buy.BackgroundColor3 = BackgroundColor3
		Price.Text = "$ " .. Simple.FormatCompact(FuseKernelUtil.CalculateFusePrice(list))
	else
		Buy.BackgroundColor3 = v12
		Price.Text = ("%* Pet Left"):format(3 - #list)
	end
end

local function scheduleRender() --[[ scheduleRender | Line: 217 | Upvalues: v28 (ref), render (copy) ]]
	if not v28 then
		v28 = true
		task.defer(function() --[[ Line: 222 | Upvalues: v28 (ref), render (ref) ]]
			v28 = false
			render()
		end)
	end
end

local function requestAcknowledgeInfo() --[[ requestAcknowledgeInfo | Line: 228 | Upvalues: v5 (copy), Info (copy), Network (copy), Constants (copy), Message (copy), v1 (copy), v28 (ref), render (copy) ]]
	v5(function() --[[ Line: 229 | Upvalues: Info (ref), Network (ref), Constants (ref), Message (ref), v1 (ref), v28 (ref), render (ref) ]]
		if not Info.Visible then
			return
		end

		if Network.Invoke(Constants.NETWORK_MAP.FuseMachine.ACKNOWLEDGE_INFO) == true then
			Info.Visible = false

			return
		end

		Message.Bottom({
			Message = "Failed to save Fuse Machine info acknowledgement",
			Time = 3,
			Color = v1
		})

		if not v28 then
			v28 = true
			task.defer(function() --[[ Line: 222 | Upvalues: v28 (ref), render (ref) ]]
				v28 = false
				render()
			end)
		end
	end)
end

local function requestInsert(p1) --[[ requestInsert | Line: 245 | Upvalues: v4 (copy), Network (copy), Constants (copy), Message (copy), v1 (copy), v26 (copy), BackpackScrollingFrameContainer (copy), v28 (ref), render (copy) ]]
	v4(function() --[[ Line: 246 | Upvalues: Network (ref), Constants (ref), p1 (copy), Message (ref), v1 (ref), v26 (ref), BackpackScrollingFrameContainer (ref), v28 (ref), render (ref) ]]
		local v12, v2 = Network.Invoke(Constants.NETWORK_MAP.FuseMachine.INSERT_MOB, p1)

		if v12 then
			v26:Close()
			BackpackScrollingFrameContainer.Visible = false

			if not v28 then
				v28 = true
				task.defer(function() --[[ Line: 222 | Upvalues: v28 (ref), render (ref) ]]
					v28 = false
					render()
				end)
			end
		else
			Message.Bottom({
				Time = 3,
				Message = if typeof(v2) == "string" then v2 else "Failed to insert pet",
				Color = v1
			})
		end
	end)
end

local function startSelection() --[[ startSelection | Line: 258 | Upvalues: v26 (copy), Save (copy), requestInsert (copy), BackpackScrollingFrameContainer (copy), Directory (copy), Message (copy), v1 (copy) ]]
	if v26:IsOpen() then
		return
	end

	local v12 = Save.Get()

	if v12 == nil then
		return
	end

	local v2 = v12.FusionSlots[1]
	local v3

	if v2 == nil then
		v3 = nil
	else
		local v4 = v12.Inventory[v2]

		v3 = if v4 then v4.Category else nil
	end

	if v26:Open(v12, v3, requestInsert) > 0 then
		BackpackScrollingFrameContainer.Visible = true
		v26:RefreshGridLayout()

		return
	end

	if not v3 then
		Message.Bottom({
			Message = "You do not have any pets to add!",
			Time = 3,
			Color = v1
		})

		return
	end

	local v5 = Directory[v3]

	assert(v5 ~= nil, (("Missing asset config %*"):format(v3)))
	Message.Bottom({
		Time = 3,
		Message = ("You have no other <font color=\"#%*\">%*</font> to add!"):format(v5.Rarity.Color:ToHex(), v5.DisplayName),
		Color = v1
	})
end

local function requestFuse() --[[ requestFuse | Line: 282 | Upvalues: v3 (copy), Save (copy), DictionaryLength (copy), Eggs (copy), Message (copy), v1 (copy), Network (copy), Constants (copy), FuseMachine (copy), v2 (copy), Audio (copy), Signal (copy), v28 (ref), render (copy) ]]
	v3(function() --[[ Line: 283 | Upvalues: Save (ref), DictionaryLength (ref), Eggs (ref), Message (ref), v1 (ref), Network (ref), Constants (ref), FuseMachine (ref), v2 (ref), Audio (ref), Signal (ref), v28 (ref), render (ref) ]]
		local v12 = Save.Get()

		if v12 == nil then
			return
		end

		if DictionaryLength(v12.EggInventory) >= Eggs.MAX_INVENTORY then
			Message.Bottom({
				Message = "Your egg inventory is full!",
				Time = 3,
				Color = v1
			})

			return
		end

		local v22, v3, v4 = Network.Invoke(Constants.NETWORK_MAP.FuseMachine.START_FUSE)

		if v22 then
			if not FuseMachine.FuseResult(v4) then
				v2:AtError():Log("Fuse server returned an invalid reward")

				return
			end

			Audio.Play(83520877125467, script, 1, 1.5)
			Signal.FireAsync(Constants.SIGNALS_MAP.Client.FuseMachine.FUSE_STARTED, v4)

			if not v28 then
				v28 = true
				task.defer(function() --[[ Line: 222 | Upvalues: v28 (ref), render (ref) ]]
					v28 = false
					render()
				end)
			end
		else
			Message.Bottom({
				Time = 3,
				Message = if typeof(v3) == "string" then v3 else "Failed to start fuse",
				Color = v1
			})
		end
	end)
end

(function() --[[ hideObsoletePresentation | Line: 309 | Upvalues: FuseMachine2 (copy), Output (copy) ]]
	local Time = FuseMachine2.Time
	local LuckyIcon = FuseMachine2.LuckyIcon
	local LuckBlur = FuseMachine2.LuckBlur
	local Arrow = FuseMachine2.Arrow

	assert(Time:IsA("GuiObject"), "FuseMachine.Time must be a GuiObject")
	assert(LuckyIcon:IsA("GuiObject"), "FuseMachine.LuckyIcon must be a GuiObject")
	assert(LuckBlur:IsA("GuiObject"), "FuseMachine.LuckBlur must be a GuiObject")
	assert(Arrow:IsA("GuiObject"), "FuseMachine.Arrow must be a GuiObject")
	Output.Visible = true
	Time.Visible = false
	LuckyIcon.Visible = false
	LuckBlur.Visible = false
	Arrow.Visible = false
end)()
BackpackScrollingFrameContainer.Visible = false
Info.Visible = false
Template.Visible = false

for i = 1, 3 do
	local v29 = v7[("Empty.%*"):format(i)]
	local v30 = v29:IsA("Frame")

	assert(v30, (("FuseMachine.Content.Empty.%* must be a Frame"):format(i)))

	local Insert = v29.Insert
	local v32 = Insert:IsA("ImageButton")

	assert(v32, (("FuseMachine.Content.Empty.%*.Insert must be an ImageButton"):format(i)))
	Insert.Activated:Connect(startSelection)
	ButtonFX(Insert)
end

Buy.Activated:Connect(requestFuse)
ButtonFX(Buy)
Ok.Activated:Connect(requestAcknowledgeInfo)
ButtonFX(Ok)
Save.ConnectForDataChanged({ "FusionSlots", "FusionLocked", "FusionEggReward", "FusionInfoAcknowledged", "Inventory", "EggInventory" }, function() --[[ Line: 348 | Upvalues: TabController (copy), v28 (ref), render (copy) ]]
	if not TabController.IsOpen("FuseMachine") then
		return
	end

	if v28 then
		return
	end

	v28 = true
	task.defer(function() --[[ Line: 222 | Upvalues: v28 (ref), render (ref) ]]
		v28 = false
		render()
	end)
end)
TabController.Opened:Connect(function(p1) --[[ Line: 354 | Upvalues: v28 (ref), render (copy) ]]
	if p1 ~= "FuseMachine" then
		return
	end

	if v28 then
		return
	end

	v28 = true
	task.defer(function() --[[ Line: 222 | Upvalues: v28 (ref), render (ref) ]]
		v28 = false
		render()
	end)
end)
TabController.Closed:Connect(function(p1) --[[ Line: 359 | Upvalues: v26 (copy), BackpackScrollingFrameContainer (copy) ]]
	if p1 ~= "FuseMachine" then
		return
	end

	v26:Close()
	BackpackScrollingFrameContainer.Visible = false
end)
render()