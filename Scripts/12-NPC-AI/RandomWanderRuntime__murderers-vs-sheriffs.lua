-- Reference copy for study. Game: murderers-vs-sheriffs
-- Original: ServerStorage/Database/Maps/ResearchFacility/Interactive/CloningSystem/InteractiveBox/InteractiveScript/AIModule.lua  (ModuleScript, 55 lines)
-- What it does: Tiny module that registers rigs and, every 5 seconds per rig, MoveTo's a random point 10-20 studs away; one Heartbeat connection per rig with Disconnect / DisconnectAll.

local RunService = game:GetService("RunService")
local module = {}
local currentRigs = {}

function module:AddRig(rig)
	if currentRigs[rig] then return end
	
	currentRigs[rig] = {
		Current = RunService.Heartbeat:Connect(function(deltaTime)
			currentRigs[rig].elapsed += deltaTime

			if currentRigs[rig].elapsed > 5 then
				currentRigs[rig].elapsed = 0 

				task.spawn(function()
					local primaryPart = rig.PrimaryPart
					local humanoid = rig:FindFirstChildOfClass("Humanoid")

					if humanoid and primaryPart then
						local angle = math.random() * 2 * math.pi
						local distance = math.random(10, 20)
						local direction = Vector3.new(math.cos(angle), 0, math.sin(angle)) * distance

						local targetPosition = primaryPart.Position + direction
						humanoid:MoveTo(targetPosition)
						humanoid.MoveToFinished:Wait()
					end
					humanoid.Died:Connect(function()
						module:Disconnect(rig)
					end)
				end)
			end
		end),
		
		elapsed = 0
	}
end

function module:Disconnect(rig)
	if currentRigs[rig] then
		currentRigs[rig].Current:Disconnect()
		currentRigs[rig] = nil
	else
		warn("There is not rig in the AI Runtime")
	end
end

function module:DisconnectAll()
	for rig in pairs(currentRigs) do
		currentRigs[rig].Current:Disconnect()
		currentRigs[rig] = nil
	end
end

return module
