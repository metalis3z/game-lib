--!strict
-- LOCAL 
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local Icons = require(frontend.Config.Icons)
local promptBulkPurchaseAsync = require(modules.AssetUtil.promptBulkPurchaseAsync)
local Children = Fusion.Children
local player = Players.LocalPlayer
local cachedRigTemplate: Model? = nil -- built once and cached for the session, every open just clones it
local rigBuildState: "idle" | "building" | "done" = "idle"


-- TYPES
type Scope = Fusion.Scope
type Props = {
	emoteId: number,
	animationId: number?,
	layoutOrder: Fusion.UsedAs<number>?,
}


-- LOCAL FUNCTIONS
-- The rig MUST be real Parts joined by Motor6Ds, not a clone of the live character
local function buildRigTemplate(): Model?
	local fetched, description = pcall(function()
		return Players:GetHumanoidDescriptionFromUserId(player.UserId)
	end)
	if not fetched or not description then
		warn("[EmotePreview] could not fetch HumanoidDescription:", description)
		return nil
	end
	local built, rig = pcall(function()
		return Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R15)
	end)
	if not built or not rig then
		warn("[EmotePreview] CreateHumanoidModelFromDescription failed:", rig)
		return nil
	end
	-- Clones must never run anything
	for _, descendant in rig:GetDescendants() do
		if descendant:IsA("BaseScript") then
			descendant:Destroy()
		end
	end
	return rig
end

local function getRigClone(): Model?
	if rigBuildState == "building" then
		repeat task.wait() until rigBuildState ~= "building"
	end
	if not cachedRigTemplate then
		rigBuildState = "building"
		cachedRigTemplate = buildRigTemplate()
		rigBuildState = "done"
	end
	if cachedRigTemplate then
		return cachedRigTemplate:Clone()
	end
	local character = player.Character
	if character and character:FindFirstChildOfClass("Humanoid") then
		local wasArchivable = character.Archivable
		character.Archivable = true
		local ok, clone = pcall(function()
			return character:Clone()
		end)
		character.Archivable = wasArchivable
		if ok and clone then
			return clone
		end
	end
	return nil
end

local function makeCatalogChip(scope: Scope, assetId: number): Instance
	return scope:New "Frame" {
		Name = "CatalogChip",
		BackgroundColor3 = Theme.Color.NeutralStroke,
		LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, 30),
		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			},
			scope:New "TextBox" {
				Name = "Link",
				BackgroundTransparency = 1,
				ClearTextOnFocus = false,
				TextEditable = false, -- read-only, but the user can still select + copy it
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
				end),
				Size = UDim2.fromScale(1, 1),
				Text = `roblox.com/catalog/{assetId}`,
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Body,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Center,
			},
		},
	}
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local emoteId = props.emoteId
	local emotesFuse = (scope :: any):Fuse("everyone", "Emotes")

	-- The purchase prompt can take ~3s to appear, so spin and block presses meanwhile
	local unlockLoading = scope:Value(false)
	local unlockContentVisible = scope:Computed(function(use)
		return not use(unlockLoading)
	end)

	local worldModel = scope:New "WorldModel" { Name = "ViewportWorldModel" }
	local camera = scope:New "Camera" { Name = "ViewportCamera" }
	local viewport = scope:New "ViewportFrame" {
		Name = "Preview",
		Ambient = Color3.fromRGB(200, 200, 200),
		BackgroundColor3 = Theme.Color.Neutral,
		CurrentCamera = camera,
		LightColor = Color3.fromRGB(255, 255, 255),
		LightDirection = Vector3.new(-0.4, -0.6, -1),
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 220),
		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			worldModel,
			camera,
		},
	}

	local cleanupFns: { () -> () } = {}
	table.insert(scope, function()
		for _, teardown in cleanupFns do
			pcall(teardown)
		end
	end)
	task.spawn(function()
		local rig = getRigClone()
		if not rig then
			warn("HD Admin: emote preview could not build a rig")
			return
		end
		table.insert(cleanupFns, function() rig:Destroy() end)
		rig:PivotTo(CFrame.new(0, 0, 0))
		rig.Parent = worldModel

		local hrp = rig:FindFirstChild("HumanoidRootPart") :: BasePart?
		if hrp then
			camera.FieldOfView = 20
			camera.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(180), 0) * CFrame.new(0, -0.1, 17.25)
		end

		local rigHumanoid = rig:FindFirstChildOfClass("Humanoid")
		if not rigHumanoid then return end
		local animator = rigHumanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = rigHumanoid
		end
		local animationId = props.animationId
		if not animationId then
			for _ = 1, 30 do
				local catalog = Fusion.peek(emotesFuse)
				local record: any = if typeof(catalog) == "table" then (catalog :: any)[tostring(emoteId)] else nil
				animationId = record and record.animationId
				if animationId then break end
				task.wait(0.1)
			end
		end
		if not animationId then return end

		-- LoadAnimation on the same frame the rig parents into the viewport breaks
		task.wait()

		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. tostring(animationId)
		animation.Parent = animator
		local ok, track = pcall(function()
			return (animator :: Animator):LoadAnimation(animation)
		end)
		if not ok or not track then
			warn(`HD Admin: emote preview could not load animation {animationId}: {track}`)
			return
		end
		track.Looped = true
		track.Priority = Enum.AnimationPriority.Action
		track:Play()
		table.insert(cleanupFns, function()
			track:Stop()
			track:Destroy()
		end)
	end)

	return scope:New "Frame" {
		Name = "EmotePreview",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			viewport,

			makeCatalogChip(scope, emoteId),

			scope:New "TextLabel" {
				Name = "Pitch",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				LayoutOrder = 3,
				Size = UDim2.new(1, 0, 0, 0),
				RichText = true,
				Text = 'Unlock this emote in <b><font color="#FFFFFF">every</font></b> Roblox game',
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Body,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Center,
			},

			Pressable(scope, {
				name = "UnlockButton",
				backgroundColor = Theme.Color.Primary,
				size = UDim2.new(1, 0, 0, 40),
				automaticSize = Enum.AutomaticSize.None,
				layoutOrder = 4,
				interactable = unlockContentVisible,
				onActivate = function()
					if Fusion.peek(unlockLoading) then return end
					unlockLoading:set(true)
					task.delay(2, function()
						unlockLoading:set(false)
					end)
					task.spawn(promptBulkPurchaseAsync, emoteId)
				end,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 8) },
					scope:New "Frame" {
						Name = "Content",
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Visible = unlockContentVisible,
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalAlignment = Enum.HorizontalAlignment.Center,
								Padding = UDim.new(0, 6),
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},
							scope:New "ImageLabel" {
								Name = "Icon",
								BackgroundTransparency = 1,
								Image = Icons.Unlock,
								ImageColor3 = Theme.Color.PrimaryContent,
								LayoutOrder = 1,
								Size = UDim2.fromOffset(18, 18),
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.X,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
								end),
								LayoutOrder = 2,
								Text = "Unlock",
								TextColor3 = Theme.Color.PrimaryContent,
								TextSize = Theme.TextSize.Subtitle,
							},
						},
					},
					(function()
						local spinner = LoadingSpinner(scope, {
							size = 14,
							thickness = 2,
							color = Theme.Color.PrimaryContent,
							paddingY = 0,
							visible = unlockLoading,
						}) :: any
						spinner.AnchorPoint = Vector2.new(0.5, 0.5)
						spinner.Position = UDim2.fromScale(0.5, 0.5)
						return spinner
					end)(),
				},
			}),
		},
	}
end
