use Tk;
use strict;
use warnings;

my @dict;
my $length;
my $word_index;
my $word;
my $word_length;
my $guess;
my $letter;
my $i;
my $count = 0;
my $match = 0;
my $win = 0;
my @letters_guessed;


#GUI Window. Must have TK.
# info about TK
# https://www.ibm.com/developerworks/aix/library/au-perltkmodule/index.html
# https://www.perl.com/pub/2001/03/gui.html/
# https://docstore.mik.ua/orelly/perl3/tk/ch01_04.htm


my $mw;
my $GuessList;
my $LettersGuessed;
my $hangmanDisplay;
my $DisplayHangman;
my $canvas;
my $CounterLabel;
my $MatchLabel;

$mw = MainWindow -> new;
$mw->geometry("450x450");
$mw->title("Hangman");


$canvas = $mw->Canvas(-relief => "sunken", -background => "lightblue");
$canvas->pack();

$canvas->createRectangle(10, 10, 20, 260, -fill => "black");
$canvas->createRectangle(10, 20, 200, 10, -fill => "black");
$canvas->createLine(100, 15, 15, 100, -width => 10, -fill => "brown");
$canvas->createRectangle(190, 40, 200, 20, -fill => "brown");
$canvas->createRectangle(10, 240, 370, 260, -fill => "brown");








$canvas->createOval(170, 40, 220, 90, -fill => "black");
$canvas->createOval(175, 45, 215, 85, -fill => "white");
$canvas->createRectangle(190, 90, 200, 170, -fill => "black");



#! /usr/bin/perl
# Initiate the dictionary
# my $size = `wc -l dictionary.txt`;
my $size = 20;
#$size =~ s/\D//g;
$mw -> Label(-text => "The size of the file is $size")->pack();


sub GUI {
	$LettersGuessed = $mw->Label(-text => "Letters Guessed: @letters_guessed")->pack();

	$GuessList = $mw->Label(-text => "$guess")->pack();

	$CounterLabel = $mw->Label(-text => "Count: $count")->pack();



###############################
#My Issue is I kind of got the GUI working. You made it so that once the button is clicked, it will push the letter into the $letter.
#But I cant figure out why it wont run the #CheckLetter sub function
#Perhaps it is and im stuck on the wrong thing.
#either way, It doesnt update the counter. So it always just keeps drawing the circle.
#anythoughts?
###############################
	my $A = $mw->Button(-text => "A", -command => [\&letter, 'a'])->pack(-side => 'left');
	my $B = $mw->Button(-text => "B", -command => [\&letter, 'b'])->pack(-side => 'left');
	my $C = $mw->Button(-text => "C", -command => [\&letter, 'c'])->pack(-side => 'left');
	my $D = $mw->Button(-text => "D", -command => [\&letter, 'd'])->pack(-side => 'left');
	my $E = $mw->Button(-text => "E", -command => [\&letter, 'e'])->pack(-side => 'left');
	my $F = $mw->Button(-text => "F", -command => [\&letter, 'f'])->pack(-side => 'left');
	my $G = $mw->Button(-text => "G", -command => [\&letter, 'g'])->pack(-side => 'left');
	my $H = $mw->Button(-text => "H", -command => [\&letter, 'h'])->pack(-side => 'left');
	my $I = $mw->Button(-text => "I", -command => [\&letter, 'i'])->pack(-side => 'left');
	my $J = $mw->Button(-text => "J", -command => [\&letter, 'j'])->pack(-side => 'left');
	my $K = $mw->Button(-text => "K", -command => [\&letter, 'k'])->pack(-side => 'left');
	my $L = $mw->Button(-text => "L", -command => [\&letter, 'l'])->pack(-side => 'left');
	my $M = $mw->Button(-text => "M", -command => [\&letter, 'm'])->pack(-side => 'left');
	my $N = $mw->Button(-text => "N", -command => [\&letter, 'n'])->pack(-side => 'left');
	my $O = $mw->Button(-text => "O", -command => [\&letter, 'o'])->pack(-side => 'left');
	my $P = $mw->Button(-text => "P", -command => [\&letter, 'p'])->pack(-side => 'left');
	my $Q = $mw->Button(-text => "Q", -command => [\&letter, 'q'])->pack(-side => 'left');
	my $R = $mw->Button(-text => "R", -command => [\&letter, 'r'])->pack(-side => 'left');
	my $S = $mw->Button(-text => "S", -command => [\&letter, 's'])->pack(-side => 'left');
	my $T = $mw->Button(-text => "T", -command => [\&letter, 't'])->pack(-side => 'left');
	my $U = $mw->Button(-text => "U", -command => [\&letter, 'u'])->pack(-side => 'left');
	my $V = $mw->Button(-text => "V", -command => [\&letter, 'v'])->pack(-side => 'left');
	my $W = $mw->Button(-text => "W", -command => [\&letter, 'w'])->pack(-side => 'left');
	my $X = $mw->Button(-text => "Y", -command => [\&letter, 'y'])->pack(-side => 'left');
	my $Y = $mw->Button(-text => "X", -command => [\&letter, 'x'])->pack(-side => 'left');
	my $Z = $mw->Button(-text => "Z", -command => [\&letter, 'z'])->pack(-side => 'left');

}


