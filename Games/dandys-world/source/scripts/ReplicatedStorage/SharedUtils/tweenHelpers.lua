--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQNYBXBjYWxsC2hhc1Byb3BlcnR5CkRpc2Nvbm5lY3QHRGVzdHJveQZDcmVhdGULUmVwZWF0Q291bnQJQ29tcGxldGVkB0Nvbm5lY3QEUGxheQlwbGF5VHdlZW4NaW5pdGlhbFByZWZpeAxHZXRBdHRyaWJ1dGUKZ2V0SW5pdGlhbAhQb3NpdGlvbgRTaXplCFJvdGF0aW9uFkJhY2tncm91bmRUcmFuc3BhcmVuY3kQQmFja2dyb3VuZENvbG9yMwpUZXh0Q29sb3IzEFRleHRUcmFuc3BhcmVuY3kGWkluZGV4EUltYWdlVHJhbnNwYXJlbmN5DFRyYW5zcGFyZW5jeRZJbml0aWFsUHJvcGVydGllc1NhdmVkCUd1aU9iamVjdANJc0EIVUlTdHJva2UFcGFpcnMMU2V0QXR0cmlidXRlDkdldERlc2NlbmRhbnRzDHNhdmVJbml0aWFscwZpcGFpcnMETmFtZQAKVGV4dEJ1dHRvbgdzY2FuR3VpCmlnbm9yZUxpc3QGc3RyaW5nBGZpbmQHVmlzaWJsZQZmYWRlSW4HZmFkZU91dBBBYnNvbHV0ZVBvc2l0aW9uDEFic29sdXRlU2l6ZQtBbmNob3JQb2ludAFYAVkFVURpbTIJZnJvbVNjYWxlE2dldFBvc2l0aW9uSW5QYXJlbnQPZ2V0U2l6ZUluUGFyZW50CVNjYWxlVHlwZQRFbnVtBVNsaWNlBVNjYWxlEkFic29sdXRlV2luZG93U2l6ZRJBYnNvbHV0ZUNhbnZhc1NpemUDbmV3DkNhbnZhc1Bvc2l0aW9uCVRleHRMYWJlbBBPcmlnaW5hbEZvbnRTaXplCFRleHRTaXplBG1hdGgFcm91bmQHVmVjdG9yMgdVSVNjYWxlCVR3ZWVuSW5mbwtFYXNpbmdTdHlsZQVDdWJpYwVUaHVtYgxXYWl0Rm9yQ2hpbGQOVUlEcmFnRGV0ZWN0b3IHQ2hhbmdlZAxEcmFnQ29udGludWUJRHJhZ1N0YXJ0B0RyYWdFbmQPY3VzdG9tU2Nyb2xsYmFyB19faW5kZXgEZ2FtZQxUd2VlblNlcnZpY2UKR2V0U2VydmljZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQJTW91c2VPdmVyCW1vdXNlT3ZlcgZzdGFydF8KVGV4dFNjYWxlcgARAwACAAAABPsB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e184rA==

-- https://lua.expert/
local t = {}

t.__index = t

local TweenService = game:GetService("TweenService")

t.mouseOver = require(script.Parent.MouseOver)
t.initialPrefix = "start_"
t.TextScaler = require(script.TextScaler)
function t.hasProperty(p1, p2) --[[ hasProperty | Line: 14 ]]
	return pcall(function() --[[ Line: 15 | Upvalues: p1 (copy), p2 (copy) ]]
		return p1[p2]
	end)
end
function t.playTween(p1, p2, p3) --[[ playTween | Line: 22 | Upvalues: TweenService (copy) ]]
	local v1 = TweenService:Create(p1, p2, p3)

	if p2.RepeatCount ~= -1 then
		local v2 = nil

		v2 = v1.Completed:Connect(function() --[[ Line: 29 | Upvalues: v2 (ref), v1 (copy) ]]
			if v2 then
				v2:Disconnect()
				v2 = nil
			end

			v1:Destroy()
		end)
	end

	v1:Play()

	return v1
end
function t.getInitial(p1, p2) --[[ getInitial | Line: 44 | Upvalues: t (copy) ]]
	if t.hasProperty(p1, p2) then
		return p1:GetAttribute(t.initialPrefix .. p2)
	end
end
function t.saveInitials(p1, p2) --[[ saveInitials | Line: 52 | Upvalues: t (copy) ]]
	if not p2 then
		p2 = {
			"Position",
			"Size",
			"Rotation",
			"BackgroundTransparency",
			"BackgroundColor3",
			"TextColor3",
			"TextTransparency",
			"ZIndex",
			"ImageTransparency",
			"Transparency"
		}
	end

	if p1:GetAttribute("InitialPropertiesSaved") then
		return
	end

	if p1:IsA("GuiObject") or p1:IsA("UIStroke") then
		for k, v in pairs(p2) do
			if t.hasProperty(p1, v) then
				p1:SetAttribute(t.initialPrefix .. v, p1[v])
			end
		end
	end

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("GuiObject") or v:IsA("UIStroke") then
			for k2, v2 in pairs(p2) do
				if t.hasProperty(v, v2) then
					v:SetAttribute(t.initialPrefix .. v2, v[v2])
				end
			end
		end
	end

	p1:SetAttribute("InitialPropertiesSaved", true)
