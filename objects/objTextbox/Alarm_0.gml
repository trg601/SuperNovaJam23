///@desc load dialogue

switch(dialogueId) {
	case 0:
		texts = ["Come back when you've collected all the candies"]
	break
	case 1:
		texts = ["Hi there [float][c=red]spooky[/c][/float] friend O mine!", "[finishLevel]How is it going with ya on this fine evening"]
	break
	
	case 100:
		var totalSeconds = (current_time - objGame.timeRoomStarted) / 1000
		var m = (totalSeconds div 60) % 60
		var s = (totalSeconds div 1) % 60
		
		texts = ["[finishLevel=RoomMainMenu]Good job! Time taken: " + string(m) + " minute" + (m == 1 ? "" : "s") + " and " + string(s) + " seconds. You died " + string(objGame.restartsInRoom) + " time" + (objGame.restartsInRoom == 1 ? "" : "s")  + "."]
	break
	case 101:
		texts = ["Oh hi! You came just in time, we were just about to have tea."]
	break
}

event_user(0)
loaded = true