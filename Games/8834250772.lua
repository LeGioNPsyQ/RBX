--[[
	#########################################################################################################################
	#### 	VARIABLES
	#########################################################################################################################
]]
--[[
	##	GLOBALS 
]]
getgenv().Toggle = false
getgenv().EggHatch = false
getgenv().AC = false 

--##	 EGG
_EggDELCommon = false
_EggDELUncommon = false
_EggDELEpic = false
_EggDELLegendary = false
--[[
	##	TIMER
]]
local RebirthTimer = "5"
--[[
	##	GUI LOAD LOCAL
]]
local Player, Rayfield, Click, comma, Notify, CreateWindow, CurrentVersion, CreateToggle = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeGioNPsyQ/LeGioN-Hub/main/Variables/Vari.lua"))()
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/LeGioNPsyQ/OrionLib/main/OrionLib.lua'))()
local emoji = loadstring(game:HttpGet('https://raw.githubusercontent.com/LeGioNPsyQ/OrionLib/main/Icons.lua'))()
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = game:GetService("Players").LocalPlayer or game:GetService("Players").PlayerAdded:Wait()
local VCurrentVersion
local function CurrentVersion(v)
	if v then VCurrentVersion = v end
end
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
CurrentVersion("v1.0")
local Name = game.Players.LocalPlayer.Name
local P = game:GetService'Players'
local HRP = P.LocalPlayer.Character.HumanoidRootPart
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[
	##	ABFRAGEN
]]
__AREAS = {"Spawn","Desert","Snow","Youtube","Lava","Ocean","Void","Dino","Cyber","Beach","Graveyard"}
__EGGS = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"}
--[[
	##	WINDOW 
]]
local Window = OrionLib:MakeWindow({
	Name = GameName.." [😈 ÐN "..VCurrentVersion.."]",
	LoadingTitle = "DevilNetWork",
	LoadingSubtitle = "by LeGioN_PsyQ",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "DevilNetWork Orion", 
		FileName = game.PlaceId.."-"..Player.Name
	},

})
--[[
	##	TAB SECTION 
]]
local Main = Window:MakeTab({Name = "Main",Icon = "rbxassetid://7733765398",PremiumOnly = false})
local Pets = Window:MakeTab({Name = "Pets",Icon = "rbxassetid://8997385940",PremiumOnly = false})
local Credits = Window:MakeTab({Name = "Credits",Icon = "rbxassetid://4503342956",PremiumOnly = false})
local mr = game.Players.LocalPlayer.Character.HumanoidRootPart

--[[
	##	Auto Farm
]]
Main:AddSection({Name = "Auto Farm"})
Main:AddDropdown({
	Name = "Auto Farm Area",
	Options = __AREAS,
	CurrentOption = "--",
	Callback = function(value)
		_AreaSelected = value
	end,
})
Main:AddSlider({
	Name = "Auto Farm Interval",
	Min = 0.1,
	Max = 10,
	Default = 5,
	Increment = 0.1,
	ValueName = "Speed",
	Color = Color3.fromRGB(255, 100, 150),
	Flag = "SPD",
	Callback = function(Value)
		FarmInterval = Value
	end
})
Main:AddToggle({
	Name = "⭐ Auto Farm",
	CurrentValue = false,
	Flags = "AutoFarm",
	Callback = function(bool)
		getgenv().Toggle = bool
		if bool then
			AutoFarm()
		end
	end,
})
function AutoFarm()
	while Toggle == true do
		if not getgenv then break end
		for i,v in pairs(game:GetService("Workspace")["__AREAS"][_AreaSelected]:GetDescendants()) do
			if v.ClassName == "MeshPart" then
				-- if v.Health.Value < _G.Hp then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
					wait(FarmInterval)
				-- end
			end
		end
	end
end

Main:AddSection({Name = "Auto Chest Claim"})
Main:AddToggle({
	Name = "⭐ Auto Chest",
	CurrentValue = false,
	Flags = "AutoChest",
	Callback = function(bool)
		getgenv().AC = bool
		if bool then
			AChest()
		end
	end,
})
function AChest()
    while AC == true do 
        if not getgenv then break end 
            for i,v in pairs(game.Workspace.__CHEST:GetChildren()) do
                if v:IsA("Touch") then
                local transmitter = v:FindFirstChild("TouchTransmitter") 
                firetouchinterest(mr, v, 0)
                firetouchinterest(mr, v, 1)
                print("Chest Collected..")
                wait(100)
            end
        end
    end
end

