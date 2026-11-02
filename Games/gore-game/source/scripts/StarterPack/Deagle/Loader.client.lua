task.wait(1)

local tool = script.Parent
local unique_id = game:GetService("HttpService"):GenerateGUID(false)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local anims = {
	["equip"] = 10120462271;
	["idle"] = 10120463202;
	["fire"] = 10120463923;
	["reload"] = 10120464595;
}
local settings = {
	["auto"] = false;
	["shotgun"] = {
		["enabled"] = false;
		["amount"] = 8;
		["spreadness"] = 2;
	};
	
	["rate"] = 0.22;
	
	["equip_time"] = 0.8;
	
	["recoil"] = {
		["x"] = {-60, 60};
		["y"] = {100, 120};
		["z"] = {0, 0};
	};
	
	["recoil_back"] = 2.5;
	["recoil_back_threshold"] = 0.6;
	
	["recoil_speed"] = 30;
	["recoil_damp"] = 0.7;
	
	["damage"] = 24;
	["critical"] = 100;
	
	["force"] = 150;
	
	["dismember"] = true;
}
Assets.Events.ToolLoader:Fire(tool, "registerGun", {
	["anims"] = anims,
	["settings"] = settings
}, unique_id)

tool.Equipped:Connect(function()
	Assets.Events.ToolLoader:Fire(tool, "anims", "equip", unique_id)
	Assets.Events.ToolLoader:Fire(tool, "anims", "idle", unique_id)
end)

tool.Unequipped:Connect(function()
	Assets.Events.ToolLoader:Fire(tool, "stopAnims", {}, unique_id)
end)