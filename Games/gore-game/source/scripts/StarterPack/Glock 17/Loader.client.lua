task.wait(1)

local tool = script.Parent
local unique_id = game:GetService("HttpService"):GenerateGUID(false)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local anims = {
	["equip"] = 10120465973;
	["idle"] = 10120466850;
	["fire"] = 10120467741;
	["reload"] = 10120468485;
}
local settings = {
	["auto"] = false;
	["shotgun"] = {
		["enabled"] = false;
		["amount"] = 8;
		["spreadness"] = 1;
	};
	
	["rate"] = 0.19;
	
	["equip_time"] = 0.65;
	
	["recoil"] = {
		["x"] = {-10, 10};
		["y"] = {35, 40};
		["z"] = {0, 0};
	};
	
	["recoil_back"] = 1.5;
	["recoil_back_threshold"] = 0.8;
	
	["recoil_speed"] = 30;
	["recoil_damp"] = 0.7;
	
	["damage"] = 8;
	["critical"] = 100;
	
	["force"] = 150;
	
	["dismember"] = false;
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