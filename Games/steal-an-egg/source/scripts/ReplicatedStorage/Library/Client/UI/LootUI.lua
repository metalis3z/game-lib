-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	ARROW_DIRECTION = {
		Down = 1,
		Left = 2,
		Right = 3
	}
}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InfoOverlay = require(ReplicatedStorage:WaitForChild("Library").Client.InfoOverlay)
local Rainbow = require(ReplicatedStorage:WaitForChild("Library").Client.GUIFX.Rainbow)
local DropTable = require(ReplicatedStorage:WaitForChild("Library").DropTable)
local Functions = require(ReplicatedStorage:WaitForChild("Library").Functions)
local ItemUI = require(ReplicatedStorage:WaitForChild("Library").Client.UI.ItemUI)
local DropInfo = ReplicatedStorage.Assets.UI.DropTable.DropInfo
local Render = ReplicatedStorage.Assets.UI.DropTable.Render
local t2 = {
	Comparator = nil,
	Distance = 20,
	Scale = 1,
	PageTurnLength = 5,
	ShowRolls = true,
	ShowPageNumbers = true,
	Title = "Display!",
	HeightOffset = 5,
	SurgeNumber = nil,
	ArrowDirection = t.ARROW_DIRECTION.Down
}
local t3 = {}
local v1 = tick()

