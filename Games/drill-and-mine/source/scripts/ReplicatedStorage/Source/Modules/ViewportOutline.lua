--[[
	ViewportOutline
	Sticker-style black border for item viewports, matching the black
	UIStroke borders the rest of the UI uses (a real UIStroke can't trace a
	3D render). Works the way a UIStroke does on text: the model is cloned
	into a pure black silhouette and stamped several times in a ring of
	SCREEN-PLANE offsets (perpendicular to the camera axis), pushed straight
	back so the depth test keeps the real model in front. The union of the
	offset stamps reads as a constant-width stroke around the 2D outline.
	(The previous scale-up-and-push-back approach made the width depend on
	each point's distance from the model center -- thick on long ends, thin
	near the middle, and enlarged features could poke through concave gaps,
	which read as stray "3D" lines crossing the object.)

	Call AFTER the model is parented and the camera is FINAL:
		ViewportOutline.Add(viewport, model, camera)
	The silhouette is parented next to the model (works inside WorldModels).
	Do NOT use on animated or spinning models -- the silhouette is static
	and would desync from the motion.
]]

local ViewportOutline = {}

-- Stroke width as a fraction of the model's bounding-sphere radius. The
-- card cameras sphere-fit every model, so this projects to the same
-- on-screen thickness on every card -- reads like the 4px twin-black
-- card borders at typical icon sizes.
ViewportOutline.Thickness = 0.15
-- How far behind the model the stamps sit (fraction of the camera
-- distance). Deeper = less chance of a stamp rim clipping in front.
ViewportOutline.DepthFrac = 0.35
-- Silhouette stamps around the ring. 8 leaves no visible gaps at this
-- thickness; raise it if Thickness ever grows a lot.
ViewportOutline.Stamps = 8

function ViewportOutline.Add(viewport, model, camera, parent)
	-- DISABLED 2026-07-16 (user request: no outlines on viewports). Every
	-- call site is left intact and tolerates the nil return; delete this
	-- early return to bring the stroke back.
	do
		return nil
	end
	if not (viewport and model and camera) then
		return nil
	end

	local ok, outline = pcall(function()
		local bbCF, bbSize = model:GetBoundingBox()
		local camOffset = camera.CFrame.Position - bbCF.Position
		local dist = camOffset.Magnitude
		if dist < 1e-3 then
			return nil
		end
		local dirToCam = camOffset / dist

		-- screen-plane basis: two axes perpendicular to the view direction,
		-- so every stamp offset is a pure 2D shift from the camera's POV
		local right = camera.CFrame.RightVector
		right = right - dirToCam * right:Dot(dirToCam)
		if right.Magnitude < 1e-3 then
			right = camera.CFrame.UpVector
			right = right - dirToCam * right:Dot(dirToCam)
		end
		right = right.Unit
		local up = dirToCam:Cross(right).Unit

		local silhouette = model:Clone()
		silhouette.Name = "OutlineStamp"
		for _, d in ipairs(silhouette:GetDescendants()) do
			if d:IsA("BasePart") then
				d.Color = Color3.new(0, 0, 0)
				d.Material = Enum.Material.SmoothPlastic
				d.Reflectance = 0
				d.CastShadow = false
				if d:IsA("MeshPart") then
					d.TextureID = ""
				end
			elseif d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 1
			elseif d:IsA("SurfaceAppearance") then
				d:Destroy()
			elseif d:IsA("AnimationController") or d:IsA("Humanoid") then
				-- the silhouette must hold the rest pose
				d:Destroy()
			elseif d:IsA("BaseScript") or d:IsA("Sound") then
				-- stamps are pure visuals; never run/play cloned logic
				d:Destroy()
			end
		end

		local depth = dist * ViewportOutline.DepthFrac
		-- grow ONLY compensates the perspective shrink from sitting further
		-- away, so each stamp lines up exactly behind the model; the visible
		-- stroke width comes purely from the ring offsets below
		local grow = (dist + depth) / dist
		silhouette:ScaleTo(silhouette:GetScale() * grow)

		-- recenter the (scaled) silhouette's bounding box on the model's
		-- center, pushed straight back away from the camera
		local silhouetteBB = silhouette:GetBoundingBox()
		local targetCenter = bbCF.Position - dirToCam * depth
		silhouette:PivotTo(CFrame.new(targetCenter - silhouetteBB.Position) * silhouette:GetPivot())

		-- world offset that projects to Thickness at the stamps' depth
		local strokeOffset = (bbSize.Magnitude / 2) * ViewportOutline.Thickness * grow

		local container = Instance.new("Model")
		container.Name = "OutlineSilhouette"
		local stamps = math.max(3, ViewportOutline.Stamps)
		for i = 1, stamps do
			local angle = (i - 1) / stamps * math.pi * 2
			local offset = (right * math.cos(angle) + up * math.sin(angle)) * strokeOffset
			-- the last iteration reuses the master clone instead of copying it
			local stamp = (i < stamps) and silhouette:Clone() or silhouette
			stamp:PivotTo(stamp:GetPivot() + offset)
			stamp.Parent = container
		end

		container.Parent = parent or model.Parent
		return container
	end)

	if not ok then
		return nil
	end
	return outline
end

return ViewportOutline
