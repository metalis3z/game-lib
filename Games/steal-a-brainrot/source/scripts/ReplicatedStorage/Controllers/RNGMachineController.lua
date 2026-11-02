--██    ██  ██████  ████████ ██████
--██    ██ ██    ██    ██    ██   ██ 
--██    ██ ██    ██    ██    ██   ██ 
-- ██  ██  ██    ██    ██    ██   ██ 
--  ████    ██████  ████████ ██████
--
--██████  ███████  ██████  ███████  ███    ███ ██████  ██ ██      ███████ ██████  
--██   ██ ██      ██       ██   ██  ████  ████ ██   ██ ██ ██      ██      ██   ██  
--██   ██ █████   ██       ██   ██  ██ ████ ██ ██████  ██ ██      █████   ██████  
--██   ██ ██      ██       ██   ██  ██  ██  ██ ██      ██ ██      ██      ██   ██ 
--██████  ███████  ██████  ███████  ██      ██ ██      ██ ███████ ███████ ██   ██
--
-- Void Decompiler made by Void
-- Void Decompiles Discord: https://discord.gg/PDvWTCa5Ef
                                        -- https://lua.expert/
local ContentProvider, Players, TextService, CustomRichTextController, Observers, Synchronizer, Mutations, v3, v4, t, LocalPlayer, v5, v6, v7, v8, v10, v31, v32, v33, v34, v40, v46, t3, v47, v52, v53, v54, observeMutationScreen, observeMutationScreenLine, setCanvasOffset, focusSkillTreeSelection, animateNewlyRevealedNodes, observeSkillTreePrompt, observeSpinPrompt, clearDisplay, prepareStageDisplay, observeDisplayCenter, v56, v57, v58, v59, v60, observeLeverRoot, setLuckySpinVfx, emitHighLuckExplosion

