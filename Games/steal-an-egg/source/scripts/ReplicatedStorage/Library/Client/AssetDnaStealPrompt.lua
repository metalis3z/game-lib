-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local AssetGenderUtil = require(ReplicatedStorage.Library.Util.AssetGenderUtil)
local AssetIconShape = require(ReplicatedStorage.Library.Client.UI.AssetIconShape)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local AssetItemUtil = require(ReplicatedStorage.Library.Util.AssetItemUtil)
local GetOrCreateUIScale = require(ReplicatedStorage.Library.Functions.GetOrCreateUIScale)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local v1 = Color3.fromRGB(48, 255, 105)
local v2 = UDim2.fromScale(0, 0.055)
local v3 = table.freeze({ -1, 1, -1, 1, -1, 0 })
local v4 = Log.new()
local v5 = Random.new()
local v6 = false
local v7 = GUI.Get("StealDnaMessage")

assert(v7:IsA("ScreenGui"), "PlayerGui.StealDnaMessage must be a ScreenGui")

local Frame = v7.Frame

assert(Frame:IsA("Frame"), "StealDnaMessage.Frame must be a Frame")

local Contents = Frame.Contents

assert(Contents:IsA("Frame"), "StealDnaMessage.Frame.Contents must be a Frame")

local Desc = Contents.Desc

assert(Desc:IsA("TextLabel"), "StealDnaMessage Contents.Desc must be a TextLabel")

local AssetIcon = Contents.AssetIcon

assert(AssetIcon:IsA("ImageLabel"), "StealDnaMessage Contents.AssetIcon must be an ImageLabel")

local Position = AssetIcon.Position
local Rotation = AssetIcon.Rotation
local ColorBG = AssetIcon.ColorBG

assert(ColorBG:IsA("GuiObject"), "StealDnaMessage AssetIcon.ColorBG must be a GuiObject")

local StealButton = Contents.StealButton

assert(StealButton:IsA("GuiObject"), "StealDnaMessage Contents.StealButton must be a GuiObject")

local TextLabel = StealButton.TextLabel

assert(TextLabel:IsA("TextLabel"), "StealButton.TextLabel must be a TextLabel")

local v16 = GetOrCreateUIScale(TextLabel)
local TextColor3 = TextLabel.TextColor3
local Scale = v16.Scale
local Stats1 = Contents.Stats1

assert(Stats1:IsA("GuiObject"), "StealDnaMessage Contents.Stats1 must be a GuiObject")

local Text = Stats1.Rarity.Text

assert(Text:IsA("TextLabel"), "Stats1.Rarity.Text must be a TextLabel")

local Text2 = Stats1.Weight.Text

assert(Text2:IsA("TextLabel"), "Stats1.Weight.Text must be a TextLabel")

local Text3 = Stats1.Money.Text

assert(Text3:IsA("TextLabel"), "Stats1.Money.Text must be a TextLabel")

local Stats2 = Contents.Stats2

assert(Stats2:IsA("GuiObject"), "StealDnaMessage Contents.Stats2 must be a GuiObject")
assert(Stats2.Gender.Text:IsA("TextLabel"), "Stats2.Gender.Text must be a TextLabel")

local Image = Stats2.Gender.Image

assert(Image:IsA("ImageLabel"), "Stats2.Gender.Image must be an ImageLabel")

local Text4 = Stats2.Personality.Text

assert(Text4:IsA("TextLabel"), "Stats2.Personality.Text must be a TextLabel")

local Mutations2 = Stats2.Mutations

assert(Mutations2:IsA("GuiObject"), "Stats2.Mutations must be a GuiObject")

local Mutations3 = Mutations2.Mutations

assert(Mutations3:IsA("GuiObject"), "Stats2.Mutations.Mutations must be a GuiObject")

local Template = Mutations3.Template

assert(Template:IsA("ImageLabel"), "Mutation icon Template must be an ImageLabel")

local t = {
	_collectMutationNames = function(p1) --[[ _collectMutationNames | Line: 98 ]]
		local t = {}
		local t2 = {}

		local function include(p1) --[[ include | Line: 102 | Upvalues: t2 (copy), t (copy) ]]
			if p1 ~= nil and (p1 ~= "" and (p1 ~= "None" and not t2[p1])) then
				t2[p1] = true
				table.insert(t, p1)
			end
		end

		local BaseMutation = p1.BaseMutation

		if BaseMutation ~= nil and (BaseMutation ~= "" and (BaseMutation ~= "None" and not t2[BaseMutation])) then
			t2[BaseMutation] = true
			table.insert(t, BaseMutation)
		end

		for i, v in ipairs(p1.Mutations) do
			if v ~= nil and (v ~= "" and v ~= "None") and not t2[v] then
				t2[v] = true
				table.insert(t, v)
			end
		end

		return t
	end
}

