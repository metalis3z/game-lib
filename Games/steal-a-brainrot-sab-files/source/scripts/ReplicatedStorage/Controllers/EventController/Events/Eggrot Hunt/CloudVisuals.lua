local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local FFlags = require(ReplicatedStorage.Packages.FFlags)

local CLOUD_TAGS = {
	"EggrotCloud",
	"EggrotCloud_Candy",
	"EggrotCloud_Lava",
	"EggrotCloud_Galaxy",
	"EggrotCloud_Divine",
}

local FADEABLE_TAGS = {
	EggrotCloud_Candy  = true,
	EggrotCloud_Lava   = true,
	EggrotCloud_Galaxy = true,
	EggrotCloud_Divine = true,
}

local STAND_BEFORE_FADE = 2
local FADE_OUT_TIME     = 1.0
local HIDDEN_WAIT       = 3
local FADE_IN_TIME      = 0.8
local TOP_HITBOX_HEIGHT = 2.5
local LocalPlayer = Players.LocalPlayer

local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include

return table.freeze({
	Start = function(_)
		local trove = Trove.new()
		local clouds = {}

		local function enableCollision(cd)
			if cd.Colliding then return end
			cd.Colliding = true
			for _, p in ipairs(cd.CollidableParts) do
				p.CanCollide = true
				p.CanTouch = true
			end
		end

		local function disableCollision(cd)
			if not cd.Colliding then return end
			cd.Colliding = false
			for _, p in ipairs(cd.CollidableParts) do
				p.CanCollide = false
				p.CanTouch = false
			end
		end

		local function cancelTweens(cd)
			for _, tw in ipairs(cd.activeTweens) do tw:Cancel() end
			table.clear(cd.activeTweens)
		end

		local function startFadeOut(cd)
			if cd.fadeState ~= "visible" then return end
			cd.fadeState = "fading_out"
			cancelTweens(cd)
			local info = TweenInfo.new(FADE_OUT_TIME, Enum.EasingStyle.Linear)
			for _, p in ipairs(cd.Parts) do
				local tw = TweenService:Create(p, info, {Transparency = 1})
				table.insert(cd.activeTweens, tw)
				tw:Play()
			end
			task.delay(FADE_OUT_TIME, function()
				if cd.fadeState ~= "fading_out" then return end
				cd.fadeState = "hidden"
				task.delay(HIDDEN_WAIT, function()
					if cd.fadeState ~= "hidden" then return end
					cd.fadeState = "fading_in"
					cancelTweens(cd)
					local ri = TweenInfo.new(FADE_IN_TIME, Enum.EasingStyle.Linear)
					for _, p in ipairs(cd.Parts) do
						local orig = cd.OriginalTransparencies[p] or 0
						local tw = TweenService:Create(p, ri, {Transparency = orig})
						table.insert(cd.activeTweens, tw)
						tw:Play()
					end
					task.delay(FADE_IN_TIME, function()
						if cd.fadeState ~= "fading_in" then return end
						cd.fadeState = "visible"
						cd.standTime = 0
					end)
				end)
			end)
		end

		local function buildTopHitbox(cd)
			if cd.topHitbox then
				cd.topHitbox:Destroy()
				cd.topHitbox = nil
			end

			if cd.TopY == -math.huge or #cd.CollidableParts == 0 then return end

			local minX, maxX = math.huge, -math.huge
			local minZ, maxZ = math.huge, -math.huge

			for _, p in ipairs(cd.CollidableParts) do
				local hx = p.Size.X * 0.5
				local hz = p.Size.Z * 0.5
				if p.Position.X - hx < minX then minX = p.Position.X - hx end
				if p.Position.X + hx > maxX then maxX = p.Position.X + hx end
				if p.Position.Z - hz < minZ then minZ = p.Position.Z - hz end
				if p.Position.Z + hz > maxZ then maxZ = p.Position.Z + hz end
			end

			local cx = (minX + maxX) * 0.5
			local cz = (minZ + maxZ) * 0.5
			local sx = maxX - minX
			local sz = maxZ - minZ
			local cy = cd.TopY + TOP_HITBOX_HEIGHT * 0.5

			local hitbox = Instance.new("Part")
			hitbox.Size = Vector3.new(sx, TOP_HITBOX_HEIGHT, sz)
			hitbox.CFrame = CFrame.new(cx, cy, cz)
			hitbox.Anchored = true
			hitbox.CanCollide = false
			hitbox.CanTouch = false
			hitbox.CanQuery = true
			hitbox.Transparency = 1
			hitbox.Parent = workspace

			cd.topHitbox = hitbox
		end

		local function getCharParts(char)
			local parts = {}
			for _, desc in ipairs(char:GetDescendants()) do
				if desc:IsA("BasePart") then
					table.insert(parts, desc)
				end
			end
			return parts
		end

		trove:Add(RunService.PostSimulation:Connect(function(dt)
			local char = LocalPlayer.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			overlapParams.FilterDescendantsInstances = getCharParts(char)

			for _, cd in pairs(clouds) do
				if cd.Hidden then
					disableCollision(cd)
					continue
				end

				if not cd.topHitbox then
					disableCollision(cd)
					continue
				end

				local touching = #workspace:GetPartsInPart(cd.topHitbox, overlapParams) > 0

				if touching then
					enableCollision(cd)
					if cd.canFade and cd.fadeState == "visible" then
						cd.standTime = (cd.standTime or 0) + dt
						if cd.standTime >= STAND_BEFORE_FADE then
							startFadeOut(cd)
						end
					end
				else
					disableCollision(cd)
					cd.standTime = 0
				end
			end
		end))

		for _, tag in ipairs(CLOUD_TAGS) do
			local canFade = FADEABLE_TAGS[tag] == true
			trove:Add(Observers.observeTag(tag, function(obj)
				local objTrove = Trove.new()
				local cd = {
					Parts = {},
					CollidableParts = {},
					OriginalTransparencies = {},
					Colliding = false,
					Hidden = obj:GetAttribute("EggrotCloudHidden") == true,
					TopY = -math.huge,
					fadeState = "visible",
					standTime = 0,
					activeTweens = {},
					canFade = canFade,
					topHitbox = nil,
				}
				clouds[obj] = cd

				local function addPart(part)
					table.insert(cd.Parts, part)
					cd.OriginalTransparencies[part] = part.Transparency
					if part.CanCollide and not part:HasTag("EggrotCloudIgnoreCollision") then
						table.insert(cd.CollidableParts, part)
						part.CanCollide = false
						part.CanTouch = false
						part.CanQuery = true
						local topEdge = part.Position.Y + part.Size.Y * 0.5
						if topEdge > cd.TopY then cd.TopY = topEdge end
					end
					if cd.Hidden then part.Transparency = 1 end
				end

				local function removePart(part)
					for i, p in ipairs(cd.Parts) do
						if p == part then table.remove(cd.Parts, i) break end
					end
					for i, p in ipairs(cd.CollidableParts) do
						if p == part then
							table.remove(cd.CollidableParts, i)
							p.CanCollide = true
							p.CanTouch = true
							p.CanQuery = true
							break
						end
					end
					local orig = cd.OriginalTransparencies[part]
					if orig then part.Transparency = orig end
					cd.OriginalTransparencies[part] = nil
				end

				if obj:IsA("BasePart") then addPart(obj) end
				objTrove:Add(Observers.observeDescendants(obj, function(child)
					if not child:IsA("BasePart") then return nil end
					addPart(child)
					buildTopHitbox(cd)
					return function()
						removePart(child)
						buildTopHitbox(cd)
					end
				end))

				buildTopHitbox(cd)

				objTrove:Add(obj:GetAttributeChangedSignal("EggrotCloudHidden"):Connect(function()
					cancelTweens(cd)
					local hidden = obj:GetAttribute("EggrotCloudHidden") == true
					cd.Hidden = hidden
					if hidden then
						disableCollision(cd)
						for _, p in ipairs(cd.Parts) do p.Transparency = 1 end
					else
						local dur = FFlags:GetInstant("EggrotCloud/ReappearDuration", 0.5)
						local info = TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						for _, p in ipairs(cd.Parts) do
							local orig = cd.OriginalTransparencies[p]
							if orig then
								local tw = TweenService:Create(p, info, {Transparency = orig})
								table.insert(cd.activeTweens, tw)
								tw:Play()
							end
						end
					end
				end))

				return function()
					clouds[obj] = nil
					cancelTweens(cd)
					if cd.topHitbox then cd.topHitbox:Destroy() end
					for _, p in ipairs(cd.CollidableParts) do
						p.CanCollide = true
						p.CanTouch = true
						p.CanQuery = true
					end
					for _, p in ipairs(cd.Parts) do
						local orig = cd.OriginalTransparencies[p]
						if orig then p.Transparency = orig end
					end
					objTrove:Destroy()
				end
			end, {workspace}))
		end

		return function()
			trove:Destroy()
			table.clear(clouds)
		end
	end,
})