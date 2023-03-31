///@desc load dialogue

switch(dialogueId) {
	case 0:
		texts = ["[float]BOOOOO!![/float] Not enough [c=lime green]candy!!"]
	break
	case 1:
		texts = [
			"O... [c=cyan]Dribbly...[/c] What brings you out and about this spooktacular night?",
			"You're going to [float][c=black]Death's[/c][/float] party? Were you even invited?",
			"Ah, whatever. I'm not your parent.",
			"But if you're crashing, might as well smooth it out with some kinda offering...",
			"How about you get a buncha [float][c=lime green]candies[/c][/float] to get the big guy happy?",
			"[finishLevel]Just sweep around and come find me when you feel like you have enough."
		]
	break
	case 2: 
		texts = [
			"O! [float]Spooktastic![/float] [c=black]Death[/c] [float]might[/float] just let you in with this much [c=lime green]candy.",
			"Don’t look at me like that! Just keep going and get some more if you’re that worried!",
			"I’m going ahead. Peace out, [c=cyan]Dribbly!"
		]
	break
	case 3: 
		texts = [
			"Hehe. Okay, I think [c=black]Death[/c] will tolerate this much.",
			"Maybe...",
			"[finishLevel]Ugh, go spit up a wall or something! [float]Later![/float]"
		]
	break
	case 4: 
		texts = [
			"This is more like it! Way to go [c=cyan]Dribbly!",
			"Now all you gotta do is sweet talk [c=black]Death[/c] into letting you party with everyone.",
			"No pressure!"
		]
	break
	
	case 50:
		texts = ["Hold left mouse button to charge your spit - Release to shoot a spit glob!", "Spit globs can stick to walls and be bounced off of"]
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