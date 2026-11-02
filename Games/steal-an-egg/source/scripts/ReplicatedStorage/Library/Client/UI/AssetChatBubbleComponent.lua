-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GetOrCreateUIScale = require(ReplicatedStorage.Library.Functions.GetOrCreateUIScale)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local TutorialMessageAnimator = require(ReplicatedStorage.Library.Client.UI.TutorialMessageAnimator)
local Weld = require(ReplicatedStorage.Library.Functions.Weld)
local t = {}

t.__index = t
t.__class = "AssetChatBubbleComponent"

local v1 = Vector2.new(1084, 144)
local v2 = Vector2.new(251, 72)
local v3 = Vector2.new(213.84, 56.4)
local v4 = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local ChatBubble = ReplicatedStorage.Assets.Billboards.ChatBubble

assert(ChatBubble:IsA("BillboardGui"), "Assets.Billboards.ChatBubble must be a BillboardGui")

local Frame = ChatBubble.Frame

assert(Frame:IsA("Frame"), "Assets.Billboards.ChatBubble.Frame must be a Frame")
assert(Frame.TextLabel:IsA("TextLabel"), "Assets.Billboards.ChatBubble.Frame.TextLabel must be a TextLabel")

local v9 = true

function t.new(p1, p2, p3) --[[ new | Line: 65 | Upvalues: Asserts (copy), t (copy), Trove (copy) ]]
	Asserts.Model(p1)
	Asserts.BasePart(p2)
	Asserts.boolean(p3)

	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2._presentationTrove = nil
	v2._model = p1
	v2._centerPart = p2
	v2._adornee = if p3 then nil else p2
	v2._billboardScale = math.max(p2.Size.X / 0.49799999594688416, p2.Size.Y / 0.4440000057220459)
	v2._useProxy = p3
	v2._suppressed = false

	return v2
end
function t._resolveAdornee(p1) --[[ _resolveAdornee | Line: 88 | Upvalues: Weld (copy) ]]
	local _adornee = p1._adornee

	if _adornee == nil then
		assert(p1._useProxy, "A missing chat bubble adornee requires proxy mode")

		local AssetBubbleProxy = Instance.new("Part")

		AssetBubbleProxy.Name = "AssetBubbleProxy"
		AssetBubbleProxy.Size = Vector3.new(0.2, 0.2, 0.2)
		AssetBubbleProxy.Transparency = 1
		AssetBubbleProxy.CanCollide = false
		AssetBubbleProxy.CanQuery = false
		AssetBubbleProxy.CanTouch = false
		AssetBubbleProxy.Anchored = false
		AssetBubbleProxy.Massless = true
		AssetBubbleProxy.CFrame = p1._centerPart.CFrame + Vector3.new(0, -1, 0)
		AssetBubbleProxy.Parent = p1._model
		Weld(p1._centerPart, AssetBubbleProxy)
		p1._trove:Add(AssetBubbleProxy)
		p1._adornee = AssetBubbleProxy

		return AssetBubbleProxy
	end

	return _adornee
end
function t._clearPresentation(p1, p2) --[[ _clearPresentation | Line: 113 ]]
	local _presentationTrove = p1._presentationTrove

	if _presentationTrove == nil or p2 ~= nil and _presentationTrove ~= p2 then
		return
	end

	p1._presentationTrove = nil
	_presentationTrove:Destroy()
end
function t._scaleBillboard(p1, p2) --[[ _scaleBillboard | Line: 126 ]]
	local Size = p2.Size
	local _billboardScale = p1._billboardScale

	p2.Size = UDim2.new(Size.X.Scale * _billboardScale, Size.X.Offset * _billboardScale, Size.Y.Scale * _billboardScale, Size.Y.Offset * _billboardScale)
