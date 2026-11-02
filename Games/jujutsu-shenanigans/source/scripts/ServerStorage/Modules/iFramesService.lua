--// Services \\--

local SvSt = game:GetService('ServerStorage')



--// Moves \\--

local MovesetsFolder = SvSt.Movesets

local Moves = { 'M1', 'Throwables' }
for _, Move: Tool in MovesetsFolder:GetDescendants() do
	if Move:IsA('Tool') then
		table.insert(Moves, Move.Name)
	end
end



--// Module Variables \\--

local AddedIFrames = {}



--// Module \\--

local module = {}



--// Functions \\--

function module:AddiFrames(Character: Model, iFrames)
	if not AddedIFrames[Character] then
		AddedIFrames[Character] = {}
	end
	
	for _, iFrameName in iFrames do
		table.insert(AddedIFrames[Character], iFrameName)
	end
end


function module:RemoveiFrames(Character: Model, iFrames)
	if not AddedIFrames[Character] then
		AddedIFrames[Character] = {}
	else
		for Index, iFrameName in AddedIFrames[Character] do
			if table.find(iFrames, iFrameName) then
				table.remove(AddedIFrames[Character], Index)
			end
		end
	end
end


function module:HasiFrame(Character: Model, iFrameName)
	if not AddedIFrames[Character] then
		AddedIFrames[Character] = {}
		
		return false
	else
		for _,IFrame in AddedIFrames[Character] do
			if IFrame == iFrameName then
				return true
			end
		end
	end
end


function module:AddAlliFrames(Character: Model)
	if not AddedIFrames[Character] then
		AddedIFrames[Character] = {}
	end

	for _, iFrameName in Moves do
		table.insert(AddedIFrames[Character], iFrameName)
	end
end


function module:RemoveAlliFrames(Character: Model)
	AddedIFrames[Character] = {}
end



return module