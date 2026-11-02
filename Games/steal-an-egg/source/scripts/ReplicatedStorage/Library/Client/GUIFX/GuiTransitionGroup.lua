-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}

t.__index = t
t.__class = "GuiTransitionGroup"
function t.new(p1, p2, p3) --[[ new | Line: 43 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Instance(p1)
	Asserts.Instance(p2)
	Asserts.number(p3)

	local v2 = setmetatable({}, t)

	v2._activeTweens = {}
	v2._positionRecords = {}
	v2._transparencyRecords = {}

	for i, v in ipairs(p1:GetDescendants()) do
		local v3
		local t2 = {
			BackgroundTransparency = nil,
			GroupTransparency = nil,
			ImageTransparency = nil,
			TextStrokeTransparency = nil,
			TextTransparency = nil,
			Transparency = nil,
			Instance = v
		}

		if v:IsA("GuiObject") then
			t2.BackgroundTransparency = v.BackgroundTransparency
			v3 = true
		else
			v3 = false
		end

		if v:IsA("CanvasGroup") then
			t2.GroupTransparency = v.GroupTransparency
			v3 = true
		end

		if v:IsA("ImageLabel") or v:IsA("ImageButton") then
			t2.ImageTransparency = v.ImageTransparency
			v3 = true
		end

		if v:IsA("TextLabel") or (v:IsA("TextButton") or v:IsA("TextBox")) then
			t2.TextTransparency = v.TextTransparency
			t2.TextStrokeTransparency = v.TextStrokeTransparency
			v3 = true
		end

		if v:IsA("UIStroke") then
			t2.Transparency = v.Transparency
			v3 = true
		end

		if v3 then
			v2._transparencyRecords[#v2._transparencyRecords + 1] = t2
		end
	end

	for i, v in ipairs(p2:GetChildren()) do
		if v:IsA("GuiObject") then
			local Position = v.Position

			v2._positionRecords[#v2._positionRecords + 1] = {
				GuiObject = v,
				OriginalPosition = Position,
				OffsetPosition = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale - p3, Position.Y.Offset)
			}
		end
	end

	return v2
end
function t._playTween(p1, p2, p3, p4) --[[ _playTween | Line: 115 | Upvalues: TweenService (copy) ]]
	local v1 = TweenService:Create(p2, p3, p4)

	p1._activeTweens[#p1._activeTweens + 1] = v1
	v1:Play()
end
function t.Cancel(p1) --[[ Cancel | Line: 130 ]]
	for i, v in ipairs(p1._activeTweens) do
		v:Cancel()
	end

	table.clear(p1._activeTweens)
end
function t.PrepareHidden(p1) --[[ PrepareHidden | Line: 137 ]]
	for i, v in ipairs(p1._transparencyRecords) do
		local v1 = v.Instance

		if v.BackgroundTransparency ~= nil then
			v1.BackgroundTransparency = 1
		end

		if v.GroupTransparency ~= nil then
			v1.GroupTransparency = 1
		end

		if v.ImageTransparency ~= nil then
			local v2 = v1:IsA("ImageLabel") or v1:IsA("ImageButton")

			assert(v2, (("%* must render images"):format((v1:GetFullName()))))
			v1.ImageTransparency = 1
		end

		if v.TextTransparency ~= nil then
			local v4 = v1:IsA("TextLabel") or (v1:IsA("TextButton") or v1:IsA("TextBox"))

			assert(v4, (("%* must render text"):format((v1:GetFullName()))))
			v1.TextTransparency = 1
		end

		if v.TextStrokeTransparency ~= nil then
			local v6 = v1:IsA("TextLabel") or (v1:IsA("TextButton") or v1:IsA("TextBox"))

			assert(v6, (("%* must render text strokes"):format((v1:GetFullName()))))
			v1.TextStrokeTransparency = 1
		end

		if v.Transparency ~= nil then
			v1.Transparency = 1
		end
	end

	for i, v in ipairs(p1._positionRecords) do
		v.GuiObject.Position = v.OffsetPosition
	end
end
function t.TweenVisible(p1, p2) --[[ TweenVisible | Line: 180 ]]
	for i, v in ipairs(p1._transparencyRecords) do
		local t = {}

		if v.BackgroundTransparency ~= nil then
			t.BackgroundTransparency = v.BackgroundTransparency
		end

		if v.GroupTransparency ~= nil then
			t.GroupTransparency = v.GroupTransparency
		end

		if v.ImageTransparency ~= nil then
			t.ImageTransparency = v.ImageTransparency
		end

		if v.TextTransparency ~= nil then
			t.TextTransparency = v.TextTransparency
		end

		if v.TextStrokeTransparency ~= nil then
			t.TextStrokeTransparency = v.TextStrokeTransparency
		end

		if v.Transparency ~= nil then
			t.Transparency = v.Transparency
		end

		p1:_playTween(v.Instance, p2, t)
	end

	for i, v in ipairs(p1._positionRecords) do
		p1:_playTween(v.GuiObject, p2, {
			Position = v.OriginalPosition
		})
	end
end
function t.TweenHidden(p1, p2) --[[ TweenHidden | Line: 211 ]]
	for i, v in ipairs(p1._transparencyRecords) do
		local t = {}

		if v.BackgroundTransparency ~= nil then
			t.BackgroundTransparency = 1
		end

		if v.GroupTransparency ~= nil then
			t.GroupTransparency = 1
		end

		if v.ImageTransparency ~= nil then
			t.ImageTransparency = 1
		end

		if v.TextTransparency ~= nil then
			t.TextTransparency = 1
		end

		if v.TextStrokeTransparency ~= nil then
			t.TextStrokeTransparency = 1
		end

		if v.Transparency ~= nil then
			t.Transparency = 1
		end

		p1:_playTween(v.Instance, p2, t)
	end

	for i, v in ipairs(p1._positionRecords) do
		p1:_playTween(v.GuiObject, p2, {
			Position = v.OffsetPosition
		})
	end
end
function t.RestorePositions(p1) --[[ RestorePositions | Line: 242 ]]
	for i, v in ipairs(p1._positionRecords) do
		v.GuiObject.Position = v.OriginalPosition
	end
end

return t