local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")

local remote = ReplicatedStorage:WaitForChild("ShowCountdown")

local ITEM_NAME = "ItemToSpawn"
local OBJECT_TIME = 20 -- tiempo que el objeto existe
local COUNTDOWN_TIME = 20 -- tiempo del contador
local spawnPosition = Vector3.new(-2.695, -1, 67.133)

while true do
	-- SPAWN DEL OBJETO
	local clone
	local item = ServerStorage:FindFirstChild(ITEM_NAME)

	if item then
		clone = item:Clone()
		clone.Parent = Workspace

		if clone:IsA("Model") then
			clone:PivotTo(CFrame.new(spawnPosition))
		else
			clone.Position = spawnPosition
		end
	end

	-- OBJETO EXISTE 20 SEGUNDOS
	task.wait(OBJECT_TIME)

	-- DESAPARECER OBJETO
	if clone and clone.Parent then
		clone:Destroy()
	end

	-- CONTADOR EN PANTALLA (20 → 1)
	for i = COUNTDOWN_TIME, 1, -1 do
		remote:FireAllClients(i)
		task.wait(1)
	end
end
