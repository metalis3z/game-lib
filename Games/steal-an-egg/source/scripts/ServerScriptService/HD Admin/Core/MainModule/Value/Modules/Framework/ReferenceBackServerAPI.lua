--!nocheck

-- This takes the place of the loader's ServerAPI after the framework moves the
-- real one into the ServerStorage container
local RunService = game:GetService("RunService")
if RunService:IsClient() then
	error("HD Admin: ServerAPI can only be used on the server. Require Core.ClientAPI from client scripts instead")
end
local ServerStorage = game:GetService("ServerStorage")
local hd = ServerStorage:FindFirstChild("HD Admin")
return require(hd.Core.ServerAPI)
