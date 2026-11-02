-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminEntryVisibility = require(ReplicatedStorage.Library.Client.AdminEntryVisibility)
local v1 = require(ReplicatedStorage.Library.Client.GUI).PlayerGui()

local function bindAdminPanelEntry(p1) --[[ bindAdminPanelEntry | Line: 25 | Upvalues: AdminEntryVisibility (copy) ]]
	if p1.Name == "AdminPanel" then
		assert(p1:IsA("ScreenGui"), "PlayerGui.AdminPanel must be a ScreenGui")

		local Toggle = p1.Toggle

		assert(Toggle:IsA("TextButton"), "PlayerGui.AdminPanel.Toggle must be a TextButton")
		Toggle.Visible = AdminEntryVisibility.IsAdminPanelVisible()
		AdminEntryVisibility.Changed:Connect(function(p1) --[[ Line: 33 | Upvalues: Toggle (copy) ]]
			if Toggle.Parent == nil then
				return
			end

			Toggle.Visible = p1
		end)
	end
end

for v2, v3 in v1:GetChildren() do
	bindAdminPanelEntry(v3)
end

v1.ChildAdded:Connect(bindAdminPanelEntry)