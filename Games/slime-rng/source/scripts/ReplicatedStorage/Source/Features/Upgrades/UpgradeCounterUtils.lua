-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeCounterUtils, time of decompilation: Sun May  3 10:11:32 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local UpgradeTree = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeTree)
local originDependency = UpgradeServiceUtils.enums.originDependency
local t2 = {
	canPurchase = function(p1, t1: {[any]: any}, p2: ((...any) -> ...any)) --[[ canPurchase ]] -- line: 13
		-- upvalues: originDependency (copy)
		if not p1.cost then
			return false
		end

		if t1[p1.id] then
			return false
		end

		if p1.dependency ~= originDependency and not t1[p1.dependency] then
			return false
		end

		return p2(p1.cost.currency) >= p1.cost.amount
	end
}

function t2.countPurchasableInTree(s1: string, t3: {[any]: any}, p3: ((...any) -> ...any)) -- line: 30
	-- upvalues: UpgradeTree (copy), t2 (copy)
	local v12 = UpgradeTree[s1]

	if not v12 then
		return 0
	end

	local n1 = 0

	for _, v15 in v12 do
		if t2.canPurchase(v15, t3, p3) then
			n1 += 1
		end
	end

	return n1
end
function t2.countPurchasableTotal(t4: {[any]: any}, p4: ((...any) -> ...any)) -- line: 50
	-- upvalues: UpgradeTree (copy), t2 (copy)
	local n2 = 0

	for v19, _ in UpgradeTree do
		n2 += t2.countPurchasableInTree(v19, t4, p4)
	end

	return n2
end
function t2.getCurrencyPathsInTree(s2: string) -- line: 58
	-- upvalues: UpgradeTree (copy)
	local v22 = UpgradeTree[s2]

	if not v22 then
		return {}
	end

	local t5 = {}
	local t6 = {}

	for _, v26 in v22 do
		local v27 = if not v26.cost then nil else v26.cost.currency

		if v27 and not t5[v27] then
			t5[v27] = true
			table.insert(t6, v27)
		end
	end

	return t6
end
function t2.getCurrencyPaths() -- line: 77
	-- upvalues: UpgradeTree (copy), t2 (copy)
	local t7 = {}
	local t8 = {}

	for v30, _ in UpgradeTree do
		for _, v33 in t2.getCurrencyPathsInTree(v30) do
			if not t7[v33] then
				t7[v33] = true
				table.insert(t8, v33)
			end
		end
	end

	return t8
end

return t2
