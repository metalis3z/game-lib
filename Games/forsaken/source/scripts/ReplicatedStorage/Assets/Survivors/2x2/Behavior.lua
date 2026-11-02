local module = {};
local Util = require(game.ReplicatedStorage.Modules.Util);
local Statuses = require(game.ReplicatedStorage.Modules.Statuses);
local Network = require(game.ReplicatedStorage.Modules.Network);
local Sounds = require(game.ReplicatedStorage.Modules.Sounds);
local AchievementUtil = require(game.ReplicatedStorage.Modules.AchievementUtil);
local ActorsModule = require(game.ReplicatedStorage.Modules.Actors)
local ServerMoveset

local RunService = game:GetService("RunService")

if RunService:IsServer() then
	ServerMoveset = require(game.ServerStorage.Modules.Characters.Survivors["2x2"].Movesets)
end

local Params = RaycastParams.new();
Params.FilterType = Enum.RaycastFilterType.Exclude;
Params.FilterDescendantsInstances = {
	workspace.Players
}

function checkPlacement(v24, v27,wall)
	local Params2 = OverlapParams.new()
	Params2.FilterType = Enum.RaycastFilterType.Exclude
	Params2.FilterDescendantsInstances = {
		workspace.Players, wall
	}
	local RayParams = RaycastParams.new()
	RayParams.FilterType = Enum.RaycastFilterType.Exclude
	RayParams.FilterDescendantsInstances = {workspace.Players, wall}
	local Parts = workspace:GetPartBoundsInRadius(v27.Position, 0.75, Params2)
	for _, v in pairs(Parts) do
		if v.Transparency < 0.9 or v.Name == "UnplacableArea" then
			return "collision"
		end
	end
	for _, v in pairs(workspace.Players.Survivors:GetChildren()) do
		local l_v36_Attribute_0 = v:GetAttribute("PlacementRadius")
		local l_PrimaryPart_0 = v.PrimaryPart
		if v ~= v24.Rig and l_v36_Attribute_0 and l_PrimaryPart_0 and (v27.Position - l_PrimaryPart_0.Position).Magnitude <= l_v36_Attribute_0 / 2 then
			return "tooClose"
		end
	end
	local Ray = workspace:Raycast(v27.Position, Vector3.new(0, -4, 0, 0), RayParams)
	if not Ray then
		return "midair"
	elseif Ray and Ray.Instance.Name == "Conveyor" then
		return "collision"
	elseif workspace:Raycast(v24.Rig.PrimaryPart.Position, v24.Rig.PrimaryPart.CFrame.LookVector * 5, RayParams) then
		return "facingWall"
	else
		return "placeable"
	end
end

local function ClientWallConstruction(self, Status, bool)
	if typeof(Status) == "table" and Status.Cancelled then
		local v82 = {
			collision = "Building area is obstructed by something. Build somewhere else.", 
			tooClose = "Building area is too close to a pre-existing building. Move further away and try again.", 
			midair = "Building area is too high above ground. Turn around and try again.", 
			facingWall = "You're too close to a wall. Turn around and try again.", 
			unknown = "Something went wrong. Try building somewhere else."
		}
		local v83 = v82[Status.Reason] or v82.unknown
		Util:CreateWarning("BuildermanWarning", v83, self.Config.WarningTemplate)
		bool = false
	elseif Status == "placed" then
		if self.Animations.F3X then
			self.Animations.F3X:Play()
		end
		local l_v2_SpeedMultiplier_0 = Util:CreateSpeedMultiplier(self.Rig, 0, "WallConstruction")
		local v87 = self.Rig:WaitForChild("Result", 4.5)
		v87 = v87 and v87.Value or "IDK"
		game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Value = 1
		}):Play()
		game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1)
	end
	if bool == nil then
		bool = true
	end
	if bool then
		if self.CWall then
			self.CWall:Destroy()
			self.CWall = nil
			self.BuildConnection:Disconnect()
			self.BuildConnection = nil
		end
		local Wall = self.Config["WallTemplate"]:Clone()
		Wall.Parent = workspace.Misc
		self.CWall = Wall
		Network:FireConnection("DisableSprinting", "2x2BuildMode", true)
		local Highlight = Instance.new("Highlight")
		Highlight.FillColor = Color3.fromRGB(255,255,255)
		Highlight.OutlineTransparency = 0
		Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		Highlight.Parent = Wall
		if Wall then
			self.BuildConnection = RunService.RenderStepped:Connect(function()
				if not self.Rig.PrimaryPart or not self.Rig.PrimaryPart.CFrame then 
					Network:FireConnection("DisableSprinting", "2x2BuildMode", false)
					self.CWall:Destroy()
					self.CWall = nil
					self.BuildConnection:Disconnect()
					self.BuildConnection = nil
					return
				end
				local v66 = self.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -5)
				local v67 = RaycastParams.new()
				v67.FilterType = Enum.RaycastFilterType.Exclude
				v67.FilterDescendantsInstances = {
					workspace.Players, Wall
				}
				local v68 = workspace:Raycast(v66.Position, Vector3.new(0, -100, 0), v67)
				local v69 = v68 and v68.Position + Vector3.new(0, Wall.PrimaryPart.Size.Y / 2, 0) or (v66 - Vector3.new(0, 1.5, 0)).Position
				Wall:SetPrimaryPartCFrame(CFrame.new(v69) * v66.Rotation)
				local status = checkPlacement(self, v66, Wall)
				if status == "placeable" then
					Highlight.FillColor = Color3.fromRGB(0,255,0)
				else
					Highlight.FillColor = Color3.fromRGB(255,0,0)
				end
			end)
		end
	elseif not bool then
		Network:FireConnection("DisableSprinting", "2x2BuildMode", false)
		self.CWall:Destroy()
		self.CWall = nil
		self.BuildConnection:Disconnect()
		self.BuildConnection = nil
	end
