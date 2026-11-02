local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local CreateTweenModule = require(ReplicatedStorage.Packages.CreateTween)
local ObserversModule = require(ReplicatedStorage.Packages.Observers)
local TroveModule = require(ReplicatedStorage.Packages.Trove)
local NetworkModule = require(ReplicatedStorage.Packages.Net)
local AnimalsModule = require(ReplicatedStorage.Shared.Animals)

local ListCycleRemote = NetworkModule:RemoteFunction("AdminboardService/ListCycle")

local function FormatCountdown(Seconds: number): string
	Seconds = math.max(0, math.floor(Seconds))

	local Minutes = math.floor(Seconds / 60)
	local RemainingSeconds = Seconds % 60

	if Minutes == 0 then
		return string.format("%ds", RemainingSeconds)
	end

	if RemainingSeconds == 0 then
		return string.format("%dm", Minutes)
	end

	return string.format("%dm %ds", Minutes, RemainingSeconds)
end

return {
	Start = function(_)
		local CycleData = ListCycleRemote:InvokeServer()

		ObserversModule.observeTag("Adminboard", function(BoardInstance)
			local ResourceTrove = TroveModule.new()
			local SurfaceInterface = BoardInstance.SurfaceGui

			SurfaceInterface.Parent = Players.LocalPlayer.PlayerGui
			ResourceTrove:Add(SurfaceInterface)

			local EventSlots = SurfaceInterface.EventChosen.Slots
			local LuckSlots = SurfaceInterface.LuckMulti.Slots
			local ItemSlots = SurfaceInterface.Item.Slots

			local CountdownLabel =
				SurfaceInterface.Timer and SurfaceInterface.Timer.Timer

			local function UpdateCountdownDisplay(Seconds: number)
				if CountdownLabel and CountdownLabel:IsA("TextLabel") then
					CountdownLabel.Text = FormatCountdown(Seconds)
				end
			end

			UpdateCountdownDisplay(BoardInstance:GetAttribute("Countdown") or 0)

			ResourceTrove:Add(
				BoardInstance:GetAttributeChangedSignal("Countdown"):Connect(function()
					UpdateCountdownDisplay(BoardInstance:GetAttribute("Countdown") or 0)
				end)
			)

			local function CreateSlider(SlotContainer, EntryCount)
				local ActiveTween
				local SliderValueObject = ResourceTrove:Add(Instance.new("NumberValue"))
				SliderValueObject.Value = 1

				SliderValueObject.Changed:Connect(function(CurrentValue)
					SlotContainer.Frame.Position =
						UDim2.fromScale(-((CurrentValue - 1) % EntryCount), 0.5)
				end)

				return function(TargetIndex: number, Instant: boolean?)
					if ActiveTween then
						ActiveTween:Cancel()
						ActiveTween = nil
					end

					SliderValueObject.Value = 0

					local TargetValue =
						EntryCount * 8 + TargetIndex - SliderValueObject.Value % EntryCount

					if Instant then
						SliderValueObject.Value = TargetValue
					else
						ActiveTween = CreateTweenModule(
							SliderValueObject,
							TweenInfo.new(
								4,
								Enum.EasingStyle.Quint,
								Enum.EasingDirection.Out
							),
							{ Value = TargetValue }
						)
					end
				end
			end

			local SetEventSlider = CreateSlider(EventSlots, #CycleData.Events)
			local SetLuckSlider = CreateSlider(LuckSlots, #CycleData.Luck)
			local SetItemSlider = CreateSlider(ItemSlots, #CycleData.Items)

			for Index = 1, #CycleData.Events + 1 do
				local EventEntry =
					CycleData.Events[(Index - 1) % #CycleData.Events + 1]

				local EntryClone =
					EventSlots.Frame.UIListLayout.Entry:Clone()

				EntryClone.LayoutOrder = Index
				EntryClone.Image =
					EventEntry.Icon or "rbxassetid://17451423471"
				EntryClone.Parent = EventSlots.Frame
			end

			for Index = 1, #CycleData.Luck + 1 do
				local LuckEntry =
					CycleData.Luck[(Index - 1) % #CycleData.Luck + 1]

				local EntryClone =
					LuckSlots.Frame.UIListLayout.Entry:Clone()

				EntryClone.LayoutOrder = Index
				EntryClone.Image =
					LuckEntry.Icon or "rbxassetid://17451423471"
				EntryClone.Parent = LuckSlots.Frame
			end

			for Index = 1, #CycleData.Items + 1 do
				local ItemEntry =
					CycleData.Items[(Index - 1) % #CycleData.Items + 1]

				local EntryClone =
					ItemSlots.Frame.UIListLayout.Entry:Clone()

				EntryClone.LayoutOrder = Index

				local ViewportHandle =
					AnimalsModule:AttachOnViewport(
						ItemEntry.Name,
						EntryClone,
						true,
						nil,
						true
					)

				if ViewportHandle then
					ResourceTrove:Add(ViewportHandle)
				end

				EntryClone.Parent = ItemSlots.Frame
			end

			local function ApplySpinningState(IsSpinning: boolean)
				EventSlots.Visible = not IsSpinning
				SurfaceInterface.EventChosen.Mark.Visible = IsSpinning

				LuckSlots.Visible = not IsSpinning
				SurfaceInterface.LuckMulti.Mark.Visible = IsSpinning

				ItemSlots.Visible = not IsSpinning
				SurfaceInterface.Item.Mark.Visible = IsSpinning
			end

			ApplySpinningState(BoardInstance:GetAttribute("SpinningIn") == true)

			ResourceTrove:Add(
				BoardInstance:GetAttributeChangedSignal("SpinningIn"):Connect(function()
					ApplySpinningState(
						BoardInstance:GetAttribute("SpinningIn") == true
					)
				end)
			)

			local function OnEventChanged(Instant: boolean?)
				local EventIndex = BoardInstance:GetAttribute("Event")
				if EventIndex then
					SetEventSlider(EventIndex, Instant)
				end
			end

			local function OnLuckChanged(Instant: boolean?)
				local LuckIndex = BoardInstance:GetAttribute("Luck")
				if LuckIndex then
					SetLuckSlider(LuckIndex, Instant)
				end
			end

			local function OnItemChanged(Instant: boolean?)
				local ItemIndex = BoardInstance:GetAttribute("Item")
				if ItemIndex then
					SetItemSlider(ItemIndex, Instant)
				end
			end

			OnEventChanged(true)
			OnLuckChanged(true)
			OnItemChanged(true)

			ResourceTrove:Add(
				BoardInstance:GetAttributeChangedSignal("Event"):Connect(function()
					OnEventChanged(false)
				end)
			)

			ResourceTrove:Add(
				BoardInstance:GetAttributeChangedSignal("Luck"):Connect(function()
					OnLuckChanged(false)
				end)
			)

			ResourceTrove:Add(
				BoardInstance:GetAttributeChangedSignal("Item"):Connect(function()
					OnItemChanged(false)
				end)
			)

			return ResourceTrove:WrapClean()
		end, { workspace })
	end,
}