--credit to leon games studio
assert(not game:GetService("RunService"):IsClient())

local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")
local EncodingService = game:GetService("EncodingService")

require(script.Types)

local Easing = require(script.Easing)
local v2 = Rect.new(64, 64, 192, 192)
local v3 = UDim2.fromScale(0, 0)
local v4 = UDim2.fromScale(1, 1)
local ok, result = pcall(require, script.PNG)
local v5 = if ok then result else nil

local function HexToColor3(p1) --[[ HexToColor3 | Line: 90 ]]
	return Color3.fromRGB(tonumber(string.sub(p1, 2, 3), 16) or 0, tonumber(string.sub(p1, 4, 5), 16) or 0, tonumber(string.sub(p1, 6, 7), 16) or 0)
end

local function IsPropertyAnimated(p1) --[[ IsPropertyAnimated | Line: 97 ]]
	if p1 == nil then
		return false
	end

	return p1.a == 1
end

local function HasAnimatedOpacity(p1) --[[ HasAnimatedOpacity | Line: 102 ]]
	if p1 == nil then
		return false
	end

	local o = p1.o

	if o == nil then
		return false
	end

	return o.a == 1
end

local function SubdivideCubicBezier(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ SubdivideCubicBezier | Line: 109 ]]
	for i = 1, p9 do
		local v1 = i / p9
		local v2 = 1 - v1
		local v3 = v2 * v2
		local v4 = v3 * v2
		local v5 = v1 * v1
		local v6 = v5 * v1

		table.insert(p10, { v4 * p1 + v3 * 3 * v1 * p3 + v2 * 3 * v5 * p5 + v6 * p7, v4 * p2 + v3 * 3 * v1 * p4 + v2 * 3 * v5 * p6 + v6 * p8 })
	end
end

local function BezierShapeToPolyline(p1) --[[ BezierShapeToPolyline | Line: 131 | Upvalues: SubdivideCubicBezier (copy) ]]
	local v = p1.v
	local i = p1.i
	local o = p1.o
	local v1 = #v

	if v1 == 0 then
		return {}
	end

	local t = {
		{ v[1][1], v[1][2] }
	}

	for i2 = 1, if p1.c then v1 else v1 - 1 do
		local v3
		local v4 = if i2 < v1 then i2 + 1 else 1
		local v5 = v[i2]
		local v6 = v[v4]
		local v7 = o[i2]
		local v8 = i[v4]
		local v9 = v5[1]
		local v10 = v5[2]
		local v15 = v6[1]
		local v16 = v6[2]

		v3 = if math.abs(v7[1]) < 0.01 then if math.abs(v7[2]) < 0.01 then if math.abs(v8[1]) < 0.01 then math.abs(v8[2]) < 0.01 else false else false else false

		if v3 then
			table.insert(t, { v15, v16 })

			continue
		end

		SubdivideCubicBezier(v9, v10, v9 + v7[1], v10 + v7[2], v6[1] + v8[1], v6[2] + v8[2], v15, v16, 12, t)
	end

	return t
end

local function Cross2D(p1, p2, p3, p4, p5, p6) --[[ Cross2D | Line: 168 ]]
	return (p3 - p1) * (p6 - p2) - (p4 - p2) * (p5 - p1)
end

local function PointInTriangle(p1, p2, p3, p4, p5, p6, p7, p8) --[[ PointInTriangle | Line: 172 ]]
	local v1 = (p3 - p1) * (p6 - p2) - (p4 - p2) * (p5 - p1)
	local v2 = (p5 - p1) * (p8 - p2) - (p6 - p2) * (p7 - p1)
	local v3 = (p7 - p1) * (p4 - p2) - (p8 - p2) * (p3 - p1)

	return not ((if v1 < 0 or v2 < 0 then true elseif v3 < 0 then true else false) and (if v1 > 0 or v2 > 0 then true else v3 > 0))
end

local function IsConvexPolygon(p1) --[[ IsConvexPolygon | Line: 181 ]]
	local v1 = #p1

	if v1 < 3 then
		return false
	end

	local v2 = 0

	for i = 1, v1 do
		local v3 = if i < v1 then i + 1 else 1
		local v4 = if v3 < v1 then v3 + 1 else 1
		local v5 = p1[i][1]
		local v6 = p1[i][2]
		local v10 = (p1[v3][1] - v5) * (p1[v4][2] - v6) - (p1[v3][2] - v6) * (p1[v4][1] - v5)

		if v10 ~= 0 then
			if v2 == 0 then
				v2 = if v10 > 0 then 1 else -1

				continue
			end

			if v10 > 0 and v2 < 0 then
				return false
			end

			if v10 < 0 and v2 > 0 then
				return false
			end
		end
	end

	return true
end

local function TriangulateFan(p1) --[[ TriangulateFan | Line: 204 ]]
	local t = {}

	for i = 2, #p1 - 1 do
		table.insert(t, { p1[1], p1[i], p1[i + 1] })
	end

	return t
end