# Letter Button takes a letter as a parameter
sub letter{
	$letter = $_[0];
	&CheckLetter();
	&hangmanDisplay();
}

sub CheckLetter {
	if (&check_guessed($letter, join("", @letters_guessed))){
		$LettersGuessed -> configure(-text => "Letters Guessed: @letters_guessed");
		$GuessList -> configure(-text => "$guess");
		$CounterLabel -> configure(-text => "Count: $count");
	} else {
		push(@letters_guessed, $letter);
		@letters_guessed = sort(@letters_guessed);
		$LettersGuessed -> configure(-text => "Letters Guessed: @letters_guessed");

		for ($i = 0; $i < $word_length; $i++){
			if ($letter eq substr($word, $i, 1)){
				substr($guess, $i, 1, $letter);
				$match = 1;
			} elsif (uc($letter) eq substr($word, $i, 1)) {
				substr($guess, $i, 1, uc($letter));
				$match = 1;
			}
		}

		$GuessList -> configure(-text => "$guess");
		if ($match == 0) {
			$count++;
		}
		$CounterLabel -> configure(-text => "Count: $count");
		$match = 0;
		if ($word eq $guess){
			$win = 1;
		}
	}
}

sub hangmanDisplay{
  if ($count == 0) {
  	# $canvas->createRectangle(30, 80, 100, 150, -fill => "yellow");
  	print "count is $count\n";
	} elsif ($count == 1) {
  	$canvas->createRectangle(100, 30, 200, 50, -fill => "red");
  	print "count is $count\n";
	} elsif ($count == 2) {
  	$canvas->createRectangle(50, 20, 100, 50, -fill => "cyan");
  	print "count is $count\n";
	} elsif ($count == 3) {
	 	$canvas->createRectangle(50, 20, 100, 50, -fill => "cyan");
	  print "count is $count\n";
	} elsif ($count == 4) {
		$canvas->createRectangle(50, 20, 100, 50, -fill => "cyan");
		print "count is $count\n";
	} elsif ($count == 5) {
		$canvas->createRectangle(50, 20, 100, 50, -fill => "cyan");
		print "count is $count\n";
	} elsif ($count == 6) {
	  $canvas->createRectangle(50, 20, 100, 50, -fill => "cyan");
	  print "count is $count\n";
	}
}

# Choose the target word
$word_index = int(rand($size));

$word = &fetch_word($word_index);
chop($word);
chop($word);
$word_length = length($word);
$guess = "_" x $word_length;
if (index($word, "'") != -1){
	substr($guess, index($word, "'"), 1, "'");
}
print($guess, "\n");



sub fetch_word {
	open(DICT, "dictionary.txt") or die "Could not open file: $!";
	my $target = <DICT>;
	my $counter = 0;
	until ($counter == $_[0]){
		$target = <DICT>;
		$counter ++;
	}
	$target;
}

# Check if a letter has already been guessed
sub check_guessed {
	@letters_guessed = split(//, $_[1]);
	my $one = @letters_guessed;
	my $guessed = 0;
	for ($i = 0; $i < $one; $i++) {
		if ($_[0] eq $letters_guessed[$i]) {
			$guessed = 1;
		}
	}
	$guessed;
}

	&GUI();

if ($win == 1){
	print("You win!\n");
	} else {
	&hangmanDisplay();
	print("You lose!\n");
	print("The correct word is: ", $word, "\n");
}


	MainLoop;

	#Hangman
	#
	# Display punctuation in game.  _ _ _ _ ' _ (Fixed)
	# Case Insensitive. A, a should be the same. (Fixed)


	# Ideas for creative project
	#
	# Processing.
	# EG. When it has this letter at the end of the string, it does this etc.
	# Variable number of arguments to a function.
	# Dereferencing
	# Hashing
	# Dynamic Arrays
	# Glue Things together
	# Variable number arguments
	# Text Processing
	# regular expression parsing.
