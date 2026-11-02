local t = {}
local LocalPlayer = game.Players.LocalPlayer
local CollectionService = game.CollectionService

function t.New(p1, p2) --[[ New | Line: 5 | Upvalues: LocalPlayer (copy), CollectionService (copy) ]]
	local v2 = p2 or p1.Board:WaitForChild("Attachment"):WaitForChild("UI")

	if v2:IsA("ObjectValue") then
		return
	end

	v2.Adornee = v2.Parent

	local Button = v2.Button

	v2.Parent = LocalPlayer.PlayerGui

	local UI = Instance.new("ObjectValue")

	UI.Name = "UI"
	UI.Parent = v2.Adornee
	UI.Value = v2
	v2:GetPropertyChangedSignal("Adornee"):Connect(function() --[[ Line: 18 | Upvalues: v2 (ref) ]]
		if v2.Adornee ~= nil then
			return
		end

		v2:Destroy()
	end)
	CollectionService:AddTag(v2.Adornee.Parent, "BillboardButton")

	return Button
end

return t