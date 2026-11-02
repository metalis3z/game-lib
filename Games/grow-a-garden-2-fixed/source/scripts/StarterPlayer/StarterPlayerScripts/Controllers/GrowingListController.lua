--credit to quartz games studio
local t = {
	StartOrder = 5
}
local MenuOpenClose = game.SoundService.SFX.MenuOpenClose
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local DevProductController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController)
local GrowRateData = require(game.ReplicatedStorage.SharedModules.GrowRateData)
local Notification = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GrowingList"):WaitForChild("Exit"):WaitForChild("ExitButton"):WaitForChild("Notification")

local function profileBegin(p1) --[[ profileBegin | Line: 31 ]]
	debug.profilebegin("Controllers/GrowingListController/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 35 ]]
	debug.profileend()
end

local v3 = UDim2.new(1, -5, 0.475, 0)
local v4 = UDim2.new(-0.03, 0, 0.475, 0)
local v5 = UDim2.new(1.265, 0, 0.475, 0)
local v6 = UDim2.new(1, 0, 0.475, 0)
local v7 = nil
local v8 = nil
local Plants = ReplicatedStorage:WaitForChild("PlantGenerationModules"):WaitForChild("Plants")
local t2 = {}

local function GetModuleGrowRate(p1) --[[ GetModuleGrowRate | Line: 54 | Upvalues: t2 (copy), Plants (copy) ]]
	if p1 == nil then
		return nil
	end

	local v1 = t2[p1]

	if v1 ~= nil then
		return v1
	end

	local v2 = Plants:FindFirstChild(p1)

	if not v2 then
		return nil
	end

	local ok, result = pcall(require, v2)

	if not ok or type(result) ~= "table" then
		return nil
	end

	local GrowData = result.GrowData

	if type(GrowData) ~= "table" then
		return nil
	end

	local GrowRate = GrowData.GrowRate

	if type(GrowRate) == "number" then
		t2[p1] = GrowRate

		return GrowRate
	end

	return nil
end

local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local t3 = {}
local t4 = {}
local t5 = {}
local v13 = 0
local v14 = false
local GuiController = require(script.Parent.GuiController)

local function FormatTimeRemaining(p1) --[[ FormatTimeRemaining | Line: 93 ]]
	if p1 <= 0 then
		return "Done!"
	end

	local v1 = math.ceil(p1)
	local v2 = math.floor(v1 / 3600)
	local v3 = math.floor(v1 % 3600 / 60)
	local v4 = v1 % 60

	if v2 > 0 then
		return string.format("%dh %dm", v2, v3)
	end

	if v3 > 0 then
		return string.format("%dm %ds", v3, v4)
	end

	return string.format("%ds", v4)
end

local function CalculateTimeRemaining(p1) --[[ CalculateTimeRemaining | Line: 114 ]]
	if p1.StableGrowthAmount <= 0 then
		return 999999
	end

	return (p1.MaxAge - p1.CurrentAge) / p1.StableGrowthAmount
end

local function PlayCompletionEffect(p1) --[[ PlayCompletionEffect | Line: 123 | Upvalues: t3 (copy), t5 (copy), v14 (ref), t4 (copy), v9 (ref), TweenService (copy), v2 (copy), Debris (copy) ]]
	local v1 = t3[p1]

	if not v1 or t5[p1] then
		return
	end

	if v14 then
		t5[p1] = true
		v1.Main_Frame.ProgressBar.TextLabel.Text = "Done!"

		local Frame = v1.Main_Frame.ProgressBar.Frame

		Frame.Size = UDim2.new(1, 0, Frame.Size.Y.Scale, Frame.Size.Y.Offset)

		local Main_Frame = v1.Main_Frame
		local AbsolutePosition = Main_Frame.AbsolutePosition
		local AbsoluteSize = Main_Frame.AbsoluteSize
		local CompletionFlash = Instance.new("Frame")

		CompletionFlash.Name = "CompletionFlash"
		CompletionFlash.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
		CompletionFlash.BackgroundTransparency = 0
		CompletionFlash.BorderSizePixel = 0
		CompletionFlash.ZIndex = Main_Frame.ZIndex + 10
		CompletionFlash.AnchorPoint = Vector2.new(0.5, 0.5)
		CompletionFlash.Position = UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2)
		CompletionFlash.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
		CompletionFlash.Parent = v9

		local v3 = TweenService:Create(CompletionFlash, v2, {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(AbsoluteSize.X * 1.5, AbsoluteSize.Y)
		})

		v3:Play()
		Debris:AddItem(v3, v2.Time)
		task.delay(0.2, function() --[[ Line: 175 | Upvalues: CompletionFlash (copy) ]]
			if not (CompletionFlash and CompletionFlash.Parent) then
				return
			end

			CompletionFlash:Destroy()
		end)
		task.delay(2, function() --[[ Line: 182 | Upvalues: v1 (copy), t3 (ref), p1 (copy), t4 (ref), t5 (ref) ]]
			if not (v1 and v1.Parent) then
				t3[p1] = nil
				t4[p1] = nil
				t5[p1] = nil

				return
			end

			v1:Destroy()
			t3[p1] = nil
			t4[p1] = nil
			t5[p1] = nil
		end)

		return
	end

	if v1 and v1.Parent then
		v1:Destroy()
	end

	t3[p1] = nil
	t4[p1] = nil
