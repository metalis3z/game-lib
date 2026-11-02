local SkinService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local BasesData = require(ReplicatedStorage.Datas.Bases)
local Trove = require(ReplicatedStorage.Packages.Trove)

local blacklist = {
	"Laser", "LaserHitbox", "Purchases", "AnimalPodiums",
	"PlotSign", "FriendPanel", "Skin", "Spawn",  "Pillar Platform",
	"Unlock", "Multiplier", "TouchInterest", "Anti falloff", "Computer Desk"
}

local RAINBOW_TAG = "RainbowModel"
local RAINBOW_DARKEN_TAG = "RainbowDarken"

local plotTroves = {}

local function isProtected(part, plot)
	for _, name in ipairs(blacklist) do
		local folder = plot:FindFirstChild(name)
		if folder and (part:IsDescendantOf(folder) or part == folder) then
			return true
		end
	end
	return false
end

local function hasColorIgnoreTag(part)
	return CollectionService:HasTag(part, "IgnoreColor")
		or CollectionService:HasTag(part, "IgnoreRainbow")
		or part:GetAttribute("IgnoreRainbow") == true
end

local function cleanPlot(plot)
	local trove = plotTroves[plot]
	if trove then
		trove:Clean()
		plotTroves[plot] = nil
	end
end

local function applyLaserColors(trove, plot, skinClone)
	local skinLaser = skinClone:FindFirstChild("Laser")
	if not skinLaser then return end

	local existingLaser = plot:FindFirstChild("Laser")
	if not existingLaser then return end

	local skinParts = {}
	for _, model in ipairs(skinLaser:GetChildren()) do
		if model:IsA("Model") then
			for _, part in ipairs(model:GetDescendants()) do
				if part:IsA("BasePart") then
					table.insert(skinParts, part)
				end
			end
		end
	end

	local existingParts = {}
	for _, model in ipairs(existingLaser:GetChildren()) do
		if model:IsA("Model") then
			for _, part in ipairs(model:GetDescendants()) do
				if part:IsA("BasePart") then
					table.insert(existingParts, part)
				end
			end
		end
	end

	for i, existingPart in ipairs(existingParts) do
		local skinPart = skinParts[i]
		if skinPart then
			local originalColor = existingPart.Color
			local originalMaterial = existingPart.Material
			local originalMaterialVariant = existingPart.MaterialVariant

			existingPart.Color = skinPart.Color
			existingPart.Material = skinPart.Material
			existingPart.MaterialVariant = skinPart.MaterialVariant

			trove:Add(function()
				if existingPart and existingPart.Parent then
					existingPart.Color = originalColor
					existingPart.Material = originalMaterial
					existingPart.MaterialVariant = originalMaterialVariant
				end
			end)
		end
	end
end

local function applyLayer(trove, plot, folderName, mutationName, tier)
	local root = ServerStorage:FindFirstChild(folderName)
	if not root then return nil, nil, nil end

	local containerName = (folderName == "Skins") and "Skin" or "Deco"
	local container = plot:FindFirstChild(containerName)

	if not container then
		container = trove:Construct(Instance, "Folder")
		container.Name = containerName
		container.Parent = plot
	else
		container:ClearAllChildren()
		trove:Add(container)
	end

	local mutationFolder = root:FindFirstChild(mutationName)
	if not mutationFolder then return nil, nil, nil end

	local tierData = BasesData[tier] or BasesData[tostring(tier)]
	if not tierData or not tierData.Model then return nil, nil, nil end

	local template = mutationFolder:FindFirstChild(tierData.Model.Name)
	if not template then return nil, nil, nil end

	local clone = trove:Clone(template)

	local skinPlotSign = clone:FindFirstChild("PlotSign", true)
	if skinPlotSign and skinPlotSign:IsA("BasePart") then
		skinPlotSign = skinPlotSign:Clone()
	else
		skinPlotSign = nil
	end

	applyLaserColors(trove, plot, clone)

	for _, name in ipairs(blacklist) do
		local extra = clone:FindFirstChild(name, true)
		if extra then extra:Destroy() end
	end

	clone.Parent = container
	clone:PivotTo(plot:GetPivot())

	return clone, skinPlotSign
end

