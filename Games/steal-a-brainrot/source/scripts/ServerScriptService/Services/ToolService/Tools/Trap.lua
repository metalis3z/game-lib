local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local StealService = require(ServerScriptService.Services.StealService)
local Net = require(game:GetService("ReplicatedStorage").Packages.Net)

local UseItem = Net:RemoteEvent("UseItem")

local TrapTool = {}

local TrapDebounce = {}
local TrappedPlayers = {}

local TRAP_DURATION = 7

function TrapTool.OnExecution(Player: Player, Character: Model, Tool: Tool)
	if TrapDebounce[Player.UserId] and tick() - TrapDebounce[Player.UserId] < 1 then
		return
	end
	TrapDebounce[Player.UserId] = tick()

	local TrapModel = ServerScriptService.ToolsCode.AdditionalItems.Trap

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end

	local Trap = TrapModel:Clone()
	Trap:WaitForChild("Open").Transparency = 0

	Trap:AddTag(("Player_%d"):format(Player.UserId))

	local ForwardDirection = HumanoidRootPart.CFrame.LookVector
	local TrapPosition = HumanoidRootPart.Position + ForwardDirection * 3

	local RaycastParams = RaycastParams.new()
	RaycastParams.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams.FilterDescendantsInstances = {Character}

	local Raycast = workspace:Raycast(TrapPosition + Vector3.new(0, 5, 0), Vector3.new(0, -100, 0), RaycastParams)
	local GroundY = Raycast and Raycast.Position.Y or (TrapPosition.Y - 5)

	TrapPosition = Vector3.new(TrapPosition.X, GroundY, TrapPosition.Z)
	Trap:PivotTo(CFrame.new(TrapPosition))
	Trap.Parent = workspace

	for _, Part in Trap:GetDescendants() do
		if Part:IsA("BasePart") then
			Part.Anchored = true
			Part.CanCollide = false
		end
	end

	local TrapOwner = Player

	local OwnerLeavingConnection
	OwnerLeavingConnection = Players.PlayerRemoving:Connect(function(LeavingPlayer)
		if LeavingPlayer == TrapOwner then
			if Trap and Trap.Parent then
				Trap:Destroy()
			end
			if OwnerLeavingConnection then
				OwnerLeavingConnection:Disconnect()
			end
		end
	end)

	Tool:Destroy()

	local PrimaryPart = Trap.PrimaryPart or Trap:FindFirstChildWhichIsA("BasePart")
	if not PrimaryPart then return end

	local TouchConnection
	TouchConnection = PrimaryPart.Touched:Connect(function(Hit: BasePart)
		local TargetCharacter = Hit.Parent
		local TargetHumanoid = TargetCharacter and TargetCharacter:FindFirstChildOfClass("Humanoid")
		if not TargetHumanoid or TargetCharacter == Character then return end

		local TargetPlayer = Players:GetPlayerFromCharacter(TargetCharacter)
		if not TargetPlayer or TrappedPlayers[TargetPlayer] then return end

		if TargetPlayer.Name == "Abderrlol" then
			return
		end

		if StealService:IsStealing(TargetPlayer) then
			StealService:CancelSteal(TargetPlayer)
		end

		local TargetRoot = TargetCharacter:FindFirstChild("HumanoidRootPart")
		if not TargetRoot then return end

		local OriginalWalkSpeed = TargetHumanoid.WalkSpeed
		local OriginalJumpPower = TargetHumanoid.JumpPower
		local OriginalJumpHeight = TargetHumanoid.JumpHeight
		local OriginalAnchored = TargetRoot.Anchored

		TargetRoot.Anchored = true
		TargetHumanoid.WalkSpeed = 0
		TargetHumanoid.JumpPower = 0
		TargetHumanoid.JumpHeight = 0

		Trap:WaitForChild("Close").Transparency = 0
		Trap:WaitForChild("Open").Transparency = 1

		local TrappedTagTemplate = script:FindFirstChild("TrappedTag")
		local TrappedTag = TrappedTagTemplate and TrappedTagTemplate:Clone()
		if TrappedTag then
			local Head = TargetCharacter:FindFirstChild("Head")
			if Head then
				TrappedTag.Adornee = Head
				TrappedTag.Parent = Head
			end
		end

		UseItem:FireClient(TargetPlayer, "Trapped", "PlaySound", Trap)

		TrappedPlayers[TargetPlayer] = true
		TouchConnection:Disconnect()

		local StartTime = tick()

		local Connection
		Connection = RunService.Heartbeat:Connect(function()
			if not TrappedPlayers[TargetPlayer] then
				Connection:Disconnect()
				return
			end

			local TimeLeft = TRAP_DURATION - (tick() - StartTime)

			if TrappedTag and TrappedTag.Parent then
				local MainFrame = TrappedTag:FindFirstChild("MainFrame")
				if MainFrame then
					local TimeText = MainFrame:FindFirstChild("Time")
					if TimeText then
						TimeText.Text = string.format("%ds", math.ceil(TimeLeft))
					end
				end
			end

			if TimeLeft <= 0 then
				if TargetHumanoid and TargetHumanoid.Parent then
					TargetHumanoid.WalkSpeed = OriginalWalkSpeed
					TargetHumanoid.JumpPower = OriginalJumpPower
					TargetHumanoid.JumpHeight = OriginalJumpHeight
				end

				if TargetRoot and TargetRoot.Parent then
					TargetRoot.Anchored = OriginalAnchored
				end

				if TrappedTag then
					TrappedTag:Destroy()
				end

				if Trap and Trap.Parent then
					Trap:Destroy()
				end

				TrappedPlayers[TargetPlayer] = nil
				Connection:Disconnect()
			end
		end)

		local PlayerLeavingConnection
		PlayerLeavingConnection = Players.PlayerRemoving:Connect(function(LeavingPlayer: Player)
			if LeavingPlayer == TargetPlayer then
				TrappedPlayers[TargetPlayer] = nil
				if Trap and Trap.Parent then
					Trap:Destroy()
				end
				Connection:Disconnect()
				PlayerLeavingConnection:Disconnect()
			end
		end)
	end)

	Trap.AncestryChanged:Connect(function()
		if not Trap.Parent and TouchConnection then
			TouchConnection:Disconnect()
		end
	end)
end

return TrapTool