end

local function UpdateCanvasSize() --[[ UpdateCanvasSize | Line: 194 | Upvalues: v10 (ref) ]]
	v10.CanvasSize = UDim2.new(0, 0, 0, v10.UIListLayout.AbsoluteContentSize.Y)
end

v9 = PlayerGui:WaitForChild("GrowingList")

local Frame = v9:WaitForChild("Frame")

v10 = Frame:WaitForChild("Notepad"):WaitForChild("ScrollingFrame")

local v15 = #v10:GetChildren()

function UpdateScrollingFrame() --[[ UpdateScrollingFrame | Line: 203 | Upvalues: v10 (ref), v15 (copy), v14 (ref), Notification (copy) ]]
	local v1 = #v10:GetChildren() - v15

	if v1 > 0 and v14 == false then
		Notification.Visible = true
		Notification.InletTexture.TextLabel.TextLabel.Text = tostring(v1)
		Notification.InletTexture.TextLabel.Text = tostring(v1)
	else
		Notification.Visible = false
	end
end
v10.ChildAdded:Connect(function() --[[ Line: 214 ]]
	UpdateScrollingFrame()
end)
v10.ChildRemoved:Connect(function() --[[ Line: 218 ]]
	UpdateScrollingFrame()
end)

local function CreatePlantTemplate(p1, p2) --[[ CreatePlantTemplate | Line: 223 | Upvalues: t3 (copy), v13 (ref), v11 (ref), v8 (ref), GrowRateData (copy), t4 (copy), FormatTimeRemaining (copy), v10 (ref), Networking (copy), DevProductController (copy) ]]
	if (p2.Age or 0) >= (p2.MaxAge or 1) then
		return
	end

	if t3[p1] then
		return
	end

	v13 = v13 + 1

	local v1 = v11:Clone()

	v1.Name = p1
	v1.Visible = true
	v1.LayoutOrder = v13

	local PlantName = p2.PlantName
	local v2 = v8:FindFirstChild(PlantName)

	if v2 then
		v1.Main_Frame.PlantImage.Image = v2.Value
	end

	local v3 = p2.Age or 0
	local v4 = p2.MaxAge or 1
	local t = {
		LastDisplayedPercent = 0,
		CurrentAge = v3,
		MaxAge = v4,
		StableGrowthAmount = 1 -- MODDED: el server envejece 1/seg hasta MaxAge; sincroniza con el plot
	}

	t.PlantedAt = p2.PlantedAt or os.time()
	t.PlantName = PlantName
	t4[p1] = t

	local v82 = math.clamp(v3 / v4, 0, 1)
	local Frame = v1.Main_Frame.ProgressBar.Frame

	Frame.Size = UDim2.new(v82, 0, Frame.Size.Y.Scale, Frame.Size.Y.Offset)
	t4[p1].LastDisplayedPercent = v82

	local v9 = t4[p1]
	local v112 = if v9.StableGrowthAmount <= 0 then 999999 else (v9.MaxAge - v9.CurrentAge) / v9.StableGrowthAmount

	v1.Main_Frame.ProgressBar.TextLabel.Text = FormatTimeRemaining(v112)
	v1.LayoutOrder = v112
	v1.Parent = v10
	t3[p1] = v1
	v1.Main_Frame.BevelEffect.GrowButton.MouseButton1Click:Connect(function() --[[ Line: 286 | Upvalues: Networking (ref), p1 (copy), DevProductController (ref) ]]
		Networking.GrowPlant:Fire(p1)
		DevProductController:PromptPurchase("Standalone:Grow Plant:1")
	end)
	v10.CanvasSize = UDim2.new(0, 0, 0, v10.UIListLayout.AbsoluteContentSize.Y)
