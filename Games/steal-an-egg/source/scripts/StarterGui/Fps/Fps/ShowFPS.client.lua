-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Constants = require(game.ReplicatedStorage:WaitForChild("Library"):WaitForChild("Globals"):WaitForChild("Constants"))

if table.find({ 1065906907, 4035869470, 4742572118, 10735014316 }, game:GetService("Players").LocalPlayer.UserId) and Constants.IS_MOBILE then
	script.Parent.Visible = true

	local t = {}

	game:GetService("RunService").Heartbeat:Connect(function(p1) --[[ Line: 12 | Upvalues: t (copy) ]]
		table.insert(t, (math.floor(1 / p1)))

		local count = 0
		local sum = 0

		for v3, v4 in t do
			count = count + 1
			sum = sum + v4
		end

		if #t > 20 then
			table.remove(t, 1)
		end

		script.Parent.Text = math.floor(sum / count) .. " FPS"
	end)
else
	script.Parent.Visible = false
end