extends Node2D

export (PackedScene) var MCQ # i used a pakcedsfenec

# GDSCRIPT has no arrays !!!! :( :(
var p1 = ["5x+2<17-->Solve the inequality", "x≤2", "x<3", "x<4", "x<5", "x<3"]
var p2 = ["2x-5≤1-->Solve the inequality", "x≤2", "x≤3", "x≤4", "x≤5", "x≤3"] #
var p3 = ["9x+7<70-->Solve the inequality", "x<4", "x>5", "x>6", "x<7", "x<7"]
var p4 = ["3x≤27-->Solve the inequality", "x≤9", "x≤4", "x≤3", "x≤2", "x≤9"] #
var p5 = ["4x+4≤28-->Solve the inequality", "x≤1", "x≤6", "x≤5", "x≤8", "x≤6"]
var p6 = ["9-x<10-->Solve the inequality", "x<4", "x< 6", "x>-1", "x>1", "x>-1"] #
var p7 = ["x/35>3/7-->Solve the inequality", "x>1", "x>15", "x>23", "x>8", "x>15"]
var p8 = ["2x+4≥9+x-->Solve the inequality", "x>5", "x<5", "x≥5", "x≤5", "x≥5"] #
var p9 = ["x-4≥6/2-->Solve the inequality", "x≥2", "x≥3", "x≥7", "x≥1", "x≥7"]
var p10 = ["7x+42≥2x+67-->Solve the inequality", "x≥5", "x≥4", "x>4", "x≥10", "x≥5"]  #

var onwrong = 0
var problems = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]
var wrongprobs = []
var curprob = 0 # testing pruposes
onready var matho = get_node("Matho")

# Called when the node enters the scene tree for the first time.
func _ready():
	prep_question(curprob)

func prep_question(number):
	var question = MCQ.instance()
	question.ready(problems[number][0], problems[number][1], problems[number][2], problems[number][3], problems[number][4], problems[number][5])
	question.connect("correct", self, "move_on")
	question.connect("incorrect", self, "go_later")
	self.add_child(question)
	question.name = "current"

# wha thappens when a question is wrong/right
func move_on():
	matho.become_happy()
	yield(get_tree().create_timer(1.0), "timeout")
	
	if not onwrong:
		if curprob < 9:
			curprob += 1
			kill_children()
			prep_question(curprob)
		elif curprob == 9:
			if not wrongprobs:
				get_tree().change_scene("res://MainScene.tscn")
			if wrongprobs:
				kill_children()
				onwrong = 1
				curprob = wrongprobs[0]
				prep_question(curprob)
	elif onwrong:
		wrongprobs.erase(curprob)
		print(wrongprobs)
		
		if not wrongprobs: # if there are no wrong questions
			get_tree().change_scene("res://MainScene.tscn")
		else:
			curprob = wrongprobs[0]
			kill_children()
			prep_question(curprob)
	
	matho.become_unhappy()

func go_later():
	matho.become_sad()
	yield(get_tree().create_timer(1.0), "timeout")
	print(wrongprobs)
	
	if not onwrong:
		wrongprobs.append(curprob)
		if curprob < 9:
			curprob += 1
			kill_children()
			prep_question(curprob)
		elif curprob == 9:
			if not wrongprobs:
				get_tree().change_scene("res://MainScene.tscn")
			if wrongprobs:
				print("got to wrongprobs")
				kill_children()
				onwrong = 1
				curprob = wrongprobs[0]
				prep_question(curprob)
	elif onwrong:
		print("wrong question wrong")
		wrongprobs.erase(curprob)
		print("b4 " + str(wrongprobs))
		wrongprobs.append(curprob) # move it to the back
		print(wrongprobs)
		curprob = wrongprobs[0]
		kill_children()
		prep_question(curprob)
	
	matho.become_unhappy()

func kill_children():
	for child in get_children():
		if child.name != "Background" and child.name != "Matho":
				child.queue_free()
