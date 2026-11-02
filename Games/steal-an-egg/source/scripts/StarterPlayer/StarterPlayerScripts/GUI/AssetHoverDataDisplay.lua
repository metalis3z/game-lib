-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetGenderUtil = require(ReplicatedStorage.Library.Util.AssetGenderUtil)
local AssetItemUtil = require(ReplicatedStorage.Library.Util.AssetItemUtil)
local AssetRuntime = require(ReplicatedStorage.Library.Types.AssetRuntime)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local HoverHighlight = require(ReplicatedStorage.Library.Client.WorldFX.HoverHighlight)
local ModelMouseHover = require(ReplicatedStorage.Library.Client.UI.ModelMouseHover)
local TouchTapTracker = require(ReplicatedStorage.Library.Client.Input.TouchTapTracker)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local v1 = Color3.fromRGB(255, 0, 0)
local v2 = Color3.new(255/255, 255/255, 255/255)
local v3 = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local t = {}
local t2 = {}
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = 0
local v8 = nil
local v9 = nil
local v10 = TouchTapTracker.new()
local v11 = nil
local t3 = {}

local function getKey(p1) --[[ getKey | Line: 80 ]]
	return ("%*:%*"):format(p1.OwnerUserId, p1.UID)
end

local function activateActiveSteal(p1) --[[ activateActiveSteal | Line: 84 | Upvalues: v5 (ref), t (copy) ]]
	local v1 = v5

	if v1 == nil or p1 ~= nil and v1 ~= p1 then
		return
	end

	local v2 = t[v1]

	if v2 ~= nil and v2.ActivateSteal ~= nil then
		v2.ActivateSteal()
	end
end

local function bindGui() --[[ bindGui | Line: 96 | Upvalues: v4 (ref), GUI (copy), v2 (copy), UserInputService (copy), v5 (ref), t (copy), v11 (ref), v10 (copy) ]]
	local v1 = v4

	if v1 == nil then
		local v22 = GUI.AssetHoverData()

		assert(v22:IsA("ScreenGui"), "PlayerGui.AssetHoverData must be a ScreenGui")

		local Frame = v22.Frame

		assert(Frame:IsA("GuiObject"), "AssetHoverData.Frame must be a GuiObject")

		local CanvasGroup = Frame.CanvasGroup

		assert(CanvasGroup:IsA("CanvasGroup"), "AssetHoverData.Frame.CanvasGroup must be a CanvasGroup")

		local Weight = CanvasGroup.Weight

		assert(Weight:IsA("TextLabel"), "AssetHoverData.Frame.CanvasGroup.Weight must be a TextLabel")

		local Gender = CanvasGroup.Gender

		assert(Gender:IsA("ImageLabel"), "AssetHoverData.Frame.CanvasGroup.Gender must be an ImageLabel")

		local Steal = CanvasGroup.Steal

		assert(Steal:IsA("Frame"), "AssetHoverData.Frame.CanvasGroup.Steal must be a Frame")

		local ImageLabel = Steal.ImageLabel

		assert(ImageLabel:IsA("ImageLabel"), "AssetHoverData.Frame.CanvasGroup.Steal.ImageLabel must be an ImageLabel")

		local DnaStealPulseScale = Instance.new("UIScale")

		DnaStealPulseScale.Name = "DnaStealPulseScale"
		DnaStealPulseScale.Scale = 0.9
		DnaStealPulseScale.Parent = ImageLabel

		local t2 = {
			Root = v22,
			Frame = Frame,
			CanvasGroup = CanvasGroup,
			Weight = Weight,
			Gender = Gender,
			Steal = Steal,
			StealImage = ImageLabel,
			StealScale = DnaStealPulseScale
		}

		v4 = t2
		v22.Enabled = false
		Frame.Visible = false
		CanvasGroup.GroupTransparency = 1
		Steal.Active = false
		Steal.Visible = false
		ImageLabel.ImageColor3 = v2
		UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 138 | Upvalues: v5 (ref), t (ref), v11 (ref), v10 (ref) ]]
			if p2 then
				return
			end

			local UserInputType = p1.UserInputType

			if UserInputType == Enum.UserInputType.MouseButton1 then
				local v1 = v5

				if v1 == nil then
					return
				end

				local v2 = t[v1]

				if v2 == nil then
					return
				end

				if v2.ActivateSteal == nil then
					return
				end

				v2.ActivateSteal()
			else
				if UserInputType ~= Enum.UserInputType.Touch or v11 ~= nil then
					return
				end

				local v3 = v5

				if v3 == nil then
					return
				end

				local v4 = t[v3]

				if v4 ~= nil and v4.ActivateSteal ~= nil then
					v11 = v3
					v10:Begin(p1)
				end
			end
		end)
		UserInputService.InputChanged:Connect(function(p1) --[[ Line: 161 | Upvalues: v10 (ref) ]]
			if p1.UserInputType ~= Enum.UserInputType.Touch or not v10:IsTrackingInput(p1) then
				return
			end

			v10:Update(p1)
		end)
		UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 166 | Upvalues: v10 (ref), v11 (ref), v5 (ref), t (ref) ]]
			if p1.UserInputType ~= Enum.UserInputType.Touch or not v10:IsTrackingInput(p1) then
				return
			end

			local v1 = v11

			v11 = nil

			if not v10:Evaluate(p1, p2) or v1 == nil then
				return
			end

			local v2 = v5

			if v2 == nil then
				return
			end

			if v1 ~= nil and v2 ~= v1 then
				return
			end

			local v3 = t[v2]

			if v3 == nil then
				return
			end

			if v3.ActivateSteal == nil then
				return
			end

			v3.ActivateSteal()
		end)

		return t2
	end

	return v1
