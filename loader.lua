local checker = pcall(function()
	GameID = game.PlaceId..".lua"
	games = game:HttpGet("https://raw.githubusercontent.com/LeGioNPsyQ/RBX/main/Games/"..GameID)
end)
if checker then
	game.StarterGui:SetCore("SendNotification", {
		Title = "[DevilNetWork X] Notify";
		Text = "Script is loaded"..games;
		Duration = 10;
	})
	loadstring(games)()
else
	game.StarterGui:SetCore("SendNotification", {
		Title = "[DevilNetWork X] Notify";
		Text = "Game not supported";
		Duration = 10;
	})
end
