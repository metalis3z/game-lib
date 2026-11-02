-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlimeIcon, time of decompilation: Sun May  3 10:11:14 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local create = Vide.create
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local vector2 = Vector2.new(0.5, 0.6)
local t1 = {
	"SlimeData",
	"UseCanvasFrames"
}

local function ClipFrame(s1: string, uDim2: UDim2, p1, b1: boolean, p2) -- line: 35
	-- upvalues: create (copy), Frame (copy)
	local t2 = {
		Name = s1,
		Size = uDim2,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = p1,
		p2
	}

	if b1 then
		return create("CanvasGroup")(t2)
	end

	return Frame(t2)
end
local function ShinyOverlay(p3, p4, p5) -- line: 61
	-- upvalues: Vide (copy), Mutations (copy), ImageLabel (copy), ImageIds (copy)
	local v27 = Vide.derive(function() -- line: 62
		-- upvalues: Mutations (copy), p3 (copy)
		return Mutations.has(p3().mutations, "shiny")
	end)

	return Vide.show(v27, function() -- line: 66
		-- upvalues: ImageLabel (copy), ImageIds (copy), p4 (copy), p5 (copy)
		return ImageLabel({
			Name = "ShinyOverlay",
			Image = ImageIds.shinyOverlay,
			ImageTransparency = p4,
			Size = UDim2.fromScale(1.4, 1.4),
			Position = UDim2.fromScale(0.5, 0.55),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = p5
		})
	end)
end
local function ZoomedIcon(p6, p7, p8, p9, b2: boolean) -- line: 79
	-- upvalues: Slimes (copy), vector2 (copy), ClipFrame (copy), ImageLabel (copy)
	local v33 = table.clone(p6)

	function v33.Image() -- line: 81
		-- upvalues: p7 (copy), Slimes (copy)
		local v58 = p7()

		return Slimes.getImage(v58.id, v58.mutations)
	end

	v33.Size = p8
	v33.Position = p9
	v33.AnchorPoint = vector2

	local v34 = table.clone(v33)

	v34.ImageColor3 = Color3.fromRGB(0, 0, 0)

	return {
		ClipFrame("IconClipFrame", UDim2.fromScale(0.77, 0.77), 1, b2, ImageLabel(v33)),
		ClipFrame("IconStrokeFrame", UDim2.fromScale(0.85, 0.85), 0, b2, ImageLabel(v34))
	}
end
local function BasicIcon(p10, p11, p12, p13) -- line: 105
	-- upvalues: Slimes (copy), ImageLabel (copy)
	function p10.Image() -- line: 106
		-- upvalues: p11 (copy), Slimes (copy)
		local v59 = p11()

		return Slimes.getImage(v59.id, v59.mutations)
	end

	p10.Size = p12
	p10.Position = p13
	p10.AnchorPoint = Vector2.new(0.5, 0.5)

	return ImageLabel(p10)
end

return function(p14) -- line: 116
	-- upvalues: RemoveKeys (copy), t1 (copy), Vide (copy), Slimes (copy), Mutations (copy), Frame (copy), ShinyOverlay (copy), ZoomedIcon (copy), BasicIcon (copy)
	local v40, v41 = RemoveKeys(p14, t1, true)
	local v42 = Vide.derive(function() -- line: 118
		-- upvalues: Vide (copy), p14 (copy)
		return Vide.read(p14.SlimeData)
	end)
	local v43 = Vide.derive(function() -- line: 121
		-- upvalues: v42 (copy), Slimes (copy)
		local v60 = v42()

		return Slimes.getSlime(v60.id)
	end)
	local v44 = Vide.derive(function() -- line: 125
		-- upvalues: Mutations (copy), v42 (copy)
		return Mutations.getIconZoom(v42().mutations)
	end)
	local v45 = Vide.derive(function() -- line: 128
		-- upvalues: v44 (copy)
		return v44() > 1
	end)
	local v46 = Vide.derive(function() -- line: 131
		-- upvalues: v43 (copy), v44 (copy)
		local v61 = (v43().iconSize or 1) * v44()

		return UDim2.fromScale(v61, v61)
	end)
	local v47 = Vide.derive(function() -- line: 135
		-- upvalues: v43 (copy)
		return v43().iconPosition or UDim2.fromScale(0.5, 0.5)
	end)
	local v48 = p14.UseCanvasFrames == true
	local v49 = Frame
	local t3 = {
		Name = "SlimeIcon",
		Size = p14.Size,
		Position = p14.Position,
		AnchorPoint = p14.AnchorPoint,
		ZIndex = p14.ZIndex,
		SizeConstraint = p14.SizeConstraint
	}
	local v51 = ShinyOverlay
	local p14ImageTransparency = p14.ImageTransparency
	local p14ZIndex = p14.ZIndex
	local n1

	if p14ZIndex == nil then
		n1 = 10
	else
		local n2 = 9

		function n1() -- line: 30
			-- upvalues: Vide (copy), p14ZIndex (copy), n2 (copy)
			return (Vide.read(p14ZIndex) or 1) + n2
		end
	end

	local v56 = v51(v42, p14ImageTransparency, n1)
	local v57 = Vide.show(v45, function() -- line: 149
		-- upvalues: ZoomedIcon (copy), v40 (copy), v42 (copy), v46 (copy), v47 (copy), v48 (copy)
		return (ZoomedIcon(v40, v42, v46, v47, v48))
	end, function() -- line: 151
		-- upvalues: BasicIcon (copy), v40 (copy), v42 (copy), v46 (copy), v47 (copy)
		return BasicIcon(v40, v42, v46, v47)
	end)

	t3[1] = v56
	t3[2] = v57
	t3[3] = v41

	return v49(t3)
end
