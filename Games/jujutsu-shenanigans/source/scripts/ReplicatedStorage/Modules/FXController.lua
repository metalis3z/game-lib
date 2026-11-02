local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Rep = game:GetService("ReplicatedStorage")
--local utils = game:GetService("ReplicatedStorage").Utils
local Player = game.Players.LocalPlayer
local module = {}
local abs_upvr = math.abs
function module.PlaySound(SoundLocation, Parent, Group, PlayOnRemove)
	local Sound = SoundLocation:Clone()
	Sound.Parent = Parent
	Sound.SoundGroup = Group
	Sound:Play()
	if SoundLocation.PlayOnRemove ~= true then
		if not PlayOnRemove then
			Debris:AddItem(Sound, SoundLocation.TimeLength)
		end
		return Sound
	end
	Sound:Destroy()
end

local mouse_upvr = Player:GetMouse()
Player:GetMouse().TargetFilter = workspace.Effects


function module.GetMouseTarget(arg1, arg2) -- Line 113
	--[[ Upvalues[2]:
		[1]: mouse_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local CurrentCamera_3 = workspace.CurrentCamera
	local var38
	if var38 == nil then
		var38 = 300
	end
	if arg1.LastInput ~= "Mobile" then
		local Position = mouse_upvr.Hit.Position
		local var40 = Position - CurrentCamera_3.CFrame.Position
		if var38 < var40.Magnitude then
			Position = CurrentCamera_3.CFrame.Position + var40.Unit * var38
		end
		return Position
	end
	local RaycastParams_new_result1 = RaycastParams.new()
	RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, workspace.Effects}
	local var43 = CurrentCamera_3.CFrame.LookVector * var38
	local workspace_Raycast_result1 = workspace:Raycast((CurrentCamera_3.CFrame + CurrentCamera_3.CFrame.UpVector * 1).Position, var43, RaycastParams_new_result1)
	if workspace_Raycast_result1 then
		return workspace_Raycast_result1.Position
	end
	return CurrentCamera_3.CFrame.Position + var43
end

function module.Flash(arg1, arg2, arg3, arg4) 

	local Position_3 = workspace.CurrentCamera.CFrame.Position
	local Position_2 = arg2.PrimaryPart.Position
	if 200 < abs_upvr(Position_3.X - Position_2.X) + abs_upvr(Position_3.Y - Position_2.Y) + abs_upvr(Position_3.Z - Position_2.Z) then
	else
		local clone = Rep.Assets.Effects.HitGlow:Clone()
		clone.Parent = workspace.Effects
		game.Debris:AddItem(clone, arg4 or 0.15)
		for _, v_13 in clone:GetChildren() do
			local SOME_2 = arg2:FindFirstChild(v_13.Name)
			if SOME_2 then
				local Weld = Instance.new("Weld", v_13)
				Weld.Part0 = v_13
				Weld.Part1 = SOME_2
			end
			v_13.Color = arg3
			if arg4 then
				TweenService:Create(v_13, TweenInfo.new(arg4), {
					Transparency = 1;
				}):Play()
			end
		end
	end
end

function module.DomainMapFade(FillColor, Tween, Time) 
	local Highlight = Instance.new("Highlight", workspace)

	Highlight.FillColor = FillColor
	Highlight.OutlineColor = FillColor
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.OutlineTransparency = 1
	Highlight.FillTransparency = 1
	TweenService:Create(Highlight, TweenInfo.new(Tween), {
		["FillTransparency"] = 0,
		["OutlineTransparency"] = 0
	}):Play()
	Debris:AddItem(Highlight, Time + 0.5)
	task.delay(Time, function()

		TweenService:Create(Highlight, TweenInfo.new(0.5), {
			["FillTransparency"] = 1,
			["OutlineTransparency"] = 1
		}):Play()
	end)
end
--function module.Bleed(MV, Target) 
--         local BloodModule =require(Rep.Modules.BloodyZee)

--		for _, v33 in utils.Damage.Explode:GetDescendants() do
--			if v33:IsA("Attachment") then
--				v33:Clone().Parent =  Target:FindFirstChild(v33.Parent.Name)
--			end
--		end
--		if not Target:GetAttribute("Bleeding") then
--			Target:SetAttribute("Bleeding", true)
--			task.spawn(function()

--				repeat
--					BloodModule:Blood(Target.Torso.CFrame, 50, 180, 180)
--					task.wait(0.1)
--				until not Target.Parent
--			end)
--		end

--end
function module.DomainBurst(MV, Root) 

	local Burst = script.Parent.Parent.Assets.Domains.DomainBurst:Clone()
	Burst.Position = Root.Position
	Burst.Parent = workspace.Effects
	TweenService:Create(Burst, TweenInfo.new(0.3), {
		["Size"] = Vector3.one * 75,
		["Transparency"] = 1
	}):Play()
	Burst.Attachment.Spark:Emit(1)
	Debris:AddItem(Burst, 0.4)
	--MV:PlaySound(Rep.Sounds.Misc.Domain.DomainOpen, Root, game.SoundService.Effect)
end
--local Twenned = { 0.3, 0.7, 0.5 }
--for _, v44 in Rep.Animations:GetDescendants() do
--	if v44.Name == "DomainWarn" then
--		utils.DomainWarn.Panel.Viewport.Display.Humanoid:LoadAnimation(v44)
--	end
--end
function module.ApplyCopyOutfit(Character, WordModels)
	for _, GetAcc in Character:GetChildren() do
		if GetAcc:IsA("Shirt") or GetAcc:IsA("TShirt") or GetAcc:IsA("Pants") or GetAcc:IsA("BodyColors") then
			GetAcc:Clone().Parent = WordModels
		elseif GetAcc:IsA("Accessory") then
			local Clone = GetAcc:Clone()
			Clone.Parent = WordModels
			local Welds = Clone.Handle.AccessoryWeld
			if Welds then
				Welds.Part1 = WordModels:FindFirstChild(Welds.Part1.Name)
				print(Welds.Part1.Name)
			end

		end
	end
	local Face = Character.Head:FindFirstChild("face")
	if Face then
		WordModels.Head.face.Texture = Face.Texture
	end
	if WordModels["Left Arm"]:FindFirstChild("FingersL") then
		for _, v51 in WordModels["Left Arm"].FingersL:GetChildren() do
			if v51:IsA("BasePart") then

				v51.BrickColor = Character["Left Arm"].BrickColor
			end
		end
		for _, v52 in WordModels["Right Arm"].FingersR:GetChildren() do
			if v52:IsA("BasePart") then
				v52.BrickColor = Character["Right Arm"].BrickColor
			end
		end
	end
end
--function module.Domain(M_VLan,Character, RandomFuctions) 

--	local Gui = utils.DomainWarn:Clone()
--    Gui.Parent = Player.PlayerGui
--	local ViewPoert = Gui.Panel.Viewport.Display
--	M_VLan:ApplyCopyOutfit(Character, ViewPoert)
--	RandomFuctions(Gui, ViewPoert)

--	local Camera = Instance.new("Camera", Gui.Panel)
--	Camera.FieldOfView = 40
--	Camera.CFrame = ViewPoert.HumanoidRootPart.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, 3.141592653589793, 0)
--	Gui.Panel.Viewport.CurrentCamera = Camera
--	TweenService:Create(Gui.FlashText, TweenInfo.new(1.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
--		["Size"] = UDim2.new(1.5, 0, 0.43, 0)
--	}):Play()
--	task.delay(0.625, function()
--		TweenService:Create(Gui.FlashText.Text1, TweenInfo.new(0.625), {
--			["TextTransparency"] = 1
--		}):Play()
--		TweenService:Create(Gui.FlashText.Text1.UIStroke, TweenInfo.new(0.625), {
--			["Transparency"] = 1
--		}):Play()
--		TweenService:Create(Gui.FlashText.Text2, TweenInfo.new(0.625), {
--			["TextTransparency"] = 1
--		}):Play()
--		TweenService:Create(Gui.FlashText.Text2.UIStroke, TweenInfo.new(0.625), {
--			["Transparency"] = 1
--		}):Play()
--	end)
--	local v68 = 0
--	for _, v69 in Player.PlayerGui:GetChildren() do
--		if v69.Name == "DomainWarn" then
--			if v69 ~= Gui then
--				v68 = v68 + 1
--			end
--		end
--	end
--	local v70 = UDim2.new(0.5, 0, Twenned[v68 % 3 + 1], 0)
--	for _, v71 in Gui:GetChildren() do
--		TweenService:Create(v71, TweenInfo.new(1.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
--			["Position"] = v70
--		}):Play()
--	end
--	TweenService:Create(Gui.Panel, TweenInfo.new(0.625, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
--		["Size"] = UDim2.new(1.5, 0, 0.4, 0)
--	}):Play()
--	TweenService:Create(Gui.PanelBack, TweenInfo.new(0.625, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
--		["Size"] = UDim2.new(1.5, 0, 0.43, 0)
--	}):Play()
--	task.wait(0.625)
--	TweenService:Create(Gui.Panel, TweenInfo.new(0.625, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
--		["Size"] = UDim2.new(1.5, 0, 0, 0)
--	}):Play()
--	TweenService:Create(Gui.PanelBack, TweenInfo.new(0.625, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
--		["Size"] = UDim2.new(1.5, 0, 0.03, 0)
--	}):Play()

--	Debris:AddItem(Gui, 0.625)
--end

function module.CFix(Position)

	local v85 = Player.Character
	if v85 then
		for _, v86 in v85:GetDescendants() do
			if v86:IsA("BodyPosition") or v86:IsA("AlignPosition") and v86.Mode == Enum.PositionAlignmentMode.OneAttachment then
				v86.Position = v86.Position + Position
			end
		end
	end
end


return module