do
	local CollectionService = game:GetService("CollectionService")

	ContentProvider = game:GetService("ContentProvider")

	local Debris = game:GetService("Debris")
	local GuiService = game:GetService("GuiService")

	Players = game:GetService("Players")

	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	TextService = game:GetService("TextService")

	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local Animals = require(ReplicatedStorage.Shared.Animals)
	local BrainrotAssets = require(ReplicatedStorage.Shared.BrainrotAssets)

	CustomRichTextController = require(ReplicatedStorage.Controllers.CustomRichTextController)

	local AnimalOverheadController = require(ReplicatedStorage.Controllers.AnimalOverheadController)
	local BackpackController = require(ReplicatedStorage.Controllers.BackpackController)
	local FastOverheadController = require(ReplicatedStorage.Controllers.FastOverheadController)
	local SoundController = require(ReplicatedStorage.Controllers.SoundController)
	local Net = require(ReplicatedStorage.Packages.Net)

	Observers = require(ReplicatedStorage.Packages.Observers)

	local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
	local Spr = require(ReplicatedStorage.Packages.Spr)

	Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	require(ReplicatedStorage.Packages.Synchronizer.Channel)

	local Trove = require(ReplicatedStorage.Packages.Trove)
	local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
	local Animals2 = require(ReplicatedStorage.Datas.Animals)
	local LuckIcons = require(ReplicatedStorage.Datas.LuckIcons)

	Mutations = require(ReplicatedStorage.Datas.Mutations)

	local RNGMachineData = require(ReplicatedStorage.Datas.RNGMachineData)
	local VFX = require(ReplicatedStorage.Shared.VFX)
	local v1 = Net:RemoteFunction("RNGMachineService/Buy")
	local v2 = Net:RemoteFunction("RNGMachineService/BuySkill")

	v3 = Net:RemoteEvent("RNGMachineService/SpinStage")
	v4 = Net:RemoteEvent("RNGMachineService/LuckExplosion")
	t = {}
	LocalPlayer = Players.LocalPlayer

	local PlayerGui = LocalPlayer.PlayerGui

	v5 = ReplicatorClient.get((("RNGMachine_%*"):format(LocalPlayer.UserId)))
	v6 = ReplicatorClient.get("RNGMachineActivity")

	local Animals3 = ReplicatedStorage.Animations.Animals

	v7 = ReplicatedStorage.Sounds.Sfx["RNG Machine"]
	v8 = nil

	local v9 = table.freeze({ "I", "II", "III", "IV", "V", "VI", "VII" })

	v10 = table.freeze({ "Luck", "Speed", "GoldMutation", "DiamondMutation", "RainbowMutation", "EventMutation" })

	local v11 = LuckIcons["2x"]
	local Icon = (Mutations.Crystal and Mutations.Crystal.Icon) or (Mutations.Candy and Mutations.Candy.Icon) or ""
	local v12 = table.freeze({ "rbxassetid://109197687749885", "rbxassetid://140082451010054", "rbxassetid://118043092840867", "rbxassetid://99161525590490", "rbxassetid://92307396985409", "rbxassetid://102896229500021" })
	local v13 = table.freeze({ Mutations.Gold.Icon, "rbxassetid://92030344139640", "rbxassetid://89363812265296" })
	local v14 = table.freeze({ Mutations.Diamond.Icon, "rbxassetid://102810669205215", "rbxassetid://137640109371878" })
	local v15 = table.freeze({ Mutations.Rainbow.Icon, "rbxassetid://81050017254533", "rbxassetid://89484412421203" })
	local v16 = table.freeze({ "rbxassetid://116329858308535", "rbxassetid://111075055814781", "rbxassetid://131490709703976", "rbxassetid://135858566074631", "rbxassetid://127684169481211", "rbxassetid://117312654669919" })
	local v17 = Vector2.new(2400, 2200)
	local v18 = Vector2.new(1200, 1400)
	local v19 = v18 / v17
	local v20 = Vector2.new(145, 145)
	local v21 = Color3.fromRGB(138, 138, 138)
	local v22 = Color3.fromRGB(65, 65, 65)
	local v23 = v20.X / 1.1
	local v24 = v20.X * 0.75
	local v25 = v23 * 0.5
	local v26 = table.freeze({
		Luck = table.freeze({
			v18 + Vector2.new(-v24, v25),
			v18 + Vector2.new(-v24 * 2, 0),
			v18 + Vector2.new(-v24 * 3, v25),
			v18 + Vector2.new(-v24 * 3, -v25),
			v18 + Vector2.new(-v24 * 4, 0),
			v18 + Vector2.new(-v24 * 5, -v25)
		}),
		Speed = table.freeze({
			v18 + Vector2.new(0, v23),
			v18 + Vector2.new(v24, v23 + v25),
			v18 + Vector2.new(0, v23 * 2),
			v18 + Vector2.new(v24, v23 * 2 + v25),
			v18 + Vector2.new(v24 * 2, v23 * 2),
			v18 + Vector2.new(v24 * 2, v23 * 3)
		}),
		GoldMutation = table.freeze({ v18, v18 + Vector2.new(0, -v23), v18 + Vector2.new(v24, -v25) }),
		DiamondMutation = table.freeze({ v18 + Vector2.new(v24 * 2, -v23), v18 + Vector2.new(v24, -v23 - v25), v18 + Vector2.new(0, -v23 * 2) }),
		RainbowMutation = table.freeze({ v18 + Vector2.new(0, -v23 * 3), v18 + Vector2.new(v24, -v23 * 2 - v25), v18 + Vector2.new(v24 * 2, -v23 * 2) })
	})
	local v27 = table.freeze({
		v18,
		v18 + Vector2.new(v24, -v25),
		v18 + Vector2.new(0, -v23),
		v18 + Vector2.new(-v24, -v23 - v25),
		v18 + Vector2.new(0, -v23 * 2),
		v18 + Vector2.new(v24, -v23 * 2 - v25)
	})
	local v28 = v18 + Vector2.new(v24 * 2, -v23 * 3)
	local v29 = v18 + Vector2.new(-v24, v25)
	local v30 = nil

	v31 = nil
	v32 = "Main"
	v33 = false
	v34 = nil

	local v35 = nil
	local v36 = nil
	local v37 = nil
	local v38 = 0.82
	local zero = Vector2.zero
	local v39 = 0.82
	local t2 = {}

	v40 = nil

	local v41 = false
	local v42 = 0
	local v43 = false
	local v44 = nil
	local zero2 = Vector2.zero
	local zero3 = Vector2.zero
	local v45 = 0

	v46 = false
	t3 = {
		PrivateStagePayload = nil,
		ActivityData = nil,
		SelectedIdentity = nil,
		SelectedOwnerUserId = nil,
		SelectedState = nil,
		StageVisualEndsAt = 0,
		ActiveSpinner = nil,
		ActiveTween = nil,
		ActiveConnection = nil,
		SpinningText = nil,
		SpinningTextToken = 0,
		LatestOfferExpiresAt = 0,
		OptimisticSpinToken = 0
	}
	v47 = nil

	local t4 = {}
	local v48 = nil
	local v49 = nil
	local v50 = nil
	local v51 = nil

	v52 = nil
	v53 = nil
	v54 = nil

	local t5 = {}
	local t6 = {}
	local t7 = {}
	local t8 = {}
	local t9 = {}
	local t10 = {}
	local v55 = nil

	local function updateMutationScreen(p1) --[[ updateMutationScreen | Line: 284 | Upvalues: v52 (ref), Mutations (copy), v53 (ref), CustomRichTextController (copy), v54 (ref) ]]
		v52 = if p1 == nil or p1 == "Normal" then nil else p1

		local v2 = v52 or ""
		local v3 = Mutations[v2]
		local v4 = if v3 then v3.DisplayWithRichText or v3.DisplayText else v2

		if v53 then
			CustomRichTextController.apply(v53, v4, {
				attachToInstance = true
			})
		end

		if not v54 then
			return
		end

		v54.LocalTransparencyModifier = if v52 then 1 else 0
	end

	observeMutationScreen = function(p1) --[[ observeMutationScreen | Line: 297 | Upvalues: v53 (ref), updateMutationScreen (copy), v52 (ref), CustomRichTextController (copy) ]]
		if p1:IsA("TextLabel") then
			v53 = p1
			updateMutationScreen(v52)

			return function() --[[ Line: 304 | Upvalues: v53 (ref), p1 (copy), CustomRichTextController (ref) ]]
				if v53 ~= p1 then
					return
				end

				CustomRichTextController.cleanup(p1)
				v53 = nil
			end
		end

		return nil
	end
	observeMutationScreenLine = function(p1) --[[ observeMutationScreenLine | Line: 312 | Upvalues: v54 (ref), updateMutationScreen (copy), v52 (ref) ]]
		if p1:IsA("BasePart") then
			v54 = p1
			updateMutationScreen(v52)

			return function() --[[ Line: 319 | Upvalues: v54 (ref), p1 (copy) ]]
				if v54 ~= p1 then
					return
				end

				p1.LocalTransparencyModifier = 0
				v54 = nil
			end
		end

		return nil
	end

	local function getTemplate(p1, p2) --[[ getTemplate | Line: 329 ]]
		for i, v in ipairs(p1:GetChildren()) do
			if v.Name == p2 and v:IsA("ImageButton") then
				return v
			end
		end

		error((("Missing SkillTree template %*"):format(p2)))
	end

	local function getSkillPosition(p1, p2) --[[ getSkillPosition | Line: 339 | Upvalues: v32 (ref), v27 (copy), v26 (copy) ]]
		if v32 == "EventMutation" then
			return v27[p2]
		end

		return v26[p1][p2]
	end

	local function setNodeText(p1, p2, p3, p4) --[[ setNodeText | Line: 346 | Upvalues: v31 (ref), NumberUtils (copy), LuckIcons (copy), v11 (copy), v12 (copy), v13 (copy), v14 (copy), v15 (copy), v16 (copy) ]]
		local v1 = v31

		if not v1 then
			return
		end

		local v2 = v1.SkillTree[p2][p3]
		local Title = p1:FindFirstChild("Title")

		if Title and Title:IsA("TextLabel") then
			Title.Text = if p2 == "Luck" then ("%*x"):format(v2.Multiplier) elseif p2 == "Speed" then ("Speed %*"):format(p3) elseif p2 == "EventMutation" then ("Tier %*"):format(p3) else ("%* %*"):format(v2.Mutation, p3)
		end

		local Txt = p1:FindFirstChild("Txt")

		if Txt and Txt:IsA("TextLabel") then
			Txt.Text = if p4 == "RebirthLocked" then "Locked" elseif p4 == "Owned" then "Owned" else ("$%*"):format((NumberUtils:ToString(v2.Cost)))
		end

		local LockedOverlay = p1:FindFirstChild("LockedOverlay")

		if LockedOverlay then
			local Txt2 = LockedOverlay:FindFirstChild("Txt")

			if Txt2 and Txt2:IsA("TextLabel") then
				Txt2.Text = ("%* REBIRTHS"):format(v2.RequiredRebirths)
			end
		end

		local Icon = p1:FindFirstChild("Icon")

		if not (Icon and Icon:IsA("ImageLabel")) then
			return
		end

		Icon.Image = if p2 == "Luck" then LuckIcons[("%*x"):format(v2.Multiplier)] or v11 elseif p2 == "Speed" then v12[p3] elseif p2 == "GoldMutation" then v13[p3] elseif p2 == "DiamondMutation" then v14[p3] elseif p2 == "RainbowMutation" then v15[p3] elseif p2 == "EventMutation" then v16[p3] else ""
	end

	local function configureNode(p1, p2, p3) --[[ configureNode | Line: 390 | Upvalues: v20 (copy) ]]
		p1.Name = p2
		p1.AnchorPoint = Vector2.new(0.5, 0.5)
		p1.Position = UDim2.fromOffset(p3.X, p3.Y)
		p1.Size = UDim2.fromOffset(v20.X, v20.Y)
		p1.Visible = true

		local Title = p1:FindFirstChild("Title")

		if Title and Title:IsA("TextLabel") then
			Title.Position = Title.Position - UDim2.fromScale(0, 0.07)
		end

		local Txt = p1:FindFirstChild("Txt")

		if Txt and Txt:IsA("TextLabel") then
			Txt.Position = Txt.Position + UDim2.fromScale(0, 0.07)
		end

		local LockedOverlay = p1:FindFirstChild("LockedOverlay")
		local v1 = if LockedOverlay then LockedOverlay:FindFirstChild("Txt") else LockedOverlay

		if not (v1 and v1:IsA("TextLabel")) then
			return
		end

		v1.Position = v1.Position + UDim2.fromScale(0, 0.07)
	end

	function t._buySkill(p1, p2) --[[ _buySkill | Line: 412 | Upvalues: v41 (ref), v31 (ref), v2 (copy) ]]
		if v41 then
			return
		end

		local v1 = v31

		if v1 and not (v1.Skills[p2].Level >= #v1.SkillTree[p2]) then
			v41 = true
			task.spawn(function() --[[ Line: 422 | Upvalues: v2 (ref), p2 (copy), v41 (ref) ]]
				local ok, result, result2 = pcall(function() --[[ Line: 423 | Upvalues: v2 (ref), p2 (ref) ]]
					return v2:InvokeServer(p2)
				end)

				if ok then
					if result == true or not result2 then
						v41 = false

						return
					end

					warn(result2)
				else
					warn(result)
				end

				v41 = false
			end)
		end
	end

	local function createEventMutationNavigation(p1) --[[ createEventMutationNavigation | Line: 436 | Upvalues: v31 (ref), t2 (copy), configureNode (copy), v28 (copy), Icon (copy), t (copy) ]]
		local v1 = v31

		if not v1 then
			return
		end

		local v2 = t2.Open:Clone()

		configureNode(v2, "EventMutationTree", v28)

		local Title = v2:FindFirstChild("Title")

		if Title and Title:IsA("TextLabel") then
			Title.Text = "Event Mutations"
		end

		local Txt = v2:FindFirstChild("Txt")

		if Txt and Txt:IsA("TextLabel") then
			Txt.Text = "Open"
		end

		local Icon2 = v2:FindFirstChild("Icon")

		if Icon2 and Icon2:IsA("ImageLabel") then
			Icon2.Image = Icon
		end

		local v3 = v1.SkillTree.EventMutation[v1.Skills.EventMutation.Level + 1]
		local Notif = v2:FindFirstChild("Notif")

		if Notif and Notif:IsA("GuiObject") then
			Notif.Visible = if v3 == nil then false else v1.Rebirths >= v3.RequiredRebirths
		end

		local Hitbox = v2:FindFirstChild("Hitbox")

		if Hitbox and Hitbox:IsA("ImageButton") then
			Hitbox.Active = true
			Hitbox.Interactable = true
			Hitbox.Selectable = true
			Hitbox.Activated:Connect(function() --[[ Line: 467 | Upvalues: t (ref) ]]
				t:_setSkillTreePage("EventMutation")
			end)
		end

		v2.Parent = p1
	end

	local function createEventMutationBack(p1) --[[ createEventMutationBack | Line: 475 | Upvalues: t2 (copy), configureNode (copy), v29 (copy), t (copy) ]]
		local v1 = t2.Owned:Clone()

		configureNode(v1, "EventMutationBack", v29)
		v1.ImageColor3 = Color3.fromRGB(221, 67, 67)

		local Title = v1:FindFirstChild("Title")

		if Title and Title:IsA("TextLabel") then
			Title.Visible = false
		end

		local Txt = v1:FindFirstChild("Txt")

		if Txt and Txt:IsA("TextLabel") then
			Txt.Text = "BACK"
		end

		local Icon = v1:FindFirstChild("Icon")

		if Icon and Icon:IsA("ImageLabel") then
			Icon.Image = "rbxassetid://139585696788832"
			Icon.Position = Icon.Position - UDim2.fromScale(0, 0.06)
		end

		local Hitbox = v1:FindFirstChild("Hitbox")

		if not (Hitbox and Hitbox:IsA("ImageButton")) then
			v1.Parent = p1

			return
		end

		Hitbox.Active = true
		Hitbox.Interactable = true
		Hitbox.Selectable = true
		Hitbox.Activated:Connect(function() --[[ Line: 498 | Upvalues: t (ref) ]]
			t:_setSkillTreePage("Main")
		end)
		v1.Parent = p1
	end

	local function createSkillNode(p1, p2, p3) --[[ createSkillNode | Line: 506 | Upvalues: v31 (ref), v32 (ref), v27 (copy), v26 (copy), t2 (copy), configureNode (copy), v9 (copy), v22 (copy), v21 (copy), setNodeText (copy), t (copy) ]]
		local v1 = v31

		if not v1 then
			return
		end

		local Level = v1.Skills[p2].Level
		local v3 = if p3 <= Level then "Owned" elseif p3 == Level + 1 then if v1.Rebirths >= v1.SkillTree[p2][p3].RequiredRebirths then "Open" else "RebirthLocked" else "Locked"
		local v4 = if v32 == "EventMutation" then v27[p3] else v26[p2][p3]
		local v5 = t2[v3]:Clone()

		configureNode(v5, ("%*%*"):format(p2, v9[p3]), v4)

		if v3 == "Locked" then
			v5.ImageColor3 = v22
		elseif v3 ~= "Owned" then
			v5.ImageColor3 = v21
		end

		setNodeText(v5, p2, p3, v3)

		local Notif = v5:FindFirstChild("Notif")

		if Notif and Notif:IsA("GuiObject") then
			Notif.Visible = false
		end

		if v3 == "Locked" then
			for i, v in ipairs({ "Title", "Txt", "LockedOverlay" }) do
				local v6 = v5:FindFirstChild(v)

				if v6 and v6:IsA("GuiObject") then
					v6.Visible = false
				end
			end

			local Icon = v5:FindFirstChild("Icon")

			if Icon and Icon:IsA("ImageLabel") then
				Icon.Visible = false

				local LockedIcon = Icon:Clone()

				LockedIcon.Name = "LockedIcon"
				LockedIcon.Image = "rbxassetid://113074138024674"
				LockedIcon.ImageColor3 = Color3.new(255/255, 255/255, 255/255)
				LockedIcon.Visible = true
				LockedIcon.Parent = Icon.Parent
			end
		end

		v5.Parent = p1

		local Hitbox = v5:FindFirstChild("Hitbox")

		if not (Hitbox and Hitbox:IsA("ImageButton")) then
			return
		end

		local v7 = if v3 == "Open" then true else false

		Hitbox.Active = v7
		Hitbox.Interactable = v7
		Hitbox.Selectable = v7

		if not v7 then
			return
		end

		Hitbox.Activated:Connect(function() --[[ Line: 565 | Upvalues: t (ref), p2 (copy) ]]
			t:_buySkill(p2)
		end)
	end

	function t._renderSkillTree(p1) --[[ _renderSkillTree | Line: 572 | Upvalues: v35 (ref), v31 (ref), v36 (ref), v32 (ref), createSkillNode (copy), createEventMutationBack (copy), v40 (ref), createEventMutationNavigation (copy) ]]
		local v1 = v35
		local v2 = v31

		if not (v1 and v2) then
			return
		end

		for i, v in ipairs(v1:GetChildren()) do
			if v ~= v36 then
				v:Destroy()
			end
		end

		if v32 == "EventMutation" then
			for i = 1, math.min(#v2.SkillTree.EventMutation, v2.Skills.EventMutation.Level + 2) do
				createSkillNode(v1, "EventMutation", i)
			end

			createEventMutationBack(v1)

			if not v40 then
				return
			end

			v40.Visible = true
		else
			if v40 then
				v40.Visible = false
			end

			local function renderBranch(p1) --[[ renderBranch | Line: 599 | Upvalues: v2 (copy), createSkillNode (ref), v1 (copy) ]]
				for i = 1, math.min(#v2.SkillTree[p1], v2.Skills[p1].Level + 2) do
					createSkillNode(v1, p1, i)
				end
			end

			renderBranch("Luck")
			renderBranch("Speed")
			renderBranch("GoldMutation")

			if not (v2.Skills.GoldMutation.Level >= #v2.SkillTree.GoldMutation) then
				return
			end

			renderBranch("DiamondMutation")

			if not (v2.Skills.DiamondMutation.Level >= #v2.SkillTree.DiamondMutation) then
				return
			end

			renderBranch("RainbowMutation")

			if not (v2.Skills.RainbowMutation.Level >= #v2.SkillTree.RainbowMutation) then
				return
			end

			createEventMutationNavigation(v1)
		end
	end
	setCanvasOffset = function(p1) --[[ setCanvasOffset | Line: 619 | Upvalues: zero (ref), v35 (ref), Spr (copy) ]]
		zero = p1

		local v1 = v35

		if not v1 then
			return
		end

		Spr.target(v1, 0.85, 14, {
			Position = UDim2.new(0.5, p1.X, 0.5, p1.Y)
		})
	end

	local function centerCanvas() --[[ centerCanvas | Line: 629 | Upvalues: setCanvasOffset (copy) ]]
		setCanvasOffset(Vector2.zero)
	end

	local function setCanvasZoom(p1) --[[ setCanvasZoom | Line: 633 | Upvalues: v36 (ref), v38 (ref), Spr (copy) ]]
		local v1 = v36

		if v1 then
			v38 = math.clamp(p1, 0.6, 1.25)
			Spr.target(v1, 0.85, 12, {
				Scale = v38
			})
		end
	end

	local function setupPanning(p1) --[[ setupPanning | Line: 645 | Upvalues: v35 (ref), v43 (ref), v44 (ref), zero2 (ref), zero3 (ref), zero (ref), UserInputService (copy), v34 (ref), v38 (ref), v36 (ref), Spr (copy), setCanvasOffset (copy), v39 (ref) ]]
		p1.Active = true
		p1.InputBegan:Connect(function(p1) --[[ Line: 647 | Upvalues: v35 (ref), v43 (ref), v44 (ref), zero2 (ref), zero3 (ref), zero (ref) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			if v35 then
				v43 = true
				v44 = p1
				zero2 = Vector2.new(p1.Position.X, p1.Position.Y)
				zero3 = zero
			end
		end)
		UserInputService.InputChanged:Connect(function(p1) --[[ Line: 666 | Upvalues: v34 (ref), v38 (ref), v36 (ref), Spr (ref), v43 (ref), v44 (ref), setCanvasOffset (ref), zero3 (ref), zero2 (ref) ]]
			if p1.UserInputType == Enum.UserInputType.MouseWheel then
				local v1 = v34

				if not (v1 and v1.Enabled) then
					return
				end

				local v3 = v38 + math.sign(p1.Position.Z) * 0.1
				local v4 = v36

				if v4 then
					v38 = math.clamp(v3, 0.6, 1.25)
					Spr.target(v4, 0.85, 12, {
						Scale = v38
					})
				end
			else
				if not v43 then
					return
				end

				if p1.UserInputType ~= Enum.UserInputType.MouseMovement and p1 ~= v44 then
					return
				end

				setCanvasOffset(zero3 + (Vector2.new(p1.Position.X, p1.Position.Y) - zero2))
			end
		end)
		UserInputService.InputEnded:Connect(function(p1) --[[ Line: 688 | Upvalues: v44 (ref), v43 (ref) ]]
			if p1 ~= v44 and p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			v43 = false
			v44 = nil
		end)
		UserInputService.TouchPinch:Connect(function(p1, p2, p3, p4, p5) --[[ Line: 696 | Upvalues: v34 (ref), v39 (ref), v38 (ref), v43 (ref), v44 (ref), v36 (ref), Spr (ref) ]]
			local v1 = v34

			if not v1 or (not v1.Enabled or #p1 < 2) then
				return
			end

			if p4 == Enum.UserInputState.Begin then
				v39 = v38
				v43 = false
				v44 = nil

				return
			end

			if p4 ~= Enum.UserInputState.Change then
				return
			end

			local v3 = v36

			if not v3 then
				return
			end

			v38 = math.clamp(v39 * p2, 0.6, 1.25)
			Spr.target(v3, 0.85, 12, {
				Scale = v38
			})
		end)
	end

	local function isGamepadPreferred() --[[ isGamepadPreferred | Line: 719 | Upvalues: UserInputService (copy) ]]
		return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
	end

	local function getPreferredSkillTreeSelection() --[[ getPreferredSkillTreeSelection | Line: 723 | Upvalues: v35 (ref), v18 (copy), v37 (ref) ]]
		local v1 = v35
		local v2 = nil
		local v3 = (1 / 0)

		if v1 then
			for i, v in ipairs(v1:GetChildren()) do
				if v:IsA("GuiObject") then
					local Hitbox = v:FindFirstChild("Hitbox")

					if Hitbox and (Hitbox:IsA("GuiButton") and (Hitbox.Selectable and Hitbox.Interactable)) then
						local Magnitude = (Vector2.new(v.Position.X.Offset, v.Position.Y.Offset) - v18).Magnitude

						if Magnitude < v3 then
							v3 = Magnitude
							v2 = Hitbox
						end
					end
				end
			end
		end

		return if v2 then v2 else v37
	end

	focusSkillTreeSelection = function() --[[ focusSkillTreeSelection | Line: 752 | Upvalues: v34 (ref), UserInputService (copy), GuiService (copy), getPreferredSkillTreeSelection (copy) ]]
		local v1 = v34

		if not (v1 and v1.Enabled) then
			return
		end

		if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
			GuiService.SelectedObject = getPreferredSkillTreeSelection()
		end
	end

	local function centerSelectedSkillNode() --[[ centerSelectedSkillNode | Line: 760 | Upvalues: v34 (ref), v35 (ref), GuiService (copy), setCanvasOffset (copy), v18 (copy) ]]
		local v1 = v34
		local v2 = v35
		local SelectedObject = GuiService.SelectedObject

		if not (v1 and (v1.Enabled and (v2 and (SelectedObject and SelectedObject:IsDescendantOf(v2))))) then
			return
		end

		local v3 = SelectedObject

		while v3.Parent and v3.Parent ~= v2 do
			v3 = v3.Parent
		end

		if v3.Parent == v2 and v3:IsA("GuiObject") then
			setCanvasOffset(v18 - Vector2.new(v3.Position.X.Offset, v3.Position.Y.Offset))
		end
	end

	local function getNodeAnimationScale(p1) --[[ getNodeAnimationScale | Line: 786 ]]
		local RNGMachinePopScale = p1:FindFirstChild("RNGMachinePopScale")

		if RNGMachinePopScale and RNGMachinePopScale:IsA("UIScale") then
			return RNGMachinePopScale
		end

		local RNGMachinePopScale2 = Instance.new("UIScale")

		RNGMachinePopScale2.Name = "RNGMachinePopScale"
		RNGMachinePopScale2.Parent = p1

		return RNGMachinePopScale2
	end

	local function prepareNodeAnimation(p1) --[[ prepareNodeAnimation | Line: 798 ]]
		local RNGMachinePopScale = p1:FindFirstChild("RNGMachinePopScale")
		local v1

		if RNGMachinePopScale and RNGMachinePopScale:IsA("UIScale") then
			v1 = RNGMachinePopScale
		else
			local RNGMachinePopScale2 = Instance.new("UIScale")

			RNGMachinePopScale2.Name = "RNGMachinePopScale"
			RNGMachinePopScale2.Parent = p1
			v1 = RNGMachinePopScale2
		end

		v1.Scale = 0
		p1.Visible = false
	end

	local function animateNode(p1) --[[ animateNode | Line: 803 | Upvalues: TweenService (copy) ]]
		local RNGMachinePopScale = p1:FindFirstChild("RNGMachinePopScale")
		local v1

		if RNGMachinePopScale and RNGMachinePopScale:IsA("UIScale") then
			v1 = RNGMachinePopScale
		else
			local RNGMachinePopScale2 = Instance.new("UIScale")

			RNGMachinePopScale2.Name = "RNGMachinePopScale"
			RNGMachinePopScale2.Parent = p1
			v1 = RNGMachinePopScale2
		end

		p1.Visible = true
		TweenService:Create(v1, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Scale = 1
		}):Play()
	end

	local function animateNodes(p1) --[[ animateNodes | Line: 813 | Upvalues: v35 (ref), v18 (copy), v42 (ref), animateNode (copy) ]]
		local v1 = v35

		if not v1 then
			return
		end

		local list = {}

		for i, v in ipairs(v1:GetChildren()) do
			local v2

			if v:IsA("GuiObject") then
				local RNGMachinePopScale = v:FindFirstChild("RNGMachinePopScale")

				if RNGMachinePopScale and RNGMachinePopScale:IsA("UIScale") then
					v2 = RNGMachinePopScale
				else
					local RNGMachinePopScale2 = Instance.new("UIScale")

					RNGMachinePopScale2.Name = "RNGMachinePopScale"
					RNGMachinePopScale2.Parent = v
					v2 = RNGMachinePopScale2
				end

				v2.Scale = 0
				v.Visible = false
				table.insert(list, v)
			end
		end

		table.sort(list, function(p1, p2) --[[ Line: 826 | Upvalues: v18 (ref) ]]
			local v1 = Vector2.new(p1.Position.X.Offset, p1.Position.Y.Offset)

			return (v1 - v18).Magnitude < (Vector2.new(p2.Position.X.Offset, p2.Position.Y.Offset) - v18).Magnitude
		end)

		for i, v in ipairs(list) do
			task.delay((i - 1) * 0.03, function() --[[ Line: 833 | Upvalues: p1 (copy), v42 (ref), v (copy), animateNode (ref) ]]
				if p1 == v42 and v.Parent then
					animateNode(v)
				end
			end)
		end
	end

	animateNewlyRevealedNodes = function(p1, p2) --[[ animateNewlyRevealedNodes | Line: 842 | Upvalues: v35 (ref), animateNode (copy), v9 (copy) ]]
		local v1 = v35

		if not v1 then
			return
		end

		local function animateNamedNode(p1, p2) --[[ animateNamedNode | Line: 848 | Upvalues: v1 (copy), animateNode (ref) ]]
			local v12 = v1:FindFirstChild(p1)

			if not (v12 and v12:IsA("GuiObject")) then
				return
			end

			local RNGMachinePopScale = v12:FindFirstChild("RNGMachinePopScale")
			local v2

			if RNGMachinePopScale and RNGMachinePopScale:IsA("UIScale") then
				v2 = RNGMachinePopScale
			else
				local RNGMachinePopScale2 = Instance.new("UIScale")

				RNGMachinePopScale2.Name = "RNGMachinePopScale"
				RNGMachinePopScale2.Parent = v12
				v2 = RNGMachinePopScale2
			end

			v2.Scale = 1
			v12.Visible = true
		end

		local function animateBranch(p12) --[[ animateBranch | Line: 862 | Upvalues: p1 (copy), p2 (copy), animateNamedNode (copy), v9 (ref) ]]
			local Level2 = p2.Skills[p12].Level

			if Level2 <= p1.Skills[p12].Level then
				return
			end

			local v1 = Level2 + 2

			if p2.SkillTree[p12][v1] then
				animateNamedNode(("%*%*"):format(p12, v9[v1]), 0)
			end
		end

		local function completedBranch(p12) --[[ completedBranch | Line: 877 | Upvalues: p2 (copy), p1 (copy) ]]
			local v1 = #p2.SkillTree[p12]

			return if p1.Skills[p12].Level < v1 then v1 <= p2.Skills[p12].Level else false
		end

		local function animateVisibleBranch(p1) --[[ animateVisibleBranch | Line: 883 | Upvalues: p2 (copy), animateNamedNode (copy), v9 (ref) ]]
			for i = 1, math.min(#p2.SkillTree[p1], p2.Skills[p1].Level + 2) do
				animateNamedNode(("%*%*"):format(p1, v9[i]), (i - 1) * 0.03)
			end
		end

		local Level2 = p2.Skills.Luck.Level

		if not (Level2 <= p1.Skills.Luck.Level) then
			local v2 = Level2 + 2

			if p2.SkillTree.Luck[v2] then
				animateNamedNode(("Luck%*"):format(v9[v2]), 0)
			end
		end

		local Level4 = p2.Skills.Speed.Level

		if not (Level4 <= p1.Skills.Speed.Level) then
			local v3 = Level4 + 2

			if p2.SkillTree.Speed[v3] then
				animateNamedNode(("Speed%*"):format(v9[v3]), 0)
			end
		end

		local Level6 = p2.Skills.GoldMutation.Level

		if not (Level6 <= p1.Skills.GoldMutation.Level) then
			local v4 = Level6 + 2

			if p2.SkillTree.GoldMutation[v4] then
				animateNamedNode(("GoldMutation%*"):format(v9[v4]), 0)
			end
		end

		local Level8 = p2.Skills.DiamondMutation.Level

		if not (Level8 <= p1.Skills.DiamondMutation.Level) then
			local v5 = Level8 + 2

			if p2.SkillTree.DiamondMutation[v5] then
				animateNamedNode(("DiamondMutation%*"):format(v9[v5]), 0)
			end
		end

		local Level10 = p2.Skills.RainbowMutation.Level

		if not (Level10 <= p1.Skills.RainbowMutation.Level) then
			local v6 = Level10 + 2

			if p2.SkillTree.RainbowMutation[v6] then
				animateNamedNode(("RainbowMutation%*"):format(v9[v6]), 0)
			end
		end

		local Level12 = p2.Skills.EventMutation.Level

		if not (Level12 <= p1.Skills.EventMutation.Level) then
			local v7 = Level12 + 2

			if p2.SkillTree.EventMutation[v7] then
				animateNamedNode(("EventMutation%*"):format(v9[v7]), 0)
			end
		end

		local v8 = #p2.SkillTree.GoldMutation

		if if p1.Skills.GoldMutation.Level < v8 then if v8 <= p2.Skills.GoldMutation.Level then true else false else false then
			animateVisibleBranch("DiamondMutation")
		end

		local v10 = #p2.SkillTree.DiamondMutation

		if if p1.Skills.DiamondMutation.Level < v10 then if v10 <= p2.Skills.DiamondMutation.Level then true else false else false then
			animateVisibleBranch("RainbowMutation")
		end

		local v12 = #p2.SkillTree.RainbowMutation

		if not (if p1.Skills.RainbowMutation.Level < v12 then v12 <= p2.Skills.RainbowMutation.Level else false) then
			return
		end

		animateNamedNode("EventMutationTree", 0)
	end

	local function playOpenAnimation() --[[ playOpenAnimation | Line: 907 | Upvalues: v34 (ref), TweenService (copy) ]]
		local v1 = v34

		if not v1 then
			return
		end

		local DarkBG = v1:FindFirstChild("DarkBG")

		if not (DarkBG and DarkBG:IsA("GuiObject")) then
			return
		end

		DarkBG.BackgroundTransparency = 1
		TweenService:Create(DarkBG, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.25
		}):Play()
	end

	local function updateSkillTreePageChrome() --[[ updateSkillTreePageChrome | Line: 924 | Upvalues: v34 (ref), v40 (ref), v32 (ref) ]]
		local v1 = v34

		if not v1 then
			return
		end

		local Close = v1:FindFirstChild("Close")
		local v2 = if Close then Close:FindFirstChild("Txt") else Close

		if v2 and v2:IsA("TextLabel") then
			v2.Text = "CLOSE"
		end

		if not v40 then
			return
		end

		v40.Visible = v32 == "EventMutation"
	end

	function t._setSkillTreePage(p1, p2) --[[ _setSkillTreePage | Line: 940 | Upvalues: v32 (ref), v42 (ref), v34 (ref), v40 (ref), setCanvasOffset (copy), animateNodes (copy), focusSkillTreeSelection (copy) ]]
		v32 = p2
		v42 = v42 + 1

		local v2 = v34

		if v2 then
			local Close = v2:FindFirstChild("Close")
			local v3 = if Close then Close:FindFirstChild("Txt") else Close

			if v3 and v3:IsA("TextLabel") then
				v3.Text = "CLOSE"
			end

			if v40 then
				v40.Visible = p2 == "EventMutation"
			end
		end

		p1:_renderSkillTree()
		setCanvasOffset(Vector2.zero)
		animateNodes(v42)
		focusSkillTreeSelection()
	end
	function t._openSkillTree(p1) --[[ _openSkillTree | Line: 951 | Upvalues: v34 (ref), v32 (ref), v42 (ref), v40 (ref), setCanvasOffset (copy), animateNodes (copy), playOpenAnimation (copy), focusSkillTreeSelection (copy) ]]
		local v1 = v34

		if not v1 then
			return
		end

		v32 = "Main"
		v42 = v42 + 1

		local v3 = v34

		if v3 then
			local Close = v3:FindFirstChild("Close")
			local v4 = if Close then Close:FindFirstChild("Txt") else Close

			if v4 and v4:IsA("TextLabel") then
				v4.Text = "CLOSE"
			end

			if v40 then
				v40.Visible = v32 == "EventMutation"
			end
		end

		p1:_renderSkillTree()
		setCanvasOffset(Vector2.zero)
		animateNodes(v42)
		v1.Enabled = true
		playOpenAnimation()
		focusSkillTreeSelection()
	end
	function t._setupSkillTree(p1) --[[ _setupSkillTree | Line: 969 | Upvalues: PlayerGui (copy), v34 (ref), v37 (ref), BackpackController (copy), focusSkillTreeSelection (copy), GuiService (copy), t2 (copy), getTemplate (copy), v19 (copy), v17 (copy), v35 (ref), v38 (ref), v36 (ref), setupPanning (copy), UserInputService (copy), v40 (ref), v42 (ref), centerSelectedSkillNode (copy), getPreferredSkillTreeSelection (copy), v32 (ref), setCanvasOffset (copy) ]]
		-- The ClientLoader copies ReplicatedGui into PlayerGui at runtime. Wait for the
		-- SkillTree GUI to appear so setup does not race ahead of the copy.
		local SkillTree = PlayerGui:FindFirstChild("SkillTree")
		local waited = 0
		while not SkillTree and waited < 5 do
			task.wait(0.1)
			waited += 0.1
			SkillTree = PlayerGui:FindFirstChild("SkillTree")
		end
		local v1 = if SkillTree then SkillTree:FindFirstChild("Frame") else SkillTree
		local v2 = if SkillTree then SkillTree:FindFirstChild("Close") else SkillTree

		if not (SkillTree and (SkillTree:IsA("ScreenGui") and (v1 and (v1:IsA("Frame") and (v2 and v2:IsA("ImageButton")))))) then
			warn("RNG Machine skill tree interface is incomplete")

			return
		end

		v34 = SkillTree
		v37 = v2
		v2.Selectable = true
		SkillTree:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 988 | Upvalues: BackpackController (ref), SkillTree (copy), focusSkillTreeSelection (ref), GuiService (ref) ]]
			BackpackController:SetEnabled("RNGMachineSkillTree", not SkillTree.Enabled)

			if SkillTree.Enabled then
				focusSkillTreeSelection()

				return
			end

			if not (GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(SkillTree)) then
				return
			end

			GuiService.SelectedObject = nil
		end)
		t2.Open = getTemplate(v1, "OpenTemplate"):Clone()
		t2.Owned = getTemplate(v1, "OwnedTemplate"):Clone()
		t2.Locked = getTemplate(v1, "LockedTemplate"):Clone()
		t2.RebirthLocked = getTemplate(v1, "RebirthLockedTemplate"):Clone()

		for k, v in pairs(t2) do
			v.Parent = nil
		end

		for i, v in ipairs(v1:GetChildren()) do
			if v:IsA("GuiButton") then
				v.Visible = false
			end
		end

		v1.Active = true
		v1.ClipsDescendants = true
		v1.SelectionGroup = true

		local RNGMachineSkills = Instance.new("Frame")

		RNGMachineSkills.Name = "RNGMachineSkills"
		RNGMachineSkills.AnchorPoint = v19
		RNGMachineSkills.BackgroundTransparency = 1
		RNGMachineSkills.ClipsDescendants = false
		RNGMachineSkills.Position = UDim2.fromScale(0.5, 0.5)
		RNGMachineSkills.Size = UDim2.fromOffset(v17.X, v17.Y)
		RNGMachineSkills.Parent = v1
		v35 = RNGMachineSkills

		local RNGMachineZoom = Instance.new("UIScale")

		RNGMachineZoom.Name = "RNGMachineZoom"
		RNGMachineZoom.Scale = v38
		RNGMachineZoom.Parent = RNGMachineSkills
		v36 = RNGMachineZoom
		setupPanning(v1)

		local PanHint = Instance.new("TextLabel")

		PanHint.Name = "PanHint"
		PanHint.AnchorPoint = Vector2.new(0.5, 0)
		PanHint.BackgroundTransparency = 1
		PanHint.Font = Enum.Font.GothamBold
		PanHint.Position = UDim2.fromScale(0.5, 0.015)
		PanHint.Size = UDim2.fromScale(0.35, 0.055)

		local v3 = if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then true else false

		PanHint.Text = if v3 then "USE D-PAD TO MOVE" else "DRAG TO MOVE"
		PanHint.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		PanHint.TextScaled = true
		PanHint.TextStrokeTransparency = 0
		PanHint.ZIndex = 20
		PanHint.Parent = v1

		local EventMutationNotice = Instance.new("TextLabel")

		EventMutationNotice.Name = "EventMutationNotice"
		EventMutationNotice.AnchorPoint = Vector2.new(0.5, 1)
		EventMutationNotice.BackgroundTransparency = 1
		EventMutationNotice.Font = Enum.Font.GothamBold
		EventMutationNotice.Position = UDim2.new(v2.Position.X.Scale, v2.Position.X.Offset, v2.Position.Y.Scale - v2.Size.Y.Scale * 0.5 - 0.008, v2.Position.Y.Offset - v2.Size.Y.Offset * 0.5)
		EventMutationNotice.Size = UDim2.fromScale(0.35, 0.025)
		EventMutationNotice.Text = "ONLY ACTIVE WHILE A MUTATION EVENT IS RUNNING"
		EventMutationNotice.TextColor3 = Color3.fromRGB(255, 127, 0)
		EventMutationNotice.TextScaled = true
		EventMutationNotice.TextStrokeTransparency = 0
		EventMutationNotice.TextWrapped = true
		EventMutationNotice.Visible = false
		EventMutationNotice.ZIndex = 20
		EventMutationNotice.Parent = v1
		v40 = EventMutationNotice

		local function closeSkillTree() --[[ closeSkillTree | Line: 1068 | Upvalues: v42 (ref), SkillTree (copy) ]]
			v42 = v42 + 1
			SkillTree.Enabled = false
		end

		v2.Activated:Connect(closeSkillTree)
		GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(centerSelectedSkillNode)
		UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 1074 | Upvalues: PanHint (copy), UserInputService (ref), v34 (ref), GuiService (ref), getPreferredSkillTreeSelection (ref) ]]
			PanHint.Text = if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then "USE D-PAD TO MOVE" else "DRAG TO MOVE"

			local v3 = v34

			if not (v3 and v3.Enabled) then
				return
			end

			if UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad then
				return
			end

			GuiService.SelectedObject = getPreferredSkillTreeSelection()
		end)
		UserInputService.InputBegan:Connect(function(p1) --[[ Line: 1078 | Upvalues: SkillTree (copy), v42 (ref) ]]
			if not SkillTree.Enabled or p1.KeyCode ~= Enum.KeyCode.ButtonB then
				return
			end

			v42 = v42 + 1
			SkillTree.Enabled = false
		end)
		SkillTree.Enabled = false
		BackpackController:SetEnabled("RNGMachineSkillTree", true)

		local v5 = v34

		if v5 then
			local Close = v5:FindFirstChild("Close")
			local v6 = if Close then Close:FindFirstChild("Txt") else Close

			if v6 and v6:IsA("TextLabel") then
				v6.Text = "CLOSE"
			end

			if EventMutationNotice then
				EventMutationNotice.Visible = v32 == "EventMutation"
			end
		end

		p1:_renderSkillTree()
		setCanvasOffset(Vector2.zero)
	end

	local function getTaggedPrompt(p1) --[[ getTaggedPrompt | Line: 1093 | Upvalues: CollectionService (copy) ]]
		for i, v in ipairs(CollectionService:GetTagged(p1)) do
			if v:IsA("ProximityPrompt") and v:IsDescendantOf(game) then
				return v
			end
		end

		return nil
	end

	function t._reconcilePrompts(p1, p2) --[[ _reconcilePrompts | Line: 1102 | Upvalues: getTaggedPrompt (copy), NumberUtils (copy) ]]
		local v1 = getTaggedPrompt("RNGMachineSpinPrompt")
		local v2 = getTaggedPrompt("RNGMachineSkillTreePrompt")
		local v3 = if p2 == nil then false else p2.Enabled
		local v4 = if p2 then p2.State else "Idle"
		local v6 = if v4 == "Offer" then typeof(if p2 then p2.Offer else nil) == "table" else false

		if v1 then
			v1.Enabled = if v3 then v4 ~= "Spinning" else v3
			v1.UIOffset = Vector2.new(0, 36)

			local v8 = if v6 then "Spin Again" else "Spin"

			v1.ActionText = if p2 then ("%* ($%*)"):format(v8, (NumberUtils:ToString(p2.SpinCost))) else v8
		end

		if not v2 then
			return
		end

		v2.Enabled = v3
		v2.UIOffset = Vector2.new(0, -36)
		v2.ActionText = "Upgrades"
	end

	local function deferPromptReconcile() --[[ deferPromptReconcile | Line: 1123 | Upvalues: v33 (ref), t (copy), v31 (ref) ]]
		if not v33 then
			v33 = true
			task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
				v33 = false
				t:_reconcilePrompts(v31)
			end)
		end
	end

	observeSkillTreePrompt = function(p1) --[[ observeSkillTreePrompt | Line: 1135 | Upvalues: v33 (ref), t (copy), v31 (ref) ]]
		if not p1:IsA("ProximityPrompt") then
			return nil
		end

		p1.Enabled = false
		p1.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton

		local v1

		if v33 then
			v1 = p1.Triggered:Connect(function() --[[ Line: 1143 | Upvalues: t (ref) ]]
				t:_openSkillTree()
			end)

			return function() --[[ Line: 1146 | Upvalues: v1 (copy), v33 (ref), t (ref), v31 (ref) ]]
				v1:Disconnect()

				if not v33 then
					v33 = true
					task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
						v33 = false
						t:_reconcilePrompts(v31)
					end)
				end
			end
		end

		v33 = true
		task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
			v33 = false
			t:_reconcilePrompts(v31)
		end)
		v1 = p1.Triggered:Connect(function() --[[ Line: 1143 | Upvalues: t (ref) ]]
			t:_openSkillTree()
		end)

		return function() --[[ Line: 1146 | Upvalues: v1 (copy), v33 (ref), t (ref), v31 (ref) ]]
			v1:Disconnect()

			if not v33 then
				v33 = true
				task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
					v33 = false
					t:_reconcilePrompts(v31)
				end)
			end
		end
	end
	observeSpinPrompt = function(p1) --[[ observeSpinPrompt | Line: 1152 | Upvalues: v33 (ref), t (copy), v31 (ref), LocalPlayer (copy), t3 (copy), v46 (ref) ]]
		if not p1:IsA("ProximityPrompt") then
			return nil
		end

		p1.Enabled = false
		p1.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton

		local v1

		if v33 then
			v1 = p1.Triggered:Connect(function(p13) --[[ Line: 1160 | Upvalues: LocalPlayer (ref), t3 (ref), v46 (ref), t (ref), v31 (ref) ]]
				if p13 == LocalPlayer then
					local v1 = t3

					v1.OptimisticSpinToken = v1.OptimisticSpinToken + 1

					local OptimisticSpinToken = t3.OptimisticSpinToken

					v46 = true
					t3.PrivateStagePayload = nil
					t:_reconcileActivityDisplay()
					task.delay(1, function() --[[ Line: 1169 | Upvalues: OptimisticSpinToken (copy), t3 (ref), v31 (ref), v46 (ref), t (ref) ]]
						if OptimisticSpinToken ~= t3.OptimisticSpinToken or v31 and v31.State == "Spinning" or t3.PrivateStagePayload then
							return
						end

						v46 = false
						t:_reconcileActivityDisplay()
					end)
				end
			end)

			return function() --[[ Line: 1180 | Upvalues: v1 (copy), v33 (ref), t (ref), v31 (ref) ]]
				v1:Disconnect()

				if not v33 then
					v33 = true
					task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
						v33 = false
						t:_reconcilePrompts(v31)
					end)
				end
			end
		end

		v33 = true
		task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
			v33 = false
			t:_reconcilePrompts(v31)
		end)
		v1 = p1.Triggered:Connect(function(p13) --[[ Line: 1160 | Upvalues: LocalPlayer (ref), t3 (ref), v46 (ref), t (ref), v31 (ref) ]]
			if p13 == LocalPlayer then
				local v1 = t3

				v1.OptimisticSpinToken = v1.OptimisticSpinToken + 1

				local OptimisticSpinToken = t3.OptimisticSpinToken

				v46 = true
				t3.PrivateStagePayload = nil
				t:_reconcileActivityDisplay()
				task.delay(1, function() --[[ Line: 1169 | Upvalues: OptimisticSpinToken (copy), t3 (ref), v31 (ref), v46 (ref), t (ref) ]]
					if OptimisticSpinToken ~= t3.OptimisticSpinToken or v31 and v31.State == "Spinning" or t3.PrivateStagePayload then
						return
					end

					v46 = false
					t:_reconcileActivityDisplay()
				end)
			end
		end)

		return function() --[[ Line: 1180 | Upvalues: v1 (copy), v33 (ref), t (ref), v31 (ref) ]]
			v1:Disconnect()

			if not v33 then
				v33 = true
				task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
					v33 = false
					t:_reconcilePrompts(v31)
				end)
			end
		end
	end

	local function clearActiveSpinAnimation() --[[ clearActiveSpinAnimation | Line: 1188 | Upvalues: t3 (copy) ]]
		if t3.ActiveConnection then
			t3.ActiveConnection:Disconnect()
			t3.ActiveConnection = nil
		end

		if t3.ActiveTween then
			t3.ActiveTween:Cancel()
			t3.ActiveTween = nil
		end

		if not t3.ActiveSpinner then
			return
		end

		t3.ActiveSpinner:Destroy()
		t3.ActiveSpinner = nil
	end

	clearDisplay = function() --[[ clearDisplay | Line: 1203 | Upvalues: v45 (ref), t3 (copy), v48 (ref), v49 (ref), v50 (ref), v51 (ref), v47 (ref), t4 (copy) ]]
		v45 = v45 + 1

		if t3.ActiveConnection then
			t3.ActiveConnection:Disconnect()
			t3.ActiveConnection = nil
		end

		if t3.ActiveTween then
			t3.ActiveTween:Cancel()
			t3.ActiveTween = nil
		end

		if t3.ActiveSpinner then
			t3.ActiveSpinner:Destroy()
			t3.ActiveSpinner = nil
		end

		t3.SelectedIdentity = nil
		t3.SelectedOwnerUserId = nil
		t3.SelectedState = nil
		t3.StageVisualEndsAt = 0

		if v48 then
			v48:Destroy()
			v48 = nil
		end

		v49 = nil
		v50 = nil
		v51 = nil

		if not v47 then
			table.clear(t4)

			return
		end

		v47:Destroy()
		v47 = nil
		table.clear(t4)
	end
	prepareStageDisplay = function() --[[ prepareStageDisplay | Line: 1224 | Upvalues: v45 (ref), t3 (copy), v48 (ref), v49 (ref), v50 (ref), v51 (ref), t4 (copy) ]]
		v45 = v45 + 1

		if t3.ActiveConnection then
			t3.ActiveConnection:Disconnect()
			t3.ActiveConnection = nil
		end

		if t3.ActiveTween then
			t3.ActiveTween:Cancel()
			t3.ActiveTween = nil
		end

		if t3.ActiveSpinner then
			t3.ActiveSpinner:Destroy()
			t3.ActiveSpinner = nil
		end

		if v48 then
			v48:Destroy()
			v48 = nil
		end

		v49 = nil
		v50 = nil
		v51 = nil

		for k, v in pairs(t4) do
			if v.Parent then
				v:PivotTo(CFrame.new(0, 100000, 100000))
			end
		end
	end
	observeDisplayCenter = function(p1) --[[ observeDisplayCenter | Line: 1241 | Upvalues: v30 (ref), t (copy), clearDisplay (copy) ]]
		if p1:IsA("BasePart") then
			v30 = p1
			task.defer(function() --[[ Line: 1247 | Upvalues: t (ref) ]]
				t:_reconcileActivityDisplay()
			end)

			return function() --[[ Line: 1250 | Upvalues: v30 (ref), p1 (copy), clearDisplay (ref) ]]
				if v30 ~= p1 then
					return
				end

				v30 = nil
				clearDisplay()
			end
		end

		return nil
	end

	local function observeVfxPart(p1, p2) --[[ observeVfxPart | Line: 1260 | Upvalues: t10 (copy) ]]
		if p2:IsA("BasePart") then
			p1[p2] = true
			t10[p2] = p2.Color

			return function() --[[ Line: 1267 | Upvalues: p1 (copy), p2 (copy), t10 (ref) ]]
				p1[p2] = nil
				t10[p2] = nil
			end
		end

		return nil
	end

	local function createVfxObserver(p1) --[[ createVfxObserver | Line: 1273 | Upvalues: t10 (copy) ]]
		return function(p12) --[[ Line: 1274 | Upvalues: p1 (copy), t10 (ref) ]]
			local v1 = p1

			if p12:IsA("BasePart") then
				v1[p12] = true
				t10[p12] = p12.Color

				return function() --[[ Line: 1267 | Upvalues: v1 (copy), p12 (copy), t10 (ref) ]]
					v1[p12] = nil
					t10[p12] = nil
				end
			end

			return nil
		end
	end

	v56 = createVfxObserver(t5)
	v57 = createVfxObserver(t6)
	v58 = createVfxObserver(t7)
	v59 = createVfxObserver(t8)
	v60 = createVfxObserver(t9)
	observeLeverRoot = function(p1) --[[ observeLeverRoot | Line: 1285 | Upvalues: v55 (ref) ]]
		if p1:IsA("BasePart") then
			v55 = p1

			return function() --[[ Line: 1291 | Upvalues: v55 (ref), p1 (copy) ]]
				if v55 ~= p1 then
					return
				end

				v55 = nil
			end
		end

		return nil
	end

	local function getDisplayCenter() --[[ getDisplayCenter | Line: 1300 | Upvalues: v30 (ref) ]]
		local v1 = v30

		if v1 and v1:IsDescendantOf(workspace) then
			return v1:GetPivot()
		end

		return nil
	end

	local function prepareModel(p1, p2) --[[ prepareModel | Line: 1309 ]]
		local PrimaryPart = p1.PrimaryPart

		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Anchored = false
				v.CanCollide = false
				v.CanQuery = false
				v.CanTouch = false
				v.Massless = true

				if not PrimaryPart then
					p1.PrimaryPart = v
					PrimaryPart = v
				end

				continue
			end

			if v:IsA("LuaSourceContainer") then
				v:Destroy()
			end
		end

		if PrimaryPart then
			PrimaryPart.Anchored = true
		end

		if p2 then
			local _, v1 = p1:GetBoundingBox()
			local v2 = math.max(v1.X, v1.Y, v1.Z)

			if v2 > 0 then
				p1:ScaleTo(p1:GetScale() * (p2 / v2))
			end
		end

		p1:SetAttribute("DefaultScale", p1:GetScale())
	end

	local function destroySpinParticleEmitters(p1) --[[ destroySpinParticleEmitters | Line: 1340 ]]
		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Destroy()
			end
		end
	end

	local function destroySpinTrails(p1) --[[ destroySpinTrails | Line: 1348 ]]
		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("Trail") then
				v:Destroy()
			end
		end
	end

	local function playIdleAnimation(p1, p2) --[[ playIdleAnimation | Line: 1356 | Upvalues: Animals3 (copy) ]]
		local v1 = Animals3:FindFirstChild(p2)
		local v2 = if v1 then v1:FindFirstChild("RoadBrainrotIdle") or v1:FindFirstChild("Idle") else v1

		if not (v2 and v2:IsA("Animation")) then
			return
		end

		local v3 = p1:FindFirstChildOfClass("AnimationController") or p1:FindFirstChildOfClass("Humanoid")
		local v4

		if v3 then
			v4 = v3
		else
			local AnimationController = Instance.new("AnimationController")

			AnimationController.Parent = p1
			v4 = AnimationController
		end

		local Animator = v4:FindFirstChildOfClass("Animator")
		local v5

		if Animator then
			v5 = Animator
		else
			local Animator2 = Instance.new("Animator")

			Animator2.Parent = v4
			v5 = Animator2
		end

		local v6 = v5:LoadAnimation(v2)

		v6.Priority = Enum.AnimationPriority.Idle
		v6.Looped = true
		v6:Play(0.1)
		v6:AdjustSpeed(v2:GetAttribute("Speed") or 1)
	end

	local function setLuckSelectionEffects(model, enabled)
		for _, descendant in ipairs(model:GetDescendants()) do
			if descendant:IsA("Highlight") or descendant:IsA("PointLight") then
				descendant.Enabled = enabled
			end
		end
	end

	local function createDisplay(p1, p2) --[[ createDisplay | Line: 1392 | Upvalues: ReplicatedStorage (copy), prepareModel (copy) ]]
		if p1.Type == "Luck" then
			local LuckIcons = ReplicatedStorage:FindFirstChild("LuckIcons")
			local v2 = if LuckIcons then LuckIcons:FindFirstChild((string.gsub(p1.Name, "x$", ""))) else nil
			if not v2 then
				local models = ReplicatedStorage:FindFirstChild("Models")
				local luckModels = models and models:FindFirstChild("Luck")
				v2 = luckModels and luckModels:FindFirstChild(p1.Name)
			end

			if v2 and v2:IsA("Model") then
				local v3 = v2:Clone()

				v3.Name = p1.Name
				prepareModel(v3)
				for _, descendant in ipairs(v3:GetDescendants()) do
					if descendant:IsA("BasePart") then
						descendant.Anchored = true
					end
				end
				setLuckSelectionEffects(v3, false)

				return v3
			end

			return nil
		end

		if p2 and p2:IsA("Model") then
			local v4 = p2:Clone()

			v4.Name = p1.Name
			prepareModel(v4)
			v4:SetAttribute("PlayIdleAnimation", true)

			return v4
		end

		return nil
	end

	local function getDisplayCacheKey(p1, p2) --[[ getDisplayCacheKey | Line: 1418 ]]
		return ("%*:%*:%*"):format(p1.Type, p1.Name, p2 or "Normal")
	end

	local function getStagePlaybackSpeed(p1) --[[ getStagePlaybackSpeed | Line: 1422 ]]
		return math.min((p1 - 1) * 0.08 + 1, 1.4)
	end

	local function getSpinVolumeMultiplier(p1) --[[ getSpinVolumeMultiplier | Line: 1426 ]]
		if p1 <= 1 then
			return 1
		end

		return math.min((p1 - 2) * 0.12 + 1.12, 1.8)
	end

	local function getLuckLandedVolumeMultiplier(p1) --[[ getLuckLandedVolumeMultiplier | Line: 1436 ]]
		return math.min((p1 - 1) * 0.12 + 1.2, 1.8)
	end

	local function playRNGSound(p1, p2, p3) --[[ playRNGSound | Line: 1443 | Upvalues: v7 (copy), SoundController (copy) ]]
		local v1 = v7:FindFirstChild(p1)

		if not (v1 and v1:IsA("Sound")) then
			return nil
		end

		local v2 = p3 or 1
		local v3 = SoundController:PlaySound(v1, p2, false)

		if v3 then
			v3.PlaybackSpeed = v2
		end

		return v3
	end

	local function playSpinTick(p1) --[[ playSpinTick | Line: 1456 | Upvalues: v7 (copy), v30 (ref) ]]
		local v2 = v7:FindFirstChild(if p1.Stage == 1 then "RegularSpin" else "LuckySpin")
		local v3 = v30

		if not (v2 and (v2:IsA("Sound") and v3)) then
			return
		end

		local v4 = v2:Clone()
		local v5 = v4:GetAttribute("SoundId")

		if typeof(v5) == "string" then
			v4:SetAttribute("SoundId", nil)
			v4.SoundId = v5
		end

		v4.Looped = false
		v4.PlaybackSpeed = math.min((p1.Stage - 1) * 0.08 + 1, 1.4)

		local Stage = p1.Stage

		v4.Volume = v4.Volume * (if Stage <= 1 then 1 else math.min((Stage - 2) * 0.12 + 1.12, 1.8))
		v4.Parent = v3
		v4.Ended:Once(function() --[[ Line: 1474 | Upvalues: v4 (copy) ]]
			task.delay(0.1, function() --[[ Line: 1475 | Upvalues: v4 (ref) ]]
				if not v4.Parent then
					return
				end

				v4:Destroy()
			end)
		end)
		v4:Play()
	end

	local function createLandedOverhead(p1, p2, p3, p4) --[[ createLandedOverhead | Line: 1484 | Upvalues: Animals2 (copy), FastOverheadController (copy), AnimalOverheadController (copy), LocalPlayer (copy), NumberUtils (copy), Animals (copy) ]]
		local v1 = Animals2[p2]
		local PrimaryPart = p1.PrimaryPart

		if not v1 or (v1.HideOverhead or not PrimaryPart) then
			return nil
		end

		local OVERHEAD_ATTACHMENT = p1:FindFirstChild("OVERHEAD_ATTACHMENT", true)
		local v2

		if OVERHEAD_ATTACHMENT and OVERHEAD_ATTACHMENT:IsA("Attachment") then
			v2 = OVERHEAD_ATTACHMENT
		else
			local RNGMachineOverhead = Instance.new("Attachment")

			RNGMachineOverhead.Name = "RNGMachineOverhead"
			RNGMachineOverhead.Parent = PrimaryPart
			RNGMachineOverhead.WorldCFrame = p1:GetPivot() * CFrame.new(0, p1:GetExtentsSize().Y * 0.75 * (v1.OverheadYOffsetModifier or 1), 0)
			v2 = p4:Add(RNGMachineOverhead)
		end

		local v4, v5 = FastOverheadController.createFastOverhead({
			adornee = v2,
			guiTemplate = FastOverheadController.GuiTemplates.AnimalOverhead
		})

		p4:Add(v5)
		AnimalOverheadController:Populate({
			HidePrice = true,
			Overhead = v4,
			Index = p2,
			Mutation = p3,
			Player = LocalPlayer,
			Trove = p4
		})
		v4.Generation.Text = ("$%*/s"):format((NumberUtils:ToString(Animals:GetGeneration(p2, p3, nil))))
		v4.Generation.Visible = not v1.HideGeneration

		return v4
	end

	local function configureOfferTimer(p1, p2, p3) --[[ configureOfferTimer | Line: 1522 ]]
		local Stolen = p1:FindFirstChild("Stolen")

		if not (Stolen and Stolen:IsA("TextLabel")) then
			return
		end

		Stolen.Visible = true
		Stolen.LayoutOrder = -1
		Stolen.Size = UDim2.fromScale(1, 0.25)

		local function updateTimer() --[[ updateTimer | Line: 1531 | Upvalues: p2 (copy), Stolen (copy) ]]
			local v3 = math.max(0, (math.ceil(p2 - workspace:GetServerTimeNow())))

			Stolen.Text = ("%*s"):format(v3)

			return if v3 > 0 then Stolen.Parent ~= nil else false
		end

		local v3 = math.max(0, (math.ceil(p2 - workspace:GetServerTimeNow())))

		Stolen.Text = ("%*s"):format(v3)

		if v3 > 0 then
			local isParent = Stolen.Parent == nil
		end

		p3:Add(task.spawn(function() --[[ Line: 1538 | Upvalues: p2 (copy), Stolen (copy) ]]
			repeat
				task.wait(1)

				local v3 = math.max(0, (math.ceil(p2 - workspace:GetServerTimeNow())))

				Stolen.Text = ("%*s"):format(v3)
			until not (if v3 > 0 then Stolen.Parent ~= nil else false)
		end))
	end

	function t._updateLandedOffer(p1, p2) --[[ _updateLandedOffer | Line: 1548 | Upvalues: v49 (ref), v51 (ref), Animals2 (copy), NumberUtils (copy), v50 (ref) ]]
		local v1 = v49

		if not (v1 and v1.Parent) then
			return
		end

		v1.Enabled = false

		local v2 = if p2 then p2.Offer else p2

		if not p2 or (not p2.Enabled or (p2.State ~= "Offer" or typeof(v2) ~= "table")) then
			return
		end

		if v2.Name ~= v51 then
			return
		end

		local v3 = Animals2[v2.Name]
		local v4 = if v3 then v3.DisplayName else v2.Name

		v1.ActionText = "Purchase"
		v1.ObjectText = ("%* $%*"):format(v4, (NumberUtils:ToString(v2.BuyPrice)))
		v1.Enabled = true

		if not v50 then
			return
		end

		local Odds = v2.Odds

		v50.Price.Visible = p2.ShowResultOdds and (if typeof(Odds) == "number" then true else false)

		if not p2.ShowResultOdds or typeof(Odds) ~= "number" then
			return
		end

		v50.Price.Text = ("1 in %*"):format((NumberUtils:Comma((math.max(1, (math.round(Odds)))))))
	end
	function t._setupLandedBrainrot(p1, p2, p3, p4, p5) --[[ _setupLandedBrainrot | Line: 1577 | Upvalues: Trove (copy), v48 (ref), v51 (ref), v50 (ref), createLandedOverhead (copy), configureOfferTimer (copy), v49 (ref), v1 (copy), v31 (ref) ]]
		if not p4 then
			return
		end

		local PrimaryPart = p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart", true)

		if not PrimaryPart then
			warn(("[RNGMachine] %s has no BasePart for its Purchase prompt."):format(p3.ResultName))
			return
		end
		p2.PrimaryPart = PrimaryPart

		local v12 = Trove.new()

		v48 = v12
		v51 = p3.ResultName
		v50 = createLandedOverhead(p2, p3.ResultName, p3.Mutation, v12)

		if v50 and p5 then
			configureOfferTimer(v50, p5, v12)
		end

		local PromptAttachment = Instance.new("Attachment")
		local boundingBox, boundingSize = p2:GetBoundingBox()

		PromptAttachment.Name = "RNGPurchasePromptAttachment"
		PromptAttachment.Parent = PrimaryPart
		PromptAttachment.WorldCFrame = CFrame.new(boundingBox.Position)
		PromptAttachment = v12:Add(PromptAttachment)

		local ProximityPrompt = Instance.new("ProximityPrompt")

		ProximityPrompt.Name = "Purchase"
		ProximityPrompt.ActionText = "Purchase"
		ProximityPrompt.ObjectText = p3.ResultName
		ProximityPrompt.HoldDuration = 0.25
		ProximityPrompt.RequiresLineOfSight = false
		ProximityPrompt.MaxActivationDistance = 18
		ProximityPrompt.Style = Enum.ProximityPromptStyle.Default
		ProximityPrompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
		ProximityPrompt.Enabled = false
		ProximityPrompt.Parent = PromptAttachment
		v49 = v12:Add(ProximityPrompt)
		v12:Add(ProximityPrompt.Triggered:Connect(function() --[[ Line: 1618 | Upvalues: ProximityPrompt (copy), v1 (ref), p1 (copy), v31 (ref) ]]
			ProximityPrompt.Enabled = false
			task.spawn(function() --[[ Line: 1620 | Upvalues: v1 (ref), p1 (ref), v31 (ref) ]]
				local ok, result, result2 = pcall(v1.InvokeServer, v1)

				if not ok then
					warn(result)
				else
					if result == true then
						if ProximityPrompt.Parent then
							ProximityPrompt:Destroy()
						end
						return
					end

					if result2 then
						warn(result2)
					end
				end

				p1:_updateLandedOffer(v31)
				p1:_reconcilePrompts(v31)
			end)
		end))
		p1:_updateLandedOffer(v31)
		p1:_reconcilePrompts(v31)
	end

	local function playLuckVFX(p1, p2) --[[ playLuckVFX | Line: 1641 | Upvalues: Debris (copy), TweenService (copy) ]]
		local v1 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart", true)

		if not (v1 and v1:IsA("BasePart")) then
			return
		end

		local v2 = if p2 then p2 else Color3.fromRGB(72, 255, 108)
		local PointLight = Instance.new("PointLight")

		PointLight.Brightness = 0
		PointLight.Color = v2
		PointLight.Range = 24
		PointLight.Shadows = true
		PointLight.Parent = v1

		local Highlight = Instance.new("Highlight")

		Highlight.Adornee = p1
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Highlight.FillColor = v2
		Highlight.FillTransparency = 1
		Highlight.OutlineColor = v2
		Highlight.OutlineTransparency = 1
		Highlight.Parent = p1
		Debris:AddItem(PointLight, 1)
		Debris:AddItem(Highlight, 1)

		local v3 = TweenService:Create(PointLight, TweenInfo.new(0.12), {
			Brightness = 8
		})
		local v4 = TweenService:Create(Highlight, TweenInfo.new(0.12), {
			FillTransparency = 0.2,
			OutlineTransparency = 0
		})

		v3:Play()
		v4:Play()
		task.delay(0.18, function() --[[ Line: 1674 | Upvalues: PointLight (copy), Highlight (copy), TweenService (ref) ]]
			if PointLight.Parent and Highlight.Parent then
				TweenService:Create(PointLight, TweenInfo.new(0.18), {
					Brightness = 0
				}):Play()
				TweenService:Create(Highlight, TweenInfo.new(0.18), {
					FillTransparency = 0.75,
					OutlineTransparency = 0.5
				}):Play()
			end
		end)
	end

	local function getLuckStyle(p1) --[[ getLuckStyle | Line: 1686 | Upvalues: ReplicatedStorage (copy), LuckIcons (copy) ]]
		local LuckIcons2 = ReplicatedStorage:FindFirstChild("LuckIcons")
		local v1 = if LuckIcons2 then LuckIcons2:FindFirstChild((tostring(p1))) else LuckIcons2
		local v2 = if v1 then v1:FindFirstChild("Glow", true) else v1

		if v2 and v2:IsA("ParticleEmitter") then
			return v2.Color, v2.Color.Keypoints[1].Value, LuckIcons[("%*x"):format(p1)]
		end

		return nil, nil, LuckIcons[("%*x"):format(p1)]
	end

	local function styleVfx(p1, p2, p3, p4) --[[ styleVfx | Line: 1697 ]]
		for i, v in ipairs(p1:GetDescendants()) do
			local v1 = if v.Name == "LuckIcons" then true elseif v.Name == "LuckIcon" then true else false

			if v:IsA("ParticleEmitter") then
				if v1 then
					if p4 then
						v.Texture = p4
					end

					continue
				end

				if p2 then
					v.Color = p2
				end

				continue
			end

			if v:IsA("Beam") then
				if v1 then
					if p4 then
						v.Texture = p4
					end

					continue
				end

				if p2 then
					v.Color = p2
				end

				continue
			end

			if v:IsA("Trail") then
				if v1 then
					if p4 then
						v.Texture = p4
					end

					continue
				end

				if p2 then
					v.Color = p2
				end

				continue
			end

			if v:IsA("Light") and p3 then
				v.Color = p3
			end
		end
	end

	setLuckySpinVfx = function(p1, p2) --[[ setLuckySpinVfx | Line: 1730 | Upvalues: getLuckStyle (copy), t5 (copy), t10 (copy), styleVfx (copy), VFX (copy), t6 (copy) ]]
		local v1, v2, v3 = getLuckStyle(p1)

		for k in pairs(t5) do
			if p2 and v2 then
				k.Color = v2
			elseif not p2 and t10[k] then
				k.Color = t10[k]
			end

			styleVfx(k, v1, v2, v3)

			if p2 then
				VFX.enable(k, true)

				continue
			end

			VFX.disable(k, true)
		end

		for k in pairs(t6) do
			styleVfx(k, v1, v2, v3)

			if p2 then
				VFX.enable(k, true)

				continue
			end

			VFX.disable(k, true)
		end
	end

	local function emitExplosion(p1, p2) --[[ emitExplosion | Line: 1755 | Upvalues: getLuckStyle (copy), styleVfx (copy), VFX (copy) ]]
		local v1, v2, v3 = getLuckStyle(p2)

		for k in pairs(p1) do
			styleVfx(k, v1, v2, v3)
			VFX.emit(k)
		end
	end

	local luckGroundVfxToken = 0
	local function sustainLuckGroundVfx(duration)
		luckGroundVfxToken += 1
		local token = luckGroundVfxToken
		local groundEmitters = {}
		for root in pairs(t7) do
			local floor = root:FindFirstChild("Tier2Floor", true)
			local ground = floor and floor:FindFirstChild("RecolorCracks")
			if ground and ground:IsA("ParticleEmitter") then
				ground.Enabled = false
				table.insert(groundEmitters, ground)
			end
		end

		-- Freeze the single emitted ground effect instead of enabling its Rate,
		-- which caused the pond/blast animation to repeat every second.
		task.delay(0.12, function()
			if luckGroundVfxToken ~= token then
				return
			end
			for _, emitter in ipairs(groundEmitters) do
				if emitter.Parent then
					emitter.TimeScale = 0
				end
			end
		end)
		task.delay(duration, function()
			if luckGroundVfxToken ~= token then
				return
			end
			for _, emitter in ipairs(groundEmitters) do
				if emitter.Parent then
					emitter.TimeScale = 1
					pcall(emitter.Clear, emitter)
				end
			end
		end)
	end

	emitHighLuckExplosion = function(p1) --[[ emitHighLuckExplosion | Line: 1763 | Upvalues: t9 (copy), t8 (copy), emitExplosion (copy), ReplicatedStorage (copy), getLuckStyle (copy), styleVfx (copy), VFX (copy), Debris (copy) ]]
		emitExplosion(if p1 >= 12 then t9 else t8, p1)

		local RNGMachineVFX = ReplicatedStorage:FindFirstChild("RNGMachineVFX")
		local v2 = if RNGMachineVFX then RNGMachineVFX:FindFirstChild((("%*xLuckMapVFX"):format(p1))) else RNGMachineVFX

		if v2 then
			local v3 = v2:Clone()

			v3.Parent = workspace

			local v4, v5, v6 = getLuckStyle(p1)

			styleVfx(v3, v4, v5, v6)
			VFX.emit(v3)
			Debris:AddItem(v3, 10)
		end
	end

	local leverAnimationToken = 0
	local function playLeverAnimation(spinDuration) -- Animate the replacement machine's real hinge bone.
		local root = v55
		local leverModel = if root then root.Parent else nil
		local hinge = root and root:FindFirstChild("Lever")
		if not (leverModel and leverModel:IsA("Model") and hinge and hinge:IsA("Bone")) then
			return
		end

		leverAnimationToken += 1
		local token = leverAnimationToken
		hinge.Transform = CFrame.identity

		local downTween = TweenService:Create(
			hinge,
			TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Transform = CFrame.Angles(math.rad(-70), 0, 0) }
		)
		downTween:Play()

		local totalDuration = tonumber(spinDuration) or 5
		local riseStart = math.min(2, totalDuration)
		local riseDuration = math.max(0.1, totalDuration - riseStart)
		task.delay(riseStart, function()
			if leverAnimationToken ~= token or not hinge.Parent then
				return
			end
			local upTween = TweenService:Create(
				hinge,
				TweenInfo.new(riseDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Transform = CFrame.identity }
			)
			upTween:Play()
		end)
	end

	local function getStageMultiplier(p1) --[[ getStageMultiplier | Line: 1798 ]]
		local match = string.match

		return tonumber(match(p1.ResultName, "%d+"))
	end

	function t._renderActivityOffer(p1, p2, p3) --[[ _renderActivityOffer | Line: 1802 | Upvalues: prepareStageDisplay (copy), updateMutationScreen (copy), setLuckySpinVfx (copy), v45 (ref), v30 (ref), v47 (ref), t4 (copy), createDisplay (copy), destroySpinParticleEmitters (copy), destroySpinTrails (copy), Animals (copy), playIdleAnimation (copy), BrainrotAssets (copy) ]]
		local Offer = p2.Offer

		if not Offer then
			return
		end

		prepareStageDisplay()
		updateMutationScreen(Offer.Mutation)
		setLuckySpinVfx(Offer.Multiplier, false)

		local v1 = v45
		local v2 = v30
		local v3 = if v2 and v2:IsDescendantOf(workspace) then v2:GetPivot() else nil

		if not v3 then
			return
		end

		local v4

		if v47 then
			v4 = v47
		else
			local RNGMachineDisplay = Instance.new("Folder")

			RNGMachineDisplay.Name = "RNGMachineDisplay"
			RNGMachineDisplay.Parent = workspace
			v47 = RNGMachineDisplay
			v4 = RNGMachineDisplay
		end

		local t = {
			Type = "Brainrot",
			Name = Offer.Name
		}
		local t2 = {
			Stage = 0,
			Duration = 0,
			ResultIndex = 1,
			ResultType = "Brainrot",
			Multiplier = Offer.Multiplier,
			StartedAt = p2.SpinStartedAt,
			Entries = { t },
			ResultName = Offer.Name,
			Mutation = Offer.Mutation
		}
		local v5 = false

		local function renderModel(p12) --[[ renderModel | Line: 1844 | Upvalues: v5 (ref), v1 (copy), v45 (ref), t (copy), Offer (copy), t4 (ref), createDisplay (ref), v4 (ref), destroySpinParticleEmitters (ref), destroySpinTrails (ref), Animals (ref), playIdleAnimation (ref), v3 (copy), p1 (copy), t2 (copy), p3 (copy) ]]
			if v5 or v1 ~= v45 then
				return
			end

			local v12 = t
			local Mutation = Offer.Mutation
			local v2 = ("%*:%*:%*"):format(v12.Type, v12.Name, Mutation or "Normal")
			local v32 = t4[v2]

			if not (v32 and v32.Parent) then
				v32 = createDisplay(t, p12)

				if not v32 then
					return
				end

				v32:PivotTo(CFrame.new(0, 100000, 100000))
				v32.Parent = v4
				t4[v2] = v32
				destroySpinParticleEmitters(v32)
				destroySpinTrails(v32)

				if Offer.Mutation then
					task.spawn(function() --[[ Line: 1862 | Upvalues: Animals (ref), v32 (ref), Offer (ref), v1 (ref), v45 (ref), destroySpinTrails (ref) ]]
						local v12 = Animals:ApplyMutation(v32, Offer.Name, Offer.Mutation)

						if v1 == v45 and v32.Parent then
							if v12 then
								v32.Destroying:Once(v12)
							end

							destroySpinTrails(v32)
						else
							if not v12 then
								return
							end

							v12()
						end
					end)
				end

				task.spawn(playIdleAnimation, v32, Offer.Name)
			end

			v5 = true
			v32:PivotTo(v3 * CFrame.Angles(0, 1.5707963267948966, 0))
			p1:_setupLandedBrainrot(v32, t2, p3, Offer.ServerExpiresAt)
		end

		local v6 = t4
		local v7 = v6[("%*:%*:%*"):format(t.Type, t.Name, Offer.Mutation or "Normal")]

		if v7 and v7.Parent then
			renderModel(v7)
		else
			local v8 = BrainrotAssets.getModelBestEffort(Offer.Name, function(p1) --[[ Line: 1889 | Upvalues: renderModel (copy) ]]
				renderModel(p1)
			end, 20)

			if v8 then
				renderModel(v8)
			end
		end
	end

	local function isSpinHidden(p1) --[[ isSpinHidden | Line: 1899 ]]
		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return false
		end

		if (CurrentCamera.CFrame.Position - p1).Magnitude > 100 then
			return true
		end

		local _, v1 = CurrentCamera:WorldToViewportPoint(p1)

		return not v1
	end

	function t._animateStage(p1, p2, p3, p4) --[[ _animateStage | Line: 1911 | Upvalues: t3 (copy), prepareStageDisplay (copy), updateMutationScreen (copy), v45 (ref), v30 (ref), playLeverAnimation (copy), setLuckySpinVfx (copy), BrainrotAssets (copy), v47 (ref), LocalPlayer (copy), emitHighLuckExplosion (copy), t4 (copy), createDisplay (copy), destroySpinParticleEmitters (copy), destroySpinTrails (copy), Animals (copy), ContentProvider (copy), playIdleAnimation (copy), playSpinTick (copy), RNGMachineData (copy), TweenService (copy), v7 (copy), SoundController (copy), getLuckStyle (copy), playLuckVFX (copy), emitExplosion (copy), t7 (copy) ]]
		if t3.SelectedIdentity ~= p4 or t3.SelectedOwnerUserId ~= p3 then
			return
		end

		prepareStageDisplay()
		updateMutationScreen(p2.Mutation)

		local v1 = v45
		local Entries = p2.Entries

		if #Entries == 0 or not Entries[p2.ResultIndex] then
			return
		end

		local v2 = v30
		local v3 = if v2 and v2:IsDescendantOf(workspace) then v2:GetPivot() else nil

		if not v3 then
			return
		end

		playLeverAnimation(p2.Duration)

		local v4 = setLuckySpinVfx

		v4(p2.Multiplier, p2.Multiplier > 1 and p2.ResultType ~= "Luck")

		local t = {}

		for i, v in ipairs(Entries) do
			if v.Type == "Brainrot" then
				table.insert(t, v.Name)
			end
		end

		BrainrotAssets.preload(t)

		local v72

		if v47 then
			v72 = v47
		else
			local RNGMachineDisplay = Instance.new("Folder")

			RNGMachineDisplay.Name = "RNGMachineDisplay"
			RNGMachineDisplay.Parent = workspace
			v47 = RNGMachineDisplay
			v72 = RNGMachineDisplay
		end

		local Spinner = Instance.new("NumberValue")

		Spinner.Name = "Spinner"
		Spinner.Value = 0
		Spinner.Parent = v72
		t3.ActiveSpinner = Spinner

		local v9 = math.max(0, workspace:GetServerTimeNow() - p2.StartedAt)

		if p3 ~= LocalPlayer.UserId and p2.ResultType == "Luck" then
			local v10 = tonumber(string.match(p2.ResultName, "%d+"))
			local v11 = p2.Duration * 0.85 - v9

			if v10 and (v10 >= 10 and v11 > 0) then
				task.delay(v11, function() --[[ Line: 1961 | Upvalues: v1 (copy), v45 (ref), t3 (ref), p3 (copy), p4 (copy), emitHighLuckExplosion (ref), v10 (copy) ]]
					if v1 ~= v45 or (t3.SelectedOwnerUserId ~= p3 or t3.SelectedIdentity ~= p4) then
						return
					end

					emitHighLuckExplosion(v10)
				end)
			end
		end

		if p3 ~= LocalPlayer.UserId then
			v9 = math.min(v9, (math.max(0, p2.Duration - math.min(2, p2.Duration))))
		end

		local v15 = p2.Duration - v9
		local v16 = math.max(0.01, v15)
		local v17 = t3
		local v18

		if p3 == LocalPlayer.UserId then
			v18 = 0
		else
			local v19 = os.clock()

			v18 = v19 + math.max(0.01, p2.Duration * 0.85 - v9)
		end

		v17.StageVisualEndsAt = v18

		local v21 = math.max(0, 0.4 - v9)
		local v22 = os.clock() + v21
		local v23 = #Entries
		local t2 = {}
		local t5 = {}
		local t6 = {}
		local t8 = {}
		local v24 = false

		local function restoreFinalScale(p1, p2) --[[ restoreFinalScale | Line: 1989 | Upvalues: v3 (copy), v1 (copy), v45 (ref) ]]
			local Position = v3.Position
			local CurrentCamera = workspace.CurrentCamera
			local v12

			if CurrentCamera then
				if (CurrentCamera.CFrame.Position - Position).Magnitude > 100 then
					v12 = true
				else
					local _, v2 = CurrentCamera:WorldToViewportPoint(Position)

					v12 = not v2
				end
			else
				v12 = false
			end

			if v12 then
				task.spawn(function() --[[ Line: 1996 | Upvalues: v1 (ref), v45 (ref), p1 (copy), v3 (ref), p2 (copy) ]]
					while v1 == v45 and p1.Parent do
						local v12
						local Position = v3.Position
						local CurrentCamera = workspace.CurrentCamera

						if CurrentCamera then
							if (CurrentCamera.CFrame.Position - Position).Magnitude > 100 then
								v12 = true
							else
								local _, v2 = CurrentCamera:WorldToViewportPoint(Position)

								v12 = not v2
							end
						else
							v12 = false
						end

						if not v12 then
							break
						end

						task.wait(0.25)
					end

					if v1 ~= v45 or not p1.Parent then
						return
					end

					if not (p2 * 0.001 <= math.abs(p1:GetScale() - p2)) then
						return
					end

					p1:ScaleTo(p2)
				end)

				return
			end

			if not (p2 * 0.001 <= math.abs(p1:GetScale() - p2)) then
				return
			end

			p1:ScaleTo(p2)
		end

		local function initializeScale(p1) --[[ initializeScale | Line: 2009 | Upvalues: v21 (copy), v3 (copy), t6 (copy), t8 (copy) ]]
			local v1 = p1:GetAttribute("DefaultScale")
			local v2 = if typeof(v1) == "number" then v1 else p1:GetScale()

			if typeof(v1) ~= "number" then
				p1:SetAttribute("DefaultScale", v2)
			end

			local v32 = p1:GetScale()

			if v21 > 0 then
				local Position = v3.Position
				local CurrentCamera = workspace.CurrentCamera
				local v4

				if CurrentCamera then
					if (CurrentCamera.CFrame.Position - Position).Magnitude > 100 then
						v4 = true
					else
						local _, v5 = CurrentCamera:WorldToViewportPoint(Position)

						v4 = not v5
					end
				else
					v4 = false
				end

				if not v4 then
					local v6 = v2 * 0.5

					if v2 * 0.001 <= math.abs(v32 - v6) then
						p1:ScaleTo(v6)
					end

					v32 = v6
				end
			end

			t6[p1] = v32
			t8[p1] = v2
		end

		local function registerModel(p12, p22, p32) --[[ registerModel | Line: 2029 | Upvalues: v1 (copy), v45 (ref), t2 (copy), p2 (copy), t4 (ref), createDisplay (ref), destroySpinParticleEmitters (ref), destroySpinTrails (ref), v72 (ref), Animals (ref), ContentProvider (ref), playIdleAnimation (ref), t5 (copy), initializeScale (copy), v24 (ref), t8 (copy), restoreFinalScale (copy), v3 (copy), p1 (copy), p3 (copy), LocalPlayer (ref) ]]
			if v1 ~= v45 or t2[p12] then
				return
			end

			local Mutation = p2.Mutation
			local v12 = ("%*:%*:%*"):format(p22.Type, p22.Name, Mutation or "Normal")
			local v2 = t4[v12]
			local v32 = not v2 or not v2.Parent

			if v32 then
				v2 = createDisplay(p22, p32)

				if not v2 then
					return
				end

				local v4 = p22.Type == "Brainrot" and Animals3:FindFirstChild(p22.Name) ~= nil

				if v4 then
					destroySpinParticleEmitters(v2)
					destroySpinTrails(v2)
				end

				v2:PivotTo(CFrame.new(0, 100000, 100000))
				v2.Parent = v72

				if v4 and p2.Mutation then
					task.spawn(function() --[[ Line: 2052 | Upvalues: Animals (ref), v2 (ref), p22 (copy), p2 (ref), v1 (ref), v45 (ref), destroySpinTrails (ref) ]]
						local v12 = Animals:ApplyMutation(v2, p22.Name, p2.Mutation)

						if v1 == v45 and v2.Parent then
							if v12 then
								v2.Destroying:Once(v12)
							end

							destroySpinTrails(v2)
						else
							if not v12 then
								return
							end

							v12()
						end
					end)
				end

				t4[v12] = v2
				task.spawn(function() --[[ Line: 2067 | Upvalues: ContentProvider (ref), v2 (ref) ]]
					local ok, result = pcall(ContentProvider.PreloadAsync, ContentProvider, { v2 })

					if ok then
						return
					end

					warn(result)
				end)

				if v4 then
					task.spawn(playIdleAnimation, v2, p22.Name)
				end
			end

			local v5 = v2
			local v6 = assert(v5)
			if p22.Type == "Luck" then
				setLuckSelectionEffects(v6, false)
			end

			t2[p12] = v6
			table.insert(t5, v6)
			initializeScale(v6)

			if v24 and p12 == p2.ResultIndex then
				restoreFinalScale(v6, t8[v6])
				v6:PivotTo(v3 * CFrame.Angles(0, 1.5707963267948966, 0))

				if p2.ResultType ~= "Brainrot" then
					return
				end

				p1:_setupLandedBrainrot(v6, p2, p3 == LocalPlayer.UserId, nil)
			else
				v6:PivotTo(CFrame.new(0, 100000, 100000))
			end
		end

		for i, v in ipairs(Entries) do
			local v26 = t4[("%*:%*:%*"):format(v.Type, v.Name, p2.Mutation or "Normal")]

			if v26 and v26.Parent then
				registerModel(i, v, v26)

				continue
			end

			if v.Type == "Luck" then
				registerModel(i, v, nil)

				continue
			end

			local v27 = BrainrotAssets.getModelBestEffort(v.Name, function(p1) --[[ Line: 2106 | Upvalues: registerModel (copy), i (copy), v (copy) ]]
				registerModel(i, v, p1)
			end, 20)

			if v27 then
				registerModel(i, v, v27)
			end
		end

		local v28 = v23
		local v29 = (-1 / 0)

		local function updateObjects(p1) --[[ updateObjects | Line: 2117 | Upvalues: v22 (copy), v3 (copy), t2 (copy), v23 (copy), t8 (copy), t6 (copy), v28 (ref), v29 (ref), playSpinTick (ref), p2 (copy) ]]
			local v1 = if os.clock() < v22 then true else false
			local Position = v3.Position
			local CurrentCamera = workspace.CurrentCamera
			local v2

			if CurrentCamera then
				if (CurrentCamera.CFrame.Position - Position).Magnitude > 100 then
					v2 = true
				else
					local _, v32 = CurrentCamera:WorldToViewportPoint(Position)

					v2 = not v32
				end
			else
				v2 = false
			end

			if v2 then
				for k, v in pairs(t2) do
					if v.Parent then
						v:PivotTo(CFrame.new(0, 100000, 100000))
					end
				end
			else
				for i = 1, v23 do
					local v4
					local v5 = t2[i]

					if v5 and v5.Parent then
						v4 = if v23 == 1 then 0.5 else math.clamp((p1 - (i - 1)) % v23 * 0.5, 0, 1)

						local v7 = math.sin(v4 * math.pi)
						local v8 = t8[v5]
						local v9 = t6[v5]

						if v7 < 0.01 then
							if not v1 and v9 > 0.001 then
								v5:ScaleTo(0.001)
								t6[v5] = 0.001
							end

							v5:PivotTo(CFrame.new(0, 100000, 100000))

							continue
						end

						local v10 = math.clamp(v8 * v7 * 1.01, 0.001, v8)

						if not v1 and v8 * 0.001 <= math.abs(v9 - v10) then
							v5:ScaleTo(v10)
							t6[v5] = v10
						end

						v5:PivotTo(v3 * CFrame.new(v7 * -5 + 5, v7 * 3 + -3, (v4 - 0.5) * 20) * CFrame.Angles(0, 1.5707963267948966, 0))
					end
				end

				local v11 = (math.floor(p1 + 0.5) - 1) % v23 + 1

				if v11 == v28 then
					return
				end

				v28 = v11

				local v12 = os.clock()

				if not (v12 - v29 >= 0.1) then
					return
				end

				v29 = v12
				playSpinTick(p2)
			end
		end

		local v302 = RNGMachineData.DisplayRotations * v23 + p2.ResultIndex
		local v31 = if p2.Duration > 0 then math.clamp(v9 / p2.Duration, 0, 1) else 1
		local v33 = v302 * TweenService:GetValue(v31, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local v34 = Spinner.Changed:Connect(updateObjects)

		t3.ActiveConnection = v34
		Spinner.Value = v33
		updateObjects(v33)

		local v35 = TweenService:Create(Spinner, TweenInfo.new(v16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Value = v302
		})

		t3.ActiveTween = v35
		v35:Play()
		task.spawn(function() --[[ Line: 2191 | Upvalues: p2 (copy), v9 (ref), v1 (copy), v45 (ref), v72 (ref), t3 (ref), Spinner (copy), v34 (copy), v35 (copy), v302 (copy), v24 (ref), t2 (copy), t5 (copy), v3 (copy), v7 (ref), SoundController (ref), t8 (copy), restoreFinalScale (copy), getLuckStyle (ref), playLuckVFX (ref), setLuckySpinVfx (ref), emitExplosion (ref), t7 (ref), p1 (copy), p3 (copy), LocalPlayer (ref) ]]
			task.wait((math.max(0, p2.Duration * 0.85 - v9)))

			if v1 == v45 and v72.Parent then
				Spinner.Value = v302

				if t3.ActiveSpinner == Spinner then
					t3.ActiveSpinner = nil
					t3.ActiveTween = nil
					t3.ActiveConnection = nil
				end

				v35:Cancel()
				v34:Disconnect()
				Spinner:Destroy()
				v24 = true

				local v32 = t2[p2.ResultIndex]

				if v32 then
					restoreFinalScale(v32, t8[v32])

					for k, v in pairs(t2) do
						if k ~= p2.ResultIndex then
							v:PivotTo(CFrame.new(0, 100000, 100000))
						end
					end

					v32:PivotTo(v3 * CFrame.Angles(0, 1.5707963267948966, 0))

					local v4 = if p2.ResultType == "Luck" then "LuckLanded" else "BrainrotLanded"
					local Position = v3.Position
					local v6 = math.min((p2.Stage - 1) * 0.08 + 1, 1.4)
					local v73 = v7:FindFirstChild(v4)
					local v8

					if v73 and v73:IsA("Sound") then
						local v92 = v6 or 1
						local v10 = SoundController:PlaySound(v73, Position, false)

						if v10 then
							v10.PlaybackSpeed = v92
						end

						v8 = v10
					else
						v8 = nil
					end

					if v8 then
						local v11

						if p2.ResultType == "Luck" then
							v11 = math.min((p2.Stage - 1) * 0.12 + 1.2, 1.8)
						else
							local Stage = p2.Stage

							v11 = if Stage <= 1 then 1 else math.min((Stage - 2) * 0.12 + 1.12, 1.8)
						end

						v8.Volume = v8.Volume * (v11 * 1.2)
					end

					if p2.ResultType == "Luck" then
						local v16 = tonumber(string.match(p2.ResultName, "%d+"))

						-- The winning model is already pivoted into place above. Wait one
						-- rendered frame before enabling any light, highlight, flash, or explosion.
						task.delay(0.12, function()
							if not v32.Parent then
								return
							end
							setLuckSelectionEffects(v32, true)
							if not v16 then
								playLuckVFX(v32, nil)
								return
							end

							local _, v17 = getLuckStyle(v16)
							playLuckVFX(v32, v17)
							setLuckySpinVfx(v16, true)
							if v16 < 10 then
								emitExplosion(t7, v16)
								if v16 == 2 then
									sustainLuckGroundVfx(p2.Duration + 0.88)
								end
							end
						end)
					else
						setLuckySpinVfx(p2.Multiplier, false)
						p1:_setupLandedBrainrot(v32, p2, p3 == LocalPlayer.UserId, nil)
					end
				else
					for i, v in ipairs(t5) do
						v:PivotTo(CFrame.new(0, 100000, 100000))
					end

					local v20 = if p2.ResultType == "Luck" then "LuckLanded" else "BrainrotLanded"
					local v22 = math.min((p2.Stage - 1) * 0.08 + 1, 1.4)
					local v23 = v7:FindFirstChild(v20)

					if not v23 then
						return
					end

					if not v23:IsA("Sound") then
						return
					end

					local v25 = SoundController:PlaySound(v23, v3.Position, false)

					if not v25 then
						return
					end

					v25.PlaybackSpeed = v22 or 1
				end
			else
				if t3.ActiveSpinner == Spinner then
					t3.ActiveSpinner = nil
					t3.ActiveTween = nil
					t3.ActiveConnection = nil
				end

				v34:Disconnect()
				v35:Cancel()
				Spinner:Destroy()
			end
		end)
	end

	local function isOfferActivityValid(p1, p2) --[[ isOfferActivityValid | Line: 2269 ]]
		return if p1.State == "Offer" and p1.Offer ~= nil then p2 < p1.Offer.ServerExpiresAt else false
	end

	local function isSpinActivityActive(p1, p2) --[[ isSpinActivityActive | Line: 2273 ]]
		if p1.State ~= "Spinning" then
			return false
		end

		local Stage = p1.Stage

		return not Stage or p2 < Stage.StartedAt + Stage.Duration * 0.85
	end

	local function getActivityPriorityMultiplier(p1) --[[ getActivityPriorityMultiplier | Line: 2281 ]]
		return p1.Multiplier
	end

	local function getDisplayedSpinTier(p1) --[[ getDisplayedSpinTier | Line: 2285 ]]
		local Stage = p1.Stage

		if not Stage or Stage.ResultType ~= "Luck" then
			return p1.Multiplier
		end

		return tonumber(string.match(Stage.ResultName, "%d+")) or p1.Multiplier
	end

	local function isStageNewer(p1, p2) --[[ isStageNewer | Line: 2293 ]]
		if not p2 then
			return true
		end

		if p1.StartedAt == p2.StartedAt then
			return p1.Stage > p2.Stage
		end

		return p1.StartedAt > p2.StartedAt
	end

	local function getSpinningTextLabel() --[[ getSpinningTextLabel | Line: 2303 | Upvalues: t3 (copy) ]]
		local SpinningText = t3.SpinningText

		if SpinningText and SpinningText.Parent then
			return SpinningText
		end

		local RNGMachine = workspace:FindFirstChild("RNGMachine")
		local v1 = if RNGMachine then RNGMachine:FindFirstChild("SpinningText", true) else RNGMachine

		if v1 and v1:IsA("TextLabel") then
			t3.SpinningText = v1

			return v1
		end

		return nil
	end
end

local function updateSpinningText(p1) --[[ updateSpinningText | Line: 2317 | Upvalues: t3 (copy), LocalPlayer (copy), Players (copy), TextService (copy) ]]
	local v1 = t3

	v1.SpinningTextToken = v1.SpinningTextToken + 1

	local SpinningTextToken = t3.SpinningTextToken
	local SpinningText = t3.SpinningText
	local v2

	if SpinningText and SpinningText.Parent then
		v2 = SpinningText
	else
		local RNGMachine = workspace:FindFirstChild("RNGMachine")
		local v3 = if RNGMachine then RNGMachine:FindFirstChild("SpinningText", true) else RNGMachine

		if v3 and v3:IsA("TextLabel") then
			t3.SpinningText = v3
			v2 = v3
		else
			v2 = nil
		end
	end

	if v2 and (p1 and p1.UserId ~= LocalPlayer.UserId) then
		local v4 = Players:GetPlayerByUserId(p1.UserId)

		if not v4 then
			v2.Visible = false

			return
		end

		v2.Text = ("%* is spinning..."):format(v4.DisplayName)

		local ImageLabel = v2:FindFirstChild("ImageLabel")

		if not (ImageLabel and ImageLabel:IsA("ImageLabel")) then
			v2.TextXAlignment = Enum.TextXAlignment.Left
			v2.Visible = true
			task.spawn(function() --[[ Line: 2345 | Upvalues: SpinningTextToken (copy), t3 (ref), v2 (copy), TextService (ref) ]]
				for i = 1, 10 do
					if SpinningTextToken ~= t3.SpinningTextToken or not v2.Parent then
						break
					end

					local GetTextBoundsParams = Instance.new("GetTextBoundsParams")

					GetTextBoundsParams.Text = v2.Text
					GetTextBoundsParams.Font = v2.FontFace
					GetTextBoundsParams.RichText = v2.RichText
					GetTextBoundsParams.Size = 16

					local ok, result = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams)

					GetTextBoundsParams:Destroy()

					if ok then
						v2.Size = UDim2.new(math.clamp(result.X / 240, 0, 1), 0, v2.Size.Y.Scale, v2.Size.Y.Offset)

						for j = 1, 10 do
							task.wait()

							if SpinningTextToken ~= t3.SpinningTextToken or not v2.Parent then
								break
							end

							local ImageLabel = v2:FindFirstChild("ImageLabel")

							if v2.AbsoluteSize.X > 0 and (ImageLabel and (ImageLabel:IsA("ImageLabel") and ImageLabel.AbsoluteSize.X > 0)) then
								local X = v2.TextBounds.X

								if X > 0 then
									v2.Size = UDim2.new(v2.Size.X.Scale * (X / v2.AbsoluteSize.X), 0, v2.Size.Y.Scale, v2.Size.Y.Offset)
									task.wait()
								end

								ImageLabel.Position = UDim2.new(-0.025, 0, ImageLabel.Position.Y.Scale, ImageLabel.Position.Y.Offset)

								local Scale = v2.Size.X.Scale
								local v5 = if Scale > 0 then v2.AbsoluteSize.X / Scale else 0

								v2.Position = UDim2.new(0.5 + (if v5 > 0 then (ImageLabel.AbsoluteSize.X + math.abs(ImageLabel.Position.X.Scale) * v2.AbsoluteSize.X) / (2 * v5) else 0), 0, v2.Position.Y.Scale, v2.Position.Y.Offset)

								return
							end
						end

						return
					end

					task.wait(1)
				end
			end)

			return
		end

		ImageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v4.UserId)
		v2.TextXAlignment = Enum.TextXAlignment.Left
		v2.Visible = true
		task.spawn(function() --[[ Line: 2345 | Upvalues: SpinningTextToken (copy), t3 (ref), v2 (copy), TextService (ref) ]]
			for i = 1, 10 do
				if SpinningTextToken ~= t3.SpinningTextToken or not v2.Parent then
					break
				end

				local GetTextBoundsParams = Instance.new("GetTextBoundsParams")

				GetTextBoundsParams.Text = v2.Text
				GetTextBoundsParams.Font = v2.FontFace
				GetTextBoundsParams.RichText = v2.RichText
				GetTextBoundsParams.Size = 16

				local ok, result = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams)

				GetTextBoundsParams:Destroy()

				if ok then
					v2.Size = UDim2.new(math.clamp(result.X / 240, 0, 1), 0, v2.Size.Y.Scale, v2.Size.Y.Offset)

					for j = 1, 10 do
						task.wait()

						if SpinningTextToken ~= t3.SpinningTextToken or not v2.Parent then
							break
						end

						local ImageLabel = v2:FindFirstChild("ImageLabel")

						if v2.AbsoluteSize.X > 0 and (ImageLabel and (ImageLabel:IsA("ImageLabel") and ImageLabel.AbsoluteSize.X > 0)) then
							local X = v2.TextBounds.X

							if X > 0 then
								v2.Size = UDim2.new(v2.Size.X.Scale * (X / v2.AbsoluteSize.X), 0, v2.Size.Y.Scale, v2.Size.Y.Offset)
								task.wait()
							end

							ImageLabel.Position = UDim2.new(-0.025, 0, ImageLabel.Position.Y.Scale, ImageLabel.Position.Y.Offset)

							local Scale = v2.Size.X.Scale
							local v5 = if Scale > 0 then v2.AbsoluteSize.X / Scale else 0

							v2.Position = UDim2.new(0.5 + (if v5 > 0 then (ImageLabel.AbsoluteSize.X + math.abs(ImageLabel.Position.X.Scale) * v2.AbsoluteSize.X) / (2 * v5) else 0), 0, v2.Position.Y.Scale, v2.Position.Y.Offset)

							return
						end
					end

					return
				end

				task.wait(1)
			end
		end)
	else
		if not v2 then
			return
		end

		v2.Visible = false
	end
