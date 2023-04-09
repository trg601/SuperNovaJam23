///@desc load dialogue

switch(dialogueId) {
	case 0:
		texts = ["[float]BOOOOOOOO![/float] Not enough [c=lime green]candy![/c]", "Come back to me after you've found some more"]
	break
	case 1:
		texts = [
			"O... [c=cyan]Dribbly...[/c] What brings you out and about this spooktacular night?",
			"...",
			"You're going to [float][c=black]Death's[/c][/float] party? Were you even invited?",
			"...",
			"Ah, whatever. I'm not your parent. But if you're crashing, might as well smooth it out with some kinda offering...",
			"How about you get a buncha [float][c=lime green]candies[/c][/float] to get the big guy happy?",
			"[finishLevel]Just sweep around and come find me when you feel like you have enough."
		]
	break
	case 2:
		texts = [
			"There you go, that should be all the [float][c=lime green]candy[/c][/float] you can find here.",
			"[finishLevel]But you'll have to keep looking if you think [c=black]Death[/c] will let you into the party."
		]
	break
	case 3: 
		texts = [
			"O! [float]Spooktastic![/float] [c=black]Death[/c] [float]might[/float] just let you in with this much [c=lime green]candy.",
			"Don't look at me like that! Just keep going and get some more if you're that worried!",
			"[finishLevel]I'm going ahead. Peace out, [c=cyan]Dribbly!"
		]
	break
	case 4: 
		texts = [
			"Hehe. Okay, I think [c=black]Death[/c] will tolerate this much.",
			"Maybe...",
			"[finishLevel]Ugh, go spit up a wall or something! [float]Later![/float]"
		]
	break
	case 5: 
		texts = [
			"This is more like it! Way to go [c=cyan]Dribbly!",
			"Now all you gotta do is sweet talk [c=black]Death[/c] into letting you party with everyone.",
			"[finishLevel=RoomCredits]No pressure!"
		]
	break
	
	case 50:
		texts = ["Press [c=blue]space[/c] or [c=blue]A[/c] to jump"]
	break
	case 51:
		texts = ["Hold [c=blue]left mouse[/c] or [c=blue]left bumper[/c] to charge your spit, aiming with [c=blue]the mouse[/c] or [c=blue]right stick[/c]- Release to shoot a spit glob!", "Pressing [c=blue]space[/c] or [c=blue]A[/c] right as you're about to hit a glob will launch you high!"]
	break
	case 52:
		texts = [
			"Touch a gravestone to save your progress!",
			"Press [c=blue]right mouse[/c] or [c=blue]right bumper[/c] to shoot a long spit that can grapple onto [c=purple]hanging mushrooms[/c] ",
			"Swing back and forth with left/right to build momentum and press jump to launch off!"
		]
	break
	case 53:
		texts = ["Push a spit glob onto a [c=lime green]mushroom button[/c] to activate it! If you do, some [c=lime green]friendly ghosts[/c] may help you out!"]
	break
	case 54:
		texts = ["Be warned: You can only have three spit globs out at a time, spitting more will pop the oldest one"]
	break
	case 55:
		texts = ["Sometimes you need to bounce a spit glob off of another spit glob to hit a [c=orange]mushroom button[/c]"]
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