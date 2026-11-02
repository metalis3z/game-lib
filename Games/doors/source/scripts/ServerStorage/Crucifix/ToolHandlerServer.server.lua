local module = require(game.ServerScriptService.Game.Directory.ItemsAttributes)
--local v5 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));

local Custom = {
	EternityDurability = 45,
	EternityDurabilityMax = 90,
	Interactable = true,
	ToolOffset = Vector3.new(0, 0, 0)
}

if module[script.Parent.Name] then

	if module[script.Parent.Name].CanUsing == true then
		script.Parent:SetAttribute("Enabled", false)
	end

	for v7, v8 in pairs(module) do

		if not script.Parent:GetAttribute("EternityDurability") then
			if module[script.Parent.Name].EternityDurability then
				script.Parent:SetAttribute("EternityDurability", module[script.Parent.Name].EternityDurability or Custom.EternityDurability)
			end
		end

		if not script.Parent:GetAttribute("EternityDurabilityMax") then
			if module[script.Parent.Name].EternityDurabilityMax then
				script.Parent:SetAttribute("EternityDurabilityMax", module[script.Parent.Name].EternityDurabilityMax or Custom.EternityDurabilityMax)
			end
		end

		if not script.Parent:GetAttribute("Interactable") then
			if module[script.Parent.Name].Interactable then
				script.Parent:SetAttribute("Interactable", module[script.Parent.Name].Interactable or Custom.Interactable)
			end
		end

		if not script.Parent:GetAttribute("ToolOffset") then
			if module[script.Parent.Name].ToolOffset then
				script.Parent:SetAttribute("ToolOffset", module[script.Parent.Name].ToolOffset or Custom.ToolOffset)
			end
		end
	end
end