end

local function stopStealPulse(p1) --[[ stopStealPulse | Line: 180 | Upvalues: v8 (ref), v9 (ref), v2 (copy) ]]
	local v1 = v8

	v8 = nil

	if v1 ~= nil then
		v1:Cancel()
		v1:Destroy()
	end

	local v22 = v9

	v9 = nil

	if v22 == nil then
		p1.StealScale.Scale = 0.9
		p1.StealImage.ImageColor3 = v2

		return
	end

	v22:Cancel()
	v22:Destroy()
	p1.StealScale.Scale = 0.9
	p1.StealImage.ImageColor3 = v2
end

local function setStealVisible(p1, p2) --[[ setStealVisible | Line: 197 | Upvalues: v11 (ref), v10 (copy), v8 (ref), v9 (ref), v2 (copy), TweenService (copy), v3 (copy), v1 (copy) ]]
	if p2 then
		p1.Steal.Visible = true

		if v8 ~= nil then
			return
		end

		local v12 = v8

		v8 = nil

		if v12 ~= nil then
			v12:Cancel()
			v12:Destroy()
		end

		local v22 = v9

		v9 = nil

		local v32, v4

		if v22 == nil then
			p1.StealScale.Scale = 0.9
			p1.StealImage.ImageColor3 = v2
			v32 = TweenService:Create(p1.StealScale, v3, {
				Scale = 1.25
			})
			v4 = TweenService:Create(p1.StealImage, v3, {
				ImageColor3 = v1
			})
			v8 = v32
			v9 = v4
			v32:Play()
			v4:Play()

			return
		end

		v22:Cancel()
		v22:Destroy()
		p1.StealScale.Scale = 0.9
		p1.StealImage.ImageColor3 = v2
		v32 = TweenService:Create(p1.StealScale, v3, {
			Scale = 1.25
		})
		v4 = TweenService:Create(p1.StealImage, v3, {
			ImageColor3 = v1
		})
		v8 = v32
		v9 = v4
		v32:Play()
		v4:Play()
	else
		v11 = nil
		v10:Reset()

		local v5 = v8

		v8 = nil

		if v5 ~= nil then
			v5:Cancel()
			v5:Destroy()
		end

		local v6 = v9

		v9 = nil

		if v6 == nil then
			p1.StealScale.Scale = 0.9
			p1.StealImage.ImageColor3 = v2
			p1.Steal.Visible = false

			return
		end

		v6:Cancel()
		v6:Destroy()
		p1.StealScale.Scale = 0.9
		p1.StealImage.ImageColor3 = v2
		p1.Steal.Visible = false
	end
end

local function clearActiveHighlight() --[[ clearActiveHighlight | Line: 222 | Upvalues: v6 (ref), HoverHighlight (copy) ]]
	local v1 = v6

	v6 = nil

	if v1 == nil then
		return
	end

	HoverHighlight.FadeOut(v1, 0.2)
end

local function updateFramePosition(p1, p2) --[[ updateFramePosition | Line: 230 ]]
	p1.Frame.Position = UDim2.fromOffset(p2.X, p2.Y)
end

local function updateStaticContent(p1, p2) --[[ updateStaticContent | Line: 234 | Upvalues: AssetItemUtil (copy), AssetGenderUtil (copy) ]]
	p1.Weight.Text = AssetItemUtil.GetVisualWeightKgDisplay(p2.Record.ItemData)
	p1.Gender.Image = AssetGenderUtil.GetIcon(AssetGenderUtil.ResolveForCategory(p2.Record.ItemData.Category, p2.Record.ItemData.Gender))
end

