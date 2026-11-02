--credit to leon games studio
local t = {
	StartOrder = 2
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gardens = workspace:WaitForChild("Gardens")
local PlotAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("PlotAssets")
local TopLayer = workspace:WaitForChild("Baseplate").TopLayer
local v1 = nil
local v2 = nil
local t2 = {}
local t3 = {}
local t4 = {}

local function getModelSize(p1) --[[ getModelSize | Line: 30 ]]
	local BottomFace = p1:FindFirstChild("BottomFace", true)

	return BottomFace and BottomFace:IsA("BasePart") and BottomFace.Size or p1:GetExtentsSize()
end

local function initSizes() --[[ initSizes | Line: 35 | Upvalues: v1 (ref), PlotAssets (copy), v2 (ref) ]]
	if v1 then
		return
	end

	local BedSection = PlotAssets.BedSection
	local BottomFace = BedSection:FindFirstChild("BottomFace", true)
	local v12, v22

	if BottomFace and BottomFace:IsA("BasePart") then
		v12 = BottomFace.Size

		if not v12 then
			v22 = BedSection:GetExtentsSize()
			v12 = v22
		end
	else
		v22 = BedSection:GetExtentsSize()
		v12 = v22
	end

	v1 = v12

	local FRONT_BedSection = PlotAssets.FRONT_BedSection
	local BottomFace2 = FRONT_BedSection:FindFirstChild("BottomFace", true)
	local v3, v4

	if BottomFace2 and BottomFace2:IsA("BasePart") then
		v3 = BottomFace2.Size

		if not v3 then
			v4 = FRONT_BedSection:GetExtentsSize()
			v3 = v4
		end
	else
		v4 = FRONT_BedSection:GetExtentsSize()
		v3 = v4
	end

	v2 = v3
end

local function alignModel(p1, p2) --[[ alignModel | Line: 41 ]]
	local BottomFace = p1:FindFirstChild("BottomFace", true)

	if not (BottomFace and BottomFace:IsA("BasePart")) then
		return
	end

	local Y = (BottomFace.CFrame * CFrame.new(0, -BottomFace.Size.Y * 0.5, 0)).Position.Y

	if not (math.abs(p2 - Y) > 0.0001) then
		return
	end

	p1:TranslateBy((Vector3.new(0, p2 - Y, 0)))
end

local function getFenceThemeAssets(p1) --[[ getFenceThemeAssets | Line: 51 | Upvalues: PlotAssets (copy) ]]
	local FenceThemes = PlotAssets:FindFirstChild("FenceThemes")
	local v1 = if FenceThemes then FenceThemes:FindFirstChild("Default") else FenceThemes
	local v2 = if typeof(p1) == "string" and (p1 ~= "" and p1) then p1 else "Default"
	local v3 = if FenceThemes then FenceThemes:FindFirstChild(v2) else FenceThemes

	if not v3 then
		v3 = v1
		v2 = "Default"
	end

	if not v3 then
		return nil, nil, "Default"
	end

	local FencePole = v3:FindFirstChild("FencePole")
	local FenceConnectors = v3:FindFirstChild("FenceConnectors")

	if v1 then
		local v4 = if FencePole then FencePole else v1:FindFirstChild("FencePole")

		FencePole, FenceConnectors = v4, if FenceConnectors then FenceConnectors else v1:FindFirstChild("FenceConnectors")
	end

	return FencePole, FenceConnectors, v2
end

local function updatePlotVisual(p1, p2, p3) --[[ updatePlotVisual | Line: 75 | Upvalues: v1 (ref), PlotAssets (copy), v2 (ref), t2 (copy), getFenceThemeAssets (copy), TopLayer (copy), alignModel (copy) ]]
	if not v1 then
		local BedSection = PlotAssets.BedSection
		local BottomFace = BedSection:FindFirstChild("BottomFace", true)

		v1 = BottomFace and BottomFace:IsA("BasePart") and BottomFace.Size or BedSection:GetExtentsSize()

		local FRONT_BedSection = PlotAssets.FRONT_BedSection
		local BottomFace2 = FRONT_BedSection:FindFirstChild("BottomFace", true)

		v2 = BottomFace2 and BottomFace2:IsA("BasePart") and BottomFace2.Size or FRONT_BedSection:GetExtentsSize()
	end

	local v3 = t2[p2]

	if not v3 then
		v3 = {
			fenceSkin = "Default",
			poles = {},
			connectors = {},
			beds = {}
		}
		t2[p2] = v3
		-- Primer render del plot: borrar las piezas estaticas (puestas a mano en el
		-- Studio). El controller es el unico dueño de canteros/cercas y las recrea
		-- en el MISMO lugar para la base (verificado: front beds en Z=-2 y misma
		-- cerca), asi que la base no cambia. Si no se borran, al expandir el set
		-- generado se mueve y las estaticas quedan atras -> duplicados. Las
		-- plantillas viven en ReplicatedStorage.Assets.PlotAssets, no aca.
		for v9, v10 in p2:GetChildren() do
			if v10.Name == "FencePole" or v10.Name == "FenceConnectors" or v10.Name == "BedSection" or v10.Name == "FRONT_BedSection" then
				v10:Destroy()
			end
		end
	end

	local v4, v5, v6 = getFenceThemeAssets(p3)

	if not (v4 and v5) then
		return
	end

	if v3.fenceSkin ~= v6 then
		for v7, v8 in v3.poles do
			v8:Destroy()
		end

		for v9, v10 in v3.connectors do
			v10:Destroy()
		end

		v3.poles = {}
		v3.connectors = {}
		v3.fenceSkin = v6
	end

	local BottomFace = v4:FindFirstChild("BottomFace", true)
	local v11 = BottomFace and BottomFace:IsA("BasePart") and BottomFace.Size or v4:GetExtentsSize()
	local BottomFace2 = v5:FindFirstChild("BottomFace", true)
	local v12 = BottomFace2 and BottomFace2:IsA("BasePart") and BottomFace2.Size or v5:GetExtentsSize()
	local v13 = v11.X + v12.X
	local v14 = math.ceil(18 / v13)
	local v15 = TopLayer.Position.Y + TopLayer.Size.X * 0.5
	local v18 = math.max(1, math.floor((p1.Size.Z - v2.X) / (v1.X + 0)) + 1)
	local v19 = v2.X + (v18 - 1) * (v1.X + 0)

	local function centerCount(p1, p2) --[[ centerCount | Line: 110 ]]
		if not (p2 > 0) then
			return math.max(p1, 1)
		end

		local v1 = math.max(p1, p2 + 2)

		return (v1 - p2) % 2 ~= 0 and v1 + 1 or v1
	end

	local v22 = math.ceil((2 * v1.Z + 11 + 5) / v13)
	local v23

	if v14 > 0 then
		local v24 = math.max(v22, v14 + 2)

		v23 = (v24 - v14) % 2 ~= 0 and v24 + 1 or v24
	else
		v23 = math.max(v22, 1)
	end

	local v27 = math.max(1, (math.ceil((v19 + 4) / v13)))
	local v28 = v23 * v13 * 0.5
	local v29 = v27 * v13 * 0.5
	local v30 = p1.Size.Z * 0.5 - v29
	local v31 = 1
	local v32 = 1
	local t = {}
	local t3 = {}

	local function placeLine(p1, p22, p3, p4, p5) --[[ placeLine | Line: 132 | Upvalues: v3 (ref), v31 (ref), v4 (copy), p2 (copy), t (copy), v13 (copy), alignModel (ref), v15 (copy), v32 (ref), v5 (copy), t3 (copy), v11 (copy), v12 (copy) ]]
		local v1 = p4 and math.floor((p3 - p5) / 2 + 1e-6) or -1
		local v2 = p4 and v1 + p5 - 1 or -1

		for i = 0, p3 do
			if not (p4 and (v1 + 1 <= i and i <= v2)) then
				local v33 = v3.poles[v31] or v4:Clone()

				if not v3.poles[v31] then
					v33.Parent = p2
				end

				t[v31] = v33
				v33:PivotTo(CFrame.lookAt(p1 + p22 * (i * v13), p1 + p22 * (i * v13) + p22) * CFrame.Angles(0, 1.5707963267948966, 0))
				alignModel(v33, v15)
				v31 = v31 + 1
			end
		end

		for j = 0, p3 - 1 do
			if not (p4 and (v1 <= j and j <= v2)) then
				local v42 = v3.connectors[v32] or v5:Clone()

				if not v3.connectors[v32] then
					v42.Parent = p2
				end

				t3[v32] = v42

				local v52 = p1 + p22 * (j * v13 + v11.X * 0.5 + v12.X * 0.5)

				v42:PivotTo(CFrame.lookAt(v52, v52 + p22) * CFrame.Angles(0, 1.5707963267948966, 0))
				alignModel(v42, v15)
				v32 = v32 + 1
			end
		end
	end

	local v33 = p1.CFrame

	placeLine(v33:PointToWorldSpace((Vector3.new(-v28, 0, -v29 + v30))), v33:VectorToWorldSpace(Vector3.new(1, 0, 0)), v23, false, 0)
	placeLine(v33:PointToWorldSpace((Vector3.new(v28, 0, -v29 + v30))), v33:VectorToWorldSpace(Vector3.new(0, 0, 1)), v27, false, 0)
	placeLine(v33:PointToWorldSpace((Vector3.new(v28, 0, v29 + v30))), v33:VectorToWorldSpace(Vector3.new(-1, 0, 0)), v23, true, v14)
	placeLine(v33:PointToWorldSpace((Vector3.new(-v28, 0, v29 + v30))), v33:VectorToWorldSpace(Vector3.new(0, 0, -1)), v27, false, 0)

	for i = v31, #v3.poles do
		v3.poles[i]:Destroy()
	end

	for j = v32, #v3.connectors do
		v3.connectors[j]:Destroy()
	end

	v3.poles = t
	v3.connectors = t3

	local v34 = -(v1.Z * 0.5 + 5.5)
	local v35 = v1.Z * 0.5 + 5.5
	local v37 = p1.Size.Z * 0.5 - 2 - v2.X * 0.5
	local v38 = -v19 * 0.5 + v1.X * 0.5 + (v37 - (-v19 * 0.5 + (v18 - 1) * (v1.X + 0) + v2.X * 0.5))
	local t4 = {}
	local count = 1

	for k = 1, 2 do
		local v39 = if k == 1 and v34 then v34 else v35

		for n = 1, v18 do
			local v40
			local v41 = if n == v18 then true else false
			local v43 = v41 and PlotAssets.FRONT_BedSection or PlotAssets.BedSection
			local v44 = v3.beds[count]

			if v44 and v44.Name ~= v43.Name then
				v44:Destroy()
				v44 = nil
			end

			if not v44 then
				local v45 = v43:Clone()

				v45.Parent = p2
				v44 = v45
			end

			t4[count] = v44
			v40 = if v41 and v37 then v37 else v38 + (n - 1) * (v1.X + 0)
			v44:PivotTo(v33 * CFrame.new(v39, v15 - p1.Position.Y + (v41 and v2 or v1).Y * 0.5, v40) * CFrame.Angles(0, 1.5707963267948966, 0))
			alignModel(v44, v15)
			count = count + 1
		end
	end

	for m = count, #v3.beds do
		v3.beds[m]:Destroy()
	end

	v3.beds = t4
end

local function clearPlotVisual(p1) --[[ clearPlotVisual | Line: 217 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	for v2, v3 in v1.poles do
		v3:Destroy()
	end

	for v4, v5 in v1.connectors do
		v5:Destroy()
	end

	for v6, v7 in v1.beds do
		v7:Destroy()
	end

	t2[p1] = nil
end

function t.RenderPlot(p1, p2) --[[ RenderPlot | Line: 226 | Upvalues: t4 (copy), updatePlotVisual (copy) ]]
	if not t4[p2] then
		t4[p2] = true
		task.defer(function() --[[ Line: 229 | Upvalues: t4 (ref), p2 (copy), updatePlotVisual (ref) ]]
			t4[p2] = nil

			local PlotSizeReference = p2:FindFirstChild("PlotSizeReference")
			local Visual = p2:FindFirstChild("Visual")

			if not (PlotSizeReference and Visual) then
				return
			end

			if not (PlotSizeReference:IsA("BasePart") and Visual:IsA("Folder")) then
				return
			end

			local v1 = p2:GetAttribute("FenceSkin")
			local v3, v4, v5

			if typeof(v1) == "string" and v1 then
				v3 = PlotSizeReference
				v4 = Visual
				v5 = v1
			else
				v3 = PlotSizeReference
				v4 = Visual
				v5 = "Default"
			end

			updatePlotVisual(v3, v4, v5)
		end)
	end
end
function t.SetupPlot(p1, p2) --[[ SetupPlot | Line: 241 | Upvalues: t3 (copy), clearPlotVisual (copy) ]]
	if not p2:IsA("Model") then
		return
	end

	if not string.match(p2.Name, "^Plot%d+$") then
		return
	end

	local v1 = t3[p2]

	if v1 then
		for v2, v3 in v1 do
			v3:Disconnect()
		end
	end

	local t = {}

	t3[p2] = t
	table.insert(t, p2:GetAttributeChangedSignal("FenceSkin"):Connect(function() --[[ Line: 255 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:RenderPlot(p2)
	end))
	table.insert(t, p2:GetAttributeChangedSignal("GardenExpansion"):Connect(function() --[[ Line: 258 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:RenderPlot(p2)
	end))

	local PlotSizeReference = p2:FindFirstChild("PlotSizeReference")

	if PlotSizeReference and PlotSizeReference:IsA("BasePart") then
		table.insert(t, PlotSizeReference:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 264 | Upvalues: p1 (copy), p2 (copy) ]]
			p1:RenderPlot(p2)
		end))
		table.insert(t, PlotSizeReference:GetPropertyChangedSignal("CFrame"):Connect(function() --[[ Line: 267 | Upvalues: p1 (copy), p2 (copy) ]]
			p1:RenderPlot(p2)
		end))
	end

	local function f8(p1, p22) --[[ Line: 272 | Upvalues: p2 (copy), clearPlotVisual (ref), t3 (ref) ]]
		if p22 then
			return
		end

		local Visual = p2:FindFirstChild("Visual")

		if Visual and Visual:IsA("Folder") then
			clearPlotVisual(Visual)
		end

		local v1 = t3[p2]

		if not v1 then
			return
		end

		for v2, v3 in v1 do
			v3:Disconnect()
		end

		t3[p2] = nil
	end

	table.insert(t, p2.AncestryChanged:Connect(f8))
	p1:RenderPlot(p2)
end
function t.Init(p1) --[[ Init | Line: 290 ]] end
function t.Start(p1) --[[ Start | Line: 293 | Upvalues: Gardens (copy) ]]
	for v1, v2 in Gardens:GetChildren() do
		p1:SetupPlot(v2)
	end

	Gardens.ChildAdded:Connect(function(p12) --[[ Line: 298 | Upvalues: p1 (copy) ]]
		p1:SetupPlot(p12)
	end)
end

return t