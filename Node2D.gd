extends Node2D

var points = 0
var pointsovertime = 0
var bushprice = 25
var treeprice = 25
var pointsperclick = 1
var _timer = null

func _ready():
	$canvas/RichTextLabel.text = str(points) + " Points\n" + str(pointsovertime) + " Points Per Second"
	$canvas/bushprice.text = str(round(bushprice))
	$canvas/treeprice.text = str(round(treeprice))
	# Create a timer node
	var timer = Timer.new()

	# Set timer interval
	timer.set_wait_time(1.0)

	# Set it as repeat
	timer.set_one_shot(false)

	# Connect its timeout signal to the function you want to repeat
	timer.connect("timeout", self, "repeat_me")

	# Add to the tree as child of the current node
	add_child(timer)

	timer.start()


func _on_TextureButton_pressed():
	points += pointsperclick
	$canvas/RichTextLabel.text = str(points) + " Points\n" + str(pointsovertime) + " Points Per Second"

func _on_bush_pressed():
	if points >= bushprice:
		pointsovertime += 1
		points -= bushprice
		bushprice += bushprice / 2
		$canvas/RichTextLabel.text = str(points) + " Points\n" + str(pointsovertime) + " Points Per Second"
		$canvas/bushprice.text = str(round(bushprice))
	
func repeat_me():
	points += pointsovertime
	$canvas/RichTextLabel.text = str(points) + " Points\n" + str(pointsovertime) + " Points Per Second"


func _on_tree_pressed():
	if points >= treeprice:
		pointsperclick += 1
		points -= treeprice
		treeprice += treeprice / 2
		$canvas/RichTextLabel.text = str(points) + " Points\n" + str(pointsovertime) + " Points Per Second"
		$canvas/treeprice.text = str(round(treeprice))
