
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function(context, player, animalName, mutationName)

	local Net = require(ReplicatedStorage.Packages.Net)
	local NewEntry   = Net:RemoteEvent("Liveboard/NewEntry")
	local ClaimEntry = Net:RemoteEvent("Liveboard/ClaimEntry")

	local canonicalMutation = nil
	if mutationName and mutationName:lower() ~= "none" and mutationName ~= "" then
		canonicalMutation = mutationName:match("^%s*(.-)%s*$")
	end

	local canonicalAnimal = animalName:match("^%s*(.-)%s*$")

	local now = workspace:GetServerTimeNow()
	local uid = math.floor(now * 1000)

	NewEntry:FireAllClients({
		UID              = uid,
		BrainrotName     = canonicalAnimal,
		Mutation         = canonicalMutation,
		IsLocalServer    = false,
		Timestamp        = now,
		DisplayDuration  = 120,
		OwnerUserId      = nil,
		OwnerDisplayName = nil,
	})

	ClaimEntry:FireAllClients(uid, player.UserId, player.DisplayName)

	return string.format(
		"Spawned '%s'%s claimed by %s.",
		canonicalAnimal,
		canonicalMutation and (" [" .. canonicalMutation .. "]") or "",
		player.DisplayName
	)
end