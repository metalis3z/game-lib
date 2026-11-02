--// linting for cyclic modules
local require = require

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Initializer = require(ReplicatedStorage.Initializer)

local Network = Initializer.Modules.Network
local Util = Initializer.Modules.Util

local Actors = require(ReplicatedStorage.Modules.Actors)

--// simplified pcall wrapper to prevent Luau from halting execution when an error occurs
local safeCall = require(ServerScriptService.Server.Modules.ServerUtil).SafeCall

local CharacterReplication = {
	Client = require(ReplicatedStorage.Systems.Player.Game.CharacterReplication),
	PlayerData = {},
	QueryHitboxType = "Pivot",
	ServerUPS = 0
}

--// handles incoming serialized data from a player and updates their actor’s position, velocity, and stored serialized state
CharacterReplication.Received = function(Player, SerializedData)
	local Actor = Actors.CurrentActors[Player]

	--// safety & validity checks
	--// note: IsAlive and Ragdolling checks are not needed cuz of char rep on client already handling that
	if not (Actor and workspace:GetAttribute("ExperimentalReplication") and Player and Player.Character and CollectionService:HasTag(Player.Character, "Replicating")) then
		return
	end

	--// deserialize the client's character data (position, velocity, etc.)
	local ClientCFrame, ClientVector = CharacterReplication.Client.Deserialize(SerializedData)
	Actor.ClientCF = ClientCFrame
	Actor.ClientV = ClientVector

	--// can you forsaken devs use os.clock or time please, not this shit
	Actor.LastClientCFUpdateTime = tick()

	--// define the replication data for the player if it doesn't exist
	if not CharacterReplication.PlayerData[Player.UserId] then
		CharacterReplication.PlayerData[Player.UserId] = { SerializedData = nil } :: { [any]: any }
	end

	--// data that gets sent to the server to replicate to other clients
	CharacterReplication.PlayerData[Player.UserId].SerializedData = SerializedData
end

--// character replication initializer for actors
function CharacterReplication:Replication(ActorInfo)
	--// check if actor exists and if so set this to the actor's rig
	local Rig = ActorInfo and ActorInfo.Rig

	return {
		Cleanup = function(): (boolean)
			--// check if the rig exists and if it's a valid rig
			if not (Rig and Rig:IsA("Model")) then
				return false
			end

			--// stops replication from actually updating
			CollectionService:RemoveTag(Rig, "Replicating")

			local Player = Players:GetPlayerFromCharacter(Rig) :: Player?

			if Player then
				local UserId = Player.UserId

				if self.PlayerData[UserId] then
					table.clear(self.PlayerData[Player.UserId])
				end
			end

			return true
		end,
		Setup = function(): (boolean)
			--// check if the rig exists, if it's a valid rig and if it's replicatable
			if not (Rig and Rig:IsA("Model") and Rig.PrimaryPart and Rig:HasTag("Replicating")) then
				return false
			end

			local Player = Players:GetPlayerFromCharacter(Rig)

			if not Player then
				--// stuff like brimstone will yield the character for a bit and stay in place forever so we gotta do this
				for _ = 1, 100 * (self.ServerUPS or 10), 1 do
					if Player then break end

					task.wait()

					Player = Players:GetPlayerFromCharacter(Rig)
				end
			end

			--// check if the player exists
			if Player ~= nil and Player:IsA("Player") then
				--// get actor type e.g. Killer or Survivor
				local ActorType = ActorInfo and ActorInfo.ActorType or "Survivor"

				--// replicating server hitbox
				local QueryHitbox = Rig:FindFirstChild("QueryHitbox")

				--// check if the query hitbox exists
				if not QueryHitbox then
					--// if it doesn't exist, wait for it
					QueryHitbox = Rig:WaitForChild("QueryHitbox", 5)

					--// check if the query hitbox exists
					--// if this fails they will be stuck in place on all clients pov
					if not QueryHitbox then
						return false
					end
				end

				--// if you don't exist it's over
				if not self.PlayerData[Player.UserId] then
					self.PlayerData[Player.UserId] = { SerializedData = nil } :: { [any]: any }
				end

				--// server upstream
				local LocalServerUPS = 30

				if ActorInfo then
					if ActorType == "Killer" then
						LocalServerUPS = self.ServerUPS
					elseif ActorType == "Survivor" then
						LocalServerUPS = self.ServerUPS
					end
				end

				--// set the rigs server upstream to the local server upstream
				--Rig:SetAttribute("ServerUPS", LocalServerUPS)

				return true
			end

			return false
		end
	}
end

