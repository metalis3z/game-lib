local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryController = require(ReplicatedStorage.Source.Controllers.InventoryController)

local HoldingAnimationController = {}

-- Unified with EquipVisualController's hold pose ("Egg Idle Anim2") so every
-- held object -- brainrot, lucky block, loot item -- uses the same holding
-- animation. Uses the +1 Lucky Block group upload (134432300238280); the
-- identical clip under Comeback Games (99756604818753) is NOT accessible to
-- this experience and fails with a permission error.
local HOLD_ANIMATION_ID = "rbxassetid://134432300238280"
local player = Players.LocalPlayer

local currentTrack = nil

local function stopAnimation()
	if currentTrack then
		currentTrack:Stop(0.15)
		currentTrack = nil
	end
end

local function playAnimation()
	stopAnimation()

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = HOLD_ANIMATION_ID

	local ok, track = pcall(function()
		return animator:LoadAnimation(animation)
	end)
	animation:Destroy()
	if not ok or not track then
		warn("[HoldingAnimationController] hold animation failed to load: " .. tostring(track))
		return
	end
	track.Priority = Enum.AnimationPriority.Action4
	track.Looped = true
	track:Play(0.05)
	track:AdjustWeight(0.85)

	currentTrack = track
end

local carrying = false

function HoldingAnimationController.StartCarry()
	carrying = true
	playAnimation()
end

function HoldingAnimationController.StopCarry()
	carrying = false
	stopAnimation()
end

function HoldingAnimationController.Init()
	InventoryController.OnSelectionChanged(function(brainrotName)
		if brainrotName then
			playAnimation()
		else
			stopAnimation()
		end
	end)

	player.CharacterAdded:Connect(function()
		task.wait(0.5)
		if carrying or InventoryController.GetSelected() then
			playAnimation()
		end
	end)

	-- Single-hold rule: equipping the axe (or any REAL tool) means the player
	-- is not carrying a brainrot / lucky block, so the carry pose has to go.
	-- carrying is cleared here so the CharacterAdded re-spawn handler above
	-- won't re-play the animation on the next respawn.
	-- EXCEPTION: claimed rarity-loot tools (RarityLootTool attribute) ARE
	-- carried objects -- an invisible handle with the loot model welded on --
	-- so they get the same two-hand carry pose as every other held object
	-- instead of the stock one-arm tool grip (which read as "no holding
	-- animation" when a loot item was equipped).
	local function watchToolEquips(character)
		character.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				if child:GetAttribute("RarityLootTool") then
					playAnimation()
				else
					carrying = false
					stopAnimation()
				end
			end
		end)
		character.ChildRemoved:Connect(function(child)
			if child:IsA("Tool") and child:GetAttribute("RarityLootTool") and not carrying then
				stopAnimation()
			end
		end)
	end
	if player.Character then
		watchToolEquips(player.Character)
	end
	player.CharacterAdded:Connect(watchToolEquips)
end

return HoldingAnimationController