end

local function RemovePlantTemplate(p1) --[[ RemovePlantTemplate | Line: 302 | Upvalues: t3 (copy), t5 (copy), t4 (copy), v10 (ref) ]]
	local v1 = t3[p1]

	if not v1 or t5[p1] then
		v10.CanvasSize = UDim2.new(0, 0, 0, v10.UIListLayout.AbsoluteContentSize.Y)

		return
	end

	local v2 = t4[p1]

	if v2 and v2.ProgressTween then
		v2.ProgressTween:Cancel()
		v2.ProgressTween:Destroy()
		v2.ProgressTween = nil
	end

	v1:Destroy()
	t3[p1] = nil
	t4[p1] = nil
	v10.CanvasSize = UDim2.new(0, 0, 0, v10.UIListLayout.AbsoluteContentSize.Y)
end

local function UpdatePlantTemplate(p1) --[[ UpdatePlantTemplate | Line: 324 | Upvalues: t3 (copy), t4 (copy), t5 (copy), PlayCompletionEffect (copy), TweenService (copy), v1 (copy), FormatTimeRemaining (copy) ]]
	local v12 = t3[p1]
	local v2 = t4[p1]

	if not (v12 and v2) then
		return
	end

	if t5[p1] then
		return
	end

	local v4 = math.clamp(v2.CurrentAge / v2.MaxAge, 0, 1)

	if v4 >= 1 then
		PlayCompletionEffect(p1)

		return
	end

	if math.abs(v4 - (v2.LastDisplayedPercent or 0)) > 0.001 then
		local Frame = v12.Main_Frame.ProgressBar.Frame
		local v6 = UDim2.new(v4, 0, Frame.Size.Y.Scale, Frame.Size.Y.Offset)

		if (v2.LastDisplayedPercent or 0) < v4 then
			local ProgressTween = v2.ProgressTween

			if ProgressTween then
				ProgressTween:Cancel()
				ProgressTween:Destroy()
			end

			local v7 = TweenService:Create(Frame, v1, {
				Size = v6
			})

			v2.ProgressTween = v7
			v7.Completed:Once(function() --[[ Line: 360 | Upvalues: v2 (copy), v7 (copy) ]]
				if v2.ProgressTween ~= v7 then
					v7:Destroy()

					return
				end

				v2.ProgressTween = nil
				v7:Destroy()
			end)
			v7:Play()
		else
			local ProgressTween = v2.ProgressTween

			if ProgressTween then
				ProgressTween:Cancel()
				ProgressTween:Destroy()
				v2.ProgressTween = nil
			end

			Frame.Size = v6
		end

		v2.LastDisplayedPercent = v4
	end

	local v9 = if v2.StableGrowthAmount <= 0 then 999999 else (v2.MaxAge - v2.CurrentAge) / v2.StableGrowthAmount

	v12.Main_Frame.ProgressBar.TextLabel.Text = FormatTimeRemaining(v9)
	v12.LayoutOrder = v9
end

