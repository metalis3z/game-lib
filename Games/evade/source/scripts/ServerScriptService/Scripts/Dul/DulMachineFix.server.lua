local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = ReplicatedStorage.Packages.Trove
local SoundController = ReplicatedStorage.Controllers.SoundController
local scripty = Trove.new();



      ReplicatedStorage:GetAttribute("DulDulDulConstructionStart")
      task.wait();
	  local ReplicatedStorageGetAttribute = ReplicatedStorage:GetAttribute("DulDulDulConstructionStart")
	  if not ReplicatedStorage then
			return;
	  else
			local machinecopy = scripty:Clone(script.Machine)
			machinecopy.Parent = workspace;
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Dul Dul Dul"].Building, machinecopy.Root.Position, false);
			local machinecopyvfx = scripty:Clone(script.BuildingVFX);
			machinecopyvfx.Parent = workspace;
			
	  end