end

local function getSelectedActivity() --[[ getSelectedActivity | Line: 2416 | Upvalues: t3 (copy), LocalPlayer (copy), v31 (ref), v46 (ref), Players (copy) ]]
	local ActivityData = t3.ActivityData
	local v1 = if ActivityData then ActivityData.Sessions[tostring(LocalPlayer.UserId)] else nil
	local PrivateStagePayload = t3.PrivateStagePayload

	if if v31 == nil or v31.State ~= "Spinning" then v46 else true then
		if v1 and v1.State == "Spinning" then
			local Stage = v1.Stage

			if PrivateStagePayload and (if Stage then if PrivateStagePayload.StartedAt == Stage.StartedAt then if PrivateStagePayload.Stage > Stage.Stage then true else false else PrivateStagePayload.StartedAt > Stage.StartedAt else true) then
				Stage = PrivateStagePayload
			end

			return v1, Stage
		end

		local t = {
			State = "Spinning",
			Offer = nil,
			UserId = LocalPlayer.UserId
		}

		t.SpinStartedAt = if PrivateStagePayload then PrivateStagePayload.StartedAt else workspace:GetServerTimeNow()
		t.Multiplier = if PrivateStagePayload then PrivateStagePayload.Multiplier else 1
		t.Stage = PrivateStagePayload

		return t, PrivateStagePayload
	end

	local v6 = workspace:GetServerTimeNow()
	local v7 = if v31 then v31.Offer else nil

	if v1 then
		if v1.State == "Spinning" then
			return v1, v1.Stage
		end

		if if v1.State == "Offer" and v1.Offer ~= nil then if v6 < v1.Offer.ServerExpiresAt then true else false else false then
			return v1, nil
		end
	end

	if v31 and (v31.State == "Offer" and (v7 and v6 < v7.ServerExpiresAt)) then
		return {
			State = "Offer",
			Stage = nil,
			UserId = LocalPlayer.UserId,
			SpinStartedAt = v7.ExpiresAt,
			Multiplier = v7.Multiplier,
			Offer = {
				Name = v7.Name,
				Multiplier = v7.Multiplier,
				Mutation = v7.Mutation,
				ExpiresAt = v7.ExpiresAt,
				ServerExpiresAt = v7.ServerExpiresAt
			}
		}, nil
	end

	if not ActivityData then
		return nil, nil
	end

	local v9 = nil
	local v10 = nil

	for k, v in pairs(ActivityData.Sessions) do
		local v11, v12, v13

		if v.UserId == LocalPlayer.UserId or Players:GetPlayerByUserId(v.UserId) then
			if v.State == "Spinning" then
				local Stage = v.Stage

				v11 = not Stage or (if v6 < Stage.StartedAt + Stage.Duration * 0.85 then true else false)
			else
				v11 = false
			end

			if not v11 then
				v11 = if v.State == "Offer" and v.Offer ~= nil then if v6 < v.Offer.ServerExpiresAt then true else false else false
			end

			if v11 then
				if v.State == "Offer" then
					local v14 = assert(v.Offer)

					if not (v14.ExpiresAt < t3.LatestOfferExpiresAt) then
						local v15 = if v10 then v10.Offer else v10

						if not v15 or (v14.ExpiresAt > v15.ExpiresAt or v14.ExpiresAt == v15.ExpiresAt and (v10 and v.SpinStartedAt > v10.SpinStartedAt)) then
							v10 = v
						end
					end

					continue
				end

				local Multiplier = v.Multiplier

				if v9 then
					v12 = v9.Multiplier
					v13 = v9
				else
					v13 = v9
					v12 = (-1 / 0)
				end

				if not v13 or (v12 < Multiplier or Multiplier == v12 and v.SpinStartedAt < v13.SpinStartedAt) then
					v9 = v
				end
			end
		end
	end

	local v16 = v9 or v10

	if v16 and v16.State == "Spinning" then
		return v16, v16.Stage
	end

	return v16, nil
