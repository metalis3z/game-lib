-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Library.Client.Network)
local Functions = require(ReplicatedStorage.Library.Functions)
local Confetti = require(ReplicatedStorage.Library.Client.GUIFX.Confetti)
local Audio = require(ReplicatedStorage.Library.Audio)
local Message = require(ReplicatedStorage.Library.Client.Message)
local Save = require(ReplicatedStorage.Library.Client.Save)

Network.Fired("Gamepass Bought"):Connect(function(p1) --[[ Line: 9 | Upvalues: Save (copy), Audio (copy), Confetti (copy), Message (copy) ]]
	if Save.Get() then
		Audio.Play("rbxassetid://98002834893313", script, 1, 1)
		Confetti.Play()
		Message.New("Purchase successful! Thank you so much! \240\159\152\132")
	end
end)
function onProductBought(p1, p2, p3) --[[ onProductBought | Line: 21 | Upvalues: Save (copy), Functions (copy), Audio (copy), Confetti (copy), Message (copy) ]]
	if not Save.Get() then
		return
	end

	local v1 = nil
	local v2 = "Purchase successful! Thank you so much! \240\159\152\132"

	if p3 then
		local v3 = Functions.UserIdToUsername(p3)

		if v3 then
			v1 = Functions.GetThumbnailFromUserIdAsync(p3, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
			v2 = ("Gift sent to %*\'s mailbox! Thank you so much! \240\159\152\132"):format(v3)
		end
	end

	task.delay(0.5, function() --[[ Line: 39 | Upvalues: Audio (ref), Confetti (ref), Message (ref), v2 (ref), v1 (ref) ]]
		Audio.Play("rbxassetid://98002834893313", script, 1, 1)
		Confetti.Play()
		Message.New(v2, {
			icon = v1
		})
	end)
end
Network.Fired("Product Bought"):Connect(onProductBought)
Network.Fired("Products: Receipt Processed"):Connect(onProductBought)
Network.Fired("Product Failed"):Connect(function(p1) --[[ Line: 50 | Upvalues: Message (copy) ]]
	task.delay(120, function() --[[ Line: 51 | Upvalues: Message (ref) ]]
		Message.New("ERROR: Purchase failed! If this continues to happen let us know! Roblox should be refunding you automatically. Sorry \240\159\152\138")
	end)
end)

return {}