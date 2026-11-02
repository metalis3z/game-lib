-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Modules = Library:WaitForChild("Modules")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Currency = require(Library.Directory.Currency)
local Functions = require(Library.Functions)
local Signal = require(Library.Signal)
local Variables = require(Library.Variables)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BigNum = require(Modules.BigNum)
local v1 = BigNum.new(1000000)
local t = require(Modules.Packages.t)
local t2 = {}
local v2 = t.union(t.string, t.map(t.string, t.number))

function t2.SetupPriceFrame(p1, p2, p3, p4) --[[ SetupPriceFrame | Line: 24 | Upvalues: Asserts (copy), v2 (copy), Assets (copy), t2 (copy), Functions (copy), Variables (copy) ]]
	Asserts.Instance(p1)
	assert(v2(p2))

	local v22 = nil

	for i, v in ipairs(p1:GetChildren()) do
		if not (v:IsA("UIListLayout") or v:IsA("UIPadding")) then
			if v:IsA("Frame") then
				v22 = v:Clone()
			end

			v:Destroy()
		end
	end

	if not v22 then
		v22 = Assets.UI.Currency.PriceFrameSub:Clone()
	end

	if type(p2) == "string" then
		Asserts.number(p3)
		p2 = {
			[p2] = p3
		}
	end

	local t = {}

	for k, v in pairs(p2) do
		local v5 = t2.NumberToTiers(k, v, p4 or 2)
		local v6 = Functions.DictionaryLength(v5)

		for k2, v3 in pairs(v5) do
			local v7 = v22:Clone()
			local imageOutlineTextOverride = k2.imageOutlineTextOverride

			if imageOutlineTextOverride then
				v7.Icon.Visible = false
			else
				v7.Icon.Image = k2.imageOutline
			end

			local v8 = if v3 == 0 then "FREE!" else Functions.NumberShorten(v3)

			if imageOutlineTextOverride then
				v7.Amount.Text = string.format(imageOutlineTextOverride, v8)
			else
				v7.Amount.Text = v8
			end

			v7.Amount.TextColor3 = k2.textColor
			v7.Name = k
			v7.Visible = true
			v7.LayoutOrder = v6 - k2.Order
			v7.Parent = p1
			table.insert(t, v7)
		end
	end

	if Variables.Mobile then
		local UIListLayout = p1:FindFirstChildOfClass("UIListLayout")

		if UIListLayout then
			UIListLayout.Padding = UDim.new(0, 2)
		end
	end

	return p1, t
end
function t2.GetTierInfo(p1, p2, p3) --[[ GetTierInfo | Line: 92 | Upvalues: Currency (copy) ]]
	local v2 = Currency[p1]
	local v3 = nil

	for i, v in ipairs(v2.Tiers) do
		local v4 = i < #v2.Tiers

		if v4 and (v.value <= p2 and p2 < v2.Tiers[i + 1].value) or not v4 then
			v3 = v

			break
		end
	end

	if not v3 then
		v3 = v2.Tiers[1]
	end

	local v6 = v3.value > 0 and v3.value or 1

	return v3, if if p3 == nil then true else p3 then tonumber(string.format("%.2f", (math.floor(p2 / v6)))) else tonumber(string.format("%.2f", p2 / v6))
end
function t2.NumberToTiers(p1, p2, p3) --[[ NumberToTiers | Line: 125 | Upvalues: Currency (copy), BigNum (copy), v1 (copy) ]]
	local v12 = Currency[p1]
	local Tiers = v12.Tiers
	local v2 = #Tiers

	if v2 == 1 or p2 == 0 then
		return {
			[Tiers[1]] = p2
		}
	end

	if v12 == Currency.Coins then
		local v3 = BigNum.new((math.round(p2)))
		local t = {}

		for i, v in ipairs(Tiers) do
			local v4

			if i == v2 then
				v4 = v3
			else
				local v5, v6 = BigNum.__div(v3, v1)

				v4 = v6
				v3 = v5
			end

			local v9 = assert((tonumber((tostring(v4)))))

			if v9 > 0 then
				t[v] = v9
			end
		end

		if p3 then
			local t2 = {}
			local count = 0

			for i = #Tiers, 1, -1 do
				local v10 = Tiers[i]
				local v11 = t[v10]

				if v11 then
					t2[v10] = v11
					count = count + 1

					if not (count < p3) then
						break
					end
				end
			end

			t = t2
		end

		return t
	end

	local sum = BigNum.new(p2)
	local t = {}
	local count = 0

	for j = #Tiers, 1, -1 do
		local v122 = Tiers[j]
		local v13 = v122.valueBig or BigNum.new(v122.value)

		v122.valueBig = v13

		local v14 = sum / v13
		local v17 = assert((tonumber((tostring(v14)))))

		if v17 > 0 then
			t[v122] = v17
			count = count + 1

			if p3 and not (count < p3) then
				break
			end
		end

		sum = sum - v14 * v13
	end

	return t
end
function t2.GetTierFromName(p1, p2) --[[ GetTierFromName | Line: 193 | Upvalues: Currency (copy) ]]
	for i, v in ipairs(Currency[p1].Tiers) do
		if v.tierName == p2 then
			return v
		end
	end

	return nil
end
function t2.RainFromItem(p1, p2, p3) --[[ RainFromItem | Line: 203 | Upvalues: t2 (copy) ]]
	local t = {}

	for k, v in pairs((t2.NumberToTiers(p2:GetId(), p2:GetAmount(), p3 or 2))) do
		table.insert(t, k.tierName)
	end

	t2.Rain(p1, unpack(t))
end
function t2.Rain(p1, ...) --[[ Rain | Line: 213 | Upvalues: Currency (copy), RunService (copy), Signal (copy) ]]
	local t = { ... }
	local t2 = {}

	for k, v in pairs(Currency) do
		for i, v2 in ipairs(v.Tiers) do
			if table.find(t, v2.tierName) then
				local t3 = {
					Texture = v2.imageOutline
				}

				t3.LightEmission = v2.rainData and v2.rainData.LightEmission
				t3.SizeScalar = v2.rainData and v2.rainData.SizeScalar
				table.insert(t2, t3)
			end
		end
	end

	if #t2 == 0 then
		return
	end

	if RunService:IsClient() then
		Signal.Fire("Currency_Rain", t2)
	else
		local ServerScriptService = game:GetService("ServerScriptService")
		local Network = require(ServerScriptService.Library.Services.Network)

		assert(p1, "Player not found")
		Network.Fire("Currency_Rain", p1, t2)
	end
end

return t2