end

local function getActivityIdentity(p1, p2) --[[ getActivityIdentity | Line: 2523 ]]
	if p1.State == "Offer" then
		return ("%*:Offer:%*"):format(p1.UserId, assert(p1.Offer).ExpiresAt)
	end

	if p2 then
		return ("%*:Spinning:%*:%*"):format(p1.UserId, p2.Stage, p2.StartedAt)
	end

	return ("%*:Spinning:Pending:%*"):format(p1.UserId, p1.SpinStartedAt)
end

function t._reconcileActivityDisplay(p1) --[[ _reconcileActivityDisplay | Line: 2534 | Upvalues: getSelectedActivity (copy), updateSpinningText (copy), t3 (copy), v47 (ref), clearDisplay (copy), v52 (ref), Mutations (copy), v53 (ref), CustomRichTextController (copy), v54 (ref), setLuckySpinVfx (copy), LocalPlayer (copy), v31 (ref), prepareStageDisplay (copy) ]]
	local v1, v2 = getSelectedActivity()

	if v1 then
		if v1.State == "Offer" and v1.Offer then
			t3.LatestOfferExpiresAt = math.max(t3.LatestOfferExpiresAt, v1.Offer.ExpiresAt)
		end

		if v1.UserId ~= LocalPlayer.UserId and (t3.SelectedOwnerUserId and (t3.SelectedOwnerUserId ~= LocalPlayer.UserId and (t3.SelectedState == "Spinning" and t3.ActivityData))) then
			local v4 = t3.ActivityData.Sessions[tostring(t3.SelectedOwnerUserId)]

			if v4 and v4.State == "Spinning" then
				local v5

				if v1.UserId == v4.UserId then
					v5 = false
				else
					local Stage = v4.Stage
					local v6

					if Stage and Stage.ResultType == "Luck" then
						local v7 = tonumber(string.match(Stage.ResultName, "%d+"))

						v6 = if v7 then v7 else v4.Multiplier
					else
						v6 = v4.Multiplier
					end

					v5 = if v6 < v1.Multiplier then true else false
				end

				if not v5 then
					v2 = v4.Stage
					v1 = v4
				end
			end
		end

		local v8 = if v1.State == "Offer" then ("%*:Offer:%*"):format(v1.UserId, assert(v1.Offer).ExpiresAt) elseif v2 then ("%*:Spinning:%*:%*"):format(v1.UserId, v2.Stage, v2.StartedAt) else ("%*:Spinning:Pending:%*"):format(v1.UserId, v1.SpinStartedAt)

		if v1.State == "Spinning" and (t3.SelectedOwnerUserId == v1.UserId and (t3.SelectedState == "Spinning" and (t3.SelectedIdentity and (t3.SelectedIdentity ~= v8 and os.clock() < t3.StageVisualEndsAt)))) then
			updateSpinningText(v1)
			task.delay(t3.StageVisualEndsAt - os.clock(), function() --[[ Line: 2583 | Upvalues: p1 (copy) ]]
				p1:_reconcileActivityDisplay()
			end)

			return
		end

		local v13 = if t3.SelectedOwnerUserId == v1.UserId then t3.SelectedState == "Spinning" else false

		if v1.State == "Offer" and (v1.UserId ~= LocalPlayer.UserId and (v13 and os.clock() < t3.StageVisualEndsAt)) then
			updateSpinningText(v1)
			task.delay(t3.StageVisualEndsAt - os.clock(), function() --[[ Line: 2598 | Upvalues: p1 (copy) ]]
				p1:_reconcileActivityDisplay()
			end)

			return
		end

		local v14 = if v1.State == "Offer" then ("%*:Offer:%*"):format(v1.UserId, assert(v1.Offer).ExpiresAt) elseif v2 then ("%*:Spinning:%*:%*"):format(v1.UserId, v2.Stage, v2.StartedAt) else ("%*:Spinning:Pending:%*"):format(v1.UserId, v1.SpinStartedAt)
		local v19 = if v1.UserId == LocalPlayer.UserId then true else false

		updateSpinningText(v1)

		if t3.SelectedIdentity == v14 and v47 then
			if v1.State ~= "Offer" or not v19 then
				return
			end

			p1:_updateLandedOffer(v31)
		else
			t3.SelectedIdentity = v14
			t3.SelectedOwnerUserId = v1.UserId
			t3.SelectedState = v1.State

			if v1.State == "Offer" then
				if not v19 and (v1.Stage and not v13) then
					local v20 = table.clone(v1.Stage)

					v20.StartedAt = workspace:GetServerTimeNow()
					p1:_animateStage(v20, v1.UserId, v14)

					return
				end

				p1:_renderActivityOffer(v1, v19)
			else
				if v2 then
					p1:_animateStage(v2, v1.UserId, v14)

					return
				end

				prepareStageDisplay()
				v52 = nil

				local v21 = v52 or ""
				local v22 = Mutations[v21]
				local v23 = if v22 then v22.DisplayWithRichText or v22.DisplayText else v21

				if v53 then
					CustomRichTextController.apply(v53, v23, {
						attachToInstance = true
					})
				end

				if v54 then
					v54.LocalTransparencyModifier = if v52 then 1 else 0
				end

				setLuckySpinVfx(v1.Multiplier, v1.Multiplier > 1)
			end
		end
	else
		updateSpinningText(nil)

		if t3.SelectedIdentity or v47 then
			clearDisplay()
		end

		v52 = nil

		local v28 = v52 or ""
		local v29 = Mutations[v28]
		local v30 = if v29 then v29.DisplayWithRichText or v29.DisplayText else v28

		if v53 then
			CustomRichTextController.apply(v53, v30, {
				attachToInstance = true
			})
		end

		if v54 then
			v54.LocalTransparencyModifier = if v52 then 1 else 0
		end

		setLuckySpinVfx(1, false)
	end