local function UpdateGrowthRate(p1, p2, p3) --[[ UpdateGrowthRate | Line: 388 | Upvalues: t4 (copy), t5 (copy) ]]
	if not t4[p1] or t5[p1] then
		return
	end

	if math.abs(p2 - t4[p1].CurrentAge) > 0.5 or p3 <= 0 then
		t4[p1].CurrentAge = p2
	end

	t4[p1].StableGrowthAmount = 1 -- MODDED: 1/seg (ver CreatePlantTemplate)
end

local function UpdateList() --[[ UpdateList | Line: 404 | Upvalues: v14 (ref), Frame (ref), v3 (copy), v12 (ref), v4 (copy), v5 (copy), v6 (copy) ]]
	if v14 then
		Frame.Position = v5
		v12.Position = v6
		v12.TextLabel.Text = "<"
		v12.TextLabel.TextLabel.Text = "<"
	else
		Frame.Position = v3
		v12.Position = v4
		v12.TextLabel.Text = ">"
		v12.TextLabel.TextLabel.Text = ">"
	end
end

local function ToggleList() --[[ ToggleList | Line: 419 | Upvalues: v14 (ref), Frame (ref), v3 (copy), v12 (ref), v4 (copy), v5 (copy), v6 (copy) ]]
	if v14 then
		Frame.Position = v5
		v12.Position = v6
		v12.TextLabel.Text = "<"
		v12.TextLabel.TextLabel.Text = "<"
	else
		Frame.Position = v3
		v12.Position = v4
		v12.TextLabel.Text = ">"
		v12.TextLabel.TextLabel.Text = ">"
	end

	v14 = not v14
	UpdateScrollingFrame()
end

local function LoadExistingPlants() --[[ LoadExistingPlants | Line: 428 | Upvalues: v7 (ref), LocalPlayer (copy), CreatePlantTemplate (copy) ]]
	local t = {}

	for v1, v2 in v7:GetGarden(LocalPlayer.UserId) do
		if (v2.Age or 0) < (v2.MaxAge or 1) then
			table.insert(t, {
				Id = v1,
				Data = v2
			})
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 441 ]]
		return (p1.Data.PlantedAt or 0) < (p2.Data.PlantedAt or 0)
	end)

	for v3, v4 in t do
		CreatePlantTemplate(v4.Id, v4.Data)
	end
end