local function TriangulateEarClip(p1) --[[ TriangulateEarClip | Line: 212 | Upvalues: IsConvexPolygon (copy), TriangulateFan (copy), PointInTriangle (copy) ]]
	local v1 = #p1

	if v1 < 3 then
		return {}
	end

	if v1 == 3 then
		return {
			{ p1[1], p1[2], p1[3] }
		}
	end

	if IsConvexPolygon(p1) then
		return TriangulateFan(p1)
	end

	local v2 = table.create(v1)
	local sum = 0

	for i = 1, v1 do
		v2[i] = i

		local v3 = if i < v1 then i + 1 else 1

		sum = sum + (p1[v3][1] - p1[i][1]) * (p1[v3][2] + p1[i][2])
	end

	if sum > 0 then
		local v4 = table.create(v1)

		for j = 1, v1 do
			v4[j] = v2[v1 - j + 1]
		end

		v2 = v4
	end

	local count = #v2
	local count2 = 0
	local count3 = 1
	local t = {}

	while count > 2 and count2 < count * count do
		count2 = count2 + 1

		if count < count3 then
			count3 = 1
		end

		local v6 = if count3 > 1 then count3 - 1 else count
		local v7 = if count3 < count then count3 + 1 else 1
		local v8 = p1[v2[v6]]
		local v9 = p1[v2[count3]]
		local v10 = p1[v2[v7]]
		local v11 = v8[1]
		local v12 = v8[2]

		if (v9[1] - v11) * (v10[2] - v12) - (v9[2] - v12) * (v10[1] - v11) > 0 then
			local v16 = true

			for k = 1, count do
				if k ~= v6 and (k ~= count3 and (k ~= v7 and PointInTriangle(p1[v2[k]][1], p1[v2[k]][2], v8[1], v8[2], v9[1], v9[2], v10[1], v10[2]))) then
					v16 = false

					break
				end
			end

			if v16 then
				table.insert(t, { v8, v9, v10 })
				table.remove(v2, count3)
				count = count - 1

				if count < count3 then
					count3 = 1
				else
					continue
				end

				continue
			end
		end

		count3 = count3 + 1
	end

	return t
end

local function CreateWedge(p1) --[[ CreateWedge | Line: 275 ]]
	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Image = "rbxassetid://83051256678409"
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.fromScale(1, 1)
	ImageLabel.Parent = p1

	return ImageLabel
end

local function UpdateTriangle(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ UpdateTriangle | Line: 285 ]]
	local v1 = p4 - p2
	local v2 = p5 - p3
	local v3 = p6 - p2
	local v4 = p7 - p3

	if v1 * v4 - v2 * v3 < 0 then
		v1 = p6 - p2
		v2 = p7 - p3
		v3 = p4 - p2
		v4 = p5 - p3
	end

	local v5 = math.sqrt(v1 * v1 + v2 * v2)

	if v5 < 1e-6 or math.sqrt(v3 * v3 + v4 * v4) < 1e-6 then
		p1.A.Visible = false
		p1.B.Visible = false

		return
	end

	local v6 = v1 / v5
	local v7 = v2 / v5
	local v8 = v3 * v6 + v4 * v7
	local v9 = v3 - v6 * v8
	local v10 = v4 - v7 * v8
	local v11 = math.sqrt(v9 * v9 + v10 * v10)

	if v11 < 1e-6 then
		p1.A.Visible = false
		p1.B.Visible = false

		return
	end

	local v12 = math.atan2(v7, v6) * 57.29577951308232
	local A = p1.A

	A.Visible = true
	A.Position = UDim2.fromScale(p2, p3)
	A.Size = UDim2.fromScale(math.max(v8, 0.0001), v11)
	A.Rotation = v12
	A.AnchorPoint = Vector2.zero
	A.ImageColor3 = p8
	A.ImageTransparency = p9

	local B = p1.B
	local v13 = v5 - v8

	B.Visible = v13 > 1e-6

	if not B.Visible then
		return
	end

	B.Position = UDim2.fromScale(p2 + v6 * v5, p3 + v7 * v5)
	B.Size = UDim2.fromScale(math.max(v13, 0.0001), v11)
	B.Rotation = v12 + 180
	B.AnchorPoint = Vector2.zero
	B.ImageColor3 = p8
	B.ImageTransparency = p9
end

local function CreateTrianglePair(p1) --[[ CreateTrianglePair | Line: 350 ]]
	local t = {}
	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Image = "rbxassetid://83051256678409"
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.fromScale(1, 1)
	ImageLabel.Parent = p1
	t.A = ImageLabel

	local ImageLabel2 = Instance.new("ImageLabel")

	ImageLabel2.Image = "rbxassetid://83051256678409"
	ImageLabel2.BackgroundTransparency = 1
	ImageLabel2.BorderSizePixel = 0
	ImageLabel2.Size = UDim2.fromScale(1, 1)
	ImageLabel2.Parent = p1
	t.B = ImageLabel2

	return t
end

