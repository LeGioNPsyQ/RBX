
local TABEVENT1 = Window:MakeTab({
	Name = "100M Event!",
	Icon = "rbxassetid://7657243214",
	PremiumOnly = false
})
local Section = TABEVENT1:AddSection({
	Name = "100M Event!"
})
TABEVENT1:AddToggle({
	Name = "Auto Collect Cupcake",
	Default = false,
	Callback = function(Value)
        getgenv().CollectCupcakes = Value
        while getgenv().CollectCupcakes do
        wait(0.2)
        for i,v in pairs(game:GetService("Workspace").Scripts.CollectCupcakes.Storage:GetDescendants()) do
          if (v.Name == "TouchInterest" and v.Parent) then
          firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 0)
          wait()
          break;
         end
        end 
	end    
end
})

local EventUpgrader = TABEVENT1:AddSection({
    Name = "Event Upgrader"
})
  function upgrade(option)
    local args = {
        [1] = option,
        [2] = "100m",
    }
  game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer(unpack(args))
    end

    local eventupgraders;
    TABEVENT1:AddDropdown({
        Name = "Select Event Upgrader",
        Default = "Select Event Upgrader",
        Options = {"Click Multiplier", "Bank Space", "+1 Pet Equip", "Hatch Speed", "Gems Multiplier", "Luck Multiplier", "Cupcakes Multiplier"},
        Callback = function(Option)
            if Option == "Click Multiplier" then
                eventupgraders = "ClickMultiplier";
               elseif Option == "Bank Space" then
                eventupgraders = "BankSlots";
               elseif Option == "+1 Pet Equip" then
                eventupgraders = "PetEquip";
               elseif Option == "Hatch Speed" then
                eventupgraders = "HatchSpeed";
               elseif Option == "Luck Multiplier" then
                eventupgraders = "LuckMultiplier";
               elseif Option == "Cupcakes Multiplier" then
                eventupgraders = "CupcakesMultiplier";
        end    
      end
    })
  
    
  local EventUpgradeWarn = TABEVENT1:AddLabel("Must Set Event Upgrader Option First")

  TABEVENT1:AddToggle({
	Name = "Enable Event Upgrader!",
	Default = false,
	Callback = function(Value)
        getgenv().EventUpgrader = Value 
        while getgenv().EventUpgrader == true do wait(1)
          upgrade(eventupgraders)
                end
	end    
})