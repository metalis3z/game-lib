-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

local t = {
	Top = Enum.NormalId.Top,
	Bottom = Enum.NormalId.Bottom,
	Back = Enum.NormalId.Back,
	Front = Enum.NormalId.Front,
	Right = Enum.NormalId.Right,
	Left = Enum.NormalId.Left
}

function getSurfaceCFrame(p1, p2) --[[ getSurfaceCFrame | Line: 19 ]]
	local v1 = CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0)

	local function getTranstionBetween(p1, p2, p3) --[[ getTranstionBetween | Line: 24 ]]
		local v1 = p1:Dot(p2)

		if v1 > 0.99999 then
			return CFrame.new()
		end

		if v1 < -0.99999 then
			return CFrame.fromAxisAngle(p3, math.pi)
		end

		return CFrame.fromAxisAngle(p1:Cross(p2), (math.acos(v1)))
	end

	return p1.CFrame * getTranstionBetween(Vector3.new(0, 1, 0), p2, Vector3.new(0, 0, 1)) * v1
end
function getWorldPosition(p1, p2) --[[ getWorldPosition | Line: 38 ]]
	return (p1.CFrame * CFrame.new(p2 * Vector3.new(-1, 1, 1))).Position
end

local t2 = {
	getVertices = function(p1) --[[ getVertices | Line: 44 ]]
		local v1 = p1.Size.X / 2
		local v2 = p1.Size.Y / 2
		local v3 = p1.Size.Z / 2

		return {
			getWorldPosition(p1, (Vector3.new(v1, -v2, v3))),
			getWorldPosition(p1, (Vector3.new(-v1, -v2, v3))),
			getWorldPosition(p1, (Vector3.new(v1, -v2, -v3))),
			getWorldPosition(p1, (Vector3.new(-v1, -v2, -v3))),
			getWorldPosition(p1, (Vector3.new(v1, v2, -v3))),
			getWorldPosition(p1, (Vector3.new(-v1, v2, -v3)))
		}
	end,
	getLines = function(p1) --[[ getLines | Line: 61 ]]
		local v1 = p1.Size.X / 2
		local v2 = p1.Size.Y / 2
		local v3 = p1.Size.Z / 2

		return {
			seColumn = { getWorldPosition(p1, (Vector3.new(v1, -v2, -v3))), getWorldPosition(p1, (Vector3.new(v1, v2, -v3))) },
			swColumn = { getWorldPosition(p1, (Vector3.new(-v1, -v2, -v3))), getWorldPosition(p1, (Vector3.new(-v1, v2, -v3))) },
			nBorder = { getWorldPosition(p1, (Vector3.new(v1, -v2, v3))), getWorldPosition(p1, (Vector3.new(-v1, -v2, v3))) },
			sBorder = { getWorldPosition(p1, (Vector3.new(v1, -v2, -v3))), getWorldPosition(p1, (Vector3.new(-v1, -v2, -v3))) },
			wBorder = { getWorldPosition(p1, (Vector3.new(-v1, -v2, -v3))), getWorldPosition(p1, (Vector3.new(-v1, -v2, v3))) },
			eBorder = { getWorldPosition(p1, (Vector3.new(v1, -v2, -v3))), getWorldPosition(p1, (Vector3.new(v1, -v2, v3))) },
			sTerrace = { getWorldPosition(p1, (Vector3.new(v1, v2, -v3))), getWorldPosition(p1, (Vector3.new(-v1, v2, -v3))) },
			wTerrace = { getWorldPosition(p1, (Vector3.new(-v1, v2, -v3))), getWorldPosition(p1, (Vector3.new(-v1, -v2, v3))) },
			eTerrace = { getWorldPosition(p1, (Vector3.new(v1, v2, -v3))), getWorldPosition(p1, (Vector3.new(v1, -v2, v3))) }
		}
	end
}

function t2.getSurfaces(p1) --[[ getSurfaces | Line: 106 | Upvalues: t2 (copy), t (copy) ]]
	local v1 = t2.getLines(p1)
	local v2 = math.atan2(p1.Size.Y, p1.Size.Z)
	local t3 = {
		[t.Top] = getSurfaceCFrame(p1, (Vector3.new(0, 0, -1)):Lerp(Vector3.new(0, 1, 0), (math.cos(v2)))).LookVector,
		[t.Bottom] = getSurfaceCFrame(p1, Vector3.new(0, -1, 0)).LookVector,
		[t.Left] = getSurfaceCFrame(p1, Vector3.new(-1, 0, 0)).LookVector,
		[t.Right] = getSurfaceCFrame(p1, Vector3.new(1, 0, 0)).LookVector,
		[t.Back] = getSurfaceCFrame(p1, Vector3.new(0, 0, 1)).LookVector
	}
	local t4 = {}

	for k, v in pairs({
		[t.Top] = { "sTerrace", "nBorder", "eTerrace", "wTerrace" },
		[t.Bottom] = { "sBorder", "nBorder", "eBorder", "wBorder" },
		[t.Right] = { "seColumn", "eBorder", "eTerrace" },
		[t.Left] = { "swColumn", "wBorder", "wTerrace" },
		[t.Back] = { "seColumn", "swColumn", "sBorder", "sTerrace" }
	}) do
		local t5 = {}

		for k2, v3 in pairs(v) do
			table.insert(t5, v1[v3])
		end

		t4[k] = {
			Normal = t3[k],
			Lines = t5
		}
	end

	return t4
end

return t2