end

module.Abilities = {
	F3X = {
		LayoutOrder = 1, 
		KeybindType = "AltAbility1", 
		Icon = "rbxassetid://119339667794819", 
		Callback = function(self,Status)
			if RunService:IsServer() then
				local t = "No serverside?"
				return ServerMoveset.F3X(self, Status)
			elseif game["Run Service"]:IsClient() then
				return ClientWallConstruction(self,Status, self.Rig:GetAttribute("Building"))
			end;
		end
	}, 
	LUA = {
		LayoutOrder = 2, 
		KeybindType = "AltAbility2", 
		Icon = "rbxassetid://120565969647024", 
		Callback = function(self)
			if RunService:IsServer() then
				local t = "No serverside?"
				ServerMoveset.LUA(self)
			elseif game["Run Service"]:IsClient() then
				if self.Animations.Lua then
					self.Animations.Lua:Play()
				end
				if self.Rig:FindFirstChild("Paper") and self.Rig:FindFirstChild("Paper"):FindFirstChild("code") then
					self.Rig:FindFirstChild("Paper"):FindFirstChild("code").img.ImageTransparency = 1
					task.delay(0.75, function()
						game:GetService("TweenService"):Create(self.Rig:FindFirstChild("Paper"):FindFirstChild("code").img, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							ImageTransparency = 0
						}):Play()
					end)
					task.delay(2.05, function()
						self.Rig:FindFirstChild("Paper"):FindFirstChild("code").img.ImageTransparency = 1
					end)
				end
				Network:FireConnection("DisableSprinting", "LUA", true)
				local l_v2_SpeedMultiplier_0 = Util:CreateSpeedMultiplier(self.Rig, 0.5, "LUA",2.5,true);
				task.wait(2.5)
				Network:FireConnection("DisableSprinting", "LUA", false)
			end;
		end
	},
	Highlight = {
		LayoutOrder = 3, 
		KeybindType = "AltAbility3", 
		Icon = "rbxassetid://91098605189229", 
		Callback = function(self)
			if RunService:IsServer() then
				local t = "No serverside?"
				ServerMoveset.Highlight(self)
			elseif game["Run Service"]:IsClient() then
				if self.Animations.Highlight then
					self.Animations.Highlight:Play()
				end
				
				local l_v2_SpeedMultiplier_2 = Util:CreateSpeedMultiplier(self.Player, 1, "404Error");
				local l_v2_FOVMultiplier_0 = Util:CreateFOVMultiplier(self.Player, 1, "404Error");
				game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.5), {
					Value = 0.5
				}):Play();
				game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
					Value = 0.75
				}):Play();
				Network:FireConnection("DisableSprinting", "2x2Highlight", true);
				task.delay(0.75, function()
					Network:FireConnection("DisableSprinting", "2x2Highlight", false);
					game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.6), {
						Value = 1
					}):Play();
					game.Debris:AddItem(l_v2_SpeedMultiplier_2, 0.4);
					game.Debris:AddItem(l_v2_FOVMultiplier_0, 2);
				end);
			end
		end,
	}
};
module.Created = function(_, self)
	if RunService:IsServer() then
		ServerMoveset.Created(self)
	elseif RunService:IsClient() then
		self.ClientHealthConnection = self.Rig.Humanoid.HealthChanged:Connect(function()
			if self.CWall and self.BuildConnection then
				Network:FireConnection("DisableSprinting", "2x2BuildMode", false)
				self.CWall:Destroy()
				self.CWall = nil
				self.BuildConnection:Disconnect()
				self.BuildConnection = nil
			end
		end)
	end
end
module.Destroyed = function(_, self)
	if RunService:IsServer() then
		self.HealthConnection:Disconnect()
		self.HealthConnection = nil
	elseif RunService:IsClient() then
		self.ClientHealthConnection:Disconnect()
		self.ClientHealthConnection = nil
	end
end
return module;