repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

--[[
	###########################################################################################################
	#### Variables
	###########################################################################################################
]]
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local rep = game:GetService("ReplicatedStorage")
local rs = game:GetService("RunService")
local wrk = game:GetService("Workspace")
local lpg = plr:WaitForChild("PlayerGui")
local crg = game:GetService("CoreGui")
local vu = game:GetService("VirtualUser")
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/LeGioNPsyQ/RBX/main/Variables/Vari.lua')))()
local Window = OrionLib:MakeWindow({Name = "DevilNetWork Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "DevilNetWorkHub"})


--[[
	###########################################################################################################
	#### EVENTS
]]
local Tab = Window:MakeTab({	Name = "Farming",	Icon = "rbxassetid://11911613779",	PremiumOnly = false	})
local Tab2 = Window:MakeTab({	Name = "Pets",		Icon = "rbxassetid://9194077649",	PremiumOnly = false	})
local Tab3 = Window:MakeTab({	Name = "Misc I",	Icon = "rbxassetid://9525535512",	PremiumOnly = false	})
local Tab4 = Window:MakeTab({	Name = "Misc II",	Icon = "rbxassetid://9525535512",	PremiumOnly = false	})
local Tab5 = Window:MakeTab({	Name = "Information",	Icon = "rbxassetid://5128872300",	PremiumOnly = false	})
--[[
	#### Variables END
	###########################################################################################################
]]

--[[
	###########################################################################################################
	#### FARMING (Tab)
]]
local Farm = Tab:AddSection({
	Name = "Main Farming!"
})

AutoClick = Tab:AddToggle({
	Name = "Auto Click",
	Default = false,
	Save = true,
	Flag = "AutoClick",
	Callback = function(Value)
		getgenv().Toggle = Value
		while getgenv().Toggle do
		wait()
		game:GetService("ReplicatedStorage").Events.Click3:FireServer()
    end
end    
})

spawn(function()
  function rebirth(amount)
      local args = {
          [1] = amount
      }
      game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(unpack(args))
    end
end)

local ToggleHighest = Tab:AddToggle({
	Name = "Auto Rebirth Highest Unlocked",
	Default = false,
	Callback = function(Value)
		getgenv().autorebirth = Value 
		while getgenv().autorebirth == true do 
		wait()
		rebirth(game:GetService("Players").LocalPlayer.Upgrades.RebirthButtons.Value)
    end
end
})

local RebirthStatus = Tab:AddLabel(game:GetService("Players").LocalPlayer.Upgrades.RebirthButtons.Value)

spawn(function()
  while true do wait()
  RebirthStatus:Set("Rebirth Buttons Unlocked : " .. game:GetService("Players").LocalPlayer.Upgrades.RebirthButtons.Value)
    end
  end)

local RebirthSelected = Tab:AddDropdown("rebirths", { Values = rebirthsTable(), Default = "1", Multi = false, Text = "Rebirths" })
local Cost = Tab:AddLabel("nil")
local RebirthSL = Tab:AddToggle("rebirth", { Text = "Auto rebirth", Default = false })

--[[
	#### FARMING END
	###########################################################################################################
]]


--[[
	###########################################################################################################
	#### PETS (Tab2)
]]
local Pets = Tab2:AddSection({
	Name = "Earn Pets!"
})

function hatch(name, mode)
  local args = {
      [1] = name,
      [2] = mode
  }
  game:GetService("ReplicatedStorage").Functions.Unbox:InvokeServer(unpack(args))
    end
  
  local EggTable = {}
  local Eggs = game:GetService("Workspace").Scripts.Eggs
  
  for _,v in next, Eggs:GetChildren() do
      table.insert(EggTable, v.Name)
  end
  
  local eggchoice;
  local EggChoice = Tab2:AddDropdown({
    Name = "Select Eggs",
    Default = "Please Select The Eggs",
    Options = EggTable,
    Callback = function(PetChoice)
      eggchoice = PetChoice
    end    
  })
  
  local SelectedMode;
  local SelectMode = Tab2:AddDropdown({
    Name = "Select Egg Opening Mode",
    Default = "Please Egg Opening Mode",
    Options = {"Single", "Triple"},
    Callback = function(Option)
      SelectedMode = Option
    end    
  })
--[[	EGG INFO	]]
local Egginfo = Tab2:AddLabel("Triple also equals 8 Eggs Hatch")
--[[	DELETE SYSTEM	]]
local EggDelete = Tab2:AddDropdown("delete_settings", { Values = deleteTable(), Default = "---", Multi = true, Text = "Delete options" })
local function deleteTable()
	local items = {}
	for i, v in pairs(plr.AutoDelete:GetChildren()) do
		table.insert(items, v.Name)
	end
	return items
end

local AutoHatch = Tab2:AddToggle({
    Name = "Auto Hatch Egg",
    Default = false,
    Callback = function(Value)
      getgenv().autohatch = Value 
      while getgenv().autohatch == true do 
      hatch(eggchoice, SelectedMode)
          end
    end    
  })

  local EggCombo = Tab2:AddLabel(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.EggCombo.Text)

  spawn(function()
      while true do wait()
      EggCombo:Set(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.EggCombo.Text)
      end
      end)
  

local Pets = Tab2:AddSection({
	Name = "Utilize Pets!"
})

AutoCraft = Tab2:AddToggle({
	Name = "Auto Craft",
	Default = false,
	Callback = function(Value)
		getgenv().Toggle = Value
		while getgenv().Toggle do
		wait()
		game:GetService("ReplicatedStorage").Functions.Request:InvokeServer(table.unpack({"CraftAll",{},}))
    end
end
})
--[[
	#### PETS END
	###########################################################################################################
]]


--[[
	###########################################################################################################
	#### Misc I (TAB3)
]]
local Section = Tab3:AddSection({
	Name = "Game Miscs"
})

local Unlock = Tab3:AddButton({
	Name = "Unlock All Worlds",
	Callback = function()
    for i, v in pairs(game:GetDescendants()) do
      if v.Name =="Unlocked" then
         v.Value = "true"
      end
    end
    
      for i, v in pairs(game:GetDescendants(game:GetService("Workspace").Scripts.Portals)) do
      if v.Name =="LabelUI" then
         v:Destroy()
      end
    end
  	end    
})

local GetChests = Tab3:AddButton({
	Name = "Collect All Chests",
	Callback = function()
    game:GetService("Players").LocalPlayer.Passes.AutoChestCollect.Value = true
    wait(10)
    game:GetService("Players").LocalPlayer.Passes.AutoChestCollect.Value = false
  	end    
})

local GetCodes = Tab3:AddButton({
	Name = "Collect All Codes",
	Callback = function()
		local codesTable = {'heaven', 'wow30000', 'magic', '20kthankyou', 'freeluckboost', 'CYBER', 'wow10klikesthanks',
	                            'freeclicksomg', 'moon', '5klikesthanks', 'wow2500likes', 'already1500likes',
	                            'thanks500likes', 'RELEASE', 'void', 'nuclear', 'spooky','75kthanks', 'cave','easter','100kthanks','easter2'}
	        for _, v in pairs(codesTable) do
	            rep.Events.Codes:FireServer(v)
	        end
    	end)
})



local GetPass = Tab3:AddButton({
  Name = "Get Some Gamepass",
  Callback = function()
		for i, v in pairs(plr.Passes:GetChildren()) do
			v.Value = true
		end

--[[
    game:GetService("Players").LocalPlayer.Passes.AutoClicker.Value = true
    game:GetService("Players").LocalPlayer.Passes.AutoRebirth.Value = true
    game:GetService("Players").LocalPlayer.SpaceUpgrades.Teleport.Value = 1
    game:GetService("Players").LocalPlayer.Upgrades.FreeAutoClicker.Value = 1
    game:GetService("Players").LocalPlayer.Upgrades.FasterFreeAutoClicker.Value = 6

]]
  end
})

local GetPassNote = Tab3:AddParagraph("NEW NEW NEW","Unlock all Gamepass :D")


local ClaimDailySpin = Tab3:AddButton({
  Name = "Auto Daily Spin",
  Callback = function()
game:GetService("ReplicatedStorage").Functions.Spin:InvokeServer()
  end
})

local WhiteScreen = Tab3:AddToggle({
	Name = "White Screen [ CPU Saver ]",
	Default = false,
	Callback = function(Value)
    getgenv().Toggle = Value
    while getgenv().Toggle == true do wait()
            if getgenv().Toggle == true then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
        setfpscap(10)
      else 
        game:GetService("RunService"):Set3dRenderingEnabled(true)
        setfpscap(360)
      end
    end
	end    
})

local ServerMisc = Tab3:AddSection({
  Name = "Server Miscs"
  })

local RejoinsServer = Tab3:AddButton({
  Name = "Rejoin",
  Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
  end
})

local LabelHop = Tab3:AddLabel("Lower Server Hop Taken From V3rm. Credits to owner")

local LowerServer = Tab3:AddButton({
  Name = "Hop To Lower Player",
  Callback = function()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
      AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)
    if not File then
      table.insert(AllIDs, actualHour)
      writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
      local Site;
      if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
      else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
      end
      local ID = ""
      if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
      end
      local num = 0;
      for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
          for _,Existing in pairs(AllIDs) do
            if num ~= 0 then
              if ID == tostring(Existing) then
                Possible = false
              end
            else
              if tonumber(actualHour) ~= tonumber(Existing) then
                local delFile = pcall(function()
                  delfile("NotSameServers.json")
                  AllIDs = {}
                  table.insert(AllIDs, actualHour)
                end)
              end
            end
            num = num + 1
          end
          if Possible == true then
            table.insert(AllIDs, ID)
            wait()
            pcall(function()
              writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
              wait()
              game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
            end)
            wait(8)
          end
        end
      end
    end
    
    function Teleport()
      while wait() do
        pcall(function()
          TPReturner()
          if foundAnything ~= "" then
            TPReturner()
          end
        end)
      end
    end
    Teleport()
  end
})