local function BuildFilledPath(p1, p2, p3, p4, p5, p6, p7) --[[ BuildFilledPath | Line: 359 | Upvalues: BezierShapeToPolyline (copy), TriangulateEarClip (copy), UpdateTriangle (copy) ]]
	local v1 = BezierShapeToPolyline(p2)

	if #v1 < 3 then
		return
	end

	local v2 = table.create(#v1)

	for v3, v4 in v1 do
		v2[v3] = { v4[1] / p4, v4[2] / p5 }
	end

	local v5 = TriangulateEarClip(v2)
	local v6 = p1.Triangles or {}

	for v8, v9 in v5 do
		local v7

		if v8 <= #v6 then
			v7 = v6[v8]
		else
			v7 = {}

			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.Image = "rbxassetid://83051256678409"
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Size = UDim2.fromScale(1, 1)
			ImageLabel.Parent = p3
			v7.A = ImageLabel

			local ImageLabel2 = Instance.new("ImageLabel")

			ImageLabel2.Image = "rbxassetid://83051256678409"
			ImageLabel2.BackgroundTransparency = 1
			ImageLabel2.BorderSizePixel = 0
			ImageLabel2.Size = UDim2.fromScale(1, 1)
			ImageLabel2.Parent = p3
			v7.B = ImageLabel2
			table.insert(v6, v7)
		end

		UpdateTriangle(v7, v9[1][1], v9[1][2], v9[2][1], v9[2][2], v9[3][1], v9[3][2], p6, p7)
	end

	for i = #v5 + 1, #v6 do
		v6[i].A.Visible = false
		v6[i].B.Visible = false
	end

	p1.Triangles = v6
end

local function BuildStrokedPath(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) --[[ BuildStrokedPath | Line: 403 | Upvalues: BezierShapeToPolyline (copy), Easing (copy) ]]
	local v1 = BezierShapeToPolyline(p2)

	if #v1 < 2 then
		return
	end

	local v2 = p1.Segments or {}
	local sum = 0
	local t = { 0 }
	local v3 = p11 or 100
	local v4 = p12 or 0
	local v5 = p10 or 0

	for i = 2, #v1 do
		local v6 = v1[i][1] - v1[i - 1][1]
		local v7 = v1[i][2] - v1[i - 1][2]

		sum = sum + math.sqrt(v6 * v6 + v7 * v7)
		t[i] = sum
	end

	local v8 = nil

	if p9 then
		local t2 = {}

		for v9, v10 in p9 do
			if v10.v then
				table.insert(t2, Easing.EvaluateScalar(v10.v, 0))
			end
		end

		if #t2 > 0 then
			v8 = t2
		end
	end

	local v11 = p8 / math.min(p4, p5)
	local count = 0

	for j = 2, #v1 do
		local v12
		local v13 = v1[j - 1]
		local v14 = v1[j]
		local v15 = v14[1] - v13[1]
		local v16 = v14[2] - v13[2]
		local v17 = math.sqrt(v15 * v15 + v16 * v16)

		if not (v17 < 0.01) then
			local v18 = ((t[j - 1] + t[j]) * 0.5 / math.max(sum, 1e-6) * 100 + v4) % 100

			if not (v18 < v5 or v3 < v18) then
				local v19 = true

				if v8 then
					local v20 = t[j - 1]
					local sum2 = 0

					for v21, v22 in v8 do
						sum2 = sum2 + v22
					end

					if sum2 > 0 then
						local sum3 = 0
						local v23 = v20 % sum2

						for v24, v25 in v8 do
							sum3 = sum3 + v25

							if v23 < sum3 then
								v19 = if v24 % 2 == 1 then true else false

								break
							end
						end
					end
				end

				count = count + 1

				if count <= #v2 then
					v12 = v2[count]
				else
					local Frame = Instance.new("Frame")

					Frame.BorderSizePixel = 0
					Frame.AnchorPoint = Vector2.new(0, 0.5)
					Frame.Parent = p3
					table.insert(v2, Frame)
					v12 = Frame
				end

				v12.Visible = v19

				if v19 then
					local v26 = math.atan2(v16, v15) * 57.29577951308232

					v12.Position = UDim2.fromScale(v13[1] / p4, v13[2] / p5)
					v12.Size = UDim2.fromScale(v17 / p4, v11)
					v12.Rotation = v26
					v12.BackgroundColor3 = p6
					v12.BackgroundTransparency = p7
				end
			end
		end
	end

	for k = count + 1, #v2 do
		v2[k].Visible = false
	end

	p1.Segments = v2
end

local function BuildLinearGradient(p1, p2, p3, p4, p5) --[[ BuildLinearGradient | Line: 509 | Upvalues: Easing (copy) ]]
	local UIGradient = Instance.new("UIGradient")
	local p = p2.p
	local v1 = Easing.EvaluateVector(p2.k, p5, {})
	local t = {}

	for i = 0, p - 1 do
		local v2 = i * 4

		table.insert(t, ColorSequenceKeypoint.new(math.clamp(v1[v2 + 1] or i / math.max(p - 1, 1), 0, 1), Color3.new(v1[v2 + 2] or 1, v1[v2 + 3] or 1, v1[v2 + 4] or 1)))
	end

	if #t < 2 then
		t = { ColorSequenceKeypoint.new(0, Color3.new(255/255, 255/255, 255/255)), ColorSequenceKeypoint.new(1, Color3.new(255/255, 255/255, 255/255)) }
	end

	UIGradient.Color = ColorSequence.new(t)

	local v10 = Easing.EvaluateVector(p3, p5, { 0, 0 })
	local v11 = Easing.EvaluateVector(p4, p5, { 1, 0 })

	UIGradient.Rotation = math.atan2(v11[2] - v10[2], v11[1] - v10[1]) * 57.29577951308232
	UIGradient.Parent = p1

	return UIGradient
end

local function BuildRadialGradientApprox(p1, p2, p3, p4, p5, p6, p7) --[[ BuildRadialGradientApprox | Line: 548 | Upvalues: Easing (copy) ]]
	local p = p2.p
	local v1 = Easing.EvaluateVector(p2.k, p5, {})
	local v2 = Easing.EvaluateVector(p3, p5, { p6 / 2, p7 / 2 })
	local v3 = Easing.EvaluateVector(p4, p5, { p6, p7 / 2 })
	local v4 = v2[1]
	local v5 = v2[2]
	local v6 = v3[1] - v4
	local v7 = v3[2] - v5
	local v8 = math.sqrt(v6 * v6 + v7 * v7)
	local v9 = math.min(p, 6)
	local t = {}

	for i = v9, 1, -1 do
		local v10 = i / v9
		local v12 = math.min(math.floor(v10 * (p - 1)), p - 1) * 4
		local v16 = v8 * 2 * v10
		local Frame = Instance.new("Frame")

		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.Position = UDim2.fromScale(v4 / p6, v5 / p7)
		Frame.Size = UDim2.fromScale(v16 / p6, v16 / p7)
		Frame.BackgroundColor3 = Color3.new(v1[v12 + 2] or 1, v1[v12 + 3] or 1, v1[v12 + 4] or 1)
		Frame.BackgroundTransparency = 0
		Frame.BorderSizePixel = 0

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0.5, 0)
		UICorner.Parent = Frame
		Frame.Parent = p1
		table.insert(t, Frame)
	end

	return t
end

