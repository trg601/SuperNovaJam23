///@desc load dialogue

switch(dialogueId) {
	case 0:
		texts = ["Come back when you've collected all the candies"]
	break
	case 1:
		texts = ["Hi there [float][c=red]spooky[/c][/float] friend O mine!", "[finishLevel]How is it going with ya on this fine evening"]
	break
}

event_user(0)
loaded = true