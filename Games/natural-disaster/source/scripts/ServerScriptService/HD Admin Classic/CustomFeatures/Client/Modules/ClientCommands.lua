-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << CLIENT COMMANDS >>
local module = {}
	
	----------------------------------------------------------------------
	module["commandName1"] = {
		Function = function(speaker, args)
			--Press paino key
			main:GetModule("cf"):ReplicateEffect(pianoKey)
			self.a = 0
		end;
		ReplicationEffect = function(speaker, pianoKey)
			
		end
		};
	
	
	
	
	----------------------------------------------------------------------
	module["commandName2"] = {
		Function = function(speaker, args)
			
		end;
		};
	
	
	
	
	----------------------------------------------------------------------
	




-- << SETUP >>
for commandName, command in pairs(module) do
	command.Name = commandName
end



return module