--// broadcast all the positions of each actor to the client
function CharacterReplication:BroadcastPositions(DeltaTime: number)
	--// loop through all active actors
	for Player, ActorInfo in Actors.CurrentActors do
		local ActorRig = ActorInfo.Rig

		--// check if it's a valid rig and if it's replicatable
		if ActorRig and CollectionService:HasTag(ActorRig, "Replicating") then
			local UserId = Player.UserId

			--// check if data & the primarypart exists
			if self.PlayerData[UserId] and ActorRig.PrimaryPart then
				--// get the current cframe and velocity
				local CurrentCFrame = ActorRig.PrimaryPart.CFrame
				local Velocity = ActorRig.PrimaryPart.Velocity

				--// serialize the data
				local SerializedData = self.Client.Serialize(CurrentCFrame, Velocity)

				--// set the servers current cframe
				ActorInfo.ServerCurrentCF = CurrentCFrame

				--// check if the data exists for the player
				if not self.PlayerData[UserId] then
					--// if it doesn't exist, set it
					self.PlayerData[UserId] = { SerializedData = SerializedData }
				else
					--// if it does exist, set it anyways
					self.PlayerData[UserId].SerializedData = SerializedData
				end

				--// use safeCall instead of pcall for simplicity
				local Success, Result = safeCall(function()
					local Rig = ActorInfo.Rig

					local QueryHitbox = Rig and Rig:FindFirstChild("QueryHitbox")

					--// check if the query hitbox exists
					--// if it doesn't exist, wait for it for x amount of time in seconds
					if not QueryHitbox then
						QueryHitbox = Rig and Rig:WaitForChild("QueryHitbox", 5)
					end

					--// safety checks
					if QueryHitbox and (QueryHitbox.Name == "QueryHitbox" and QueryHitbox:IsA("BasePart")) and (QueryHitbox.Parent:HasTag("Replicating")) and (QueryHitbox.Parent:IsA("Model") or not QueryHitbox.Parent.PrimaryPart) then
						if QueryHitbox.Anchored ~= true then
							QueryHitbox.Anchored = true
						end

						local Predicted : CFrame = (if self.QueryHitboxType == "Pivot" then ActorInfo:GetPivot((((Rig.PrimaryPart.Position) - (QueryHitbox.Position)).Magnitude - 0.25) >= 0.05 and Rig.PrimaryPart.Anchored == false and not Player.Character:GetAttribute("Ragdolling") and Player.Character:FindFirstChildOfClass("Humanoid") and Player.Character:FindFirstChildOfClass("Humanoid").Health > 0) else ActorInfo.Rig.PrimaryPart.CFrame) * (QueryHitbox:GetAttribute("CFOffset") or CFrame.new(0, 0, 0))

						local CurrentCF = QueryHitbox.CFrame
						local Distance = (Predicted.Position - CurrentCF.Position).Magnitude

						if Distance < math.clamp(Rig.PrimaryPart.AssemblyLinearVelocity.Magnitude*math.clamp(1+4*(game["Run Service"]:IsStudio() and 0.1 or Player:GetNetworkPing()), 1, 2), 10, math.huge) then
							local Alpha = math.clamp(1 - 0.000000001 ^ DeltaTime, 0, 1) --math.clamp(1-(game["Run Service"]:IsStudio() and 0.1 or Player:GetNetworkPing())*2, 0, 1)
							local LerpCFrame = (((Rig.PrimaryPart.Anchored or Distance > 7) and Predicted) or CFrame.new(Predicted.Position:Lerp(Rig.PrimaryPart.Position, Alpha)) * Predicted.Rotation:Lerp(Rig.PrimaryPart.CFrame.Rotation, Alpha))
							QueryHitbox.Color = Color3.fromRGB(90, 140, 165)
							QueryHitbox.CFrame = LerpCFrame	
						else
							QueryHitbox.Color = Color3.fromRGB(165, 71, 71)
							QueryHitbox.CFrame = CurrentCFrame
						end
					end
				end)
			end
		end
	end

	--local SerializedData = {}

	--// loop through the data and add the players serialized data to the list
	--for UserId, PlayerData in self.PlayerData do
	--	SerializedData[UserId] = PlayerData.SerializedData
	--end

	--// update the server cframes to all the clients active in-game
	--Network:FireAllClientConnection(
	--	"UpdCF",
	--	"UREMOTE_EVENT",
	--	SerializedData
	--)
end

--// initialize the whole damn script so it actually does something
function CharacterReplication:Start()
	--// start the server loop for character replication
	RunService.Heartbeat:Connect(function(DeltaTime: number)
		--// update the server upstream
		self.ServerUPS = 1 / DeltaTime

		--// check if the server is using the experimental replication
		--// if it isn't, it will not continue attempting replication
		--// but will still run in the background for live-updates
		--// if it should continue or not
		if not workspace:GetAttribute("ExperimentalReplication") then
			return
		end

		--// broadcast the positions from server to client
		self:BroadcastPositions(DeltaTime)
	end)

	--// handle the replication
	local function Replication(_Instance, Type: string)
		--// get the player from the instance
		local Player = Players:GetPlayerFromCharacter(_Instance)

		--// if it's not a valid player, don't continue
		--// and tell the function caller it failed
		if not Player then return false, "Player" end

		--// get the actor info
		local ActorInfo = Actors.CurrentActors[Player]

		--// replication setup
		local Replica = self:Replication(ActorInfo)[Type]

		--// validity checks
		--// if these checks fail, don't continue
		--// and tell the function caller it failed
		if not ActorInfo then return false, "Actor" end
		if not Replica then return false, "Type" end

		--// setup the replication
		Replica()

		--// tell the function caller it succeeded
		return true, "Replicated"
	end

	--// if something with the tag Replicating gets added attempt to initialize replication
	--// note: the variable names are unused but i felt like defining them anyways
	CollectionService:GetInstanceAddedSignal("Replicating"):Connect(function(_Instance)
		local Success, Result = Replication(_Instance, "Setup")
	end)
	CollectionService:GetInstanceRemovedSignal("Replicating"):Connect(function(_Instance)
		local Success, Result = Replication(_Instance, "Cleanup")
	end)

	--// if the player leaves, clean up their data on the server
	Players.PlayerRemoving:Connect(function(Player)
		if self.PlayerData[Player.UserId] then
			self.PlayerData[Player.UserId] = nil
		end
	end)
end

--// type checking stuff to make things easier to understand and access
export type CharacterReplication = typeof(CharacterReplication)

return CharacterReplication

--// note: this is unofficial code, reprogrammed by kuro.core & forleaken <3