for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
    v:Disable()
  end
--[[
	#### MICS I (TAB3) END
	###########################################################################################################
]]


--[[
	###########################################################################################################
	#### MISC II (TAB4)
]]

local Section2 = Tab4:AddSection({
	Name = "Player Miscs"
})

local Slider = Tab4:AddSlider({
	Name = "Walk Speed",
	Min = 16,
	Max = 400,
	Default = 48,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

local Gravity = Tab4:AddSlider({
	Name = "Gravity",
	Min = 1,
	Max = 1000,
	Default = 196,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Gravity",
	Callback = function(Value)
    game.Workspace.Gravity = Value
	end    
})

local FOV = Tab4:AddSlider({
	Name = "Field Of View (FOV)",
	Min = 10,
	Max = 120,
	Default = 70,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Gravity",
	Callback = function(Value)
    game:GetService'Workspace'.Camera.FieldOfView = Value
	end    
})
-------------------------------------------------------------------------------------------------------------------


local UPD1 = Tab5:AddSection({		Name = "UPDATE Information!"		})
local UPD2 = Tab5:AddParagraph("Gamepass Unlock!","The Gamepass will be completely unlocked")


local INFO = Tab5:AddSection({		Name = "General Information!"		})
local INFO1 = Tab5:AddParagraph("Script Window","Hit The - Button To Minimize And The X Button To Close The Script")
local INFO2 = Tab5:AddParagraph("COMING SOON","Discord, Owner-Nickname,Design")

--[[
local Discord = Tab5:AddButton({
	Name = "Join The Discord!",
	Callback = function()
    setclipboard("https://discord.gg/JEDCJDBbg3")
    OrionLib:MakeNotification({
      Name = "DevilNetWork Hub!",
      Content = "Discord Link Copied To Clipboard",
      Image = "rbxassetid://8387379647",
      Time = 1
    })
  end
})
]]
local LabelAFK = Tab5:AddParagraph("Anti AFK","Is Always Active")
  
-- { Loops } --
rs.RenderStepped:Connect(function()
	if Toggles.wheel.Value then
		if wrk.Scripts.DailySpin.Billboard.BillboardGui.Countdown.Text == "Ready to Claim!" then
			Spin:InvokeServer()
		end
	end
	if Toggles.upgrade.Value then
		for i, v in pairs(Options.upgrades.Value) do
			Upgrade:InvokeServer(i)
		end
	end
	if Toggles.potion.Value then
		for i, v in pairs(Options.potions.Value) do
			Potion:FireServer(i)
		end
	end
	Cost:SetText(lpg.MainUI.RebirthFrame.Top.Holder.ScrollingFrame[Options.rebirths.Value].Main.Label.Text)
	if Toggles.rebirth.Value then
		Rebirth:FireServer(tonumber(Options.rebirths.Value))
	end
	if Toggles.delete.Value then
		for i, v in pairs(Options.delete_settings.Value) do
			plr.AutoDelete[i].Value = true
		end
		else
			for i, v in pairs(Options.delete_settings.Value) do
				plr.AutoDelete[i].Value = false
			end
		end
		if Toggles.auto_craft.Value then
			rep.Functions.Request:InvokeServer('CraftAll', {})
		end
		plr.Character.Humanoid.WalkSpeed = Options.walkspeed.Value
		plr.Character.Humanoid.JumpHeight = Options.jumppower.Value
	end)
end
OrionLib:MakeNotification({
	Name = "DevilNetWork Hub!",
	Content = "Fully Loaded",
	Image = "rbxassetid://4838075912",
	Time = 3
})
OrionLib:Init()
