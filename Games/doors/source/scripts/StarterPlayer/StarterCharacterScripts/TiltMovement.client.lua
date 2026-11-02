local Ang = CFrame.Angles
local aSin = math.asin
local aTan = math.atan

local Cam = game.Workspace.CurrentCamera

local Player = game.Players.LocalPlayer
local Body = Player.Character or Player.CharacterAdded:Wait()
local Head = Body:WaitForChild("Head")
local Hum = Body:WaitForChild("Humanoid")
local Core = Body:WaitForChild("HumanoidRootPart")
local IsR6 = (Hum.RigType.Value == 0)
local Trso = (IsR6 and Body:WaitForChild("Torso")) or Body:WaitForChild("UpperTorso")
local Neck = (IsR6 and Trso:WaitForChild("Neck")) or Head:WaitForChild("Neck")
local Waist = (not IsR6 and Trso:WaitForChild("Waist"))
local TS = game:GetService("TweenService")

local HeadHorFactor = 6
local HeadVertFactor = 2.6
local BodyHorFactor = 0.4 --0.25
local BodyVertFactor = 0.6 --0.1
local UpdateSpeed = 0.1

local NeckOrgnC0 = Neck.C0
local WaistOrgnC0 = (not IsR6 and Waist.C0)

Neck.MaxVelocity = 1/3

local AnimatePlayerEvent = game.ReplicatedStorage:WaitForChild("AnimatePlayerEvent")
local ReceiveAnimationEvent = Instance.new("RemoteEvent")
ReceiveAnimationEvent.Name = "ReceiveAnimationEvent"
ReceiveAnimationEvent.Parent = script

local sendTimer = 0
local sendInterval = 0.1 

game:GetService("RunService").RenderStepped:Connect(function()
	local CamCF = Cam.CoordinateFrame
	if ((IsR6 and Body:FindFirstChild("Torso")) or Body:FindFirstChild("UpperTorso")) and Body:FindFirstChild("Head") then
		local TrsoLV = Trso.CFrame.lookVector
		local HdPos = Head.CFrame.p
		if IsR6 and Neck or Neck and Waist then
			local Dist, Diff
			Dist = (Head.CFrame.p - CamCF.p).magnitude
			Diff = Head.CFrame.Y - CamCF.Y
			if not IsR6 then
				--Neck.C0 = Neck.C0:lerp(NeckOrgnC0 * Ang((aSin(Diff/Dist) * HeadVertFactor), -(((HdPos - CamCF.p).Unit):Cross(TrsoLV)).Y * HeadHorFactor, 0), UpdateSpeed)
				--Waist.C0 = Waist.C0:lerp(WaistOrgnC0 * Ang((aSin(Diff/Dist) * BodyVertFactor), -(((HdPos - CamCF.p).Unit):Cross(TrsoLV)).Y * BodyHorFactor, 0), UpdateSpeed)
			else
				--Neck.C0 = Neck.C0:lerp(NeckOrgnC0 * Ang(-(aSin(Diff/Dist) * HeadVertFactor), 0, -(((HdPos - CamCF.p).Unit):Cross(TrsoLV)).Y * HeadHorFactor), UpdateSpeed)
			end

			local currentTime = os.clock()
			if currentTime - sendTimer >= sendInterval then
				sendTimer = currentTime

				local animationData = {
					NeckC0 = Neck.C0,
					IsR6 = IsR6
				}

				if not IsR6 then
					animationData.WaistC0 = Waist.C0
				end
				--print("sending out")
				AnimatePlayerEvent:FireServer(animationData)
			end
		end
	end
end)

AnimatePlayerEvent.OnClientEvent:Connect(function(otherPlayer, animationData)
	--print("receiving from " .. (otherPlayer.Name or "Unknown Player"))
	local otherCharacter = otherPlayer.Character
	if otherCharacter then
		local otherBody = otherPlayer.Character or otherPlayer.CharacterAdded:Wait()
		local otherHead = otherCharacter:FindFirstChild("Head")
		local otherTrso = (animationData.IsR6 and otherBody:WaitForChild("Torso")) or otherBody:WaitForChild("UpperTorso")
		local otherNeck = (animationData.IsR6 and otherTrso:FindFirstChild("Neck")) or otherHead and otherHead:FindFirstChild("Neck")
		local otherWaist = (not animationData.IsR6 and otherTrso:WaitForChild("Waist"))

		if otherBody and otherHead and otherTrso and otherNeck then
			if animationData.IsR6 or not (animationData.IsR6 and otherWaist) then
				if not animationData.IsR6 then
					--TS:Create(otherNeck, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {C0 = animationData.NeckC0}):Play()
					TS:Create(otherWaist, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {C0 = animationData.WaistC0}):Play()
				else
					--TS:Create(otherNeck, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {C0 = animationData.NeckC0}):Play()
				end
			end
		end
	end
end)