local function hidePlotSign(trove, plot)
	local plotSign = plot:FindFirstChild("PlotSign")
	if not plotSign or not plotSign:IsA("BasePart") then return end

	if plotSign.Transparency < 1 then
		local originalTrans = plotSign.Transparency
		plotSign.Transparency = 1
		trove:Add(function()
			if plotSign.Parent then
				plotSign.Transparency = originalTrans
			end
		end)
	end

	for _, child in ipairs(plotSign:GetChildren()) do
		if child:IsA("SurfaceGui") and child.Enabled then
			child.Enabled = false
			trove:Add(function()
				if child.Parent then
					child.Enabled = true
				end
			end)
		end
	end
end

local function applySkinPlotSign(trove, plot, skinPlotSignTemplate)
	if not skinPlotSignTemplate then return end

	local signClone = skinPlotSignTemplate
	signClone.Name = "SkinPlotSign"

	local currentPlotSign = plot:FindFirstChild("PlotSign")
	if currentPlotSign and currentPlotSign:IsA("BasePart") then
		signClone:PivotTo(currentPlotSign.CFrame)
		signClone.Size = currentPlotSign.Size

		for _, child in ipairs(signClone:GetChildren()) do
			if child:IsA("SurfaceGui") then
				child:Destroy()
			end
		end

		for _, child in ipairs(currentPlotSign:GetChildren()) do
			if child:IsA("SurfaceGui") then
				local guiClone = child:Clone()
				guiClone.Enabled = true
				guiClone.Parent = signClone
			end
		end
	end

	signClone.Parent = plot
	trove:Add(signClone)
end

local function addRainbowTag(trove, part, tag)
	if not CollectionService:HasTag(part, tag) then
		CollectionService:AddTag(part, tag)
		trove:Add(function()
			if part.Parent then
				CollectionService:RemoveTag(part, tag)
			end
		end)
	end
end

local function hidePartTransparency(trove, obj)
	if obj.Transparency < 1 then
		local originalTrans = obj.Transparency
		obj.Transparency = 1
		trove:Add(function()
			if obj.Parent then
				obj.Transparency = originalTrans
			end
		end)
	end
end

local function disableGui(trove, gui)
	if gui.Enabled then
		gui.Enabled = false
		trove:Add(function()
			if gui.Parent then
				gui.Enabled = true
			end
		end)
	end
end

function SkinService:Apply(mutation, plot, tier, IsSammy)
	if not plot then return end
	local level = tier or plot:GetAttribute("Tier") or 0

	cleanPlot(plot)

	local trove = Trove.new()
	plotTroves[plot] = trove

	if mutation == "Rainbow" then
		for _, part in ipairs(plot:GetDescendants()) do
			if part:IsA("BasePart")
				and not isProtected(part, plot)
				and not hasColorIgnoreTag(part) then

				addRainbowTag(trove, part, RAINBOW_TAG)
				addRainbowTag(trove, part, RAINBOW_DARKEN_TAG)
			end
		end
		return
	end

	local Skin, skinPlotSignFromSkin = applyLayer(trove, plot, "Skins", mutation, level)
	local ModelsSkins, skinPlotSignFromModels = applyLayer(trove, plot, "SkinsModels", mutation, level)
	if plot:IsA("Model") and plot.Name == "SammyBase" then
		for _, obj in ipairs(plot:GetDescendants()) do
			if obj.Name == "CashPad" then
				obj:Destroy()
			end
		end
	end
	local skinPlotSign = skinPlotSignFromSkin or skinPlotSignFromModels

	if skinPlotSign then
		hidePlotSign(trove, plot)
		applySkinPlotSign(trove, plot, skinPlotSign)
	end

	local skinPlotSignInPlot = plot:FindFirstChild("SkinPlotSign")

	if Skin or ModelsSkins then
		for _, obj in ipairs(plot:GetDescendants()) do
			local isSkinPart = (Skin and obj:IsDescendantOf(Skin))
				or (ModelsSkins and obj:IsDescendantOf(ModelsSkins))

			local isSkinPlotSign = skinPlotSignInPlot
				and (obj == skinPlotSignInPlot or obj:IsDescendantOf(skinPlotSignInPlot))

			if obj:IsA("BasePart") and not isProtected(obj, plot) and not isSkinPart and not isSkinPlotSign then
				hidePartTransparency(trove, obj)
			end
		end
	end
end

function SkinService:CleanupPlot(plot)
	cleanPlot(plot)
end

return SkinService