Main:AddSection({Name = "Anti Report"})
Main:AddParagraph("Anti-Report", "Changes your Avatar")
Main:AddButton({
	Name = "Anti Report",
	Callback = function()
		Notify("Anti-Report is Enabled","Your Avatar is Black")
		for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v.ClassName == "BillboardGui" or v.ClassName == "Accessory" or v.ClassName == "Pants" or v.ClassName == "Decal" or v.ClassName == "Shirt" then
				wait()
				v:Destroy()
			end
		end 
	end
})

--[[
	#### PETS
]]
Pets:AddParagraph("Hacth Info","You must be near the Egg")
Pets:AddDropdown({
	Name = "Egg",
	Options = __EGGS,
	CurrentOption = "--",
	Callback = function(value)
		_EggSelected = value
	end,
})
Pets:AddDropdown({
	Name = "Egg Amount",
	Options = {1,3},
	CurrentOption = "--",
	Flag = "EggAmount",
	Callback = function(value)
		_EggAmount = value
	end,
})
Pets:AddSlider({
	Name = "Auto Hatch Interval",
	Min = 2,
	Max = 10,
	Default = 5,
	Increment = 1,
	ValueName = "Hatch Speed",
	Color = Color3.fromRGB(255, 100, 150),
	Flag = "HSPD",
	Callback = function(Value)
		HatchInterval = Value
	end
})
Pets:AddToggle({
	Name = "Auto Hatch",
	CurrentValue = false,
	Flag = "AHatch",
	Callback = function(bool)
		getgenv().EggHatch = bool
		if bool then 
			EggA()
		end
	end,
})
Pets:AddSection({Name = "Auto Delete"})
Pets:AddToggle({Name = "Common",CurrentValue = false,Callback = function(bool)	if bool then _EggDELUnCommon = true else _EggDELCommon = false end end,	})
Pets:AddToggle({Name = "Uncommon",CurrentValue = false,Callback = function(bool)	_EggDELUncommon = true	 else _EggDELUncommon = false	end end,})
Pets:AddToggle({Name = "Epic",CurrentValue = false,Callback = function(bool)	_EggDELEpic = true	else _EggDELEpic = false end	end,})
Pets:AddToggle({Name = "Legendary",CurrentValue = false,Callback = function(bool)	_EggDELLegendary = true	else _EggDELLegendary = false end end,})
function EggA()
    while EggHatch == true do 
        if not getgenv then break end 
		local args = {
			[1] = _EggAmount,
			[2] = _EggSelected,
			[3] = _EggDELCommon,
			[4] = _EggDELUncommon,
			[5] = _EggDELEpic,
			[6] = _EggDELLegendary
		}
		game:GetService("ReplicatedStorage").__REMOTES.__Buy_EGG:FireServer(unpack(args))
		wait(HatchInterval)
    end
end
---//MISC
Misc:AddSlider({
	Name = "Walkspeed",
	Min = 0,
	Max = 500,
	Default = 40,
	Increment = 1,
	ValueName = "Walkspeed",
    Color = Color3.fromRGB(63, 198, 255),
	Callback = function(Value)
		game:GetService('Workspace')[Name].Humanoid.WalkSpeed = Value
	end
})
Misc:AddSlider({
	Name = "JumpPower",
	Min = 0,
	Max = 500,
	Default = 50,
	Increment = 1,
	ValueName = "JumpPower",
    Color = Color3.fromRGB(31, 255, 23),
	Callback = function(Value)
		game:GetService('Workspace')[Name].Humanoid.JumpPower = Value
	end 
})
Misc:AddTextbox({
	Name = "Teleport to player",
	Default = "Player Name",
	TextDisappear = true,
	Callback = function(Value)
        local function TPToPlayer()
            HRP.CFrame = workspace[Value].HumanoidRootPart.CFrame
        end
        TPToPlayer()
	end	  
})

---//Credits 
Credits:AddButton({
	Name = "💭 Copy link to Discord",
	icon = "rbxassetid://7733954760",
	Callback = function()
      	setclipboard('https://discord.gg/tJtY47NZ5z')
	end
})
Credits:AddLabel("Made by LeGioN_PsyQ#3114")
Credits:AddParagraph(
	"Information",
	"[😈 ÐN v1.0] = [😈 DevilNetWork v1.0]"
)
Credits:AddParagraph(
	"DevilNetWork v1.0",
	"Is a Script from Testing on LUA-Codiung	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 		 	 	 	 	 	 DevilNetWork Owner © LeGioN_PsyQ"
)


OrionLib:MakeNotification({
	Name = "GUI",
	Content = "Successfully loaded GUI",
	Image = "rbxassetid://4483345998",
	Time = 5
})
OrionLib:MakeNotification({
	Name = "GUI",
	Content = "Copied link to the Discord server!",
	Image = "rbxassetid://4483345998",
	Time = 5
})
OrionLib:Init()
