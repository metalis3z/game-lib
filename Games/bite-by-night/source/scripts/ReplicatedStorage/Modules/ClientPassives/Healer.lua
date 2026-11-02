
local Passive = {}
local Maid = require(game:GetService("ReplicatedStorage").Modules.Maid)

function Passive.Activate()
	local newMaid = Maid.new()
	local playerMedicUIs = {}
	local rateColors = {
		["Good"] = { 73, 194, 65 },
		["Alright"] = { 184, 119, 15 },
		["Bad"] = { 255, 69, 69 }
	}
	local function createMedicUI(char)
		local medicUI = script.MedicHealth:Clone()
		medicUI.Parent = char
		if char:FindFirstChild("Head") then
			medicUI.StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0)
			medicUI.Adornee = char:FindFirstChild("Head")
		end

		local hum = char:FindFirstChildOfClass("Humanoid")

		local rating = rateColors.Good
		if hum.Health / hum.MaxHealth <= 0.33333333 then
			rating = rateColors.Bad
		elseif hum.Health / hum.MaxHealth <= 0.66666666 then
			rating = rateColors.Alright
		end

		medicUI.Holder:FindFirstChild("Icon").ImageColor3 = Color3.fromRGB(rating[1], rating[2], rating[3])
		medicUI.Holder:FindFirstChild("HP").Text = "<font size=\"90\"><font color =\"rgb(" .. rating[1] .. ", " .. rating[2] .. ", " .. rating[3] .. ")\">" .. math.round(hum.Health) .. "<font color=\"rgb(255,255,255)\"><font size =\"100\">/" .. hum.MaxHealth .. "HP</font></font></font></font>"
		medicUI.ShieldHolder:FindFirstChild("HP").Text = "<font color=\"rgb(133, 55, 188)\"><font size =\"100\">" .. char:GetAttribute("Dodges") .. "/" .. 25 .. "</font></font>"

		table.insert(playerMedicUIs, medicUI)

		medicUI.ShieldHolder.Visible = not (char:GetAttribute("Dodges") <= 0) and true or false

		newMaid:Mark(char:GetAttributeChangedSignal("Dodges"):Connect(function()
			rating = rateColors.Good
			if hum.Health / hum.MaxHealth <= 0.33333333 then
				rating = rateColors.Bad
			elseif hum.Health / hum.MaxHealth <= 0.66666666 then
				rating = rateColors.Alright
			end
			medicUI.Holder:FindFirstChild("Icon").ImageColor3 = Color3.fromRGB(rating[1], rating[2], rating[3])
			medicUI.Holder:FindFirstChild("HP").Text = "<font size=\"90\"><font color =\"rgb(" .. rating[1] .. ", " .. rating[2] .. ", " .. rating[3] .. ")\">" .. math.round(hum.Health) .. "<font color=\"rgb(255,255,255)\"><font size =\"100\">/" .. hum.MaxHealth .. "HP</font></font></font></font>"
			medicUI.ShieldHolder:FindFirstChild("HP").Text = "<font color=\"rgb(133, 55, 188)\"><font size =\"100\">" .. char:GetAttribute("Dodges") .. "/" .. 25 .. "</font></font>"
			table.insert(playerMedicUIs, medicUI)
			medicUI.ShieldHolder.Visible = not (char:GetAttribute("Dodges") <= 0) and true or false
		end))

		newMaid:Mark(hum:GetPropertyChangedSignal("Health"):Connect(function()
			medicUI.ShieldHolder.Visible = not (char:GetAttribute("Dodges") <= 0) and true or false
			rating = rateColors.Good
			if hum.Health / hum.MaxHealth <= 0.33333333 then
				rating = rateColors.Bad
			elseif hum.Health / hum.MaxHealth <= 0.66666666 then
				rating = rateColors.Alright
			end
			medicUI.ShieldHolder:FindFirstChild("HP").Text = "<font color=\"rgb(133, 55, 188)\"><font size =\"100\">" .. char:GetAttribute("Dodges") .. "/" .. 25 .. "</font></font>"
			medicUI.Holder:FindFirstChild("Icon").ImageColor3 = Color3.fromRGB(rating[1], rating[2], rating[3])
			medicUI.Holder:FindFirstChild("HP").Text = "<font size=\"90\"><font color =\"rgb(" .. rating[1] .. ", " .. rating[2] .. ", " .. rating[3] .. ")\">" .. math.round(hum.Health) .. "<font color=\"rgb(255,255,255)\"><font size =\"100\">/" .. hum.MaxHealth .. "HP</font></font></font></font>"
		end))
	end

	for _, char in workspace.PLAYERS.ALIVE:GetChildren() do
		if char ~= game:GetService("Players").LocalPlayer.Character then
			createMedicUI(char)
		end
	end

	for _, char in workspace.PLAYERS.KILLER:GetChildren() do
		if char ~= game:GetService("Players").LocalPlayer.Character then
			local medicUI = script.MedicHealth:Clone()
			task.spawn(function()
				if char:WaitForChild("Head", 2) then
					medicUI.StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0)
					medicUI.Adornee = char:WaitForChild("Head", 2)
				end
			end)
			medicUI.Parent = char
			medicUI.Enabled = false
			medicUI:FindFirstChild("Holder"):FindFirstChild("HP").Text = "<font size=\"90\"><font color =\"rgb(73, 194, 65)\">100<font color=\"rgb(255,255,255)\"><font size =\"100\">/100HP</font></font></font></font>"
			task.spawn(function()
				while task.wait(0.5) and char.Parent ~= nil do
					medicUI.Enabled = char:HasTag("Imitation") and true or false
				end
			end)
		end
	end

	newMaid:Mark(workspace.PLAYERS.KILLER.ChildAdded:Connect(function(char)
		local medicUI = script.MedicHealth:Clone()
		task.spawn(function()
			if char:WaitForChild("Head", 2) then
				medicUI.StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0)
				medicUI.Adornee = char:WaitForChild("Head", 2)
			end
		end)
		medicUI.Parent = char
		medicUI.Enabled = false
		medicUI:FindFirstChild("Holder"):FindFirstChild("HP").Text = "<font size=\"90\"><font color =\"rgb(73, 194, 65)\">100<font color=\"rgb(255,255,255)\"><font size =\"100\">/100HP</font></font></font></font>"
		task.spawn(function()
			while task.wait(0.5) and char.Parent ~= nil do
				medicUI.Enabled = char:HasTag("Imitation") and true or false
			end
		end)
	end))

	newMaid:Mark(workspace.PLAYERS.ALIVE.ChildAdded:Connect(function(char)
		if char ~= game:GetService("Players").LocalPlayer.Character then
			createMedicUI(char)
		end
	end))

	newMaid:Mark(game:GetService("Players").LocalPlayer.Character:GetPropertyChangedSignal("Parent"):Connect(function()
		for _, ui in playerMedicUIs do ui:Remove() end
		newMaid:Sweep()
		newMaid:Destroy()
	end))
end
return Passive