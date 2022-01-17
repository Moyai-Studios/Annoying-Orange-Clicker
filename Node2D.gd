extends Node2D

var subscribers = 0
var points = 0
var subsovertime = 0
var bushprice = 25
var treeprice = 25
var subsperclick = 1
var mouseonbush = 0
var mouseontree = 0
var sponsor = 0
var rand_generate = RandomNumberGenerator.new()
var _timer = null

func _ready():
	$canvas/RichTextLabel.text = str(points) + "$\n" + str(subscribers) + " Subscribers\n"  + str(subsovertime) + " Subscribers over time"
	$canvas/bushprice.text = str(round(bushprice)) + "$ For Marketing"
	$canvas/treeprice.text = str(round(treeprice)) + "$ For Video Quality"
	$canvas/ItemInfo.text = ""
	$canvas/Sponsor.visible = false
	randomize()
	rand_generate.randomize()
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
	subscribers += subsperclick
	$canvas/RichTextLabel.text = str(points) + "$\n" + str(subscribers) + " Subscribers\n"  + str(subsovertime) + " Subscribers over time"

func _on_bush_pressed():
	## bush will be replaced by marketing or increase video quality in the future
	if points >= bushprice:
		$canvas/AudioStreamPlayer2D.play()
		subsovertime += 1
		points -= bushprice
		bushprice += bushprice / 2
		$canvas/RichTextLabel.text = str(points) + "$\n" + str(subscribers) + " Subscribers\n"  + str(subsovertime) + " Subscribers over time"
		$canvas/bushprice.text = str(round(bushprice*100)/100) + "$ For Marketing"
	
func repeat_me():
	points += subscribers * 0.01
	subscribers += subsovertime
	if round(rand_generate.randf_range(0.0, 100.0)) == 5:
		if sponsor == 0:
			$canvas/Sponsor.visible = true
			$canvas/Sponsor.rect_position.x = round(rand_generate.randf_range(0.0, 900.0))
			$canvas/Sponsor.rect_position.y = round(rand_generate.randf_range(0.0, 400.0))
			sponsor = 1
	$canvas/RichTextLabel.text = str(points) + "$\n" + str(subscribers) + " Subscribers\n"  + str(subsovertime) + " Subscribers over time"


func _on_tree_pressed():
	if points >= treeprice:
		$canvas/AudioStreamPlayer2D.play()
		subsperclick += 1
		points -= treeprice
		treeprice += treeprice / 2
	$canvas/RichTextLabel.text = str(points) + "$\n" + str(subscribers) + " Subscribers\n" + str(subsovertime) + " Subscribers over time"
	$canvas/treeprice.text = str(round(treeprice)) + "$ For Video Quality"


func _on_TextureButton_mouse_entered():
	$canvas/RichTextLabel.text = str(points) + "$\n" + str(subscribers) + " Subscribers\n" + str(subsovertime) + " Subscribers over time"


func _on_bush_mouse_entered():
	mouseonbush = 1
	$canvas/ItemInfo.text = "This bush will be marketing/video quality in the future. Each you buy will increase your subscribers by one every second."

func _on_bush_mouse_exited():
	mouseonbush = 0
	if mouseonbush == 0 && mouseontree == 0:
		$canvas/ItemInfo.text = " "


func _on_tree_mouse_entered():
	mouseontree = 1
	$canvas/ItemInfo.text = "This tree will be something else in the future. Each you buy will increase your subscribers per click by one."


func _on_tree_mouse_exited():
	mouseontree = 0
	if mouseonbush == 0 && mouseontree == 0:
		$canvas/ItemInfo.text = " "


func _on_Sponsor_pressed():
	if sponsor == 1:
		points += (subscribers + 10) * round(rand_generate.randf_range(1.0, 3.0))
		subscribers += subscribers * round(rand_generate.randf_range(0.03, 0.1))
		$canvas/Sponsor.visible = false
		sponsor = 0