local function ApplyTransform(p1, p2, p3, p4, p5, p6, p7, p8) --[[ ApplyTransform | Line: 597 | Upvalues: Easing (copy) ]]
	if p2 == nil then
		return
	end

	local p = p2.p
	local v1 = if p == nil or type(p) ~= "table" then { 0, 0 } elseif p.s == true then { Easing.EvaluateScalarAtFrame(p.x, p3, 0), (Easing.EvaluateScalarAtFrame(p.y, p3, 0)) } else Easing.EvaluateVector(p, p3, { 0, 0 })
	local v3 = Easing.EvaluateVector(p2.s, p3, { 100, 100 })
	local v4 = Easing.EvaluateScalarAtFrame(p2.r, p3, 0)
	local v5 = Easing.EvaluateScalarAtFrame(p2.o, p3, 100)
	local v6 = Easing.EvaluateVector(p2.a, p3, { 0, 0 })
	local v7 = v3[1] / 100
	local v8 = v3[2] / 100

	p1.Position = UDim2.fromScale(v1[1] / p4, v1[2] / p5)
	p1.Rotation = v4
	p1.Size = UDim2.fromScale(p7 * v7, p8 * v8)

	if p6 then
		p1.GroupTransparency = 1 - v5 / 100
	end

	local v9 = p7 * v7 * p4
	local v10 = p8 * v8 * p5

	if v6[1] == 0 and v6[2] == 0 then
		return
	end

	if not (v9 > 0 and v10 > 0) then
		return
	end

	p1.AnchorPoint = Vector2.new(math.clamp(v6[1] / v9, 0, 1), (math.clamp(v6[2] / v10, 0, 1)))
end

local function CollectShapeInfo(p1) --[[ CollectShapeInfo | Line: 651 ]]
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = nil
	local v6 = nil
	local v7 = nil
	local v8 = nil
	local v9 = nil
	local v10 = nil
	local v11 = nil
	local v12 = nil
	local v13 = nil

	for v14, v15 in p1 do
		if not v15.hd then
			local ty = v15.ty

			if ty == "fl" then
				v6 = v15.c
				v7 = v15.o

				continue
			end

			if ty == "st" then
				v8 = v15.c
				v9 = v15.o
				v10 = v15.w
				v12 = v15.da

				continue
			end

			if ty == "sh" then
				v11 = v15.ks

				continue
			end

			if ty == "tr" then
				v4 = v15

				continue
			end

			if ty == "tm" then
				v13 = v15.s
				v1 = v15.e
				v2 = v15.o
				v3 = v15.m

				continue
			end

			if ty == "mm" then
				v5 = v15.mm
			end
		end
	end

	return v6, v7, v8, v9, v10, v11, v12, v13, v1, v2, v3, v4, v5
end

