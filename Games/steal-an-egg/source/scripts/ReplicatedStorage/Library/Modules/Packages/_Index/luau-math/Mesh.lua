-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

local Part = require(script:WaitForChild("Part"))
local WedgePart = require(script:WaitForChild("WedgePart"))
local TetraPart = require(script:WaitForChild("TetraPart"))
local CornerWedgePart = require(script:WaitForChild("CornerWedgePart"))
local t = {}

t.__index = t
t.TetraPartAssetId = 552212360
function getSolver(p1) --[[ getSolver | Line: 27 | Upvalues: CornerWedgePart (copy), WedgePart (copy), t (copy), TetraPart (copy), Part (copy) ]]
	local v1 = nil

	if p1:IsA("CornerWedgePart") then
		return CornerWedgePart
	end

	if p1:IsA("WedgePart") then
		return WedgePart
	end

	if p1:IsA("MeshPart") and p1.MeshId == "rbxassetid://" .. tostring(t.TetraPartAssetId) then
		return TetraPart
	end

	if p1:IsA("BasePart") then
		v1 = Part
	end

	return v1
end
function t.getVertices(p1) --[[ getVertices | Line: 42 ]]
	return getSolver(p1).getVertices(p1)
end
function t.getLines(p1) --[[ getLines | Line: 48 ]]
	return getSolver(p1).getLines(p1)
end
function t.getSurfaces(p1) --[[ getSurfaces | Line: 54 ]]
	return getSolver(p1).getSurfaces(p1)
end
function t.renderTriangle(p1, p2, p3, p4) --[[ renderTriangle | Line: 60 ]]
	local v1 = p4 or 0
	local WedgePart = Instance.new("WedgePart")

	WedgePart.Anchored = true
	WedgePart.TopSurface = Enum.SurfaceType.Smooth
	WedgePart.BottomSurface = Enum.SurfaceType.Smooth

	local v2 = WedgePart:Clone()
	local v3 = p2 - p1
	local v4 = p3 - p1
	local v5 = p3 - p2
	local v6 = v3:Dot(v3)
	local v7 = v4:Dot(v4)
	local v8 = v5:Dot(v5)

	if v7 < v6 and v8 < v6 then
		p1, p3 = p3, p1
	elseif v8 < v7 and v6 < v7 then
		p2, p1 = p1, p2
	end

	local v10 = p2 - p1
	local v11 = p3 - p1
	local v12 = p3 - p2
	local Unit = v11:Cross(v10).Unit
	local Unit2 = v12:Cross(Unit).Unit
	local Unit3 = v12.Unit
	local v14 = math.abs((v10:Dot(Unit2)))

	WedgePart.Size = Vector3.new(v1, v14, (math.abs((v10:Dot(Unit3)))))
	WedgePart.CFrame = CFrame.fromMatrix((p1 + p2) / 2, Unit, Unit2, Unit3)
	v2.Size = Vector3.new(v1, v14, (math.abs((v11:Dot(Unit3)))))
	v2.CFrame = CFrame.fromMatrix((p1 + p3) / 2, -Unit, Unit2, -Unit3)

	return WedgePart, v2
end
function t.solveGreedyMesh(p1) --[[ solveGreedyMesh | Line: 97 ]]
	local t = {}
	local t2 = {}

	for k, v in pairs(p1) do
		if t[k] == nil then
			local function try(p12) --[[ try | Line: 105 | Upvalues: p1 (copy), t (copy) ]]
				return p1[p12] ~= nil and t[p12] == nil
			end

			local function tryX(p12) --[[ tryX | Line: 114 | Upvalues: k (copy), p1 (copy), t (copy) ]]
				local v1 = Vector3.new(p12, k.Y, k.Z)

				return p1[v1] ~= nil and t[v1] == nil
			end

			local X = k.X

			while true do
				local v1
				local v2 = Vector3.new(X + 1, k.Y, k.Z)

				v1 = p1[v2] ~= nil and t[v2] == nil

				if not v1 then
					break
				end

				X = X + 1
			end

			local X2 = k.X

			while true do
				local v3
				local v4 = Vector3.new(X2 - 1, k.Y, k.Z)

				v3 = p1[v4] ~= nil and t[v4] == nil

				if not v3 then
					break
				end

				X2 = X2 - 1
			end

			local function tryXY(p12) --[[ tryXY | Line: 129 | Upvalues: X2 (ref), X (ref), k (copy), p1 (copy), t (copy) ]]
				for i = X2, X do
					local v1 = Vector3.new(i, p12, k.Z)

					if not (if p1[v1] == nil or t[v1] ~= nil then false else true) then
						return false
					end
				end

				return true
			end

			local Y = k.Y

			while tryXY(Y + 1) do
				Y = Y + 1
			end

			local Y2 = k.Y

			while tryXY(Y2 - 1) do
				Y2 = Y2 - 1
			end

			local function tryXYZ(p12) --[[ tryXYZ | Line: 148 | Upvalues: X2 (ref), X (ref), Y2 (ref), Y (ref), p1 (copy), t (copy) ]]
				for i = X2, X do
					for j = Y2, Y do
						local v1 = Vector3.new(i, j, p12)

						if not (if p1[v1] == nil or t[v1] ~= nil then false else true) then
							return false
						end
					end
				end

				return true
			end

			local Z = k.Z

			while tryXYZ(Z + 1) do
				Z = Z + 1
			end

			local Z2 = k.Z

			while tryXYZ(Z2 - 1) do
				Z2 = Z2 - 1
			end

			local t3 = { Vector3.new(X2, Y2, Z2), (Vector3.new(X, Y, Z)) }

			table.insert(t2, t3)

			for i = X2, X do
				for j = Y2, Y do
					for k2 = Z2, Z do
						t[Vector3.new(i, j, k2)] = #t2
					end
				end
			end
		end
	end

	return t2
end
function t.getBoundingBoxAtCFrame(p1, p2) --[[ getBoundingBoxAtCFrame | Line: 186 | Upvalues: t (copy) ]]
	if #p2 == 0 then
		return Vector3.new(0, 0, 0), CFrame.new(0, 0, 0)
	end

	local tbl = {}
	local v1 = (-1 / 0)
	local v2 = (1 / 0)
	local v3 = (1 / 0)
	local v4 = (1 / 0)
	local v5 = (-1 / 0)
	local v6 = (-1 / 0)

	for i, v in ipairs(p2) do
		for i2, v8 in ipairs((t.getVertices(v))) do
			tbl[(p1:Inverse() * CFrame.new(v8)).Position] = true
		end
	end

	for k, v in pairs(tbl) do
		local v8 = math.min(k.X, v2)
		local v9 = math.min(k.Y, v3)
		local v10 = math.min(k.Z, v4)
		local v11 = math.max(k.X, v5)
		local v12 = math.max(k.Y, v6)

		v1, v2, v3, v4, v5, v6 = math.max(k.Z, v1), v8, v9, v10, v11, v12
	end

	local v14 = Vector3.new(v2, v3, v4)
	local v15 = Vector3.new(v5, v6, v1)

	return v15 - v14, p1 * CFrame.fromMatrix(v14:Lerp(v15, 0.5), p1.XVector, p1.YVector, p1.ZVector)
end

return t