function t._populateMutations(p1, p2) --[[ _populateMutations | Line: 119 | Upvalues: Template (copy), t (copy), Mutations2 (copy), Mutations (copy), Mutations3 (copy) ]]
	Template.Visible = false

	local v1 = t._collectMutationNames(p2)

	Mutations2.Visible = if #v1 > 0 then true else false

	for i, v in ipairs(v1) do
		local Icon = assert(Mutations.GetMutation(v), (("Unknown mutation \"%*\""):format(v))).Icon

		if Icon ~= nil and Icon ~= 0 then
			local v6 = Template:Clone()

			v6.Name = v
			v6.Image = ("rbxassetid://%*"):format(Icon)
			v6.Visible = true
			v6.Parent = Mutations3
			p1:Add(v6)
		end
	end
end
function t._populate(p1, p2, p3) --[[ _populate | Line: 140 | Upvalues: Assets (copy), Desc (copy), Text (copy), Text2 (copy), AssetItemUtil (copy), Simple (copy), AssetGenerationUtil (copy), Text3 (copy), AssetGenderUtil (copy), Image (copy), Text4 (copy), AssetIconShape (copy), AssetIcon (copy), AssetColorUtil (copy), ColorBG (copy), t (copy) ]]
	local v1 = Assets.Directory[p2.Category]

	assert(if v1 == nil then false else true, (("Unknown asset category \"%*\""):format(p2.Category)))

	local v4 = if p3 then ("%* "):format(p3) else ""

	Desc.RichText = true
	Desc.Text = ("You\226\128\153ll get a %*<font color=\"#%*\">%*</font> copy:"):format(v4, v1.Rarity.Color:ToHex(), v1.Egg.DisplayName)
	Text.Text = v1.Rarity.DisplayName
	Text.TextColor3 = v1.Rarity.Color
	Text2.Text = AssetItemUtil.GetVisualWeightKgDisplay(p2):gsub("Kg$", "kg")
	Text3.Text = ("$%*"):format((Simple.FormatCompact(AssetGenerationUtil.GetBaseRateMutationOnly(p2), "precision-integer")))

	local v5 = AssetGenderUtil.ResolveForCategory(p2.Category, p2.Gender)

	assert(if v5 == "Male" then true elseif v5 == "Female" then true else false, (("Invalid asset gender \"%*\""):format(v5)))
	Image.Image = if v5 == "Male" then AssetGenderUtil.GetIcon("Male") else AssetGenderUtil.GetIcon("Female")
	Text4.Text = p2.Personality
	AssetIconShape.Apply(AssetIcon, p2)

	local v11 = AssetColorUtil.ResolveModelColor(p2.Category, AssetColorUtil.ResolveFields(p2.Category, p2.EyeColor, p2.ColorSeed, p2.ColorIndex).ColorIndex)

	ColorBG.Visible = if v11 == nil then false else true

	if v11 == nil then
		t._populateMutations(p1, p2)

		return
	end

	ColorBG.BackgroundColor3 = v11
	t._populateMutations(p1, p2)