local function setActiveEntry(p1, p2) --[[ setActiveEntry | Line: 241 | Upvalues: v5 (ref), bindGui (copy), v11 (ref), v10 (copy), v8 (ref), v9 (ref), v2 (copy), v7 (ref), v6 (ref), HoverHighlight (copy), Tween (copy), setStealVisible (copy), AssetItemUtil (copy), AssetGenderUtil (copy) ]]
	v7 = v7 + 1

	if p1 == nil then
		if v5 == nil then
			return
		end

		local v1 = bindGui()

		v1.Frame.Position = UDim2.fromOffset(p2.X, p2.Y)
		v5 = nil
		v11 = nil
		v10:Reset()

		local v22 = v8

		v8 = nil

		if v22 ~= nil then
			v22:Cancel()
			v22:Destroy()
		end

		local v3 = v9

		v9 = nil

		if v3 ~= nil then
			v3:Cancel()
			v3:Destroy()
		end

		v1.StealScale.Scale = 0.9
		v1.StealImage.ImageColor3 = v2
		v1.Steal.Visible = false

		local v4 = v7
		local v52 = v6

		v6 = nil

		if v52 == nil then
			Tween(v1.CanvasGroup, {
				GroupTransparency = 1
			}, { 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }).Completed:Once(function(p13) --[[ Line: 258 | Upvalues: v5 (ref), v7 (ref), v4 (copy), v1 (copy) ]]
				if p13 ~= Enum.PlaybackState.Completed or (v5 ~= nil or v7 ~= v4) then
					return
				end

				v1.Frame.Visible = false
				v1.Root.Enabled = false
			end)

			return
		end

		HoverHighlight.FadeOut(v52, 0.2)
		Tween(v1.CanvasGroup, {
			GroupTransparency = 1
		}, { 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }).Completed:Once(function(p13) --[[ Line: 258 | Upvalues: v5 (ref), v7 (ref), v4 (copy), v1 (copy) ]]
			if p13 ~= Enum.PlaybackState.Completed or (v5 ~= nil or v7 ~= v4) then
				return
			end

			v1.Frame.Visible = false
			v1.Root.Enabled = false
		end)
	else
		local v62 = bindGui()

		v62.Frame.Position = UDim2.fromOffset(p2.X, p2.Y)
		v62.Root.Enabled = true
		v62.Frame.Visible = true
		setStealVisible(v62, p1.ActivateSteal ~= nil)

		if v5 == p1.Key then
			return
		end

		v5 = p1.Key

		local v82 = v6

		v6 = nil

		if v82 ~= nil then
			HoverHighlight.FadeOut(v82, 0.2)
		end

		v6 = HoverHighlight.FadeIn(p1.Model, "AssetHoverHighlight", 0.2)
		v62.Weight.Text = AssetItemUtil.GetVisualWeightKgDisplay(p1.Record.ItemData)
		v62.Gender.Image = AssetGenderUtil.GetIcon(AssetGenderUtil.ResolveForCategory(p1.Record.ItemData.Category, p1.Record.ItemData.Gender))
		v62.CanvasGroup.GroupTransparency = 1
		Tween(v62.CanvasGroup, {
			GroupTransparency = 0
		}, { 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
	end
end

local function updateHover() --[[ updateHover | Line: 288 | Upvalues: UserInputService (copy), ModelMouseHover (copy), t2 (copy), t (copy), setActiveEntry (copy) ]]
	local v1 = UserInputService:GetMouseLocation()
	local v2 = ModelMouseHover.GetHoveredKey(t2, v1, 200)

	setActiveEntry(if v2 == nil then nil else t[v2], v1)
end

function t3.SetEntry(p1) --[[ SetEntry | Line: 299 | Upvalues: AssetRuntime (copy), Asserts (copy), t (copy), t2 (copy) ]]
	assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(p1.Record), "Invalid runtime asset record")
	Asserts.Model(p1.Model)

	local Record = p1.Record
	local v2 = ("%*:%*"):format(Record.OwnerUserId, Record.UID)

	t[v2] = {
		Key = v2,
		Record = p1.Record,
		Model = p1.Model,
		ActivateSteal = p1.ActivateSteal
	}
	t2[v2] = p1.Model
end
function t3.RemoveEntry(p1, p2) --[[ RemoveEntry | Line: 313 | Upvalues: Asserts (copy), t (copy), t2 (copy), v5 (ref), setActiveEntry (copy), UserInputService (copy) ]]
	Asserts.number(p1)
	Asserts.string(p2)

	local v1 = ("%*:%*"):format(p1, p2)

	t[v1] = nil
	t2[v1] = nil

	if v5 ~= v1 then
		return
	end

	setActiveEntry(nil, UserInputService:GetMouseLocation())
end
function t3.DestroyOwner(p1) --[[ DestroyOwner | Line: 325 | Upvalues: Asserts (copy), t (copy), t2 (copy), v5 (ref), setActiveEntry (copy), UserInputService (copy) ]]
	Asserts.number(p1)

	for k, v in pairs(t) do
		if v.Record.OwnerUserId == p1 then
			t[k] = nil
			t2[k] = nil

			if v5 == k then
				setActiveEntry(nil, UserInputService:GetMouseLocation())
			end
		end
	end
end
RunService.RenderStepped:Connect(updateHover)

return t3