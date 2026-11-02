task.wait(1)

local tool = script.Parent
local unique_id = game:GetService("HttpService"):GenerateGUID(false)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local anims = {
	["equip"] = 10120472452;
	["idle"] = 10120473039;
	["fire"] = 10120473622;
	["reload"] = 10120474315;
}
local settings = {
	["auto"] = true;
	["shotgun"] = {
		["enabled"] = false;
		["amount"] = 8;
		["spreadness"] = 2;
	};
	
	["rate"] = 0.17;
	
	["equip_time"] = 0.8;
	
	["recoil"] = {
		["x"] = {-50, 50};
		["y"] = {35, 45};
		["z"] = {0, 0};
	};
	
	["recoil_back"] = 2;
	["recoil_back_threshold"] = 0.8;
	
	["recoil_speed"] = 40;
	["recoil_damp"] = 0.7;
	
	["damage"] = 12;
	["critical"] = 50;
	
	["force"] = 20;
	
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