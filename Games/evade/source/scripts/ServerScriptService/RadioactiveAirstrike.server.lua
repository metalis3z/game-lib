local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local UseItem = Net:RemoteEvent("UseItem")

local function makeJetUUID()
	return tostring(math.random(1000000,9999999))
end

UseItem.OnServerEvent:Connect(function(player, position)
	UseItem:FireClient(player, "LockCircle", { Pos = position })
	task.wait(0.5)

	local jetID = makeJetUUID()
	UseItem:FireClient(player, "CreateRadioactivePuddles", {
		MousePosition = position,
		JetUUID = jetID
	})

	task.wait(0.5)

	local bombs = {}
	for i = 1, 3 do
		table.insert(bombs, {
			FinalPos = position + Vector3.new(math.random(-3,3), 0, math.random(-3,3)), -- small spread
			TweenTime = 0.35 + (i-1)*0.1,
			Scale = 4
		})
	end

	UseItem:FireClient(player, "DropBombsAt", {
		FinalPositions = bombs,
		MousePosition = position,
		JetUUID = jetID
	})
end)
