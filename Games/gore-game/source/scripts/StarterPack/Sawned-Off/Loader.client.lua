task.wait(1)

local tool = script.Parent
local unique_id = game:GetService("HttpService"):GenerateGUID(false)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local anims = {
	["equip"] = 10120469464;
	["idle"] = 10120470303;
	["fire"] = 10120470757;
	["reload"] = 10120471289;
}
local settings = {
	["auto"] = true;
	["shotgun"] = {
		["enabled"] = true;
		["amount"] = 6;
		["spreadness"] = 2;
	};
	
	["rate"] = 0.8;
	
	["equip_time"] = 0.8;
	
	["recoil"] = {
		["x"] = {-100, 100};
		["y"] = {100, 110};
		["z"] = {0, 0};
	};
	
	["recoil_back"] = 1.35;
	["recoil_back_threshold"] = 0.7;
	
	["recoil_speed"] = 12.5;
	["recoil_damp"] = 0.8;
	
	["damage"] = 112;
	["critical"] = 100;
	
	["force"] = 100;
	["forceForward"] = true;
	
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