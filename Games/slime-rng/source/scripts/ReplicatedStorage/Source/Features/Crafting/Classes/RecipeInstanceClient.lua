-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RecipeInstanceClient, time of decompilation: Sun May  3 10:12:26 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)
local t1 = {}

t1.__index = t1

local function syncVisibility(p1) -- line: 37
	if p1.root ~= nil and p1.root.Parent ~= nil then
		p1.root.Transparency = not p1.visible and 1 or (p1.rootTransparency or 0)
	end

	for _, v9 in p1.particleEmitters do
		if v9.Parent ~= nil then
			v9.Enabled = not not p1.visible and p1.particleEmitterEnabled[v9] == true
		end
	end

	for _, v11 in p1.highlights do
		if v11.Parent ~= nil then
			v11.Enabled = not not p1.visible and p1.highlightEnabled[v11] ~= false
		end
	end

	if p1.prompt ~= nil and p1.prompt.Parent ~= nil then
		p1.prompt.Enabled = p1.visible and not p1.claimPending
	end
end

function t1.new(p2, p3: ((...any) -> ...any)) -- line: 56
	-- upvalues: CraftingServiceUtils (copy), Janitor (copy), t1 (copy), syncVisibility (copy)
	local v14 = setmetatable({
		attachment = nil,
		prompt = nil,
		rootTransparency = nil,
		claimPending = false,
		visible = true,
		instance = p2,
		root = if not p2:IsA("BasePart") then nil else p2,
		recipeKey = CraftingServiceUtils.getRecipeKeyFromInstance(p2),
		zoneId = CraftingServiceUtils.getRecipeZoneId(p2),
		particleEmitters = {},
		particleEmitterEnabled = {},
		highlights = {},
		highlightEnabled = {},
		janitor = Janitor.new()
	}, t1)

	if v14.root ~= nil then
		v14.rootTransparency = v14.root.Transparency

		for _, v16 in v14.root:GetDescendants() do
			if v16:IsA("ParticleEmitter") then
				table.insert(v14.particleEmitters, v16)
				v14.particleEmitterEnabled[v16] = v16.Enabled
			elseif v16:IsA("Highlight") then
				table.insert(v14.highlights, v16)
				v14.highlightEnabled[v16] = v16.Enabled
			end
		end

		local Attachment = Instance.new("Attachment")

		Attachment.Name = "RecipePromptAttachment"
		Attachment.Parent = v14.root
		v14.attachment = Attachment

		local ProximityPrompt = Instance.new("ProximityPrompt")

		ProximityPrompt.Name = "RecipePrompt"
		ProximityPrompt.ActionText = "Claim Recipe"
		ProximityPrompt.ObjectText = "Recipe"
		ProximityPrompt.HoldDuration = 1
		ProximityPrompt.RequiresLineOfSight = false
		ProximityPrompt.MaxActivationDistance = CraftingServiceUtils.RECIPE_CLAIM_MAX_DISTANCE
		ProximityPrompt.Parent = Attachment
		v14.prompt = ProximityPrompt
		v14.janitor:Add(Attachment)
		v14.janitor:Add(ProximityPrompt.Triggered:Connect(function() -- line: 103
			-- upvalues: p3 (copy), v14 (copy)
			p3(v14)
		end))
	end

	syncVisibility(v14)

	return v14
end
function t1.setVisible(p4, b1: boolean) -- line: 113
	-- upvalues: syncVisibility (copy)
	p4.visible = b1
	syncVisibility(p4)
end
function t1.setClaimPending(p5, b2: boolean) -- line: 118
	-- upvalues: syncVisibility (copy)
	p5.claimPending = b2
	syncVisibility(p5)
end
function t1.destroy(p6) -- line: 123
	p6.janitor:Destroy()
end

return t1