local function v6(p1, p2, p3, p4, p5) --[[ BuildShapeGroup | Line: 696 | Upvalues: CollectShapeInfo (copy), v4 (copy), v3 (copy), ApplyTransform (copy), Easing (copy), BuildFilledPath (copy), BuildStrokedPath (copy), BuildLinearGradient (copy), BuildRadialGradientApprox (copy), v6 (copy) ]]
	local v1 = p1.it or {}
	local v2, v32, v42, v5, v62, v7, v8, v9, v10, v11, _, v12, _2 = CollectShapeInfo(v1)
	local v13 = false

	for v14, v15 in v1 do
		if v15.ty == "tr" then
			local o = v15.o

			if if o == nil then false else o.a == 1 then
				v13 = true

				break
			end
		end
	end

	local v17 = if v13 then Instance.new("CanvasGroup") else Instance.new("Frame")

	v17.BackgroundTransparency = 1
	v17.BorderSizePixel = 0
	v17.Size = v4
	v17.Position = v3
	v17.Parent = p2

	if v12 then
		ApplyTransform(v17, {
			a = v12.a,
			p = v12.p,
			s = v12.s,
			r = v12.r,
			o = v12.o
		}, p5, p3, p4, v13, 1, 1)
	end

	local t = {
		Shape = p1,
		Frame = v17,
		Children = {},
		FillColor = v2,
		FillOpacity = v32,
		StrokeColor = v42,
		StrokeOpacity = v5,
		StrokeWidth = v62,
		PathData = v7
	}

	t.IsAnimatedPath = if v7 == nil then false elseif v7.a == 1 then true else false

	local v19 = Easing.EvaluateColor(v2, p5)
	local v20 = 1 - Easing.EvaluateScalarAtFrame(v32, p5, 100) / 100
	local v21 = Easing.EvaluateColor(v42, p5)
	local v22 = 1 - Easing.EvaluateScalarAtFrame(v5, p5, 100) / 100
	local v23 = Easing.EvaluateScalarAtFrame(v62, p5, 0)
	local v24 = Easing.EvaluateScalarAtFrame(v9, p5, 0)
	local v25 = Easing.EvaluateScalarAtFrame(v10, p5, 100)
	local v26 = Easing.EvaluateScalarAtFrame(v11, p5, 0)
	local v27 = 0

	for v28, v29 in v1 do
		if v29.ty == "op" and v29.a then
			v27 = Easing.EvaluateScalarAtFrame(v29.a, p5, 0)
		end
	end

	for v31, v322 in v1 do
		if not v322.hd then
			local ty = v322.ty

			if ty == "sh" then
				local v33 = Easing.EvaluateBezierShape(v322.ks, p5)

				if v33 and v27 ~= 0 then
					local sum = 0
					local sum2 = 0

					for v34, v35 in v33.v do
						sum = sum + v35[1]
						sum2 = sum2 + v35[2]
					end

					local v36 = sum / #v33.v
					local v37 = sum2 / #v33.v
					local v40 = v27 / math.max(math.sqrt((v33.v[1][1] - v36) ^ 2 + (v33.v[1][2] - v37) ^ 2), 1) + 1
					local v41 = table.create(#v33.v)

					for v422, v43 in v33.v do
						v41[v422] = { v36 + (v43[1] - v36) * v40, v37 + (v43[2] - v37) * v40 }
					end

					v33 = {
						v = v41,
						i = v33.i,
						o = v33.o,
						c = v33.c
					}
				end

				if v33 then
					if v2 then
						BuildFilledPath(t, v33, v17, p3, p4, v19, v20)
					end

					if v42 and v23 > 0 then
						BuildStrokedPath(t, v33, v17, p3, p4, v21, v22, v23, v8, v24, v25, v26)
					end
				end

				continue
			end

			if ty == "rc" then
				local Frame = Instance.new("Frame")

				Frame.BorderSizePixel = 0

				local v44 = Easing.EvaluateVector(v322.s, p5, { 100, 100 })
				local v45 = Easing.EvaluateVector(v322.p, p5, { 0, 0 })
				local v46 = Easing.EvaluateScalarAtFrame(v322.r, p5, 0)

				Frame.Size = UDim2.fromScale(v44[1] / p3, v44[2] / p4)
				Frame.Position = UDim2.fromScale(v45[1] / p3, v45[2] / p4)
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)

				if v2 then
					Frame.BackgroundColor3 = v19
					Frame.BackgroundTransparency = v20
				else
					Frame.BackgroundTransparency = 1
				end

				if v46 > 0 then
					local UICorner = Instance.new("UICorner")

					UICorner.CornerRadius = UDim.new(0, v46)
					UICorner.Parent = Frame
					t.UICorner = UICorner
				end

				if v42 and v23 > 0 then
					local UIStroke = Instance.new("UIStroke")

					UIStroke.Color = v21
					UIStroke.Transparency = v22
					UIStroke.Thickness = v23 / math.min(p3, p4)
					UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

					if not pcall(function() --[[ Line: 836 | Upvalues: UIStroke (copy) ]]
						UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
					end) then
						UIStroke.Thickness = v23
					end

					UIStroke.Parent = Frame
					t.UIStroke = UIStroke
				end

				Frame.Parent = v17
				t.Frame = Frame

				continue
			end

			if ty == "el" then
				local Frame = Instance.new("Frame")

				Frame.BorderSizePixel = 0

				local v47 = Easing.EvaluateVector(v322.s, p5, { 100, 100 })
				local v48 = Easing.EvaluateVector(v322.p, p5, { 0, 0 })

				Frame.Size = UDim2.fromScale(v47[1] / p3, v47[2] / p4)
				Frame.Position = UDim2.fromScale(v48[1] / p3, v48[2] / p4)
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)

				if v2 then
					Frame.BackgroundColor3 = v19
					Frame.BackgroundTransparency = v20
				else
					Frame.BackgroundTransparency = 1
				end

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = UDim.new(0.5, 0)
				UICorner.Parent = Frame
				t.UICorner = UICorner

				if v42 and v23 > 0 then
					local UIStroke = Instance.new("UIStroke")

					UIStroke.Color = v21
					UIStroke.Transparency = v22
					UIStroke.Thickness = v23 / math.min(p3, p4)
					UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					pcall(function() --[[ Line: 877 | Upvalues: UIStroke (copy) ]]
						UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
					end)
					UIStroke.Parent = Frame
					t.UIStroke = UIStroke
				end

				Frame.Parent = v17
				t.Frame = Frame

				continue
			end

			if ty == "gf" or ty == "gs" then
				local v49 = v322.t or 1

				if v322.g then
					if v49 == 1 then
						t.UIGradient = BuildLinearGradient(v17, v322.g, v322.s, v322.e, p5)

						continue
					end

					if v49 == 2 then
						BuildRadialGradientApprox(v17, v322.g, v322.s, v322.e, p5, p3, p4)
					end
				end

				continue
			end

			if ty == "gr" then
				local v50 = v6(v322, v17, p3, p4, p5)

				if t.Children then
					table.insert(t.Children, v50)
				end

				continue
			end

			if ty == "rp" then
				local v51 = Easing.EvaluateScalarAtFrame(v322.c, p5, 1)
				local tr = v322.tr

				if tr and v51 > 1 then
					local v52 = Easing.EvaluateScalarAtFrame(tr.so, p5, 100)
					local v53 = Easing.EvaluateScalarAtFrame(tr.eo, p5, 100)

					for i = 0, math.floor(v51) - 1 do
						local Frame = Instance.new("Frame")

						Frame.BackgroundTransparency = 1
						Frame.BorderSizePixel = 0
						Frame.Size = v4
						Frame.BackgroundTransparency = 1 - math.lerp(v52, v53, i / math.max(v51 - 1, 1)) / 100

						local _3 = {
							p = tr.p,
							s = tr.s,
							r = tr.r,
							a = tr.a,
							o = tr.o
						}
						local v55 = Easing.EvaluateVector(tr.p, p5, { 0, 0 })

						Easing.EvaluateVector(tr.s, p5, { 100, 100 })

						local v56 = Easing.EvaluateScalarAtFrame(tr.r, p5, 0)

						Frame.Position = UDim2.fromScale(v55[1] * i / p3, v55[2] * i / p4)
						Frame.Rotation = v56 * i
						Frame.Parent = v17

						for v57, v58 in v1 do
							if v58.ty == "gr" and v58 ~= p1 then
								v6(v58, Frame, p3, p4, p5)
							end
						end
					end
				end
			end
		end
	end

	return t
end

local function BuildShapeLayer(p1, p2, p3, p4, p5) --[[ BuildShapeLayer | Line: 950 | Upvalues: v6 (copy) ]]
	local shapes = p1.shapes

	if shapes == nil then
		return {}
	end

	local t = {}

	for i = #shapes, 1, -1 do
		local v1 = shapes[i]

		if not v1.hd and v1.ty == "gr" then
			table.insert(t, (v6(v1, p2, p3, p4, p5)))
		end
	end

	return t
end

