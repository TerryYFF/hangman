#! /usr/bin/perl

# Please comment out line 50 if you are a Windows user

use Tk;
use strict;
use warnings;

my @dict;
my $length;
my $word_index;
my $word;
my $word_length;
my $guess;
my $guess2;
my $letter;
my $i;
my $count;
my $match;
my $win;
my @letters_guessed;
my $subwin1;
my $Won = 0;
my $Lost = 0;
my $mw;
my $GuessList;
my $LettersGuessed;
my $hangmanDisplay;
my $DisplayHangman;
my $canvas;
my $CounterLabel;
my $MatchLabel;
my $size;

&MainStart();

sub MainStart {

	# Initiate the dictionary
	open(my $fh, '<', 'dictionary.txt') or die "Unable to open file, $!";
	my @dict = <$fh>; # Slurp!
	close($fh) or warn "Unable to close the file handle: $!";
	# Get the size of the dictionary
	$size = @dict;

	# Randomly choose the target word
	$word_index = int(rand($size));
	$word = $dict[$word_index];
	chop($word);
	chop($word);
	$word_length = length($word);

	$guess = "_ " x $word_length;
	$guess2 = " " x $word_length;
	chop($guess);
	# Reveal the position of the apostrophe
	if (index($word, "'") != -1){
		substr($guess, 2*index($word, "'"), 1, "'");
		substr($guess2, index($word, "'"), 1, "'");
	}

	$count = 0;
	$match = 0;
	$win = 0;
	@letters_guessed = ();

	$mw = MainWindow -> new;
	$mw->geometry("1000x450");
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

		# Show buttons A-Z
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
		my $Y = $mw->Button(-text => "X", -command => [\&letter, 'x'])->pack(-side => 'left');
		my $X = $mw->Button(-text => "Y", -command => [\&letter, 'y'])->pack(-side => 'left');
		my $Z = $mw->Button(-text => "Z", -command => [\&letter, 'z'])->pack(-side => 'left');
	}

	# Check if the Key press is a valid letter.
	sub KeyPress {
		my $widget = shift;
		my $e = $widget->XEvent;
		my ($keysym_text) = ($e->K);
		&letter(lc($keysym_text));
	}

	# Letter Button takes a letter as a parameter
	sub letter {
		$letter = $_[0];
		&CheckLetter();
		&hangmanDisplay();
	}

	#Compares the letter guessed with whether it is in the word or not.
	sub CheckLetter {
		# Check if the input letter has already been guessed
		if (&check_guessed($letter, join("", @letters_guessed))){
			$LettersGuessed -> configure(-text => "Letters Guessed: @letters_guessed");
			$GuessList -> configure(-text => "$guess");
			$CounterLabel -> configure(-text => "Count: $count");
		} else {
			# Add the input letter into the list of guessed letters
			push(@letters_guessed, $letter);
			@letters_guessed = sort(@letters_guessed);
			$LettersGuessed -> configure(-text => "Letters Guessed: @letters_guessed");

			# Reveal the letter being guessed
			for ($i = 0; $i < $word_length; $i++){
				if ($letter eq substr($word, $i, 1)){
					substr($guess, 2*$i, 1, $letter);
					substr($guess2, $i, 1, $letter);
					$match = 1;
				} elsif (uc($letter) eq substr($word, $i, 1)) {
					substr($guess, 2*$i, 1, uc($letter));
					substr($guess2, $i, 1, $letter);
					$match = 1;
				}
			}

			$GuessList -> configure(-text => "$guess");

			# Update the number of guess chances left
			if ($match == 0) {
				$count++;
			}
			$CounterLabel -> configure(-text => "Count: $count");
			$match = 0;

			# Check if the player wins the game
			if ($word eq $guess2){
				$win = 1;
				&Winner();
			}
		}
	}

	# Depending on the count, a body part will show for Hangman.
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
			$subwin1->geometry("250x130");
			$subwin1 ->Label(-text => "Oops.")->pack();
			$subwin1 ->Label(-text => "Hangman is now Hung.")->pack();
			$subwin1 ->Label(-text => "The correct word is $word.")->pack();
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

	# Draw the face of the hangman
	sub Face {
		$canvas->createOval(170, 40, 220, 90, -fill => "black");
		$canvas->createOval(175, 45, 215, 85, -fill => "white");
		$canvas->createLine(184, 55, 191, 65, -width => 2, -fill => "black");
		$canvas->createLine(191, 55, 184, 65, -width => 2, -fill => "black");
		$canvas->createLine(198, 55, 205, 65, -width => 2, -fill => "black");
		$canvas->createLine(205, 55, 198, 65, -width => 2, -fill => "black");
		$canvas->createRectangle(184, 74, 205, 75, -fill => "black");
	}

	# Draw the body of the hangman
	sub Body {
		$canvas->createRectangle(190, 90, 200, 170, -fill => "black");
		$canvas->createRectangle(190, 90, 200, 100, -fill => "brown");
	}

	# Draw the right leg of the hangman
	sub RightLeg {
		$canvas->createLine(195, 169, 230, 220, -width => 10, -fill => "black");
	}

	# Draw the left leg of the hangman
	sub LeftLeg {
		$canvas->createLine(195, 169, 160, 220, -width => 10, -fill => "black");
	}

	# Draw the right arm of the hangman
	sub RightArm {
		$canvas->createLine(195, 103, 225, 150, -width => 10, -fill => "black");
	}

	# Draw the left arm of the hangman
	sub LeftArm {
		$canvas->createLine(195, 103, 165, 150, -width => 10, -fill => "black");
	}

}

MainLoop;