end
function t._fitFrameToText(p1, p2, p3, p4) --[[ _fitFrameToText | Line: 132 | Upvalues: v3 (copy), TextService (copy), v2 (copy), v1 (copy) ]]
	local GetTextBoundsParams = Instance.new("GetTextBoundsParams")

	GetTextBoundsParams.Font = p3.FontFace
	GetTextBoundsParams.Size = v3.Y
	GetTextBoundsParams.Width = 10000
	GetTextBoundsParams.Text = p4

	local v12 = TextService:GetTextBoundsAsync(GetTextBoundsParams)

	GetTextBoundsParams:Destroy()
	assert(if v12.Y > 0 then true else false, "Chat bubble text must produce positive text bounds")

	local Size = p2.Size

	assert(if Size.X.Offset == 0 then if Size.Y.Offset == 0 then true else false else false, "ChatBubble.Frame.Size must use scale dimensions")
	p2.Size = UDim2.fromScale(math.max(v2.X, v12.X + (v2.X - v3.X)) / v1.X, Size.Y.Scale)
end
function t.Display(p1, p2, p3) --[[ Display | Line: 159 | Upvalues: Asserts (copy), ChatBubble (copy), v9 (ref), Trove (copy), GetOrCreateUIScale (copy), TutorialMessageAnimator (copy), TweenService (copy), v4 (copy), v5 (copy) ]]
	Asserts.string(p2)

	if not p1._suppressed then
		p1:_clearPresentation(nil)

		local v1 = ChatBubble:Clone()
		local Frame = v1.Frame
		local TextLabel = Frame.TextLabel

		assert(Frame:IsA("Frame"), "Cloned ChatBubble.Frame must be a Frame")
		assert(TextLabel:IsA("TextLabel"), "Cloned ChatBubble.Frame.TextLabel must be a TextLabel")
		p1:_scaleBillboard(v1)
		Frame.AutomaticSize = Enum.AutomaticSize.None
		v1.Adornee = p1:_resolveAdornee()
		v1.AlwaysOnTop = v9
		v1.Parent = p1._model
		v1.Enabled = true
		TextLabel.Text = ""

		local v42 = Trove.new()

		p1._presentationTrove = v42
		v42:Add(v1)
		v42:Add(task.spawn(function() --[[ Line: 187 | Upvalues: p1 (copy), v42 (copy), Frame (copy), TextLabel (copy), p2 (copy), GetOrCreateUIScale (ref), TutorialMessageAnimator (ref), TweenService (ref), v4 (ref), v5 (ref), p3 (copy) ]]
			if p1._presentationTrove ~= v42 then
				return
			end

			p1:_fitFrameToText(Frame, TextLabel, p2)

			if p1._presentationTrove == v42 then
				local v1 = GetOrCreateUIScale(Frame)

				v1.Scale = 0

				local v2 = TutorialMessageAnimator.new(TextLabel, nil, nil, false)

				v42:Add(function() --[[ Line: 200 | Upvalues: v2 (copy) ]]
					v2:Stop()
				end)

				local v3 = TweenService:Create(v1, v4, {
					Scale = 1
				})

				v42:Add(v3)
				v42:Add(task.delay(4, function() --[[ Line: 206 | Upvalues: p1 (ref), v42 (ref), TweenService (ref), v1 (copy), v5 (ref), p3 (ref) ]]
					if p1._presentationTrove == v42 then
						local v12 = TweenService:Create(v1, v5, {
							Scale = 0
						})

						v42:Add(v12)
						v42:Add(v12.Completed:Connect(function() --[[ Line: 213 | Upvalues: p1 (ref), v42 (ref), p3 (ref) ]]
							p1:_clearPresentation(v42)

							if p3 == nil then
								return
							end

							p3()
						end))
						v12:Play()
					end
				end))
				task.delay(0.2, function() --[[ Line: 222 | Upvalues: v2 (copy), p2 (ref), TextLabel (ref) ]]
					v2:SetAnimated(p2, TextLabel.TextColor3)
				end)
				v3:Play()
			end
		end))

		return
	end

	if p3 == nil then
		return
	end

	p3()
end
function t.SetSuppressed(p1, p2) --[[ SetSuppressed | Line: 229 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)

	if p1._suppressed == p2 then
		return
	end

	p1._suppressed = p2

	if not p2 then
		return
	end

	p1:_clearPresentation(nil)
end
function t.SetAlwaysOnTop(p1) --[[ SetAlwaysOnTop | Line: 241 | Upvalues: Asserts (copy), v9 (ref) ]]
	Asserts.boolean(p1)
	v9 = p1
end
function t.Destroy(p1) --[[ Destroy | Line: 246 ]]
	p1:_clearPresentation(nil)
	p1._trove:Destroy()
end

return t