local function BuildTextLayer(p1, p2, p3, p4, p5) --[[ BuildTextLayer | Line: 967 | Upvalues: v4 (copy) ]]
	local t = p1.t

	if t == nil then
		return nil
	end

	local d = t.d

	if d == nil then
		return nil
	end

	local k = d.k

	if k == nil or #k == 0 then
		return nil
	end

	local v1 = nil

	for v2, v3 in k do
		if v3.t == nil or v3.t <= p5 then
			v1 = v3.s
		end
	end

	if v1 == nil then
		v1 = k[1].s
	end

	if v1 == nil then
		return nil
	end

	local TextLabel = Instance.new("TextLabel")

	TextLabel.BackgroundTransparency = 1
	TextLabel.BorderSizePixel = 0
	TextLabel.Size = v4
	TextLabel.Text = v1.t or ""
	TextLabel.TextScaled = false
	TextLabel.RichText = false
	TextLabel.TextSize = (v1.s or 24) / p4 * 100

	if v1.fc then
		local fc = v1.fc

		TextLabel.TextColor3 = Color3.new(fc[1] or 1, fc[2] or 1, fc[3] or 1)
	end

	local v42 = v1.j or 0

	if v42 == 0 then
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	elseif v42 == 1 then
		TextLabel.TextXAlignment = Enum.TextXAlignment.Right
	else
		TextLabel.TextXAlignment = Enum.TextXAlignment.Center
	end

	TextLabel.TextYAlignment = Enum.TextYAlignment.Top

	if v1.f then
		local ok, result = pcall(function() --[[ Line: 1013 | Upvalues: v1 (ref) ]]
			return Enum.Font[v1.f]
		end)

		if ok and result then
			TextLabel.Font = result
		else
			TextLabel.Font = Enum.Font.GothamMedium
		end
	end

	TextLabel.Parent = p2

	return TextLabel
end

local function BuildImageLayer(p1, p2, p3, p4, p5) --[[ BuildImageLayer | Line: 1027 | Upvalues: v4 (copy), v5 (ref), EncodingService (copy), AssetService (copy) ]]
	local refId = p1.refId

	if refId == nil then
		return nil
	end

	local v1 = p3[refId]

	if v1 == nil then
		return nil
	end

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = v4
	ImageLabel.ScaleType = Enum.ScaleType.Stretch

	if v1.e == 1 and v1.p then
		local p = v1.p

		if string.sub(p, 1, 22) == "data:image/png;base64," then
			local v2 = string.sub(p, 23)

			if v5 then
				local ok, result = pcall(function() --[[ Line: 1053 | Upvalues: EncodingService (ref), v2 (copy), v5 (ref) ]]
					return v5.decode((EncodingService:Base64Decode(buffer.fromstring(v2))))
				end)

				if ok and result then
					local ok2, result2 = pcall(function() --[[ Line: 1058 | Upvalues: AssetService (ref), result (copy) ]]
						return AssetService:CreateEditableImage({
							Size = Vector2.new(result.width, result.height)
						})
					end)

					if ok2 and (result2 and pcall(function() --[[ Line: 1062 | Upvalues: result2 (copy), result (copy) ]]
						result2:WritePixelsBuffer(Vector2.zero, Vector2.new(result.width, result.height), result.pixels)
					end)) then
						ImageLabel.ImageContent = Content.fromObject(result2)
					end
				end
			end
		elseif string.sub(p, 1, 23) == "data:image/jpeg;base64," then
			warn("[Lottie] Embedded JPEG not supported, skipping image layer:", p1.nm or "")
		end
	elseif v1.p and not v1.e then
		ImageLabel.Image = v1.p
	end

	ImageLabel.Parent = p2

	return ImageLabel
end

local function BuildDropShadow(p1, p2, p3, p4, p5) --[[ BuildDropShadow | Line: 1086 | Upvalues: Easing (copy), v2 (copy) ]]
	local ef = p1.ef

	if ef == nil then
		return
	end

	for v1, v22 in ef do
		if v22.ty == 25 then
			local ef2 = v22.ef

			if ef2 ~= nil then
				local v3 = Color3.new(0/255, 0/255, 0/255)
				local v4 = 0
				local v5 = 5
				local v6 = 5
				local v7 = 0.5

				for v8, v9 in ef2 do
					local ty = v9.ty

					if ty ~= nil then
						if ty == 1 then
							v3 = Easing.EvaluateColor(v9.v, p5)

							continue
						end

						if ty == 0 then
							v7 = Easing.EvaluateScalarAtFrame(v9.v, p5, 128) / 255

							continue
						end

						if ty == 3 then
							v4 = Easing.EvaluateScalarAtFrame(v9.v, p5, 0)

							continue
						end

						if ty == 2 then
							v5 = Easing.EvaluateScalarAtFrame(v9.v, p5, 5)

							continue
						end

						if ty == 4 then
							v6 = Easing.EvaluateScalarAtFrame(v9.v, p5, 5)
						end
					end
				end

				local v14 = math.rad(v4 + 180)
				local v15 = math.cos(v14) * v5 / p3
				local v16 = math.sin(v14) * v5 / p4
				local v17 = (v6 * 2 + math.max(p3, p4)) / math.max(p3, p4)
				local ImageLabel = Instance.new("ImageLabel")

				ImageLabel.Image = "rbxassetid://100849323991833"
				ImageLabel.ScaleType = Enum.ScaleType.Slice
				ImageLabel.SliceCenter = v2
				ImageLabel.ImageColor3 = v3
				ImageLabel.ImageTransparency = 1 - v7
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.BorderSizePixel = 0
				ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel.Position = UDim2.fromScale(v15 + 0.5, v16 + 0.5)
				ImageLabel.Size = UDim2.fromScale(v17, v17)
				ImageLabel.ZIndex = -1
				ImageLabel.Parent = p2

				return
			end
		end
	end
end

