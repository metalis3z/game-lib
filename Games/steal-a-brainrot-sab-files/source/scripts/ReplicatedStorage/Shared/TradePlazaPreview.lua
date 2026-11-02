
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	PreviewingAttribute = "PreviewingBaseOrder"
}
local v1 = CFrame.new(10000, 0, 0)

function t.getSlotCFrame(p1) --[[ getSlotCFrame | Line: 21 | Upvalues: v1 (copy) ]]
	return v1 * CFrame.new(p1 * 1000, 0, 0)
end
function t.getBaseRootCFrame(p1) --[[ getBaseRootCFrame | Line: 34 | Upvalues: ReplicatedStorage (copy) ]]
	local TradePlazaPreviewMap = ReplicatedStorage:FindFirstChild("TradePlazaPreviewMap")
	local v1 = if TradePlazaPreviewMap then TradePlazaPreviewMap:FindFirstChild("Plots") else TradePlazaPreviewMap
	local v2 = if v1 then v1:FindFirstChild("PlotFixed") else v1

	if TradePlazaPreviewMap and v2 then
		return p1 * TradePlazaPreviewMap:GetPivot():ToObjectSpace(v2:GetPivot())
	end

	return p1
end
function t.getBaseSpawnCFrame(p1, p2) --[[ getBaseSpawnCFrame | Line: 46 | Upvalues: ReplicatedStorage (copy), t (copy) ]]
	local TradePlazaPreviewMap = ReplicatedStorage:FindFirstChild("TradePlazaPreviewMap")
	local v1 = if TradePlazaPreviewMap then TradePlazaPreviewMap:FindFirstChild("Plots") else TradePlazaPreviewMap
	local v2 = if v1 then v1:FindFirstChild("PlotFixed") else v1
	local Bases = ReplicatedStorage:FindFirstChild("Bases")
	local v3 = if p2 then if Bases then Bases:FindFirstChild(p2) else Bases else p2
		local v4 = if v3 then v3:FindFirstChild("Spawn") else v3
		local v5 = if v3 then v3:FindFirstChild("Root", true) else v3

		if TradePlazaPreviewMap and (v2 and (v5 and (v5:IsA("BasePart") and (v4 and v4:IsA("BasePart"))))) then
			return t.getBaseRootCFrame(p1) * v5.CFrame:ToObjectSpace(v4.CFrame) + Vector3.new(0, 3, 0)
		end

		return p1 + Vector3.new(0, 5, 0)
	end

	return t