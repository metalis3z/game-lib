-- StudsTileFixClient: keeps the studded button texture's tiles at the
-- game-standard aspect on ANY screen. TileSize authored in SCALE units
-- makes the tile aspect depend on the element's own aspect ratio, which
-- squished the texture on wide buttons. Everything tagged "AspectTrueTile"
-- gets TileSize rewritten in PIXELS: the authored tile HEIGHT is kept
-- exactly (authored Y scale x current height), the width derives from the
-- standard tile aspect the tuned Robux-shop buttons render at (86:114).
-- Re-applied whenever the element resizes. Ported from "+1 Kick Door Per
-- Click" 2026-07-21.
local CollectionService = game:GetService("CollectionService")

local TAG = "AspectTrueTile"
local TILE_ASPECT = 86 / 114 -- px width per px height: the Shop-frame standard

local fixed = {} -- [ImageLabel] = authored TileSize.Y.Scale

local function apply(img)
	local yScale = fixed[img]
	if not yScale then return end
	local h = img.AbsoluteSize.Y * yScale
	if h <= 0 then return end -- not laid out yet (StarterGui original / pre-layout)
	img.TileSize = UDim2.fromOffset(math.floor(h * TILE_ASPECT + 0.5), math.floor(h + 0.5))
end

local function register(img)
	if fixed[img] then return end
	if not (img:IsA("ImageLabel") or img:IsA("ImageButton")) then return end
	if img.ScaleType ~= Enum.ScaleType.Tile then return end
	fixed[img] = img.TileSize.Y.Scale
	img:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		apply(img)
	end)
	apply(img)
end

CollectionService:GetInstanceAddedSignal(TAG):Connect(register)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(img)
	fixed[img] = nil
end)
for _, img in ipairs(CollectionService:GetTagged(TAG)) do
	register(img)
end