local function v7(p1, p2, p3, p4, p5, p6) --[[ BuildLayers | Line: 1148 | Upvalues: v4 (copy), BuildShapeLayer (copy), BuildTextLayer (copy), BuildImageLayer (copy), v7 (copy), BuildDropShadow (copy), Easing (copy), ApplyTransform (copy) ]]
	local t = {}
	local t2 = {}

	for i = #p1, 1, -1 do
		local v1, v2, v3
		local v42 = p1[i]

		if not v42.hd then
			local ty = v42.ty
			local ks = v42.ks

			if ks == nil then
				v1 = false
			else
				local o = ks.o

				v1 = if o == nil then false elseif o.a == 1 then true else false
			end

			if ty == 1 then
				local Frame = Instance.new("Frame")

				Frame.BorderSizePixel = 0

				if v42.sc then
					local sc = v42.sc

					v2 = Color3.fromRGB(tonumber(string.sub(sc, 2, 3), 16) or 0, tonumber(string.sub(sc, 4, 5), 16) or 0, tonumber(string.sub(sc, 6, 7), 16) or 0)
				else
					v2 = Color3.new(0/255, 0/255, 0/255)
				end

				Frame.BackgroundColor3 = v2
				Frame.BackgroundTransparency = 0
				Frame.Size = UDim2.fromScale((v42.sw or p4) / p4, (v42.sh or p5) / p5)
				v3 = Frame
			elseif v1 then
				local CanvasGroup = Instance.new("CanvasGroup")

				CanvasGroup.BackgroundTransparency = 1
				CanvasGroup.BorderSizePixel = 0
				CanvasGroup.Size = v4
				v3 = CanvasGroup
			else
				local Frame = Instance.new("Frame")

				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				Frame.Size = v4
				v3 = Frame
			end

			local nm = v42.nm

			if not nm then
				nm = ("Layer_%*"):format(v42.ind or i)
			end

			v3.Name = nm

			local Scale = v3.Size.X.Scale
			local Scale2 = v3.Size.Y.Scale
			local t3 = {
				Layer = v42,
				Frame = v3,
				BaseSizeX = Scale,
				BaseSizeY = Scale2
			}

			if v42.ind then
				t2[v42.ind] = t3
			end

			if ty == 4 then
				t3.Shapes = BuildShapeLayer(v42, v3, p4, p5, p6)
			elseif ty == 5 then
				t3.TextLabel = BuildTextLayer(v42, v3, p4, p5, p6)
			elseif ty == 2 then
				t3.ImageLabel = BuildImageLayer(v42, v3, p3, p4, p5)
			elseif ty == 0 then
				local refId = v42.refId

				if refId and p3[refId] then
					local v13 = p3[refId]

					if v13.layers then
						local v14 = v42.w or (v13.w or p4)
						local v15 = v42.h or (v13.h or p5)

						v3.ClipsDescendants = true
						v3.Size = UDim2.fromScale(v14 / p4, v15 / p5)
						t3.Children = v7(v13.layers, v3, p3, v14, v15, p6)
					end
				end
			end

			BuildDropShadow(v42, v3, p4, p5, p6)

			if v42.masksProperties then
				for v16, v17 in v42.masksProperties do
					if v17.mode == "a" or v17.mode == nil then
						local v18 = Easing.EvaluateBezierShape(v17.pt, p6)

						if v18 then
							local v19 = (1 / 0)
							local v20 = (1 / 0)
							local v21 = (-1 / 0)
							local v22 = (-1 / 0)

							for v23, v24 in v18.v do
								v19, v20, v21, v22 = math.min(v19, v24[1]), math.min(v20, v24[2]), math.max(v21, v24[1]), math.max(v22, v24[2])
							end

							local Frame = Instance.new("Frame")

							Frame.BackgroundTransparency = 1
							Frame.BorderSizePixel = 0
							Frame.ClipsDescendants = true
							Frame.Position = UDim2.fromScale(v19 / p4, v20 / p5)
							Frame.Size = UDim2.fromScale((v21 - v19) / p4, (v22 - v20) / p5)
							Frame.Parent = p2
							v3.Parent = Frame
							t3.MatteClip = Frame
						end
					end
				end
			end

			ApplyTransform(v3, v42.ks, p6, p4, p5, v1, Scale, Scale2)

			local v33 = p6 - (v42.st or 0)

			v3.Visible = if v42.ip <= v33 then v33 < v42.op else false
			table.insert(t, t3)
		end
	end

	for v35, v36 in t do
		local Layer = v36.Layer

		if Layer.parent and t2[Layer.parent] then
			v36.Frame.Parent = t2[Layer.parent].Frame

			continue
		end

		if v36.MatteClip == nil then
			v36.Frame.Parent = p2
		end
	end

	for j = 1, #t - 1 do
		local v38 = t[j]
		local v39 = t[j + 1]

		if v39.Layer.tt then
			local v40 = nil

			for v42, v43 in v38.Shapes or {} do
				if v43.PathData then
					v40 = Easing.EvaluateBezierShape(v43.PathData, p6)

					break
				end
			end

			if v40 then
				local v45 = (1 / 0)
				local v46 = (1 / 0)
				local v47 = (-1 / 0)
				local v48 = (-1 / 0)

				for v49, v50 in v40.v do
					v45, v46, v47, v48 = math.min(v45, v50[1]), math.min(v46, v50[2]), math.max(v47, v50[1]), math.max(v48, v50[2])
				end

				local Frame = Instance.new("Frame")

				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				Frame.ClipsDescendants = true
				Frame.Position = UDim2.fromScale(v45 / p4, v46 / p5)
				Frame.Size = UDim2.fromScale((v47 - v45) / p4, (v48 - v46) / p5)
				Frame.Parent = p2
				v39.Frame.Parent = Frame
				v39.MatteClip = Frame
				v38.Frame.Visible = false
			end
		end
	end

	return t
end

local v8 = nil

