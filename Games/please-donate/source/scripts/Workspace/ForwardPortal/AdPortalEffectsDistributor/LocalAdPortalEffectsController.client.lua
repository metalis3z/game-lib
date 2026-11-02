-- This LocalScript controls the client visual effects of a specific portal as the portal's status changes.


local portalModel = nil
local adPortal = nil
local portalTag = script:WaitForChild("PortalTag")
if portalTag then
	local startTime = os.clock()
	while (portalTag.Value == nil) and (os.clock()-startTime < 30) do	-- Wait up to 30 seconds for the PortalTag.Value to exist
		task.wait()
	end
	portalModel = portalTag.Value
end

if portalModel and portalModel.Parent then
	local door = portalModel:WaitForChild("Door", 30)
	if door and door.Parent then
		adPortal = door:WaitForChild("AdPortal", 30)
	end
end

if portalModel and adPortal then
	-- Portal was found
	local function UpdatePortalVisuals()
		if portalModel and portalModel.Parent and adPortal and adPortal.Parent then
			local enabled = adPortal.PortalStatus == Enum.AdPortalStatus.Active
			local door = adPortal.Parent
			if door and door.Parent and door:IsA("BasePart") then
				--TODO: Temporarily disabled this because adjusting door properties causes failed portal validation checks.
				--door.Color = enabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(163,162,165)
				--door.Material = enabled and Enum.Material.Neon or Enum.Material.Concrete
			end
			for _,child in pairs(portalModel:GetDescendants()) do
				-- Set neon parts to desired state (dim and plastic if not enabled)
				if child:IsA("BasePart") and child ~= door then
					if child.Name == "InactiveCover" then	-- Cover the portal door with concrete part when not active
						child.Transparency = enabled and 1 or 0
						child.CanCollide = not enabled
					end
					-- Neon parts get their initial colors cached and will be dimmed when inacvive.
					local litColor = child:GetAttribute("LitColor")
					if (not litColor) and child.Material == Enum.Material.Neon then
						litColor = child.Color
						child:SetAttribute("LitColor", litColor)
					end
					-- Parts with a cached "LitColor" will get updated to match current state
					if litColor then
						child.Material = enabled and Enum.Material.Neon or Enum.Material.Plastic
						if enabled then
							-- Original lit color if enabled
							child.Color = litColor
						else
							-- Dim the part color
							local H,S,V = litColor:ToHSV()
							child.Color = Color3.fromHSV(H, S*.5, V*.5)
						end
					end
				end
				-- Set effects to desired state
				if child:IsA("Beam") or child:IsA("Light") or child:IsA("ParticleEmitter") then
					child.Enabled = enabled
				end
			end
		end
	end
	UpdatePortalVisuals()
	adPortal:GetPropertyChangedSignal("PortalStatus"):Connect(UpdatePortalVisuals)
	
else
	-- Portal not found
	wait()	-- This solves a possible race condition where this localscript runs before/while the ScreenGui's parent is being set
	script.Parent:Destroy()
	
end