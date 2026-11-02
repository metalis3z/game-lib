-- SkipPadClient: squash-and-pop animation + Robux purchase prompt for the
-- SkipStagePad in every zone. Stepping on the green pad squashes the whole
-- model down, pops it back up past normal size, then settles -- and prompts
-- the pad's dev product. The ProductId attribute on the Pad part is read at
-- touch time, so pads stay animation-only while it's 0 and start prompting
-- the moment the real product ids are filled in (no script change needed).
-- Animation is client-side only (ScaleTo doesn't replicate), so each player
-- sees their own clean interaction.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- SkipStageService owns the purchase + teleport; the client only asks
local skipRemote
task.spawn(function()
	local remotes = ReplicatedStorage:WaitForChild("Remotes", 30)
	skipRemote = remotes and remotes:WaitForChild("SkipStage", 30)
end)

local SQUASH_SCALE = 0.75 -- press-in depth
local POP_SCALE = 1.12 -- overshoot past normal on the way back
local SQUASH_TIME = 0.12
local POP_TIME = 0.18
local SETTLE_TIME = 0.28
local PAD_COOLDOWN = 2 -- seconds between triggers per pad

local squashInfo = TweenInfo.new(SQUASH_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local popInfo = TweenInfo.new(POP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local settleInfo = TweenInfo.new(SETTLE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

-- one prompt at a time -- released when the purchase dialog closes
local promptBusy = false
MarketplaceService.PromptProductPurchaseFinished:Connect(function()
	promptBusy = false
end)

local function promptSkip(pad)
	local productId = pad:GetAttribute("ProductId")
	if type(productId) ~= "number" or productId <= 0 then
		return -- dev product not created yet -- animation only for now
	end
	if promptBusy then
		return
	end
	if not skipRemote then
		return
	end
	-- the purchase must run through SkipStageService (server PromptProduct
	-- + teleport-on-success); a raw client PromptProductPurchase would
	-- charge without granting anything
	promptBusy = true
	local ok = pcall(function()
		skipRemote:FireServer(pad)
	end)
	if not ok then
		promptBusy = false
	end
end

local function bindPad(model)
	local pad = model:FindFirstChild("Pad")
	if not (pad and pad:IsA("BasePart")) then
		return
	end

	-- tween a NumberValue and feed it to ScaleTo -- scales are absolute
	-- (relative to the model's original size), so the pad always lands
	-- back at exactly 1 with no drift between triggers
	local scaleValue = Instance.new("NumberValue")
	scaleValue.Value = 1
	scaleValue.Changed:Connect(function(v)
		model:ScaleTo(v)
	end)

	local readyAt = 0
	pad.Touched:Connect(function(hit)
		local char = player.Character
		if not char or not hit:IsDescendantOf(char) then
			return
		end
		if os.clock() < readyAt then
			return
		end
		readyAt = os.clock() + PAD_COOLDOWN

		local squash = TweenService:Create(scaleValue, squashInfo, { Value = SQUASH_SCALE })
		squash.Completed:Once(function()
			promptSkip(pad)
			local pop = TweenService:Create(scaleValue, popInfo, { Value = POP_SCALE })
			pop.Completed:Once(function()
				TweenService:Create(scaleValue, settleInfo, { Value = 1 }):Play()
			end)
			pop:Play()
		end)
		squash:Play()
	end)
end

-- streaming is disabled in this game, so a one-time scan catches all 30 pads
for _, inst in workspace:GetDescendants() do
	if inst.Name == "SkipStagePad" and inst:IsA("Model") then
		bindPad(inst)
	end
end