end
function t.scanGui(p1) --[[ scanGui | Line: 92 ]]
	local t = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("GuiObject") and (v.Name ~= "" and not v:IsA("TextButton")) then
			t[v.Name] = v
		end
	end

	return t
end
function t.fadeIn(p1, p2) --[[ fadeIn | Line: 107 | Upvalues: t (copy) ]]
	local tbl = { "ImageTransparency", "BackgroundTransparency", "TextTransparency", "Transparency" }

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("GuiObject") or v:IsA("UIStroke") then
			for k2, v2 in pairs(tbl) do
				if (v:GetAttribute("ignoreList") == nil or not string.find(v:GetAttribute("ignoreList"), v2)) and t.hasProperty(v, v2) then
					v[v2] = 1
					t.playTween(v, p2, {
						[v2] = v:GetAttribute(t.initialPrefix .. v2)
					})
				end
			end
		end
	end

	p1.Visible = true
end
function t.fadeOut(p1, p2) --[[ fadeOut | Line: 139 | Upvalues: t (copy) ]]
	local tbl = { "ImageTransparency", "BackgroundTransparency", "TextTransparency", "Transparency" }

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("UIStroke") then
			t.playTween(v, p2, {
				Transparency = 1
			})
		end

		if v:IsA("GuiObject") or v:IsA("UIStroke") then
			for k2, v2 in pairs(tbl) do
				if t.hasProperty(v, v2) then
					v[v2] = v:GetAttribute(t.initialPrefix .. v2)
					t.playTween(v, p2, {
						[v2] = 1
					})
				end
			end
		end
	end
end
function t.getPositionInParent(p1, p2) --[[ getPositionInParent | Line: 170 ]]
	local AbsolutePosition = p1.AbsolutePosition
	local AbsoluteSize = p1.AbsoluteSize
	local AnchorPoint = p1.AnchorPoint
	local AbsolutePosition2 = p2.AbsolutePosition
	local AbsoluteSize2 = p2.AbsoluteSize

	return UDim2.fromScale((AbsolutePosition.X + AbsoluteSize.X * AnchorPoint.X - AbsolutePosition2.X) / AbsoluteSize2.X, (AbsolutePosition.Y + AbsoluteSize.Y * AnchorPoint.Y - AbsolutePosition2.Y) / AbsoluteSize2.Y)
end
function t.getSizeInParent(p1, p2) --[[ getSizeInParent | Line: 190 ]]
	local AbsoluteSize = p1.AbsoluteSize
	local AbsoluteSize2 = p2.AbsoluteSize

	return UDim2.fromScale(AbsoluteSize.X / AbsoluteSize2.X, AbsoluteSize.Y / AbsoluteSize2.Y)
end
function t.customScrollbar(p1, p2, p3) --[[ customScrollbar | Line: 201 | Upvalues: t (copy) ]]
	local Thumb = p1:WaitForChild("Thumb")
	local UIDragDetector = Thumb.UIDragDetector
	local v1 = 1 - Thumb.Size.Y.Scale

	p2.Changed:Connect(function() --[[ Line: 209 | Upvalues: Thumb (copy), p2 (copy), v1 (ref), p3 (copy) ]]
		if Thumb.ScaleType == Enum.ScaleType.Slice then
			Thumb.Size = UDim2.fromScale(Thumb.Size.X.Scale, p2.AbsoluteWindowSize.Y / p2.AbsoluteCanvasSize.Y)
		end

		v1 = 1 - Thumb.Size.Y.Scale
		Thumb.Position = UDim2.new(Thumb.Position.X.Scale, 0, p2.CanvasPosition.Y / (p2.AbsoluteCanvasSize.Y - p2.AbsoluteWindowSize.Y) * v1, 0)

		if not p3 then
			return
		end

		local v12 = p2.AbsoluteSize.X / p3

		for i, v in ipairs(p2:GetDescendants()) do
			if v:IsA("TextLabel") then
				if not v:GetAttribute("OriginalFontSize") then
					v:SetAttribute("OriginalFontSize", v.TextSize)
				end

				v.TextSize = math.round(v:GetAttribute("OriginalFontSize") * v12)
			end
		end
	end)
	UIDragDetector.DragContinue:Connect(function() --[[ Line: 235 | Upvalues: v1 (ref), Thumb (copy), p2 (copy) ]]
		v1 = 1 - Thumb.Size.Y.Scale
		p2.CanvasPosition = Vector2.new(0, (p2.AbsoluteCanvasSize.Y - p2.AbsoluteWindowSize.Y) * (Thumb.Position.Y.Scale / v1))
	end)
	UIDragDetector.DragStart:Connect(function() --[[ Line: 242 | Upvalues: t (ref), Thumb (copy) ]]
		t.playTween(Thumb.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Cubic), {
			Scale = 1.15
		})
	end)
	UIDragDetector.DragEnd:Connect(function() --[[ Line: 246 | Upvalues: t (ref), Thumb (copy) ]]
		t.playTween(Thumb.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Cubic), {
			Scale = 1
		})
	end)
end

return t