end

local function getSynchronizedSkillLevel(p1, p2, p3) --[[ getSynchronizedSkillLevel | Line: 2636 ]]
	local v1 = p1:Get((("RNGMachine.%*Level"):format(p2)))

	if typeof(v1) == "number" then
		return math.clamp(math.floor(v1), 0, p3)
	end

	return 0
end

local function getClientState(p1, p2) --[[ getClientState | Line: 2641 ]]
	local v1 = p2:Get("Rebirth")
	local v2 = if typeof(v1) == "number" and v1 == v1 then v1 else 0
	local v4 = p2:Get("RNGMachine.LuckLevel")
	local v5 = if typeof(v4) == "number" then math.clamp(math.floor(v4), 0, #p1.SkillTree.Luck) else 0
	local v9 = p2:Get("RNGMachine.SpeedLevel")
	local v10 = if typeof(v9) == "number" then math.clamp(math.floor(v9), 0, #p1.SkillTree.Speed) else 0
	local t = {
		Enabled = p1.Enabled,
		ShowResultOdds = p1.ShowResultOdds,
		State = p1.State,
		SpinCost = math.round((p1.SpinCosts[v5 + 1] or p1.SpinCosts[#p1.SpinCosts]) * p1.SpeedSpinCostMultiplier ^ v10),
		SkillTree = p1.SkillTree,
		SpinCosts = p1.SpinCosts,
		SpeedSpinCostMultiplier = p1.SpeedSpinCostMultiplier,
		Offer = p1.Offer,
		Rebirths = v2
	}
	local t2 = {
		Luck = {
			Level = v5
		},
		Speed = {
			Level = v10
		}
	}
	local t3 = {}
	local v17 = p2:Get("RNGMachine.GoldMutationLevel")

	t3.Level = if typeof(v17) == "number" then math.clamp(math.floor(v17), 0, #p1.SkillTree.GoldMutation) else 0
	t2.GoldMutation = t3

	local t4 = {}
	local v22 = p2:Get("RNGMachine.DiamondMutationLevel")

	t4.Level = if typeof(v22) == "number" then math.clamp(math.floor(v22), 0, #p1.SkillTree.DiamondMutation) else 0
	t2.DiamondMutation = t4

	local t5 = {}
	local v27 = p2:Get("RNGMachine.RainbowMutationLevel")

	t5.Level = if typeof(v27) == "number" then math.clamp(math.floor(v27), 0, #p1.SkillTree.RainbowMutation) else 0
	t2.RainbowMutation = t5

	local t6 = {}
	local v32 = p2:Get("RNGMachine.EventMutationLevel")

	t6.Level = if typeof(v32) == "number" then math.clamp(math.floor(v32), 0, #p1.SkillTree.EventMutation) else 0
	t2.EventMutation = t6
	t.Skills = t2

	return t
end

function t._handleStateChanged(p1, p2) --[[ _handleStateChanged | Line: 2694 | Upvalues: v31 (ref), v32 (ref), v34 (ref), v40 (ref), setCanvasOffset (copy), animateNewlyRevealedNodes (copy), focusSkillTreeSelection (copy), v46 (ref), t3 (copy) ]]
	local v1 = v31

	v31 = p2

	if v32 == "EventMutation" and p2.Skills.RainbowMutation.Level < #p2.SkillTree.RainbowMutation then
		v32 = "Main"

		local v2 = v34

		if v2 then
			local Close = v2:FindFirstChild("Close")
			local v3 = if Close then Close:FindFirstChild("Txt") else Close

			if v3 and v3:IsA("TextLabel") then
				v3.Text = "CLOSE"
			end

			if v40 then
				v40.Visible = v32 == "EventMutation"
			end
		end

		setCanvasOffset(Vector2.zero)
	end

	p1:_updateLandedOffer(p2)
	p1:_reconcilePrompts(p2)

	if v34 and v34.Enabled then
		p1:_renderSkillTree()

		if v1 then
			animateNewlyRevealedNodes(v1, p2)
		end

		task.defer(focusSkillTreeSelection)
	end

	if p2.State ~= "Spinning" then
		t3.PrivateStagePayload = nil
		v46 = false
		p1:_reconcileActivityDisplay()

		return
	end

	if (not v1 or v1.State ~= "Spinning") and not v46 then
		t3.PrivateStagePayload = nil
	end

	p1:_reconcileActivityDisplay()
	v46 = false
end
function t._setupObservers(p1) --[[ _setupObservers | Line: 2729 | Upvalues: Observers (copy), observeDisplayCenter (copy), observeSpinPrompt (copy), observeSkillTreePrompt (copy), v56 (copy), v57 (copy), v58 (copy), v59 (copy), v60 (copy), observeLeverRoot (copy), observeMutationScreen (copy), observeMutationScreenLine (copy), v33 (ref), t (copy), v31 (ref) ]]
	Observers.observeTag("RNGMachineCenter", observeDisplayCenter)
	Observers.observeTag("RNGMachineSpinPrompt", observeSpinPrompt)
	Observers.observeTag("RNGMachineSkillTreePrompt", observeSkillTreePrompt)
	Observers.observeTag("RNGMachineRecolorVFX", v56)
	Observers.observeTag("RNGMachinePadVFX", v57)
	Observers.observeTag("RNGMachineLuckExplosionVFX", v58)
	Observers.observeTag("RNGMachine10xExplosionVFX", v59)
	Observers.observeTag("RNGMachine12xExplosionVFX", v60)
	Observers.observeTag("RNGMachineLeverRoot", observeLeverRoot)
	Observers.observeTag("RNGMachineMutationScreen", observeMutationScreen)
	Observers.observeTag("RNGMachineMutationScreenLine", observeMutationScreenLine)

	if not v33 then
		v33 = true
		task.defer(function() --[[ Line: 1129 | Upvalues: v33 (ref), t (ref), v31 (ref) ]]
			v33 = false
			t:_reconcilePrompts(v31)
		end)
	end
end
function t._setupRemotes(p1) --[[ _setupRemotes | Line: 2744 | Upvalues: v3 (copy), v31 (ref), v46 (ref), t3 (copy), v4 (copy), LocalPlayer (copy), emitHighLuckExplosion (copy) ]]
	v3.OnClientEvent:Connect(function(p12) --[[ Line: 2745 | Upvalues: v31 (ref), v46 (ref), t3 (ref), p1 (copy) ]]
		if workspace:GetServerTimeNow() - p12.StartedAt > p12.Duration + 0.5 then
			return
		end

		if not v31 or v31.State ~= "Spinning" then
			v46 = true
		end

		t3.PrivateStagePayload = p12
		p1:_reconcileActivityDisplay()
	end)
	v4.OnClientEvent:Connect(function(p1) --[[ Line: 2755 | Upvalues: t3 (ref), LocalPlayer (ref), emitHighLuckExplosion (ref) ]]
		if t3.SelectedOwnerUserId ~= LocalPlayer.UserId or (t3.SelectedState ~= "Spinning" or (typeof(p1) ~= "number" or p1 ~= 10 and p1 ~= 12)) then
			return
		end

		emitHighLuckExplosion(p1)
	end)
end
function t._setupActivityReplication(p1) --[[ _setupActivityReplication | Line: 2767 | Upvalues: Players (copy), t3 (copy), updateSpinningText (copy), clearDisplay (copy), v6 (copy) ]]
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 2768 | Upvalues: t3 (ref), updateSpinningText (ref), clearDisplay (ref), p1 (copy) ]]
		if t3.SelectedOwnerUserId ~= p12.UserId then
			task.defer(function() --[[ Line: 2773 | Upvalues: p1 (ref) ]]
				p1:_reconcileActivityDisplay()
			end)

			return
		end

		updateSpinningText(nil)
		clearDisplay()
		task.defer(function() --[[ Line: 2773 | Upvalues: p1 (ref) ]]
			p1:_reconcileActivityDisplay()
		end)
	end)
	task.spawn(function() --[[ Line: 2778 | Upvalues: v6 (ref), t3 (ref), p1 (copy) ]]
		v6:WaitForLoaded()
		v6:ListenRaw(function(p12) --[[ updateActivity | Line: 2781 | Upvalues: t3 (ref), p1 (ref) ]]
			t3.ActivityData = p12
			p1:_reconcileActivityDisplay()
		end)
		t3.ActivityData = v6.Data
		p1:_reconcileActivityDisplay()
	end)
end
function t._setupStateReplication(p1) --[[ _setupStateReplication | Line: 2791 | Upvalues: v5 (copy), Synchronizer (copy), LocalPlayer (copy), getClientState (copy), v10 (copy) ]]
	task.spawn(function() --[[ Line: 2792 | Upvalues: v5 (ref), Synchronizer (ref), LocalPlayer (ref), p1 (copy), getClientState (ref), v10 (ref) ]]
		v5:WaitForLoaded()

		local v1 = Synchronizer:Wait(LocalPlayer)

		local function updateState() --[[ updateState | Line: 2796 | Upvalues: v5 (ref), p1 (ref), getClientState (ref), v1 (copy) ]]
			local Data = v5.Data

			if not Data then
				return
			end

			p1:_handleStateChanged((getClientState(Data, v1)))
		end

		v5:ListenRaw(function(p12) --[[ Line: 2803 | Upvalues: p1 (ref), getClientState (ref), v1 (copy) ]]
			p1:_handleStateChanged((getClientState(p12, v1)))
		end)
		v1:OnChanged("Rebirth", updateState)

		for i, v in ipairs(v10) do
			v1:OnChanged(("RNGMachine.%*Level"):format(v), updateState)
		end

		local Data = v5.Data

		if not Data then
			return
		end

		p1:_handleStateChanged((getClientState(Data, v1)))
	end)
end
function t.Start(p1) --[[ Start | Line: 2814 | Upvalues: v8 (ref), ContentProvider (copy), v7 (copy) ]]
	if script:GetAttribute("RNGMachineStarted") then
		return
	end
	script:SetAttribute("RNGMachineStarted", true)
	local LeverAnimation = script:FindFirstChild("LeverAnimation")

	if LeverAnimation and LeverAnimation:IsA("Animation") then
		v8 = LeverAnimation
	else
		warn("RNG Machine lever animation is missing")
	end

	p1:_setupSkillTree()
	p1:_setupObservers()
	p1:_setupRemotes()
	p1:_setupActivityReplication()
	p1:_setupStateReplication()
	task.spawn(function() --[[ Line: 2828 | Upvalues: ContentProvider (ref), v7 (ref) ]]
		local ok, result = pcall(ContentProvider.PreloadAsync, ContentProvider, v7:GetChildren())

		if ok then
			return
		end

		warn(result)
	end)
end

return table.freeze(t)