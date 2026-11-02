--credit to prince games studio
local SharedModules = game.ReplicatedStorage.SharedModules
local CrateData = SharedModules.CrateData
local PropImages = SharedModules.PropImages
local v1 = script.Parent
local ScrollingFrame = v1.Parent:WaitForChild("ScrollingFrame")
local Template = ScrollingFrame:WaitForChild("Template")
local GrandTemplate = ScrollingFrame:WaitForChild("GrandTemplate")
local FenceImages = game.ReplicatedStorage.SharedModules.FenceImages

local function FormatChance(p1, p2) --[[ FormatChance | Line: 10 ]]
	return tostring(math.floor(p1 / p2 * 100 * 100 + 0.5) / 100) .. "%"
end

function UPD() --[[ UPD | Line: 17 | Upvalues: ScrollingFrame (copy), CrateData (copy), v1 (copy), PropImages (copy), FenceImages (copy), GrandTemplate (copy), Template (copy) ]]
	for k, v in pairs(ScrollingFrame:GetChildren()) do
		if v.Name == "TempFrame" then
			v:Destroy()
		end
	end

	local v12 = CrateData:FindFirstChild(v1.Value)

	if not v12 then
		return
	end

	local v2 = require(v12)

	if not v2 then
		return
	end

	local sum = 0

	for k, v in pairs(v2.Items) do
		sum = sum + v.Chance
	end

	local v3 = (1 / 0)
	local v4 = nil

	for k, v in pairs(v2.Items) do
		if v.Chance < v3 then
			v3 = v.Chance
			v4 = v
		end
	end

	local tbl = {}

	for k, v in pairs(v2.Items) do
		if v.Name ~= v4.Name then
			table.insert(tbl, v)
		end
	end

	if not v4 then
		return
	end

	local v5 = PropImages:FindFirstChild(v4.Name)

	if v5 == nil then
		v5 = FenceImages:FindFirstChild(v4.Name)
	end

	if not v5 then
		return
	end

	local TempFrame = GrandTemplate:Clone()

	TempFrame.Parent = ScrollingFrame
	TempFrame.Visible = true
	TempFrame.Cell.Vector.Image = v5.Value
	TempFrame.Cell.Odds.Text = tostring(math.floor(v4.Chance / sum * 100 * 100 + 0.5) / 100) .. "%"
	TempFrame.Cell.ItemName.Text = v4.Name
	TempFrame.Name = "TempFrame"
	TempFrame.Parent = ScrollingFrame
	TempFrame.LayoutOrder = 1000

	for k, v in pairs(tbl) do
		local v9 = PropImages:FindFirstChild(v.Name)

		if v9 == nil then
			v9 = FenceImages:FindFirstChild(v.Name)
		end

		local TempFrame2 = Template:Clone()

		TempFrame2.Parent = ScrollingFrame
		TempFrame2.Visible = true
		TempFrame2.Cell.Vector.Image = v9.Value
		TempFrame2.Cell.Odds.Text = tostring(math.floor(v.Chance / sum * 100 * 100 + 0.5) / 100) .. "%"
		TempFrame2.Cell.ItemName.Text = v.Name
		TempFrame2.Name = "TempFrame"
		TempFrame2.Parent = ScrollingFrame
		TempFrame2.LayoutOrder = -v.Chance * 100
	end
end
v1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 84 | Upvalues: v1 (copy) ]]
	if v1.Value == "" then
		return
	end

	UPD()
end)