local function v9(p1, p2, p3, p4) --[[ RenderLayerNodes | Line: 1314 | Upvalues: ApplyTransform (copy), v8 (ref), Easing (copy), v9 (copy) ]]
	for v1, v2 in p1 do
		local Layer = v2.Layer
		local v3 = p2 - (Layer.st or 0)
		local v4 = if Layer.ip <= v3 then if v3 < Layer.op then true else false else false

		v2.Frame.Visible = v4

		if v4 then
			ApplyTransform(v2.Frame, Layer.ks, v3, p3, p4, v2.Frame:IsA("CanvasGroup"), v2.BaseSizeX, v2.BaseSizeY)

			if v2.Shapes then
				for v6, v7 in v2.Shapes do
					v8(v7, v3, p3, p4)
				end
			end

			if v2.Children then
				v9(v2.Children, if Layer.tm then Easing.EvaluateScalarAtFrame(Layer.tm, v3, 0) * (Layer.op - Layer.ip) else v3, Layer.w or p3, Layer.h or p4)
			end

			if v2.TextLabel and Layer.t then
				local d = Layer.t.d

				if d and d.k then
					local v11 = nil

					for v12, v13 in d.k do
						if v13.t == nil or v13.t <= v3 then
							v11 = v13.s
						end
					end

					if v11 then
						v2.TextLabel.Text = v11.t or ""

						if v11.fc then
							v2.TextLabel.TextColor3 = Color3.new(v11.fc[1] or 1, v11.fc[2] or 1, v11.fc[3] or 1)
						end
					end
				end
			end
		end
	end
end

v8 = function(p1, p2, p3, p4) --[[ Line: 1368 | Upvalues: v8 (ref), Easing (copy), BuildFilledPath (copy), BuildStrokedPath (copy) ]]
	if p1.Children then
		for v1, v2 in p1.Children do
			v8(v2, p2, p3, p4)
		end
	end

	if p1.IsAnimatedPath and p1.PathData then
		local v3 = Easing.EvaluateBezierShape(p1.PathData, p2)

		if v3 and p1.Frame then
			local v4 = Easing.EvaluateColor(p1.FillColor, p2)
			local v5 = Easing.EvaluateScalarAtFrame(p1.FillOpacity, p2, 100)

			if p1.FillColor then
				BuildFilledPath(p1, v3, p1.Frame, p3, p4, v4, 1 - v5 / 100)
			end

			if p1.StrokeColor then
				local v6 = Easing.EvaluateColor(p1.StrokeColor, p2)
				local v7 = Easing.EvaluateScalarAtFrame(p1.StrokeOpacity, p2, 100)
				local v82 = Easing.EvaluateScalarAtFrame(p1.StrokeWidth, p2, 0)

				if v82 > 0 then
					BuildStrokedPath(p1, v3, p1.Frame, p3, p4, v6, 1 - v7 / 100, v82)
				end
			end
		end
	elseif p1.FillColor then
		local FillColor = p1.FillColor

		if if FillColor == nil then false else FillColor.a == 1 then
			local v10 = Easing.EvaluateColor(p1.FillColor, p2)
			local v11 = 1 - Easing.EvaluateScalarAtFrame(p1.FillOpacity, p2, 100) / 100

			if p1.Triangles then
				for v12, v13 in p1.Triangles do
					if v13.A.Visible then
						v13.A.ImageColor3 = v10
						v13.A.ImageTransparency = v11
					end

					if v13.B.Visible then
						v13.B.ImageColor3 = v10
						v13.B.ImageTransparency = v11
					end
				end
			end

			if p1.Frame and p1.Frame.BackgroundTransparency < 1 then
				p1.Frame.BackgroundColor3 = v10
				p1.Frame.BackgroundTransparency = v11
			end
		end
	end

	if not p1.StrokeColor then
		return
	end

	local StrokeColor = p1.StrokeColor

	if not (if StrokeColor == nil then false elseif StrokeColor.a == 1 then true else false) then
		return
	end

	local v15 = Easing.EvaluateColor(p1.StrokeColor, p2)
	local v16 = Easing.EvaluateScalarAtFrame(p1.StrokeOpacity, p2, 100)

	if p1.Segments then
		for v17, v18 in p1.Segments do
			if v18.Visible then
				v18.BackgroundColor3 = v15
				v18.BackgroundTransparency = 1 - v16 / 100
			end
		end
	end

	if not p1.UIStroke then
		return
	end

	p1.UIStroke.Color = v15
	p1.UIStroke.Transparency = 1 - v16 / 100
end

local function Parse(p1) --[[ Parse | Line: 1437 | Upvalues: HttpService (copy) ]]
	return HttpService:JSONDecode(p1)
end

local function Create(p1) --[[ Create | Line: 1441 | Upvalues: v4 (copy), v7 (copy) ]]
	local w = p1.w
	local h = p1.h
	local ip = p1.ip
	local Frame = Instance.new("Frame")

	Frame.Name = p1.nm or "LottieAnimation"
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.ClipsDescendants = true
	Frame.Size = v4

	local t = {}

	if p1.assets then
		for v1, v2 in p1.assets do
			t[v2.id] = v2
		end
	end

	return {
		Animation = p1,
		Root = Frame,
		Layers = v7(p1.layers, Frame, t, w, h, ip),
		AssetMap = t,
		Duration = (p1.op - ip) / p1.fr,
		Width = w,
		Height = h
	}
end

local function Render(p1, p2) --[[ Render | Line: 1476 | Upvalues: v9 (copy) ]]
	local Animation = p1.Animation
	local ip = Animation.ip

	v9(p1.Layers, ip + p2 * Animation.fr % (Animation.op - ip), p1.Width, p1.Height)
end

local function Destroy(p1) --[[ Destroy | Line: 1487 ]]
	p1.Root:Destroy()
	table.clear(p1.Layers)
	table.clear(p1.AssetMap)
end

return table.freeze({
	Parse = Parse,
	Create = Create,
	Render = Render,
	Destroy = Destroy
})