end
function t._startStealAnimation(p1, p2) --[[ _startStealAnimation | Line: 175 | Upvalues: TextLabel (copy), TextColor3 (copy), v16 (copy), Scale (copy), Tween (copy), v1 (copy) ]]
	TextLabel.TextColor3 = TextColor3
	v16.Scale = Scale
	p1:Add(function() --[[ Line: 178 | Upvalues: TextLabel (ref), TextColor3 (ref), v16 (ref), Scale (ref) ]]
		TextLabel.TextColor3 = TextColor3
		v16.Scale = Scale
	end)
	p1:Add(task.spawn(function() --[[ Line: 183 | Upvalues: p2 (copy), TextLabel (ref), TextColor3 (ref), v16 (ref), Scale (ref), Tween (ref), v1 (ref), p1 (copy) ]]
		while p2() do
			TextLabel.TextColor3 = TextColor3
			v16.Scale = Scale

			local v12 = Tween(TextLabel, {
				TextColor3 = v1
			}, { 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
			local v2 = Tween(v16, {
				Scale = Scale * 1.3
			}, { 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

			p1:Add(v12)
			p1:Add(v2)
			v2.Completed:Wait()

			if not p2() then
				break
			end

			local v3 = Tween(TextLabel, {
				TextColor3 = TextColor3
			}, { 0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })
			local v4 = Tween(v16, {
				Scale = Scale
			}, { 0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })

			p1:Add(v3)
			p1:Add(v4)
			v4.Completed:Wait()
			TextLabel.TextColor3 = TextColor3
			v16.Scale = Scale
		end
	end))
end
function t._startIconAnimation(p1, p2) --[[ _startIconAnimation | Line: 223 | Upvalues: AssetIcon (copy), Position (copy), Rotation (copy), v5 (copy), v2 (copy), Tween (copy), v3 (copy) ]]
	AssetIcon.Position = Position
	AssetIcon.Rotation = Rotation
	p1:Add(function() --[[ Line: 226 | Upvalues: AssetIcon (ref), Position (ref), Rotation (ref) ]]
		AssetIcon.Position = Position
		AssetIcon.Rotation = Rotation
	end)
	p1:Add(task.spawn(function() --[[ Line: 231 | Upvalues: p2 (copy), AssetIcon (ref), Position (ref), Rotation (ref), v5 (ref), v2 (ref), Tween (ref), p1 (copy), v3 (ref) ]]
		while p2() do
			AssetIcon.Position = Position
			AssetIcon.Rotation = Rotation

			local v1 = v5:NextNumber(1, 3)
			local v22 = Tween(AssetIcon, {
				Position = Position - v2
			}, { v1 * 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

			p1:Add(v22)
			v22.Completed:Wait()

			if not p2() then
				break
			end

			local v32 = v1 * 0.3 / #v3

			for i, v in ipairs(v3) do
				local v4 = Tween(AssetIcon, {
					Rotation = Rotation + 12 * v
				}, { v32, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut })

				p1:Add(v4)
				v4.Completed:Wait()

				if not p2() then
					break
				end
			end

			if not p2() then
				break
			end

			local v52 = Tween(AssetIcon, {
				Position = Position
			}, { v1 * 0.45, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out })

			p1:Add(v52)
			v52.Completed:Wait()
			AssetIcon.Position = Position
			AssetIcon.Rotation = Rotation
		end
	end))
end
function t.Prompt(p1, p2) --[[ Prompt | Line: 282 | Upvalues: AssetItem (copy), Asserts (copy), v6 (ref), TabController (copy), Trove (copy), Signal (copy), t (copy), ButtonFX (copy), StealButton (copy), v4 (copy) ]]
	assert(AssetItem.AssetItemData(p1))

	if p2 ~= nil then
		Asserts.string(p2)
	end

	if v6 then
		return false
	end

	v6 = true

	local v1 = true
	local v2 = false
	local v3 = TabController.Get()
	local v42 = Trove.new()
	local v5 = v42:Add(Signal.new())

	t._populate(v42, p1, p2)
	v42:Add(ButtonFX(StealButton, nil, function() --[[ Line: 299 | Upvalues: v1 (ref), v2 (ref), TabController (ref), v5 (copy) ]]
		if v1 then
			v1 = false
			v2 = true
			TabController.CloseTab(true)
			v5:Fire()
		end
	end))
	v42:Add(TabController.Closed:Connect(function(p1) --[[ Line: 309 | Upvalues: v1 (ref), v5 (copy) ]]
		if not v1 or p1 ~= "StealDnaMessage" then
			return
		end

		v1 = false
		v5:Fire()
	end))

	if not TabController.OpenTab("StealDnaMessage") then
		v4:AtWarning():Log("Steal DNA confirmation tab could not open")
		v1 = false
		v42:Destroy()
		v6 = false

		return false
	end

	t._startStealAnimation(v42, function() --[[ Line: 324 | Upvalues: v1 (ref) ]]
		return v1
	end)
	t._startIconAnimation(v42, function() --[[ Line: 327 | Upvalues: v1 (ref) ]]
		return v1
	end)
	v5:Wait()
	v42:Destroy()
	v6 = false

	if v2 or v3 == nil then
		return v2
	end

	TabController.OpenTab(v3, true)

	return v2
end

return t