local function RenderPage(p1, p2, p3) --[[ RenderPage | Line: 83 | Upvalues: Functions (copy), RunService (copy), Render (copy), Rainbow (copy), ItemUI (copy) ]]
	local Billboard = p1.Billboard

	assert(Billboard, "Billboard not found")

	local Container = Billboard.Frame.Items.Container

	local function clearContainer() --[[ clearContainer | Line: 88 | Upvalues: Container (copy) ]]
		for i, v in ipairs(Container:GetChildren()) do
			if v:IsA("GuiObject") then
				v:Destroy()
			end
		end
	end

	if not p3 then
		p1.TweeningPage = true
		Functions.Tween(Container, {
			Position = UDim2.new(-1, 0, 0, 0)
		}, { 0.125, "Quad", "Out" }).Completed:Connect(function() --[[ Line: 99 | Upvalues: p1 (copy) ]]
			p1.TweeningPage = false
		end)

		while p1.TweeningPage do
			RunService.RenderStepped:Wait()
		end

		if not p1.Billboard then
			return
		end
	end

	clearContainer()

	local list = {}

	for i = (p2 - 1) * 9 + 1, math.min(p2 * 9, #p1.DropProbability) do
		table.insert(list, p1.DropProbability[i])
	end

	for i, v in ipairs(list) do
		local v3
		local v4 = v.Probability * 100
		local MinAmount = v.MinAmount
		local MaxAmount = v.MaxAmount

		v3 = if MinAmount == MaxAmount then Functions.NumberShorten(MinAmount) elseif MinAmount < 1 then ("%*"):format(Functions.NumberShorten(MaxAmount)) else ("%* - %*"):format(Functions.NumberShorten(MinAmount), Functions.NumberShorten(MaxAmount))

		local v8 = Render:Clone()

		v8.Holder:ClearAllChildren()
		v8.LayoutOrder = i

		if v4 < 0.1 then
			v8.Chance.Text = "??"
			Rainbow(v8.Chance, "TextColor3")
		else
			local v10 = math.clamp(math.pow(0.9315, v4) * 94.2467 / 100, 0, 1)
			local v11, v12, v13 = Color3.fromRGB(49, 255, 39):Lerp(Color3.fromRGB(255, 75, 39), v10):ToHSV()

			v8.Chance.TextColor3 = Color3.fromHSV(v11, v12, v13 * 2)
			v8.Chance.Text = ("%*%%"):format(Functions.FormatFigures(v4, 3, 5))
		end

		local t = {
			NoActionMenu = true,
			NoButtonFX = true,
			HideQuantity = true,
			ShowCurrencyBag = true,
			HideLevel = true
		}

		t.QuantityOverride = math.round(v.AvgAmount)

		local v15 = ItemUI.Create(v.ItemBase, t)

		v15.Selectable = false
		v15:SetAttribute("SurfaceElement", true)
		v15.Strength.Size = Functions.ScaleUDim2(v15.Strength.Size, 0.6666666666666666)

		local UIStroke = v15.Strength.UIStroke

		UIStroke.Thickness = UIStroke.Thickness * 0.6666666666666666
		v15.Strength.Text = v3
		v15.Strength.Visible = if v3 == "1" then false else true
		v15.Parent = v8.Holder
		v8.Parent = Container
	end

	local Rolls = p1.Rolls
	local v17

	if p1.Config.SurgeNumber then
		Rolls = Rolls * p1.Config.SurgeNumber
		v17 = "SURGE: "
	else
		v17 = ""
	end

	Billboard.Frame.Rolls.Text = ("%*%* Rolls!"):format(v17, Rolls)
	Billboard.Frame.PageNumber.Text = ("%*/%*"):format(p2, p1.NumberOfPages)
	p1.PageNumber = p2

	if p3 then
		Container.Position = UDim2.new()
	else
		Container.Position = UDim2.new(1, 0, 0, 0)
		p1.TweeningPage = true
		Functions.Tween(Container, {
			Position = UDim2.new(0, 0, 0, 0)
		}, { 0.125, "Quad", "Out" }).Completed:Connect(function() --[[ Line: 196 | Upvalues: p1 (copy) ]]
			p1.TweeningPage = false
		end)
	end
end

function t.Add(p1, p2, p3) --[[ Add | Line: 202 | Upvalues: t2 (copy), Functions (copy), DropTable (copy), t3 (copy) ]]
	assert(p1, "host must be provided")
	assert(p2, "dropTable must be provided")

	local v1 = p3 or {}

	for k, v in pairs(t2) do
		if v1[k] == nil then
			v1[k] = v
		end
	end

	assert(v1.Distance, "config.Distance is required")
	assert(if v1.ShowRolls == nil then false else true, "config.ShowRolls must be defined")
	assert(if v1.ShowPageNumbers == nil then false else true, "config.ShowPageNumbers must be defined")
	assert(v1.Title, "config.Title is required")
	assert(v1.Comparator, "config.Comparator is required")

	local v4 = nil
	local v5 = false

	if typeof(p1) == "Instance" then
		if p1:IsA("Model") then
			v4 = p1.PrimaryPart
			assert(v4, "Provided Model must have a PrimaryPart")
		elseif p1:IsA("BasePart") then
			v4 = p1
		else
			error("Unknown host type: " .. typeof(p1))
		end
	else
		assert(if typeof(p1) == "Vector3" then true elseif typeof(p1) == "CFrame" then true else false, "host must be an Instance, Vector3, or CFrame")
		v4 = Functions.CreateParticleHost(p1)
		v5 = true
	end

	local v7 = Functions.GenerateUID()
	local v8 = false
	local v9, v10

	if #p2.entries == 1 then
		local v11 = p2.entries[1]

		v9 = v11.Amount or 1
		v10 = DropTable.new({
			{
				Weight = 1,
				Value = v11.Value
			}
		})
	else
		v10 = p2
		v9 = 1
	end

	local v14 = table.clone((v10:GetDisplayTable()))

	table.sort(v14, function(p1, p2) --[[ Line: 256 | Upvalues: v1 (copy) ]]
		return v1.Comparator(p1.ItemBase, p1.Probability, p2.ItemBase, p2.Probability)
	end)
	t3[v7] = {
		PageNumber = 1,
		Config = v1,
		NumberOfPages = math.ceil(#v14 / 9),
		LastPageTurn = tick(),
		UID = v7,
		Billboard = nil,
		Showing = false,
		Tweening = false,
		TweeningPage = false,
		Host = v4,
		DropProbability = v14,
		OriginalDropTable = p2,
		Rolls = v9,
		DropTable = v10
	}

	local v15 = t3[v7]

	local function cleanup() --[[ cleanup | Line: 282 | Upvalues: v8 (ref), v15 (copy), v5 (ref), v4 (ref), t3 (ref), v7 (copy) ]]
		if v8 then
			return
		end

		v8 = true

		if v15.Billboard then
			v15.Billboard:Destroy()
		end

		if v5 then
			v4:Destroy()
		end

		t3[v7] = nil
	end

	if typeof(p1) == "Instance" then
		p1.Destroying:Connect(cleanup)
	end

	return cleanup
end
t.Comparators = {
	RaritySorted = function(p1, p2, p3, p4) --[[ RaritySorted | Line: 301 ]]
		local v1 = p1:GetRarity()
		local v2 = p3:GetRarity()

		if v1 == v2 then
			return p4 < p2
		end

		return v1.RarityNumber < v2.RarityNumber
	end,
	ReverseRaritySorted = function(p1, p2, p3, p4) --[[ ReverseRaritySorted | Line: 316 ]]
		local v1 = p1:GetRarity()
		local v2 = p3:GetRarity()

		if v1 == v2 then
			return p2 < p4
		end

		return v1.RarityNumber > v2.RarityNumber
	end,
	PercentSorted = function(p1, p2, p3, p4) --[[ PercentSorted | Line: 331 ]]
		return p4 < p2
	end,
	ClassSorted = function(p1, p2, p3, p4) --[[ ClassSorted | Line: 334 | Upvalues: t (copy) ]]
		local v1 = p1.Class.Name
		local v2 = p3.Class.Name

		p1:GetRarity()
		p3:GetRarity()

		if v1 == v2 then
			return t.Comparators.RaritySorted(p1, p2, p3, p4)
		end

		return v1 < v2
	end
}
t2.Comparator = t.Comparators.RaritySorted

local function UpdateArrowVisibility(p1, p2) --[[ UpdateArrowVisibility | Line: 348 | Upvalues: t (copy) ]]
	local tbl = {
		Left = p1.Frame.Pointer_Left,
		Right = p1.Frame.Pointer_Right,
		Down = p1.Frame.Pointer_Down
	}
	local v1 = p2 == t.ARROW_DIRECTION.Left and tbl.Left or (p2 == t.ARROW_DIRECTION.Right and tbl.Right or tbl.Down)

	for k, v in pairs(tbl) do
		v.Visible = v == v1
	end
end

RunService.RenderStepped:Connect(function() --[[ Line: 364 | Upvalues: InfoOverlay (copy), v1 (ref), t3 (copy), Functions (copy), DropInfo (copy), UpdateArrowVisibility (copy), RenderPage (copy) ]]
	local Character = game.Players.LocalPlayer.Character

	if not Character then
		return
	end

	if InfoOverlay.IsActive() then
		v1 = tick()
	end

	local Position = Character:GetPivot().Position

	for k, v in pairs(t3) do
		if not (v.Tweening or v.TweeningPage) then
			local Magnitude = (Position - v.Host.Position).Magnitude
			local Distance = v.Config.Distance
			local v12 = Distance + 4

			if v.Billboard or Distance <= Magnitude then
				if v.Billboard and v12 < Magnitude then
					v.Tweening = true
					Functions.Tween(v.Billboard, {
						Size = UDim2.new()
					}, { 0.15, "Expo", "Out" }).Completed:Connect(function() --[[ Line: 381 | Upvalues: v (copy) ]]
						v.Billboard:Destroy()
						v.Billboard = nil
						v.Tweening = false
					end)
				end
			else
				v.Tweening = true

				local v2 = DropInfo:Clone()

				UpdateArrowVisibility(v2, v.Config.ArrowDirection)

				local v3 = UDim2.new(v2.Size.X.Scale * v.Config.Scale, v2.Size.X.Offset, v2.Size.Y.Scale * v.Config.Scale, v2.Size.Y.Scale)

				v2.Adornee = v.Host
				v2.StudsOffset = Vector3.new(0, v.Config.HeightOffset, 0)
				v2.Size = UDim2.new()
				v2.Frame.Title.Text = v.Config.Title
				v2.Frame.Rolls.Visible = v.Config.ShowRolls and (if v.Rolls > 1 then true else false)
				v2.Frame.PageNumber.Visible = v.Config.ShowPageNumbers and (if v.NumberOfPages > 1 then true else false)
				v2.Parent = game.Players.LocalPlayer.PlayerGui
				v.Billboard = v2
				v.LastPageTurn = tick()
				task.spawn(RenderPage, v, 1, true)
				Functions.Tween(v2, {
					Size = v3
				}, { 0.15, "Back", "Out" }).Completed:Connect(function() --[[ Line: 416 | Upvalues: v (copy) ]]
					v.Tweening = false
				end)
			end

			if (if tick() - v.LastPageTurn > v.Config.PageTurnLength and tick() - v1 > 0.5 then v.Billboard and (not v.Tweening and not v.TweeningPage) else false) and v.NumberOfPages > 1 then
				task.spawn(RenderPage, v, if v.PageNumber >= v.NumberOfPages then 1 else v.PageNumber + 1)
				v.LastPageTurn = tick()
			end
		end
	end
end)

return t