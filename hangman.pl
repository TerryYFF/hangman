use Tk;
use strict;
use warnings;


######################
##############################
# Check line 303.
################
##########################
##########################
###################

my @dict;
my $length;
my $word_index;
my $word;
my $word_length;
my $guess;
my $letter;
my $i;
my $count;
my $match;
my $win;
my @letters_guessed;
my $subwin1;
my $Won = 0;
my $Lost = 0;


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



#! /usr/bin/perl
# Initiate the dictionary
# my $size = `wc -l dictionary.txt`;
my $size = 10000;
# $size =~ s/\D//g;

&MainStart();

sub MainStart {

	$count = 0;
	$match = 0;
	$win = 0;
	@letters_guessed = ();

	$mw = MainWindow -> new;
	$mw->geometry("420x450");
	$mw->title("Hangman");
	$mw -> Label(-text => "The size of the file is $size")->pack();

	$canvas = $mw->Canvas(-relief => "sunken", -background => "lightblue");
	$canvas->pack();
	$canvas->createRectangle(10, 10, 20, 260, -fill => "black");
	$canvas->createRectangle(10, 20, 200, 10, -fill => "black");
	$canvas->createLine(100, 15, 15, 100, -width => 10, -fill => "brown");
	$canvas->createRectangle(190, 40, 200, 20, -fill => "brown");
	$canvas->createRectangle(10, 240, 370, 260, -fill => "brown");

sub GUI {
	$LettersGuessed = $mw->Label(-text => "Letters Guessed: @letters_guessed")->pack();
	$GuessList = $mw->Label(-text => "$guess")->pack();
	$CounterLabel = $mw->Label(-text => "Count: $count")->pack();
	$mw->Label(-text => "You can Type or Press the letters.")->pack();

	$mw->bind('<KeyPress>' => \&KeyPress);

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

# Check if the Key press is a valid letter.
sub KeyPress {

	my $widget = shift;

  my $e = $widget->XEvent;
  my ($keysym_text) = ($e->K);

	if ($keysym_text eq 'a' || $keysym_text eq 'A') {
		&letter('a');
	} elsif ($keysym_text eq 'b' || $keysym_text eq 'B') {
		&letter('b');
	} elsif ($keysym_text eq 'c' || $keysym_text eq 'C') {
		&letter('c');
	} elsif ($keysym_text eq 'd' || $keysym_text eq 'D') {
		&letter('d');
	} elsif ($keysym_text eq 'e' || $keysym_text eq 'E') {
		&letter('e');
	} elsif ($keysym_text eq 'f' || $keysym_text eq 'F') {
		&letter('f');
	} elsif ($keysym_text eq 'g' || $keysym_text eq 'G') {
		&letter('g');
	} elsif ($keysym_text eq 'h' || $keysym_text eq 'H') {
		&letter('h');
	} elsif ($keysym_text eq 'i' || $keysym_text eq 'I') {
		&letter('i');
	} elsif ($keysym_text eq 'j' || $keysym_text eq 'J') {
		&letter('j');
	} elsif ($keysym_text eq 'k' || $keysym_text eq 'K') {
		&letter('k');
	} elsif ($keysym_text eq 'l' || $keysym_text eq 'L') {
		&letter('l');
	} elsif ($keysym_text eq 'm' || $keysym_text eq 'M') {
		&letter('m');
	} elsif ($keysym_text eq 'n' || $keysym_text eq 'N') {
		&letter('n');
	} elsif ($keysym_text eq 'o' || $keysym_text eq 'O') {
		&letter('o');
	} elsif ($keysym_text eq 'p' || $keysym_text eq 'P') {
		&letter('p');
	} elsif ($keysym_text eq 'q' || $keysym_text eq 'Q') {
		&letter('q');
	} elsif ($keysym_text eq 'r' || $keysym_text eq 'R') {
		&letter('r');
	} elsif ($keysym_text eq 's' || $keysym_text eq 'S') {
		&letter('s');
	} elsif ($keysym_text eq 't' || $keysym_text eq 'T') {
		&letter('t');
	} elsif ($keysym_text eq 'u' || $keysym_text eq 'U') {
		&letter('u');
	} elsif ($keysym_text eq 'v' || $keysym_text eq 'V') {
		&letter('v');
	} elsif ($keysym_text eq 'w' || $keysym_text eq 'W') {
		&letter('w');
	} elsif ($keysym_text eq 'x' || $keysym_text eq 'X') {
		&letter('x');
	} elsif ($keysym_text eq 'y' || $keysym_text eq 'Y') {
		&letter('y');
	} elsif ($keysym_text eq 'z' || $keysym_text eq 'Z') {
		&letter('z');
	}
}

# Letter Button takes a letter as a parameter
sub letter {
	$letter = $_[0];
	&CheckLetter();
	&hangmanDisplay();
}

#Compares the letter guessed with whether it is in the word or not.
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
			&Winner();
		}
	}
}