function t.Init(p1) --[[ Init | Line: 450 | Upvalues: v7 (ref), LocalPlayer (copy), v8 (ref), ReplicatedStorage (copy), v9 (ref), PlayerGui (copy), Frame (ref), v10 (ref), v11 (ref), v12 (ref), v14 (ref), v5 (copy), v6 (copy) ]]
	v7 = require(LocalPlayer.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GardenSyncController"))
	v8 = ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("SeedData"):WaitForChild("FruitImages")
	v9 = PlayerGui:WaitForChild("GrowingList")
	Frame = v9:WaitForChild("Frame")
	v10 = Frame:WaitForChild("Notepad"):WaitForChild("ScrollingFrame")
	v11 = v10:WaitForChild("Template")
	v12 = v9:WaitForChild("Exit"):WaitForChild("ExitButton")
	v11.Visible = false
	v10.CanvasSize = UDim2.new(0, 0, 0, v10.UIListLayout.AbsoluteContentSize.Y)
	v14 = false
	Frame.Position = v5
	v12.Position = v6
	v12.TextLabel.Text = "<"
	v12.TextLabel.TextLabel.Text = "<"
	UpdateScrollingFrame()
end
function t.Start(p1) --[[ Start | Line: 478 | Upvalues: v7 (ref), LocalPlayer (copy), CreatePlantTemplate (copy), RemovePlantTemplate (copy), t4 (copy), t5 (copy), RunService (copy), UpdatePlantTemplate (copy), GuiController (copy), v12 (ref), MenuOpenClose (copy), v14 (ref), Frame (ref), v3 (copy), v4 (copy), v5 (copy), v6 (copy), Players (copy), LoadExistingPlants (copy) ]]
	v7:OnPlantAdded(function(p1, p2, p3) --[[ Line: 480 | Upvalues: LocalPlayer (ref), CreatePlantTemplate (ref) ]]
		if p1 ~= LocalPlayer.UserId then
			return
		end

		CreatePlantTemplate(p2, p3)
	end)
	v7:OnPlantRemoved(function(p1, p2) --[[ Line: 487 | Upvalues: LocalPlayer (ref), RemovePlantTemplate (ref) ]]
		if p1 ~= LocalPlayer.UserId then
			return
		end

		RemovePlantTemplate(p2)
	end)
	v7:OnPlantGrowthUpdated(function(p1, p2, p3, p4) --[[ Line: 494 | Upvalues: LocalPlayer (ref), t4 (ref), t5 (ref) ]]
		if p1 ~= LocalPlayer.UserId or (not t4[p2] or t5[p2]) then
			return
		end

		if math.abs(p3 - t4[p2].CurrentAge) > 0.5 or p4 <= 0 then
			t4[p2].CurrentAge = p3
		end

		t4[p2].StableGrowthAmount = 1 -- MODDED: 1/seg (ver CreatePlantTemplate)
	end)
	v7:OnPlantAgeSync(function(p1, p2) --[[ Line: 501 | Upvalues: LocalPlayer (ref), t4 (ref), t5 (ref) ]]
		if p1 ~= LocalPlayer.UserId then
			return
		end

		for v1, v2 in p2 do
			if t4[v1] and (not t5[v1] and t4[v1].CurrentAge < v2) then
				t4[v1].CurrentAge = v2
			end
		end
	end)

	local v1 = 0

	RunService.Heartbeat:Connect(function(p1) --[[ Line: 517 | Upvalues: v1 (ref), t4 (ref), t5 (ref) ]]
		v1 = v1 + p1

		if v1 < 0.25 then
			return
		end

		local v12 = v1

		v1 = 0
		debug.profilebegin("Controllers/GrowingListController/Heartbeat/simulatePlantGrowth")

		for v2, v3 in t4 do
			if not t5[v2] and v3.CurrentAge < v3.MaxAge then
				v3.CurrentAge = math.min(v3.CurrentAge + v12 * v3.StableGrowthAmount, v3.MaxAge)
			end
		end

		debug.profileend()
	end)
	task.spawn(function() --[[ Line: 534 | Upvalues: t4 (ref), UpdatePlantTemplate (ref) ]]
		while true do
			task.wait(1)
			debug.profilebegin("Controllers/GrowingListController/UI/UpdateAllPlantTemplates")

			local v1 = (1 / 0)

			for v2 in t4 do
				local v3 = t4[v2]
				local v5 = if v3.StableGrowthAmount <= 0 then 999999 else (v3.MaxAge - v3.CurrentAge) / v3.StableGrowthAmount

				if v5 <= v1 then
					v1 = v5
				end

				UpdatePlantTemplate(v2)
			end

			debug.profileend()
		end
	end)
	GuiController:Hook("Click", v12).Clicked:Connect(function() --[[ Line: 560 | Upvalues: MenuOpenClose (ref), v14 (ref), Frame (ref), v3 (ref), v12 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
		MenuOpenClose.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		MenuOpenClose.TimePosition = 0
		MenuOpenClose.Playing = true

		if v14 then
			Frame.Position = v5
			v12.Position = v6
			v12.TextLabel.Text = "<"
			v12.TextLabel.TextLabel.Text = "<"
		else
			Frame.Position = v3
			v12.Position = v4
			v12.TextLabel.Text = ">"
			v12.TextLabel.TextLabel.Text = ">"
		end

		v14 = not v14
		UpdateScrollingFrame()
	end)
	task.spawn(function() --[[ Line: 577 | Upvalues: LocalPlayer (ref), Players (ref), LoadExistingPlants (ref) ]]
		repeat
			task.wait()
		until LocalPlayer:HasTag("DataLoaded") or not LocalPlayer:IsDescendantOf(Players)

		if LocalPlayer:IsDescendantOf(Players) then
			task.wait(0.5)
			LoadExistingPlants()
		end
	end)
end

return t