local Server = {}
local SS = script
local Server = {}
for _, child in ipairs(SS:GetChildren()) do
if child:IsA("ModuleScript") and child ~= script then
local success, result = pcall(require, child)
if success then
Server[child.Name] = result
else
end
end
end
return Server
