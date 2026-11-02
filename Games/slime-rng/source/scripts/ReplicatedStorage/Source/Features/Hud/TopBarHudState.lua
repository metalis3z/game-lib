-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TopBarHudState, time of decompilation: Sun May  3 10:11:23 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Vide = require(ReplicatedStorage.Packages.Vide)
local t1 = {}
local t2 = {}
local t3 = {}
local t4 = {
	coins = "CoinCounter",
	goop = "GoopCounter"
}
local t5 = {
	coins = UDim2.fromScale(0.095, 0.055),
	goop = UDim2.fromScale(0.095, 0.12)
}
local t6 = {
	coins = Vector2.new(46, 28),
	goop = Vector2.new(46, 28)
}

local function findCurrencyCounterGui(s1: string) -- line: 49
	-- upvalues: Players (copy), t4 (copy)
	local LocalPlayer = Players.LocalPlayer
	local v33 = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")

	if not v33 then
		return nil
	end

	local Root = v33:FindFirstChild("Root")

	if not Root then
		return nil
	end

	local v35 = t4[s1]

	if not v35 then
		return nil
	end

	local v36 = Root:FindFirstChild(v35, true)

	if v36 and v36:IsA("GuiObject") then
		return v36
	end

	return nil
end

local t7 = {}
local coins = t1.coins

if coins then
else
	coins = Vide.source(0)
	t1.coins = coins
end

t7.collectionBurst = coins

local coins2 = t2.coins

if coins2 then
else
	coins2 = Vide.source(0)
	t2.coins = coins2
end

t7.lastCollectedAmount = coins2

function t7.getCollectionBurstSource(s2: string) -- line: 37
	-- upvalues: t1 (copy), Vide (copy)
	local v20 = t1
	local v21 = v20[s2]

	if v21 then
		return v21
	end

	local v22 = Vide.source(0)

	v20[s2] = v22

	return v22
end
function t7.getLastCollectedAmountSource(s3: string) -- line: 41
	-- upvalues: t2 (copy), Vide (copy)
	local v24 = t2
	local v25 = v24[s3]

	if v25 then
		return v25
	end

	local v26 = Vide.source(0)

	v24[s3] = v26

	return v26
end
function t7.getHiddenAmountSource(s4: string) -- line: 45
	-- upvalues: t3 (copy), Vide (copy)
	local v28 = t3
	local v29 = v28[s4]

	if v29 then
		return v29
	end

	local v30 = Vide.source(0)

	v28[s4] = v30

	return v30
end
function t7.notifyCurrencyCollected(s5: string, n1: number) -- line: 82
	-- upvalues: t2 (copy), Vide (copy), t1 (copy)
	local v39 = t2
	local v40 = v39[s5]

	if v40 then
	else
		v40 = Vide.source(0)
		v39[s5] = v40
	end

	local v41 = t1
	local v42 = v41[s5]

	if v42 then
	else
		v42 = Vide.source(0)
		v41[s5] = v42
	end

	v40(n1)
	v42(v42() + 1)
end
function t7.notifyCoinCollected(n2: number) -- line: 89
	-- upvalues: t7 (copy)
	t7.notifyCurrencyCollected("coins", n2)
end
function t7.setHiddenAmount(s6: string, n3: number) -- line: 93
	-- upvalues: t3 (copy), Vide (copy)
	local v46 = t3
	local v47 = v46[s6]

	if v47 then
	else
		v47 = Vide.source(0)
		v46[s6] = v47
	end

	v47((math.max(math.floor(n3 or 0), 0)))
end
function t7.consumeHiddenAmount(s7: string, n4: number) -- line: 97
	-- upvalues: t3 (copy), Vide (copy)
	local v50 = t3
	local v51 = v50[s7]

	if v51 then
	else
		v51 = Vide.source(0)
		v50[s7] = v51
	end

	v51((math.max(v51() - math.max(math.floor(n4 or 0), 0), 0)))
end
function t7.getCounterAbsolutePosition(s8: string) -- line: 102
	-- upvalues: findCurrencyCounterGui (copy), t5 (copy), t6 (copy), Workspace (copy)
	local v53 = findCurrencyCounterGui(s8)

	if v53 and v53.AbsoluteSize.Magnitude > 0 then
		return v53.AbsolutePosition
	end

	local v54 = t5[s8] or UDim2.fromScale(0.1, 0.06)
	local v55 = t6[s8] or Vector2.zero
	local CurrentCamera = Workspace.CurrentCamera
	local v57 = if not CurrentCamera then Vector2.new(1920, 1080) else CurrentCamera.ViewportSize

	return Vector2.new(v57.X * v54.X.Scale + v54.X.Offset, v57.Y * v54.Y.Scale + v54.Y.Offset) + v55
end

return t7
