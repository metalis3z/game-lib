script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	if not plr.PlayerGui:FindFirstChild("AdvanceToolGiver") then
		local GUI = script.AdvanceToolGiver:Clone()
		GUI.Parent = plr.PlayerGui
		GUI.Frame.Frame.ScrollingFrame.Name = plr.Name

		plr.CameraMinZoomDistance = 5
		wait()
		plr.CameraMinZoomDistance = 0.5
		
		local Folder = Instance.new("ObjectValue")
		Folder.Value = script.Parent.Parent.TOOLS
		Folder.Parent = GUI
		Folder.Name = "Folder"

		for i,v in pairs(GUI:GetDescendants()) do
			if v.Name == "Script" then
				v.Disabled = false
			end
		end
	end
end) 

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

local Folder = Instance.new("Folder")
Folder.Parent = game.ReplicatedStorage
Folder.Name = "SCP-988"
local ToolsNumbers = 1

for i,v in pairs(script.Parent.Parent.TOOLS:GetChildren()) do
	v.Parent = Folder
	ToolsNumbers = i
end

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

while wait(script.Parent.Parent.CoolDown.Value) do
	script.Parent.Parent.TOOLS:ClearAllChildren()
	
	local Loots = math.random(1,script.Parent.Parent.MaxLoot.Value)
	local LootFolder = Folder:GetChildren()

	for i = 1,Loots do
		local ItemNumber = math.random(1,ToolsNumbers)
		local Item = LootFolder[ItemNumber]
		local ItemReference = Instance.new("ObjectValue")
		ItemReference.Value = Item 
		ItemReference.Parent = script.Parent.Parent.TOOLS
		ItemReference.Name = Item.Name
	end
	
	script.Parent.Parent.Update.Value = true
	wait(2)
	script.Parent.Parent.Update.Value = false
end