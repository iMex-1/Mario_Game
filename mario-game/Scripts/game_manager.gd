extends Node
var Score = 0
@onready var score: Label = $Score

func add_Pt():
	Score += 1
	score.text = "You Collected: " + str(Score) +" Coin"