# Depending on the count, a body part will show for Hangman.
# https://docstore.mik.ua/orelly/perl3/tk/ch02_01.htm
# Geometry Pack Guide.
sub hangmanDisplay {
	if ($count == 1) {
		&Face();
	} elsif ($count == 2) {
		&Body();
	} elsif ($count == 3) {
		&RightArm();
	} elsif ($count == 4) {
		&LeftArm();
	} elsif ($count == 5) {
		&RightLeg();
	} elsif ($count == 6) {
		&LeftLeg();
			$count = 0;
			$Lost = $Lost + 1;
			$subwin1 = $mw->Toplevel;
			$subwin1->title("Loser!!!");
			$subwin1->geometry("250x110");
			$subwin1 ->Label(-text => "Oops.")->pack();
			$subwin1 ->Label(-text => "Hangman is now Hung.")->pack();
			$subwin1 ->Label(-text => "Would you like to try again?")->pack();
			my $button1 = $subwin1->Button(-text => "Yes", -command => \&Restart)->pack();
			$subwin1->Button(-text => "No", -command => \&Exit)->pack();
	}
}


#Window that shows when the player wins.
sub Winner {
		$Won = $Won + 1;
		$subwin1 = $mw->Toplevel;
		$subwin1->title("Winner!!!");
		$subwin1->geometry("250x110");
		$subwin1 ->Label(-text => "You saved Hangman from certain death!")->pack();
		$subwin1 ->Label(-text => "Would you like to save him again?")->pack();
		my $button1 = $subwin1->Button(-text => "Yes", -command => \&Restart)->pack();
		$subwin1->Button(-text => "No", -command => \&Exit)->pack();
}

# Restart the game.
sub Restart {
	$mw -> destroy;
	&MainStart();
}


# Exit the game.
sub Exit {
	$subwin1 = $mw->Toplevel;
	$subwin1->title("Summary");
	$subwin1->geometry("250x110");
	$subwin1 ->Label(-text => "You saved Hangman $Won times!" )->pack();
	$subwin1 ->Label(-text =>  "You also killed Hangman $Lost times!" )->pack();
	$subwin1 ->Label(-text => "See You Next Time!" )->pack();
	my $button1 = $subwin1->Button(-text => "Close", -command => \&Close)->pack();

	sub Close {
		$mw -> destroy;
	}
}


# Choose the target word
$word_index = int(rand($size));

$word = &fetch_word($word_index);
chop($word);
$word_length = length($word);
$guess = "_" x $word_length;
if (index($word, "'") != -1){
	substr($guess, index($word, "'"), 1, "'");
}

print $word;
print "\n";


######################
##############################
# Do we still need this?
####################
##########################
##########################
###################
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

sub Face {
	$canvas->createOval(170, 40, 220, 90, -fill => "black");
	$canvas->createOval(175, 45, 215, 85, -fill => "white");
	$canvas->createLine(184, 55, 191, 65, -width => 2, -fill => "black");
	$canvas->createLine(191, 55, 184, 65, -width => 2, -fill => "black");
	$canvas->createLine(198, 55, 205, 65, -width => 2, -fill => "black");
	$canvas->createLine(205, 55, 198, 65, -width => 2, -fill => "black");
	$canvas->createRectangle(184, 74, 205, 75, -fill => "black");
}

sub Body {
	$canvas->createRectangle(190, 90, 200, 170, -fill => "black");
	$canvas->createRectangle(190, 90, 200, 100, -fill => "brown");
}

sub RightLeg {
	$canvas->createLine(195, 169, 230, 220, -width => 10, -fill => "black");
}

sub LeftLeg {
	$canvas->createLine(195, 169, 160, 220, -width => 10, -fill => "black");
}

sub RightArm {
	$canvas->createLine(195, 103, 225, 150, -width => 10, -fill => "black");
}

sub LeftArm {
	$canvas->createLine(195, 103, 165, 150, -width => 10, -fill => "black");
}

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
