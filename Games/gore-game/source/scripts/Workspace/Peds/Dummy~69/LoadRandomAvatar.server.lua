wait(0.2)
local HttpService = game:GetService'HttpService'
-- use proxy such as rprxy.xyz if you're doing this from inside a game
local response = HttpService:GetAsync("https://groups.roproxy.com/v1/groups/9572461/users?sortOrder=Asc&limit=100")
response = HttpService:JSONDecode(response)

local userIds = {}
for i, memberData in pairs(response.data) do
	table.insert(userIds, memberData.user.userId)
end

local DefaultID
local ChoosenID = userIds[math.random(#userIds)]
local Name = game.Players:GetNameFromUserIdAsync(DefaultID or ChoosenID)
local Description = game.Players:GetHumanoidDescriptionFromUserId(DefaultID or ChoosenID)
script.Parent:FindFirstChildOfClass("Humanoid"):ApplyDescription(Description)
script.Parent:FindFirstChildOfClass("Humanoid").DisplayName = Name

for _,v in pairs(script.Parent:GetDescendants()) do
	if (v:IsA("BasePart") and (v.Parent:IsA("Accessory") or v.Parent.Parent:IsA("Accessory"))) then
		v.CollisionGroupId = 3
	elseif(v:IsA("CharacterMesh")) then
		v:Destroy()
	end
end