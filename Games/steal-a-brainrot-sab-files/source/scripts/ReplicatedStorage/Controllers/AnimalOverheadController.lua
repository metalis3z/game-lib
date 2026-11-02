-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Trove)
local u2 = require(v1.Packages.Gradients)
local u3 = require(v1.Controllers.FastOverheadController)
local u4 = require(v1.Datas.Animals)
local u5 = require(v1.Datas.Rarities)
local u6 = require(v1.Datas.Mutations)
local u7 = require(v1.Datas.Traits)
local u8 = require(v1.Shared.Animals)
local u9 = require(v1.Shared.MutationText)
local u10 = require(v1.Utils.NumberUtils)

local function calculateGenerationWithMultipliers(baseGeneration, traits, mutation)
	local traitMult = 1
	local hasSleepy = false
	if type(traits) == "table" then
		for _, traitName in ipairs(traits) do
			local td = u7[traitName]
			if td then
				if traitName == "Sleepy" then
					hasSleepy = true
				else
					traitMult = traitMult + (td.MultiplierModifier or 0)
				end
			end
		end
	end
	if mutation then
		local md = u6[mutation]
		if md then traitMult = traitMult + (md.Modifier or 0) end
	end
	local gen = baseGeneration * traitMult
	if hasSleepy then gen = gen * 0.5 end
	return math.round(gen)
end

return {
	["ResolveDisplayName"] = function(_, p10, p11)
		local v12 = u4[p10]
		local v13 = if not v12 then p10 else v12.DisplayName

		if p11 then
			for _, v14 in p11 do
				local v15 = u7[v14]
				if v15 and v15.OverheadDisplayName then
					v13 = v15.OverheadDisplayName(v13)
				end
			end
		end
		return v13
	end,
	["PopulateTraits"] = function(_, p15, p16, p17)
		local v18 = 0

		if not p16 then
			p15.Traits.Visible = false
			u3.setStudsOffsetY(p15, 2.5)
			return
		end

		local v19 = p15.Traits.Template
		for _, v20 in p16 do
			local v21 = u7[v20]
			if v21 then
				if v21.OverheadYOffset then
					v18 = v18 + v21.OverheadYOffset
				end
				local v22 = p17:Clone(v19)
				v22.Image = v21.Icon
				v22.Visible = true
				v22.Parent = p15.Traits
			end
		end
		p15.Traits.Visible = true
		u3.setStudsOffsetY(p15, v18 + 2.5)
	end,
	["Populate"] = function(p23, p24)
		local v25 = p24.Overhead
		local v26 = p24.Index
		local v27 = p24.Traits
		local v28 = p24.Mutation
		local v29 = p24.Player
		local v30 = p24.Trove
		local v31 = u4[v26]

		local customRarity = p24.CustomRarity
		local rarityToUse = customRarity or v31.Rarity
		local v32 = u5[rarityToUse]

		local v33 = if p24.HidePrice == nil then v31.HidePrice else p24.HidePrice
		local v34 = if p24.HideRarity == nil then v31.HideRarity else p24.HideRarity

		local customDisplayName = p24.CustomDisplayName
		if customDisplayName then
			v25.DisplayName.Text = customDisplayName
		else
			v25.DisplayName.Text = p23:ResolveDisplayName(v26, v27)
		end

		local customPrice = p24.CustomPrice
		if customPrice then
			v25.Price.Text = `${u10:ToString(customPrice)}`
		else
			v25.Price.Text = `${u10:ToString(u8:GetPrice(v26, v29))}`
		end

		v25.Price.Visible = not v33
		v25.Rarity.Text = rarityToUse
		v25.Rarity.TextColor3 = v32.Color
		v25.Rarity.Visible = not v34
		v25.Mutation.Visible = v28 ~= nil

		if v28 then
			local v35 = u9.ApplyToLabel(v25.Mutation, v28, "Auto")
			if v35 then
				v30:Add(v35)
			end
		end

		if v32.StrokeColor then
			v25.Rarity.UIStroke.Color = v32.StrokeColor
		end

		if v32.GradientPreset then
			v30:Add(u2.apply(v25.Rarity, v32.GradientPreset))
		end

		p23:PopulateTraits(v25, v27, v30)
	end,
	["CalculateGenerationWithMultipliers"] = function(_, baseGeneration, traits, mutation)
		return calculateGenerationWithMultipliers(baseGeneration, traits, mutation)
	end
}