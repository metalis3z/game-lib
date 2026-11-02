-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Recipes, time of decompilation: Sun May  3 10:12:24 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {}
local t2 = {}
local t3 = {}

for v5, v6 in {
	crafty = {
		id = "crafty",
		layoutOrder = 1,
		outputId = "crafty",
		description = "Find the recipe in the Cave zone!",
		hidden = false,
		inputs = {
			{
				id = "lucky"
			},
			{
				id = "rocky"
			},
			{
				id = "mushy"
			}
		}
	},
	thorn = {
		id = "thorn",
		layoutOrder = 2,
		outputId = "thorn",
		description = "Find the recipe in the Jungle zone!",
		hidden = false,
		inputs = {
			{
				id = "orbit"
			},
			{
				id = "icy"
			},
			{
				id = "stump"
			}
		}
	},
	geode = {
		id = "geode",
		layoutOrder = 3,
		outputId = "geode",
		description = "Find the recipe in the Mushroom zone!",
		hidden = false,
		inputs = {
			{
				id = "ninja"
			},
			{
				id = "guest"
			},
			{
				id = "aegis"
			}
		}
	},
	slimeSlimeSlime = {
		id = "slimeSlimeSlime",
		layoutOrder = 4,
		outputId = "slimeSlimeSlime",
		description = "Find the recipe in the Redwood zone!",
		hidden = false,
		inputs = {
			{
				id = "slimeSlime"
			},
			{
				id = "slimeSlime"
			},
			{
				id = "slimeSlime"
			}
		}
	},
	puffy = {
		id = "puffy",
		layoutOrder = 5,
		outputId = "puffy",
		description = "Find the recipe in the Candyland zone!",
		hidden = false,
		inputs = {
			{
				id = "unicorn"
			},
			{
				id = "flour"
			},
			{
				id = "derpy"
			}
		}
	},
	astro = {
		id = "astro",
		layoutOrder = 6,
		outputId = "astro",
		description = "Find the recipe in the Crystal Cavern zone!",
		hidden = false,
		inputs = {
			{
				id = "ufo"
			},
			{
				id = "blackhole"
			},
			{
				id = "bomber"
			}
		}
	},
	sunny = {
		id = "sunny",
		layoutOrder = 7,
		outputId = "sunny",
		description = "Find the recipe in the Atlantis zone!",
		hidden = false,
		inputs = {
			{
				id = "pumpkin"
			},
			{
				id = "ouchy"
			},
			{
				id = "ember"
			}
		}
	},
	melly = {
		id = "melly",
		layoutOrder = 8,
		outputId = "melly",
		description = "Find the recipe in the Graveyard zone!",
		hidden = false,
		inputs = {
			{
				id = "monke"
			},
			{
				id = "waxie"
			},
			{
				id = "germy"
			}
		}
	}
} do
	assert(v5 == v6.id, "Crafting recipe id must match dictionary key: " .. v5)
	assert(t3[v6.outputId] == nil, "Duplicate crafting recipe output: " .. v6.outputId)
	assert(#v6.inputs > 0, "Crafting recipe must have at least one input: " .. v6.id)
	table.insert(t1, v6)
	t2[v6.id] = v6
	t3[v6.outputId] = v6
end

return {
	getRecipes = function() --[[ getRecipes ]] -- line: 142
		-- upvalues: t1 (copy)
		return t1
	end,
	getRecipe = function(s1: string) --[[ getRecipe ]] -- line: 146
		-- upvalues: t2 (copy)
		return t2[s1]
	end,
	getRecipeByOutputId = function(s2: string) --[[ getRecipeByOutputId ]] -- line: 150
		-- upvalues: t3 (copy)
		return t3[s2]
	end
}
