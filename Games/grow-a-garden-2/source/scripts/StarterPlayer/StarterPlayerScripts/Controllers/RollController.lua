--credit to prince games studio
local t = {
	StartOrder = 6
}
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PropData = require(ReplicatedStorage.SharedModules.PropData)
local FenceData = require(ReplicatedStorage.SharedModules.FenceData)
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Click = SoundService.SFX.Click
local RollFrame_New = PlayerGui:WaitForChild("RollFrame_New")
local Spinner = RollFrame_New:WaitForChild("Frame"):WaitForChild("Spinner")
local Template = Spinner:WaitForChild("UIListLayout"):WaitForChild("Template")
local SkipButton = RollFrame_New:WaitForChild("BlackBackdrop"):WaitForChild("SkipButton")
local t2 = {}

function t.Init(p1) --[[ Init | Line: 24 | Upvalues: Template (copy), PropData (copy), t2 (copy), FenceData (copy) ]]
	Template.Visible = false

	for v1, v2 in PropData.Data do
		t2[v2.PropName] = v2.IMG
	end

	for v3, v4 in FenceData.Data do
		t2[v4.PropName] = v4.IMG
	end
end
function t.Start(p1) --[[ Start | Line: 36 ]] end
function t.GetImage(p1, p2) --[[ GetImage | Line: 39 | Upvalues: t2 (copy) ]]
	return t2[p2] or ""
end
function t.ReturnRandomItem(p1, p2) --[[ ReturnRandomItem | Line: 43 ]]
	local sum = 0

	for k, v in pairs(p2) do
		sum = sum + v.Chance
	end

	local v1 = math.random() * sum
	local sum2 = 0

	for k, v in pairs(p2) do
		sum2 = sum2 + v.Chance

		if v1 <= sum2 then
			return v
		end
	end

	return p2[#p2]
end
function t.ClearSpinnerFrames(p1) --[[ ClearSpinnerFrames | Line: 59 | Upvalues: Spinner (copy) ]]
	for k, v in pairs(Spinner:GetChildren()) do
		if v:IsA("Frame") and v.Name ~= "Template" then
			v:Destroy()
		end
	end
end
function t.MakeFrame(p1, p2, p3) --[[ MakeFrame | Line: 67 | Upvalues: Template (copy), Spinner (copy) ]]
	local SpinnerFrame = Template:Clone()

	SpinnerFrame.Image.Image = p2.Image or p1:GetImage(p2.Name)
	SpinnerFrame.ItemName.Text = p2.Name
	SpinnerFrame.Name = "SpinnerFrame"
	SpinnerFrame.LayoutOrder = p3
	SpinnerFrame.Visible = true
	SpinnerFrame.Parent = Spinner

	return SpinnerFrame
end
function t.Roll(p1, p2, p3) --[[ Roll | Line: 79 | Upvalues: GuiController (copy), Spinner (copy), Click (copy), TweenService (copy), SkipButton (copy) ]]
	GuiController:Open("RollFrame_New")
	p1:ClearSpinnerFrames()

	local v1 = if p3 then p3 else p1:ReturnRandomItem(p2)

	Spinner.Position = UDim2.new(0.5, 0, 0.5, 0)

	local t = {}

	for i = 1, 60 do
		local v2

		v2 = if i == 50 and v1 then v1 else p1:ReturnRandomItem(p2)
		t[i] = p1:MakeFrame(v2, i)
	end

	task.wait()

	local v3 = t[1]
	local X = v3.AbsoluteSize.X
	local v4 = if t[2] then t[2].AbsolutePosition.X - v3.AbsolutePosition.X else X
	local v5 = Spinner.AbsolutePosition.X + Spinner.AbsoluteSize.X / 2
	local v6 = v3.AbsolutePosition.X + X / 2 - v5
	local v7 = Instance.new("NumberValue")

	v7.Value = 0

	local function updateSpinner(p1) --[[ updateSpinner | Line: 104 | Upvalues: v6 (copy), v4 (copy), Spinner (ref) ]]
		Spinner.Position = UDim2.new(0.5, -(v6 + p1 * v4), 0.5, 0)
	end

	local v8 = 0
	local v9 = v7.Changed:Connect(function(p1) --[[ Line: 110 | Upvalues: v6 (copy), v4 (copy), Spinner (ref), v8 (ref), Click (ref) ]]
		Spinner.Position = UDim2.new(0.5, -(v6 + p1 * v4), 0.5, 0)

		local v2 = math.floor(p1 + 0.5)

		if not (v8 < v2) then
			return
		end

		v8 = v2
		Click:Play()
	end)
	local v10 = TweenService:Create(v7, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Value = 49
	})
	local v11 = coroutine.running()
	local v12 = false

	local function finishRoll() --[[ finishRoll | Line: 127 | Upvalues: v12 (ref), v10 (copy), v7 (copy), v6 (copy), v4 (copy), Spinner (ref), v11 (copy) ]]
		if not v12 then
			v12 = true
			v10:Cancel()
			v7.Value = 49
			Spinner.Position = UDim2.new(0.5, -(v6 + 49 * v4), 0.5, 0)
			task.spawn(v11)
		end
	end

	local v13 = SkipButton.Activated:Once(finishRoll)
	local v14 = v10.Completed:Once(finishRoll)

	v10:Play()
	coroutine.yield()

	if v13 then
		v13:Disconnect()
	end

	if not v14 then
		v9:Disconnect()
		v7:Destroy()
		task.wait(1)
		GuiController:Close()

		return v1
	end

	v14:Disconnect()
	v9:Disconnect()
	v7:Destroy()
	task.wait(1)
	GuiController:Close()

	return v1
end

return t