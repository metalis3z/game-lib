--!strict
-- PlacementGrid (pattern module, shared: require it from both client and server)
-- Grid snapping, rotation, bounds and overlap checks for placing things on a plot, with
-- positions stored in plot-local space so a saved layout loads on any plot.
--
-- Ideas taken from: work-at-a-pizza-place (House:PlaceFurniture stores Marker:ToObjectSpace(cf)
-- and enforces a furniture cap), steal-an-egg (placeEgg: the client sends a LOCAL CFrame, the
-- server rebuilds the world CFrame, checks it is inside the pen and that the player is close),
-- grow-a-garden-2 (PlacementGrid / PotPlacementController: snap to a grid on the plot floor;
-- that game's code is not readable source, so only the idea is reused here).
--
-- Plot layout: a flat BasePart called "BuildArea" (top face = floor) inside the plot Model.
--
-- Client usage (preview):
--   local grid = PlacementGrid.new(plot.BuildArea, 4)          -- 4-stud cells
--   local cf = grid:SnapWorld(mouseHitPosition, rotationSteps, model:GetExtentsSize())
--   previewModel:PivotTo(cf)
--   placeRemote:FireServer(itemId, grid:ToLocal(cf))           -- send LOCAL CFrame only
--
-- Server usage (validate + place):
--   local grid = PlacementGrid.new(plot.BuildArea, 4)
--   local ok, worldCf, why = grid:Validate(localCf, size, { Ignore = { plot.Built } , Root = root, MaxReach = 60 })
--   if ok then model:PivotTo(worldCf); save { Id = itemId, CFrame = PlacementGrid.Encode(localCf) } end
--
-- Loading a save on a (possibly different) plot:
--   model:PivotTo(grid:ToWorld(PlacementGrid.Decode(saved.CFrame)))

local PlacementGrid = {}
PlacementGrid.__index = PlacementGrid

export type ValidateOptions = {
	Ignore: { Instance }?,  -- e.g. the plot's own floor parts; placed items are NOT ignored
	Root: BasePart?,        -- player's HumanoidRootPart for a reach check
	MaxReach: number?,
	AllowOverlap: boolean?,
}

function PlacementGrid.new(area: BasePart, cellSize: number)
	assert(cellSize > 0, "cellSize must be positive")
	local self = setmetatable({}, PlacementGrid)
	self.Area = area
	self.CellSize = cellSize
	return self
end

-- Floor origin: centre of the area's top face, keeping the area's rotation.
function PlacementGrid:Origin(): CFrame
	local area: BasePart = self.Area
	return area.CFrame * CFrame.new(0, area.Size.Y / 2, 0)
end

local function footprint(size: Vector3, steps: number): (number, number)
	-- Rotating by 90 or 270 degrees swaps the X and Z footprint.
	if steps % 2 == 1 then
		return size.Z, size.X
	end
	return size.X, size.Z
end

local function snapAxis(value: number, cell: number, extent: number): number
	-- Objects whose width is an odd number of cells sit on cell centres, even ones on lines.
	local cells = math.max(1, math.round(extent / cell))
	local offset = if cells % 2 == 1 then cell / 2 else 0
	return math.floor((value - offset) / cell + 0.5) * cell + offset
end

-- Snap a local position (relative to Origin) and build the local CFrame.
function PlacementGrid:SnapLocal(localPos: Vector3, rotationSteps: number, size: Vector3): CFrame
	local steps = rotationSteps % 4
	local fx, fz = footprint(size, steps)
	local x = snapAxis(localPos.X, self.CellSize, fx)
	local z = snapAxis(localPos.Z, self.CellSize, fz)
	return CFrame.new(x, size.Y / 2, z) * CFrame.Angles(0, math.rad(90 * steps), 0)
end

function PlacementGrid:SnapWorld(worldPos: Vector3, rotationSteps: number, size: Vector3): CFrame
	local localPos = self:Origin():PointToObjectSpace(worldPos)
	return self:ToWorld(self:SnapLocal(localPos, rotationSteps, size))
end

function PlacementGrid:ToLocal(worldCf: CFrame): CFrame
	return self:Origin():ToObjectSpace(worldCf)
end

function PlacementGrid:ToWorld(localCf: CFrame): CFrame
	return self:Origin() * localCf
end

-- True if a box of `size` at localCf stays inside the build area (with a small tolerance).
function PlacementGrid:InBounds(localCf: CFrame, size: Vector3): boolean
	local area: BasePart = self.Area
	local rotated = localCf.Rotation
	local half = size / 2
	local limitX, limitZ = area.Size.X / 2 + 0.05, area.Size.Z / 2 + 0.05
	for _, sx in ipairs({ -1, 1 }) do
		for _, sz in ipairs({ -1, 1 }) do
			local corner = localCf.Position + rotated * Vector3.new(half.X * sx, 0, half.Z * sz)
			if math.abs(corner.X) > limitX or math.abs(corner.Z) > limitZ then
				return false
			end
		end
	end
	return true
end

-- Is the cell already occupied? Shrinks the box slightly so neighbours that only touch pass.
function PlacementGrid:Overlaps(worldCf: CFrame, size: Vector3, ignore: { Instance }?): boolean
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local list: { Instance } = { self.Area }
	if ignore then
		for _, inst in ipairs(ignore) do
			table.insert(list, inst)
		end
	end
	params.FilterDescendantsInstances = list
	local shrink = Vector3.new(0.1, 0.1, 0.1)
	local parts = workspace:GetPartBoundsInBox(worldCf, size - shrink, params)
	for _, part in ipairs(parts) do
		if part.CanCollide or part:GetAttribute("Placed") then
			return true
		end
	end
	return false
end

-- Server-side check for a client request. Never trust the client's world position:
-- re-snap the local CFrame (so off-grid values are corrected), then check bounds, reach, overlap.
function PlacementGrid:Validate(localCf: any, size: Vector3, options: ValidateOptions?): (boolean, CFrame?, string?)
	if typeof(localCf) ~= "CFrame" then
		return false, nil, "bad cframe"
	end
	local opts: ValidateOptions = options or {}
	local _, yaw, _ = localCf:ToOrientation()
	local steps = math.round(math.deg(yaw) / 90) % 4
	local snapped = self:SnapLocal(localCf.Position, steps, size)
	if not self:InBounds(snapped, size) then
		return false, nil, "outside your plot"
	end
	local world = self:ToWorld(snapped)
	if opts.Root and opts.MaxReach and (opts.Root.Position - world.Position).Magnitude > opts.MaxReach then
		return false, nil, "too far away"
	end
	if not opts.AllowOverlap and self:Overlaps(world, size, opts.Ignore) then
		return false, nil, "something is already there"
	end
	return true, world, nil
end

-- DataStores can't hold CFrames: save the 12 components (or just x, z, steps if you prefer).
function PlacementGrid.Encode(cf: CFrame): { number }
	return { cf:GetComponents() }
end

function PlacementGrid.Decode(t: { number }): CFrame
	return CFrame.new(table.unpack(t))
end

return PlacementGrid
